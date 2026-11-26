// Tests de integración del esquema contra un PostgreSQL real y DESECHABLE.
// Requiere TEST_DATABASE_URL; el nombre de la base debe contener "test" (protección contra
// borrar una base real). Sin la variable, los tests se omiten.
const { test, before, after } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { Client } = require('pg');

const url = process.env.TEST_DATABASE_URL;
const dbName = url ? new URL(url).pathname.slice(1) : '';
const skip = !url
  ? 'TEST_DATABASE_URL no definida'
  : !/test/i.test(dbName)
    ? `la base "${dbName}" no parece de pruebas (su nombre debe contener "test")`
    : false;

const ROOT = path.resolve(__dirname, '..');
let client;

function run(script, args = []) {
  const result = spawnSync(process.execPath, [path.join(ROOT, 'scripts', script), ...args], {
    cwd: ROOT,
    env: { ...process.env, DATABASE_URL: url },
    encoding: 'utf8',
    timeout: 600000, // margen amplio para equipos lentos
  });
  assert.equal(result.status, 0, `${script} ${args.join(' ')} falló:\n${result.stdout}\n${result.stderr}`);
  return result.stdout;
}

async function resetDatabase() {
  await client.query(`
    DROP SCHEMA IF EXISTS analytics, auditoria, pagos, deportivo, seguridad CASCADE;
    DROP TABLE IF EXISTS public.schema_migrations;
  `);
}

async function expectPgError(sql, params, code) {
  await assert.rejects(client.query(sql, params), (error) => {
    assert.equal(error.code, code, error.message);
    return true;
  });
}

before(async () => {
  if (skip) return;
  client = new Client({ connectionString: url });
  await client.connect();
  await resetDatabase();
});

after(async () => {
  if (client) await client.end();
});

test('las migraciones crean el esquema completo desde cero', { skip }, async () => {
  run('migrate.js', ['up']);
  const { rows } = await client.query('SELECT name FROM public.schema_migrations ORDER BY id');
  assert.ok(rows.length >= 2);
  assert.equal(rows[0].name, '1763450000000_linea-base');
});

test('los seeds cargan y los básicos se pueden re-ejecutar sin duplicar', { skip }, async () => {
  run('seed.js', ['--demo']);
  run('seed.js');
  const { rows } = await client.query(`
    SELECT (SELECT COUNT(*) FROM seguridad.roles)::int AS roles,
           (SELECT COUNT(*) FROM deportivo.categorias)::int AS categorias,
           (SELECT COUNT(*) FROM deportivo.jugadores)::int AS jugadores,
           (SELECT COUNT(*) FROM deportivo.eventos_partido)::int AS eventos`);
  assert.deepEqual(rows[0], { roles: 7, categorias: 4, jugadores: 3, eventos: 4 });
});

test('el seed no crea ningún usuario con contraseña utilizable', { skip }, async () => {
  const { rows } = await client.query(`SELECT COUNT(*)::int AS n FROM seguridad.usuarios WHERE password_hash LIKE '$2%'`);
  assert.equal(rows[0].n, 0);
});

test('borrar la cuenta de un jugador conserva el jugador (ON DELETE SET NULL)', { skip }, async () => {
  const { rows } = await client.query(`
    DELETE FROM seguridad.usuarios WHERE correo = 'jugador1@statshub.cl' RETURNING id`);
  assert.equal(rows.length, 1);
  const jugador = await client.query(`SELECT usuario_id FROM deportivo.jugadores WHERE rut = '11111111-1'`);
  assert.equal(jugador.rows[0].usuario_id, null);
});

test('no se puede borrar un torneo con partidos (RESTRICT)', { skip }, async () => {
  await expectPgError('DELETE FROM deportivo.torneos WHERE id = 1', [], '23503');
});

test('las categorías no se pueden duplicar', { skip }, async () => {
  await expectPgError(`INSERT INTO deportivo.categorias (nombre) VALUES ('Adulto')`, [], '23505');
});

test('se rechazan minutos y goles fuera de rango', { skip }, async () => {
  await expectPgError(
    `INSERT INTO deportivo.eventos_partido (partido_id, tipo_evento, minuto) VALUES (1, 'GOL', 200)`, [], '23514');
  await expectPgError(`UPDATE deportivo.resultados SET goles_local = -1 WHERE partido_id = 1`, [], '23514');
});

test('básquetbol: deporte por torneo, cuartos y eventos propios', { skip }, async () => {
  const { rows } = await client.query(`SELECT deporte FROM deportivo.torneos ORDER BY id`);
  assert.deepEqual(rows.map((r) => r.deporte), ['FUTBOL', 'BASQUETBOL']);
  const nuevo = await client.query(
    `INSERT INTO deportivo.torneos (nombre, categoria_id, fecha_inicio, estado) VALUES ('Liga de Básquet', 1, '2027-04-01', 'PLANIFICADO') RETURNING deporte`);
  assert.equal(nuevo.rows[0].deporte, 'BASQUETBOL', 'los torneos nuevos parten como básquetbol');
  await expectPgError(`UPDATE deportivo.torneos SET deporte = 'TENIS' WHERE id = 1`, [], '23514');
  await client.query(`INSERT INTO deportivo.eventos_partido (partido_id, tipo_evento, minuto, periodo) VALUES (1, 'PUNTO_3', 8, 2)`);
  await expectPgError(`INSERT INTO deportivo.eventos_partido (partido_id, tipo_evento, minuto, periodo) VALUES (1, 'PUNTO_3', 8, 11)`, [], '23514');
  await expectPgError(`INSERT INTO deportivo.eventos_partido (partido_id, tipo_evento, minuto) VALUES (1, 'CANASTA', 8)`, [], '23514');
});

test('las migraciones se pueden revertir y volver a aplicar', { skip }, async () => {
  const { rows } = await client.query('SELECT COUNT(*)::int AS n FROM public.schema_migrations');
  run('migrate.js', ['down', String(rows[0].n)]);
  const schemas = await client.query(`SELECT COUNT(*)::int AS n FROM pg_namespace WHERE nspname = 'deportivo'`);
  assert.equal(schemas.rows[0].n, 0);
  run('migrate.js', ['up']);
});
