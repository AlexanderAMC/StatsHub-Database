// Carga los datos iniciales en orden.
//   npm run seed                  roles, usuarios de prueba y categorías (re-ejecutable)
//   npm run seed -- --demo        además, datos de prueba (solo en una BD recién creada)
require('dotenv').config({ quiet: true });
const fs = require('node:fs');
const path = require('node:path');
const { Client } = require('pg');

const BASE_SEEDS = ['01_roles.sql', '02_usuarios.sql', '03_categorias.sql'];
const DEMO_SEEDS = ['04_datos_prueba.sql'];

async function main() {
  const withDemo = process.argv.includes('--demo');
  const files = withDemo ? [...BASE_SEEDS, ...DEMO_SEEDS] : BASE_SEEDS;

  const client = new Client(
    process.env.DATABASE_URL
      ? { connectionString: process.env.DATABASE_URL }
      : {
          host: process.env.DB_HOST,
          port: process.env.DB_PORT,
          database: process.env.DB_NAME,
          user: process.env.DB_USER,
          password: process.env.DB_PASSWORD,
        }
  );
  await client.connect();

  try {
    for (const file of files) {
      const sql = fs.readFileSync(path.join(__dirname, '..', 'seeds', file), 'utf8');
      await client.query('BEGIN');
      try {
        await client.query(sql);
        await client.query('COMMIT');
        console.log(`✅ ${file}`);
      } catch (error) {
        await client.query('ROLLBACK');
        throw new Error(`${file}: ${error.message}`);
      }
    }
  } finally {
    await client.end();
  }
}

main().catch((error) => {
  console.error(`❌ ${error.message}`);
  process.exitCode = 1;
});
