# StatsHub Database - Guía de Instalación

El procedimiento oficial está en el [README](README.md) de este repositorio. Resumen:

## Requisitos

- PostgreSQL 17
- Node.js 20.11 o superior

## Desarrollo local

```bash
createdb -U postgres statshub_deportivo
cp .env.example .env          # completar DB_PASSWORD
npm install
npm run migrate:up            # crea el esquema completo desde migrations/
npm run seed                  # roles, usuarios de prueba (sin acceso) y categorías
npm run seed -- --demo        # opcional: equipos, torneos y partidos de ejemplo (solo base recién creada)
```

El administrador se crea desde el backend (`npm run create-admin` en StatsHub-Backend), nunca desde un seed.

## Base creada con los scripts antiguos

Si la base se creó antes con `install.sql` o la carpeta `schemas/` (ya eliminados), marcar la línea
base como aplicada y luego aplicar las migraciones nuevas:

```bash
npm run migrate:baseline
npm run migrate:up
```

## Cambios de esquema

Nunca editar una migración ya aplicada: crear una nueva con `npm run migrate:create -- nombre` y
completar sus secciones `-- Up Migration` y `-- Down Migration`.

## Producción

Ver `StatsHub-Backend/DEPLOY.md` (RDS PostgreSQL, usuario de aplicación con permisos mínimos y respaldos).

## Flujo de ramas

`main` (producción) ← `develop` (integración) ← `feature/<nombre>` (trabajo de cada integrante).
