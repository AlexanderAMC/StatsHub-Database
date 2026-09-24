# StatsHub Database - Guía de Instalación

## Descripción

Este repositorio contiene la estructura, scripts y documentación de la base de datos del proyecto StatsHub.

---

# Requisitos Previos

## PostgreSQL

Versión oficial del proyecto:

```text
17.11
```

Verificar instalación:

```bash
psql --version
```

Resultado esperado:

```text
psql (PostgreSQL) 17.11
```

---

## pgAdmin 4

Instalar junto con PostgreSQL.

Permite administrar gráficamente la base de datos.

---

## Git

Verificar instalación:

```bash
git --version
```

---

# Clonar el Repositorio

```bash
git clone https://github.com/TU_ORGANIZACION/StatsHub-Database.git
```

Ingresar al proyecto:

```bash
cd StatsHub-Database
```

---

# Crear Base de Datos

Conectarse a PostgreSQL:

```bash
psql -U postgres
```

Crear la base de datos:

```sql
CREATE DATABASE statshub_deportivo;
```

Verificar:

```sql
\l
```

Conectarse:

```sql
\c statshub_deportivo
```

Salir:

```sql
\q
```

---

# Estructura del Repositorio

```text
StatsHub-Database
│
├── scripts
│   ├── schema.sql
│   ├── seed.sql
│   ├── procedures.sql
│   ├── functions.sql
│   └── views.sql
│
├── backups
│
├── docs
│
├── README.md
├── INSTALACION.md
├── VERSIONES.md
└── .env.example
```

---

# Ejecutar Scripts

Crear tablas:

```bash
psql -U postgres -d statshub_deportivo -f scripts/schema.sql
```

Insertar datos iniciales:

```bash
psql -U postgres -d statshub_deportivo -f scripts/seed.sql
```

Procedimientos almacenados:

```bash
psql -U postgres -d statshub_deportivo -f scripts/procedures.sql
```

Funciones:

```bash
psql -U postgres -d statshub_deportivo -f scripts/functions.sql
```

Vistas:

```bash
psql -U postgres -d statshub_deportivo -f scripts/views.sql
```

---

# Respaldos de Base de Datos

Crear respaldo:

```bash
pg_dump -U postgres statshub_deportivo > backups/backup.sql
```

Restaurar respaldo:

```bash
psql -U postgres -d statshub_deportivo < backups/backup.sql
```

---

# Variables de Entorno

Archivo:

```text
.env
```

Contenido:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=statshub_deportivo
DB_USER=postgres
DB_PASSWORD=TU_PASSWORD
```

---

# Archivo .env.example

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=statshub_deportivo
DB_USER=postgres
DB_PASSWORD=CAMBIAR_PASSWORD
```

---

# Convención de Nombres

## Tablas

```text
usuarios
equipos
jugadores
partidos
estadisticas
```

## Claves Primarias

```text
id
```

## Claves Foráneas

```text
usuario_id
equipo_id
jugador_id
partido_id
```

---

# Actualización de Scripts

Después de obtener cambios del repositorio:

```bash
git pull origin develop
```

Ejecutar nuevamente los scripts que correspondan.

---

# Estructura de Ramas

No realizar commits en:

```text
main
```

No realizar commits en:

```text
develop
```

Cada integrante trabajará en su rama:

```text
feature-AlexanderMendez
feature-DanielPincheira
feature-NombreIntegrante
```

---

# Reglas del Proyecto

No modificar scripts desarrollados por otros integrantes sin coordinación previa.

Todo cambio estructural debe documentarse mediante Pull Request.

Toda modificación de tablas debe quedar registrada en el repositorio.

No compartir contraseñas reales en GitHub.

Nunca subir:

```text
.env
```

Solo se debe subir:

```text
.env.example
```

---

# Instalación Inicial para Nuevos Integrantes

Clonar repositorio:

```bash
git clone URL_DEL_REPOSITORIO
```

Ingresar:

```bash
cd StatsHub-Database
```

Crear base de datos:

```sql
CREATE DATABASE statshub_deportivo;
```

Ejecutar scripts:

```bash
psql -U postgres -d statshub_deportivo -f scripts/schema.sql
```

```bash
psql -U postgres -d statshub_deportivo -f scripts/seed.sql
```

Verificar tablas:

```sql
\dt
```

---

# Versiones Oficiales

| Herramienta | Versión |
|-------------|----------|
| PostgreSQL | 17.11 |
| pgAdmin | 4 |
| Puerto PostgreSQL | 5432 |
| Git | Última estable |

---

# Soporte

Si PostgreSQL no es reconocido:

Verificar:

```bash
psql --version
```

Si aparece error, agregar al PATH:

```text
C:\Program Files\PostgreSQL\17\bin
```

Reiniciar la terminal y volver a ejecutar:

```bash
psql --version
```