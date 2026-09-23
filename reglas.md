# StatsHub Database

Repositorio oficial de la capa de datos de StatsHub Deportivo.

---

# Tecnologías

- PostgreSQL
- SQL
- Data Warehouse
- Star Schema

---

# Requisitos

- PostgreSQL 17+
- pgAdmin 4
- DBeaver (Opcional)
- Git

---

# Instalación

Clonar repositorio:

```bash
git clone https://github.com/AlexanderAMC/StatsHub-Database.git
```

Entrar:

```bash
cd StatsHub-Database
```

---

# Estructura

```txt
docs/
diagrams/
migrations/
seeds/
sql/
warehouse/
```

---

# Creación Base de Datos

Ejecutar en orden:

```txt
001_create_database.sql

002_create_tables.sql

003_constraints.sql

004_indexes.sql

005_views.sql
```

---

# Validación

Verificar:

```sql
SELECT * FROM usuarios;

SELECT * FROM equipos;

SELECT * FROM torneos;

SELECT * FROM partidos;
```

---

# Estructura de ramas

```txt
main
develop

feature/AlexanderMendez
feature/DanielBalcarce
feature/JuanVillagran
feature/DanielPincheira
```

---

# Flujo de Trabajo

Actualizar develop:

```bash
git checkout develop

git pull origin develop
```

Cambiar a rama personal:

```bash
git checkout feature/TuNombre
```

Actualizar rama:

```bash
git merge develop
```

Subir cambios:

```bash
git add .

git commit -m "feat: descripción"

git push
```

---

# Pull Request

Todos los Pull Request deben apuntar a:

```txt
develop
```

Debe incluir:

- Scripts afectados
- Tablas modificadas
- Evidencia SQL
- Impacto esperado

Checklist:

- [ ] Script ejecuta sin errores
- [ ] Relaciones verificadas
- [ ] Índices revisados
- [ ] Documentación actualizada

---

# Convención SQL

```txt
001_create_database.sql

002_create_tables.sql

003_constraints.sql

004_indexes.sql

005_views.sql

006_seed_roles.sql

007_seed_users.sql
```

---

# Convención de Commits

```txt
feat:
fix:
docs:
refactor:
```

Ejemplo:

```txt
feat: tabla jugadores
```

---

# Prohibido

❌ Modificar main

❌ Modificar develop

❌ Eliminar tablas sin consenso

❌ Reescribir scripts históricos

❌ Eliminar diagramas

---

# Objetivo

Gestionar la estructura de datos, migraciones, scripts SQL y modelo analítico de StatsHub Deportivo.