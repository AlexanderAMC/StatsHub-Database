--
-- PostgreSQL database dump
--

\restrict D9DnqEhcv1Nqg2Q3sZzNFIZk0M1ZdBoymPvNlLe2mjIVDSrgtnlhU9dLnoRbty1

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: analytics; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA analytics;


ALTER SCHEMA analytics OWNER TO postgres;

--
-- Name: auditoria; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA auditoria;


ALTER SCHEMA auditoria OWNER TO postgres;

--
-- Name: deportivo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA deportivo;


ALTER SCHEMA deportivo OWNER TO postgres;

--
-- Name: pagos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pagos;


ALTER SCHEMA pagos OWNER TO postgres;

--
-- Name: seguridad; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA seguridad;


ALTER SCHEMA seguridad OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dim_equipo; Type: TABLE; Schema: analytics; Owner: postgres
--

CREATE TABLE analytics.dim_equipo (
    id integer NOT NULL,
    equipo_id integer NOT NULL,
    nombre character varying(150) NOT NULL
);


ALTER TABLE analytics.dim_equipo OWNER TO postgres;

--
-- Name: dim_equipo_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.dim_equipo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.dim_equipo_id_seq OWNER TO postgres;

--
-- Name: dim_equipo_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.dim_equipo_id_seq OWNED BY analytics.dim_equipo.id;


--
-- Name: dim_jugador; Type: TABLE; Schema: analytics; Owner: postgres
--

CREATE TABLE analytics.dim_jugador (
    id integer NOT NULL,
    jugador_id integer NOT NULL,
    nombre_completo character varying(200),
    posicion character varying(50)
);


ALTER TABLE analytics.dim_jugador OWNER TO postgres;

--
-- Name: dim_jugador_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.dim_jugador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.dim_jugador_id_seq OWNER TO postgres;

--
-- Name: dim_jugador_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.dim_jugador_id_seq OWNED BY analytics.dim_jugador.id;


--
-- Name: dim_tiempo; Type: TABLE; Schema: analytics; Owner: postgres
--

CREATE TABLE analytics.dim_tiempo (
    id integer NOT NULL,
    fecha date NOT NULL,
    anio integer NOT NULL,
    trimestre integer NOT NULL,
    mes integer NOT NULL,
    nombre_mes character varying(20) NOT NULL,
    semana integer NOT NULL,
    dia integer NOT NULL,
    dia_semana integer NOT NULL,
    nombre_dia character varying(20) NOT NULL
);


ALTER TABLE analytics.dim_tiempo OWNER TO postgres;

--
-- Name: dim_tiempo_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.dim_tiempo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.dim_tiempo_id_seq OWNER TO postgres;

--
-- Name: dim_tiempo_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.dim_tiempo_id_seq OWNED BY analytics.dim_tiempo.id;


--
-- Name: dim_torneo; Type: TABLE; Schema: analytics; Owner: postgres
--

CREATE TABLE analytics.dim_torneo (
    id integer NOT NULL,
    torneo_id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    categoria character varying(100)
);


ALTER TABLE analytics.dim_torneo OWNER TO postgres;

--
-- Name: dim_torneo_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.dim_torneo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.dim_torneo_id_seq OWNER TO postgres;

--
-- Name: dim_torneo_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.dim_torneo_id_seq OWNED BY analytics.dim_torneo.id;


--
-- Name: fact_estadisticas_jugador; Type: TABLE; Schema: analytics; Owner: postgres
--

CREATE TABLE analytics.fact_estadisticas_jugador (
    id bigint NOT NULL,
    tiempo_id integer NOT NULL,
    jugador_id integer NOT NULL,
    partidos integer DEFAULT 0,
    goles integer DEFAULT 0,
    asistencias integer DEFAULT 0,
    amarillas integer DEFAULT 0,
    rojas integer DEFAULT 0
);


ALTER TABLE analytics.fact_estadisticas_jugador OWNER TO postgres;

--
-- Name: fact_estadisticas_jugador_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.fact_estadisticas_jugador_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.fact_estadisticas_jugador_id_seq OWNER TO postgres;

--
-- Name: fact_estadisticas_jugador_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.fact_estadisticas_jugador_id_seq OWNED BY analytics.fact_estadisticas_jugador.id;


--
-- Name: fact_partidos; Type: TABLE; Schema: analytics; Owner: postgres
--

CREATE TABLE analytics.fact_partidos (
    id bigint NOT NULL,
    tiempo_id integer NOT NULL,
    torneo_id integer NOT NULL,
    equipo_local_id integer NOT NULL,
    equipo_visita_id integer NOT NULL,
    goles_local integer DEFAULT 0,
    goles_visita integer DEFAULT 0
);


ALTER TABLE analytics.fact_partidos OWNER TO postgres;

--
-- Name: fact_partidos_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.fact_partidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.fact_partidos_id_seq OWNER TO postgres;

--
-- Name: fact_partidos_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.fact_partidos_id_seq OWNED BY analytics.fact_partidos.id;


--
-- Name: logs; Type: TABLE; Schema: auditoria; Owner: postgres
--

CREATE TABLE auditoria.logs (
    id bigint NOT NULL,
    usuario_id uuid,
    accion character varying(200),
    tabla_afectada character varying(100),
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE auditoria.logs OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: auditoria; Owner: postgres
--

CREATE SEQUENCE auditoria.logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auditoria.logs_id_seq OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: auditoria; Owner: postgres
--

ALTER SEQUENCE auditoria.logs_id_seq OWNED BY auditoria.logs.id;


--
-- Name: categorias; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.categorias (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE deportivo.categorias OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: deportivo; Owner: postgres
--

CREATE SEQUENCE deportivo.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE deportivo.categorias_id_seq OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: deportivo; Owner: postgres
--

ALTER SEQUENCE deportivo.categorias_id_seq OWNED BY deportivo.categorias.id;


--
-- Name: equipo_jugador; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.equipo_jugador (
    id integer NOT NULL,
    equipo_id integer NOT NULL,
    jugador_id integer NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date,
    activo boolean DEFAULT true
);


ALTER TABLE deportivo.equipo_jugador OWNER TO postgres;

--
-- Name: equipo_jugador_id_seq; Type: SEQUENCE; Schema: deportivo; Owner: postgres
--

CREATE SEQUENCE deportivo.equipo_jugador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE deportivo.equipo_jugador_id_seq OWNER TO postgres;

--
-- Name: equipo_jugador_id_seq; Type: SEQUENCE OWNED BY; Schema: deportivo; Owner: postgres
--

ALTER SEQUENCE deportivo.equipo_jugador_id_seq OWNED BY deportivo.equipo_jugador.id;


--
-- Name: equipos; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.equipos (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    escudo_url text,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE deportivo.equipos OWNER TO postgres;

--
-- Name: equipos_id_seq; Type: SEQUENCE; Schema: deportivo; Owner: postgres
--

CREATE SEQUENCE deportivo.equipos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE deportivo.equipos_id_seq OWNER TO postgres;

--
-- Name: equipos_id_seq; Type: SEQUENCE OWNED BY; Schema: deportivo; Owner: postgres
--

ALTER SEQUENCE deportivo.equipos_id_seq OWNED BY deportivo.equipos.id;


--
-- Name: estadisticas_jugador; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.estadisticas_jugador (
    jugador_id integer NOT NULL,
    partidos integer DEFAULT 0,
    goles integer DEFAULT 0,
    asistencias integer DEFAULT 0,
    amarillas integer DEFAULT 0,
    rojas integer DEFAULT 0
);


ALTER TABLE deportivo.estadisticas_jugador OWNER TO postgres;

--
-- Name: eventos_partido; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.eventos_partido (
    id integer NOT NULL,
    partido_id integer NOT NULL,
    jugador_id integer,
    tipo_evento character varying(50) NOT NULL,
    minuto integer NOT NULL,
    descripcion text,
    CONSTRAINT eventos_partido_tipo_evento_check CHECK (((tipo_evento)::text = ANY ((ARRAY['GOL'::character varying, 'ASISTENCIA'::character varying, 'AMARILLA'::character varying, 'ROJA'::character varying, 'LESION'::character varying, 'SUSTITUCION'::character varying])::text[])))
);


ALTER TABLE deportivo.eventos_partido OWNER TO postgres;

--
-- Name: eventos_partido_id_seq; Type: SEQUENCE; Schema: deportivo; Owner: postgres
--

CREATE SEQUENCE deportivo.eventos_partido_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE deportivo.eventos_partido_id_seq OWNER TO postgres;

--
-- Name: eventos_partido_id_seq; Type: SEQUENCE OWNED BY; Schema: deportivo; Owner: postgres
--

ALTER SEQUENCE deportivo.eventos_partido_id_seq OWNED BY deportivo.eventos_partido.id;


--
-- Name: jugadores; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.jugadores (
    id integer NOT NULL,
    usuario_id uuid,
    rut character varying(20),
    fecha_nacimiento date,
    posicion character varying(50)
);


ALTER TABLE deportivo.jugadores OWNER TO postgres;

--
-- Name: jugadores_id_seq; Type: SEQUENCE; Schema: deportivo; Owner: postgres
--

CREATE SEQUENCE deportivo.jugadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE deportivo.jugadores_id_seq OWNER TO postgres;

--
-- Name: jugadores_id_seq; Type: SEQUENCE OWNED BY; Schema: deportivo; Owner: postgres
--

ALTER SEQUENCE deportivo.jugadores_id_seq OWNED BY deportivo.jugadores.id;


--
-- Name: notificaciones; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.notificaciones (
    id integer NOT NULL,
    usuario_id uuid NOT NULL,
    titulo character varying(200) NOT NULL,
    mensaje text NOT NULL,
    leida boolean DEFAULT false,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE deportivo.notificaciones OWNER TO postgres;

--
-- Name: notificaciones_id_seq; Type: SEQUENCE; Schema: deportivo; Owner: postgres
--

CREATE SEQUENCE deportivo.notificaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE deportivo.notificaciones_id_seq OWNER TO postgres;

--
-- Name: notificaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: deportivo; Owner: postgres
--

ALTER SEQUENCE deportivo.notificaciones_id_seq OWNED BY deportivo.notificaciones.id;


--
-- Name: partidos; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.partidos (
    id integer NOT NULL,
    torneo_id integer NOT NULL,
    equipo_local integer NOT NULL,
    equipo_visita integer NOT NULL,
    fecha_partido timestamp without time zone,
    cancha character varying(200),
    estado character varying(30) DEFAULT 'PROGRAMADO'::character varying,
    CONSTRAINT partidos_check CHECK ((equipo_local <> equipo_visita)),
    CONSTRAINT partidos_estado_check CHECK (((estado)::text = ANY ((ARRAY['PROGRAMADO'::character varying, 'EN_CURSO'::character varying, 'FINALIZADO'::character varying, 'SUSPENDIDO'::character varying])::text[])))
);


ALTER TABLE deportivo.partidos OWNER TO postgres;

--
-- Name: partidos_id_seq; Type: SEQUENCE; Schema: deportivo; Owner: postgres
--

CREATE SEQUENCE deportivo.partidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE deportivo.partidos_id_seq OWNER TO postgres;

--
-- Name: partidos_id_seq; Type: SEQUENCE OWNED BY; Schema: deportivo; Owner: postgres
--

ALTER SEQUENCE deportivo.partidos_id_seq OWNED BY deportivo.partidos.id;


--
-- Name: resultados; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.resultados (
    partido_id integer NOT NULL,
    goles_local integer DEFAULT 0,
    goles_visita integer DEFAULT 0,
    registrado_por uuid,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE deportivo.resultados OWNER TO postgres;

--
-- Name: torneo_equipos; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.torneo_equipos (
    id integer NOT NULL,
    torneo_id integer NOT NULL,
    equipo_id integer NOT NULL
);


ALTER TABLE deportivo.torneo_equipos OWNER TO postgres;

--
-- Name: torneo_equipos_id_seq; Type: SEQUENCE; Schema: deportivo; Owner: postgres
--

CREATE SEQUENCE deportivo.torneo_equipos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE deportivo.torneo_equipos_id_seq OWNER TO postgres;

--
-- Name: torneo_equipos_id_seq; Type: SEQUENCE OWNED BY; Schema: deportivo; Owner: postgres
--

ALTER SEQUENCE deportivo.torneo_equipos_id_seq OWNED BY deportivo.torneo_equipos.id;


--
-- Name: torneos; Type: TABLE; Schema: deportivo; Owner: postgres
--

CREATE TABLE deportivo.torneos (
    id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    categoria_id integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    estado character varying(30) NOT NULL,
    CONSTRAINT torneos_estado_check CHECK (((estado)::text = ANY ((ARRAY['PLANIFICADO'::character varying, 'ACTIVO'::character varying, 'FINALIZADO'::character varying])::text[])))
);


ALTER TABLE deportivo.torneos OWNER TO postgres;

--
-- Name: torneos_id_seq; Type: SEQUENCE; Schema: deportivo; Owner: postgres
--

CREATE SEQUENCE deportivo.torneos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE deportivo.torneos_id_seq OWNER TO postgres;

--
-- Name: torneos_id_seq; Type: SEQUENCE OWNED BY; Schema: deportivo; Owner: postgres
--

ALTER SEQUENCE deportivo.torneos_id_seq OWNED BY deportivo.torneos.id;


--
-- Name: usuarios; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.usuarios (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    correo character varying(255) NOT NULL,
    password_hash text NOT NULL,
    telefono character varying(20),
    activo boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    rol_id integer NOT NULL
);


ALTER TABLE seguridad.usuarios OWNER TO postgres;

--
-- Name: vw_goleadores; Type: VIEW; Schema: deportivo; Owner: postgres
--

CREATE VIEW deportivo.vw_goleadores AS
 SELECT u.nombre,
    u.apellido,
    e.goles
   FROM ((deportivo.estadisticas_jugador e
     JOIN deportivo.jugadores j ON ((j.id = e.jugador_id)))
     JOIN seguridad.usuarios u ON ((u.id = j.usuario_id)))
  ORDER BY e.goles DESC;


ALTER VIEW deportivo.vw_goleadores OWNER TO postgres;

--
-- Name: vw_partidos; Type: VIEW; Schema: deportivo; Owner: postgres
--

CREATE VIEW deportivo.vw_partidos AS
 SELECT p.id,
    el.nombre AS equipo_local,
    ev.nombre AS equipo_visita,
    p.fecha_partido,
    p.estado
   FROM ((deportivo.partidos p
     JOIN deportivo.equipos el ON ((el.id = p.equipo_local)))
     JOIN deportivo.equipos ev ON ((ev.id = p.equipo_visita)));


ALTER VIEW deportivo.vw_partidos OWNER TO postgres;

--
-- Name: vw_tabla_posiciones; Type: VIEW; Schema: deportivo; Owner: postgres
--

CREATE VIEW deportivo.vw_tabla_posiciones AS
 SELECT id,
    nombre
   FROM deportivo.equipos;


ALTER VIEW deportivo.vw_tabla_posiciones OWNER TO postgres;

--
-- Name: transacciones; Type: TABLE; Schema: pagos; Owner: postgres
--

CREATE TABLE pagos.transacciones (
    id integer NOT NULL,
    usuario_id uuid,
    monto numeric(10,2),
    estado character varying(20),
    flow_id character varying(255),
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pagos.transacciones OWNER TO postgres;

--
-- Name: transacciones_id_seq; Type: SEQUENCE; Schema: pagos; Owner: postgres
--

CREATE SEQUENCE pagos.transacciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pagos.transacciones_id_seq OWNER TO postgres;

--
-- Name: transacciones_id_seq; Type: SEQUENCE OWNED BY; Schema: pagos; Owner: postgres
--

ALTER SEQUENCE pagos.transacciones_id_seq OWNED BY pagos.transacciones.id;


--
-- Name: roles; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.roles (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text
);


ALTER TABLE seguridad.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.roles_id_seq OWNED BY seguridad.roles.id;


--
-- Name: dim_equipo id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_equipo ALTER COLUMN id SET DEFAULT nextval('analytics.dim_equipo_id_seq'::regclass);


--
-- Name: dim_jugador id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_jugador ALTER COLUMN id SET DEFAULT nextval('analytics.dim_jugador_id_seq'::regclass);


--
-- Name: dim_tiempo id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_tiempo ALTER COLUMN id SET DEFAULT nextval('analytics.dim_tiempo_id_seq'::regclass);


--
-- Name: dim_torneo id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_torneo ALTER COLUMN id SET DEFAULT nextval('analytics.dim_torneo_id_seq'::regclass);


--
-- Name: fact_estadisticas_jugador id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.fact_estadisticas_jugador ALTER COLUMN id SET DEFAULT nextval('analytics.fact_estadisticas_jugador_id_seq'::regclass);


--
-- Name: fact_partidos id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.fact_partidos ALTER COLUMN id SET DEFAULT nextval('analytics.fact_partidos_id_seq'::regclass);


--
-- Name: logs id; Type: DEFAULT; Schema: auditoria; Owner: postgres
--

ALTER TABLE ONLY auditoria.logs ALTER COLUMN id SET DEFAULT nextval('auditoria.logs_id_seq'::regclass);


--
-- Name: categorias id; Type: DEFAULT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.categorias ALTER COLUMN id SET DEFAULT nextval('deportivo.categorias_id_seq'::regclass);


--
-- Name: equipo_jugador id; Type: DEFAULT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.equipo_jugador ALTER COLUMN id SET DEFAULT nextval('deportivo.equipo_jugador_id_seq'::regclass);


--
-- Name: equipos id; Type: DEFAULT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.equipos ALTER COLUMN id SET DEFAULT nextval('deportivo.equipos_id_seq'::regclass);


--
-- Name: eventos_partido id; Type: DEFAULT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.eventos_partido ALTER COLUMN id SET DEFAULT nextval('deportivo.eventos_partido_id_seq'::regclass);


--
-- Name: jugadores id; Type: DEFAULT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.jugadores ALTER COLUMN id SET DEFAULT nextval('deportivo.jugadores_id_seq'::regclass);


--
-- Name: notificaciones id; Type: DEFAULT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.notificaciones ALTER COLUMN id SET DEFAULT nextval('deportivo.notificaciones_id_seq'::regclass);


--
-- Name: partidos id; Type: DEFAULT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.partidos ALTER COLUMN id SET DEFAULT nextval('deportivo.partidos_id_seq'::regclass);


--
-- Name: torneo_equipos id; Type: DEFAULT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.torneo_equipos ALTER COLUMN id SET DEFAULT nextval('deportivo.torneo_equipos_id_seq'::regclass);


--
-- Name: torneos id; Type: DEFAULT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.torneos ALTER COLUMN id SET DEFAULT nextval('deportivo.torneos_id_seq'::regclass);


--
-- Name: transacciones id; Type: DEFAULT; Schema: pagos; Owner: postgres
--

ALTER TABLE ONLY pagos.transacciones ALTER COLUMN id SET DEFAULT nextval('pagos.transacciones_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.roles ALTER COLUMN id SET DEFAULT nextval('seguridad.roles_id_seq'::regclass);


--
-- Data for Name: dim_equipo; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.dim_equipo (id, equipo_id, nombre) FROM stdin;
1	1	Deportivo Puente Alto
2	2	AtlÃ©tico Cordillera
3	3	UniÃ³n Sur
4	4	Real Maipo
5	5	Club Municipal
6	6	Estrella Roja
\.


--
-- Data for Name: dim_jugador; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.dim_jugador (id, jugador_id, nombre_completo, posicion) FROM stdin;
\.


--
-- Data for Name: dim_tiempo; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.dim_tiempo (id, fecha, anio, trimestre, mes, nombre_mes, semana, dia, dia_semana, nombre_dia) FROM stdin;
1	2025-01-01	2025	1	1	January  	1	1	3	Wednesday
2	2025-01-02	2025	1	1	January  	1	2	4	Thursday 
3	2025-01-03	2025	1	1	January  	1	3	5	Friday   
4	2025-01-04	2025	1	1	January  	1	4	6	Saturday 
5	2025-01-05	2025	1	1	January  	1	5	0	Sunday   
6	2025-01-06	2025	1	1	January  	2	6	1	Monday   
7	2025-01-07	2025	1	1	January  	2	7	2	Tuesday  
8	2025-01-08	2025	1	1	January  	2	8	3	Wednesday
9	2025-01-09	2025	1	1	January  	2	9	4	Thursday 
10	2025-01-10	2025	1	1	January  	2	10	5	Friday   
11	2025-01-11	2025	1	1	January  	2	11	6	Saturday 
12	2025-01-12	2025	1	1	January  	2	12	0	Sunday   
13	2025-01-13	2025	1	1	January  	3	13	1	Monday   
14	2025-01-14	2025	1	1	January  	3	14	2	Tuesday  
15	2025-01-15	2025	1	1	January  	3	15	3	Wednesday
16	2025-01-16	2025	1	1	January  	3	16	4	Thursday 
17	2025-01-17	2025	1	1	January  	3	17	5	Friday   
18	2025-01-18	2025	1	1	January  	3	18	6	Saturday 
19	2025-01-19	2025	1	1	January  	3	19	0	Sunday   
20	2025-01-20	2025	1	1	January  	4	20	1	Monday   
21	2025-01-21	2025	1	1	January  	4	21	2	Tuesday  
22	2025-01-22	2025	1	1	January  	4	22	3	Wednesday
23	2025-01-23	2025	1	1	January  	4	23	4	Thursday 
24	2025-01-24	2025	1	1	January  	4	24	5	Friday   
25	2025-01-25	2025	1	1	January  	4	25	6	Saturday 
26	2025-01-26	2025	1	1	January  	4	26	0	Sunday   
27	2025-01-27	2025	1	1	January  	5	27	1	Monday   
28	2025-01-28	2025	1	1	January  	5	28	2	Tuesday  
29	2025-01-29	2025	1	1	January  	5	29	3	Wednesday
30	2025-01-30	2025	1	1	January  	5	30	4	Thursday 
31	2025-01-31	2025	1	1	January  	5	31	5	Friday   
32	2025-02-01	2025	1	2	February 	5	1	6	Saturday 
33	2025-02-02	2025	1	2	February 	5	2	0	Sunday   
34	2025-02-03	2025	1	2	February 	6	3	1	Monday   
35	2025-02-04	2025	1	2	February 	6	4	2	Tuesday  
36	2025-02-05	2025	1	2	February 	6	5	3	Wednesday
37	2025-02-06	2025	1	2	February 	6	6	4	Thursday 
38	2025-02-07	2025	1	2	February 	6	7	5	Friday   
39	2025-02-08	2025	1	2	February 	6	8	6	Saturday 
40	2025-02-09	2025	1	2	February 	6	9	0	Sunday   
41	2025-02-10	2025	1	2	February 	7	10	1	Monday   
42	2025-02-11	2025	1	2	February 	7	11	2	Tuesday  
43	2025-02-12	2025	1	2	February 	7	12	3	Wednesday
44	2025-02-13	2025	1	2	February 	7	13	4	Thursday 
45	2025-02-14	2025	1	2	February 	7	14	5	Friday   
46	2025-02-15	2025	1	2	February 	7	15	6	Saturday 
47	2025-02-16	2025	1	2	February 	7	16	0	Sunday   
48	2025-02-17	2025	1	2	February 	8	17	1	Monday   
49	2025-02-18	2025	1	2	February 	8	18	2	Tuesday  
50	2025-02-19	2025	1	2	February 	8	19	3	Wednesday
51	2025-02-20	2025	1	2	February 	8	20	4	Thursday 
52	2025-02-21	2025	1	2	February 	8	21	5	Friday   
53	2025-02-22	2025	1	2	February 	8	22	6	Saturday 
54	2025-02-23	2025	1	2	February 	8	23	0	Sunday   
55	2025-02-24	2025	1	2	February 	9	24	1	Monday   
56	2025-02-25	2025	1	2	February 	9	25	2	Tuesday  
57	2025-02-26	2025	1	2	February 	9	26	3	Wednesday
58	2025-02-27	2025	1	2	February 	9	27	4	Thursday 
59	2025-02-28	2025	1	2	February 	9	28	5	Friday   
60	2025-03-01	2025	1	3	March    	9	1	6	Saturday 
61	2025-03-02	2025	1	3	March    	9	2	0	Sunday   
62	2025-03-03	2025	1	3	March    	10	3	1	Monday   
63	2025-03-04	2025	1	3	March    	10	4	2	Tuesday  
64	2025-03-05	2025	1	3	March    	10	5	3	Wednesday
65	2025-03-06	2025	1	3	March    	10	6	4	Thursday 
66	2025-03-07	2025	1	3	March    	10	7	5	Friday   
67	2025-03-08	2025	1	3	March    	10	8	6	Saturday 
68	2025-03-09	2025	1	3	March    	10	9	0	Sunday   
69	2025-03-10	2025	1	3	March    	11	10	1	Monday   
70	2025-03-11	2025	1	3	March    	11	11	2	Tuesday  
71	2025-03-12	2025	1	3	March    	11	12	3	Wednesday
72	2025-03-13	2025	1	3	March    	11	13	4	Thursday 
73	2025-03-14	2025	1	3	March    	11	14	5	Friday   
74	2025-03-15	2025	1	3	March    	11	15	6	Saturday 
75	2025-03-16	2025	1	3	March    	11	16	0	Sunday   
76	2025-03-17	2025	1	3	March    	12	17	1	Monday   
77	2025-03-18	2025	1	3	March    	12	18	2	Tuesday  
78	2025-03-19	2025	1	3	March    	12	19	3	Wednesday
79	2025-03-20	2025	1	3	March    	12	20	4	Thursday 
80	2025-03-21	2025	1	3	March    	12	21	5	Friday   
81	2025-03-22	2025	1	3	March    	12	22	6	Saturday 
82	2025-03-23	2025	1	3	March    	12	23	0	Sunday   
83	2025-03-24	2025	1	3	March    	13	24	1	Monday   
84	2025-03-25	2025	1	3	March    	13	25	2	Tuesday  
85	2025-03-26	2025	1	3	March    	13	26	3	Wednesday
86	2025-03-27	2025	1	3	March    	13	27	4	Thursday 
87	2025-03-28	2025	1	3	March    	13	28	5	Friday   
88	2025-03-29	2025	1	3	March    	13	29	6	Saturday 
89	2025-03-30	2025	1	3	March    	13	30	0	Sunday   
90	2025-03-31	2025	1	3	March    	14	31	1	Monday   
91	2025-04-01	2025	2	4	April    	14	1	2	Tuesday  
92	2025-04-02	2025	2	4	April    	14	2	3	Wednesday
93	2025-04-03	2025	2	4	April    	14	3	4	Thursday 
94	2025-04-04	2025	2	4	April    	14	4	5	Friday   
95	2025-04-05	2025	2	4	April    	14	5	6	Saturday 
96	2025-04-06	2025	2	4	April    	14	6	0	Sunday   
97	2025-04-07	2025	2	4	April    	15	7	1	Monday   
98	2025-04-08	2025	2	4	April    	15	8	2	Tuesday  
99	2025-04-09	2025	2	4	April    	15	9	3	Wednesday
100	2025-04-10	2025	2	4	April    	15	10	4	Thursday 
101	2025-04-11	2025	2	4	April    	15	11	5	Friday   
102	2025-04-12	2025	2	4	April    	15	12	6	Saturday 
103	2025-04-13	2025	2	4	April    	15	13	0	Sunday   
104	2025-04-14	2025	2	4	April    	16	14	1	Monday   
105	2025-04-15	2025	2	4	April    	16	15	2	Tuesday  
106	2025-04-16	2025	2	4	April    	16	16	3	Wednesday
107	2025-04-17	2025	2	4	April    	16	17	4	Thursday 
108	2025-04-18	2025	2	4	April    	16	18	5	Friday   
109	2025-04-19	2025	2	4	April    	16	19	6	Saturday 
110	2025-04-20	2025	2	4	April    	16	20	0	Sunday   
111	2025-04-21	2025	2	4	April    	17	21	1	Monday   
112	2025-04-22	2025	2	4	April    	17	22	2	Tuesday  
113	2025-04-23	2025	2	4	April    	17	23	3	Wednesday
114	2025-04-24	2025	2	4	April    	17	24	4	Thursday 
115	2025-04-25	2025	2	4	April    	17	25	5	Friday   
116	2025-04-26	2025	2	4	April    	17	26	6	Saturday 
117	2025-04-27	2025	2	4	April    	17	27	0	Sunday   
118	2025-04-28	2025	2	4	April    	18	28	1	Monday   
119	2025-04-29	2025	2	4	April    	18	29	2	Tuesday  
120	2025-04-30	2025	2	4	April    	18	30	3	Wednesday
121	2025-05-01	2025	2	5	May      	18	1	4	Thursday 
122	2025-05-02	2025	2	5	May      	18	2	5	Friday   
123	2025-05-03	2025	2	5	May      	18	3	6	Saturday 
124	2025-05-04	2025	2	5	May      	18	4	0	Sunday   
125	2025-05-05	2025	2	5	May      	19	5	1	Monday   
126	2025-05-06	2025	2	5	May      	19	6	2	Tuesday  
127	2025-05-07	2025	2	5	May      	19	7	3	Wednesday
128	2025-05-08	2025	2	5	May      	19	8	4	Thursday 
129	2025-05-09	2025	2	5	May      	19	9	5	Friday   
130	2025-05-10	2025	2	5	May      	19	10	6	Saturday 
131	2025-05-11	2025	2	5	May      	19	11	0	Sunday   
132	2025-05-12	2025	2	5	May      	20	12	1	Monday   
133	2025-05-13	2025	2	5	May      	20	13	2	Tuesday  
134	2025-05-14	2025	2	5	May      	20	14	3	Wednesday
135	2025-05-15	2025	2	5	May      	20	15	4	Thursday 
136	2025-05-16	2025	2	5	May      	20	16	5	Friday   
137	2025-05-17	2025	2	5	May      	20	17	6	Saturday 
138	2025-05-18	2025	2	5	May      	20	18	0	Sunday   
139	2025-05-19	2025	2	5	May      	21	19	1	Monday   
140	2025-05-20	2025	2	5	May      	21	20	2	Tuesday  
141	2025-05-21	2025	2	5	May      	21	21	3	Wednesday
142	2025-05-22	2025	2	5	May      	21	22	4	Thursday 
143	2025-05-23	2025	2	5	May      	21	23	5	Friday   
144	2025-05-24	2025	2	5	May      	21	24	6	Saturday 
145	2025-05-25	2025	2	5	May      	21	25	0	Sunday   
146	2025-05-26	2025	2	5	May      	22	26	1	Monday   
147	2025-05-27	2025	2	5	May      	22	27	2	Tuesday  
148	2025-05-28	2025	2	5	May      	22	28	3	Wednesday
149	2025-05-29	2025	2	5	May      	22	29	4	Thursday 
150	2025-05-30	2025	2	5	May      	22	30	5	Friday   
151	2025-05-31	2025	2	5	May      	22	31	6	Saturday 
152	2025-06-01	2025	2	6	June     	22	1	0	Sunday   
153	2025-06-02	2025	2	6	June     	23	2	1	Monday   
154	2025-06-03	2025	2	6	June     	23	3	2	Tuesday  
155	2025-06-04	2025	2	6	June     	23	4	3	Wednesday
156	2025-06-05	2025	2	6	June     	23	5	4	Thursday 
157	2025-06-06	2025	2	6	June     	23	6	5	Friday   
158	2025-06-07	2025	2	6	June     	23	7	6	Saturday 
159	2025-06-08	2025	2	6	June     	23	8	0	Sunday   
160	2025-06-09	2025	2	6	June     	24	9	1	Monday   
161	2025-06-10	2025	2	6	June     	24	10	2	Tuesday  
162	2025-06-11	2025	2	6	June     	24	11	3	Wednesday
163	2025-06-12	2025	2	6	June     	24	12	4	Thursday 
164	2025-06-13	2025	2	6	June     	24	13	5	Friday   
165	2025-06-14	2025	2	6	June     	24	14	6	Saturday 
166	2025-06-15	2025	2	6	June     	24	15	0	Sunday   
167	2025-06-16	2025	2	6	June     	25	16	1	Monday   
168	2025-06-17	2025	2	6	June     	25	17	2	Tuesday  
169	2025-06-18	2025	2	6	June     	25	18	3	Wednesday
170	2025-06-19	2025	2	6	June     	25	19	4	Thursday 
171	2025-06-20	2025	2	6	June     	25	20	5	Friday   
172	2025-06-21	2025	2	6	June     	25	21	6	Saturday 
173	2025-06-22	2025	2	6	June     	25	22	0	Sunday   
174	2025-06-23	2025	2	6	June     	26	23	1	Monday   
175	2025-06-24	2025	2	6	June     	26	24	2	Tuesday  
176	2025-06-25	2025	2	6	June     	26	25	3	Wednesday
177	2025-06-26	2025	2	6	June     	26	26	4	Thursday 
178	2025-06-27	2025	2	6	June     	26	27	5	Friday   
179	2025-06-28	2025	2	6	June     	26	28	6	Saturday 
180	2025-06-29	2025	2	6	June     	26	29	0	Sunday   
181	2025-06-30	2025	2	6	June     	27	30	1	Monday   
182	2025-07-01	2025	3	7	July     	27	1	2	Tuesday  
183	2025-07-02	2025	3	7	July     	27	2	3	Wednesday
184	2025-07-03	2025	3	7	July     	27	3	4	Thursday 
185	2025-07-04	2025	3	7	July     	27	4	5	Friday   
186	2025-07-05	2025	3	7	July     	27	5	6	Saturday 
187	2025-07-06	2025	3	7	July     	27	6	0	Sunday   
188	2025-07-07	2025	3	7	July     	28	7	1	Monday   
189	2025-07-08	2025	3	7	July     	28	8	2	Tuesday  
190	2025-07-09	2025	3	7	July     	28	9	3	Wednesday
191	2025-07-10	2025	3	7	July     	28	10	4	Thursday 
192	2025-07-11	2025	3	7	July     	28	11	5	Friday   
193	2025-07-12	2025	3	7	July     	28	12	6	Saturday 
194	2025-07-13	2025	3	7	July     	28	13	0	Sunday   
195	2025-07-14	2025	3	7	July     	29	14	1	Monday   
196	2025-07-15	2025	3	7	July     	29	15	2	Tuesday  
197	2025-07-16	2025	3	7	July     	29	16	3	Wednesday
198	2025-07-17	2025	3	7	July     	29	17	4	Thursday 
199	2025-07-18	2025	3	7	July     	29	18	5	Friday   
200	2025-07-19	2025	3	7	July     	29	19	6	Saturday 
201	2025-07-20	2025	3	7	July     	29	20	0	Sunday   
202	2025-07-21	2025	3	7	July     	30	21	1	Monday   
203	2025-07-22	2025	3	7	July     	30	22	2	Tuesday  
204	2025-07-23	2025	3	7	July     	30	23	3	Wednesday
205	2025-07-24	2025	3	7	July     	30	24	4	Thursday 
206	2025-07-25	2025	3	7	July     	30	25	5	Friday   
207	2025-07-26	2025	3	7	July     	30	26	6	Saturday 
208	2025-07-27	2025	3	7	July     	30	27	0	Sunday   
209	2025-07-28	2025	3	7	July     	31	28	1	Monday   
210	2025-07-29	2025	3	7	July     	31	29	2	Tuesday  
211	2025-07-30	2025	3	7	July     	31	30	3	Wednesday
212	2025-07-31	2025	3	7	July     	31	31	4	Thursday 
213	2025-08-01	2025	3	8	August   	31	1	5	Friday   
214	2025-08-02	2025	3	8	August   	31	2	6	Saturday 
215	2025-08-03	2025	3	8	August   	31	3	0	Sunday   
216	2025-08-04	2025	3	8	August   	32	4	1	Monday   
217	2025-08-05	2025	3	8	August   	32	5	2	Tuesday  
218	2025-08-06	2025	3	8	August   	32	6	3	Wednesday
219	2025-08-07	2025	3	8	August   	32	7	4	Thursday 
220	2025-08-08	2025	3	8	August   	32	8	5	Friday   
221	2025-08-09	2025	3	8	August   	32	9	6	Saturday 
222	2025-08-10	2025	3	8	August   	32	10	0	Sunday   
223	2025-08-11	2025	3	8	August   	33	11	1	Monday   
224	2025-08-12	2025	3	8	August   	33	12	2	Tuesday  
225	2025-08-13	2025	3	8	August   	33	13	3	Wednesday
226	2025-08-14	2025	3	8	August   	33	14	4	Thursday 
227	2025-08-15	2025	3	8	August   	33	15	5	Friday   
228	2025-08-16	2025	3	8	August   	33	16	6	Saturday 
229	2025-08-17	2025	3	8	August   	33	17	0	Sunday   
230	2025-08-18	2025	3	8	August   	34	18	1	Monday   
231	2025-08-19	2025	3	8	August   	34	19	2	Tuesday  
232	2025-08-20	2025	3	8	August   	34	20	3	Wednesday
233	2025-08-21	2025	3	8	August   	34	21	4	Thursday 
234	2025-08-22	2025	3	8	August   	34	22	5	Friday   
235	2025-08-23	2025	3	8	August   	34	23	6	Saturday 
236	2025-08-24	2025	3	8	August   	34	24	0	Sunday   
237	2025-08-25	2025	3	8	August   	35	25	1	Monday   
238	2025-08-26	2025	3	8	August   	35	26	2	Tuesday  
239	2025-08-27	2025	3	8	August   	35	27	3	Wednesday
240	2025-08-28	2025	3	8	August   	35	28	4	Thursday 
241	2025-08-29	2025	3	8	August   	35	29	5	Friday   
242	2025-08-30	2025	3	8	August   	35	30	6	Saturday 
243	2025-08-31	2025	3	8	August   	35	31	0	Sunday   
244	2025-09-01	2025	3	9	September	36	1	1	Monday   
245	2025-09-02	2025	3	9	September	36	2	2	Tuesday  
246	2025-09-03	2025	3	9	September	36	3	3	Wednesday
247	2025-09-04	2025	3	9	September	36	4	4	Thursday 
248	2025-09-05	2025	3	9	September	36	5	5	Friday   
249	2025-09-06	2025	3	9	September	36	6	6	Saturday 
250	2025-09-07	2025	3	9	September	36	7	0	Sunday   
251	2025-09-08	2025	3	9	September	37	8	1	Monday   
252	2025-09-09	2025	3	9	September	37	9	2	Tuesday  
253	2025-09-10	2025	3	9	September	37	10	3	Wednesday
254	2025-09-11	2025	3	9	September	37	11	4	Thursday 
255	2025-09-12	2025	3	9	September	37	12	5	Friday   
256	2025-09-13	2025	3	9	September	37	13	6	Saturday 
257	2025-09-14	2025	3	9	September	37	14	0	Sunday   
258	2025-09-15	2025	3	9	September	38	15	1	Monday   
259	2025-09-16	2025	3	9	September	38	16	2	Tuesday  
260	2025-09-17	2025	3	9	September	38	17	3	Wednesday
261	2025-09-18	2025	3	9	September	38	18	4	Thursday 
262	2025-09-19	2025	3	9	September	38	19	5	Friday   
263	2025-09-20	2025	3	9	September	38	20	6	Saturday 
264	2025-09-21	2025	3	9	September	38	21	0	Sunday   
265	2025-09-22	2025	3	9	September	39	22	1	Monday   
266	2025-09-23	2025	3	9	September	39	23	2	Tuesday  
267	2025-09-24	2025	3	9	September	39	24	3	Wednesday
268	2025-09-25	2025	3	9	September	39	25	4	Thursday 
269	2025-09-26	2025	3	9	September	39	26	5	Friday   
270	2025-09-27	2025	3	9	September	39	27	6	Saturday 
271	2025-09-28	2025	3	9	September	39	28	0	Sunday   
272	2025-09-29	2025	3	9	September	40	29	1	Monday   
273	2025-09-30	2025	3	9	September	40	30	2	Tuesday  
274	2025-10-01	2025	4	10	October  	40	1	3	Wednesday
275	2025-10-02	2025	4	10	October  	40	2	4	Thursday 
276	2025-10-03	2025	4	10	October  	40	3	5	Friday   
277	2025-10-04	2025	4	10	October  	40	4	6	Saturday 
278	2025-10-05	2025	4	10	October  	40	5	0	Sunday   
279	2025-10-06	2025	4	10	October  	41	6	1	Monday   
280	2025-10-07	2025	4	10	October  	41	7	2	Tuesday  
281	2025-10-08	2025	4	10	October  	41	8	3	Wednesday
282	2025-10-09	2025	4	10	October  	41	9	4	Thursday 
283	2025-10-10	2025	4	10	October  	41	10	5	Friday   
284	2025-10-11	2025	4	10	October  	41	11	6	Saturday 
285	2025-10-12	2025	4	10	October  	41	12	0	Sunday   
286	2025-10-13	2025	4	10	October  	42	13	1	Monday   
287	2025-10-14	2025	4	10	October  	42	14	2	Tuesday  
288	2025-10-15	2025	4	10	October  	42	15	3	Wednesday
289	2025-10-16	2025	4	10	October  	42	16	4	Thursday 
290	2025-10-17	2025	4	10	October  	42	17	5	Friday   
291	2025-10-18	2025	4	10	October  	42	18	6	Saturday 
292	2025-10-19	2025	4	10	October  	42	19	0	Sunday   
293	2025-10-20	2025	4	10	October  	43	20	1	Monday   
294	2025-10-21	2025	4	10	October  	43	21	2	Tuesday  
295	2025-10-22	2025	4	10	October  	43	22	3	Wednesday
296	2025-10-23	2025	4	10	October  	43	23	4	Thursday 
297	2025-10-24	2025	4	10	October  	43	24	5	Friday   
298	2025-10-25	2025	4	10	October  	43	25	6	Saturday 
299	2025-10-26	2025	4	10	October  	43	26	0	Sunday   
300	2025-10-27	2025	4	10	October  	44	27	1	Monday   
301	2025-10-28	2025	4	10	October  	44	28	2	Tuesday  
302	2025-10-29	2025	4	10	October  	44	29	3	Wednesday
303	2025-10-30	2025	4	10	October  	44	30	4	Thursday 
304	2025-10-31	2025	4	10	October  	44	31	5	Friday   
305	2025-11-01	2025	4	11	November 	44	1	6	Saturday 
306	2025-11-02	2025	4	11	November 	44	2	0	Sunday   
307	2025-11-03	2025	4	11	November 	45	3	1	Monday   
308	2025-11-04	2025	4	11	November 	45	4	2	Tuesday  
309	2025-11-05	2025	4	11	November 	45	5	3	Wednesday
310	2025-11-06	2025	4	11	November 	45	6	4	Thursday 
311	2025-11-07	2025	4	11	November 	45	7	5	Friday   
312	2025-11-08	2025	4	11	November 	45	8	6	Saturday 
313	2025-11-09	2025	4	11	November 	45	9	0	Sunday   
314	2025-11-10	2025	4	11	November 	46	10	1	Monday   
315	2025-11-11	2025	4	11	November 	46	11	2	Tuesday  
316	2025-11-12	2025	4	11	November 	46	12	3	Wednesday
317	2025-11-13	2025	4	11	November 	46	13	4	Thursday 
318	2025-11-14	2025	4	11	November 	46	14	5	Friday   
319	2025-11-15	2025	4	11	November 	46	15	6	Saturday 
320	2025-11-16	2025	4	11	November 	46	16	0	Sunday   
321	2025-11-17	2025	4	11	November 	47	17	1	Monday   
322	2025-11-18	2025	4	11	November 	47	18	2	Tuesday  
323	2025-11-19	2025	4	11	November 	47	19	3	Wednesday
324	2025-11-20	2025	4	11	November 	47	20	4	Thursday 
325	2025-11-21	2025	4	11	November 	47	21	5	Friday   
326	2025-11-22	2025	4	11	November 	47	22	6	Saturday 
327	2025-11-23	2025	4	11	November 	47	23	0	Sunday   
328	2025-11-24	2025	4	11	November 	48	24	1	Monday   
329	2025-11-25	2025	4	11	November 	48	25	2	Tuesday  
330	2025-11-26	2025	4	11	November 	48	26	3	Wednesday
331	2025-11-27	2025	4	11	November 	48	27	4	Thursday 
332	2025-11-28	2025	4	11	November 	48	28	5	Friday   
333	2025-11-29	2025	4	11	November 	48	29	6	Saturday 
334	2025-11-30	2025	4	11	November 	48	30	0	Sunday   
335	2025-12-01	2025	4	12	December 	49	1	1	Monday   
336	2025-12-02	2025	4	12	December 	49	2	2	Tuesday  
337	2025-12-03	2025	4	12	December 	49	3	3	Wednesday
338	2025-12-04	2025	4	12	December 	49	4	4	Thursday 
339	2025-12-05	2025	4	12	December 	49	5	5	Friday   
340	2025-12-06	2025	4	12	December 	49	6	6	Saturday 
341	2025-12-07	2025	4	12	December 	49	7	0	Sunday   
342	2025-12-08	2025	4	12	December 	50	8	1	Monday   
343	2025-12-09	2025	4	12	December 	50	9	2	Tuesday  
344	2025-12-10	2025	4	12	December 	50	10	3	Wednesday
345	2025-12-11	2025	4	12	December 	50	11	4	Thursday 
346	2025-12-12	2025	4	12	December 	50	12	5	Friday   
347	2025-12-13	2025	4	12	December 	50	13	6	Saturday 
348	2025-12-14	2025	4	12	December 	50	14	0	Sunday   
349	2025-12-15	2025	4	12	December 	51	15	1	Monday   
350	2025-12-16	2025	4	12	December 	51	16	2	Tuesday  
351	2025-12-17	2025	4	12	December 	51	17	3	Wednesday
352	2025-12-18	2025	4	12	December 	51	18	4	Thursday 
353	2025-12-19	2025	4	12	December 	51	19	5	Friday   
354	2025-12-20	2025	4	12	December 	51	20	6	Saturday 
355	2025-12-21	2025	4	12	December 	51	21	0	Sunday   
356	2025-12-22	2025	4	12	December 	52	22	1	Monday   
357	2025-12-23	2025	4	12	December 	52	23	2	Tuesday  
358	2025-12-24	2025	4	12	December 	52	24	3	Wednesday
359	2025-12-25	2025	4	12	December 	52	25	4	Thursday 
360	2025-12-26	2025	4	12	December 	52	26	5	Friday   
361	2025-12-27	2025	4	12	December 	52	27	6	Saturday 
362	2025-12-28	2025	4	12	December 	52	28	0	Sunday   
363	2025-12-29	2025	4	12	December 	1	29	1	Monday   
364	2025-12-30	2025	4	12	December 	1	30	2	Tuesday  
365	2025-12-31	2025	4	12	December 	1	31	3	Wednesday
366	2026-01-01	2026	1	1	January  	1	1	4	Thursday 
367	2026-01-02	2026	1	1	January  	1	2	5	Friday   
368	2026-01-03	2026	1	1	January  	1	3	6	Saturday 
369	2026-01-04	2026	1	1	January  	1	4	0	Sunday   
370	2026-01-05	2026	1	1	January  	2	5	1	Monday   
371	2026-01-06	2026	1	1	January  	2	6	2	Tuesday  
372	2026-01-07	2026	1	1	January  	2	7	3	Wednesday
373	2026-01-08	2026	1	1	January  	2	8	4	Thursday 
374	2026-01-09	2026	1	1	January  	2	9	5	Friday   
375	2026-01-10	2026	1	1	January  	2	10	6	Saturday 
376	2026-01-11	2026	1	1	January  	2	11	0	Sunday   
377	2026-01-12	2026	1	1	January  	3	12	1	Monday   
378	2026-01-13	2026	1	1	January  	3	13	2	Tuesday  
379	2026-01-14	2026	1	1	January  	3	14	3	Wednesday
380	2026-01-15	2026	1	1	January  	3	15	4	Thursday 
381	2026-01-16	2026	1	1	January  	3	16	5	Friday   
382	2026-01-17	2026	1	1	January  	3	17	6	Saturday 
383	2026-01-18	2026	1	1	January  	3	18	0	Sunday   
384	2026-01-19	2026	1	1	January  	4	19	1	Monday   
385	2026-01-20	2026	1	1	January  	4	20	2	Tuesday  
386	2026-01-21	2026	1	1	January  	4	21	3	Wednesday
387	2026-01-22	2026	1	1	January  	4	22	4	Thursday 
388	2026-01-23	2026	1	1	January  	4	23	5	Friday   
389	2026-01-24	2026	1	1	January  	4	24	6	Saturday 
390	2026-01-25	2026	1	1	January  	4	25	0	Sunday   
391	2026-01-26	2026	1	1	January  	5	26	1	Monday   
392	2026-01-27	2026	1	1	January  	5	27	2	Tuesday  
393	2026-01-28	2026	1	1	January  	5	28	3	Wednesday
394	2026-01-29	2026	1	1	January  	5	29	4	Thursday 
395	2026-01-30	2026	1	1	January  	5	30	5	Friday   
396	2026-01-31	2026	1	1	January  	5	31	6	Saturday 
397	2026-02-01	2026	1	2	February 	5	1	0	Sunday   
398	2026-02-02	2026	1	2	February 	6	2	1	Monday   
399	2026-02-03	2026	1	2	February 	6	3	2	Tuesday  
400	2026-02-04	2026	1	2	February 	6	4	3	Wednesday
401	2026-02-05	2026	1	2	February 	6	5	4	Thursday 
402	2026-02-06	2026	1	2	February 	6	6	5	Friday   
403	2026-02-07	2026	1	2	February 	6	7	6	Saturday 
404	2026-02-08	2026	1	2	February 	6	8	0	Sunday   
405	2026-02-09	2026	1	2	February 	7	9	1	Monday   
406	2026-02-10	2026	1	2	February 	7	10	2	Tuesday  
407	2026-02-11	2026	1	2	February 	7	11	3	Wednesday
408	2026-02-12	2026	1	2	February 	7	12	4	Thursday 
409	2026-02-13	2026	1	2	February 	7	13	5	Friday   
410	2026-02-14	2026	1	2	February 	7	14	6	Saturday 
411	2026-02-15	2026	1	2	February 	7	15	0	Sunday   
412	2026-02-16	2026	1	2	February 	8	16	1	Monday   
413	2026-02-17	2026	1	2	February 	8	17	2	Tuesday  
414	2026-02-18	2026	1	2	February 	8	18	3	Wednesday
415	2026-02-19	2026	1	2	February 	8	19	4	Thursday 
416	2026-02-20	2026	1	2	February 	8	20	5	Friday   
417	2026-02-21	2026	1	2	February 	8	21	6	Saturday 
418	2026-02-22	2026	1	2	February 	8	22	0	Sunday   
419	2026-02-23	2026	1	2	February 	9	23	1	Monday   
420	2026-02-24	2026	1	2	February 	9	24	2	Tuesday  
421	2026-02-25	2026	1	2	February 	9	25	3	Wednesday
422	2026-02-26	2026	1	2	February 	9	26	4	Thursday 
423	2026-02-27	2026	1	2	February 	9	27	5	Friday   
424	2026-02-28	2026	1	2	February 	9	28	6	Saturday 
425	2026-03-01	2026	1	3	March    	9	1	0	Sunday   
426	2026-03-02	2026	1	3	March    	10	2	1	Monday   
427	2026-03-03	2026	1	3	March    	10	3	2	Tuesday  
428	2026-03-04	2026	1	3	March    	10	4	3	Wednesday
429	2026-03-05	2026	1	3	March    	10	5	4	Thursday 
430	2026-03-06	2026	1	3	March    	10	6	5	Friday   
431	2026-03-07	2026	1	3	March    	10	7	6	Saturday 
432	2026-03-08	2026	1	3	March    	10	8	0	Sunday   
433	2026-03-09	2026	1	3	March    	11	9	1	Monday   
434	2026-03-10	2026	1	3	March    	11	10	2	Tuesday  
435	2026-03-11	2026	1	3	March    	11	11	3	Wednesday
436	2026-03-12	2026	1	3	March    	11	12	4	Thursday 
437	2026-03-13	2026	1	3	March    	11	13	5	Friday   
438	2026-03-14	2026	1	3	March    	11	14	6	Saturday 
439	2026-03-15	2026	1	3	March    	11	15	0	Sunday   
440	2026-03-16	2026	1	3	March    	12	16	1	Monday   
441	2026-03-17	2026	1	3	March    	12	17	2	Tuesday  
442	2026-03-18	2026	1	3	March    	12	18	3	Wednesday
443	2026-03-19	2026	1	3	March    	12	19	4	Thursday 
444	2026-03-20	2026	1	3	March    	12	20	5	Friday   
445	2026-03-21	2026	1	3	March    	12	21	6	Saturday 
446	2026-03-22	2026	1	3	March    	12	22	0	Sunday   
447	2026-03-23	2026	1	3	March    	13	23	1	Monday   
448	2026-03-24	2026	1	3	March    	13	24	2	Tuesday  
449	2026-03-25	2026	1	3	March    	13	25	3	Wednesday
450	2026-03-26	2026	1	3	March    	13	26	4	Thursday 
451	2026-03-27	2026	1	3	March    	13	27	5	Friday   
452	2026-03-28	2026	1	3	March    	13	28	6	Saturday 
453	2026-03-29	2026	1	3	March    	13	29	0	Sunday   
454	2026-03-30	2026	1	3	March    	14	30	1	Monday   
455	2026-03-31	2026	1	3	March    	14	31	2	Tuesday  
456	2026-04-01	2026	2	4	April    	14	1	3	Wednesday
457	2026-04-02	2026	2	4	April    	14	2	4	Thursday 
458	2026-04-03	2026	2	4	April    	14	3	5	Friday   
459	2026-04-04	2026	2	4	April    	14	4	6	Saturday 
460	2026-04-05	2026	2	4	April    	14	5	0	Sunday   
461	2026-04-06	2026	2	4	April    	15	6	1	Monday   
462	2026-04-07	2026	2	4	April    	15	7	2	Tuesday  
463	2026-04-08	2026	2	4	April    	15	8	3	Wednesday
464	2026-04-09	2026	2	4	April    	15	9	4	Thursday 
465	2026-04-10	2026	2	4	April    	15	10	5	Friday   
466	2026-04-11	2026	2	4	April    	15	11	6	Saturday 
467	2026-04-12	2026	2	4	April    	15	12	0	Sunday   
468	2026-04-13	2026	2	4	April    	16	13	1	Monday   
469	2026-04-14	2026	2	4	April    	16	14	2	Tuesday  
470	2026-04-15	2026	2	4	April    	16	15	3	Wednesday
471	2026-04-16	2026	2	4	April    	16	16	4	Thursday 
472	2026-04-17	2026	2	4	April    	16	17	5	Friday   
473	2026-04-18	2026	2	4	April    	16	18	6	Saturday 
474	2026-04-19	2026	2	4	April    	16	19	0	Sunday   
475	2026-04-20	2026	2	4	April    	17	20	1	Monday   
476	2026-04-21	2026	2	4	April    	17	21	2	Tuesday  
477	2026-04-22	2026	2	4	April    	17	22	3	Wednesday
478	2026-04-23	2026	2	4	April    	17	23	4	Thursday 
479	2026-04-24	2026	2	4	April    	17	24	5	Friday   
480	2026-04-25	2026	2	4	April    	17	25	6	Saturday 
481	2026-04-26	2026	2	4	April    	17	26	0	Sunday   
482	2026-04-27	2026	2	4	April    	18	27	1	Monday   
483	2026-04-28	2026	2	4	April    	18	28	2	Tuesday  
484	2026-04-29	2026	2	4	April    	18	29	3	Wednesday
485	2026-04-30	2026	2	4	April    	18	30	4	Thursday 
486	2026-05-01	2026	2	5	May      	18	1	5	Friday   
487	2026-05-02	2026	2	5	May      	18	2	6	Saturday 
488	2026-05-03	2026	2	5	May      	18	3	0	Sunday   
489	2026-05-04	2026	2	5	May      	19	4	1	Monday   
490	2026-05-05	2026	2	5	May      	19	5	2	Tuesday  
491	2026-05-06	2026	2	5	May      	19	6	3	Wednesday
492	2026-05-07	2026	2	5	May      	19	7	4	Thursday 
493	2026-05-08	2026	2	5	May      	19	8	5	Friday   
494	2026-05-09	2026	2	5	May      	19	9	6	Saturday 
495	2026-05-10	2026	2	5	May      	19	10	0	Sunday   
496	2026-05-11	2026	2	5	May      	20	11	1	Monday   
497	2026-05-12	2026	2	5	May      	20	12	2	Tuesday  
498	2026-05-13	2026	2	5	May      	20	13	3	Wednesday
499	2026-05-14	2026	2	5	May      	20	14	4	Thursday 
500	2026-05-15	2026	2	5	May      	20	15	5	Friday   
501	2026-05-16	2026	2	5	May      	20	16	6	Saturday 
502	2026-05-17	2026	2	5	May      	20	17	0	Sunday   
503	2026-05-18	2026	2	5	May      	21	18	1	Monday   
504	2026-05-19	2026	2	5	May      	21	19	2	Tuesday  
505	2026-05-20	2026	2	5	May      	21	20	3	Wednesday
506	2026-05-21	2026	2	5	May      	21	21	4	Thursday 
507	2026-05-22	2026	2	5	May      	21	22	5	Friday   
508	2026-05-23	2026	2	5	May      	21	23	6	Saturday 
509	2026-05-24	2026	2	5	May      	21	24	0	Sunday   
510	2026-05-25	2026	2	5	May      	22	25	1	Monday   
511	2026-05-26	2026	2	5	May      	22	26	2	Tuesday  
512	2026-05-27	2026	2	5	May      	22	27	3	Wednesday
513	2026-05-28	2026	2	5	May      	22	28	4	Thursday 
514	2026-05-29	2026	2	5	May      	22	29	5	Friday   
515	2026-05-30	2026	2	5	May      	22	30	6	Saturday 
516	2026-05-31	2026	2	5	May      	22	31	0	Sunday   
517	2026-06-01	2026	2	6	June     	23	1	1	Monday   
518	2026-06-02	2026	2	6	June     	23	2	2	Tuesday  
519	2026-06-03	2026	2	6	June     	23	3	3	Wednesday
520	2026-06-04	2026	2	6	June     	23	4	4	Thursday 
521	2026-06-05	2026	2	6	June     	23	5	5	Friday   
522	2026-06-06	2026	2	6	June     	23	6	6	Saturday 
523	2026-06-07	2026	2	6	June     	23	7	0	Sunday   
524	2026-06-08	2026	2	6	June     	24	8	1	Monday   
525	2026-06-09	2026	2	6	June     	24	9	2	Tuesday  
526	2026-06-10	2026	2	6	June     	24	10	3	Wednesday
527	2026-06-11	2026	2	6	June     	24	11	4	Thursday 
528	2026-06-12	2026	2	6	June     	24	12	5	Friday   
529	2026-06-13	2026	2	6	June     	24	13	6	Saturday 
530	2026-06-14	2026	2	6	June     	24	14	0	Sunday   
531	2026-06-15	2026	2	6	June     	25	15	1	Monday   
532	2026-06-16	2026	2	6	June     	25	16	2	Tuesday  
533	2026-06-17	2026	2	6	June     	25	17	3	Wednesday
534	2026-06-18	2026	2	6	June     	25	18	4	Thursday 
535	2026-06-19	2026	2	6	June     	25	19	5	Friday   
536	2026-06-20	2026	2	6	June     	25	20	6	Saturday 
537	2026-06-21	2026	2	6	June     	25	21	0	Sunday   
538	2026-06-22	2026	2	6	June     	26	22	1	Monday   
539	2026-06-23	2026	2	6	June     	26	23	2	Tuesday  
540	2026-06-24	2026	2	6	June     	26	24	3	Wednesday
541	2026-06-25	2026	2	6	June     	26	25	4	Thursday 
542	2026-06-26	2026	2	6	June     	26	26	5	Friday   
543	2026-06-27	2026	2	6	June     	26	27	6	Saturday 
544	2026-06-28	2026	2	6	June     	26	28	0	Sunday   
545	2026-06-29	2026	2	6	June     	27	29	1	Monday   
546	2026-06-30	2026	2	6	June     	27	30	2	Tuesday  
547	2026-07-01	2026	3	7	July     	27	1	3	Wednesday
548	2026-07-02	2026	3	7	July     	27	2	4	Thursday 
549	2026-07-03	2026	3	7	July     	27	3	5	Friday   
550	2026-07-04	2026	3	7	July     	27	4	6	Saturday 
551	2026-07-05	2026	3	7	July     	27	5	0	Sunday   
552	2026-07-06	2026	3	7	July     	28	6	1	Monday   
553	2026-07-07	2026	3	7	July     	28	7	2	Tuesday  
554	2026-07-08	2026	3	7	July     	28	8	3	Wednesday
555	2026-07-09	2026	3	7	July     	28	9	4	Thursday 
556	2026-07-10	2026	3	7	July     	28	10	5	Friday   
557	2026-07-11	2026	3	7	July     	28	11	6	Saturday 
558	2026-07-12	2026	3	7	July     	28	12	0	Sunday   
559	2026-07-13	2026	3	7	July     	29	13	1	Monday   
560	2026-07-14	2026	3	7	July     	29	14	2	Tuesday  
561	2026-07-15	2026	3	7	July     	29	15	3	Wednesday
562	2026-07-16	2026	3	7	July     	29	16	4	Thursday 
563	2026-07-17	2026	3	7	July     	29	17	5	Friday   
564	2026-07-18	2026	3	7	July     	29	18	6	Saturday 
565	2026-07-19	2026	3	7	July     	29	19	0	Sunday   
566	2026-07-20	2026	3	7	July     	30	20	1	Monday   
567	2026-07-21	2026	3	7	July     	30	21	2	Tuesday  
568	2026-07-22	2026	3	7	July     	30	22	3	Wednesday
569	2026-07-23	2026	3	7	July     	30	23	4	Thursday 
570	2026-07-24	2026	3	7	July     	30	24	5	Friday   
571	2026-07-25	2026	3	7	July     	30	25	6	Saturday 
572	2026-07-26	2026	3	7	July     	30	26	0	Sunday   
573	2026-07-27	2026	3	7	July     	31	27	1	Monday   
574	2026-07-28	2026	3	7	July     	31	28	2	Tuesday  
575	2026-07-29	2026	3	7	July     	31	29	3	Wednesday
576	2026-07-30	2026	3	7	July     	31	30	4	Thursday 
577	2026-07-31	2026	3	7	July     	31	31	5	Friday   
578	2026-08-01	2026	3	8	August   	31	1	6	Saturday 
579	2026-08-02	2026	3	8	August   	31	2	0	Sunday   
580	2026-08-03	2026	3	8	August   	32	3	1	Monday   
581	2026-08-04	2026	3	8	August   	32	4	2	Tuesday  
582	2026-08-05	2026	3	8	August   	32	5	3	Wednesday
583	2026-08-06	2026	3	8	August   	32	6	4	Thursday 
584	2026-08-07	2026	3	8	August   	32	7	5	Friday   
585	2026-08-08	2026	3	8	August   	32	8	6	Saturday 
586	2026-08-09	2026	3	8	August   	32	9	0	Sunday   
587	2026-08-10	2026	3	8	August   	33	10	1	Monday   
588	2026-08-11	2026	3	8	August   	33	11	2	Tuesday  
589	2026-08-12	2026	3	8	August   	33	12	3	Wednesday
590	2026-08-13	2026	3	8	August   	33	13	4	Thursday 
591	2026-08-14	2026	3	8	August   	33	14	5	Friday   
592	2026-08-15	2026	3	8	August   	33	15	6	Saturday 
593	2026-08-16	2026	3	8	August   	33	16	0	Sunday   
594	2026-08-17	2026	3	8	August   	34	17	1	Monday   
595	2026-08-18	2026	3	8	August   	34	18	2	Tuesday  
596	2026-08-19	2026	3	8	August   	34	19	3	Wednesday
597	2026-08-20	2026	3	8	August   	34	20	4	Thursday 
598	2026-08-21	2026	3	8	August   	34	21	5	Friday   
599	2026-08-22	2026	3	8	August   	34	22	6	Saturday 
600	2026-08-23	2026	3	8	August   	34	23	0	Sunday   
601	2026-08-24	2026	3	8	August   	35	24	1	Monday   
602	2026-08-25	2026	3	8	August   	35	25	2	Tuesday  
603	2026-08-26	2026	3	8	August   	35	26	3	Wednesday
604	2026-08-27	2026	3	8	August   	35	27	4	Thursday 
605	2026-08-28	2026	3	8	August   	35	28	5	Friday   
606	2026-08-29	2026	3	8	August   	35	29	6	Saturday 
607	2026-08-30	2026	3	8	August   	35	30	0	Sunday   
608	2026-08-31	2026	3	8	August   	36	31	1	Monday   
609	2026-09-01	2026	3	9	September	36	1	2	Tuesday  
610	2026-09-02	2026	3	9	September	36	2	3	Wednesday
611	2026-09-03	2026	3	9	September	36	3	4	Thursday 
612	2026-09-04	2026	3	9	September	36	4	5	Friday   
613	2026-09-05	2026	3	9	September	36	5	6	Saturday 
614	2026-09-06	2026	3	9	September	36	6	0	Sunday   
615	2026-09-07	2026	3	9	September	37	7	1	Monday   
616	2026-09-08	2026	3	9	September	37	8	2	Tuesday  
617	2026-09-09	2026	3	9	September	37	9	3	Wednesday
618	2026-09-10	2026	3	9	September	37	10	4	Thursday 
619	2026-09-11	2026	3	9	September	37	11	5	Friday   
620	2026-09-12	2026	3	9	September	37	12	6	Saturday 
621	2026-09-13	2026	3	9	September	37	13	0	Sunday   
622	2026-09-14	2026	3	9	September	38	14	1	Monday   
623	2026-09-15	2026	3	9	September	38	15	2	Tuesday  
624	2026-09-16	2026	3	9	September	38	16	3	Wednesday
625	2026-09-17	2026	3	9	September	38	17	4	Thursday 
626	2026-09-18	2026	3	9	September	38	18	5	Friday   
627	2026-09-19	2026	3	9	September	38	19	6	Saturday 
628	2026-09-20	2026	3	9	September	38	20	0	Sunday   
629	2026-09-21	2026	3	9	September	39	21	1	Monday   
630	2026-09-22	2026	3	9	September	39	22	2	Tuesday  
631	2026-09-23	2026	3	9	September	39	23	3	Wednesday
632	2026-09-24	2026	3	9	September	39	24	4	Thursday 
633	2026-09-25	2026	3	9	September	39	25	5	Friday   
634	2026-09-26	2026	3	9	September	39	26	6	Saturday 
635	2026-09-27	2026	3	9	September	39	27	0	Sunday   
636	2026-09-28	2026	3	9	September	40	28	1	Monday   
637	2026-09-29	2026	3	9	September	40	29	2	Tuesday  
638	2026-09-30	2026	3	9	September	40	30	3	Wednesday
639	2026-10-01	2026	4	10	October  	40	1	4	Thursday 
640	2026-10-02	2026	4	10	October  	40	2	5	Friday   
641	2026-10-03	2026	4	10	October  	40	3	6	Saturday 
642	2026-10-04	2026	4	10	October  	40	4	0	Sunday   
643	2026-10-05	2026	4	10	October  	41	5	1	Monday   
644	2026-10-06	2026	4	10	October  	41	6	2	Tuesday  
645	2026-10-07	2026	4	10	October  	41	7	3	Wednesday
646	2026-10-08	2026	4	10	October  	41	8	4	Thursday 
647	2026-10-09	2026	4	10	October  	41	9	5	Friday   
648	2026-10-10	2026	4	10	October  	41	10	6	Saturday 
649	2026-10-11	2026	4	10	October  	41	11	0	Sunday   
650	2026-10-12	2026	4	10	October  	42	12	1	Monday   
651	2026-10-13	2026	4	10	October  	42	13	2	Tuesday  
652	2026-10-14	2026	4	10	October  	42	14	3	Wednesday
653	2026-10-15	2026	4	10	October  	42	15	4	Thursday 
654	2026-10-16	2026	4	10	October  	42	16	5	Friday   
655	2026-10-17	2026	4	10	October  	42	17	6	Saturday 
656	2026-10-18	2026	4	10	October  	42	18	0	Sunday   
657	2026-10-19	2026	4	10	October  	43	19	1	Monday   
658	2026-10-20	2026	4	10	October  	43	20	2	Tuesday  
659	2026-10-21	2026	4	10	October  	43	21	3	Wednesday
660	2026-10-22	2026	4	10	October  	43	22	4	Thursday 
661	2026-10-23	2026	4	10	October  	43	23	5	Friday   
662	2026-10-24	2026	4	10	October  	43	24	6	Saturday 
663	2026-10-25	2026	4	10	October  	43	25	0	Sunday   
664	2026-10-26	2026	4	10	October  	44	26	1	Monday   
665	2026-10-27	2026	4	10	October  	44	27	2	Tuesday  
666	2026-10-28	2026	4	10	October  	44	28	3	Wednesday
667	2026-10-29	2026	4	10	October  	44	29	4	Thursday 
668	2026-10-30	2026	4	10	October  	44	30	5	Friday   
669	2026-10-31	2026	4	10	October  	44	31	6	Saturday 
670	2026-11-01	2026	4	11	November 	44	1	0	Sunday   
671	2026-11-02	2026	4	11	November 	45	2	1	Monday   
672	2026-11-03	2026	4	11	November 	45	3	2	Tuesday  
673	2026-11-04	2026	4	11	November 	45	4	3	Wednesday
674	2026-11-05	2026	4	11	November 	45	5	4	Thursday 
675	2026-11-06	2026	4	11	November 	45	6	5	Friday   
676	2026-11-07	2026	4	11	November 	45	7	6	Saturday 
677	2026-11-08	2026	4	11	November 	45	8	0	Sunday   
678	2026-11-09	2026	4	11	November 	46	9	1	Monday   
679	2026-11-10	2026	4	11	November 	46	10	2	Tuesday  
680	2026-11-11	2026	4	11	November 	46	11	3	Wednesday
681	2026-11-12	2026	4	11	November 	46	12	4	Thursday 
682	2026-11-13	2026	4	11	November 	46	13	5	Friday   
683	2026-11-14	2026	4	11	November 	46	14	6	Saturday 
684	2026-11-15	2026	4	11	November 	46	15	0	Sunday   
685	2026-11-16	2026	4	11	November 	47	16	1	Monday   
686	2026-11-17	2026	4	11	November 	47	17	2	Tuesday  
687	2026-11-18	2026	4	11	November 	47	18	3	Wednesday
688	2026-11-19	2026	4	11	November 	47	19	4	Thursday 
689	2026-11-20	2026	4	11	November 	47	20	5	Friday   
690	2026-11-21	2026	4	11	November 	47	21	6	Saturday 
691	2026-11-22	2026	4	11	November 	47	22	0	Sunday   
692	2026-11-23	2026	4	11	November 	48	23	1	Monday   
693	2026-11-24	2026	4	11	November 	48	24	2	Tuesday  
694	2026-11-25	2026	4	11	November 	48	25	3	Wednesday
695	2026-11-26	2026	4	11	November 	48	26	4	Thursday 
696	2026-11-27	2026	4	11	November 	48	27	5	Friday   
697	2026-11-28	2026	4	11	November 	48	28	6	Saturday 
698	2026-11-29	2026	4	11	November 	48	29	0	Sunday   
699	2026-11-30	2026	4	11	November 	49	30	1	Monday   
700	2026-12-01	2026	4	12	December 	49	1	2	Tuesday  
701	2026-12-02	2026	4	12	December 	49	2	3	Wednesday
702	2026-12-03	2026	4	12	December 	49	3	4	Thursday 
703	2026-12-04	2026	4	12	December 	49	4	5	Friday   
704	2026-12-05	2026	4	12	December 	49	5	6	Saturday 
705	2026-12-06	2026	4	12	December 	49	6	0	Sunday   
706	2026-12-07	2026	4	12	December 	50	7	1	Monday   
707	2026-12-08	2026	4	12	December 	50	8	2	Tuesday  
708	2026-12-09	2026	4	12	December 	50	9	3	Wednesday
709	2026-12-10	2026	4	12	December 	50	10	4	Thursday 
710	2026-12-11	2026	4	12	December 	50	11	5	Friday   
711	2026-12-12	2026	4	12	December 	50	12	6	Saturday 
712	2026-12-13	2026	4	12	December 	50	13	0	Sunday   
713	2026-12-14	2026	4	12	December 	51	14	1	Monday   
714	2026-12-15	2026	4	12	December 	51	15	2	Tuesday  
715	2026-12-16	2026	4	12	December 	51	16	3	Wednesday
716	2026-12-17	2026	4	12	December 	51	17	4	Thursday 
717	2026-12-18	2026	4	12	December 	51	18	5	Friday   
718	2026-12-19	2026	4	12	December 	51	19	6	Saturday 
719	2026-12-20	2026	4	12	December 	51	20	0	Sunday   
720	2026-12-21	2026	4	12	December 	52	21	1	Monday   
721	2026-12-22	2026	4	12	December 	52	22	2	Tuesday  
722	2026-12-23	2026	4	12	December 	52	23	3	Wednesday
723	2026-12-24	2026	4	12	December 	52	24	4	Thursday 
724	2026-12-25	2026	4	12	December 	52	25	5	Friday   
725	2026-12-26	2026	4	12	December 	52	26	6	Saturday 
726	2026-12-27	2026	4	12	December 	52	27	0	Sunday   
727	2026-12-28	2026	4	12	December 	53	28	1	Monday   
728	2026-12-29	2026	4	12	December 	53	29	2	Tuesday  
729	2026-12-30	2026	4	12	December 	53	30	3	Wednesday
730	2026-12-31	2026	4	12	December 	53	31	4	Thursday 
731	2027-01-01	2027	1	1	January  	53	1	5	Friday   
732	2027-01-02	2027	1	1	January  	53	2	6	Saturday 
733	2027-01-03	2027	1	1	January  	53	3	0	Sunday   
734	2027-01-04	2027	1	1	January  	1	4	1	Monday   
735	2027-01-05	2027	1	1	January  	1	5	2	Tuesday  
736	2027-01-06	2027	1	1	January  	1	6	3	Wednesday
737	2027-01-07	2027	1	1	January  	1	7	4	Thursday 
738	2027-01-08	2027	1	1	January  	1	8	5	Friday   
739	2027-01-09	2027	1	1	January  	1	9	6	Saturday 
740	2027-01-10	2027	1	1	January  	1	10	0	Sunday   
741	2027-01-11	2027	1	1	January  	2	11	1	Monday   
742	2027-01-12	2027	1	1	January  	2	12	2	Tuesday  
743	2027-01-13	2027	1	1	January  	2	13	3	Wednesday
744	2027-01-14	2027	1	1	January  	2	14	4	Thursday 
745	2027-01-15	2027	1	1	January  	2	15	5	Friday   
746	2027-01-16	2027	1	1	January  	2	16	6	Saturday 
747	2027-01-17	2027	1	1	January  	2	17	0	Sunday   
748	2027-01-18	2027	1	1	January  	3	18	1	Monday   
749	2027-01-19	2027	1	1	January  	3	19	2	Tuesday  
750	2027-01-20	2027	1	1	January  	3	20	3	Wednesday
751	2027-01-21	2027	1	1	January  	3	21	4	Thursday 
752	2027-01-22	2027	1	1	January  	3	22	5	Friday   
753	2027-01-23	2027	1	1	January  	3	23	6	Saturday 
754	2027-01-24	2027	1	1	January  	3	24	0	Sunday   
755	2027-01-25	2027	1	1	January  	4	25	1	Monday   
756	2027-01-26	2027	1	1	January  	4	26	2	Tuesday  
757	2027-01-27	2027	1	1	January  	4	27	3	Wednesday
758	2027-01-28	2027	1	1	January  	4	28	4	Thursday 
759	2027-01-29	2027	1	1	January  	4	29	5	Friday   
760	2027-01-30	2027	1	1	January  	4	30	6	Saturday 
761	2027-01-31	2027	1	1	January  	4	31	0	Sunday   
762	2027-02-01	2027	1	2	February 	5	1	1	Monday   
763	2027-02-02	2027	1	2	February 	5	2	2	Tuesday  
764	2027-02-03	2027	1	2	February 	5	3	3	Wednesday
765	2027-02-04	2027	1	2	February 	5	4	4	Thursday 
766	2027-02-05	2027	1	2	February 	5	5	5	Friday   
767	2027-02-06	2027	1	2	February 	5	6	6	Saturday 
768	2027-02-07	2027	1	2	February 	5	7	0	Sunday   
769	2027-02-08	2027	1	2	February 	6	8	1	Monday   
770	2027-02-09	2027	1	2	February 	6	9	2	Tuesday  
771	2027-02-10	2027	1	2	February 	6	10	3	Wednesday
772	2027-02-11	2027	1	2	February 	6	11	4	Thursday 
773	2027-02-12	2027	1	2	February 	6	12	5	Friday   
774	2027-02-13	2027	1	2	February 	6	13	6	Saturday 
775	2027-02-14	2027	1	2	February 	6	14	0	Sunday   
776	2027-02-15	2027	1	2	February 	7	15	1	Monday   
777	2027-02-16	2027	1	2	February 	7	16	2	Tuesday  
778	2027-02-17	2027	1	2	February 	7	17	3	Wednesday
779	2027-02-18	2027	1	2	February 	7	18	4	Thursday 
780	2027-02-19	2027	1	2	February 	7	19	5	Friday   
781	2027-02-20	2027	1	2	February 	7	20	6	Saturday 
782	2027-02-21	2027	1	2	February 	7	21	0	Sunday   
783	2027-02-22	2027	1	2	February 	8	22	1	Monday   
784	2027-02-23	2027	1	2	February 	8	23	2	Tuesday  
785	2027-02-24	2027	1	2	February 	8	24	3	Wednesday
786	2027-02-25	2027	1	2	February 	8	25	4	Thursday 
787	2027-02-26	2027	1	2	February 	8	26	5	Friday   
788	2027-02-27	2027	1	2	February 	8	27	6	Saturday 
789	2027-02-28	2027	1	2	February 	8	28	0	Sunday   
790	2027-03-01	2027	1	3	March    	9	1	1	Monday   
791	2027-03-02	2027	1	3	March    	9	2	2	Tuesday  
792	2027-03-03	2027	1	3	March    	9	3	3	Wednesday
793	2027-03-04	2027	1	3	March    	9	4	4	Thursday 
794	2027-03-05	2027	1	3	March    	9	5	5	Friday   
795	2027-03-06	2027	1	3	March    	9	6	6	Saturday 
796	2027-03-07	2027	1	3	March    	9	7	0	Sunday   
797	2027-03-08	2027	1	3	March    	10	8	1	Monday   
798	2027-03-09	2027	1	3	March    	10	9	2	Tuesday  
799	2027-03-10	2027	1	3	March    	10	10	3	Wednesday
800	2027-03-11	2027	1	3	March    	10	11	4	Thursday 
801	2027-03-12	2027	1	3	March    	10	12	5	Friday   
802	2027-03-13	2027	1	3	March    	10	13	6	Saturday 
803	2027-03-14	2027	1	3	March    	10	14	0	Sunday   
804	2027-03-15	2027	1	3	March    	11	15	1	Monday   
805	2027-03-16	2027	1	3	March    	11	16	2	Tuesday  
806	2027-03-17	2027	1	3	March    	11	17	3	Wednesday
807	2027-03-18	2027	1	3	March    	11	18	4	Thursday 
808	2027-03-19	2027	1	3	March    	11	19	5	Friday   
809	2027-03-20	2027	1	3	March    	11	20	6	Saturday 
810	2027-03-21	2027	1	3	March    	11	21	0	Sunday   
811	2027-03-22	2027	1	3	March    	12	22	1	Monday   
812	2027-03-23	2027	1	3	March    	12	23	2	Tuesday  
813	2027-03-24	2027	1	3	March    	12	24	3	Wednesday
814	2027-03-25	2027	1	3	March    	12	25	4	Thursday 
815	2027-03-26	2027	1	3	March    	12	26	5	Friday   
816	2027-03-27	2027	1	3	March    	12	27	6	Saturday 
817	2027-03-28	2027	1	3	March    	12	28	0	Sunday   
818	2027-03-29	2027	1	3	March    	13	29	1	Monday   
819	2027-03-30	2027	1	3	March    	13	30	2	Tuesday  
820	2027-03-31	2027	1	3	March    	13	31	3	Wednesday
821	2027-04-01	2027	2	4	April    	13	1	4	Thursday 
822	2027-04-02	2027	2	4	April    	13	2	5	Friday   
823	2027-04-03	2027	2	4	April    	13	3	6	Saturday 
824	2027-04-04	2027	2	4	April    	13	4	0	Sunday   
825	2027-04-05	2027	2	4	April    	14	5	1	Monday   
826	2027-04-06	2027	2	4	April    	14	6	2	Tuesday  
827	2027-04-07	2027	2	4	April    	14	7	3	Wednesday
828	2027-04-08	2027	2	4	April    	14	8	4	Thursday 
829	2027-04-09	2027	2	4	April    	14	9	5	Friday   
830	2027-04-10	2027	2	4	April    	14	10	6	Saturday 
831	2027-04-11	2027	2	4	April    	14	11	0	Sunday   
832	2027-04-12	2027	2	4	April    	15	12	1	Monday   
833	2027-04-13	2027	2	4	April    	15	13	2	Tuesday  
834	2027-04-14	2027	2	4	April    	15	14	3	Wednesday
835	2027-04-15	2027	2	4	April    	15	15	4	Thursday 
836	2027-04-16	2027	2	4	April    	15	16	5	Friday   
837	2027-04-17	2027	2	4	April    	15	17	6	Saturday 
838	2027-04-18	2027	2	4	April    	15	18	0	Sunday   
839	2027-04-19	2027	2	4	April    	16	19	1	Monday   
840	2027-04-20	2027	2	4	April    	16	20	2	Tuesday  
841	2027-04-21	2027	2	4	April    	16	21	3	Wednesday
842	2027-04-22	2027	2	4	April    	16	22	4	Thursday 
843	2027-04-23	2027	2	4	April    	16	23	5	Friday   
844	2027-04-24	2027	2	4	April    	16	24	6	Saturday 
845	2027-04-25	2027	2	4	April    	16	25	0	Sunday   
846	2027-04-26	2027	2	4	April    	17	26	1	Monday   
847	2027-04-27	2027	2	4	April    	17	27	2	Tuesday  
848	2027-04-28	2027	2	4	April    	17	28	3	Wednesday
849	2027-04-29	2027	2	4	April    	17	29	4	Thursday 
850	2027-04-30	2027	2	4	April    	17	30	5	Friday   
851	2027-05-01	2027	2	5	May      	17	1	6	Saturday 
852	2027-05-02	2027	2	5	May      	17	2	0	Sunday   
853	2027-05-03	2027	2	5	May      	18	3	1	Monday   
854	2027-05-04	2027	2	5	May      	18	4	2	Tuesday  
855	2027-05-05	2027	2	5	May      	18	5	3	Wednesday
856	2027-05-06	2027	2	5	May      	18	6	4	Thursday 
857	2027-05-07	2027	2	5	May      	18	7	5	Friday   
858	2027-05-08	2027	2	5	May      	18	8	6	Saturday 
859	2027-05-09	2027	2	5	May      	18	9	0	Sunday   
860	2027-05-10	2027	2	5	May      	19	10	1	Monday   
861	2027-05-11	2027	2	5	May      	19	11	2	Tuesday  
862	2027-05-12	2027	2	5	May      	19	12	3	Wednesday
863	2027-05-13	2027	2	5	May      	19	13	4	Thursday 
864	2027-05-14	2027	2	5	May      	19	14	5	Friday   
865	2027-05-15	2027	2	5	May      	19	15	6	Saturday 
866	2027-05-16	2027	2	5	May      	19	16	0	Sunday   
867	2027-05-17	2027	2	5	May      	20	17	1	Monday   
868	2027-05-18	2027	2	5	May      	20	18	2	Tuesday  
869	2027-05-19	2027	2	5	May      	20	19	3	Wednesday
870	2027-05-20	2027	2	5	May      	20	20	4	Thursday 
871	2027-05-21	2027	2	5	May      	20	21	5	Friday   
872	2027-05-22	2027	2	5	May      	20	22	6	Saturday 
873	2027-05-23	2027	2	5	May      	20	23	0	Sunday   
874	2027-05-24	2027	2	5	May      	21	24	1	Monday   
875	2027-05-25	2027	2	5	May      	21	25	2	Tuesday  
876	2027-05-26	2027	2	5	May      	21	26	3	Wednesday
877	2027-05-27	2027	2	5	May      	21	27	4	Thursday 
878	2027-05-28	2027	2	5	May      	21	28	5	Friday   
879	2027-05-29	2027	2	5	May      	21	29	6	Saturday 
880	2027-05-30	2027	2	5	May      	21	30	0	Sunday   
881	2027-05-31	2027	2	5	May      	22	31	1	Monday   
882	2027-06-01	2027	2	6	June     	22	1	2	Tuesday  
883	2027-06-02	2027	2	6	June     	22	2	3	Wednesday
884	2027-06-03	2027	2	6	June     	22	3	4	Thursday 
885	2027-06-04	2027	2	6	June     	22	4	5	Friday   
886	2027-06-05	2027	2	6	June     	22	5	6	Saturday 
887	2027-06-06	2027	2	6	June     	22	6	0	Sunday   
888	2027-06-07	2027	2	6	June     	23	7	1	Monday   
889	2027-06-08	2027	2	6	June     	23	8	2	Tuesday  
890	2027-06-09	2027	2	6	June     	23	9	3	Wednesday
891	2027-06-10	2027	2	6	June     	23	10	4	Thursday 
892	2027-06-11	2027	2	6	June     	23	11	5	Friday   
893	2027-06-12	2027	2	6	June     	23	12	6	Saturday 
894	2027-06-13	2027	2	6	June     	23	13	0	Sunday   
895	2027-06-14	2027	2	6	June     	24	14	1	Monday   
896	2027-06-15	2027	2	6	June     	24	15	2	Tuesday  
897	2027-06-16	2027	2	6	June     	24	16	3	Wednesday
898	2027-06-17	2027	2	6	June     	24	17	4	Thursday 
899	2027-06-18	2027	2	6	June     	24	18	5	Friday   
900	2027-06-19	2027	2	6	June     	24	19	6	Saturday 
901	2027-06-20	2027	2	6	June     	24	20	0	Sunday   
902	2027-06-21	2027	2	6	June     	25	21	1	Monday   
903	2027-06-22	2027	2	6	June     	25	22	2	Tuesday  
904	2027-06-23	2027	2	6	June     	25	23	3	Wednesday
905	2027-06-24	2027	2	6	June     	25	24	4	Thursday 
906	2027-06-25	2027	2	6	June     	25	25	5	Friday   
907	2027-06-26	2027	2	6	June     	25	26	6	Saturday 
908	2027-06-27	2027	2	6	June     	25	27	0	Sunday   
909	2027-06-28	2027	2	6	June     	26	28	1	Monday   
910	2027-06-29	2027	2	6	June     	26	29	2	Tuesday  
911	2027-06-30	2027	2	6	June     	26	30	3	Wednesday
912	2027-07-01	2027	3	7	July     	26	1	4	Thursday 
913	2027-07-02	2027	3	7	July     	26	2	5	Friday   
914	2027-07-03	2027	3	7	July     	26	3	6	Saturday 
915	2027-07-04	2027	3	7	July     	26	4	0	Sunday   
916	2027-07-05	2027	3	7	July     	27	5	1	Monday   
917	2027-07-06	2027	3	7	July     	27	6	2	Tuesday  
918	2027-07-07	2027	3	7	July     	27	7	3	Wednesday
919	2027-07-08	2027	3	7	July     	27	8	4	Thursday 
920	2027-07-09	2027	3	7	July     	27	9	5	Friday   
921	2027-07-10	2027	3	7	July     	27	10	6	Saturday 
922	2027-07-11	2027	3	7	July     	27	11	0	Sunday   
923	2027-07-12	2027	3	7	July     	28	12	1	Monday   
924	2027-07-13	2027	3	7	July     	28	13	2	Tuesday  
925	2027-07-14	2027	3	7	July     	28	14	3	Wednesday
926	2027-07-15	2027	3	7	July     	28	15	4	Thursday 
927	2027-07-16	2027	3	7	July     	28	16	5	Friday   
928	2027-07-17	2027	3	7	July     	28	17	6	Saturday 
929	2027-07-18	2027	3	7	July     	28	18	0	Sunday   
930	2027-07-19	2027	3	7	July     	29	19	1	Monday   
931	2027-07-20	2027	3	7	July     	29	20	2	Tuesday  
932	2027-07-21	2027	3	7	July     	29	21	3	Wednesday
933	2027-07-22	2027	3	7	July     	29	22	4	Thursday 
934	2027-07-23	2027	3	7	July     	29	23	5	Friday   
935	2027-07-24	2027	3	7	July     	29	24	6	Saturday 
936	2027-07-25	2027	3	7	July     	29	25	0	Sunday   
937	2027-07-26	2027	3	7	July     	30	26	1	Monday   
938	2027-07-27	2027	3	7	July     	30	27	2	Tuesday  
939	2027-07-28	2027	3	7	July     	30	28	3	Wednesday
940	2027-07-29	2027	3	7	July     	30	29	4	Thursday 
941	2027-07-30	2027	3	7	July     	30	30	5	Friday   
942	2027-07-31	2027	3	7	July     	30	31	6	Saturday 
943	2027-08-01	2027	3	8	August   	30	1	0	Sunday   
944	2027-08-02	2027	3	8	August   	31	2	1	Monday   
945	2027-08-03	2027	3	8	August   	31	3	2	Tuesday  
946	2027-08-04	2027	3	8	August   	31	4	3	Wednesday
947	2027-08-05	2027	3	8	August   	31	5	4	Thursday 
948	2027-08-06	2027	3	8	August   	31	6	5	Friday   
949	2027-08-07	2027	3	8	August   	31	7	6	Saturday 
950	2027-08-08	2027	3	8	August   	31	8	0	Sunday   
951	2027-08-09	2027	3	8	August   	32	9	1	Monday   
952	2027-08-10	2027	3	8	August   	32	10	2	Tuesday  
953	2027-08-11	2027	3	8	August   	32	11	3	Wednesday
954	2027-08-12	2027	3	8	August   	32	12	4	Thursday 
955	2027-08-13	2027	3	8	August   	32	13	5	Friday   
956	2027-08-14	2027	3	8	August   	32	14	6	Saturday 
957	2027-08-15	2027	3	8	August   	32	15	0	Sunday   
958	2027-08-16	2027	3	8	August   	33	16	1	Monday   
959	2027-08-17	2027	3	8	August   	33	17	2	Tuesday  
960	2027-08-18	2027	3	8	August   	33	18	3	Wednesday
961	2027-08-19	2027	3	8	August   	33	19	4	Thursday 
962	2027-08-20	2027	3	8	August   	33	20	5	Friday   
963	2027-08-21	2027	3	8	August   	33	21	6	Saturday 
964	2027-08-22	2027	3	8	August   	33	22	0	Sunday   
965	2027-08-23	2027	3	8	August   	34	23	1	Monday   
966	2027-08-24	2027	3	8	August   	34	24	2	Tuesday  
967	2027-08-25	2027	3	8	August   	34	25	3	Wednesday
968	2027-08-26	2027	3	8	August   	34	26	4	Thursday 
969	2027-08-27	2027	3	8	August   	34	27	5	Friday   
970	2027-08-28	2027	3	8	August   	34	28	6	Saturday 
971	2027-08-29	2027	3	8	August   	34	29	0	Sunday   
972	2027-08-30	2027	3	8	August   	35	30	1	Monday   
973	2027-08-31	2027	3	8	August   	35	31	2	Tuesday  
974	2027-09-01	2027	3	9	September	35	1	3	Wednesday
975	2027-09-02	2027	3	9	September	35	2	4	Thursday 
976	2027-09-03	2027	3	9	September	35	3	5	Friday   
977	2027-09-04	2027	3	9	September	35	4	6	Saturday 
978	2027-09-05	2027	3	9	September	35	5	0	Sunday   
979	2027-09-06	2027	3	9	September	36	6	1	Monday   
980	2027-09-07	2027	3	9	September	36	7	2	Tuesday  
981	2027-09-08	2027	3	9	September	36	8	3	Wednesday
982	2027-09-09	2027	3	9	September	36	9	4	Thursday 
983	2027-09-10	2027	3	9	September	36	10	5	Friday   
984	2027-09-11	2027	3	9	September	36	11	6	Saturday 
985	2027-09-12	2027	3	9	September	36	12	0	Sunday   
986	2027-09-13	2027	3	9	September	37	13	1	Monday   
987	2027-09-14	2027	3	9	September	37	14	2	Tuesday  
988	2027-09-15	2027	3	9	September	37	15	3	Wednesday
989	2027-09-16	2027	3	9	September	37	16	4	Thursday 
990	2027-09-17	2027	3	9	September	37	17	5	Friday   
991	2027-09-18	2027	3	9	September	37	18	6	Saturday 
992	2027-09-19	2027	3	9	September	37	19	0	Sunday   
993	2027-09-20	2027	3	9	September	38	20	1	Monday   
994	2027-09-21	2027	3	9	September	38	21	2	Tuesday  
995	2027-09-22	2027	3	9	September	38	22	3	Wednesday
996	2027-09-23	2027	3	9	September	38	23	4	Thursday 
997	2027-09-24	2027	3	9	September	38	24	5	Friday   
998	2027-09-25	2027	3	9	September	38	25	6	Saturday 
999	2027-09-26	2027	3	9	September	38	26	0	Sunday   
1000	2027-09-27	2027	3	9	September	39	27	1	Monday   
1001	2027-09-28	2027	3	9	September	39	28	2	Tuesday  
1002	2027-09-29	2027	3	9	September	39	29	3	Wednesday
1003	2027-09-30	2027	3	9	September	39	30	4	Thursday 
1004	2027-10-01	2027	4	10	October  	39	1	5	Friday   
1005	2027-10-02	2027	4	10	October  	39	2	6	Saturday 
1006	2027-10-03	2027	4	10	October  	39	3	0	Sunday   
1007	2027-10-04	2027	4	10	October  	40	4	1	Monday   
1008	2027-10-05	2027	4	10	October  	40	5	2	Tuesday  
1009	2027-10-06	2027	4	10	October  	40	6	3	Wednesday
1010	2027-10-07	2027	4	10	October  	40	7	4	Thursday 
1011	2027-10-08	2027	4	10	October  	40	8	5	Friday   
1012	2027-10-09	2027	4	10	October  	40	9	6	Saturday 
1013	2027-10-10	2027	4	10	October  	40	10	0	Sunday   
1014	2027-10-11	2027	4	10	October  	41	11	1	Monday   
1015	2027-10-12	2027	4	10	October  	41	12	2	Tuesday  
1016	2027-10-13	2027	4	10	October  	41	13	3	Wednesday
1017	2027-10-14	2027	4	10	October  	41	14	4	Thursday 
1018	2027-10-15	2027	4	10	October  	41	15	5	Friday   
1019	2027-10-16	2027	4	10	October  	41	16	6	Saturday 
1020	2027-10-17	2027	4	10	October  	41	17	0	Sunday   
1021	2027-10-18	2027	4	10	October  	42	18	1	Monday   
1022	2027-10-19	2027	4	10	October  	42	19	2	Tuesday  
1023	2027-10-20	2027	4	10	October  	42	20	3	Wednesday
1024	2027-10-21	2027	4	10	October  	42	21	4	Thursday 
1025	2027-10-22	2027	4	10	October  	42	22	5	Friday   
1026	2027-10-23	2027	4	10	October  	42	23	6	Saturday 
1027	2027-10-24	2027	4	10	October  	42	24	0	Sunday   
1028	2027-10-25	2027	4	10	October  	43	25	1	Monday   
1029	2027-10-26	2027	4	10	October  	43	26	2	Tuesday  
1030	2027-10-27	2027	4	10	October  	43	27	3	Wednesday
1031	2027-10-28	2027	4	10	October  	43	28	4	Thursday 
1032	2027-10-29	2027	4	10	October  	43	29	5	Friday   
1033	2027-10-30	2027	4	10	October  	43	30	6	Saturday 
1034	2027-10-31	2027	4	10	October  	43	31	0	Sunday   
1035	2027-11-01	2027	4	11	November 	44	1	1	Monday   
1036	2027-11-02	2027	4	11	November 	44	2	2	Tuesday  
1037	2027-11-03	2027	4	11	November 	44	3	3	Wednesday
1038	2027-11-04	2027	4	11	November 	44	4	4	Thursday 
1039	2027-11-05	2027	4	11	November 	44	5	5	Friday   
1040	2027-11-06	2027	4	11	November 	44	6	6	Saturday 
1041	2027-11-07	2027	4	11	November 	44	7	0	Sunday   
1042	2027-11-08	2027	4	11	November 	45	8	1	Monday   
1043	2027-11-09	2027	4	11	November 	45	9	2	Tuesday  
1044	2027-11-10	2027	4	11	November 	45	10	3	Wednesday
1045	2027-11-11	2027	4	11	November 	45	11	4	Thursday 
1046	2027-11-12	2027	4	11	November 	45	12	5	Friday   
1047	2027-11-13	2027	4	11	November 	45	13	6	Saturday 
1048	2027-11-14	2027	4	11	November 	45	14	0	Sunday   
1049	2027-11-15	2027	4	11	November 	46	15	1	Monday   
1050	2027-11-16	2027	4	11	November 	46	16	2	Tuesday  
1051	2027-11-17	2027	4	11	November 	46	17	3	Wednesday
1052	2027-11-18	2027	4	11	November 	46	18	4	Thursday 
1053	2027-11-19	2027	4	11	November 	46	19	5	Friday   
1054	2027-11-20	2027	4	11	November 	46	20	6	Saturday 
1055	2027-11-21	2027	4	11	November 	46	21	0	Sunday   
1056	2027-11-22	2027	4	11	November 	47	22	1	Monday   
1057	2027-11-23	2027	4	11	November 	47	23	2	Tuesday  
1058	2027-11-24	2027	4	11	November 	47	24	3	Wednesday
1059	2027-11-25	2027	4	11	November 	47	25	4	Thursday 
1060	2027-11-26	2027	4	11	November 	47	26	5	Friday   
1061	2027-11-27	2027	4	11	November 	47	27	6	Saturday 
1062	2027-11-28	2027	4	11	November 	47	28	0	Sunday   
1063	2027-11-29	2027	4	11	November 	48	29	1	Monday   
1064	2027-11-30	2027	4	11	November 	48	30	2	Tuesday  
1065	2027-12-01	2027	4	12	December 	48	1	3	Wednesday
1066	2027-12-02	2027	4	12	December 	48	2	4	Thursday 
1067	2027-12-03	2027	4	12	December 	48	3	5	Friday   
1068	2027-12-04	2027	4	12	December 	48	4	6	Saturday 
1069	2027-12-05	2027	4	12	December 	48	5	0	Sunday   
1070	2027-12-06	2027	4	12	December 	49	6	1	Monday   
1071	2027-12-07	2027	4	12	December 	49	7	2	Tuesday  
1072	2027-12-08	2027	4	12	December 	49	8	3	Wednesday
1073	2027-12-09	2027	4	12	December 	49	9	4	Thursday 
1074	2027-12-10	2027	4	12	December 	49	10	5	Friday   
1075	2027-12-11	2027	4	12	December 	49	11	6	Saturday 
1076	2027-12-12	2027	4	12	December 	49	12	0	Sunday   
1077	2027-12-13	2027	4	12	December 	50	13	1	Monday   
1078	2027-12-14	2027	4	12	December 	50	14	2	Tuesday  
1079	2027-12-15	2027	4	12	December 	50	15	3	Wednesday
1080	2027-12-16	2027	4	12	December 	50	16	4	Thursday 
1081	2027-12-17	2027	4	12	December 	50	17	5	Friday   
1082	2027-12-18	2027	4	12	December 	50	18	6	Saturday 
1083	2027-12-19	2027	4	12	December 	50	19	0	Sunday   
1084	2027-12-20	2027	4	12	December 	51	20	1	Monday   
1085	2027-12-21	2027	4	12	December 	51	21	2	Tuesday  
1086	2027-12-22	2027	4	12	December 	51	22	3	Wednesday
1087	2027-12-23	2027	4	12	December 	51	23	4	Thursday 
1088	2027-12-24	2027	4	12	December 	51	24	5	Friday   
1089	2027-12-25	2027	4	12	December 	51	25	6	Saturday 
1090	2027-12-26	2027	4	12	December 	51	26	0	Sunday   
1091	2027-12-27	2027	4	12	December 	52	27	1	Monday   
1092	2027-12-28	2027	4	12	December 	52	28	2	Tuesday  
1093	2027-12-29	2027	4	12	December 	52	29	3	Wednesday
1094	2027-12-30	2027	4	12	December 	52	30	4	Thursday 
1095	2027-12-31	2027	4	12	December 	52	31	5	Friday   
1096	2028-01-01	2028	1	1	January  	52	1	6	Saturday 
1097	2028-01-02	2028	1	1	January  	52	2	0	Sunday   
1098	2028-01-03	2028	1	1	January  	1	3	1	Monday   
1099	2028-01-04	2028	1	1	January  	1	4	2	Tuesday  
1100	2028-01-05	2028	1	1	January  	1	5	3	Wednesday
1101	2028-01-06	2028	1	1	January  	1	6	4	Thursday 
1102	2028-01-07	2028	1	1	January  	1	7	5	Friday   
1103	2028-01-08	2028	1	1	January  	1	8	6	Saturday 
1104	2028-01-09	2028	1	1	January  	1	9	0	Sunday   
1105	2028-01-10	2028	1	1	January  	2	10	1	Monday   
1106	2028-01-11	2028	1	1	January  	2	11	2	Tuesday  
1107	2028-01-12	2028	1	1	January  	2	12	3	Wednesday
1108	2028-01-13	2028	1	1	January  	2	13	4	Thursday 
1109	2028-01-14	2028	1	1	January  	2	14	5	Friday   
1110	2028-01-15	2028	1	1	January  	2	15	6	Saturday 
1111	2028-01-16	2028	1	1	January  	2	16	0	Sunday   
1112	2028-01-17	2028	1	1	January  	3	17	1	Monday   
1113	2028-01-18	2028	1	1	January  	3	18	2	Tuesday  
1114	2028-01-19	2028	1	1	January  	3	19	3	Wednesday
1115	2028-01-20	2028	1	1	January  	3	20	4	Thursday 
1116	2028-01-21	2028	1	1	January  	3	21	5	Friday   
1117	2028-01-22	2028	1	1	January  	3	22	6	Saturday 
1118	2028-01-23	2028	1	1	January  	3	23	0	Sunday   
1119	2028-01-24	2028	1	1	January  	4	24	1	Monday   
1120	2028-01-25	2028	1	1	January  	4	25	2	Tuesday  
1121	2028-01-26	2028	1	1	January  	4	26	3	Wednesday
1122	2028-01-27	2028	1	1	January  	4	27	4	Thursday 
1123	2028-01-28	2028	1	1	January  	4	28	5	Friday   
1124	2028-01-29	2028	1	1	January  	4	29	6	Saturday 
1125	2028-01-30	2028	1	1	January  	4	30	0	Sunday   
1126	2028-01-31	2028	1	1	January  	5	31	1	Monday   
1127	2028-02-01	2028	1	2	February 	5	1	2	Tuesday  
1128	2028-02-02	2028	1	2	February 	5	2	3	Wednesday
1129	2028-02-03	2028	1	2	February 	5	3	4	Thursday 
1130	2028-02-04	2028	1	2	February 	5	4	5	Friday   
1131	2028-02-05	2028	1	2	February 	5	5	6	Saturday 
1132	2028-02-06	2028	1	2	February 	5	6	0	Sunday   
1133	2028-02-07	2028	1	2	February 	6	7	1	Monday   
1134	2028-02-08	2028	1	2	February 	6	8	2	Tuesday  
1135	2028-02-09	2028	1	2	February 	6	9	3	Wednesday
1136	2028-02-10	2028	1	2	February 	6	10	4	Thursday 
1137	2028-02-11	2028	1	2	February 	6	11	5	Friday   
1138	2028-02-12	2028	1	2	February 	6	12	6	Saturday 
1139	2028-02-13	2028	1	2	February 	6	13	0	Sunday   
1140	2028-02-14	2028	1	2	February 	7	14	1	Monday   
1141	2028-02-15	2028	1	2	February 	7	15	2	Tuesday  
1142	2028-02-16	2028	1	2	February 	7	16	3	Wednesday
1143	2028-02-17	2028	1	2	February 	7	17	4	Thursday 
1144	2028-02-18	2028	1	2	February 	7	18	5	Friday   
1145	2028-02-19	2028	1	2	February 	7	19	6	Saturday 
1146	2028-02-20	2028	1	2	February 	7	20	0	Sunday   
1147	2028-02-21	2028	1	2	February 	8	21	1	Monday   
1148	2028-02-22	2028	1	2	February 	8	22	2	Tuesday  
1149	2028-02-23	2028	1	2	February 	8	23	3	Wednesday
1150	2028-02-24	2028	1	2	February 	8	24	4	Thursday 
1151	2028-02-25	2028	1	2	February 	8	25	5	Friday   
1152	2028-02-26	2028	1	2	February 	8	26	6	Saturday 
1153	2028-02-27	2028	1	2	February 	8	27	0	Sunday   
1154	2028-02-28	2028	1	2	February 	9	28	1	Monday   
1155	2028-02-29	2028	1	2	February 	9	29	2	Tuesday  
1156	2028-03-01	2028	1	3	March    	9	1	3	Wednesday
1157	2028-03-02	2028	1	3	March    	9	2	4	Thursday 
1158	2028-03-03	2028	1	3	March    	9	3	5	Friday   
1159	2028-03-04	2028	1	3	March    	9	4	6	Saturday 
1160	2028-03-05	2028	1	3	March    	9	5	0	Sunday   
1161	2028-03-06	2028	1	3	March    	10	6	1	Monday   
1162	2028-03-07	2028	1	3	March    	10	7	2	Tuesday  
1163	2028-03-08	2028	1	3	March    	10	8	3	Wednesday
1164	2028-03-09	2028	1	3	March    	10	9	4	Thursday 
1165	2028-03-10	2028	1	3	March    	10	10	5	Friday   
1166	2028-03-11	2028	1	3	March    	10	11	6	Saturday 
1167	2028-03-12	2028	1	3	March    	10	12	0	Sunday   
1168	2028-03-13	2028	1	3	March    	11	13	1	Monday   
1169	2028-03-14	2028	1	3	March    	11	14	2	Tuesday  
1170	2028-03-15	2028	1	3	March    	11	15	3	Wednesday
1171	2028-03-16	2028	1	3	March    	11	16	4	Thursday 
1172	2028-03-17	2028	1	3	March    	11	17	5	Friday   
1173	2028-03-18	2028	1	3	March    	11	18	6	Saturday 
1174	2028-03-19	2028	1	3	March    	11	19	0	Sunday   
1175	2028-03-20	2028	1	3	March    	12	20	1	Monday   
1176	2028-03-21	2028	1	3	March    	12	21	2	Tuesday  
1177	2028-03-22	2028	1	3	March    	12	22	3	Wednesday
1178	2028-03-23	2028	1	3	March    	12	23	4	Thursday 
1179	2028-03-24	2028	1	3	March    	12	24	5	Friday   
1180	2028-03-25	2028	1	3	March    	12	25	6	Saturday 
1181	2028-03-26	2028	1	3	March    	12	26	0	Sunday   
1182	2028-03-27	2028	1	3	March    	13	27	1	Monday   
1183	2028-03-28	2028	1	3	March    	13	28	2	Tuesday  
1184	2028-03-29	2028	1	3	March    	13	29	3	Wednesday
1185	2028-03-30	2028	1	3	March    	13	30	4	Thursday 
1186	2028-03-31	2028	1	3	March    	13	31	5	Friday   
1187	2028-04-01	2028	2	4	April    	13	1	6	Saturday 
1188	2028-04-02	2028	2	4	April    	13	2	0	Sunday   
1189	2028-04-03	2028	2	4	April    	14	3	1	Monday   
1190	2028-04-04	2028	2	4	April    	14	4	2	Tuesday  
1191	2028-04-05	2028	2	4	April    	14	5	3	Wednesday
1192	2028-04-06	2028	2	4	April    	14	6	4	Thursday 
1193	2028-04-07	2028	2	4	April    	14	7	5	Friday   
1194	2028-04-08	2028	2	4	April    	14	8	6	Saturday 
1195	2028-04-09	2028	2	4	April    	14	9	0	Sunday   
1196	2028-04-10	2028	2	4	April    	15	10	1	Monday   
1197	2028-04-11	2028	2	4	April    	15	11	2	Tuesday  
1198	2028-04-12	2028	2	4	April    	15	12	3	Wednesday
1199	2028-04-13	2028	2	4	April    	15	13	4	Thursday 
1200	2028-04-14	2028	2	4	April    	15	14	5	Friday   
1201	2028-04-15	2028	2	4	April    	15	15	6	Saturday 
1202	2028-04-16	2028	2	4	April    	15	16	0	Sunday   
1203	2028-04-17	2028	2	4	April    	16	17	1	Monday   
1204	2028-04-18	2028	2	4	April    	16	18	2	Tuesday  
1205	2028-04-19	2028	2	4	April    	16	19	3	Wednesday
1206	2028-04-20	2028	2	4	April    	16	20	4	Thursday 
1207	2028-04-21	2028	2	4	April    	16	21	5	Friday   
1208	2028-04-22	2028	2	4	April    	16	22	6	Saturday 
1209	2028-04-23	2028	2	4	April    	16	23	0	Sunday   
1210	2028-04-24	2028	2	4	April    	17	24	1	Monday   
1211	2028-04-25	2028	2	4	April    	17	25	2	Tuesday  
1212	2028-04-26	2028	2	4	April    	17	26	3	Wednesday
1213	2028-04-27	2028	2	4	April    	17	27	4	Thursday 
1214	2028-04-28	2028	2	4	April    	17	28	5	Friday   
1215	2028-04-29	2028	2	4	April    	17	29	6	Saturday 
1216	2028-04-30	2028	2	4	April    	17	30	0	Sunday   
1217	2028-05-01	2028	2	5	May      	18	1	1	Monday   
1218	2028-05-02	2028	2	5	May      	18	2	2	Tuesday  
1219	2028-05-03	2028	2	5	May      	18	3	3	Wednesday
1220	2028-05-04	2028	2	5	May      	18	4	4	Thursday 
1221	2028-05-05	2028	2	5	May      	18	5	5	Friday   
1222	2028-05-06	2028	2	5	May      	18	6	6	Saturday 
1223	2028-05-07	2028	2	5	May      	18	7	0	Sunday   
1224	2028-05-08	2028	2	5	May      	19	8	1	Monday   
1225	2028-05-09	2028	2	5	May      	19	9	2	Tuesday  
1226	2028-05-10	2028	2	5	May      	19	10	3	Wednesday
1227	2028-05-11	2028	2	5	May      	19	11	4	Thursday 
1228	2028-05-12	2028	2	5	May      	19	12	5	Friday   
1229	2028-05-13	2028	2	5	May      	19	13	6	Saturday 
1230	2028-05-14	2028	2	5	May      	19	14	0	Sunday   
1231	2028-05-15	2028	2	5	May      	20	15	1	Monday   
1232	2028-05-16	2028	2	5	May      	20	16	2	Tuesday  
1233	2028-05-17	2028	2	5	May      	20	17	3	Wednesday
1234	2028-05-18	2028	2	5	May      	20	18	4	Thursday 
1235	2028-05-19	2028	2	5	May      	20	19	5	Friday   
1236	2028-05-20	2028	2	5	May      	20	20	6	Saturday 
1237	2028-05-21	2028	2	5	May      	20	21	0	Sunday   
1238	2028-05-22	2028	2	5	May      	21	22	1	Monday   
1239	2028-05-23	2028	2	5	May      	21	23	2	Tuesday  
1240	2028-05-24	2028	2	5	May      	21	24	3	Wednesday
1241	2028-05-25	2028	2	5	May      	21	25	4	Thursday 
1242	2028-05-26	2028	2	5	May      	21	26	5	Friday   
1243	2028-05-27	2028	2	5	May      	21	27	6	Saturday 
1244	2028-05-28	2028	2	5	May      	21	28	0	Sunday   
1245	2028-05-29	2028	2	5	May      	22	29	1	Monday   
1246	2028-05-30	2028	2	5	May      	22	30	2	Tuesday  
1247	2028-05-31	2028	2	5	May      	22	31	3	Wednesday
1248	2028-06-01	2028	2	6	June     	22	1	4	Thursday 
1249	2028-06-02	2028	2	6	June     	22	2	5	Friday   
1250	2028-06-03	2028	2	6	June     	22	3	6	Saturday 
1251	2028-06-04	2028	2	6	June     	22	4	0	Sunday   
1252	2028-06-05	2028	2	6	June     	23	5	1	Monday   
1253	2028-06-06	2028	2	6	June     	23	6	2	Tuesday  
1254	2028-06-07	2028	2	6	June     	23	7	3	Wednesday
1255	2028-06-08	2028	2	6	June     	23	8	4	Thursday 
1256	2028-06-09	2028	2	6	June     	23	9	5	Friday   
1257	2028-06-10	2028	2	6	June     	23	10	6	Saturday 
1258	2028-06-11	2028	2	6	June     	23	11	0	Sunday   
1259	2028-06-12	2028	2	6	June     	24	12	1	Monday   
1260	2028-06-13	2028	2	6	June     	24	13	2	Tuesday  
1261	2028-06-14	2028	2	6	June     	24	14	3	Wednesday
1262	2028-06-15	2028	2	6	June     	24	15	4	Thursday 
1263	2028-06-16	2028	2	6	June     	24	16	5	Friday   
1264	2028-06-17	2028	2	6	June     	24	17	6	Saturday 
1265	2028-06-18	2028	2	6	June     	24	18	0	Sunday   
1266	2028-06-19	2028	2	6	June     	25	19	1	Monday   
1267	2028-06-20	2028	2	6	June     	25	20	2	Tuesday  
1268	2028-06-21	2028	2	6	June     	25	21	3	Wednesday
1269	2028-06-22	2028	2	6	June     	25	22	4	Thursday 
1270	2028-06-23	2028	2	6	June     	25	23	5	Friday   
1271	2028-06-24	2028	2	6	June     	25	24	6	Saturday 
1272	2028-06-25	2028	2	6	June     	25	25	0	Sunday   
1273	2028-06-26	2028	2	6	June     	26	26	1	Monday   
1274	2028-06-27	2028	2	6	June     	26	27	2	Tuesday  
1275	2028-06-28	2028	2	6	June     	26	28	3	Wednesday
1276	2028-06-29	2028	2	6	June     	26	29	4	Thursday 
1277	2028-06-30	2028	2	6	June     	26	30	5	Friday   
1278	2028-07-01	2028	3	7	July     	26	1	6	Saturday 
1279	2028-07-02	2028	3	7	July     	26	2	0	Sunday   
1280	2028-07-03	2028	3	7	July     	27	3	1	Monday   
1281	2028-07-04	2028	3	7	July     	27	4	2	Tuesday  
1282	2028-07-05	2028	3	7	July     	27	5	3	Wednesday
1283	2028-07-06	2028	3	7	July     	27	6	4	Thursday 
1284	2028-07-07	2028	3	7	July     	27	7	5	Friday   
1285	2028-07-08	2028	3	7	July     	27	8	6	Saturday 
1286	2028-07-09	2028	3	7	July     	27	9	0	Sunday   
1287	2028-07-10	2028	3	7	July     	28	10	1	Monday   
1288	2028-07-11	2028	3	7	July     	28	11	2	Tuesday  
1289	2028-07-12	2028	3	7	July     	28	12	3	Wednesday
1290	2028-07-13	2028	3	7	July     	28	13	4	Thursday 
1291	2028-07-14	2028	3	7	July     	28	14	5	Friday   
1292	2028-07-15	2028	3	7	July     	28	15	6	Saturday 
1293	2028-07-16	2028	3	7	July     	28	16	0	Sunday   
1294	2028-07-17	2028	3	7	July     	29	17	1	Monday   
1295	2028-07-18	2028	3	7	July     	29	18	2	Tuesday  
1296	2028-07-19	2028	3	7	July     	29	19	3	Wednesday
1297	2028-07-20	2028	3	7	July     	29	20	4	Thursday 
1298	2028-07-21	2028	3	7	July     	29	21	5	Friday   
1299	2028-07-22	2028	3	7	July     	29	22	6	Saturday 
1300	2028-07-23	2028	3	7	July     	29	23	0	Sunday   
1301	2028-07-24	2028	3	7	July     	30	24	1	Monday   
1302	2028-07-25	2028	3	7	July     	30	25	2	Tuesday  
1303	2028-07-26	2028	3	7	July     	30	26	3	Wednesday
1304	2028-07-27	2028	3	7	July     	30	27	4	Thursday 
1305	2028-07-28	2028	3	7	July     	30	28	5	Friday   
1306	2028-07-29	2028	3	7	July     	30	29	6	Saturday 
1307	2028-07-30	2028	3	7	July     	30	30	0	Sunday   
1308	2028-07-31	2028	3	7	July     	31	31	1	Monday   
1309	2028-08-01	2028	3	8	August   	31	1	2	Tuesday  
1310	2028-08-02	2028	3	8	August   	31	2	3	Wednesday
1311	2028-08-03	2028	3	8	August   	31	3	4	Thursday 
1312	2028-08-04	2028	3	8	August   	31	4	5	Friday   
1313	2028-08-05	2028	3	8	August   	31	5	6	Saturday 
1314	2028-08-06	2028	3	8	August   	31	6	0	Sunday   
1315	2028-08-07	2028	3	8	August   	32	7	1	Monday   
1316	2028-08-08	2028	3	8	August   	32	8	2	Tuesday  
1317	2028-08-09	2028	3	8	August   	32	9	3	Wednesday
1318	2028-08-10	2028	3	8	August   	32	10	4	Thursday 
1319	2028-08-11	2028	3	8	August   	32	11	5	Friday   
1320	2028-08-12	2028	3	8	August   	32	12	6	Saturday 
1321	2028-08-13	2028	3	8	August   	32	13	0	Sunday   
1322	2028-08-14	2028	3	8	August   	33	14	1	Monday   
1323	2028-08-15	2028	3	8	August   	33	15	2	Tuesday  
1324	2028-08-16	2028	3	8	August   	33	16	3	Wednesday
1325	2028-08-17	2028	3	8	August   	33	17	4	Thursday 
1326	2028-08-18	2028	3	8	August   	33	18	5	Friday   
1327	2028-08-19	2028	3	8	August   	33	19	6	Saturday 
1328	2028-08-20	2028	3	8	August   	33	20	0	Sunday   
1329	2028-08-21	2028	3	8	August   	34	21	1	Monday   
1330	2028-08-22	2028	3	8	August   	34	22	2	Tuesday  
1331	2028-08-23	2028	3	8	August   	34	23	3	Wednesday
1332	2028-08-24	2028	3	8	August   	34	24	4	Thursday 
1333	2028-08-25	2028	3	8	August   	34	25	5	Friday   
1334	2028-08-26	2028	3	8	August   	34	26	6	Saturday 
1335	2028-08-27	2028	3	8	August   	34	27	0	Sunday   
1336	2028-08-28	2028	3	8	August   	35	28	1	Monday   
1337	2028-08-29	2028	3	8	August   	35	29	2	Tuesday  
1338	2028-08-30	2028	3	8	August   	35	30	3	Wednesday
1339	2028-08-31	2028	3	8	August   	35	31	4	Thursday 
1340	2028-09-01	2028	3	9	September	35	1	5	Friday   
1341	2028-09-02	2028	3	9	September	35	2	6	Saturday 
1342	2028-09-03	2028	3	9	September	35	3	0	Sunday   
1343	2028-09-04	2028	3	9	September	36	4	1	Monday   
1344	2028-09-05	2028	3	9	September	36	5	2	Tuesday  
1345	2028-09-06	2028	3	9	September	36	6	3	Wednesday
1346	2028-09-07	2028	3	9	September	36	7	4	Thursday 
1347	2028-09-08	2028	3	9	September	36	8	5	Friday   
1348	2028-09-09	2028	3	9	September	36	9	6	Saturday 
1349	2028-09-10	2028	3	9	September	36	10	0	Sunday   
1350	2028-09-11	2028	3	9	September	37	11	1	Monday   
1351	2028-09-12	2028	3	9	September	37	12	2	Tuesday  
1352	2028-09-13	2028	3	9	September	37	13	3	Wednesday
1353	2028-09-14	2028	3	9	September	37	14	4	Thursday 
1354	2028-09-15	2028	3	9	September	37	15	5	Friday   
1355	2028-09-16	2028	3	9	September	37	16	6	Saturday 
1356	2028-09-17	2028	3	9	September	37	17	0	Sunday   
1357	2028-09-18	2028	3	9	September	38	18	1	Monday   
1358	2028-09-19	2028	3	9	September	38	19	2	Tuesday  
1359	2028-09-20	2028	3	9	September	38	20	3	Wednesday
1360	2028-09-21	2028	3	9	September	38	21	4	Thursday 
1361	2028-09-22	2028	3	9	September	38	22	5	Friday   
1362	2028-09-23	2028	3	9	September	38	23	6	Saturday 
1363	2028-09-24	2028	3	9	September	38	24	0	Sunday   
1364	2028-09-25	2028	3	9	September	39	25	1	Monday   
1365	2028-09-26	2028	3	9	September	39	26	2	Tuesday  
1366	2028-09-27	2028	3	9	September	39	27	3	Wednesday
1367	2028-09-28	2028	3	9	September	39	28	4	Thursday 
1368	2028-09-29	2028	3	9	September	39	29	5	Friday   
1369	2028-09-30	2028	3	9	September	39	30	6	Saturday 
1370	2028-10-01	2028	4	10	October  	39	1	0	Sunday   
1371	2028-10-02	2028	4	10	October  	40	2	1	Monday   
1372	2028-10-03	2028	4	10	October  	40	3	2	Tuesday  
1373	2028-10-04	2028	4	10	October  	40	4	3	Wednesday
1374	2028-10-05	2028	4	10	October  	40	5	4	Thursday 
1375	2028-10-06	2028	4	10	October  	40	6	5	Friday   
1376	2028-10-07	2028	4	10	October  	40	7	6	Saturday 
1377	2028-10-08	2028	4	10	October  	40	8	0	Sunday   
1378	2028-10-09	2028	4	10	October  	41	9	1	Monday   
1379	2028-10-10	2028	4	10	October  	41	10	2	Tuesday  
1380	2028-10-11	2028	4	10	October  	41	11	3	Wednesday
1381	2028-10-12	2028	4	10	October  	41	12	4	Thursday 
1382	2028-10-13	2028	4	10	October  	41	13	5	Friday   
1383	2028-10-14	2028	4	10	October  	41	14	6	Saturday 
1384	2028-10-15	2028	4	10	October  	41	15	0	Sunday   
1385	2028-10-16	2028	4	10	October  	42	16	1	Monday   
1386	2028-10-17	2028	4	10	October  	42	17	2	Tuesday  
1387	2028-10-18	2028	4	10	October  	42	18	3	Wednesday
1388	2028-10-19	2028	4	10	October  	42	19	4	Thursday 
1389	2028-10-20	2028	4	10	October  	42	20	5	Friday   
1390	2028-10-21	2028	4	10	October  	42	21	6	Saturday 
1391	2028-10-22	2028	4	10	October  	42	22	0	Sunday   
1392	2028-10-23	2028	4	10	October  	43	23	1	Monday   
1393	2028-10-24	2028	4	10	October  	43	24	2	Tuesday  
1394	2028-10-25	2028	4	10	October  	43	25	3	Wednesday
1395	2028-10-26	2028	4	10	October  	43	26	4	Thursday 
1396	2028-10-27	2028	4	10	October  	43	27	5	Friday   
1397	2028-10-28	2028	4	10	October  	43	28	6	Saturday 
1398	2028-10-29	2028	4	10	October  	43	29	0	Sunday   
1399	2028-10-30	2028	4	10	October  	44	30	1	Monday   
1400	2028-10-31	2028	4	10	October  	44	31	2	Tuesday  
1401	2028-11-01	2028	4	11	November 	44	1	3	Wednesday
1402	2028-11-02	2028	4	11	November 	44	2	4	Thursday 
1403	2028-11-03	2028	4	11	November 	44	3	5	Friday   
1404	2028-11-04	2028	4	11	November 	44	4	6	Saturday 
1405	2028-11-05	2028	4	11	November 	44	5	0	Sunday   
1406	2028-11-06	2028	4	11	November 	45	6	1	Monday   
1407	2028-11-07	2028	4	11	November 	45	7	2	Tuesday  
1408	2028-11-08	2028	4	11	November 	45	8	3	Wednesday
1409	2028-11-09	2028	4	11	November 	45	9	4	Thursday 
1410	2028-11-10	2028	4	11	November 	45	10	5	Friday   
1411	2028-11-11	2028	4	11	November 	45	11	6	Saturday 
1412	2028-11-12	2028	4	11	November 	45	12	0	Sunday   
1413	2028-11-13	2028	4	11	November 	46	13	1	Monday   
1414	2028-11-14	2028	4	11	November 	46	14	2	Tuesday  
1415	2028-11-15	2028	4	11	November 	46	15	3	Wednesday
1416	2028-11-16	2028	4	11	November 	46	16	4	Thursday 
1417	2028-11-17	2028	4	11	November 	46	17	5	Friday   
1418	2028-11-18	2028	4	11	November 	46	18	6	Saturday 
1419	2028-11-19	2028	4	11	November 	46	19	0	Sunday   
1420	2028-11-20	2028	4	11	November 	47	20	1	Monday   
1421	2028-11-21	2028	4	11	November 	47	21	2	Tuesday  
1422	2028-11-22	2028	4	11	November 	47	22	3	Wednesday
1423	2028-11-23	2028	4	11	November 	47	23	4	Thursday 
1424	2028-11-24	2028	4	11	November 	47	24	5	Friday   
1425	2028-11-25	2028	4	11	November 	47	25	6	Saturday 
1426	2028-11-26	2028	4	11	November 	47	26	0	Sunday   
1427	2028-11-27	2028	4	11	November 	48	27	1	Monday   
1428	2028-11-28	2028	4	11	November 	48	28	2	Tuesday  
1429	2028-11-29	2028	4	11	November 	48	29	3	Wednesday
1430	2028-11-30	2028	4	11	November 	48	30	4	Thursday 
1431	2028-12-01	2028	4	12	December 	48	1	5	Friday   
1432	2028-12-02	2028	4	12	December 	48	2	6	Saturday 
1433	2028-12-03	2028	4	12	December 	48	3	0	Sunday   
1434	2028-12-04	2028	4	12	December 	49	4	1	Monday   
1435	2028-12-05	2028	4	12	December 	49	5	2	Tuesday  
1436	2028-12-06	2028	4	12	December 	49	6	3	Wednesday
1437	2028-12-07	2028	4	12	December 	49	7	4	Thursday 
1438	2028-12-08	2028	4	12	December 	49	8	5	Friday   
1439	2028-12-09	2028	4	12	December 	49	9	6	Saturday 
1440	2028-12-10	2028	4	12	December 	49	10	0	Sunday   
1441	2028-12-11	2028	4	12	December 	50	11	1	Monday   
1442	2028-12-12	2028	4	12	December 	50	12	2	Tuesday  
1443	2028-12-13	2028	4	12	December 	50	13	3	Wednesday
1444	2028-12-14	2028	4	12	December 	50	14	4	Thursday 
1445	2028-12-15	2028	4	12	December 	50	15	5	Friday   
1446	2028-12-16	2028	4	12	December 	50	16	6	Saturday 
1447	2028-12-17	2028	4	12	December 	50	17	0	Sunday   
1448	2028-12-18	2028	4	12	December 	51	18	1	Monday   
1449	2028-12-19	2028	4	12	December 	51	19	2	Tuesday  
1450	2028-12-20	2028	4	12	December 	51	20	3	Wednesday
1451	2028-12-21	2028	4	12	December 	51	21	4	Thursday 
1452	2028-12-22	2028	4	12	December 	51	22	5	Friday   
1453	2028-12-23	2028	4	12	December 	51	23	6	Saturday 
1454	2028-12-24	2028	4	12	December 	51	24	0	Sunday   
1455	2028-12-25	2028	4	12	December 	52	25	1	Monday   
1456	2028-12-26	2028	4	12	December 	52	26	2	Tuesday  
1457	2028-12-27	2028	4	12	December 	52	27	3	Wednesday
1458	2028-12-28	2028	4	12	December 	52	28	4	Thursday 
1459	2028-12-29	2028	4	12	December 	52	29	5	Friday   
1460	2028-12-30	2028	4	12	December 	52	30	6	Saturday 
1461	2028-12-31	2028	4	12	December 	52	31	0	Sunday   
1462	2029-01-01	2029	1	1	January  	1	1	1	Monday   
1463	2029-01-02	2029	1	1	January  	1	2	2	Tuesday  
1464	2029-01-03	2029	1	1	January  	1	3	3	Wednesday
1465	2029-01-04	2029	1	1	January  	1	4	4	Thursday 
1466	2029-01-05	2029	1	1	January  	1	5	5	Friday   
1467	2029-01-06	2029	1	1	January  	1	6	6	Saturday 
1468	2029-01-07	2029	1	1	January  	1	7	0	Sunday   
1469	2029-01-08	2029	1	1	January  	2	8	1	Monday   
1470	2029-01-09	2029	1	1	January  	2	9	2	Tuesday  
1471	2029-01-10	2029	1	1	January  	2	10	3	Wednesday
1472	2029-01-11	2029	1	1	January  	2	11	4	Thursday 
1473	2029-01-12	2029	1	1	January  	2	12	5	Friday   
1474	2029-01-13	2029	1	1	January  	2	13	6	Saturday 
1475	2029-01-14	2029	1	1	January  	2	14	0	Sunday   
1476	2029-01-15	2029	1	1	January  	3	15	1	Monday   
1477	2029-01-16	2029	1	1	January  	3	16	2	Tuesday  
1478	2029-01-17	2029	1	1	January  	3	17	3	Wednesday
1479	2029-01-18	2029	1	1	January  	3	18	4	Thursday 
1480	2029-01-19	2029	1	1	January  	3	19	5	Friday   
1481	2029-01-20	2029	1	1	January  	3	20	6	Saturday 
1482	2029-01-21	2029	1	1	January  	3	21	0	Sunday   
1483	2029-01-22	2029	1	1	January  	4	22	1	Monday   
1484	2029-01-23	2029	1	1	January  	4	23	2	Tuesday  
1485	2029-01-24	2029	1	1	January  	4	24	3	Wednesday
1486	2029-01-25	2029	1	1	January  	4	25	4	Thursday 
1487	2029-01-26	2029	1	1	January  	4	26	5	Friday   
1488	2029-01-27	2029	1	1	January  	4	27	6	Saturday 
1489	2029-01-28	2029	1	1	January  	4	28	0	Sunday   
1490	2029-01-29	2029	1	1	January  	5	29	1	Monday   
1491	2029-01-30	2029	1	1	January  	5	30	2	Tuesday  
1492	2029-01-31	2029	1	1	January  	5	31	3	Wednesday
1493	2029-02-01	2029	1	2	February 	5	1	4	Thursday 
1494	2029-02-02	2029	1	2	February 	5	2	5	Friday   
1495	2029-02-03	2029	1	2	February 	5	3	6	Saturday 
1496	2029-02-04	2029	1	2	February 	5	4	0	Sunday   
1497	2029-02-05	2029	1	2	February 	6	5	1	Monday   
1498	2029-02-06	2029	1	2	February 	6	6	2	Tuesday  
1499	2029-02-07	2029	1	2	February 	6	7	3	Wednesday
1500	2029-02-08	2029	1	2	February 	6	8	4	Thursday 
1501	2029-02-09	2029	1	2	February 	6	9	5	Friday   
1502	2029-02-10	2029	1	2	February 	6	10	6	Saturday 
1503	2029-02-11	2029	1	2	February 	6	11	0	Sunday   
1504	2029-02-12	2029	1	2	February 	7	12	1	Monday   
1505	2029-02-13	2029	1	2	February 	7	13	2	Tuesday  
1506	2029-02-14	2029	1	2	February 	7	14	3	Wednesday
1507	2029-02-15	2029	1	2	February 	7	15	4	Thursday 
1508	2029-02-16	2029	1	2	February 	7	16	5	Friday   
1509	2029-02-17	2029	1	2	February 	7	17	6	Saturday 
1510	2029-02-18	2029	1	2	February 	7	18	0	Sunday   
1511	2029-02-19	2029	1	2	February 	8	19	1	Monday   
1512	2029-02-20	2029	1	2	February 	8	20	2	Tuesday  
1513	2029-02-21	2029	1	2	February 	8	21	3	Wednesday
1514	2029-02-22	2029	1	2	February 	8	22	4	Thursday 
1515	2029-02-23	2029	1	2	February 	8	23	5	Friday   
1516	2029-02-24	2029	1	2	February 	8	24	6	Saturday 
1517	2029-02-25	2029	1	2	February 	8	25	0	Sunday   
1518	2029-02-26	2029	1	2	February 	9	26	1	Monday   
1519	2029-02-27	2029	1	2	February 	9	27	2	Tuesday  
1520	2029-02-28	2029	1	2	February 	9	28	3	Wednesday
1521	2029-03-01	2029	1	3	March    	9	1	4	Thursday 
1522	2029-03-02	2029	1	3	March    	9	2	5	Friday   
1523	2029-03-03	2029	1	3	March    	9	3	6	Saturday 
1524	2029-03-04	2029	1	3	March    	9	4	0	Sunday   
1525	2029-03-05	2029	1	3	March    	10	5	1	Monday   
1526	2029-03-06	2029	1	3	March    	10	6	2	Tuesday  
1527	2029-03-07	2029	1	3	March    	10	7	3	Wednesday
1528	2029-03-08	2029	1	3	March    	10	8	4	Thursday 
1529	2029-03-09	2029	1	3	March    	10	9	5	Friday   
1530	2029-03-10	2029	1	3	March    	10	10	6	Saturday 
1531	2029-03-11	2029	1	3	March    	10	11	0	Sunday   
1532	2029-03-12	2029	1	3	March    	11	12	1	Monday   
1533	2029-03-13	2029	1	3	March    	11	13	2	Tuesday  
1534	2029-03-14	2029	1	3	March    	11	14	3	Wednesday
1535	2029-03-15	2029	1	3	March    	11	15	4	Thursday 
1536	2029-03-16	2029	1	3	March    	11	16	5	Friday   
1537	2029-03-17	2029	1	3	March    	11	17	6	Saturday 
1538	2029-03-18	2029	1	3	March    	11	18	0	Sunday   
1539	2029-03-19	2029	1	3	March    	12	19	1	Monday   
1540	2029-03-20	2029	1	3	March    	12	20	2	Tuesday  
1541	2029-03-21	2029	1	3	March    	12	21	3	Wednesday
1542	2029-03-22	2029	1	3	March    	12	22	4	Thursday 
1543	2029-03-23	2029	1	3	March    	12	23	5	Friday   
1544	2029-03-24	2029	1	3	March    	12	24	6	Saturday 
1545	2029-03-25	2029	1	3	March    	12	25	0	Sunday   
1546	2029-03-26	2029	1	3	March    	13	26	1	Monday   
1547	2029-03-27	2029	1	3	March    	13	27	2	Tuesday  
1548	2029-03-28	2029	1	3	March    	13	28	3	Wednesday
1549	2029-03-29	2029	1	3	March    	13	29	4	Thursday 
1550	2029-03-30	2029	1	3	March    	13	30	5	Friday   
1551	2029-03-31	2029	1	3	March    	13	31	6	Saturday 
1552	2029-04-01	2029	2	4	April    	13	1	0	Sunday   
1553	2029-04-02	2029	2	4	April    	14	2	1	Monday   
1554	2029-04-03	2029	2	4	April    	14	3	2	Tuesday  
1555	2029-04-04	2029	2	4	April    	14	4	3	Wednesday
1556	2029-04-05	2029	2	4	April    	14	5	4	Thursday 
1557	2029-04-06	2029	2	4	April    	14	6	5	Friday   
1558	2029-04-07	2029	2	4	April    	14	7	6	Saturday 
1559	2029-04-08	2029	2	4	April    	14	8	0	Sunday   
1560	2029-04-09	2029	2	4	April    	15	9	1	Monday   
1561	2029-04-10	2029	2	4	April    	15	10	2	Tuesday  
1562	2029-04-11	2029	2	4	April    	15	11	3	Wednesday
1563	2029-04-12	2029	2	4	April    	15	12	4	Thursday 
1564	2029-04-13	2029	2	4	April    	15	13	5	Friday   
1565	2029-04-14	2029	2	4	April    	15	14	6	Saturday 
1566	2029-04-15	2029	2	4	April    	15	15	0	Sunday   
1567	2029-04-16	2029	2	4	April    	16	16	1	Monday   
1568	2029-04-17	2029	2	4	April    	16	17	2	Tuesday  
1569	2029-04-18	2029	2	4	April    	16	18	3	Wednesday
1570	2029-04-19	2029	2	4	April    	16	19	4	Thursday 
1571	2029-04-20	2029	2	4	April    	16	20	5	Friday   
1572	2029-04-21	2029	2	4	April    	16	21	6	Saturday 
1573	2029-04-22	2029	2	4	April    	16	22	0	Sunday   
1574	2029-04-23	2029	2	4	April    	17	23	1	Monday   
1575	2029-04-24	2029	2	4	April    	17	24	2	Tuesday  
1576	2029-04-25	2029	2	4	April    	17	25	3	Wednesday
1577	2029-04-26	2029	2	4	April    	17	26	4	Thursday 
1578	2029-04-27	2029	2	4	April    	17	27	5	Friday   
1579	2029-04-28	2029	2	4	April    	17	28	6	Saturday 
1580	2029-04-29	2029	2	4	April    	17	29	0	Sunday   
1581	2029-04-30	2029	2	4	April    	18	30	1	Monday   
1582	2029-05-01	2029	2	5	May      	18	1	2	Tuesday  
1583	2029-05-02	2029	2	5	May      	18	2	3	Wednesday
1584	2029-05-03	2029	2	5	May      	18	3	4	Thursday 
1585	2029-05-04	2029	2	5	May      	18	4	5	Friday   
1586	2029-05-05	2029	2	5	May      	18	5	6	Saturday 
1587	2029-05-06	2029	2	5	May      	18	6	0	Sunday   
1588	2029-05-07	2029	2	5	May      	19	7	1	Monday   
1589	2029-05-08	2029	2	5	May      	19	8	2	Tuesday  
1590	2029-05-09	2029	2	5	May      	19	9	3	Wednesday
1591	2029-05-10	2029	2	5	May      	19	10	4	Thursday 
1592	2029-05-11	2029	2	5	May      	19	11	5	Friday   
1593	2029-05-12	2029	2	5	May      	19	12	6	Saturday 
1594	2029-05-13	2029	2	5	May      	19	13	0	Sunday   
1595	2029-05-14	2029	2	5	May      	20	14	1	Monday   
1596	2029-05-15	2029	2	5	May      	20	15	2	Tuesday  
1597	2029-05-16	2029	2	5	May      	20	16	3	Wednesday
1598	2029-05-17	2029	2	5	May      	20	17	4	Thursday 
1599	2029-05-18	2029	2	5	May      	20	18	5	Friday   
1600	2029-05-19	2029	2	5	May      	20	19	6	Saturday 
1601	2029-05-20	2029	2	5	May      	20	20	0	Sunday   
1602	2029-05-21	2029	2	5	May      	21	21	1	Monday   
1603	2029-05-22	2029	2	5	May      	21	22	2	Tuesday  
1604	2029-05-23	2029	2	5	May      	21	23	3	Wednesday
1605	2029-05-24	2029	2	5	May      	21	24	4	Thursday 
1606	2029-05-25	2029	2	5	May      	21	25	5	Friday   
1607	2029-05-26	2029	2	5	May      	21	26	6	Saturday 
1608	2029-05-27	2029	2	5	May      	21	27	0	Sunday   
1609	2029-05-28	2029	2	5	May      	22	28	1	Monday   
1610	2029-05-29	2029	2	5	May      	22	29	2	Tuesday  
1611	2029-05-30	2029	2	5	May      	22	30	3	Wednesday
1612	2029-05-31	2029	2	5	May      	22	31	4	Thursday 
1613	2029-06-01	2029	2	6	June     	22	1	5	Friday   
1614	2029-06-02	2029	2	6	June     	22	2	6	Saturday 
1615	2029-06-03	2029	2	6	June     	22	3	0	Sunday   
1616	2029-06-04	2029	2	6	June     	23	4	1	Monday   
1617	2029-06-05	2029	2	6	June     	23	5	2	Tuesday  
1618	2029-06-06	2029	2	6	June     	23	6	3	Wednesday
1619	2029-06-07	2029	2	6	June     	23	7	4	Thursday 
1620	2029-06-08	2029	2	6	June     	23	8	5	Friday   
1621	2029-06-09	2029	2	6	June     	23	9	6	Saturday 
1622	2029-06-10	2029	2	6	June     	23	10	0	Sunday   
1623	2029-06-11	2029	2	6	June     	24	11	1	Monday   
1624	2029-06-12	2029	2	6	June     	24	12	2	Tuesday  
1625	2029-06-13	2029	2	6	June     	24	13	3	Wednesday
1626	2029-06-14	2029	2	6	June     	24	14	4	Thursday 
1627	2029-06-15	2029	2	6	June     	24	15	5	Friday   
1628	2029-06-16	2029	2	6	June     	24	16	6	Saturday 
1629	2029-06-17	2029	2	6	June     	24	17	0	Sunday   
1630	2029-06-18	2029	2	6	June     	25	18	1	Monday   
1631	2029-06-19	2029	2	6	June     	25	19	2	Tuesday  
1632	2029-06-20	2029	2	6	June     	25	20	3	Wednesday
1633	2029-06-21	2029	2	6	June     	25	21	4	Thursday 
1634	2029-06-22	2029	2	6	June     	25	22	5	Friday   
1635	2029-06-23	2029	2	6	June     	25	23	6	Saturday 
1636	2029-06-24	2029	2	6	June     	25	24	0	Sunday   
1637	2029-06-25	2029	2	6	June     	26	25	1	Monday   
1638	2029-06-26	2029	2	6	June     	26	26	2	Tuesday  
1639	2029-06-27	2029	2	6	June     	26	27	3	Wednesday
1640	2029-06-28	2029	2	6	June     	26	28	4	Thursday 
1641	2029-06-29	2029	2	6	June     	26	29	5	Friday   
1642	2029-06-30	2029	2	6	June     	26	30	6	Saturday 
1643	2029-07-01	2029	3	7	July     	26	1	0	Sunday   
1644	2029-07-02	2029	3	7	July     	27	2	1	Monday   
1645	2029-07-03	2029	3	7	July     	27	3	2	Tuesday  
1646	2029-07-04	2029	3	7	July     	27	4	3	Wednesday
1647	2029-07-05	2029	3	7	July     	27	5	4	Thursday 
1648	2029-07-06	2029	3	7	July     	27	6	5	Friday   
1649	2029-07-07	2029	3	7	July     	27	7	6	Saturday 
1650	2029-07-08	2029	3	7	July     	27	8	0	Sunday   
1651	2029-07-09	2029	3	7	July     	28	9	1	Monday   
1652	2029-07-10	2029	3	7	July     	28	10	2	Tuesday  
1653	2029-07-11	2029	3	7	July     	28	11	3	Wednesday
1654	2029-07-12	2029	3	7	July     	28	12	4	Thursday 
1655	2029-07-13	2029	3	7	July     	28	13	5	Friday   
1656	2029-07-14	2029	3	7	July     	28	14	6	Saturday 
1657	2029-07-15	2029	3	7	July     	28	15	0	Sunday   
1658	2029-07-16	2029	3	7	July     	29	16	1	Monday   
1659	2029-07-17	2029	3	7	July     	29	17	2	Tuesday  
1660	2029-07-18	2029	3	7	July     	29	18	3	Wednesday
1661	2029-07-19	2029	3	7	July     	29	19	4	Thursday 
1662	2029-07-20	2029	3	7	July     	29	20	5	Friday   
1663	2029-07-21	2029	3	7	July     	29	21	6	Saturday 
1664	2029-07-22	2029	3	7	July     	29	22	0	Sunday   
1665	2029-07-23	2029	3	7	July     	30	23	1	Monday   
1666	2029-07-24	2029	3	7	July     	30	24	2	Tuesday  
1667	2029-07-25	2029	3	7	July     	30	25	3	Wednesday
1668	2029-07-26	2029	3	7	July     	30	26	4	Thursday 
1669	2029-07-27	2029	3	7	July     	30	27	5	Friday   
1670	2029-07-28	2029	3	7	July     	30	28	6	Saturday 
1671	2029-07-29	2029	3	7	July     	30	29	0	Sunday   
1672	2029-07-30	2029	3	7	July     	31	30	1	Monday   
1673	2029-07-31	2029	3	7	July     	31	31	2	Tuesday  
1674	2029-08-01	2029	3	8	August   	31	1	3	Wednesday
1675	2029-08-02	2029	3	8	August   	31	2	4	Thursday 
1676	2029-08-03	2029	3	8	August   	31	3	5	Friday   
1677	2029-08-04	2029	3	8	August   	31	4	6	Saturday 
1678	2029-08-05	2029	3	8	August   	31	5	0	Sunday   
1679	2029-08-06	2029	3	8	August   	32	6	1	Monday   
1680	2029-08-07	2029	3	8	August   	32	7	2	Tuesday  
1681	2029-08-08	2029	3	8	August   	32	8	3	Wednesday
1682	2029-08-09	2029	3	8	August   	32	9	4	Thursday 
1683	2029-08-10	2029	3	8	August   	32	10	5	Friday   
1684	2029-08-11	2029	3	8	August   	32	11	6	Saturday 
1685	2029-08-12	2029	3	8	August   	32	12	0	Sunday   
1686	2029-08-13	2029	3	8	August   	33	13	1	Monday   
1687	2029-08-14	2029	3	8	August   	33	14	2	Tuesday  
1688	2029-08-15	2029	3	8	August   	33	15	3	Wednesday
1689	2029-08-16	2029	3	8	August   	33	16	4	Thursday 
1690	2029-08-17	2029	3	8	August   	33	17	5	Friday   
1691	2029-08-18	2029	3	8	August   	33	18	6	Saturday 
1692	2029-08-19	2029	3	8	August   	33	19	0	Sunday   
1693	2029-08-20	2029	3	8	August   	34	20	1	Monday   
1694	2029-08-21	2029	3	8	August   	34	21	2	Tuesday  
1695	2029-08-22	2029	3	8	August   	34	22	3	Wednesday
1696	2029-08-23	2029	3	8	August   	34	23	4	Thursday 
1697	2029-08-24	2029	3	8	August   	34	24	5	Friday   
1698	2029-08-25	2029	3	8	August   	34	25	6	Saturday 
1699	2029-08-26	2029	3	8	August   	34	26	0	Sunday   
1700	2029-08-27	2029	3	8	August   	35	27	1	Monday   
1701	2029-08-28	2029	3	8	August   	35	28	2	Tuesday  
1702	2029-08-29	2029	3	8	August   	35	29	3	Wednesday
1703	2029-08-30	2029	3	8	August   	35	30	4	Thursday 
1704	2029-08-31	2029	3	8	August   	35	31	5	Friday   
1705	2029-09-01	2029	3	9	September	35	1	6	Saturday 
1706	2029-09-02	2029	3	9	September	35	2	0	Sunday   
1707	2029-09-03	2029	3	9	September	36	3	1	Monday   
1708	2029-09-04	2029	3	9	September	36	4	2	Tuesday  
1709	2029-09-05	2029	3	9	September	36	5	3	Wednesday
1710	2029-09-06	2029	3	9	September	36	6	4	Thursday 
1711	2029-09-07	2029	3	9	September	36	7	5	Friday   
1712	2029-09-08	2029	3	9	September	36	8	6	Saturday 
1713	2029-09-09	2029	3	9	September	36	9	0	Sunday   
1714	2029-09-10	2029	3	9	September	37	10	1	Monday   
1715	2029-09-11	2029	3	9	September	37	11	2	Tuesday  
1716	2029-09-12	2029	3	9	September	37	12	3	Wednesday
1717	2029-09-13	2029	3	9	September	37	13	4	Thursday 
1718	2029-09-14	2029	3	9	September	37	14	5	Friday   
1719	2029-09-15	2029	3	9	September	37	15	6	Saturday 
1720	2029-09-16	2029	3	9	September	37	16	0	Sunday   
1721	2029-09-17	2029	3	9	September	38	17	1	Monday   
1722	2029-09-18	2029	3	9	September	38	18	2	Tuesday  
1723	2029-09-19	2029	3	9	September	38	19	3	Wednesday
1724	2029-09-20	2029	3	9	September	38	20	4	Thursday 
1725	2029-09-21	2029	3	9	September	38	21	5	Friday   
1726	2029-09-22	2029	3	9	September	38	22	6	Saturday 
1727	2029-09-23	2029	3	9	September	38	23	0	Sunday   
1728	2029-09-24	2029	3	9	September	39	24	1	Monday   
1729	2029-09-25	2029	3	9	September	39	25	2	Tuesday  
1730	2029-09-26	2029	3	9	September	39	26	3	Wednesday
1731	2029-09-27	2029	3	9	September	39	27	4	Thursday 
1732	2029-09-28	2029	3	9	September	39	28	5	Friday   
1733	2029-09-29	2029	3	9	September	39	29	6	Saturday 
1734	2029-09-30	2029	3	9	September	39	30	0	Sunday   
1735	2029-10-01	2029	4	10	October  	40	1	1	Monday   
1736	2029-10-02	2029	4	10	October  	40	2	2	Tuesday  
1737	2029-10-03	2029	4	10	October  	40	3	3	Wednesday
1738	2029-10-04	2029	4	10	October  	40	4	4	Thursday 
1739	2029-10-05	2029	4	10	October  	40	5	5	Friday   
1740	2029-10-06	2029	4	10	October  	40	6	6	Saturday 
1741	2029-10-07	2029	4	10	October  	40	7	0	Sunday   
1742	2029-10-08	2029	4	10	October  	41	8	1	Monday   
1743	2029-10-09	2029	4	10	October  	41	9	2	Tuesday  
1744	2029-10-10	2029	4	10	October  	41	10	3	Wednesday
1745	2029-10-11	2029	4	10	October  	41	11	4	Thursday 
1746	2029-10-12	2029	4	10	October  	41	12	5	Friday   
1747	2029-10-13	2029	4	10	October  	41	13	6	Saturday 
1748	2029-10-14	2029	4	10	October  	41	14	0	Sunday   
1749	2029-10-15	2029	4	10	October  	42	15	1	Monday   
1750	2029-10-16	2029	4	10	October  	42	16	2	Tuesday  
1751	2029-10-17	2029	4	10	October  	42	17	3	Wednesday
1752	2029-10-18	2029	4	10	October  	42	18	4	Thursday 
1753	2029-10-19	2029	4	10	October  	42	19	5	Friday   
1754	2029-10-20	2029	4	10	October  	42	20	6	Saturday 
1755	2029-10-21	2029	4	10	October  	42	21	0	Sunday   
1756	2029-10-22	2029	4	10	October  	43	22	1	Monday   
1757	2029-10-23	2029	4	10	October  	43	23	2	Tuesday  
1758	2029-10-24	2029	4	10	October  	43	24	3	Wednesday
1759	2029-10-25	2029	4	10	October  	43	25	4	Thursday 
1760	2029-10-26	2029	4	10	October  	43	26	5	Friday   
1761	2029-10-27	2029	4	10	October  	43	27	6	Saturday 
1762	2029-10-28	2029	4	10	October  	43	28	0	Sunday   
1763	2029-10-29	2029	4	10	October  	44	29	1	Monday   
1764	2029-10-30	2029	4	10	October  	44	30	2	Tuesday  
1765	2029-10-31	2029	4	10	October  	44	31	3	Wednesday
1766	2029-11-01	2029	4	11	November 	44	1	4	Thursday 
1767	2029-11-02	2029	4	11	November 	44	2	5	Friday   
1768	2029-11-03	2029	4	11	November 	44	3	6	Saturday 
1769	2029-11-04	2029	4	11	November 	44	4	0	Sunday   
1770	2029-11-05	2029	4	11	November 	45	5	1	Monday   
1771	2029-11-06	2029	4	11	November 	45	6	2	Tuesday  
1772	2029-11-07	2029	4	11	November 	45	7	3	Wednesday
1773	2029-11-08	2029	4	11	November 	45	8	4	Thursday 
1774	2029-11-09	2029	4	11	November 	45	9	5	Friday   
1775	2029-11-10	2029	4	11	November 	45	10	6	Saturday 
1776	2029-11-11	2029	4	11	November 	45	11	0	Sunday   
1777	2029-11-12	2029	4	11	November 	46	12	1	Monday   
1778	2029-11-13	2029	4	11	November 	46	13	2	Tuesday  
1779	2029-11-14	2029	4	11	November 	46	14	3	Wednesday
1780	2029-11-15	2029	4	11	November 	46	15	4	Thursday 
1781	2029-11-16	2029	4	11	November 	46	16	5	Friday   
1782	2029-11-17	2029	4	11	November 	46	17	6	Saturday 
1783	2029-11-18	2029	4	11	November 	46	18	0	Sunday   
1784	2029-11-19	2029	4	11	November 	47	19	1	Monday   
1785	2029-11-20	2029	4	11	November 	47	20	2	Tuesday  
1786	2029-11-21	2029	4	11	November 	47	21	3	Wednesday
1787	2029-11-22	2029	4	11	November 	47	22	4	Thursday 
1788	2029-11-23	2029	4	11	November 	47	23	5	Friday   
1789	2029-11-24	2029	4	11	November 	47	24	6	Saturday 
1790	2029-11-25	2029	4	11	November 	47	25	0	Sunday   
1791	2029-11-26	2029	4	11	November 	48	26	1	Monday   
1792	2029-11-27	2029	4	11	November 	48	27	2	Tuesday  
1793	2029-11-28	2029	4	11	November 	48	28	3	Wednesday
1794	2029-11-29	2029	4	11	November 	48	29	4	Thursday 
1795	2029-11-30	2029	4	11	November 	48	30	5	Friday   
1796	2029-12-01	2029	4	12	December 	48	1	6	Saturday 
1797	2029-12-02	2029	4	12	December 	48	2	0	Sunday   
1798	2029-12-03	2029	4	12	December 	49	3	1	Monday   
1799	2029-12-04	2029	4	12	December 	49	4	2	Tuesday  
1800	2029-12-05	2029	4	12	December 	49	5	3	Wednesday
1801	2029-12-06	2029	4	12	December 	49	6	4	Thursday 
1802	2029-12-07	2029	4	12	December 	49	7	5	Friday   
1803	2029-12-08	2029	4	12	December 	49	8	6	Saturday 
1804	2029-12-09	2029	4	12	December 	49	9	0	Sunday   
1805	2029-12-10	2029	4	12	December 	50	10	1	Monday   
1806	2029-12-11	2029	4	12	December 	50	11	2	Tuesday  
1807	2029-12-12	2029	4	12	December 	50	12	3	Wednesday
1808	2029-12-13	2029	4	12	December 	50	13	4	Thursday 
1809	2029-12-14	2029	4	12	December 	50	14	5	Friday   
1810	2029-12-15	2029	4	12	December 	50	15	6	Saturday 
1811	2029-12-16	2029	4	12	December 	50	16	0	Sunday   
1812	2029-12-17	2029	4	12	December 	51	17	1	Monday   
1813	2029-12-18	2029	4	12	December 	51	18	2	Tuesday  
1814	2029-12-19	2029	4	12	December 	51	19	3	Wednesday
1815	2029-12-20	2029	4	12	December 	51	20	4	Thursday 
1816	2029-12-21	2029	4	12	December 	51	21	5	Friday   
1817	2029-12-22	2029	4	12	December 	51	22	6	Saturday 
1818	2029-12-23	2029	4	12	December 	51	23	0	Sunday   
1819	2029-12-24	2029	4	12	December 	52	24	1	Monday   
1820	2029-12-25	2029	4	12	December 	52	25	2	Tuesday  
1821	2029-12-26	2029	4	12	December 	52	26	3	Wednesday
1822	2029-12-27	2029	4	12	December 	52	27	4	Thursday 
1823	2029-12-28	2029	4	12	December 	52	28	5	Friday   
1824	2029-12-29	2029	4	12	December 	52	29	6	Saturday 
1825	2029-12-30	2029	4	12	December 	52	30	0	Sunday   
1826	2029-12-31	2029	4	12	December 	1	31	1	Monday   
1827	2030-01-01	2030	1	1	January  	1	1	2	Tuesday  
1828	2030-01-02	2030	1	1	January  	1	2	3	Wednesday
1829	2030-01-03	2030	1	1	January  	1	3	4	Thursday 
1830	2030-01-04	2030	1	1	January  	1	4	5	Friday   
1831	2030-01-05	2030	1	1	January  	1	5	6	Saturday 
1832	2030-01-06	2030	1	1	January  	1	6	0	Sunday   
1833	2030-01-07	2030	1	1	January  	2	7	1	Monday   
1834	2030-01-08	2030	1	1	January  	2	8	2	Tuesday  
1835	2030-01-09	2030	1	1	January  	2	9	3	Wednesday
1836	2030-01-10	2030	1	1	January  	2	10	4	Thursday 
1837	2030-01-11	2030	1	1	January  	2	11	5	Friday   
1838	2030-01-12	2030	1	1	January  	2	12	6	Saturday 
1839	2030-01-13	2030	1	1	January  	2	13	0	Sunday   
1840	2030-01-14	2030	1	1	January  	3	14	1	Monday   
1841	2030-01-15	2030	1	1	January  	3	15	2	Tuesday  
1842	2030-01-16	2030	1	1	January  	3	16	3	Wednesday
1843	2030-01-17	2030	1	1	January  	3	17	4	Thursday 
1844	2030-01-18	2030	1	1	January  	3	18	5	Friday   
1845	2030-01-19	2030	1	1	January  	3	19	6	Saturday 
1846	2030-01-20	2030	1	1	January  	3	20	0	Sunday   
1847	2030-01-21	2030	1	1	January  	4	21	1	Monday   
1848	2030-01-22	2030	1	1	January  	4	22	2	Tuesday  
1849	2030-01-23	2030	1	1	January  	4	23	3	Wednesday
1850	2030-01-24	2030	1	1	January  	4	24	4	Thursday 
1851	2030-01-25	2030	1	1	January  	4	25	5	Friday   
1852	2030-01-26	2030	1	1	January  	4	26	6	Saturday 
1853	2030-01-27	2030	1	1	January  	4	27	0	Sunday   
1854	2030-01-28	2030	1	1	January  	5	28	1	Monday   
1855	2030-01-29	2030	1	1	January  	5	29	2	Tuesday  
1856	2030-01-30	2030	1	1	January  	5	30	3	Wednesday
1857	2030-01-31	2030	1	1	January  	5	31	4	Thursday 
1858	2030-02-01	2030	1	2	February 	5	1	5	Friday   
1859	2030-02-02	2030	1	2	February 	5	2	6	Saturday 
1860	2030-02-03	2030	1	2	February 	5	3	0	Sunday   
1861	2030-02-04	2030	1	2	February 	6	4	1	Monday   
1862	2030-02-05	2030	1	2	February 	6	5	2	Tuesday  
1863	2030-02-06	2030	1	2	February 	6	6	3	Wednesday
1864	2030-02-07	2030	1	2	February 	6	7	4	Thursday 
1865	2030-02-08	2030	1	2	February 	6	8	5	Friday   
1866	2030-02-09	2030	1	2	February 	6	9	6	Saturday 
1867	2030-02-10	2030	1	2	February 	6	10	0	Sunday   
1868	2030-02-11	2030	1	2	February 	7	11	1	Monday   
1869	2030-02-12	2030	1	2	February 	7	12	2	Tuesday  
1870	2030-02-13	2030	1	2	February 	7	13	3	Wednesday
1871	2030-02-14	2030	1	2	February 	7	14	4	Thursday 
1872	2030-02-15	2030	1	2	February 	7	15	5	Friday   
1873	2030-02-16	2030	1	2	February 	7	16	6	Saturday 
1874	2030-02-17	2030	1	2	February 	7	17	0	Sunday   
1875	2030-02-18	2030	1	2	February 	8	18	1	Monday   
1876	2030-02-19	2030	1	2	February 	8	19	2	Tuesday  
1877	2030-02-20	2030	1	2	February 	8	20	3	Wednesday
1878	2030-02-21	2030	1	2	February 	8	21	4	Thursday 
1879	2030-02-22	2030	1	2	February 	8	22	5	Friday   
1880	2030-02-23	2030	1	2	February 	8	23	6	Saturday 
1881	2030-02-24	2030	1	2	February 	8	24	0	Sunday   
1882	2030-02-25	2030	1	2	February 	9	25	1	Monday   
1883	2030-02-26	2030	1	2	February 	9	26	2	Tuesday  
1884	2030-02-27	2030	1	2	February 	9	27	3	Wednesday
1885	2030-02-28	2030	1	2	February 	9	28	4	Thursday 
1886	2030-03-01	2030	1	3	March    	9	1	5	Friday   
1887	2030-03-02	2030	1	3	March    	9	2	6	Saturday 
1888	2030-03-03	2030	1	3	March    	9	3	0	Sunday   
1889	2030-03-04	2030	1	3	March    	10	4	1	Monday   
1890	2030-03-05	2030	1	3	March    	10	5	2	Tuesday  
1891	2030-03-06	2030	1	3	March    	10	6	3	Wednesday
1892	2030-03-07	2030	1	3	March    	10	7	4	Thursday 
1893	2030-03-08	2030	1	3	March    	10	8	5	Friday   
1894	2030-03-09	2030	1	3	March    	10	9	6	Saturday 
1895	2030-03-10	2030	1	3	March    	10	10	0	Sunday   
1896	2030-03-11	2030	1	3	March    	11	11	1	Monday   
1897	2030-03-12	2030	1	3	March    	11	12	2	Tuesday  
1898	2030-03-13	2030	1	3	March    	11	13	3	Wednesday
1899	2030-03-14	2030	1	3	March    	11	14	4	Thursday 
1900	2030-03-15	2030	1	3	March    	11	15	5	Friday   
1901	2030-03-16	2030	1	3	March    	11	16	6	Saturday 
1902	2030-03-17	2030	1	3	March    	11	17	0	Sunday   
1903	2030-03-18	2030	1	3	March    	12	18	1	Monday   
1904	2030-03-19	2030	1	3	March    	12	19	2	Tuesday  
1905	2030-03-20	2030	1	3	March    	12	20	3	Wednesday
1906	2030-03-21	2030	1	3	March    	12	21	4	Thursday 
1907	2030-03-22	2030	1	3	March    	12	22	5	Friday   
1908	2030-03-23	2030	1	3	March    	12	23	6	Saturday 
1909	2030-03-24	2030	1	3	March    	12	24	0	Sunday   
1910	2030-03-25	2030	1	3	March    	13	25	1	Monday   
1911	2030-03-26	2030	1	3	March    	13	26	2	Tuesday  
1912	2030-03-27	2030	1	3	March    	13	27	3	Wednesday
1913	2030-03-28	2030	1	3	March    	13	28	4	Thursday 
1914	2030-03-29	2030	1	3	March    	13	29	5	Friday   
1915	2030-03-30	2030	1	3	March    	13	30	6	Saturday 
1916	2030-03-31	2030	1	3	March    	13	31	0	Sunday   
1917	2030-04-01	2030	2	4	April    	14	1	1	Monday   
1918	2030-04-02	2030	2	4	April    	14	2	2	Tuesday  
1919	2030-04-03	2030	2	4	April    	14	3	3	Wednesday
1920	2030-04-04	2030	2	4	April    	14	4	4	Thursday 
1921	2030-04-05	2030	2	4	April    	14	5	5	Friday   
1922	2030-04-06	2030	2	4	April    	14	6	6	Saturday 
1923	2030-04-07	2030	2	4	April    	14	7	0	Sunday   
1924	2030-04-08	2030	2	4	April    	15	8	1	Monday   
1925	2030-04-09	2030	2	4	April    	15	9	2	Tuesday  
1926	2030-04-10	2030	2	4	April    	15	10	3	Wednesday
1927	2030-04-11	2030	2	4	April    	15	11	4	Thursday 
1928	2030-04-12	2030	2	4	April    	15	12	5	Friday   
1929	2030-04-13	2030	2	4	April    	15	13	6	Saturday 
1930	2030-04-14	2030	2	4	April    	15	14	0	Sunday   
1931	2030-04-15	2030	2	4	April    	16	15	1	Monday   
1932	2030-04-16	2030	2	4	April    	16	16	2	Tuesday  
1933	2030-04-17	2030	2	4	April    	16	17	3	Wednesday
1934	2030-04-18	2030	2	4	April    	16	18	4	Thursday 
1935	2030-04-19	2030	2	4	April    	16	19	5	Friday   
1936	2030-04-20	2030	2	4	April    	16	20	6	Saturday 
1937	2030-04-21	2030	2	4	April    	16	21	0	Sunday   
1938	2030-04-22	2030	2	4	April    	17	22	1	Monday   
1939	2030-04-23	2030	2	4	April    	17	23	2	Tuesday  
1940	2030-04-24	2030	2	4	April    	17	24	3	Wednesday
1941	2030-04-25	2030	2	4	April    	17	25	4	Thursday 
1942	2030-04-26	2030	2	4	April    	17	26	5	Friday   
1943	2030-04-27	2030	2	4	April    	17	27	6	Saturday 
1944	2030-04-28	2030	2	4	April    	17	28	0	Sunday   
1945	2030-04-29	2030	2	4	April    	18	29	1	Monday   
1946	2030-04-30	2030	2	4	April    	18	30	2	Tuesday  
1947	2030-05-01	2030	2	5	May      	18	1	3	Wednesday
1948	2030-05-02	2030	2	5	May      	18	2	4	Thursday 
1949	2030-05-03	2030	2	5	May      	18	3	5	Friday   
1950	2030-05-04	2030	2	5	May      	18	4	6	Saturday 
1951	2030-05-05	2030	2	5	May      	18	5	0	Sunday   
1952	2030-05-06	2030	2	5	May      	19	6	1	Monday   
1953	2030-05-07	2030	2	5	May      	19	7	2	Tuesday  
1954	2030-05-08	2030	2	5	May      	19	8	3	Wednesday
1955	2030-05-09	2030	2	5	May      	19	9	4	Thursday 
1956	2030-05-10	2030	2	5	May      	19	10	5	Friday   
1957	2030-05-11	2030	2	5	May      	19	11	6	Saturday 
1958	2030-05-12	2030	2	5	May      	19	12	0	Sunday   
1959	2030-05-13	2030	2	5	May      	20	13	1	Monday   
1960	2030-05-14	2030	2	5	May      	20	14	2	Tuesday  
1961	2030-05-15	2030	2	5	May      	20	15	3	Wednesday
1962	2030-05-16	2030	2	5	May      	20	16	4	Thursday 
1963	2030-05-17	2030	2	5	May      	20	17	5	Friday   
1964	2030-05-18	2030	2	5	May      	20	18	6	Saturday 
1965	2030-05-19	2030	2	5	May      	20	19	0	Sunday   
1966	2030-05-20	2030	2	5	May      	21	20	1	Monday   
1967	2030-05-21	2030	2	5	May      	21	21	2	Tuesday  
1968	2030-05-22	2030	2	5	May      	21	22	3	Wednesday
1969	2030-05-23	2030	2	5	May      	21	23	4	Thursday 
1970	2030-05-24	2030	2	5	May      	21	24	5	Friday   
1971	2030-05-25	2030	2	5	May      	21	25	6	Saturday 
1972	2030-05-26	2030	2	5	May      	21	26	0	Sunday   
1973	2030-05-27	2030	2	5	May      	22	27	1	Monday   
1974	2030-05-28	2030	2	5	May      	22	28	2	Tuesday  
1975	2030-05-29	2030	2	5	May      	22	29	3	Wednesday
1976	2030-05-30	2030	2	5	May      	22	30	4	Thursday 
1977	2030-05-31	2030	2	5	May      	22	31	5	Friday   
1978	2030-06-01	2030	2	6	June     	22	1	6	Saturday 
1979	2030-06-02	2030	2	6	June     	22	2	0	Sunday   
1980	2030-06-03	2030	2	6	June     	23	3	1	Monday   
1981	2030-06-04	2030	2	6	June     	23	4	2	Tuesday  
1982	2030-06-05	2030	2	6	June     	23	5	3	Wednesday
1983	2030-06-06	2030	2	6	June     	23	6	4	Thursday 
1984	2030-06-07	2030	2	6	June     	23	7	5	Friday   
1985	2030-06-08	2030	2	6	June     	23	8	6	Saturday 
1986	2030-06-09	2030	2	6	June     	23	9	0	Sunday   
1987	2030-06-10	2030	2	6	June     	24	10	1	Monday   
1988	2030-06-11	2030	2	6	June     	24	11	2	Tuesday  
1989	2030-06-12	2030	2	6	June     	24	12	3	Wednesday
1990	2030-06-13	2030	2	6	June     	24	13	4	Thursday 
1991	2030-06-14	2030	2	6	June     	24	14	5	Friday   
1992	2030-06-15	2030	2	6	June     	24	15	6	Saturday 
1993	2030-06-16	2030	2	6	June     	24	16	0	Sunday   
1994	2030-06-17	2030	2	6	June     	25	17	1	Monday   
1995	2030-06-18	2030	2	6	June     	25	18	2	Tuesday  
1996	2030-06-19	2030	2	6	June     	25	19	3	Wednesday
1997	2030-06-20	2030	2	6	June     	25	20	4	Thursday 
1998	2030-06-21	2030	2	6	June     	25	21	5	Friday   
1999	2030-06-22	2030	2	6	June     	25	22	6	Saturday 
2000	2030-06-23	2030	2	6	June     	25	23	0	Sunday   
2001	2030-06-24	2030	2	6	June     	26	24	1	Monday   
2002	2030-06-25	2030	2	6	June     	26	25	2	Tuesday  
2003	2030-06-26	2030	2	6	June     	26	26	3	Wednesday
2004	2030-06-27	2030	2	6	June     	26	27	4	Thursday 
2005	2030-06-28	2030	2	6	June     	26	28	5	Friday   
2006	2030-06-29	2030	2	6	June     	26	29	6	Saturday 
2007	2030-06-30	2030	2	6	June     	26	30	0	Sunday   
2008	2030-07-01	2030	3	7	July     	27	1	1	Monday   
2009	2030-07-02	2030	3	7	July     	27	2	2	Tuesday  
2010	2030-07-03	2030	3	7	July     	27	3	3	Wednesday
2011	2030-07-04	2030	3	7	July     	27	4	4	Thursday 
2012	2030-07-05	2030	3	7	July     	27	5	5	Friday   
2013	2030-07-06	2030	3	7	July     	27	6	6	Saturday 
2014	2030-07-07	2030	3	7	July     	27	7	0	Sunday   
2015	2030-07-08	2030	3	7	July     	28	8	1	Monday   
2016	2030-07-09	2030	3	7	July     	28	9	2	Tuesday  
2017	2030-07-10	2030	3	7	July     	28	10	3	Wednesday
2018	2030-07-11	2030	3	7	July     	28	11	4	Thursday 
2019	2030-07-12	2030	3	7	July     	28	12	5	Friday   
2020	2030-07-13	2030	3	7	July     	28	13	6	Saturday 
2021	2030-07-14	2030	3	7	July     	28	14	0	Sunday   
2022	2030-07-15	2030	3	7	July     	29	15	1	Monday   
2023	2030-07-16	2030	3	7	July     	29	16	2	Tuesday  
2024	2030-07-17	2030	3	7	July     	29	17	3	Wednesday
2025	2030-07-18	2030	3	7	July     	29	18	4	Thursday 
2026	2030-07-19	2030	3	7	July     	29	19	5	Friday   
2027	2030-07-20	2030	3	7	July     	29	20	6	Saturday 
2028	2030-07-21	2030	3	7	July     	29	21	0	Sunday   
2029	2030-07-22	2030	3	7	July     	30	22	1	Monday   
2030	2030-07-23	2030	3	7	July     	30	23	2	Tuesday  
2031	2030-07-24	2030	3	7	July     	30	24	3	Wednesday
2032	2030-07-25	2030	3	7	July     	30	25	4	Thursday 
2033	2030-07-26	2030	3	7	July     	30	26	5	Friday   
2034	2030-07-27	2030	3	7	July     	30	27	6	Saturday 
2035	2030-07-28	2030	3	7	July     	30	28	0	Sunday   
2036	2030-07-29	2030	3	7	July     	31	29	1	Monday   
2037	2030-07-30	2030	3	7	July     	31	30	2	Tuesday  
2038	2030-07-31	2030	3	7	July     	31	31	3	Wednesday
2039	2030-08-01	2030	3	8	August   	31	1	4	Thursday 
2040	2030-08-02	2030	3	8	August   	31	2	5	Friday   
2041	2030-08-03	2030	3	8	August   	31	3	6	Saturday 
2042	2030-08-04	2030	3	8	August   	31	4	0	Sunday   
2043	2030-08-05	2030	3	8	August   	32	5	1	Monday   
2044	2030-08-06	2030	3	8	August   	32	6	2	Tuesday  
2045	2030-08-07	2030	3	8	August   	32	7	3	Wednesday
2046	2030-08-08	2030	3	8	August   	32	8	4	Thursday 
2047	2030-08-09	2030	3	8	August   	32	9	5	Friday   
2048	2030-08-10	2030	3	8	August   	32	10	6	Saturday 
2049	2030-08-11	2030	3	8	August   	32	11	0	Sunday   
2050	2030-08-12	2030	3	8	August   	33	12	1	Monday   
2051	2030-08-13	2030	3	8	August   	33	13	2	Tuesday  
2052	2030-08-14	2030	3	8	August   	33	14	3	Wednesday
2053	2030-08-15	2030	3	8	August   	33	15	4	Thursday 
2054	2030-08-16	2030	3	8	August   	33	16	5	Friday   
2055	2030-08-17	2030	3	8	August   	33	17	6	Saturday 
2056	2030-08-18	2030	3	8	August   	33	18	0	Sunday   
2057	2030-08-19	2030	3	8	August   	34	19	1	Monday   
2058	2030-08-20	2030	3	8	August   	34	20	2	Tuesday  
2059	2030-08-21	2030	3	8	August   	34	21	3	Wednesday
2060	2030-08-22	2030	3	8	August   	34	22	4	Thursday 
2061	2030-08-23	2030	3	8	August   	34	23	5	Friday   
2062	2030-08-24	2030	3	8	August   	34	24	6	Saturday 
2063	2030-08-25	2030	3	8	August   	34	25	0	Sunday   
2064	2030-08-26	2030	3	8	August   	35	26	1	Monday   
2065	2030-08-27	2030	3	8	August   	35	27	2	Tuesday  
2066	2030-08-28	2030	3	8	August   	35	28	3	Wednesday
2067	2030-08-29	2030	3	8	August   	35	29	4	Thursday 
2068	2030-08-30	2030	3	8	August   	35	30	5	Friday   
2069	2030-08-31	2030	3	8	August   	35	31	6	Saturday 
2070	2030-09-01	2030	3	9	September	35	1	0	Sunday   
2071	2030-09-02	2030	3	9	September	36	2	1	Monday   
2072	2030-09-03	2030	3	9	September	36	3	2	Tuesday  
2073	2030-09-04	2030	3	9	September	36	4	3	Wednesday
2074	2030-09-05	2030	3	9	September	36	5	4	Thursday 
2075	2030-09-06	2030	3	9	September	36	6	5	Friday   
2076	2030-09-07	2030	3	9	September	36	7	6	Saturday 
2077	2030-09-08	2030	3	9	September	36	8	0	Sunday   
2078	2030-09-09	2030	3	9	September	37	9	1	Monday   
2079	2030-09-10	2030	3	9	September	37	10	2	Tuesday  
2080	2030-09-11	2030	3	9	September	37	11	3	Wednesday
2081	2030-09-12	2030	3	9	September	37	12	4	Thursday 
2082	2030-09-13	2030	3	9	September	37	13	5	Friday   
2083	2030-09-14	2030	3	9	September	37	14	6	Saturday 
2084	2030-09-15	2030	3	9	September	37	15	0	Sunday   
2085	2030-09-16	2030	3	9	September	38	16	1	Monday   
2086	2030-09-17	2030	3	9	September	38	17	2	Tuesday  
2087	2030-09-18	2030	3	9	September	38	18	3	Wednesday
2088	2030-09-19	2030	3	9	September	38	19	4	Thursday 
2089	2030-09-20	2030	3	9	September	38	20	5	Friday   
2090	2030-09-21	2030	3	9	September	38	21	6	Saturday 
2091	2030-09-22	2030	3	9	September	38	22	0	Sunday   
2092	2030-09-23	2030	3	9	September	39	23	1	Monday   
2093	2030-09-24	2030	3	9	September	39	24	2	Tuesday  
2094	2030-09-25	2030	3	9	September	39	25	3	Wednesday
2095	2030-09-26	2030	3	9	September	39	26	4	Thursday 
2096	2030-09-27	2030	3	9	September	39	27	5	Friday   
2097	2030-09-28	2030	3	9	September	39	28	6	Saturday 
2098	2030-09-29	2030	3	9	September	39	29	0	Sunday   
2099	2030-09-30	2030	3	9	September	40	30	1	Monday   
2100	2030-10-01	2030	4	10	October  	40	1	2	Tuesday  
2101	2030-10-02	2030	4	10	October  	40	2	3	Wednesday
2102	2030-10-03	2030	4	10	October  	40	3	4	Thursday 
2103	2030-10-04	2030	4	10	October  	40	4	5	Friday   
2104	2030-10-05	2030	4	10	October  	40	5	6	Saturday 
2105	2030-10-06	2030	4	10	October  	40	6	0	Sunday   
2106	2030-10-07	2030	4	10	October  	41	7	1	Monday   
2107	2030-10-08	2030	4	10	October  	41	8	2	Tuesday  
2108	2030-10-09	2030	4	10	October  	41	9	3	Wednesday
2109	2030-10-10	2030	4	10	October  	41	10	4	Thursday 
2110	2030-10-11	2030	4	10	October  	41	11	5	Friday   
2111	2030-10-12	2030	4	10	October  	41	12	6	Saturday 
2112	2030-10-13	2030	4	10	October  	41	13	0	Sunday   
2113	2030-10-14	2030	4	10	October  	42	14	1	Monday   
2114	2030-10-15	2030	4	10	October  	42	15	2	Tuesday  
2115	2030-10-16	2030	4	10	October  	42	16	3	Wednesday
2116	2030-10-17	2030	4	10	October  	42	17	4	Thursday 
2117	2030-10-18	2030	4	10	October  	42	18	5	Friday   
2118	2030-10-19	2030	4	10	October  	42	19	6	Saturday 
2119	2030-10-20	2030	4	10	October  	42	20	0	Sunday   
2120	2030-10-21	2030	4	10	October  	43	21	1	Monday   
2121	2030-10-22	2030	4	10	October  	43	22	2	Tuesday  
2122	2030-10-23	2030	4	10	October  	43	23	3	Wednesday
2123	2030-10-24	2030	4	10	October  	43	24	4	Thursday 
2124	2030-10-25	2030	4	10	October  	43	25	5	Friday   
2125	2030-10-26	2030	4	10	October  	43	26	6	Saturday 
2126	2030-10-27	2030	4	10	October  	43	27	0	Sunday   
2127	2030-10-28	2030	4	10	October  	44	28	1	Monday   
2128	2030-10-29	2030	4	10	October  	44	29	2	Tuesday  
2129	2030-10-30	2030	4	10	October  	44	30	3	Wednesday
2130	2030-10-31	2030	4	10	October  	44	31	4	Thursday 
2131	2030-11-01	2030	4	11	November 	44	1	5	Friday   
2132	2030-11-02	2030	4	11	November 	44	2	6	Saturday 
2133	2030-11-03	2030	4	11	November 	44	3	0	Sunday   
2134	2030-11-04	2030	4	11	November 	45	4	1	Monday   
2135	2030-11-05	2030	4	11	November 	45	5	2	Tuesday  
2136	2030-11-06	2030	4	11	November 	45	6	3	Wednesday
2137	2030-11-07	2030	4	11	November 	45	7	4	Thursday 
2138	2030-11-08	2030	4	11	November 	45	8	5	Friday   
2139	2030-11-09	2030	4	11	November 	45	9	6	Saturday 
2140	2030-11-10	2030	4	11	November 	45	10	0	Sunday   
2141	2030-11-11	2030	4	11	November 	46	11	1	Monday   
2142	2030-11-12	2030	4	11	November 	46	12	2	Tuesday  
2143	2030-11-13	2030	4	11	November 	46	13	3	Wednesday
2144	2030-11-14	2030	4	11	November 	46	14	4	Thursday 
2145	2030-11-15	2030	4	11	November 	46	15	5	Friday   
2146	2030-11-16	2030	4	11	November 	46	16	6	Saturday 
2147	2030-11-17	2030	4	11	November 	46	17	0	Sunday   
2148	2030-11-18	2030	4	11	November 	47	18	1	Monday   
2149	2030-11-19	2030	4	11	November 	47	19	2	Tuesday  
2150	2030-11-20	2030	4	11	November 	47	20	3	Wednesday
2151	2030-11-21	2030	4	11	November 	47	21	4	Thursday 
2152	2030-11-22	2030	4	11	November 	47	22	5	Friday   
2153	2030-11-23	2030	4	11	November 	47	23	6	Saturday 
2154	2030-11-24	2030	4	11	November 	47	24	0	Sunday   
2155	2030-11-25	2030	4	11	November 	48	25	1	Monday   
2156	2030-11-26	2030	4	11	November 	48	26	2	Tuesday  
2157	2030-11-27	2030	4	11	November 	48	27	3	Wednesday
2158	2030-11-28	2030	4	11	November 	48	28	4	Thursday 
2159	2030-11-29	2030	4	11	November 	48	29	5	Friday   
2160	2030-11-30	2030	4	11	November 	48	30	6	Saturday 
2161	2030-12-01	2030	4	12	December 	48	1	0	Sunday   
2162	2030-12-02	2030	4	12	December 	49	2	1	Monday   
2163	2030-12-03	2030	4	12	December 	49	3	2	Tuesday  
2164	2030-12-04	2030	4	12	December 	49	4	3	Wednesday
2165	2030-12-05	2030	4	12	December 	49	5	4	Thursday 
2166	2030-12-06	2030	4	12	December 	49	6	5	Friday   
2167	2030-12-07	2030	4	12	December 	49	7	6	Saturday 
2168	2030-12-08	2030	4	12	December 	49	8	0	Sunday   
2169	2030-12-09	2030	4	12	December 	50	9	1	Monday   
2170	2030-12-10	2030	4	12	December 	50	10	2	Tuesday  
2171	2030-12-11	2030	4	12	December 	50	11	3	Wednesday
2172	2030-12-12	2030	4	12	December 	50	12	4	Thursday 
2173	2030-12-13	2030	4	12	December 	50	13	5	Friday   
2174	2030-12-14	2030	4	12	December 	50	14	6	Saturday 
2175	2030-12-15	2030	4	12	December 	50	15	0	Sunday   
2176	2030-12-16	2030	4	12	December 	51	16	1	Monday   
2177	2030-12-17	2030	4	12	December 	51	17	2	Tuesday  
2178	2030-12-18	2030	4	12	December 	51	18	3	Wednesday
2179	2030-12-19	2030	4	12	December 	51	19	4	Thursday 
2180	2030-12-20	2030	4	12	December 	51	20	5	Friday   
2181	2030-12-21	2030	4	12	December 	51	21	6	Saturday 
2182	2030-12-22	2030	4	12	December 	51	22	0	Sunday   
2183	2030-12-23	2030	4	12	December 	52	23	1	Monday   
2184	2030-12-24	2030	4	12	December 	52	24	2	Tuesday  
2185	2030-12-25	2030	4	12	December 	52	25	3	Wednesday
2186	2030-12-26	2030	4	12	December 	52	26	4	Thursday 
2187	2030-12-27	2030	4	12	December 	52	27	5	Friday   
2188	2030-12-28	2030	4	12	December 	52	28	6	Saturday 
2189	2030-12-29	2030	4	12	December 	52	29	0	Sunday   
2190	2030-12-30	2030	4	12	December 	1	30	1	Monday   
2191	2030-12-31	2030	4	12	December 	1	31	2	Tuesday  
2192	2031-01-01	2031	1	1	January  	1	1	3	Wednesday
2193	2031-01-02	2031	1	1	January  	1	2	4	Thursday 
2194	2031-01-03	2031	1	1	January  	1	3	5	Friday   
2195	2031-01-04	2031	1	1	January  	1	4	6	Saturday 
2196	2031-01-05	2031	1	1	January  	1	5	0	Sunday   
2197	2031-01-06	2031	1	1	January  	2	6	1	Monday   
2198	2031-01-07	2031	1	1	January  	2	7	2	Tuesday  
2199	2031-01-08	2031	1	1	January  	2	8	3	Wednesday
2200	2031-01-09	2031	1	1	January  	2	9	4	Thursday 
2201	2031-01-10	2031	1	1	January  	2	10	5	Friday   
2202	2031-01-11	2031	1	1	January  	2	11	6	Saturday 
2203	2031-01-12	2031	1	1	January  	2	12	0	Sunday   
2204	2031-01-13	2031	1	1	January  	3	13	1	Monday   
2205	2031-01-14	2031	1	1	January  	3	14	2	Tuesday  
2206	2031-01-15	2031	1	1	January  	3	15	3	Wednesday
2207	2031-01-16	2031	1	1	January  	3	16	4	Thursday 
2208	2031-01-17	2031	1	1	January  	3	17	5	Friday   
2209	2031-01-18	2031	1	1	January  	3	18	6	Saturday 
2210	2031-01-19	2031	1	1	January  	3	19	0	Sunday   
2211	2031-01-20	2031	1	1	January  	4	20	1	Monday   
2212	2031-01-21	2031	1	1	January  	4	21	2	Tuesday  
2213	2031-01-22	2031	1	1	January  	4	22	3	Wednesday
2214	2031-01-23	2031	1	1	January  	4	23	4	Thursday 
2215	2031-01-24	2031	1	1	January  	4	24	5	Friday   
2216	2031-01-25	2031	1	1	January  	4	25	6	Saturday 
2217	2031-01-26	2031	1	1	January  	4	26	0	Sunday   
2218	2031-01-27	2031	1	1	January  	5	27	1	Monday   
2219	2031-01-28	2031	1	1	January  	5	28	2	Tuesday  
2220	2031-01-29	2031	1	1	January  	5	29	3	Wednesday
2221	2031-01-30	2031	1	1	January  	5	30	4	Thursday 
2222	2031-01-31	2031	1	1	January  	5	31	5	Friday   
2223	2031-02-01	2031	1	2	February 	5	1	6	Saturday 
2224	2031-02-02	2031	1	2	February 	5	2	0	Sunday   
2225	2031-02-03	2031	1	2	February 	6	3	1	Monday   
2226	2031-02-04	2031	1	2	February 	6	4	2	Tuesday  
2227	2031-02-05	2031	1	2	February 	6	5	3	Wednesday
2228	2031-02-06	2031	1	2	February 	6	6	4	Thursday 
2229	2031-02-07	2031	1	2	February 	6	7	5	Friday   
2230	2031-02-08	2031	1	2	February 	6	8	6	Saturday 
2231	2031-02-09	2031	1	2	February 	6	9	0	Sunday   
2232	2031-02-10	2031	1	2	February 	7	10	1	Monday   
2233	2031-02-11	2031	1	2	February 	7	11	2	Tuesday  
2234	2031-02-12	2031	1	2	February 	7	12	3	Wednesday
2235	2031-02-13	2031	1	2	February 	7	13	4	Thursday 
2236	2031-02-14	2031	1	2	February 	7	14	5	Friday   
2237	2031-02-15	2031	1	2	February 	7	15	6	Saturday 
2238	2031-02-16	2031	1	2	February 	7	16	0	Sunday   
2239	2031-02-17	2031	1	2	February 	8	17	1	Monday   
2240	2031-02-18	2031	1	2	February 	8	18	2	Tuesday  
2241	2031-02-19	2031	1	2	February 	8	19	3	Wednesday
2242	2031-02-20	2031	1	2	February 	8	20	4	Thursday 
2243	2031-02-21	2031	1	2	February 	8	21	5	Friday   
2244	2031-02-22	2031	1	2	February 	8	22	6	Saturday 
2245	2031-02-23	2031	1	2	February 	8	23	0	Sunday   
2246	2031-02-24	2031	1	2	February 	9	24	1	Monday   
2247	2031-02-25	2031	1	2	February 	9	25	2	Tuesday  
2248	2031-02-26	2031	1	2	February 	9	26	3	Wednesday
2249	2031-02-27	2031	1	2	February 	9	27	4	Thursday 
2250	2031-02-28	2031	1	2	February 	9	28	5	Friday   
2251	2031-03-01	2031	1	3	March    	9	1	6	Saturday 
2252	2031-03-02	2031	1	3	March    	9	2	0	Sunday   
2253	2031-03-03	2031	1	3	March    	10	3	1	Monday   
2254	2031-03-04	2031	1	3	March    	10	4	2	Tuesday  
2255	2031-03-05	2031	1	3	March    	10	5	3	Wednesday
2256	2031-03-06	2031	1	3	March    	10	6	4	Thursday 
2257	2031-03-07	2031	1	3	March    	10	7	5	Friday   
2258	2031-03-08	2031	1	3	March    	10	8	6	Saturday 
2259	2031-03-09	2031	1	3	March    	10	9	0	Sunday   
2260	2031-03-10	2031	1	3	March    	11	10	1	Monday   
2261	2031-03-11	2031	1	3	March    	11	11	2	Tuesday  
2262	2031-03-12	2031	1	3	March    	11	12	3	Wednesday
2263	2031-03-13	2031	1	3	March    	11	13	4	Thursday 
2264	2031-03-14	2031	1	3	March    	11	14	5	Friday   
2265	2031-03-15	2031	1	3	March    	11	15	6	Saturday 
2266	2031-03-16	2031	1	3	March    	11	16	0	Sunday   
2267	2031-03-17	2031	1	3	March    	12	17	1	Monday   
2268	2031-03-18	2031	1	3	March    	12	18	2	Tuesday  
2269	2031-03-19	2031	1	3	March    	12	19	3	Wednesday
2270	2031-03-20	2031	1	3	March    	12	20	4	Thursday 
2271	2031-03-21	2031	1	3	March    	12	21	5	Friday   
2272	2031-03-22	2031	1	3	March    	12	22	6	Saturday 
2273	2031-03-23	2031	1	3	March    	12	23	0	Sunday   
2274	2031-03-24	2031	1	3	March    	13	24	1	Monday   
2275	2031-03-25	2031	1	3	March    	13	25	2	Tuesday  
2276	2031-03-26	2031	1	3	March    	13	26	3	Wednesday
2277	2031-03-27	2031	1	3	March    	13	27	4	Thursday 
2278	2031-03-28	2031	1	3	March    	13	28	5	Friday   
2279	2031-03-29	2031	1	3	March    	13	29	6	Saturday 
2280	2031-03-30	2031	1	3	March    	13	30	0	Sunday   
2281	2031-03-31	2031	1	3	March    	14	31	1	Monday   
2282	2031-04-01	2031	2	4	April    	14	1	2	Tuesday  
2283	2031-04-02	2031	2	4	April    	14	2	3	Wednesday
2284	2031-04-03	2031	2	4	April    	14	3	4	Thursday 
2285	2031-04-04	2031	2	4	April    	14	4	5	Friday   
2286	2031-04-05	2031	2	4	April    	14	5	6	Saturday 
2287	2031-04-06	2031	2	4	April    	14	6	0	Sunday   
2288	2031-04-07	2031	2	4	April    	15	7	1	Monday   
2289	2031-04-08	2031	2	4	April    	15	8	2	Tuesday  
2290	2031-04-09	2031	2	4	April    	15	9	3	Wednesday
2291	2031-04-10	2031	2	4	April    	15	10	4	Thursday 
2292	2031-04-11	2031	2	4	April    	15	11	5	Friday   
2293	2031-04-12	2031	2	4	April    	15	12	6	Saturday 
2294	2031-04-13	2031	2	4	April    	15	13	0	Sunday   
2295	2031-04-14	2031	2	4	April    	16	14	1	Monday   
2296	2031-04-15	2031	2	4	April    	16	15	2	Tuesday  
2297	2031-04-16	2031	2	4	April    	16	16	3	Wednesday
2298	2031-04-17	2031	2	4	April    	16	17	4	Thursday 
2299	2031-04-18	2031	2	4	April    	16	18	5	Friday   
2300	2031-04-19	2031	2	4	April    	16	19	6	Saturday 
2301	2031-04-20	2031	2	4	April    	16	20	0	Sunday   
2302	2031-04-21	2031	2	4	April    	17	21	1	Monday   
2303	2031-04-22	2031	2	4	April    	17	22	2	Tuesday  
2304	2031-04-23	2031	2	4	April    	17	23	3	Wednesday
2305	2031-04-24	2031	2	4	April    	17	24	4	Thursday 
2306	2031-04-25	2031	2	4	April    	17	25	5	Friday   
2307	2031-04-26	2031	2	4	April    	17	26	6	Saturday 
2308	2031-04-27	2031	2	4	April    	17	27	0	Sunday   
2309	2031-04-28	2031	2	4	April    	18	28	1	Monday   
2310	2031-04-29	2031	2	4	April    	18	29	2	Tuesday  
2311	2031-04-30	2031	2	4	April    	18	30	3	Wednesday
2312	2031-05-01	2031	2	5	May      	18	1	4	Thursday 
2313	2031-05-02	2031	2	5	May      	18	2	5	Friday   
2314	2031-05-03	2031	2	5	May      	18	3	6	Saturday 
2315	2031-05-04	2031	2	5	May      	18	4	0	Sunday   
2316	2031-05-05	2031	2	5	May      	19	5	1	Monday   
2317	2031-05-06	2031	2	5	May      	19	6	2	Tuesday  
2318	2031-05-07	2031	2	5	May      	19	7	3	Wednesday
2319	2031-05-08	2031	2	5	May      	19	8	4	Thursday 
2320	2031-05-09	2031	2	5	May      	19	9	5	Friday   
2321	2031-05-10	2031	2	5	May      	19	10	6	Saturday 
2322	2031-05-11	2031	2	5	May      	19	11	0	Sunday   
2323	2031-05-12	2031	2	5	May      	20	12	1	Monday   
2324	2031-05-13	2031	2	5	May      	20	13	2	Tuesday  
2325	2031-05-14	2031	2	5	May      	20	14	3	Wednesday
2326	2031-05-15	2031	2	5	May      	20	15	4	Thursday 
2327	2031-05-16	2031	2	5	May      	20	16	5	Friday   
2328	2031-05-17	2031	2	5	May      	20	17	6	Saturday 
2329	2031-05-18	2031	2	5	May      	20	18	0	Sunday   
2330	2031-05-19	2031	2	5	May      	21	19	1	Monday   
2331	2031-05-20	2031	2	5	May      	21	20	2	Tuesday  
2332	2031-05-21	2031	2	5	May      	21	21	3	Wednesday
2333	2031-05-22	2031	2	5	May      	21	22	4	Thursday 
2334	2031-05-23	2031	2	5	May      	21	23	5	Friday   
2335	2031-05-24	2031	2	5	May      	21	24	6	Saturday 
2336	2031-05-25	2031	2	5	May      	21	25	0	Sunday   
2337	2031-05-26	2031	2	5	May      	22	26	1	Monday   
2338	2031-05-27	2031	2	5	May      	22	27	2	Tuesday  
2339	2031-05-28	2031	2	5	May      	22	28	3	Wednesday
2340	2031-05-29	2031	2	5	May      	22	29	4	Thursday 
2341	2031-05-30	2031	2	5	May      	22	30	5	Friday   
2342	2031-05-31	2031	2	5	May      	22	31	6	Saturday 
2343	2031-06-01	2031	2	6	June     	22	1	0	Sunday   
2344	2031-06-02	2031	2	6	June     	23	2	1	Monday   
2345	2031-06-03	2031	2	6	June     	23	3	2	Tuesday  
2346	2031-06-04	2031	2	6	June     	23	4	3	Wednesday
2347	2031-06-05	2031	2	6	June     	23	5	4	Thursday 
2348	2031-06-06	2031	2	6	June     	23	6	5	Friday   
2349	2031-06-07	2031	2	6	June     	23	7	6	Saturday 
2350	2031-06-08	2031	2	6	June     	23	8	0	Sunday   
2351	2031-06-09	2031	2	6	June     	24	9	1	Monday   
2352	2031-06-10	2031	2	6	June     	24	10	2	Tuesday  
2353	2031-06-11	2031	2	6	June     	24	11	3	Wednesday
2354	2031-06-12	2031	2	6	June     	24	12	4	Thursday 
2355	2031-06-13	2031	2	6	June     	24	13	5	Friday   
2356	2031-06-14	2031	2	6	June     	24	14	6	Saturday 
2357	2031-06-15	2031	2	6	June     	24	15	0	Sunday   
2358	2031-06-16	2031	2	6	June     	25	16	1	Monday   
2359	2031-06-17	2031	2	6	June     	25	17	2	Tuesday  
2360	2031-06-18	2031	2	6	June     	25	18	3	Wednesday
2361	2031-06-19	2031	2	6	June     	25	19	4	Thursday 
2362	2031-06-20	2031	2	6	June     	25	20	5	Friday   
2363	2031-06-21	2031	2	6	June     	25	21	6	Saturday 
2364	2031-06-22	2031	2	6	June     	25	22	0	Sunday   
2365	2031-06-23	2031	2	6	June     	26	23	1	Monday   
2366	2031-06-24	2031	2	6	June     	26	24	2	Tuesday  
2367	2031-06-25	2031	2	6	June     	26	25	3	Wednesday
2368	2031-06-26	2031	2	6	June     	26	26	4	Thursday 
2369	2031-06-27	2031	2	6	June     	26	27	5	Friday   
2370	2031-06-28	2031	2	6	June     	26	28	6	Saturday 
2371	2031-06-29	2031	2	6	June     	26	29	0	Sunday   
2372	2031-06-30	2031	2	6	June     	27	30	1	Monday   
2373	2031-07-01	2031	3	7	July     	27	1	2	Tuesday  
2374	2031-07-02	2031	3	7	July     	27	2	3	Wednesday
2375	2031-07-03	2031	3	7	July     	27	3	4	Thursday 
2376	2031-07-04	2031	3	7	July     	27	4	5	Friday   
2377	2031-07-05	2031	3	7	July     	27	5	6	Saturday 
2378	2031-07-06	2031	3	7	July     	27	6	0	Sunday   
2379	2031-07-07	2031	3	7	July     	28	7	1	Monday   
2380	2031-07-08	2031	3	7	July     	28	8	2	Tuesday  
2381	2031-07-09	2031	3	7	July     	28	9	3	Wednesday
2382	2031-07-10	2031	3	7	July     	28	10	4	Thursday 
2383	2031-07-11	2031	3	7	July     	28	11	5	Friday   
2384	2031-07-12	2031	3	7	July     	28	12	6	Saturday 
2385	2031-07-13	2031	3	7	July     	28	13	0	Sunday   
2386	2031-07-14	2031	3	7	July     	29	14	1	Monday   
2387	2031-07-15	2031	3	7	July     	29	15	2	Tuesday  
2388	2031-07-16	2031	3	7	July     	29	16	3	Wednesday
2389	2031-07-17	2031	3	7	July     	29	17	4	Thursday 
2390	2031-07-18	2031	3	7	July     	29	18	5	Friday   
2391	2031-07-19	2031	3	7	July     	29	19	6	Saturday 
2392	2031-07-20	2031	3	7	July     	29	20	0	Sunday   
2393	2031-07-21	2031	3	7	July     	30	21	1	Monday   
2394	2031-07-22	2031	3	7	July     	30	22	2	Tuesday  
2395	2031-07-23	2031	3	7	July     	30	23	3	Wednesday
2396	2031-07-24	2031	3	7	July     	30	24	4	Thursday 
2397	2031-07-25	2031	3	7	July     	30	25	5	Friday   
2398	2031-07-26	2031	3	7	July     	30	26	6	Saturday 
2399	2031-07-27	2031	3	7	July     	30	27	0	Sunday   
2400	2031-07-28	2031	3	7	July     	31	28	1	Monday   
2401	2031-07-29	2031	3	7	July     	31	29	2	Tuesday  
2402	2031-07-30	2031	3	7	July     	31	30	3	Wednesday
2403	2031-07-31	2031	3	7	July     	31	31	4	Thursday 
2404	2031-08-01	2031	3	8	August   	31	1	5	Friday   
2405	2031-08-02	2031	3	8	August   	31	2	6	Saturday 
2406	2031-08-03	2031	3	8	August   	31	3	0	Sunday   
2407	2031-08-04	2031	3	8	August   	32	4	1	Monday   
2408	2031-08-05	2031	3	8	August   	32	5	2	Tuesday  
2409	2031-08-06	2031	3	8	August   	32	6	3	Wednesday
2410	2031-08-07	2031	3	8	August   	32	7	4	Thursday 
2411	2031-08-08	2031	3	8	August   	32	8	5	Friday   
2412	2031-08-09	2031	3	8	August   	32	9	6	Saturday 
2413	2031-08-10	2031	3	8	August   	32	10	0	Sunday   
2414	2031-08-11	2031	3	8	August   	33	11	1	Monday   
2415	2031-08-12	2031	3	8	August   	33	12	2	Tuesday  
2416	2031-08-13	2031	3	8	August   	33	13	3	Wednesday
2417	2031-08-14	2031	3	8	August   	33	14	4	Thursday 
2418	2031-08-15	2031	3	8	August   	33	15	5	Friday   
2419	2031-08-16	2031	3	8	August   	33	16	6	Saturday 
2420	2031-08-17	2031	3	8	August   	33	17	0	Sunday   
2421	2031-08-18	2031	3	8	August   	34	18	1	Monday   
2422	2031-08-19	2031	3	8	August   	34	19	2	Tuesday  
2423	2031-08-20	2031	3	8	August   	34	20	3	Wednesday
2424	2031-08-21	2031	3	8	August   	34	21	4	Thursday 
2425	2031-08-22	2031	3	8	August   	34	22	5	Friday   
2426	2031-08-23	2031	3	8	August   	34	23	6	Saturday 
2427	2031-08-24	2031	3	8	August   	34	24	0	Sunday   
2428	2031-08-25	2031	3	8	August   	35	25	1	Monday   
2429	2031-08-26	2031	3	8	August   	35	26	2	Tuesday  
2430	2031-08-27	2031	3	8	August   	35	27	3	Wednesday
2431	2031-08-28	2031	3	8	August   	35	28	4	Thursday 
2432	2031-08-29	2031	3	8	August   	35	29	5	Friday   
2433	2031-08-30	2031	3	8	August   	35	30	6	Saturday 
2434	2031-08-31	2031	3	8	August   	35	31	0	Sunday   
2435	2031-09-01	2031	3	9	September	36	1	1	Monday   
2436	2031-09-02	2031	3	9	September	36	2	2	Tuesday  
2437	2031-09-03	2031	3	9	September	36	3	3	Wednesday
2438	2031-09-04	2031	3	9	September	36	4	4	Thursday 
2439	2031-09-05	2031	3	9	September	36	5	5	Friday   
2440	2031-09-06	2031	3	9	September	36	6	6	Saturday 
2441	2031-09-07	2031	3	9	September	36	7	0	Sunday   
2442	2031-09-08	2031	3	9	September	37	8	1	Monday   
2443	2031-09-09	2031	3	9	September	37	9	2	Tuesday  
2444	2031-09-10	2031	3	9	September	37	10	3	Wednesday
2445	2031-09-11	2031	3	9	September	37	11	4	Thursday 
2446	2031-09-12	2031	3	9	September	37	12	5	Friday   
2447	2031-09-13	2031	3	9	September	37	13	6	Saturday 
2448	2031-09-14	2031	3	9	September	37	14	0	Sunday   
2449	2031-09-15	2031	3	9	September	38	15	1	Monday   
2450	2031-09-16	2031	3	9	September	38	16	2	Tuesday  
2451	2031-09-17	2031	3	9	September	38	17	3	Wednesday
2452	2031-09-18	2031	3	9	September	38	18	4	Thursday 
2453	2031-09-19	2031	3	9	September	38	19	5	Friday   
2454	2031-09-20	2031	3	9	September	38	20	6	Saturday 
2455	2031-09-21	2031	3	9	September	38	21	0	Sunday   
2456	2031-09-22	2031	3	9	September	39	22	1	Monday   
2457	2031-09-23	2031	3	9	September	39	23	2	Tuesday  
2458	2031-09-24	2031	3	9	September	39	24	3	Wednesday
2459	2031-09-25	2031	3	9	September	39	25	4	Thursday 
2460	2031-09-26	2031	3	9	September	39	26	5	Friday   
2461	2031-09-27	2031	3	9	September	39	27	6	Saturday 
2462	2031-09-28	2031	3	9	September	39	28	0	Sunday   
2463	2031-09-29	2031	3	9	September	40	29	1	Monday   
2464	2031-09-30	2031	3	9	September	40	30	2	Tuesday  
2465	2031-10-01	2031	4	10	October  	40	1	3	Wednesday
2466	2031-10-02	2031	4	10	October  	40	2	4	Thursday 
2467	2031-10-03	2031	4	10	October  	40	3	5	Friday   
2468	2031-10-04	2031	4	10	October  	40	4	6	Saturday 
2469	2031-10-05	2031	4	10	October  	40	5	0	Sunday   
2470	2031-10-06	2031	4	10	October  	41	6	1	Monday   
2471	2031-10-07	2031	4	10	October  	41	7	2	Tuesday  
2472	2031-10-08	2031	4	10	October  	41	8	3	Wednesday
2473	2031-10-09	2031	4	10	October  	41	9	4	Thursday 
2474	2031-10-10	2031	4	10	October  	41	10	5	Friday   
2475	2031-10-11	2031	4	10	October  	41	11	6	Saturday 
2476	2031-10-12	2031	4	10	October  	41	12	0	Sunday   
2477	2031-10-13	2031	4	10	October  	42	13	1	Monday   
2478	2031-10-14	2031	4	10	October  	42	14	2	Tuesday  
2479	2031-10-15	2031	4	10	October  	42	15	3	Wednesday
2480	2031-10-16	2031	4	10	October  	42	16	4	Thursday 
2481	2031-10-17	2031	4	10	October  	42	17	5	Friday   
2482	2031-10-18	2031	4	10	October  	42	18	6	Saturday 
2483	2031-10-19	2031	4	10	October  	42	19	0	Sunday   
2484	2031-10-20	2031	4	10	October  	43	20	1	Monday   
2485	2031-10-21	2031	4	10	October  	43	21	2	Tuesday  
2486	2031-10-22	2031	4	10	October  	43	22	3	Wednesday
2487	2031-10-23	2031	4	10	October  	43	23	4	Thursday 
2488	2031-10-24	2031	4	10	October  	43	24	5	Friday   
2489	2031-10-25	2031	4	10	October  	43	25	6	Saturday 
2490	2031-10-26	2031	4	10	October  	43	26	0	Sunday   
2491	2031-10-27	2031	4	10	October  	44	27	1	Monday   
2492	2031-10-28	2031	4	10	October  	44	28	2	Tuesday  
2493	2031-10-29	2031	4	10	October  	44	29	3	Wednesday
2494	2031-10-30	2031	4	10	October  	44	30	4	Thursday 
2495	2031-10-31	2031	4	10	October  	44	31	5	Friday   
2496	2031-11-01	2031	4	11	November 	44	1	6	Saturday 
2497	2031-11-02	2031	4	11	November 	44	2	0	Sunday   
2498	2031-11-03	2031	4	11	November 	45	3	1	Monday   
2499	2031-11-04	2031	4	11	November 	45	4	2	Tuesday  
2500	2031-11-05	2031	4	11	November 	45	5	3	Wednesday
2501	2031-11-06	2031	4	11	November 	45	6	4	Thursday 
2502	2031-11-07	2031	4	11	November 	45	7	5	Friday   
2503	2031-11-08	2031	4	11	November 	45	8	6	Saturday 
2504	2031-11-09	2031	4	11	November 	45	9	0	Sunday   
2505	2031-11-10	2031	4	11	November 	46	10	1	Monday   
2506	2031-11-11	2031	4	11	November 	46	11	2	Tuesday  
2507	2031-11-12	2031	4	11	November 	46	12	3	Wednesday
2508	2031-11-13	2031	4	11	November 	46	13	4	Thursday 
2509	2031-11-14	2031	4	11	November 	46	14	5	Friday   
2510	2031-11-15	2031	4	11	November 	46	15	6	Saturday 
2511	2031-11-16	2031	4	11	November 	46	16	0	Sunday   
2512	2031-11-17	2031	4	11	November 	47	17	1	Monday   
2513	2031-11-18	2031	4	11	November 	47	18	2	Tuesday  
2514	2031-11-19	2031	4	11	November 	47	19	3	Wednesday
2515	2031-11-20	2031	4	11	November 	47	20	4	Thursday 
2516	2031-11-21	2031	4	11	November 	47	21	5	Friday   
2517	2031-11-22	2031	4	11	November 	47	22	6	Saturday 
2518	2031-11-23	2031	4	11	November 	47	23	0	Sunday   
2519	2031-11-24	2031	4	11	November 	48	24	1	Monday   
2520	2031-11-25	2031	4	11	November 	48	25	2	Tuesday  
2521	2031-11-26	2031	4	11	November 	48	26	3	Wednesday
2522	2031-11-27	2031	4	11	November 	48	27	4	Thursday 
2523	2031-11-28	2031	4	11	November 	48	28	5	Friday   
2524	2031-11-29	2031	4	11	November 	48	29	6	Saturday 
2525	2031-11-30	2031	4	11	November 	48	30	0	Sunday   
2526	2031-12-01	2031	4	12	December 	49	1	1	Monday   
2527	2031-12-02	2031	4	12	December 	49	2	2	Tuesday  
2528	2031-12-03	2031	4	12	December 	49	3	3	Wednesday
2529	2031-12-04	2031	4	12	December 	49	4	4	Thursday 
2530	2031-12-05	2031	4	12	December 	49	5	5	Friday   
2531	2031-12-06	2031	4	12	December 	49	6	6	Saturday 
2532	2031-12-07	2031	4	12	December 	49	7	0	Sunday   
2533	2031-12-08	2031	4	12	December 	50	8	1	Monday   
2534	2031-12-09	2031	4	12	December 	50	9	2	Tuesday  
2535	2031-12-10	2031	4	12	December 	50	10	3	Wednesday
2536	2031-12-11	2031	4	12	December 	50	11	4	Thursday 
2537	2031-12-12	2031	4	12	December 	50	12	5	Friday   
2538	2031-12-13	2031	4	12	December 	50	13	6	Saturday 
2539	2031-12-14	2031	4	12	December 	50	14	0	Sunday   
2540	2031-12-15	2031	4	12	December 	51	15	1	Monday   
2541	2031-12-16	2031	4	12	December 	51	16	2	Tuesday  
2542	2031-12-17	2031	4	12	December 	51	17	3	Wednesday
2543	2031-12-18	2031	4	12	December 	51	18	4	Thursday 
2544	2031-12-19	2031	4	12	December 	51	19	5	Friday   
2545	2031-12-20	2031	4	12	December 	51	20	6	Saturday 
2546	2031-12-21	2031	4	12	December 	51	21	0	Sunday   
2547	2031-12-22	2031	4	12	December 	52	22	1	Monday   
2548	2031-12-23	2031	4	12	December 	52	23	2	Tuesday  
2549	2031-12-24	2031	4	12	December 	52	24	3	Wednesday
2550	2031-12-25	2031	4	12	December 	52	25	4	Thursday 
2551	2031-12-26	2031	4	12	December 	52	26	5	Friday   
2552	2031-12-27	2031	4	12	December 	52	27	6	Saturday 
2553	2031-12-28	2031	4	12	December 	52	28	0	Sunday   
2554	2031-12-29	2031	4	12	December 	1	29	1	Monday   
2555	2031-12-30	2031	4	12	December 	1	30	2	Tuesday  
2556	2031-12-31	2031	4	12	December 	1	31	3	Wednesday
2557	2032-01-01	2032	1	1	January  	1	1	4	Thursday 
2558	2032-01-02	2032	1	1	January  	1	2	5	Friday   
2559	2032-01-03	2032	1	1	January  	1	3	6	Saturday 
2560	2032-01-04	2032	1	1	January  	1	4	0	Sunday   
2561	2032-01-05	2032	1	1	January  	2	5	1	Monday   
2562	2032-01-06	2032	1	1	January  	2	6	2	Tuesday  
2563	2032-01-07	2032	1	1	January  	2	7	3	Wednesday
2564	2032-01-08	2032	1	1	January  	2	8	4	Thursday 
2565	2032-01-09	2032	1	1	January  	2	9	5	Friday   
2566	2032-01-10	2032	1	1	January  	2	10	6	Saturday 
2567	2032-01-11	2032	1	1	January  	2	11	0	Sunday   
2568	2032-01-12	2032	1	1	January  	3	12	1	Monday   
2569	2032-01-13	2032	1	1	January  	3	13	2	Tuesday  
2570	2032-01-14	2032	1	1	January  	3	14	3	Wednesday
2571	2032-01-15	2032	1	1	January  	3	15	4	Thursday 
2572	2032-01-16	2032	1	1	January  	3	16	5	Friday   
2573	2032-01-17	2032	1	1	January  	3	17	6	Saturday 
2574	2032-01-18	2032	1	1	January  	3	18	0	Sunday   
2575	2032-01-19	2032	1	1	January  	4	19	1	Monday   
2576	2032-01-20	2032	1	1	January  	4	20	2	Tuesday  
2577	2032-01-21	2032	1	1	January  	4	21	3	Wednesday
2578	2032-01-22	2032	1	1	January  	4	22	4	Thursday 
2579	2032-01-23	2032	1	1	January  	4	23	5	Friday   
2580	2032-01-24	2032	1	1	January  	4	24	6	Saturday 
2581	2032-01-25	2032	1	1	January  	4	25	0	Sunday   
2582	2032-01-26	2032	1	1	January  	5	26	1	Monday   
2583	2032-01-27	2032	1	1	January  	5	27	2	Tuesday  
2584	2032-01-28	2032	1	1	January  	5	28	3	Wednesday
2585	2032-01-29	2032	1	1	January  	5	29	4	Thursday 
2586	2032-01-30	2032	1	1	January  	5	30	5	Friday   
2587	2032-01-31	2032	1	1	January  	5	31	6	Saturday 
2588	2032-02-01	2032	1	2	February 	5	1	0	Sunday   
2589	2032-02-02	2032	1	2	February 	6	2	1	Monday   
2590	2032-02-03	2032	1	2	February 	6	3	2	Tuesday  
2591	2032-02-04	2032	1	2	February 	6	4	3	Wednesday
2592	2032-02-05	2032	1	2	February 	6	5	4	Thursday 
2593	2032-02-06	2032	1	2	February 	6	6	5	Friday   
2594	2032-02-07	2032	1	2	February 	6	7	6	Saturday 
2595	2032-02-08	2032	1	2	February 	6	8	0	Sunday   
2596	2032-02-09	2032	1	2	February 	7	9	1	Monday   
2597	2032-02-10	2032	1	2	February 	7	10	2	Tuesday  
2598	2032-02-11	2032	1	2	February 	7	11	3	Wednesday
2599	2032-02-12	2032	1	2	February 	7	12	4	Thursday 
2600	2032-02-13	2032	1	2	February 	7	13	5	Friday   
2601	2032-02-14	2032	1	2	February 	7	14	6	Saturday 
2602	2032-02-15	2032	1	2	February 	7	15	0	Sunday   
2603	2032-02-16	2032	1	2	February 	8	16	1	Monday   
2604	2032-02-17	2032	1	2	February 	8	17	2	Tuesday  
2605	2032-02-18	2032	1	2	February 	8	18	3	Wednesday
2606	2032-02-19	2032	1	2	February 	8	19	4	Thursday 
2607	2032-02-20	2032	1	2	February 	8	20	5	Friday   
2608	2032-02-21	2032	1	2	February 	8	21	6	Saturday 
2609	2032-02-22	2032	1	2	February 	8	22	0	Sunday   
2610	2032-02-23	2032	1	2	February 	9	23	1	Monday   
2611	2032-02-24	2032	1	2	February 	9	24	2	Tuesday  
2612	2032-02-25	2032	1	2	February 	9	25	3	Wednesday
2613	2032-02-26	2032	1	2	February 	9	26	4	Thursday 
2614	2032-02-27	2032	1	2	February 	9	27	5	Friday   
2615	2032-02-28	2032	1	2	February 	9	28	6	Saturday 
2616	2032-02-29	2032	1	2	February 	9	29	0	Sunday   
2617	2032-03-01	2032	1	3	March    	10	1	1	Monday   
2618	2032-03-02	2032	1	3	March    	10	2	2	Tuesday  
2619	2032-03-03	2032	1	3	March    	10	3	3	Wednesday
2620	2032-03-04	2032	1	3	March    	10	4	4	Thursday 
2621	2032-03-05	2032	1	3	March    	10	5	5	Friday   
2622	2032-03-06	2032	1	3	March    	10	6	6	Saturday 
2623	2032-03-07	2032	1	3	March    	10	7	0	Sunday   
2624	2032-03-08	2032	1	3	March    	11	8	1	Monday   
2625	2032-03-09	2032	1	3	March    	11	9	2	Tuesday  
2626	2032-03-10	2032	1	3	March    	11	10	3	Wednesday
2627	2032-03-11	2032	1	3	March    	11	11	4	Thursday 
2628	2032-03-12	2032	1	3	March    	11	12	5	Friday   
2629	2032-03-13	2032	1	3	March    	11	13	6	Saturday 
2630	2032-03-14	2032	1	3	March    	11	14	0	Sunday   
2631	2032-03-15	2032	1	3	March    	12	15	1	Monday   
2632	2032-03-16	2032	1	3	March    	12	16	2	Tuesday  
2633	2032-03-17	2032	1	3	March    	12	17	3	Wednesday
2634	2032-03-18	2032	1	3	March    	12	18	4	Thursday 
2635	2032-03-19	2032	1	3	March    	12	19	5	Friday   
2636	2032-03-20	2032	1	3	March    	12	20	6	Saturday 
2637	2032-03-21	2032	1	3	March    	12	21	0	Sunday   
2638	2032-03-22	2032	1	3	March    	13	22	1	Monday   
2639	2032-03-23	2032	1	3	March    	13	23	2	Tuesday  
2640	2032-03-24	2032	1	3	March    	13	24	3	Wednesday
2641	2032-03-25	2032	1	3	March    	13	25	4	Thursday 
2642	2032-03-26	2032	1	3	March    	13	26	5	Friday   
2643	2032-03-27	2032	1	3	March    	13	27	6	Saturday 
2644	2032-03-28	2032	1	3	March    	13	28	0	Sunday   
2645	2032-03-29	2032	1	3	March    	14	29	1	Monday   
2646	2032-03-30	2032	1	3	March    	14	30	2	Tuesday  
2647	2032-03-31	2032	1	3	March    	14	31	3	Wednesday
2648	2032-04-01	2032	2	4	April    	14	1	4	Thursday 
2649	2032-04-02	2032	2	4	April    	14	2	5	Friday   
2650	2032-04-03	2032	2	4	April    	14	3	6	Saturday 
2651	2032-04-04	2032	2	4	April    	14	4	0	Sunday   
2652	2032-04-05	2032	2	4	April    	15	5	1	Monday   
2653	2032-04-06	2032	2	4	April    	15	6	2	Tuesday  
2654	2032-04-07	2032	2	4	April    	15	7	3	Wednesday
2655	2032-04-08	2032	2	4	April    	15	8	4	Thursday 
2656	2032-04-09	2032	2	4	April    	15	9	5	Friday   
2657	2032-04-10	2032	2	4	April    	15	10	6	Saturday 
2658	2032-04-11	2032	2	4	April    	15	11	0	Sunday   
2659	2032-04-12	2032	2	4	April    	16	12	1	Monday   
2660	2032-04-13	2032	2	4	April    	16	13	2	Tuesday  
2661	2032-04-14	2032	2	4	April    	16	14	3	Wednesday
2662	2032-04-15	2032	2	4	April    	16	15	4	Thursday 
2663	2032-04-16	2032	2	4	April    	16	16	5	Friday   
2664	2032-04-17	2032	2	4	April    	16	17	6	Saturday 
2665	2032-04-18	2032	2	4	April    	16	18	0	Sunday   
2666	2032-04-19	2032	2	4	April    	17	19	1	Monday   
2667	2032-04-20	2032	2	4	April    	17	20	2	Tuesday  
2668	2032-04-21	2032	2	4	April    	17	21	3	Wednesday
2669	2032-04-22	2032	2	4	April    	17	22	4	Thursday 
2670	2032-04-23	2032	2	4	April    	17	23	5	Friday   
2671	2032-04-24	2032	2	4	April    	17	24	6	Saturday 
2672	2032-04-25	2032	2	4	April    	17	25	0	Sunday   
2673	2032-04-26	2032	2	4	April    	18	26	1	Monday   
2674	2032-04-27	2032	2	4	April    	18	27	2	Tuesday  
2675	2032-04-28	2032	2	4	April    	18	28	3	Wednesday
2676	2032-04-29	2032	2	4	April    	18	29	4	Thursday 
2677	2032-04-30	2032	2	4	April    	18	30	5	Friday   
2678	2032-05-01	2032	2	5	May      	18	1	6	Saturday 
2679	2032-05-02	2032	2	5	May      	18	2	0	Sunday   
2680	2032-05-03	2032	2	5	May      	19	3	1	Monday   
2681	2032-05-04	2032	2	5	May      	19	4	2	Tuesday  
2682	2032-05-05	2032	2	5	May      	19	5	3	Wednesday
2683	2032-05-06	2032	2	5	May      	19	6	4	Thursday 
2684	2032-05-07	2032	2	5	May      	19	7	5	Friday   
2685	2032-05-08	2032	2	5	May      	19	8	6	Saturday 
2686	2032-05-09	2032	2	5	May      	19	9	0	Sunday   
2687	2032-05-10	2032	2	5	May      	20	10	1	Monday   
2688	2032-05-11	2032	2	5	May      	20	11	2	Tuesday  
2689	2032-05-12	2032	2	5	May      	20	12	3	Wednesday
2690	2032-05-13	2032	2	5	May      	20	13	4	Thursday 
2691	2032-05-14	2032	2	5	May      	20	14	5	Friday   
2692	2032-05-15	2032	2	5	May      	20	15	6	Saturday 
2693	2032-05-16	2032	2	5	May      	20	16	0	Sunday   
2694	2032-05-17	2032	2	5	May      	21	17	1	Monday   
2695	2032-05-18	2032	2	5	May      	21	18	2	Tuesday  
2696	2032-05-19	2032	2	5	May      	21	19	3	Wednesday
2697	2032-05-20	2032	2	5	May      	21	20	4	Thursday 
2698	2032-05-21	2032	2	5	May      	21	21	5	Friday   
2699	2032-05-22	2032	2	5	May      	21	22	6	Saturday 
2700	2032-05-23	2032	2	5	May      	21	23	0	Sunday   
2701	2032-05-24	2032	2	5	May      	22	24	1	Monday   
2702	2032-05-25	2032	2	5	May      	22	25	2	Tuesday  
2703	2032-05-26	2032	2	5	May      	22	26	3	Wednesday
2704	2032-05-27	2032	2	5	May      	22	27	4	Thursday 
2705	2032-05-28	2032	2	5	May      	22	28	5	Friday   
2706	2032-05-29	2032	2	5	May      	22	29	6	Saturday 
2707	2032-05-30	2032	2	5	May      	22	30	0	Sunday   
2708	2032-05-31	2032	2	5	May      	23	31	1	Monday   
2709	2032-06-01	2032	2	6	June     	23	1	2	Tuesday  
2710	2032-06-02	2032	2	6	June     	23	2	3	Wednesday
2711	2032-06-03	2032	2	6	June     	23	3	4	Thursday 
2712	2032-06-04	2032	2	6	June     	23	4	5	Friday   
2713	2032-06-05	2032	2	6	June     	23	5	6	Saturday 
2714	2032-06-06	2032	2	6	June     	23	6	0	Sunday   
2715	2032-06-07	2032	2	6	June     	24	7	1	Monday   
2716	2032-06-08	2032	2	6	June     	24	8	2	Tuesday  
2717	2032-06-09	2032	2	6	June     	24	9	3	Wednesday
2718	2032-06-10	2032	2	6	June     	24	10	4	Thursday 
2719	2032-06-11	2032	2	6	June     	24	11	5	Friday   
2720	2032-06-12	2032	2	6	June     	24	12	6	Saturday 
2721	2032-06-13	2032	2	6	June     	24	13	0	Sunday   
2722	2032-06-14	2032	2	6	June     	25	14	1	Monday   
2723	2032-06-15	2032	2	6	June     	25	15	2	Tuesday  
2724	2032-06-16	2032	2	6	June     	25	16	3	Wednesday
2725	2032-06-17	2032	2	6	June     	25	17	4	Thursday 
2726	2032-06-18	2032	2	6	June     	25	18	5	Friday   
2727	2032-06-19	2032	2	6	June     	25	19	6	Saturday 
2728	2032-06-20	2032	2	6	June     	25	20	0	Sunday   
2729	2032-06-21	2032	2	6	June     	26	21	1	Monday   
2730	2032-06-22	2032	2	6	June     	26	22	2	Tuesday  
2731	2032-06-23	2032	2	6	June     	26	23	3	Wednesday
2732	2032-06-24	2032	2	6	June     	26	24	4	Thursday 
2733	2032-06-25	2032	2	6	June     	26	25	5	Friday   
2734	2032-06-26	2032	2	6	June     	26	26	6	Saturday 
2735	2032-06-27	2032	2	6	June     	26	27	0	Sunday   
2736	2032-06-28	2032	2	6	June     	27	28	1	Monday   
2737	2032-06-29	2032	2	6	June     	27	29	2	Tuesday  
2738	2032-06-30	2032	2	6	June     	27	30	3	Wednesday
2739	2032-07-01	2032	3	7	July     	27	1	4	Thursday 
2740	2032-07-02	2032	3	7	July     	27	2	5	Friday   
2741	2032-07-03	2032	3	7	July     	27	3	6	Saturday 
2742	2032-07-04	2032	3	7	July     	27	4	0	Sunday   
2743	2032-07-05	2032	3	7	July     	28	5	1	Monday   
2744	2032-07-06	2032	3	7	July     	28	6	2	Tuesday  
2745	2032-07-07	2032	3	7	July     	28	7	3	Wednesday
2746	2032-07-08	2032	3	7	July     	28	8	4	Thursday 
2747	2032-07-09	2032	3	7	July     	28	9	5	Friday   
2748	2032-07-10	2032	3	7	July     	28	10	6	Saturday 
2749	2032-07-11	2032	3	7	July     	28	11	0	Sunday   
2750	2032-07-12	2032	3	7	July     	29	12	1	Monday   
2751	2032-07-13	2032	3	7	July     	29	13	2	Tuesday  
2752	2032-07-14	2032	3	7	July     	29	14	3	Wednesday
2753	2032-07-15	2032	3	7	July     	29	15	4	Thursday 
2754	2032-07-16	2032	3	7	July     	29	16	5	Friday   
2755	2032-07-17	2032	3	7	July     	29	17	6	Saturday 
2756	2032-07-18	2032	3	7	July     	29	18	0	Sunday   
2757	2032-07-19	2032	3	7	July     	30	19	1	Monday   
2758	2032-07-20	2032	3	7	July     	30	20	2	Tuesday  
2759	2032-07-21	2032	3	7	July     	30	21	3	Wednesday
2760	2032-07-22	2032	3	7	July     	30	22	4	Thursday 
2761	2032-07-23	2032	3	7	July     	30	23	5	Friday   
2762	2032-07-24	2032	3	7	July     	30	24	6	Saturday 
2763	2032-07-25	2032	3	7	July     	30	25	0	Sunday   
2764	2032-07-26	2032	3	7	July     	31	26	1	Monday   
2765	2032-07-27	2032	3	7	July     	31	27	2	Tuesday  
2766	2032-07-28	2032	3	7	July     	31	28	3	Wednesday
2767	2032-07-29	2032	3	7	July     	31	29	4	Thursday 
2768	2032-07-30	2032	3	7	July     	31	30	5	Friday   
2769	2032-07-31	2032	3	7	July     	31	31	6	Saturday 
2770	2032-08-01	2032	3	8	August   	31	1	0	Sunday   
2771	2032-08-02	2032	3	8	August   	32	2	1	Monday   
2772	2032-08-03	2032	3	8	August   	32	3	2	Tuesday  
2773	2032-08-04	2032	3	8	August   	32	4	3	Wednesday
2774	2032-08-05	2032	3	8	August   	32	5	4	Thursday 
2775	2032-08-06	2032	3	8	August   	32	6	5	Friday   
2776	2032-08-07	2032	3	8	August   	32	7	6	Saturday 
2777	2032-08-08	2032	3	8	August   	32	8	0	Sunday   
2778	2032-08-09	2032	3	8	August   	33	9	1	Monday   
2779	2032-08-10	2032	3	8	August   	33	10	2	Tuesday  
2780	2032-08-11	2032	3	8	August   	33	11	3	Wednesday
2781	2032-08-12	2032	3	8	August   	33	12	4	Thursday 
2782	2032-08-13	2032	3	8	August   	33	13	5	Friday   
2783	2032-08-14	2032	3	8	August   	33	14	6	Saturday 
2784	2032-08-15	2032	3	8	August   	33	15	0	Sunday   
2785	2032-08-16	2032	3	8	August   	34	16	1	Monday   
2786	2032-08-17	2032	3	8	August   	34	17	2	Tuesday  
2787	2032-08-18	2032	3	8	August   	34	18	3	Wednesday
2788	2032-08-19	2032	3	8	August   	34	19	4	Thursday 
2789	2032-08-20	2032	3	8	August   	34	20	5	Friday   
2790	2032-08-21	2032	3	8	August   	34	21	6	Saturday 
2791	2032-08-22	2032	3	8	August   	34	22	0	Sunday   
2792	2032-08-23	2032	3	8	August   	35	23	1	Monday   
2793	2032-08-24	2032	3	8	August   	35	24	2	Tuesday  
2794	2032-08-25	2032	3	8	August   	35	25	3	Wednesday
2795	2032-08-26	2032	3	8	August   	35	26	4	Thursday 
2796	2032-08-27	2032	3	8	August   	35	27	5	Friday   
2797	2032-08-28	2032	3	8	August   	35	28	6	Saturday 
2798	2032-08-29	2032	3	8	August   	35	29	0	Sunday   
2799	2032-08-30	2032	3	8	August   	36	30	1	Monday   
2800	2032-08-31	2032	3	8	August   	36	31	2	Tuesday  
2801	2032-09-01	2032	3	9	September	36	1	3	Wednesday
2802	2032-09-02	2032	3	9	September	36	2	4	Thursday 
2803	2032-09-03	2032	3	9	September	36	3	5	Friday   
2804	2032-09-04	2032	3	9	September	36	4	6	Saturday 
2805	2032-09-05	2032	3	9	September	36	5	0	Sunday   
2806	2032-09-06	2032	3	9	September	37	6	1	Monday   
2807	2032-09-07	2032	3	9	September	37	7	2	Tuesday  
2808	2032-09-08	2032	3	9	September	37	8	3	Wednesday
2809	2032-09-09	2032	3	9	September	37	9	4	Thursday 
2810	2032-09-10	2032	3	9	September	37	10	5	Friday   
2811	2032-09-11	2032	3	9	September	37	11	6	Saturday 
2812	2032-09-12	2032	3	9	September	37	12	0	Sunday   
2813	2032-09-13	2032	3	9	September	38	13	1	Monday   
2814	2032-09-14	2032	3	9	September	38	14	2	Tuesday  
2815	2032-09-15	2032	3	9	September	38	15	3	Wednesday
2816	2032-09-16	2032	3	9	September	38	16	4	Thursday 
2817	2032-09-17	2032	3	9	September	38	17	5	Friday   
2818	2032-09-18	2032	3	9	September	38	18	6	Saturday 
2819	2032-09-19	2032	3	9	September	38	19	0	Sunday   
2820	2032-09-20	2032	3	9	September	39	20	1	Monday   
2821	2032-09-21	2032	3	9	September	39	21	2	Tuesday  
2822	2032-09-22	2032	3	9	September	39	22	3	Wednesday
2823	2032-09-23	2032	3	9	September	39	23	4	Thursday 
2824	2032-09-24	2032	3	9	September	39	24	5	Friday   
2825	2032-09-25	2032	3	9	September	39	25	6	Saturday 
2826	2032-09-26	2032	3	9	September	39	26	0	Sunday   
2827	2032-09-27	2032	3	9	September	40	27	1	Monday   
2828	2032-09-28	2032	3	9	September	40	28	2	Tuesday  
2829	2032-09-29	2032	3	9	September	40	29	3	Wednesday
2830	2032-09-30	2032	3	9	September	40	30	4	Thursday 
2831	2032-10-01	2032	4	10	October  	40	1	5	Friday   
2832	2032-10-02	2032	4	10	October  	40	2	6	Saturday 
2833	2032-10-03	2032	4	10	October  	40	3	0	Sunday   
2834	2032-10-04	2032	4	10	October  	41	4	1	Monday   
2835	2032-10-05	2032	4	10	October  	41	5	2	Tuesday  
2836	2032-10-06	2032	4	10	October  	41	6	3	Wednesday
2837	2032-10-07	2032	4	10	October  	41	7	4	Thursday 
2838	2032-10-08	2032	4	10	October  	41	8	5	Friday   
2839	2032-10-09	2032	4	10	October  	41	9	6	Saturday 
2840	2032-10-10	2032	4	10	October  	41	10	0	Sunday   
2841	2032-10-11	2032	4	10	October  	42	11	1	Monday   
2842	2032-10-12	2032	4	10	October  	42	12	2	Tuesday  
2843	2032-10-13	2032	4	10	October  	42	13	3	Wednesday
2844	2032-10-14	2032	4	10	October  	42	14	4	Thursday 
2845	2032-10-15	2032	4	10	October  	42	15	5	Friday   
2846	2032-10-16	2032	4	10	October  	42	16	6	Saturday 
2847	2032-10-17	2032	4	10	October  	42	17	0	Sunday   
2848	2032-10-18	2032	4	10	October  	43	18	1	Monday   
2849	2032-10-19	2032	4	10	October  	43	19	2	Tuesday  
2850	2032-10-20	2032	4	10	October  	43	20	3	Wednesday
2851	2032-10-21	2032	4	10	October  	43	21	4	Thursday 
2852	2032-10-22	2032	4	10	October  	43	22	5	Friday   
2853	2032-10-23	2032	4	10	October  	43	23	6	Saturday 
2854	2032-10-24	2032	4	10	October  	43	24	0	Sunday   
2855	2032-10-25	2032	4	10	October  	44	25	1	Monday   
2856	2032-10-26	2032	4	10	October  	44	26	2	Tuesday  
2857	2032-10-27	2032	4	10	October  	44	27	3	Wednesday
2858	2032-10-28	2032	4	10	October  	44	28	4	Thursday 
2859	2032-10-29	2032	4	10	October  	44	29	5	Friday   
2860	2032-10-30	2032	4	10	October  	44	30	6	Saturday 
2861	2032-10-31	2032	4	10	October  	44	31	0	Sunday   
2862	2032-11-01	2032	4	11	November 	45	1	1	Monday   
2863	2032-11-02	2032	4	11	November 	45	2	2	Tuesday  
2864	2032-11-03	2032	4	11	November 	45	3	3	Wednesday
2865	2032-11-04	2032	4	11	November 	45	4	4	Thursday 
2866	2032-11-05	2032	4	11	November 	45	5	5	Friday   
2867	2032-11-06	2032	4	11	November 	45	6	6	Saturday 
2868	2032-11-07	2032	4	11	November 	45	7	0	Sunday   
2869	2032-11-08	2032	4	11	November 	46	8	1	Monday   
2870	2032-11-09	2032	4	11	November 	46	9	2	Tuesday  
2871	2032-11-10	2032	4	11	November 	46	10	3	Wednesday
2872	2032-11-11	2032	4	11	November 	46	11	4	Thursday 
2873	2032-11-12	2032	4	11	November 	46	12	5	Friday   
2874	2032-11-13	2032	4	11	November 	46	13	6	Saturday 
2875	2032-11-14	2032	4	11	November 	46	14	0	Sunday   
2876	2032-11-15	2032	4	11	November 	47	15	1	Monday   
2877	2032-11-16	2032	4	11	November 	47	16	2	Tuesday  
2878	2032-11-17	2032	4	11	November 	47	17	3	Wednesday
2879	2032-11-18	2032	4	11	November 	47	18	4	Thursday 
2880	2032-11-19	2032	4	11	November 	47	19	5	Friday   
2881	2032-11-20	2032	4	11	November 	47	20	6	Saturday 
2882	2032-11-21	2032	4	11	November 	47	21	0	Sunday   
2883	2032-11-22	2032	4	11	November 	48	22	1	Monday   
2884	2032-11-23	2032	4	11	November 	48	23	2	Tuesday  
2885	2032-11-24	2032	4	11	November 	48	24	3	Wednesday
2886	2032-11-25	2032	4	11	November 	48	25	4	Thursday 
2887	2032-11-26	2032	4	11	November 	48	26	5	Friday   
2888	2032-11-27	2032	4	11	November 	48	27	6	Saturday 
2889	2032-11-28	2032	4	11	November 	48	28	0	Sunday   
2890	2032-11-29	2032	4	11	November 	49	29	1	Monday   
2891	2032-11-30	2032	4	11	November 	49	30	2	Tuesday  
2892	2032-12-01	2032	4	12	December 	49	1	3	Wednesday
2893	2032-12-02	2032	4	12	December 	49	2	4	Thursday 
2894	2032-12-03	2032	4	12	December 	49	3	5	Friday   
2895	2032-12-04	2032	4	12	December 	49	4	6	Saturday 
2896	2032-12-05	2032	4	12	December 	49	5	0	Sunday   
2897	2032-12-06	2032	4	12	December 	50	6	1	Monday   
2898	2032-12-07	2032	4	12	December 	50	7	2	Tuesday  
2899	2032-12-08	2032	4	12	December 	50	8	3	Wednesday
2900	2032-12-09	2032	4	12	December 	50	9	4	Thursday 
2901	2032-12-10	2032	4	12	December 	50	10	5	Friday   
2902	2032-12-11	2032	4	12	December 	50	11	6	Saturday 
2903	2032-12-12	2032	4	12	December 	50	12	0	Sunday   
2904	2032-12-13	2032	4	12	December 	51	13	1	Monday   
2905	2032-12-14	2032	4	12	December 	51	14	2	Tuesday  
2906	2032-12-15	2032	4	12	December 	51	15	3	Wednesday
2907	2032-12-16	2032	4	12	December 	51	16	4	Thursday 
2908	2032-12-17	2032	4	12	December 	51	17	5	Friday   
2909	2032-12-18	2032	4	12	December 	51	18	6	Saturday 
2910	2032-12-19	2032	4	12	December 	51	19	0	Sunday   
2911	2032-12-20	2032	4	12	December 	52	20	1	Monday   
2912	2032-12-21	2032	4	12	December 	52	21	2	Tuesday  
2913	2032-12-22	2032	4	12	December 	52	22	3	Wednesday
2914	2032-12-23	2032	4	12	December 	52	23	4	Thursday 
2915	2032-12-24	2032	4	12	December 	52	24	5	Friday   
2916	2032-12-25	2032	4	12	December 	52	25	6	Saturday 
2917	2032-12-26	2032	4	12	December 	52	26	0	Sunday   
2918	2032-12-27	2032	4	12	December 	53	27	1	Monday   
2919	2032-12-28	2032	4	12	December 	53	28	2	Tuesday  
2920	2032-12-29	2032	4	12	December 	53	29	3	Wednesday
2921	2032-12-30	2032	4	12	December 	53	30	4	Thursday 
2922	2032-12-31	2032	4	12	December 	53	31	5	Friday   
2923	2033-01-01	2033	1	1	January  	53	1	6	Saturday 
2924	2033-01-02	2033	1	1	January  	53	2	0	Sunday   
2925	2033-01-03	2033	1	1	January  	1	3	1	Monday   
2926	2033-01-04	2033	1	1	January  	1	4	2	Tuesday  
2927	2033-01-05	2033	1	1	January  	1	5	3	Wednesday
2928	2033-01-06	2033	1	1	January  	1	6	4	Thursday 
2929	2033-01-07	2033	1	1	January  	1	7	5	Friday   
2930	2033-01-08	2033	1	1	January  	1	8	6	Saturday 
2931	2033-01-09	2033	1	1	January  	1	9	0	Sunday   
2932	2033-01-10	2033	1	1	January  	2	10	1	Monday   
2933	2033-01-11	2033	1	1	January  	2	11	2	Tuesday  
2934	2033-01-12	2033	1	1	January  	2	12	3	Wednesday
2935	2033-01-13	2033	1	1	January  	2	13	4	Thursday 
2936	2033-01-14	2033	1	1	January  	2	14	5	Friday   
2937	2033-01-15	2033	1	1	January  	2	15	6	Saturday 
2938	2033-01-16	2033	1	1	January  	2	16	0	Sunday   
2939	2033-01-17	2033	1	1	January  	3	17	1	Monday   
2940	2033-01-18	2033	1	1	January  	3	18	2	Tuesday  
2941	2033-01-19	2033	1	1	January  	3	19	3	Wednesday
2942	2033-01-20	2033	1	1	January  	3	20	4	Thursday 
2943	2033-01-21	2033	1	1	January  	3	21	5	Friday   
2944	2033-01-22	2033	1	1	January  	3	22	6	Saturday 
2945	2033-01-23	2033	1	1	January  	3	23	0	Sunday   
2946	2033-01-24	2033	1	1	January  	4	24	1	Monday   
2947	2033-01-25	2033	1	1	January  	4	25	2	Tuesday  
2948	2033-01-26	2033	1	1	January  	4	26	3	Wednesday
2949	2033-01-27	2033	1	1	January  	4	27	4	Thursday 
2950	2033-01-28	2033	1	1	January  	4	28	5	Friday   
2951	2033-01-29	2033	1	1	January  	4	29	6	Saturday 
2952	2033-01-30	2033	1	1	January  	4	30	0	Sunday   
2953	2033-01-31	2033	1	1	January  	5	31	1	Monday   
2954	2033-02-01	2033	1	2	February 	5	1	2	Tuesday  
2955	2033-02-02	2033	1	2	February 	5	2	3	Wednesday
2956	2033-02-03	2033	1	2	February 	5	3	4	Thursday 
2957	2033-02-04	2033	1	2	February 	5	4	5	Friday   
2958	2033-02-05	2033	1	2	February 	5	5	6	Saturday 
2959	2033-02-06	2033	1	2	February 	5	6	0	Sunday   
2960	2033-02-07	2033	1	2	February 	6	7	1	Monday   
2961	2033-02-08	2033	1	2	February 	6	8	2	Tuesday  
2962	2033-02-09	2033	1	2	February 	6	9	3	Wednesday
2963	2033-02-10	2033	1	2	February 	6	10	4	Thursday 
2964	2033-02-11	2033	1	2	February 	6	11	5	Friday   
2965	2033-02-12	2033	1	2	February 	6	12	6	Saturday 
2966	2033-02-13	2033	1	2	February 	6	13	0	Sunday   
2967	2033-02-14	2033	1	2	February 	7	14	1	Monday   
2968	2033-02-15	2033	1	2	February 	7	15	2	Tuesday  
2969	2033-02-16	2033	1	2	February 	7	16	3	Wednesday
2970	2033-02-17	2033	1	2	February 	7	17	4	Thursday 
2971	2033-02-18	2033	1	2	February 	7	18	5	Friday   
2972	2033-02-19	2033	1	2	February 	7	19	6	Saturday 
2973	2033-02-20	2033	1	2	February 	7	20	0	Sunday   
2974	2033-02-21	2033	1	2	February 	8	21	1	Monday   
2975	2033-02-22	2033	1	2	February 	8	22	2	Tuesday  
2976	2033-02-23	2033	1	2	February 	8	23	3	Wednesday
2977	2033-02-24	2033	1	2	February 	8	24	4	Thursday 
2978	2033-02-25	2033	1	2	February 	8	25	5	Friday   
2979	2033-02-26	2033	1	2	February 	8	26	6	Saturday 
2980	2033-02-27	2033	1	2	February 	8	27	0	Sunday   
2981	2033-02-28	2033	1	2	February 	9	28	1	Monday   
2982	2033-03-01	2033	1	3	March    	9	1	2	Tuesday  
2983	2033-03-02	2033	1	3	March    	9	2	3	Wednesday
2984	2033-03-03	2033	1	3	March    	9	3	4	Thursday 
2985	2033-03-04	2033	1	3	March    	9	4	5	Friday   
2986	2033-03-05	2033	1	3	March    	9	5	6	Saturday 
2987	2033-03-06	2033	1	3	March    	9	6	0	Sunday   
2988	2033-03-07	2033	1	3	March    	10	7	1	Monday   
2989	2033-03-08	2033	1	3	March    	10	8	2	Tuesday  
2990	2033-03-09	2033	1	3	March    	10	9	3	Wednesday
2991	2033-03-10	2033	1	3	March    	10	10	4	Thursday 
2992	2033-03-11	2033	1	3	March    	10	11	5	Friday   
2993	2033-03-12	2033	1	3	March    	10	12	6	Saturday 
2994	2033-03-13	2033	1	3	March    	10	13	0	Sunday   
2995	2033-03-14	2033	1	3	March    	11	14	1	Monday   
2996	2033-03-15	2033	1	3	March    	11	15	2	Tuesday  
2997	2033-03-16	2033	1	3	March    	11	16	3	Wednesday
2998	2033-03-17	2033	1	3	March    	11	17	4	Thursday 
2999	2033-03-18	2033	1	3	March    	11	18	5	Friday   
3000	2033-03-19	2033	1	3	March    	11	19	6	Saturday 
3001	2033-03-20	2033	1	3	March    	11	20	0	Sunday   
3002	2033-03-21	2033	1	3	March    	12	21	1	Monday   
3003	2033-03-22	2033	1	3	March    	12	22	2	Tuesday  
3004	2033-03-23	2033	1	3	March    	12	23	3	Wednesday
3005	2033-03-24	2033	1	3	March    	12	24	4	Thursday 
3006	2033-03-25	2033	1	3	March    	12	25	5	Friday   
3007	2033-03-26	2033	1	3	March    	12	26	6	Saturday 
3008	2033-03-27	2033	1	3	March    	12	27	0	Sunday   
3009	2033-03-28	2033	1	3	March    	13	28	1	Monday   
3010	2033-03-29	2033	1	3	March    	13	29	2	Tuesday  
3011	2033-03-30	2033	1	3	March    	13	30	3	Wednesday
3012	2033-03-31	2033	1	3	March    	13	31	4	Thursday 
3013	2033-04-01	2033	2	4	April    	13	1	5	Friday   
3014	2033-04-02	2033	2	4	April    	13	2	6	Saturday 
3015	2033-04-03	2033	2	4	April    	13	3	0	Sunday   
3016	2033-04-04	2033	2	4	April    	14	4	1	Monday   
3017	2033-04-05	2033	2	4	April    	14	5	2	Tuesday  
3018	2033-04-06	2033	2	4	April    	14	6	3	Wednesday
3019	2033-04-07	2033	2	4	April    	14	7	4	Thursday 
3020	2033-04-08	2033	2	4	April    	14	8	5	Friday   
3021	2033-04-09	2033	2	4	April    	14	9	6	Saturday 
3022	2033-04-10	2033	2	4	April    	14	10	0	Sunday   
3023	2033-04-11	2033	2	4	April    	15	11	1	Monday   
3024	2033-04-12	2033	2	4	April    	15	12	2	Tuesday  
3025	2033-04-13	2033	2	4	April    	15	13	3	Wednesday
3026	2033-04-14	2033	2	4	April    	15	14	4	Thursday 
3027	2033-04-15	2033	2	4	April    	15	15	5	Friday   
3028	2033-04-16	2033	2	4	April    	15	16	6	Saturday 
3029	2033-04-17	2033	2	4	April    	15	17	0	Sunday   
3030	2033-04-18	2033	2	4	April    	16	18	1	Monday   
3031	2033-04-19	2033	2	4	April    	16	19	2	Tuesday  
3032	2033-04-20	2033	2	4	April    	16	20	3	Wednesday
3033	2033-04-21	2033	2	4	April    	16	21	4	Thursday 
3034	2033-04-22	2033	2	4	April    	16	22	5	Friday   
3035	2033-04-23	2033	2	4	April    	16	23	6	Saturday 
3036	2033-04-24	2033	2	4	April    	16	24	0	Sunday   
3037	2033-04-25	2033	2	4	April    	17	25	1	Monday   
3038	2033-04-26	2033	2	4	April    	17	26	2	Tuesday  
3039	2033-04-27	2033	2	4	April    	17	27	3	Wednesday
3040	2033-04-28	2033	2	4	April    	17	28	4	Thursday 
3041	2033-04-29	2033	2	4	April    	17	29	5	Friday   
3042	2033-04-30	2033	2	4	April    	17	30	6	Saturday 
3043	2033-05-01	2033	2	5	May      	17	1	0	Sunday   
3044	2033-05-02	2033	2	5	May      	18	2	1	Monday   
3045	2033-05-03	2033	2	5	May      	18	3	2	Tuesday  
3046	2033-05-04	2033	2	5	May      	18	4	3	Wednesday
3047	2033-05-05	2033	2	5	May      	18	5	4	Thursday 
3048	2033-05-06	2033	2	5	May      	18	6	5	Friday   
3049	2033-05-07	2033	2	5	May      	18	7	6	Saturday 
3050	2033-05-08	2033	2	5	May      	18	8	0	Sunday   
3051	2033-05-09	2033	2	5	May      	19	9	1	Monday   
3052	2033-05-10	2033	2	5	May      	19	10	2	Tuesday  
3053	2033-05-11	2033	2	5	May      	19	11	3	Wednesday
3054	2033-05-12	2033	2	5	May      	19	12	4	Thursday 
3055	2033-05-13	2033	2	5	May      	19	13	5	Friday   
3056	2033-05-14	2033	2	5	May      	19	14	6	Saturday 
3057	2033-05-15	2033	2	5	May      	19	15	0	Sunday   
3058	2033-05-16	2033	2	5	May      	20	16	1	Monday   
3059	2033-05-17	2033	2	5	May      	20	17	2	Tuesday  
3060	2033-05-18	2033	2	5	May      	20	18	3	Wednesday
3061	2033-05-19	2033	2	5	May      	20	19	4	Thursday 
3062	2033-05-20	2033	2	5	May      	20	20	5	Friday   
3063	2033-05-21	2033	2	5	May      	20	21	6	Saturday 
3064	2033-05-22	2033	2	5	May      	20	22	0	Sunday   
3065	2033-05-23	2033	2	5	May      	21	23	1	Monday   
3066	2033-05-24	2033	2	5	May      	21	24	2	Tuesday  
3067	2033-05-25	2033	2	5	May      	21	25	3	Wednesday
3068	2033-05-26	2033	2	5	May      	21	26	4	Thursday 
3069	2033-05-27	2033	2	5	May      	21	27	5	Friday   
3070	2033-05-28	2033	2	5	May      	21	28	6	Saturday 
3071	2033-05-29	2033	2	5	May      	21	29	0	Sunday   
3072	2033-05-30	2033	2	5	May      	22	30	1	Monday   
3073	2033-05-31	2033	2	5	May      	22	31	2	Tuesday  
3074	2033-06-01	2033	2	6	June     	22	1	3	Wednesday
3075	2033-06-02	2033	2	6	June     	22	2	4	Thursday 
3076	2033-06-03	2033	2	6	June     	22	3	5	Friday   
3077	2033-06-04	2033	2	6	June     	22	4	6	Saturday 
3078	2033-06-05	2033	2	6	June     	22	5	0	Sunday   
3079	2033-06-06	2033	2	6	June     	23	6	1	Monday   
3080	2033-06-07	2033	2	6	June     	23	7	2	Tuesday  
3081	2033-06-08	2033	2	6	June     	23	8	3	Wednesday
3082	2033-06-09	2033	2	6	June     	23	9	4	Thursday 
3083	2033-06-10	2033	2	6	June     	23	10	5	Friday   
3084	2033-06-11	2033	2	6	June     	23	11	6	Saturday 
3085	2033-06-12	2033	2	6	June     	23	12	0	Sunday   
3086	2033-06-13	2033	2	6	June     	24	13	1	Monday   
3087	2033-06-14	2033	2	6	June     	24	14	2	Tuesday  
3088	2033-06-15	2033	2	6	June     	24	15	3	Wednesday
3089	2033-06-16	2033	2	6	June     	24	16	4	Thursday 
3090	2033-06-17	2033	2	6	June     	24	17	5	Friday   
3091	2033-06-18	2033	2	6	June     	24	18	6	Saturday 
3092	2033-06-19	2033	2	6	June     	24	19	0	Sunday   
3093	2033-06-20	2033	2	6	June     	25	20	1	Monday   
3094	2033-06-21	2033	2	6	June     	25	21	2	Tuesday  
3095	2033-06-22	2033	2	6	June     	25	22	3	Wednesday
3096	2033-06-23	2033	2	6	June     	25	23	4	Thursday 
3097	2033-06-24	2033	2	6	June     	25	24	5	Friday   
3098	2033-06-25	2033	2	6	June     	25	25	6	Saturday 
3099	2033-06-26	2033	2	6	June     	25	26	0	Sunday   
3100	2033-06-27	2033	2	6	June     	26	27	1	Monday   
3101	2033-06-28	2033	2	6	June     	26	28	2	Tuesday  
3102	2033-06-29	2033	2	6	June     	26	29	3	Wednesday
3103	2033-06-30	2033	2	6	June     	26	30	4	Thursday 
3104	2033-07-01	2033	3	7	July     	26	1	5	Friday   
3105	2033-07-02	2033	3	7	July     	26	2	6	Saturday 
3106	2033-07-03	2033	3	7	July     	26	3	0	Sunday   
3107	2033-07-04	2033	3	7	July     	27	4	1	Monday   
3108	2033-07-05	2033	3	7	July     	27	5	2	Tuesday  
3109	2033-07-06	2033	3	7	July     	27	6	3	Wednesday
3110	2033-07-07	2033	3	7	July     	27	7	4	Thursday 
3111	2033-07-08	2033	3	7	July     	27	8	5	Friday   
3112	2033-07-09	2033	3	7	July     	27	9	6	Saturday 
3113	2033-07-10	2033	3	7	July     	27	10	0	Sunday   
3114	2033-07-11	2033	3	7	July     	28	11	1	Monday   
3115	2033-07-12	2033	3	7	July     	28	12	2	Tuesday  
3116	2033-07-13	2033	3	7	July     	28	13	3	Wednesday
3117	2033-07-14	2033	3	7	July     	28	14	4	Thursday 
3118	2033-07-15	2033	3	7	July     	28	15	5	Friday   
3119	2033-07-16	2033	3	7	July     	28	16	6	Saturday 
3120	2033-07-17	2033	3	7	July     	28	17	0	Sunday   
3121	2033-07-18	2033	3	7	July     	29	18	1	Monday   
3122	2033-07-19	2033	3	7	July     	29	19	2	Tuesday  
3123	2033-07-20	2033	3	7	July     	29	20	3	Wednesday
3124	2033-07-21	2033	3	7	July     	29	21	4	Thursday 
3125	2033-07-22	2033	3	7	July     	29	22	5	Friday   
3126	2033-07-23	2033	3	7	July     	29	23	6	Saturday 
3127	2033-07-24	2033	3	7	July     	29	24	0	Sunday   
3128	2033-07-25	2033	3	7	July     	30	25	1	Monday   
3129	2033-07-26	2033	3	7	July     	30	26	2	Tuesday  
3130	2033-07-27	2033	3	7	July     	30	27	3	Wednesday
3131	2033-07-28	2033	3	7	July     	30	28	4	Thursday 
3132	2033-07-29	2033	3	7	July     	30	29	5	Friday   
3133	2033-07-30	2033	3	7	July     	30	30	6	Saturday 
3134	2033-07-31	2033	3	7	July     	30	31	0	Sunday   
3135	2033-08-01	2033	3	8	August   	31	1	1	Monday   
3136	2033-08-02	2033	3	8	August   	31	2	2	Tuesday  
3137	2033-08-03	2033	3	8	August   	31	3	3	Wednesday
3138	2033-08-04	2033	3	8	August   	31	4	4	Thursday 
3139	2033-08-05	2033	3	8	August   	31	5	5	Friday   
3140	2033-08-06	2033	3	8	August   	31	6	6	Saturday 
3141	2033-08-07	2033	3	8	August   	31	7	0	Sunday   
3142	2033-08-08	2033	3	8	August   	32	8	1	Monday   
3143	2033-08-09	2033	3	8	August   	32	9	2	Tuesday  
3144	2033-08-10	2033	3	8	August   	32	10	3	Wednesday
3145	2033-08-11	2033	3	8	August   	32	11	4	Thursday 
3146	2033-08-12	2033	3	8	August   	32	12	5	Friday   
3147	2033-08-13	2033	3	8	August   	32	13	6	Saturday 
3148	2033-08-14	2033	3	8	August   	32	14	0	Sunday   
3149	2033-08-15	2033	3	8	August   	33	15	1	Monday   
3150	2033-08-16	2033	3	8	August   	33	16	2	Tuesday  
3151	2033-08-17	2033	3	8	August   	33	17	3	Wednesday
3152	2033-08-18	2033	3	8	August   	33	18	4	Thursday 
3153	2033-08-19	2033	3	8	August   	33	19	5	Friday   
3154	2033-08-20	2033	3	8	August   	33	20	6	Saturday 
3155	2033-08-21	2033	3	8	August   	33	21	0	Sunday   
3156	2033-08-22	2033	3	8	August   	34	22	1	Monday   
3157	2033-08-23	2033	3	8	August   	34	23	2	Tuesday  
3158	2033-08-24	2033	3	8	August   	34	24	3	Wednesday
3159	2033-08-25	2033	3	8	August   	34	25	4	Thursday 
3160	2033-08-26	2033	3	8	August   	34	26	5	Friday   
3161	2033-08-27	2033	3	8	August   	34	27	6	Saturday 
3162	2033-08-28	2033	3	8	August   	34	28	0	Sunday   
3163	2033-08-29	2033	3	8	August   	35	29	1	Monday   
3164	2033-08-30	2033	3	8	August   	35	30	2	Tuesday  
3165	2033-08-31	2033	3	8	August   	35	31	3	Wednesday
3166	2033-09-01	2033	3	9	September	35	1	4	Thursday 
3167	2033-09-02	2033	3	9	September	35	2	5	Friday   
3168	2033-09-03	2033	3	9	September	35	3	6	Saturday 
3169	2033-09-04	2033	3	9	September	35	4	0	Sunday   
3170	2033-09-05	2033	3	9	September	36	5	1	Monday   
3171	2033-09-06	2033	3	9	September	36	6	2	Tuesday  
3172	2033-09-07	2033	3	9	September	36	7	3	Wednesday
3173	2033-09-08	2033	3	9	September	36	8	4	Thursday 
3174	2033-09-09	2033	3	9	September	36	9	5	Friday   
3175	2033-09-10	2033	3	9	September	36	10	6	Saturday 
3176	2033-09-11	2033	3	9	September	36	11	0	Sunday   
3177	2033-09-12	2033	3	9	September	37	12	1	Monday   
3178	2033-09-13	2033	3	9	September	37	13	2	Tuesday  
3179	2033-09-14	2033	3	9	September	37	14	3	Wednesday
3180	2033-09-15	2033	3	9	September	37	15	4	Thursday 
3181	2033-09-16	2033	3	9	September	37	16	5	Friday   
3182	2033-09-17	2033	3	9	September	37	17	6	Saturday 
3183	2033-09-18	2033	3	9	September	37	18	0	Sunday   
3184	2033-09-19	2033	3	9	September	38	19	1	Monday   
3185	2033-09-20	2033	3	9	September	38	20	2	Tuesday  
3186	2033-09-21	2033	3	9	September	38	21	3	Wednesday
3187	2033-09-22	2033	3	9	September	38	22	4	Thursday 
3188	2033-09-23	2033	3	9	September	38	23	5	Friday   
3189	2033-09-24	2033	3	9	September	38	24	6	Saturday 
3190	2033-09-25	2033	3	9	September	38	25	0	Sunday   
3191	2033-09-26	2033	3	9	September	39	26	1	Monday   
3192	2033-09-27	2033	3	9	September	39	27	2	Tuesday  
3193	2033-09-28	2033	3	9	September	39	28	3	Wednesday
3194	2033-09-29	2033	3	9	September	39	29	4	Thursday 
3195	2033-09-30	2033	3	9	September	39	30	5	Friday   
3196	2033-10-01	2033	4	10	October  	39	1	6	Saturday 
3197	2033-10-02	2033	4	10	October  	39	2	0	Sunday   
3198	2033-10-03	2033	4	10	October  	40	3	1	Monday   
3199	2033-10-04	2033	4	10	October  	40	4	2	Tuesday  
3200	2033-10-05	2033	4	10	October  	40	5	3	Wednesday
3201	2033-10-06	2033	4	10	October  	40	6	4	Thursday 
3202	2033-10-07	2033	4	10	October  	40	7	5	Friday   
3203	2033-10-08	2033	4	10	October  	40	8	6	Saturday 
3204	2033-10-09	2033	4	10	October  	40	9	0	Sunday   
3205	2033-10-10	2033	4	10	October  	41	10	1	Monday   
3206	2033-10-11	2033	4	10	October  	41	11	2	Tuesday  
3207	2033-10-12	2033	4	10	October  	41	12	3	Wednesday
3208	2033-10-13	2033	4	10	October  	41	13	4	Thursday 
3209	2033-10-14	2033	4	10	October  	41	14	5	Friday   
3210	2033-10-15	2033	4	10	October  	41	15	6	Saturday 
3211	2033-10-16	2033	4	10	October  	41	16	0	Sunday   
3212	2033-10-17	2033	4	10	October  	42	17	1	Monday   
3213	2033-10-18	2033	4	10	October  	42	18	2	Tuesday  
3214	2033-10-19	2033	4	10	October  	42	19	3	Wednesday
3215	2033-10-20	2033	4	10	October  	42	20	4	Thursday 
3216	2033-10-21	2033	4	10	October  	42	21	5	Friday   
3217	2033-10-22	2033	4	10	October  	42	22	6	Saturday 
3218	2033-10-23	2033	4	10	October  	42	23	0	Sunday   
3219	2033-10-24	2033	4	10	October  	43	24	1	Monday   
3220	2033-10-25	2033	4	10	October  	43	25	2	Tuesday  
3221	2033-10-26	2033	4	10	October  	43	26	3	Wednesday
3222	2033-10-27	2033	4	10	October  	43	27	4	Thursday 
3223	2033-10-28	2033	4	10	October  	43	28	5	Friday   
3224	2033-10-29	2033	4	10	October  	43	29	6	Saturday 
3225	2033-10-30	2033	4	10	October  	43	30	0	Sunday   
3226	2033-10-31	2033	4	10	October  	44	31	1	Monday   
3227	2033-11-01	2033	4	11	November 	44	1	2	Tuesday  
3228	2033-11-02	2033	4	11	November 	44	2	3	Wednesday
3229	2033-11-03	2033	4	11	November 	44	3	4	Thursday 
3230	2033-11-04	2033	4	11	November 	44	4	5	Friday   
3231	2033-11-05	2033	4	11	November 	44	5	6	Saturday 
3232	2033-11-06	2033	4	11	November 	44	6	0	Sunday   
3233	2033-11-07	2033	4	11	November 	45	7	1	Monday   
3234	2033-11-08	2033	4	11	November 	45	8	2	Tuesday  
3235	2033-11-09	2033	4	11	November 	45	9	3	Wednesday
3236	2033-11-10	2033	4	11	November 	45	10	4	Thursday 
3237	2033-11-11	2033	4	11	November 	45	11	5	Friday   
3238	2033-11-12	2033	4	11	November 	45	12	6	Saturday 
3239	2033-11-13	2033	4	11	November 	45	13	0	Sunday   
3240	2033-11-14	2033	4	11	November 	46	14	1	Monday   
3241	2033-11-15	2033	4	11	November 	46	15	2	Tuesday  
3242	2033-11-16	2033	4	11	November 	46	16	3	Wednesday
3243	2033-11-17	2033	4	11	November 	46	17	4	Thursday 
3244	2033-11-18	2033	4	11	November 	46	18	5	Friday   
3245	2033-11-19	2033	4	11	November 	46	19	6	Saturday 
3246	2033-11-20	2033	4	11	November 	46	20	0	Sunday   
3247	2033-11-21	2033	4	11	November 	47	21	1	Monday   
3248	2033-11-22	2033	4	11	November 	47	22	2	Tuesday  
3249	2033-11-23	2033	4	11	November 	47	23	3	Wednesday
3250	2033-11-24	2033	4	11	November 	47	24	4	Thursday 
3251	2033-11-25	2033	4	11	November 	47	25	5	Friday   
3252	2033-11-26	2033	4	11	November 	47	26	6	Saturday 
3253	2033-11-27	2033	4	11	November 	47	27	0	Sunday   
3254	2033-11-28	2033	4	11	November 	48	28	1	Monday   
3255	2033-11-29	2033	4	11	November 	48	29	2	Tuesday  
3256	2033-11-30	2033	4	11	November 	48	30	3	Wednesday
3257	2033-12-01	2033	4	12	December 	48	1	4	Thursday 
3258	2033-12-02	2033	4	12	December 	48	2	5	Friday   
3259	2033-12-03	2033	4	12	December 	48	3	6	Saturday 
3260	2033-12-04	2033	4	12	December 	48	4	0	Sunday   
3261	2033-12-05	2033	4	12	December 	49	5	1	Monday   
3262	2033-12-06	2033	4	12	December 	49	6	2	Tuesday  
3263	2033-12-07	2033	4	12	December 	49	7	3	Wednesday
3264	2033-12-08	2033	4	12	December 	49	8	4	Thursday 
3265	2033-12-09	2033	4	12	December 	49	9	5	Friday   
3266	2033-12-10	2033	4	12	December 	49	10	6	Saturday 
3267	2033-12-11	2033	4	12	December 	49	11	0	Sunday   
3268	2033-12-12	2033	4	12	December 	50	12	1	Monday   
3269	2033-12-13	2033	4	12	December 	50	13	2	Tuesday  
3270	2033-12-14	2033	4	12	December 	50	14	3	Wednesday
3271	2033-12-15	2033	4	12	December 	50	15	4	Thursday 
3272	2033-12-16	2033	4	12	December 	50	16	5	Friday   
3273	2033-12-17	2033	4	12	December 	50	17	6	Saturday 
3274	2033-12-18	2033	4	12	December 	50	18	0	Sunday   
3275	2033-12-19	2033	4	12	December 	51	19	1	Monday   
3276	2033-12-20	2033	4	12	December 	51	20	2	Tuesday  
3277	2033-12-21	2033	4	12	December 	51	21	3	Wednesday
3278	2033-12-22	2033	4	12	December 	51	22	4	Thursday 
3279	2033-12-23	2033	4	12	December 	51	23	5	Friday   
3280	2033-12-24	2033	4	12	December 	51	24	6	Saturday 
3281	2033-12-25	2033	4	12	December 	51	25	0	Sunday   
3282	2033-12-26	2033	4	12	December 	52	26	1	Monday   
3283	2033-12-27	2033	4	12	December 	52	27	2	Tuesday  
3284	2033-12-28	2033	4	12	December 	52	28	3	Wednesday
3285	2033-12-29	2033	4	12	December 	52	29	4	Thursday 
3286	2033-12-30	2033	4	12	December 	52	30	5	Friday   
3287	2033-12-31	2033	4	12	December 	52	31	6	Saturday 
3288	2034-01-01	2034	1	1	January  	52	1	0	Sunday   
3289	2034-01-02	2034	1	1	January  	1	2	1	Monday   
3290	2034-01-03	2034	1	1	January  	1	3	2	Tuesday  
3291	2034-01-04	2034	1	1	January  	1	4	3	Wednesday
3292	2034-01-05	2034	1	1	January  	1	5	4	Thursday 
3293	2034-01-06	2034	1	1	January  	1	6	5	Friday   
3294	2034-01-07	2034	1	1	January  	1	7	6	Saturday 
3295	2034-01-08	2034	1	1	January  	1	8	0	Sunday   
3296	2034-01-09	2034	1	1	January  	2	9	1	Monday   
3297	2034-01-10	2034	1	1	January  	2	10	2	Tuesday  
3298	2034-01-11	2034	1	1	January  	2	11	3	Wednesday
3299	2034-01-12	2034	1	1	January  	2	12	4	Thursday 
3300	2034-01-13	2034	1	1	January  	2	13	5	Friday   
3301	2034-01-14	2034	1	1	January  	2	14	6	Saturday 
3302	2034-01-15	2034	1	1	January  	2	15	0	Sunday   
3303	2034-01-16	2034	1	1	January  	3	16	1	Monday   
3304	2034-01-17	2034	1	1	January  	3	17	2	Tuesday  
3305	2034-01-18	2034	1	1	January  	3	18	3	Wednesday
3306	2034-01-19	2034	1	1	January  	3	19	4	Thursday 
3307	2034-01-20	2034	1	1	January  	3	20	5	Friday   
3308	2034-01-21	2034	1	1	January  	3	21	6	Saturday 
3309	2034-01-22	2034	1	1	January  	3	22	0	Sunday   
3310	2034-01-23	2034	1	1	January  	4	23	1	Monday   
3311	2034-01-24	2034	1	1	January  	4	24	2	Tuesday  
3312	2034-01-25	2034	1	1	January  	4	25	3	Wednesday
3313	2034-01-26	2034	1	1	January  	4	26	4	Thursday 
3314	2034-01-27	2034	1	1	January  	4	27	5	Friday   
3315	2034-01-28	2034	1	1	January  	4	28	6	Saturday 
3316	2034-01-29	2034	1	1	January  	4	29	0	Sunday   
3317	2034-01-30	2034	1	1	January  	5	30	1	Monday   
3318	2034-01-31	2034	1	1	January  	5	31	2	Tuesday  
3319	2034-02-01	2034	1	2	February 	5	1	3	Wednesday
3320	2034-02-02	2034	1	2	February 	5	2	4	Thursday 
3321	2034-02-03	2034	1	2	February 	5	3	5	Friday   
3322	2034-02-04	2034	1	2	February 	5	4	6	Saturday 
3323	2034-02-05	2034	1	2	February 	5	5	0	Sunday   
3324	2034-02-06	2034	1	2	February 	6	6	1	Monday   
3325	2034-02-07	2034	1	2	February 	6	7	2	Tuesday  
3326	2034-02-08	2034	1	2	February 	6	8	3	Wednesday
3327	2034-02-09	2034	1	2	February 	6	9	4	Thursday 
3328	2034-02-10	2034	1	2	February 	6	10	5	Friday   
3329	2034-02-11	2034	1	2	February 	6	11	6	Saturday 
3330	2034-02-12	2034	1	2	February 	6	12	0	Sunday   
3331	2034-02-13	2034	1	2	February 	7	13	1	Monday   
3332	2034-02-14	2034	1	2	February 	7	14	2	Tuesday  
3333	2034-02-15	2034	1	2	February 	7	15	3	Wednesday
3334	2034-02-16	2034	1	2	February 	7	16	4	Thursday 
3335	2034-02-17	2034	1	2	February 	7	17	5	Friday   
3336	2034-02-18	2034	1	2	February 	7	18	6	Saturday 
3337	2034-02-19	2034	1	2	February 	7	19	0	Sunday   
3338	2034-02-20	2034	1	2	February 	8	20	1	Monday   
3339	2034-02-21	2034	1	2	February 	8	21	2	Tuesday  
3340	2034-02-22	2034	1	2	February 	8	22	3	Wednesday
3341	2034-02-23	2034	1	2	February 	8	23	4	Thursday 
3342	2034-02-24	2034	1	2	February 	8	24	5	Friday   
3343	2034-02-25	2034	1	2	February 	8	25	6	Saturday 
3344	2034-02-26	2034	1	2	February 	8	26	0	Sunday   
3345	2034-02-27	2034	1	2	February 	9	27	1	Monday   
3346	2034-02-28	2034	1	2	February 	9	28	2	Tuesday  
3347	2034-03-01	2034	1	3	March    	9	1	3	Wednesday
3348	2034-03-02	2034	1	3	March    	9	2	4	Thursday 
3349	2034-03-03	2034	1	3	March    	9	3	5	Friday   
3350	2034-03-04	2034	1	3	March    	9	4	6	Saturday 
3351	2034-03-05	2034	1	3	March    	9	5	0	Sunday   
3352	2034-03-06	2034	1	3	March    	10	6	1	Monday   
3353	2034-03-07	2034	1	3	March    	10	7	2	Tuesday  
3354	2034-03-08	2034	1	3	March    	10	8	3	Wednesday
3355	2034-03-09	2034	1	3	March    	10	9	4	Thursday 
3356	2034-03-10	2034	1	3	March    	10	10	5	Friday   
3357	2034-03-11	2034	1	3	March    	10	11	6	Saturday 
3358	2034-03-12	2034	1	3	March    	10	12	0	Sunday   
3359	2034-03-13	2034	1	3	March    	11	13	1	Monday   
3360	2034-03-14	2034	1	3	March    	11	14	2	Tuesday  
3361	2034-03-15	2034	1	3	March    	11	15	3	Wednesday
3362	2034-03-16	2034	1	3	March    	11	16	4	Thursday 
3363	2034-03-17	2034	1	3	March    	11	17	5	Friday   
3364	2034-03-18	2034	1	3	March    	11	18	6	Saturday 
3365	2034-03-19	2034	1	3	March    	11	19	0	Sunday   
3366	2034-03-20	2034	1	3	March    	12	20	1	Monday   
3367	2034-03-21	2034	1	3	March    	12	21	2	Tuesday  
3368	2034-03-22	2034	1	3	March    	12	22	3	Wednesday
3369	2034-03-23	2034	1	3	March    	12	23	4	Thursday 
3370	2034-03-24	2034	1	3	March    	12	24	5	Friday   
3371	2034-03-25	2034	1	3	March    	12	25	6	Saturday 
3372	2034-03-26	2034	1	3	March    	12	26	0	Sunday   
3373	2034-03-27	2034	1	3	March    	13	27	1	Monday   
3374	2034-03-28	2034	1	3	March    	13	28	2	Tuesday  
3375	2034-03-29	2034	1	3	March    	13	29	3	Wednesday
3376	2034-03-30	2034	1	3	March    	13	30	4	Thursday 
3377	2034-03-31	2034	1	3	March    	13	31	5	Friday   
3378	2034-04-01	2034	2	4	April    	13	1	6	Saturday 
3379	2034-04-02	2034	2	4	April    	13	2	0	Sunday   
3380	2034-04-03	2034	2	4	April    	14	3	1	Monday   
3381	2034-04-04	2034	2	4	April    	14	4	2	Tuesday  
3382	2034-04-05	2034	2	4	April    	14	5	3	Wednesday
3383	2034-04-06	2034	2	4	April    	14	6	4	Thursday 
3384	2034-04-07	2034	2	4	April    	14	7	5	Friday   
3385	2034-04-08	2034	2	4	April    	14	8	6	Saturday 
3386	2034-04-09	2034	2	4	April    	14	9	0	Sunday   
3387	2034-04-10	2034	2	4	April    	15	10	1	Monday   
3388	2034-04-11	2034	2	4	April    	15	11	2	Tuesday  
3389	2034-04-12	2034	2	4	April    	15	12	3	Wednesday
3390	2034-04-13	2034	2	4	April    	15	13	4	Thursday 
3391	2034-04-14	2034	2	4	April    	15	14	5	Friday   
3392	2034-04-15	2034	2	4	April    	15	15	6	Saturday 
3393	2034-04-16	2034	2	4	April    	15	16	0	Sunday   
3394	2034-04-17	2034	2	4	April    	16	17	1	Monday   
3395	2034-04-18	2034	2	4	April    	16	18	2	Tuesday  
3396	2034-04-19	2034	2	4	April    	16	19	3	Wednesday
3397	2034-04-20	2034	2	4	April    	16	20	4	Thursday 
3398	2034-04-21	2034	2	4	April    	16	21	5	Friday   
3399	2034-04-22	2034	2	4	April    	16	22	6	Saturday 
3400	2034-04-23	2034	2	4	April    	16	23	0	Sunday   
3401	2034-04-24	2034	2	4	April    	17	24	1	Monday   
3402	2034-04-25	2034	2	4	April    	17	25	2	Tuesday  
3403	2034-04-26	2034	2	4	April    	17	26	3	Wednesday
3404	2034-04-27	2034	2	4	April    	17	27	4	Thursday 
3405	2034-04-28	2034	2	4	April    	17	28	5	Friday   
3406	2034-04-29	2034	2	4	April    	17	29	6	Saturday 
3407	2034-04-30	2034	2	4	April    	17	30	0	Sunday   
3408	2034-05-01	2034	2	5	May      	18	1	1	Monday   
3409	2034-05-02	2034	2	5	May      	18	2	2	Tuesday  
3410	2034-05-03	2034	2	5	May      	18	3	3	Wednesday
3411	2034-05-04	2034	2	5	May      	18	4	4	Thursday 
3412	2034-05-05	2034	2	5	May      	18	5	5	Friday   
3413	2034-05-06	2034	2	5	May      	18	6	6	Saturday 
3414	2034-05-07	2034	2	5	May      	18	7	0	Sunday   
3415	2034-05-08	2034	2	5	May      	19	8	1	Monday   
3416	2034-05-09	2034	2	5	May      	19	9	2	Tuesday  
3417	2034-05-10	2034	2	5	May      	19	10	3	Wednesday
3418	2034-05-11	2034	2	5	May      	19	11	4	Thursday 
3419	2034-05-12	2034	2	5	May      	19	12	5	Friday   
3420	2034-05-13	2034	2	5	May      	19	13	6	Saturday 
3421	2034-05-14	2034	2	5	May      	19	14	0	Sunday   
3422	2034-05-15	2034	2	5	May      	20	15	1	Monday   
3423	2034-05-16	2034	2	5	May      	20	16	2	Tuesday  
3424	2034-05-17	2034	2	5	May      	20	17	3	Wednesday
3425	2034-05-18	2034	2	5	May      	20	18	4	Thursday 
3426	2034-05-19	2034	2	5	May      	20	19	5	Friday   
3427	2034-05-20	2034	2	5	May      	20	20	6	Saturday 
3428	2034-05-21	2034	2	5	May      	20	21	0	Sunday   
3429	2034-05-22	2034	2	5	May      	21	22	1	Monday   
3430	2034-05-23	2034	2	5	May      	21	23	2	Tuesday  
3431	2034-05-24	2034	2	5	May      	21	24	3	Wednesday
3432	2034-05-25	2034	2	5	May      	21	25	4	Thursday 
3433	2034-05-26	2034	2	5	May      	21	26	5	Friday   
3434	2034-05-27	2034	2	5	May      	21	27	6	Saturday 
3435	2034-05-28	2034	2	5	May      	21	28	0	Sunday   
3436	2034-05-29	2034	2	5	May      	22	29	1	Monday   
3437	2034-05-30	2034	2	5	May      	22	30	2	Tuesday  
3438	2034-05-31	2034	2	5	May      	22	31	3	Wednesday
3439	2034-06-01	2034	2	6	June     	22	1	4	Thursday 
3440	2034-06-02	2034	2	6	June     	22	2	5	Friday   
3441	2034-06-03	2034	2	6	June     	22	3	6	Saturday 
3442	2034-06-04	2034	2	6	June     	22	4	0	Sunday   
3443	2034-06-05	2034	2	6	June     	23	5	1	Monday   
3444	2034-06-06	2034	2	6	June     	23	6	2	Tuesday  
3445	2034-06-07	2034	2	6	June     	23	7	3	Wednesday
3446	2034-06-08	2034	2	6	June     	23	8	4	Thursday 
3447	2034-06-09	2034	2	6	June     	23	9	5	Friday   
3448	2034-06-10	2034	2	6	June     	23	10	6	Saturday 
3449	2034-06-11	2034	2	6	June     	23	11	0	Sunday   
3450	2034-06-12	2034	2	6	June     	24	12	1	Monday   
3451	2034-06-13	2034	2	6	June     	24	13	2	Tuesday  
3452	2034-06-14	2034	2	6	June     	24	14	3	Wednesday
3453	2034-06-15	2034	2	6	June     	24	15	4	Thursday 
3454	2034-06-16	2034	2	6	June     	24	16	5	Friday   
3455	2034-06-17	2034	2	6	June     	24	17	6	Saturday 
3456	2034-06-18	2034	2	6	June     	24	18	0	Sunday   
3457	2034-06-19	2034	2	6	June     	25	19	1	Monday   
3458	2034-06-20	2034	2	6	June     	25	20	2	Tuesday  
3459	2034-06-21	2034	2	6	June     	25	21	3	Wednesday
3460	2034-06-22	2034	2	6	June     	25	22	4	Thursday 
3461	2034-06-23	2034	2	6	June     	25	23	5	Friday   
3462	2034-06-24	2034	2	6	June     	25	24	6	Saturday 
3463	2034-06-25	2034	2	6	June     	25	25	0	Sunday   
3464	2034-06-26	2034	2	6	June     	26	26	1	Monday   
3465	2034-06-27	2034	2	6	June     	26	27	2	Tuesday  
3466	2034-06-28	2034	2	6	June     	26	28	3	Wednesday
3467	2034-06-29	2034	2	6	June     	26	29	4	Thursday 
3468	2034-06-30	2034	2	6	June     	26	30	5	Friday   
3469	2034-07-01	2034	3	7	July     	26	1	6	Saturday 
3470	2034-07-02	2034	3	7	July     	26	2	0	Sunday   
3471	2034-07-03	2034	3	7	July     	27	3	1	Monday   
3472	2034-07-04	2034	3	7	July     	27	4	2	Tuesday  
3473	2034-07-05	2034	3	7	July     	27	5	3	Wednesday
3474	2034-07-06	2034	3	7	July     	27	6	4	Thursday 
3475	2034-07-07	2034	3	7	July     	27	7	5	Friday   
3476	2034-07-08	2034	3	7	July     	27	8	6	Saturday 
3477	2034-07-09	2034	3	7	July     	27	9	0	Sunday   
3478	2034-07-10	2034	3	7	July     	28	10	1	Monday   
3479	2034-07-11	2034	3	7	July     	28	11	2	Tuesday  
3480	2034-07-12	2034	3	7	July     	28	12	3	Wednesday
3481	2034-07-13	2034	3	7	July     	28	13	4	Thursday 
3482	2034-07-14	2034	3	7	July     	28	14	5	Friday   
3483	2034-07-15	2034	3	7	July     	28	15	6	Saturday 
3484	2034-07-16	2034	3	7	July     	28	16	0	Sunday   
3485	2034-07-17	2034	3	7	July     	29	17	1	Monday   
3486	2034-07-18	2034	3	7	July     	29	18	2	Tuesday  
3487	2034-07-19	2034	3	7	July     	29	19	3	Wednesday
3488	2034-07-20	2034	3	7	July     	29	20	4	Thursday 
3489	2034-07-21	2034	3	7	July     	29	21	5	Friday   
3490	2034-07-22	2034	3	7	July     	29	22	6	Saturday 
3491	2034-07-23	2034	3	7	July     	29	23	0	Sunday   
3492	2034-07-24	2034	3	7	July     	30	24	1	Monday   
3493	2034-07-25	2034	3	7	July     	30	25	2	Tuesday  
3494	2034-07-26	2034	3	7	July     	30	26	3	Wednesday
3495	2034-07-27	2034	3	7	July     	30	27	4	Thursday 
3496	2034-07-28	2034	3	7	July     	30	28	5	Friday   
3497	2034-07-29	2034	3	7	July     	30	29	6	Saturday 
3498	2034-07-30	2034	3	7	July     	30	30	0	Sunday   
3499	2034-07-31	2034	3	7	July     	31	31	1	Monday   
3500	2034-08-01	2034	3	8	August   	31	1	2	Tuesday  
3501	2034-08-02	2034	3	8	August   	31	2	3	Wednesday
3502	2034-08-03	2034	3	8	August   	31	3	4	Thursday 
3503	2034-08-04	2034	3	8	August   	31	4	5	Friday   
3504	2034-08-05	2034	3	8	August   	31	5	6	Saturday 
3505	2034-08-06	2034	3	8	August   	31	6	0	Sunday   
3506	2034-08-07	2034	3	8	August   	32	7	1	Monday   
3507	2034-08-08	2034	3	8	August   	32	8	2	Tuesday  
3508	2034-08-09	2034	3	8	August   	32	9	3	Wednesday
3509	2034-08-10	2034	3	8	August   	32	10	4	Thursday 
3510	2034-08-11	2034	3	8	August   	32	11	5	Friday   
3511	2034-08-12	2034	3	8	August   	32	12	6	Saturday 
3512	2034-08-13	2034	3	8	August   	32	13	0	Sunday   
3513	2034-08-14	2034	3	8	August   	33	14	1	Monday   
3514	2034-08-15	2034	3	8	August   	33	15	2	Tuesday  
3515	2034-08-16	2034	3	8	August   	33	16	3	Wednesday
3516	2034-08-17	2034	3	8	August   	33	17	4	Thursday 
3517	2034-08-18	2034	3	8	August   	33	18	5	Friday   
3518	2034-08-19	2034	3	8	August   	33	19	6	Saturday 
3519	2034-08-20	2034	3	8	August   	33	20	0	Sunday   
3520	2034-08-21	2034	3	8	August   	34	21	1	Monday   
3521	2034-08-22	2034	3	8	August   	34	22	2	Tuesday  
3522	2034-08-23	2034	3	8	August   	34	23	3	Wednesday
3523	2034-08-24	2034	3	8	August   	34	24	4	Thursday 
3524	2034-08-25	2034	3	8	August   	34	25	5	Friday   
3525	2034-08-26	2034	3	8	August   	34	26	6	Saturday 
3526	2034-08-27	2034	3	8	August   	34	27	0	Sunday   
3527	2034-08-28	2034	3	8	August   	35	28	1	Monday   
3528	2034-08-29	2034	3	8	August   	35	29	2	Tuesday  
3529	2034-08-30	2034	3	8	August   	35	30	3	Wednesday
3530	2034-08-31	2034	3	8	August   	35	31	4	Thursday 
3531	2034-09-01	2034	3	9	September	35	1	5	Friday   
3532	2034-09-02	2034	3	9	September	35	2	6	Saturday 
3533	2034-09-03	2034	3	9	September	35	3	0	Sunday   
3534	2034-09-04	2034	3	9	September	36	4	1	Monday   
3535	2034-09-05	2034	3	9	September	36	5	2	Tuesday  
3536	2034-09-06	2034	3	9	September	36	6	3	Wednesday
3537	2034-09-07	2034	3	9	September	36	7	4	Thursday 
3538	2034-09-08	2034	3	9	September	36	8	5	Friday   
3539	2034-09-09	2034	3	9	September	36	9	6	Saturday 
3540	2034-09-10	2034	3	9	September	36	10	0	Sunday   
3541	2034-09-11	2034	3	9	September	37	11	1	Monday   
3542	2034-09-12	2034	3	9	September	37	12	2	Tuesday  
3543	2034-09-13	2034	3	9	September	37	13	3	Wednesday
3544	2034-09-14	2034	3	9	September	37	14	4	Thursday 
3545	2034-09-15	2034	3	9	September	37	15	5	Friday   
3546	2034-09-16	2034	3	9	September	37	16	6	Saturday 
3547	2034-09-17	2034	3	9	September	37	17	0	Sunday   
3548	2034-09-18	2034	3	9	September	38	18	1	Monday   
3549	2034-09-19	2034	3	9	September	38	19	2	Tuesday  
3550	2034-09-20	2034	3	9	September	38	20	3	Wednesday
3551	2034-09-21	2034	3	9	September	38	21	4	Thursday 
3552	2034-09-22	2034	3	9	September	38	22	5	Friday   
3553	2034-09-23	2034	3	9	September	38	23	6	Saturday 
3554	2034-09-24	2034	3	9	September	38	24	0	Sunday   
3555	2034-09-25	2034	3	9	September	39	25	1	Monday   
3556	2034-09-26	2034	3	9	September	39	26	2	Tuesday  
3557	2034-09-27	2034	3	9	September	39	27	3	Wednesday
3558	2034-09-28	2034	3	9	September	39	28	4	Thursday 
3559	2034-09-29	2034	3	9	September	39	29	5	Friday   
3560	2034-09-30	2034	3	9	September	39	30	6	Saturday 
3561	2034-10-01	2034	4	10	October  	39	1	0	Sunday   
3562	2034-10-02	2034	4	10	October  	40	2	1	Monday   
3563	2034-10-03	2034	4	10	October  	40	3	2	Tuesday  
3564	2034-10-04	2034	4	10	October  	40	4	3	Wednesday
3565	2034-10-05	2034	4	10	October  	40	5	4	Thursday 
3566	2034-10-06	2034	4	10	October  	40	6	5	Friday   
3567	2034-10-07	2034	4	10	October  	40	7	6	Saturday 
3568	2034-10-08	2034	4	10	October  	40	8	0	Sunday   
3569	2034-10-09	2034	4	10	October  	41	9	1	Monday   
3570	2034-10-10	2034	4	10	October  	41	10	2	Tuesday  
3571	2034-10-11	2034	4	10	October  	41	11	3	Wednesday
3572	2034-10-12	2034	4	10	October  	41	12	4	Thursday 
3573	2034-10-13	2034	4	10	October  	41	13	5	Friday   
3574	2034-10-14	2034	4	10	October  	41	14	6	Saturday 
3575	2034-10-15	2034	4	10	October  	41	15	0	Sunday   
3576	2034-10-16	2034	4	10	October  	42	16	1	Monday   
3577	2034-10-17	2034	4	10	October  	42	17	2	Tuesday  
3578	2034-10-18	2034	4	10	October  	42	18	3	Wednesday
3579	2034-10-19	2034	4	10	October  	42	19	4	Thursday 
3580	2034-10-20	2034	4	10	October  	42	20	5	Friday   
3581	2034-10-21	2034	4	10	October  	42	21	6	Saturday 
3582	2034-10-22	2034	4	10	October  	42	22	0	Sunday   
3583	2034-10-23	2034	4	10	October  	43	23	1	Monday   
3584	2034-10-24	2034	4	10	October  	43	24	2	Tuesday  
3585	2034-10-25	2034	4	10	October  	43	25	3	Wednesday
3586	2034-10-26	2034	4	10	October  	43	26	4	Thursday 
3587	2034-10-27	2034	4	10	October  	43	27	5	Friday   
3588	2034-10-28	2034	4	10	October  	43	28	6	Saturday 
3589	2034-10-29	2034	4	10	October  	43	29	0	Sunday   
3590	2034-10-30	2034	4	10	October  	44	30	1	Monday   
3591	2034-10-31	2034	4	10	October  	44	31	2	Tuesday  
3592	2034-11-01	2034	4	11	November 	44	1	3	Wednesday
3593	2034-11-02	2034	4	11	November 	44	2	4	Thursday 
3594	2034-11-03	2034	4	11	November 	44	3	5	Friday   
3595	2034-11-04	2034	4	11	November 	44	4	6	Saturday 
3596	2034-11-05	2034	4	11	November 	44	5	0	Sunday   
3597	2034-11-06	2034	4	11	November 	45	6	1	Monday   
3598	2034-11-07	2034	4	11	November 	45	7	2	Tuesday  
3599	2034-11-08	2034	4	11	November 	45	8	3	Wednesday
3600	2034-11-09	2034	4	11	November 	45	9	4	Thursday 
3601	2034-11-10	2034	4	11	November 	45	10	5	Friday   
3602	2034-11-11	2034	4	11	November 	45	11	6	Saturday 
3603	2034-11-12	2034	4	11	November 	45	12	0	Sunday   
3604	2034-11-13	2034	4	11	November 	46	13	1	Monday   
3605	2034-11-14	2034	4	11	November 	46	14	2	Tuesday  
3606	2034-11-15	2034	4	11	November 	46	15	3	Wednesday
3607	2034-11-16	2034	4	11	November 	46	16	4	Thursday 
3608	2034-11-17	2034	4	11	November 	46	17	5	Friday   
3609	2034-11-18	2034	4	11	November 	46	18	6	Saturday 
3610	2034-11-19	2034	4	11	November 	46	19	0	Sunday   
3611	2034-11-20	2034	4	11	November 	47	20	1	Monday   
3612	2034-11-21	2034	4	11	November 	47	21	2	Tuesday  
3613	2034-11-22	2034	4	11	November 	47	22	3	Wednesday
3614	2034-11-23	2034	4	11	November 	47	23	4	Thursday 
3615	2034-11-24	2034	4	11	November 	47	24	5	Friday   
3616	2034-11-25	2034	4	11	November 	47	25	6	Saturday 
3617	2034-11-26	2034	4	11	November 	47	26	0	Sunday   
3618	2034-11-27	2034	4	11	November 	48	27	1	Monday   
3619	2034-11-28	2034	4	11	November 	48	28	2	Tuesday  
3620	2034-11-29	2034	4	11	November 	48	29	3	Wednesday
3621	2034-11-30	2034	4	11	November 	48	30	4	Thursday 
3622	2034-12-01	2034	4	12	December 	48	1	5	Friday   
3623	2034-12-02	2034	4	12	December 	48	2	6	Saturday 
3624	2034-12-03	2034	4	12	December 	48	3	0	Sunday   
3625	2034-12-04	2034	4	12	December 	49	4	1	Monday   
3626	2034-12-05	2034	4	12	December 	49	5	2	Tuesday  
3627	2034-12-06	2034	4	12	December 	49	6	3	Wednesday
3628	2034-12-07	2034	4	12	December 	49	7	4	Thursday 
3629	2034-12-08	2034	4	12	December 	49	8	5	Friday   
3630	2034-12-09	2034	4	12	December 	49	9	6	Saturday 
3631	2034-12-10	2034	4	12	December 	49	10	0	Sunday   
3632	2034-12-11	2034	4	12	December 	50	11	1	Monday   
3633	2034-12-12	2034	4	12	December 	50	12	2	Tuesday  
3634	2034-12-13	2034	4	12	December 	50	13	3	Wednesday
3635	2034-12-14	2034	4	12	December 	50	14	4	Thursday 
3636	2034-12-15	2034	4	12	December 	50	15	5	Friday   
3637	2034-12-16	2034	4	12	December 	50	16	6	Saturday 
3638	2034-12-17	2034	4	12	December 	50	17	0	Sunday   
3639	2034-12-18	2034	4	12	December 	51	18	1	Monday   
3640	2034-12-19	2034	4	12	December 	51	19	2	Tuesday  
3641	2034-12-20	2034	4	12	December 	51	20	3	Wednesday
3642	2034-12-21	2034	4	12	December 	51	21	4	Thursday 
3643	2034-12-22	2034	4	12	December 	51	22	5	Friday   
3644	2034-12-23	2034	4	12	December 	51	23	6	Saturday 
3645	2034-12-24	2034	4	12	December 	51	24	0	Sunday   
3646	2034-12-25	2034	4	12	December 	52	25	1	Monday   
3647	2034-12-26	2034	4	12	December 	52	26	2	Tuesday  
3648	2034-12-27	2034	4	12	December 	52	27	3	Wednesday
3649	2034-12-28	2034	4	12	December 	52	28	4	Thursday 
3650	2034-12-29	2034	4	12	December 	52	29	5	Friday   
3651	2034-12-30	2034	4	12	December 	52	30	6	Saturday 
3652	2034-12-31	2034	4	12	December 	52	31	0	Sunday   
3653	2035-01-01	2035	1	1	January  	1	1	1	Monday   
3654	2035-01-02	2035	1	1	January  	1	2	2	Tuesday  
3655	2035-01-03	2035	1	1	January  	1	3	3	Wednesday
3656	2035-01-04	2035	1	1	January  	1	4	4	Thursday 
3657	2035-01-05	2035	1	1	January  	1	5	5	Friday   
3658	2035-01-06	2035	1	1	January  	1	6	6	Saturday 
3659	2035-01-07	2035	1	1	January  	1	7	0	Sunday   
3660	2035-01-08	2035	1	1	January  	2	8	1	Monday   
3661	2035-01-09	2035	1	1	January  	2	9	2	Tuesday  
3662	2035-01-10	2035	1	1	January  	2	10	3	Wednesday
3663	2035-01-11	2035	1	1	January  	2	11	4	Thursday 
3664	2035-01-12	2035	1	1	January  	2	12	5	Friday   
3665	2035-01-13	2035	1	1	January  	2	13	6	Saturday 
3666	2035-01-14	2035	1	1	January  	2	14	0	Sunday   
3667	2035-01-15	2035	1	1	January  	3	15	1	Monday   
3668	2035-01-16	2035	1	1	January  	3	16	2	Tuesday  
3669	2035-01-17	2035	1	1	January  	3	17	3	Wednesday
3670	2035-01-18	2035	1	1	January  	3	18	4	Thursday 
3671	2035-01-19	2035	1	1	January  	3	19	5	Friday   
3672	2035-01-20	2035	1	1	January  	3	20	6	Saturday 
3673	2035-01-21	2035	1	1	January  	3	21	0	Sunday   
3674	2035-01-22	2035	1	1	January  	4	22	1	Monday   
3675	2035-01-23	2035	1	1	January  	4	23	2	Tuesday  
3676	2035-01-24	2035	1	1	January  	4	24	3	Wednesday
3677	2035-01-25	2035	1	1	January  	4	25	4	Thursday 
3678	2035-01-26	2035	1	1	January  	4	26	5	Friday   
3679	2035-01-27	2035	1	1	January  	4	27	6	Saturday 
3680	2035-01-28	2035	1	1	January  	4	28	0	Sunday   
3681	2035-01-29	2035	1	1	January  	5	29	1	Monday   
3682	2035-01-30	2035	1	1	January  	5	30	2	Tuesday  
3683	2035-01-31	2035	1	1	January  	5	31	3	Wednesday
3684	2035-02-01	2035	1	2	February 	5	1	4	Thursday 
3685	2035-02-02	2035	1	2	February 	5	2	5	Friday   
3686	2035-02-03	2035	1	2	February 	5	3	6	Saturday 
3687	2035-02-04	2035	1	2	February 	5	4	0	Sunday   
3688	2035-02-05	2035	1	2	February 	6	5	1	Monday   
3689	2035-02-06	2035	1	2	February 	6	6	2	Tuesday  
3690	2035-02-07	2035	1	2	February 	6	7	3	Wednesday
3691	2035-02-08	2035	1	2	February 	6	8	4	Thursday 
3692	2035-02-09	2035	1	2	February 	6	9	5	Friday   
3693	2035-02-10	2035	1	2	February 	6	10	6	Saturday 
3694	2035-02-11	2035	1	2	February 	6	11	0	Sunday   
3695	2035-02-12	2035	1	2	February 	7	12	1	Monday   
3696	2035-02-13	2035	1	2	February 	7	13	2	Tuesday  
3697	2035-02-14	2035	1	2	February 	7	14	3	Wednesday
3698	2035-02-15	2035	1	2	February 	7	15	4	Thursday 
3699	2035-02-16	2035	1	2	February 	7	16	5	Friday   
3700	2035-02-17	2035	1	2	February 	7	17	6	Saturday 
3701	2035-02-18	2035	1	2	February 	7	18	0	Sunday   
3702	2035-02-19	2035	1	2	February 	8	19	1	Monday   
3703	2035-02-20	2035	1	2	February 	8	20	2	Tuesday  
3704	2035-02-21	2035	1	2	February 	8	21	3	Wednesday
3705	2035-02-22	2035	1	2	February 	8	22	4	Thursday 
3706	2035-02-23	2035	1	2	February 	8	23	5	Friday   
3707	2035-02-24	2035	1	2	February 	8	24	6	Saturday 
3708	2035-02-25	2035	1	2	February 	8	25	0	Sunday   
3709	2035-02-26	2035	1	2	February 	9	26	1	Monday   
3710	2035-02-27	2035	1	2	February 	9	27	2	Tuesday  
3711	2035-02-28	2035	1	2	February 	9	28	3	Wednesday
3712	2035-03-01	2035	1	3	March    	9	1	4	Thursday 
3713	2035-03-02	2035	1	3	March    	9	2	5	Friday   
3714	2035-03-03	2035	1	3	March    	9	3	6	Saturday 
3715	2035-03-04	2035	1	3	March    	9	4	0	Sunday   
3716	2035-03-05	2035	1	3	March    	10	5	1	Monday   
3717	2035-03-06	2035	1	3	March    	10	6	2	Tuesday  
3718	2035-03-07	2035	1	3	March    	10	7	3	Wednesday
3719	2035-03-08	2035	1	3	March    	10	8	4	Thursday 
3720	2035-03-09	2035	1	3	March    	10	9	5	Friday   
3721	2035-03-10	2035	1	3	March    	10	10	6	Saturday 
3722	2035-03-11	2035	1	3	March    	10	11	0	Sunday   
3723	2035-03-12	2035	1	3	March    	11	12	1	Monday   
3724	2035-03-13	2035	1	3	March    	11	13	2	Tuesday  
3725	2035-03-14	2035	1	3	March    	11	14	3	Wednesday
3726	2035-03-15	2035	1	3	March    	11	15	4	Thursday 
3727	2035-03-16	2035	1	3	March    	11	16	5	Friday   
3728	2035-03-17	2035	1	3	March    	11	17	6	Saturday 
3729	2035-03-18	2035	1	3	March    	11	18	0	Sunday   
3730	2035-03-19	2035	1	3	March    	12	19	1	Monday   
3731	2035-03-20	2035	1	3	March    	12	20	2	Tuesday  
3732	2035-03-21	2035	1	3	March    	12	21	3	Wednesday
3733	2035-03-22	2035	1	3	March    	12	22	4	Thursday 
3734	2035-03-23	2035	1	3	March    	12	23	5	Friday   
3735	2035-03-24	2035	1	3	March    	12	24	6	Saturday 
3736	2035-03-25	2035	1	3	March    	12	25	0	Sunday   
3737	2035-03-26	2035	1	3	March    	13	26	1	Monday   
3738	2035-03-27	2035	1	3	March    	13	27	2	Tuesday  
3739	2035-03-28	2035	1	3	March    	13	28	3	Wednesday
3740	2035-03-29	2035	1	3	March    	13	29	4	Thursday 
3741	2035-03-30	2035	1	3	March    	13	30	5	Friday   
3742	2035-03-31	2035	1	3	March    	13	31	6	Saturday 
3743	2035-04-01	2035	2	4	April    	13	1	0	Sunday   
3744	2035-04-02	2035	2	4	April    	14	2	1	Monday   
3745	2035-04-03	2035	2	4	April    	14	3	2	Tuesday  
3746	2035-04-04	2035	2	4	April    	14	4	3	Wednesday
3747	2035-04-05	2035	2	4	April    	14	5	4	Thursday 
3748	2035-04-06	2035	2	4	April    	14	6	5	Friday   
3749	2035-04-07	2035	2	4	April    	14	7	6	Saturday 
3750	2035-04-08	2035	2	4	April    	14	8	0	Sunday   
3751	2035-04-09	2035	2	4	April    	15	9	1	Monday   
3752	2035-04-10	2035	2	4	April    	15	10	2	Tuesday  
3753	2035-04-11	2035	2	4	April    	15	11	3	Wednesday
3754	2035-04-12	2035	2	4	April    	15	12	4	Thursday 
3755	2035-04-13	2035	2	4	April    	15	13	5	Friday   
3756	2035-04-14	2035	2	4	April    	15	14	6	Saturday 
3757	2035-04-15	2035	2	4	April    	15	15	0	Sunday   
3758	2035-04-16	2035	2	4	April    	16	16	1	Monday   
3759	2035-04-17	2035	2	4	April    	16	17	2	Tuesday  
3760	2035-04-18	2035	2	4	April    	16	18	3	Wednesday
3761	2035-04-19	2035	2	4	April    	16	19	4	Thursday 
3762	2035-04-20	2035	2	4	April    	16	20	5	Friday   
3763	2035-04-21	2035	2	4	April    	16	21	6	Saturday 
3764	2035-04-22	2035	2	4	April    	16	22	0	Sunday   
3765	2035-04-23	2035	2	4	April    	17	23	1	Monday   
3766	2035-04-24	2035	2	4	April    	17	24	2	Tuesday  
3767	2035-04-25	2035	2	4	April    	17	25	3	Wednesday
3768	2035-04-26	2035	2	4	April    	17	26	4	Thursday 
3769	2035-04-27	2035	2	4	April    	17	27	5	Friday   
3770	2035-04-28	2035	2	4	April    	17	28	6	Saturday 
3771	2035-04-29	2035	2	4	April    	17	29	0	Sunday   
3772	2035-04-30	2035	2	4	April    	18	30	1	Monday   
3773	2035-05-01	2035	2	5	May      	18	1	2	Tuesday  
3774	2035-05-02	2035	2	5	May      	18	2	3	Wednesday
3775	2035-05-03	2035	2	5	May      	18	3	4	Thursday 
3776	2035-05-04	2035	2	5	May      	18	4	5	Friday   
3777	2035-05-05	2035	2	5	May      	18	5	6	Saturday 
3778	2035-05-06	2035	2	5	May      	18	6	0	Sunday   
3779	2035-05-07	2035	2	5	May      	19	7	1	Monday   
3780	2035-05-08	2035	2	5	May      	19	8	2	Tuesday  
3781	2035-05-09	2035	2	5	May      	19	9	3	Wednesday
3782	2035-05-10	2035	2	5	May      	19	10	4	Thursday 
3783	2035-05-11	2035	2	5	May      	19	11	5	Friday   
3784	2035-05-12	2035	2	5	May      	19	12	6	Saturday 
3785	2035-05-13	2035	2	5	May      	19	13	0	Sunday   
3786	2035-05-14	2035	2	5	May      	20	14	1	Monday   
3787	2035-05-15	2035	2	5	May      	20	15	2	Tuesday  
3788	2035-05-16	2035	2	5	May      	20	16	3	Wednesday
3789	2035-05-17	2035	2	5	May      	20	17	4	Thursday 
3790	2035-05-18	2035	2	5	May      	20	18	5	Friday   
3791	2035-05-19	2035	2	5	May      	20	19	6	Saturday 
3792	2035-05-20	2035	2	5	May      	20	20	0	Sunday   
3793	2035-05-21	2035	2	5	May      	21	21	1	Monday   
3794	2035-05-22	2035	2	5	May      	21	22	2	Tuesday  
3795	2035-05-23	2035	2	5	May      	21	23	3	Wednesday
3796	2035-05-24	2035	2	5	May      	21	24	4	Thursday 
3797	2035-05-25	2035	2	5	May      	21	25	5	Friday   
3798	2035-05-26	2035	2	5	May      	21	26	6	Saturday 
3799	2035-05-27	2035	2	5	May      	21	27	0	Sunday   
3800	2035-05-28	2035	2	5	May      	22	28	1	Monday   
3801	2035-05-29	2035	2	5	May      	22	29	2	Tuesday  
3802	2035-05-30	2035	2	5	May      	22	30	3	Wednesday
3803	2035-05-31	2035	2	5	May      	22	31	4	Thursday 
3804	2035-06-01	2035	2	6	June     	22	1	5	Friday   
3805	2035-06-02	2035	2	6	June     	22	2	6	Saturday 
3806	2035-06-03	2035	2	6	June     	22	3	0	Sunday   
3807	2035-06-04	2035	2	6	June     	23	4	1	Monday   
3808	2035-06-05	2035	2	6	June     	23	5	2	Tuesday  
3809	2035-06-06	2035	2	6	June     	23	6	3	Wednesday
3810	2035-06-07	2035	2	6	June     	23	7	4	Thursday 
3811	2035-06-08	2035	2	6	June     	23	8	5	Friday   
3812	2035-06-09	2035	2	6	June     	23	9	6	Saturday 
3813	2035-06-10	2035	2	6	June     	23	10	0	Sunday   
3814	2035-06-11	2035	2	6	June     	24	11	1	Monday   
3815	2035-06-12	2035	2	6	June     	24	12	2	Tuesday  
3816	2035-06-13	2035	2	6	June     	24	13	3	Wednesday
3817	2035-06-14	2035	2	6	June     	24	14	4	Thursday 
3818	2035-06-15	2035	2	6	June     	24	15	5	Friday   
3819	2035-06-16	2035	2	6	June     	24	16	6	Saturday 
3820	2035-06-17	2035	2	6	June     	24	17	0	Sunday   
3821	2035-06-18	2035	2	6	June     	25	18	1	Monday   
3822	2035-06-19	2035	2	6	June     	25	19	2	Tuesday  
3823	2035-06-20	2035	2	6	June     	25	20	3	Wednesday
3824	2035-06-21	2035	2	6	June     	25	21	4	Thursday 
3825	2035-06-22	2035	2	6	June     	25	22	5	Friday   
3826	2035-06-23	2035	2	6	June     	25	23	6	Saturday 
3827	2035-06-24	2035	2	6	June     	25	24	0	Sunday   
3828	2035-06-25	2035	2	6	June     	26	25	1	Monday   
3829	2035-06-26	2035	2	6	June     	26	26	2	Tuesday  
3830	2035-06-27	2035	2	6	June     	26	27	3	Wednesday
3831	2035-06-28	2035	2	6	June     	26	28	4	Thursday 
3832	2035-06-29	2035	2	6	June     	26	29	5	Friday   
3833	2035-06-30	2035	2	6	June     	26	30	6	Saturday 
3834	2035-07-01	2035	3	7	July     	26	1	0	Sunday   
3835	2035-07-02	2035	3	7	July     	27	2	1	Monday   
3836	2035-07-03	2035	3	7	July     	27	3	2	Tuesday  
3837	2035-07-04	2035	3	7	July     	27	4	3	Wednesday
3838	2035-07-05	2035	3	7	July     	27	5	4	Thursday 
3839	2035-07-06	2035	3	7	July     	27	6	5	Friday   
3840	2035-07-07	2035	3	7	July     	27	7	6	Saturday 
3841	2035-07-08	2035	3	7	July     	27	8	0	Sunday   
3842	2035-07-09	2035	3	7	July     	28	9	1	Monday   
3843	2035-07-10	2035	3	7	July     	28	10	2	Tuesday  
3844	2035-07-11	2035	3	7	July     	28	11	3	Wednesday
3845	2035-07-12	2035	3	7	July     	28	12	4	Thursday 
3846	2035-07-13	2035	3	7	July     	28	13	5	Friday   
3847	2035-07-14	2035	3	7	July     	28	14	6	Saturday 
3848	2035-07-15	2035	3	7	July     	28	15	0	Sunday   
3849	2035-07-16	2035	3	7	July     	29	16	1	Monday   
3850	2035-07-17	2035	3	7	July     	29	17	2	Tuesday  
3851	2035-07-18	2035	3	7	July     	29	18	3	Wednesday
3852	2035-07-19	2035	3	7	July     	29	19	4	Thursday 
3853	2035-07-20	2035	3	7	July     	29	20	5	Friday   
3854	2035-07-21	2035	3	7	July     	29	21	6	Saturday 
3855	2035-07-22	2035	3	7	July     	29	22	0	Sunday   
3856	2035-07-23	2035	3	7	July     	30	23	1	Monday   
3857	2035-07-24	2035	3	7	July     	30	24	2	Tuesday  
3858	2035-07-25	2035	3	7	July     	30	25	3	Wednesday
3859	2035-07-26	2035	3	7	July     	30	26	4	Thursday 
3860	2035-07-27	2035	3	7	July     	30	27	5	Friday   
3861	2035-07-28	2035	3	7	July     	30	28	6	Saturday 
3862	2035-07-29	2035	3	7	July     	30	29	0	Sunday   
3863	2035-07-30	2035	3	7	July     	31	30	1	Monday   
3864	2035-07-31	2035	3	7	July     	31	31	2	Tuesday  
3865	2035-08-01	2035	3	8	August   	31	1	3	Wednesday
3866	2035-08-02	2035	3	8	August   	31	2	4	Thursday 
3867	2035-08-03	2035	3	8	August   	31	3	5	Friday   
3868	2035-08-04	2035	3	8	August   	31	4	6	Saturday 
3869	2035-08-05	2035	3	8	August   	31	5	0	Sunday   
3870	2035-08-06	2035	3	8	August   	32	6	1	Monday   
3871	2035-08-07	2035	3	8	August   	32	7	2	Tuesday  
3872	2035-08-08	2035	3	8	August   	32	8	3	Wednesday
3873	2035-08-09	2035	3	8	August   	32	9	4	Thursday 
3874	2035-08-10	2035	3	8	August   	32	10	5	Friday   
3875	2035-08-11	2035	3	8	August   	32	11	6	Saturday 
3876	2035-08-12	2035	3	8	August   	32	12	0	Sunday   
3877	2035-08-13	2035	3	8	August   	33	13	1	Monday   
3878	2035-08-14	2035	3	8	August   	33	14	2	Tuesday  
3879	2035-08-15	2035	3	8	August   	33	15	3	Wednesday
3880	2035-08-16	2035	3	8	August   	33	16	4	Thursday 
3881	2035-08-17	2035	3	8	August   	33	17	5	Friday   
3882	2035-08-18	2035	3	8	August   	33	18	6	Saturday 
3883	2035-08-19	2035	3	8	August   	33	19	0	Sunday   
3884	2035-08-20	2035	3	8	August   	34	20	1	Monday   
3885	2035-08-21	2035	3	8	August   	34	21	2	Tuesday  
3886	2035-08-22	2035	3	8	August   	34	22	3	Wednesday
3887	2035-08-23	2035	3	8	August   	34	23	4	Thursday 
3888	2035-08-24	2035	3	8	August   	34	24	5	Friday   
3889	2035-08-25	2035	3	8	August   	34	25	6	Saturday 
3890	2035-08-26	2035	3	8	August   	34	26	0	Sunday   
3891	2035-08-27	2035	3	8	August   	35	27	1	Monday   
3892	2035-08-28	2035	3	8	August   	35	28	2	Tuesday  
3893	2035-08-29	2035	3	8	August   	35	29	3	Wednesday
3894	2035-08-30	2035	3	8	August   	35	30	4	Thursday 
3895	2035-08-31	2035	3	8	August   	35	31	5	Friday   
3896	2035-09-01	2035	3	9	September	35	1	6	Saturday 
3897	2035-09-02	2035	3	9	September	35	2	0	Sunday   
3898	2035-09-03	2035	3	9	September	36	3	1	Monday   
3899	2035-09-04	2035	3	9	September	36	4	2	Tuesday  
3900	2035-09-05	2035	3	9	September	36	5	3	Wednesday
3901	2035-09-06	2035	3	9	September	36	6	4	Thursday 
3902	2035-09-07	2035	3	9	September	36	7	5	Friday   
3903	2035-09-08	2035	3	9	September	36	8	6	Saturday 
3904	2035-09-09	2035	3	9	September	36	9	0	Sunday   
3905	2035-09-10	2035	3	9	September	37	10	1	Monday   
3906	2035-09-11	2035	3	9	September	37	11	2	Tuesday  
3907	2035-09-12	2035	3	9	September	37	12	3	Wednesday
3908	2035-09-13	2035	3	9	September	37	13	4	Thursday 
3909	2035-09-14	2035	3	9	September	37	14	5	Friday   
3910	2035-09-15	2035	3	9	September	37	15	6	Saturday 
3911	2035-09-16	2035	3	9	September	37	16	0	Sunday   
3912	2035-09-17	2035	3	9	September	38	17	1	Monday   
3913	2035-09-18	2035	3	9	September	38	18	2	Tuesday  
3914	2035-09-19	2035	3	9	September	38	19	3	Wednesday
3915	2035-09-20	2035	3	9	September	38	20	4	Thursday 
3916	2035-09-21	2035	3	9	September	38	21	5	Friday   
3917	2035-09-22	2035	3	9	September	38	22	6	Saturday 
3918	2035-09-23	2035	3	9	September	38	23	0	Sunday   
3919	2035-09-24	2035	3	9	September	39	24	1	Monday   
3920	2035-09-25	2035	3	9	September	39	25	2	Tuesday  
3921	2035-09-26	2035	3	9	September	39	26	3	Wednesday
3922	2035-09-27	2035	3	9	September	39	27	4	Thursday 
3923	2035-09-28	2035	3	9	September	39	28	5	Friday   
3924	2035-09-29	2035	3	9	September	39	29	6	Saturday 
3925	2035-09-30	2035	3	9	September	39	30	0	Sunday   
3926	2035-10-01	2035	4	10	October  	40	1	1	Monday   
3927	2035-10-02	2035	4	10	October  	40	2	2	Tuesday  
3928	2035-10-03	2035	4	10	October  	40	3	3	Wednesday
3929	2035-10-04	2035	4	10	October  	40	4	4	Thursday 
3930	2035-10-05	2035	4	10	October  	40	5	5	Friday   
3931	2035-10-06	2035	4	10	October  	40	6	6	Saturday 
3932	2035-10-07	2035	4	10	October  	40	7	0	Sunday   
3933	2035-10-08	2035	4	10	October  	41	8	1	Monday   
3934	2035-10-09	2035	4	10	October  	41	9	2	Tuesday  
3935	2035-10-10	2035	4	10	October  	41	10	3	Wednesday
3936	2035-10-11	2035	4	10	October  	41	11	4	Thursday 
3937	2035-10-12	2035	4	10	October  	41	12	5	Friday   
3938	2035-10-13	2035	4	10	October  	41	13	6	Saturday 
3939	2035-10-14	2035	4	10	October  	41	14	0	Sunday   
3940	2035-10-15	2035	4	10	October  	42	15	1	Monday   
3941	2035-10-16	2035	4	10	October  	42	16	2	Tuesday  
3942	2035-10-17	2035	4	10	October  	42	17	3	Wednesday
3943	2035-10-18	2035	4	10	October  	42	18	4	Thursday 
3944	2035-10-19	2035	4	10	October  	42	19	5	Friday   
3945	2035-10-20	2035	4	10	October  	42	20	6	Saturday 
3946	2035-10-21	2035	4	10	October  	42	21	0	Sunday   
3947	2035-10-22	2035	4	10	October  	43	22	1	Monday   
3948	2035-10-23	2035	4	10	October  	43	23	2	Tuesday  
3949	2035-10-24	2035	4	10	October  	43	24	3	Wednesday
3950	2035-10-25	2035	4	10	October  	43	25	4	Thursday 
3951	2035-10-26	2035	4	10	October  	43	26	5	Friday   
3952	2035-10-27	2035	4	10	October  	43	27	6	Saturday 
3953	2035-10-28	2035	4	10	October  	43	28	0	Sunday   
3954	2035-10-29	2035	4	10	October  	44	29	1	Monday   
3955	2035-10-30	2035	4	10	October  	44	30	2	Tuesday  
3956	2035-10-31	2035	4	10	October  	44	31	3	Wednesday
3957	2035-11-01	2035	4	11	November 	44	1	4	Thursday 
3958	2035-11-02	2035	4	11	November 	44	2	5	Friday   
3959	2035-11-03	2035	4	11	November 	44	3	6	Saturday 
3960	2035-11-04	2035	4	11	November 	44	4	0	Sunday   
3961	2035-11-05	2035	4	11	November 	45	5	1	Monday   
3962	2035-11-06	2035	4	11	November 	45	6	2	Tuesday  
3963	2035-11-07	2035	4	11	November 	45	7	3	Wednesday
3964	2035-11-08	2035	4	11	November 	45	8	4	Thursday 
3965	2035-11-09	2035	4	11	November 	45	9	5	Friday   
3966	2035-11-10	2035	4	11	November 	45	10	6	Saturday 
3967	2035-11-11	2035	4	11	November 	45	11	0	Sunday   
3968	2035-11-12	2035	4	11	November 	46	12	1	Monday   
3969	2035-11-13	2035	4	11	November 	46	13	2	Tuesday  
3970	2035-11-14	2035	4	11	November 	46	14	3	Wednesday
3971	2035-11-15	2035	4	11	November 	46	15	4	Thursday 
3972	2035-11-16	2035	4	11	November 	46	16	5	Friday   
3973	2035-11-17	2035	4	11	November 	46	17	6	Saturday 
3974	2035-11-18	2035	4	11	November 	46	18	0	Sunday   
3975	2035-11-19	2035	4	11	November 	47	19	1	Monday   
3976	2035-11-20	2035	4	11	November 	47	20	2	Tuesday  
3977	2035-11-21	2035	4	11	November 	47	21	3	Wednesday
3978	2035-11-22	2035	4	11	November 	47	22	4	Thursday 
3979	2035-11-23	2035	4	11	November 	47	23	5	Friday   
3980	2035-11-24	2035	4	11	November 	47	24	6	Saturday 
3981	2035-11-25	2035	4	11	November 	47	25	0	Sunday   
3982	2035-11-26	2035	4	11	November 	48	26	1	Monday   
3983	2035-11-27	2035	4	11	November 	48	27	2	Tuesday  
3984	2035-11-28	2035	4	11	November 	48	28	3	Wednesday
3985	2035-11-29	2035	4	11	November 	48	29	4	Thursday 
3986	2035-11-30	2035	4	11	November 	48	30	5	Friday   
3987	2035-12-01	2035	4	12	December 	48	1	6	Saturday 
3988	2035-12-02	2035	4	12	December 	48	2	0	Sunday   
3989	2035-12-03	2035	4	12	December 	49	3	1	Monday   
3990	2035-12-04	2035	4	12	December 	49	4	2	Tuesday  
3991	2035-12-05	2035	4	12	December 	49	5	3	Wednesday
3992	2035-12-06	2035	4	12	December 	49	6	4	Thursday 
3993	2035-12-07	2035	4	12	December 	49	7	5	Friday   
3994	2035-12-08	2035	4	12	December 	49	8	6	Saturday 
3995	2035-12-09	2035	4	12	December 	49	9	0	Sunday   
3996	2035-12-10	2035	4	12	December 	50	10	1	Monday   
3997	2035-12-11	2035	4	12	December 	50	11	2	Tuesday  
3998	2035-12-12	2035	4	12	December 	50	12	3	Wednesday
3999	2035-12-13	2035	4	12	December 	50	13	4	Thursday 
4000	2035-12-14	2035	4	12	December 	50	14	5	Friday   
4001	2035-12-15	2035	4	12	December 	50	15	6	Saturday 
4002	2035-12-16	2035	4	12	December 	50	16	0	Sunday   
4003	2035-12-17	2035	4	12	December 	51	17	1	Monday   
4004	2035-12-18	2035	4	12	December 	51	18	2	Tuesday  
4005	2035-12-19	2035	4	12	December 	51	19	3	Wednesday
4006	2035-12-20	2035	4	12	December 	51	20	4	Thursday 
4007	2035-12-21	2035	4	12	December 	51	21	5	Friday   
4008	2035-12-22	2035	4	12	December 	51	22	6	Saturday 
4009	2035-12-23	2035	4	12	December 	51	23	0	Sunday   
4010	2035-12-24	2035	4	12	December 	52	24	1	Monday   
4011	2035-12-25	2035	4	12	December 	52	25	2	Tuesday  
4012	2035-12-26	2035	4	12	December 	52	26	3	Wednesday
4013	2035-12-27	2035	4	12	December 	52	27	4	Thursday 
4014	2035-12-28	2035	4	12	December 	52	28	5	Friday   
4015	2035-12-29	2035	4	12	December 	52	29	6	Saturday 
4016	2035-12-30	2035	4	12	December 	52	30	0	Sunday   
\.


--
-- Data for Name: dim_torneo; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.dim_torneo (id, torneo_id, nombre, categoria) FROM stdin;
1	1	Copa Apertura 2027	Adulto
2	2	Liga Metropolitana 2027	Juvenil
\.


--
-- Data for Name: fact_estadisticas_jugador; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.fact_estadisticas_jugador (id, tiempo_id, jugador_id, partidos, goles, asistencias, amarillas, rojas) FROM stdin;
\.


--
-- Data for Name: fact_partidos; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.fact_partidos (id, tiempo_id, torneo_id, equipo_local_id, equipo_visita_id, goles_local, goles_visita) FROM stdin;
1	799	1	1	2	3	1
2	799	1	3	4	2	2
3	800	1	5	6	0	1
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: auditoria; Owner: postgres
--

COPY auditoria.logs (id, usuario_id, accion, tabla_afectada, fecha) FROM stdin;
\.


--
-- Data for Name: categorias; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.categorias (id, nombre) FROM stdin;
1	Adulto
2	Juvenil
3	Senior
4	Damas
\.


--
-- Data for Name: equipo_jugador; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.equipo_jugador (id, equipo_id, jugador_id, fecha_desde, fecha_hasta, activo) FROM stdin;
\.


--
-- Data for Name: equipos; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.equipos (id, nombre, escudo_url, fecha_creacion) FROM stdin;
1	Deportivo Puente Alto	\N	2026-10-21 01:06:51.072363
2	AtlÃ©tico Cordillera	\N	2026-10-21 01:06:51.072363
3	UniÃ³n Sur	\N	2026-10-21 01:06:51.072363
4	Real Maipo	\N	2026-10-21 01:06:51.072363
5	Club Municipal	\N	2026-10-21 01:06:51.072363
6	Estrella Roja	\N	2026-10-21 01:06:51.072363
\.


--
-- Data for Name: estadisticas_jugador; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.estadisticas_jugador (jugador_id, partidos, goles, asistencias, amarillas, rojas) FROM stdin;
\.


--
-- Data for Name: eventos_partido; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.eventos_partido (id, partido_id, jugador_id, tipo_evento, minuto, descripcion) FROM stdin;
\.


--
-- Data for Name: jugadores; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.jugadores (id, usuario_id, rut, fecha_nacimiento, posicion) FROM stdin;
\.


--
-- Data for Name: notificaciones; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.notificaciones (id, usuario_id, titulo, mensaje, leida, fecha) FROM stdin;
1	afeec918-aa0d-4682-871b-003b36b21afb	Bienvenido	Tu cuenta ha sido creada correctamente	f	2026-10-21 01:06:51.171507
\.


--
-- Data for Name: partidos; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.partidos (id, torneo_id, equipo_local, equipo_visita, fecha_partido, cancha, estado) FROM stdin;
1	1	1	2	2027-03-10 19:00:00	Estadio Municipal	FINALIZADO
2	1	3	4	2027-03-10 21:00:00	Estadio Municipal	FINALIZADO
3	1	5	6	2027-03-11 18:30:00	Cancha Sur	FINALIZADO
\.


--
-- Data for Name: resultados; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.resultados (partido_id, goles_local, goles_visita, registrado_por, fecha_registro) FROM stdin;
1	3	1	\N	2026-10-21 01:06:51.139344
2	2	2	\N	2026-10-21 01:06:51.139344
3	0	1	\N	2026-10-21 01:06:51.139344
\.


--
-- Data for Name: torneo_equipos; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.torneo_equipos (id, torneo_id, equipo_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
\.


--
-- Data for Name: torneos; Type: TABLE DATA; Schema: deportivo; Owner: postgres
--

COPY deportivo.torneos (id, nombre, categoria_id, fecha_inicio, fecha_fin, estado) FROM stdin;
1	Copa Apertura 2027	1	2027-03-01	2027-06-30	ACTIVO
2	Liga Metropolitana 2027	2	2027-08-01	2027-12-30	PLANIFICADO
\.


--
-- Data for Name: transacciones; Type: TABLE DATA; Schema: pagos; Owner: postgres
--

COPY pagos.transacciones (id, usuario_id, monto, estado, flow_id, fecha) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.roles (id, nombre, descripcion) FROM stdin;
1	ADMINISTRADOR	\N
2	ORGANIZADOR	\N
3	ENTRENADOR	\N
4	ARBITRO	\N
5	ESTADIGRAFO	\N
6	JUGADOR	\N
7	ESPECTADOR	\N
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.usuarios (id, nombre, apellido, correo, password_hash, telefono, activo, fecha_creacion, rol_id) FROM stdin;
afeec918-aa0d-4682-871b-003b36b21afb	Admin	Sistema	admin@statshub.cl	123456	999999999	t	2026-10-21 01:06:22.904042	1
\.


--
-- Name: dim_equipo_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.dim_equipo_id_seq', 6, true);


--
-- Name: dim_jugador_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.dim_jugador_id_seq', 1, false);


--
-- Name: dim_tiempo_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.dim_tiempo_id_seq', 4016, true);


--
-- Name: dim_torneo_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.dim_torneo_id_seq', 2, true);


--
-- Name: fact_estadisticas_jugador_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.fact_estadisticas_jugador_id_seq', 1, false);


--
-- Name: fact_partidos_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.fact_partidos_id_seq', 3, true);


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: auditoria; Owner: postgres
--

SELECT pg_catalog.setval('auditoria.logs_id_seq', 1, false);


--
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: deportivo; Owner: postgres
--

SELECT pg_catalog.setval('deportivo.categorias_id_seq', 4, true);


--
-- Name: equipo_jugador_id_seq; Type: SEQUENCE SET; Schema: deportivo; Owner: postgres
--

SELECT pg_catalog.setval('deportivo.equipo_jugador_id_seq', 3, true);


--
-- Name: equipos_id_seq; Type: SEQUENCE SET; Schema: deportivo; Owner: postgres
--

SELECT pg_catalog.setval('deportivo.equipos_id_seq', 6, true);


--
-- Name: eventos_partido_id_seq; Type: SEQUENCE SET; Schema: deportivo; Owner: postgres
--

SELECT pg_catalog.setval('deportivo.eventos_partido_id_seq', 4, true);


--
-- Name: jugadores_id_seq; Type: SEQUENCE SET; Schema: deportivo; Owner: postgres
--

SELECT pg_catalog.setval('deportivo.jugadores_id_seq', 1, false);


--
-- Name: notificaciones_id_seq; Type: SEQUENCE SET; Schema: deportivo; Owner: postgres
--

SELECT pg_catalog.setval('deportivo.notificaciones_id_seq', 1, true);


--
-- Name: partidos_id_seq; Type: SEQUENCE SET; Schema: deportivo; Owner: postgres
--

SELECT pg_catalog.setval('deportivo.partidos_id_seq', 3, true);


--
-- Name: torneo_equipos_id_seq; Type: SEQUENCE SET; Schema: deportivo; Owner: postgres
--

SELECT pg_catalog.setval('deportivo.torneo_equipos_id_seq', 6, true);


--
-- Name: torneos_id_seq; Type: SEQUENCE SET; Schema: deportivo; Owner: postgres
--

SELECT pg_catalog.setval('deportivo.torneos_id_seq', 2, true);


--
-- Name: transacciones_id_seq; Type: SEQUENCE SET; Schema: pagos; Owner: postgres
--

SELECT pg_catalog.setval('pagos.transacciones_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.roles_id_seq', 7, true);


--
-- Name: dim_equipo dim_equipo_equipo_id_key; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_equipo
    ADD CONSTRAINT dim_equipo_equipo_id_key UNIQUE (equipo_id);


--
-- Name: dim_equipo dim_equipo_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_equipo
    ADD CONSTRAINT dim_equipo_pkey PRIMARY KEY (id);


--
-- Name: dim_jugador dim_jugador_jugador_id_key; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_jugador
    ADD CONSTRAINT dim_jugador_jugador_id_key UNIQUE (jugador_id);


--
-- Name: dim_jugador dim_jugador_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_jugador
    ADD CONSTRAINT dim_jugador_pkey PRIMARY KEY (id);


--
-- Name: dim_tiempo dim_tiempo_fecha_key; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_tiempo
    ADD CONSTRAINT dim_tiempo_fecha_key UNIQUE (fecha);


--
-- Name: dim_tiempo dim_tiempo_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_tiempo
    ADD CONSTRAINT dim_tiempo_pkey PRIMARY KEY (id);


--
-- Name: dim_torneo dim_torneo_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_torneo
    ADD CONSTRAINT dim_torneo_pkey PRIMARY KEY (id);


--
-- Name: dim_torneo dim_torneo_torneo_id_key; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.dim_torneo
    ADD CONSTRAINT dim_torneo_torneo_id_key UNIQUE (torneo_id);


--
-- Name: fact_estadisticas_jugador fact_estadisticas_jugador_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.fact_estadisticas_jugador
    ADD CONSTRAINT fact_estadisticas_jugador_pkey PRIMARY KEY (id);


--
-- Name: fact_partidos fact_partidos_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.fact_partidos
    ADD CONSTRAINT fact_partidos_pkey PRIMARY KEY (id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: auditoria; Owner: postgres
--

ALTER TABLE ONLY auditoria.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- Name: equipo_jugador equipo_jugador_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.equipo_jugador
    ADD CONSTRAINT equipo_jugador_pkey PRIMARY KEY (id);


--
-- Name: equipos equipos_nombre_key; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.equipos
    ADD CONSTRAINT equipos_nombre_key UNIQUE (nombre);


--
-- Name: equipos equipos_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.equipos
    ADD CONSTRAINT equipos_pkey PRIMARY KEY (id);


--
-- Name: estadisticas_jugador estadisticas_jugador_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.estadisticas_jugador
    ADD CONSTRAINT estadisticas_jugador_pkey PRIMARY KEY (jugador_id);


--
-- Name: eventos_partido eventos_partido_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.eventos_partido
    ADD CONSTRAINT eventos_partido_pkey PRIMARY KEY (id);


--
-- Name: jugadores jugadores_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.jugadores
    ADD CONSTRAINT jugadores_pkey PRIMARY KEY (id);


--
-- Name: jugadores jugadores_rut_key; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.jugadores
    ADD CONSTRAINT jugadores_rut_key UNIQUE (rut);


--
-- Name: jugadores jugadores_usuario_id_key; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.jugadores
    ADD CONSTRAINT jugadores_usuario_id_key UNIQUE (usuario_id);


--
-- Name: notificaciones notificaciones_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.notificaciones
    ADD CONSTRAINT notificaciones_pkey PRIMARY KEY (id);


--
-- Name: partidos partidos_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.partidos
    ADD CONSTRAINT partidos_pkey PRIMARY KEY (id);


--
-- Name: resultados resultados_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.resultados
    ADD CONSTRAINT resultados_pkey PRIMARY KEY (partido_id);


--
-- Name: torneo_equipos torneo_equipos_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.torneo_equipos
    ADD CONSTRAINT torneo_equipos_pkey PRIMARY KEY (id);


--
-- Name: torneo_equipos torneo_equipos_torneo_id_equipo_id_key; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.torneo_equipos
    ADD CONSTRAINT torneo_equipos_torneo_id_equipo_id_key UNIQUE (torneo_id, equipo_id);


--
-- Name: torneos torneos_pkey; Type: CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.torneos
    ADD CONSTRAINT torneos_pkey PRIMARY KEY (id);


--
-- Name: transacciones transacciones_pkey; Type: CONSTRAINT; Schema: pagos; Owner: postgres
--

ALTER TABLE ONLY pagos.transacciones
    ADD CONSTRAINT transacciones_pkey PRIMARY KEY (id);


--
-- Name: roles roles_nombre_key; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.roles
    ADD CONSTRAINT roles_nombre_key UNIQUE (nombre);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: idx_fact_estadisticas_jugador; Type: INDEX; Schema: analytics; Owner: postgres
--

CREATE INDEX idx_fact_estadisticas_jugador ON analytics.fact_estadisticas_jugador USING btree (jugador_id);


--
-- Name: idx_fact_estadisticas_tiempo; Type: INDEX; Schema: analytics; Owner: postgres
--

CREATE INDEX idx_fact_estadisticas_tiempo ON analytics.fact_estadisticas_jugador USING btree (tiempo_id);


--
-- Name: idx_fact_partidos_tiempo; Type: INDEX; Schema: analytics; Owner: postgres
--

CREATE INDEX idx_fact_partidos_tiempo ON analytics.fact_partidos USING btree (tiempo_id);


--
-- Name: idx_fact_partidos_torneo; Type: INDEX; Schema: analytics; Owner: postgres
--

CREATE INDEX idx_fact_partidos_torneo ON analytics.fact_partidos USING btree (torneo_id);


--
-- Name: idx_equipo_jugador_equipo; Type: INDEX; Schema: deportivo; Owner: postgres
--

CREATE INDEX idx_equipo_jugador_equipo ON deportivo.equipo_jugador USING btree (equipo_id);


--
-- Name: idx_equipo_jugador_jugador; Type: INDEX; Schema: deportivo; Owner: postgres
--

CREATE INDEX idx_equipo_jugador_jugador ON deportivo.equipo_jugador USING btree (jugador_id);


--
-- Name: idx_evento_jugador; Type: INDEX; Schema: deportivo; Owner: postgres
--

CREATE INDEX idx_evento_jugador ON deportivo.eventos_partido USING btree (jugador_id);


--
-- Name: idx_evento_partido; Type: INDEX; Schema: deportivo; Owner: postgres
--

CREATE INDEX idx_evento_partido ON deportivo.eventos_partido USING btree (partido_id);


--
-- Name: idx_jugador_usuario; Type: INDEX; Schema: deportivo; Owner: postgres
--

CREATE INDEX idx_jugador_usuario ON deportivo.jugadores USING btree (usuario_id);


--
-- Name: idx_partido_torneo; Type: INDEX; Schema: deportivo; Owner: postgres
--

CREATE INDEX idx_partido_torneo ON deportivo.partidos USING btree (torneo_id);


--
-- Name: fact_estadisticas_jugador fact_estadisticas_jugador_jugador_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.fact_estadisticas_jugador
    ADD CONSTRAINT fact_estadisticas_jugador_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES analytics.dim_jugador(id);


--
-- Name: fact_estadisticas_jugador fact_estadisticas_jugador_tiempo_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.fact_estadisticas_jugador
    ADD CONSTRAINT fact_estadisticas_jugador_tiempo_id_fkey FOREIGN KEY (tiempo_id) REFERENCES analytics.dim_tiempo(id);


--
-- Name: fact_partidos fact_partidos_equipo_local_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.fact_partidos
    ADD CONSTRAINT fact_partidos_equipo_local_id_fkey FOREIGN KEY (equipo_local_id) REFERENCES analytics.dim_equipo(id);


--
-- Name: fact_partidos fact_partidos_equipo_visita_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.fact_partidos
    ADD CONSTRAINT fact_partidos_equipo_visita_id_fkey FOREIGN KEY (equipo_visita_id) REFERENCES analytics.dim_equipo(id);


--
-- Name: fact_partidos fact_partidos_tiempo_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.fact_partidos
    ADD CONSTRAINT fact_partidos_tiempo_id_fkey FOREIGN KEY (tiempo_id) REFERENCES analytics.dim_tiempo(id);


--
-- Name: fact_partidos fact_partidos_torneo_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.fact_partidos
    ADD CONSTRAINT fact_partidos_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES analytics.dim_torneo(id);


--
-- Name: equipo_jugador equipo_jugador_equipo_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.equipo_jugador
    ADD CONSTRAINT equipo_jugador_equipo_id_fkey FOREIGN KEY (equipo_id) REFERENCES deportivo.equipos(id);


--
-- Name: equipo_jugador equipo_jugador_jugador_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.equipo_jugador
    ADD CONSTRAINT equipo_jugador_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES deportivo.jugadores(id);


--
-- Name: estadisticas_jugador estadisticas_jugador_jugador_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.estadisticas_jugador
    ADD CONSTRAINT estadisticas_jugador_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES deportivo.jugadores(id);


--
-- Name: eventos_partido eventos_partido_jugador_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.eventos_partido
    ADD CONSTRAINT eventos_partido_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES deportivo.jugadores(id);


--
-- Name: eventos_partido eventos_partido_partido_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.eventos_partido
    ADD CONSTRAINT eventos_partido_partido_id_fkey FOREIGN KEY (partido_id) REFERENCES deportivo.partidos(id);


--
-- Name: jugadores jugadores_usuario_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.jugadores
    ADD CONSTRAINT jugadores_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES seguridad.usuarios(id);


--
-- Name: notificaciones notificaciones_usuario_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.notificaciones
    ADD CONSTRAINT notificaciones_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES seguridad.usuarios(id);


--
-- Name: partidos partidos_equipo_local_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.partidos
    ADD CONSTRAINT partidos_equipo_local_fkey FOREIGN KEY (equipo_local) REFERENCES deportivo.equipos(id);


--
-- Name: partidos partidos_equipo_visita_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.partidos
    ADD CONSTRAINT partidos_equipo_visita_fkey FOREIGN KEY (equipo_visita) REFERENCES deportivo.equipos(id);


--
-- Name: partidos partidos_torneo_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.partidos
    ADD CONSTRAINT partidos_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES deportivo.torneos(id);


--
-- Name: resultados resultados_partido_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.resultados
    ADD CONSTRAINT resultados_partido_id_fkey FOREIGN KEY (partido_id) REFERENCES deportivo.partidos(id);


--
-- Name: resultados resultados_registrado_por_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.resultados
    ADD CONSTRAINT resultados_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES seguridad.usuarios(id);


--
-- Name: torneo_equipos torneo_equipos_equipo_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.torneo_equipos
    ADD CONSTRAINT torneo_equipos_equipo_id_fkey FOREIGN KEY (equipo_id) REFERENCES deportivo.equipos(id);


--
-- Name: torneo_equipos torneo_equipos_torneo_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.torneo_equipos
    ADD CONSTRAINT torneo_equipos_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES deportivo.torneos(id);


--
-- Name: torneos torneos_categoria_id_fkey; Type: FK CONSTRAINT; Schema: deportivo; Owner: postgres
--

ALTER TABLE ONLY deportivo.torneos
    ADD CONSTRAINT torneos_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES deportivo.categorias(id);


--
-- Name: transacciones transacciones_usuario_id_fkey; Type: FK CONSTRAINT; Schema: pagos; Owner: postgres
--

ALTER TABLE ONLY pagos.transacciones
    ADD CONSTRAINT transacciones_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES seguridad.usuarios(id);


--
-- Name: usuarios usuarios_rol_id_fkey; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT usuarios_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES seguridad.roles(id);


--
-- PostgreSQL database dump complete
--

\unrestrict D9DnqEhcv1Nqg2Q3sZzNFIZk0M1ZdBoymPvNlLe2mjIVDSrgtnlhU9dLnoRbty1

