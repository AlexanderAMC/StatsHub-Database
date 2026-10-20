TRUNCATE TABLE analytics.dim_tiempo
RESTART IDENTITY CASCADE;

INSERT INTO analytics.dim_tiempo (
    fecha,
    anio,
    trimestre,
    mes,
    nombre_mes,
    semana,
    dia,
    dia_semana,
    nombre_dia
)
SELECT
    fecha::date,
    EXTRACT(YEAR FROM fecha)::INT,
    EXTRACT(QUARTER FROM fecha)::INT,
    EXTRACT(MONTH FROM fecha)::INT,
    TO_CHAR(fecha,'Month'),
    EXTRACT(WEEK FROM fecha)::INT,
    EXTRACT(DAY FROM fecha)::INT,
    EXTRACT(DOW FROM fecha)::INT,
    TO_CHAR(fecha,'Day')
FROM generate_series(
    '2025-01-01'::date,
    '2035-12-31'::date,
    interval '1 day'
) fecha;