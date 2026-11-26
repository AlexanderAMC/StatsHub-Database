-- Up Migration
-- Básquetbol (deporte principal) junto al fútbol: cada torneo define su deporte y el acta,
-- la tabla y las estadísticas se adaptan a él.

-- Los torneos existentes eran de fútbol; los nuevos parten como básquetbol.
ALTER TABLE deportivo.torneos
    ADD COLUMN deporte VARCHAR(12) NOT NULL DEFAULT 'FUTBOL'
        CONSTRAINT torneos_deporte_check CHECK (deporte IN ('FUTBOL', 'BASQUETBOL'));
ALTER TABLE deportivo.torneos ALTER COLUMN deporte SET DEFAULT 'BASQUETBOL';

-- Cuarto en juego (1-4; 5 en adelante = prórrogas). En fútbol queda en 1.
ALTER TABLE deportivo.partidos
    ADD COLUMN periodo SMALLINT NOT NULL DEFAULT 1 CONSTRAINT partidos_periodo_check CHECK (periodo BETWEEN 1 AND 10);

ALTER TABLE deportivo.eventos_partido
    ADD COLUMN periodo SMALLINT CONSTRAINT eventos_partido_periodo_check CHECK (periodo BETWEEN 1 AND 10);

-- Tipos de evento de ambos deportes (el CHECK original venía sin nombre explícito).
DO $$
DECLARE c record;
BEGIN
  FOR c IN
    SELECT conname FROM pg_constraint
    WHERE conrelid = 'deportivo.eventos_partido'::regclass AND contype = 'c'
      AND pg_get_constraintdef(oid) LIKE '%tipo_evento%'
  LOOP
    EXECUTE format('ALTER TABLE deportivo.eventos_partido DROP CONSTRAINT %I', c.conname);
  END LOOP;
END $$;

ALTER TABLE deportivo.eventos_partido ADD CONSTRAINT eventos_partido_tipo_evento_check CHECK (tipo_evento IN (
    'GOL', 'ASISTENCIA', 'AMARILLA', 'ROJA', 'LESION', 'SUSTITUCION',
    'PUNTO_1', 'PUNTO_2', 'PUNTO_3', 'REBOTE', 'FALTA', 'FALTA_TECNICA', 'FALTA_ANTIDEPORTIVA', 'TIEMPO_MUERTO'
));

CREATE INDEX idx_torneos_deporte ON deportivo.torneos (deporte);

-- Down Migration
DROP INDEX IF EXISTS deportivo.idx_torneos_deporte;

DELETE FROM deportivo.eventos_partido
WHERE tipo_evento IN ('PUNTO_1', 'PUNTO_2', 'PUNTO_3', 'REBOTE', 'FALTA', 'FALTA_TECNICA', 'FALTA_ANTIDEPORTIVA', 'TIEMPO_MUERTO');

ALTER TABLE deportivo.eventos_partido DROP CONSTRAINT IF EXISTS eventos_partido_tipo_evento_check;
ALTER TABLE deportivo.eventos_partido ADD CONSTRAINT eventos_partido_tipo_evento_check CHECK (tipo_evento IN (
    'GOL', 'ASISTENCIA', 'AMARILLA', 'ROJA', 'LESION', 'SUSTITUCION'
));

ALTER TABLE deportivo.eventos_partido DROP COLUMN IF EXISTS periodo;
ALTER TABLE deportivo.partidos DROP COLUMN IF EXISTS periodo;
ALTER TABLE deportivo.torneos DROP COLUMN IF EXISTS deporte;
