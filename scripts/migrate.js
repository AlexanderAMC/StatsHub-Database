// Ejecuta node-pg-migrate usando las mismas variables DB_* que el backend.
// Uso:
//   npm run migrate:up          aplica las migraciones pendientes
//   npm run migrate:down        revierte la última migración
//   npm run migrate:baseline    marca la línea base como aplicada (BD creada antes con schemas/)
//   npm run migrate:create -- nombre-de-la-migracion
require('dotenv').config({ quiet: true });
const path = require('node:path');
const { spawnSync } = require('node:child_process');

function buildDatabaseUrl() {
  if (process.env.DATABASE_URL) return process.env.DATABASE_URL;

  const { DB_HOST = 'localhost', DB_PORT = '5432', DB_NAME, DB_USER, DB_PASSWORD = '' } = process.env;
  if (!DB_NAME || !DB_USER) {
    console.error('❌ Define DB_NAME y DB_USER (o DATABASE_URL) en StatsHub-Database/.env. Ver .env.example.');
    process.exit(1);
  }
  const enc = encodeURIComponent;
  return `postgres://${enc(DB_USER)}:${enc(DB_PASSWORD)}@${DB_HOST}:${DB_PORT}/${enc(DB_NAME)}`;
}

const bin = path.join(__dirname, '..', 'node_modules', 'node-pg-migrate', 'bin', 'node-pg-migrate.js');
const baseArgs = [
  '--migrations-dir', path.join(__dirname, '..', 'migrations'),
  '--migration-file-language', 'sql',
  '--migrations-table', 'schema_migrations',
  '--migrations-schema', 'public',
];

const result = spawnSync(process.execPath, [bin, ...process.argv.slice(2), ...baseArgs], {
  stdio: 'inherit',
  env: { ...process.env, DATABASE_URL: buildDatabaseUrl() },
});

process.exit(result.status ?? 1);
