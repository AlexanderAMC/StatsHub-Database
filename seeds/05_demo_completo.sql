-- =====================================
-- DATOS DE DEMOSTRACIÓN COMPLETOS
-- =====================================
-- Requisito: haber ejecutado 01..04 (npm run seed -- --demo los ejecuta en orden).
-- Completa los datos mínimos de 04 para que todas las pantallas muestren información:
--   · Copa Apertura: liga a dos ruedas (6 equipos, 10 jornadas, 30 partidos) con fechas relativas a hoy:
--     jornadas 1-6 finalizadas (resultados, goles, asistencias y tarjetas), jornada 7 hoy, 8-10 por jugar.
--   · Planteles de 10 jugadores por equipo, entrenadores, una transferencia.
--   · Árbitro y estadígrafo asignados, actas cerradas/validadas, tarifas y una liquidación pagada.
--   · Cobros de inscripción y planilla (pagados y pendientes) con sus transacciones.
--   · Liga Metropolitana con inscripciones abiertas.
-- Se puede ejecutar varias veces: si la Copa Apertura ya tiene la jornada 2, no hace nada.

DO $$
DECLARE
    v_torneo        INT;
    v_torneo2       INT;
    v_arbitro       UUID;
    v_estadigrafo   UUID;
    v_organizador   UUID;
    v_inicio        DATE := CURRENT_DATE - 42;          -- jornada 1 = hace 6 semanas
    v_equipos       INT[];
    v_nombres       TEXT[] := ARRAY['Matías','Benjamín','Vicente','Martín','Joaquín','Agustín','Tomás','Cristóbal',
                                    'Sebastián','Diego','Nicolás','Felipe','Ignacio','Lucas','Maximiliano','Gaspar',
                                    'Bastián','Fernando','Rodrigo','Claudio','Javier','Gonzalo','Andrés','Pablo'];
    v_apellidos     TEXT[] := ARRAY['González','Muñoz','Rojas','Díaz','Pérez','Soto','Contreras','Silva','Martínez',
                                    'Sepúlveda','Morales','Rodríguez','López','Fuentes','Hernández','Torres','Araya',
                                    'Flores','Espinoza','Valenzuela','Castillo','Tapia','Reyes','Gutiérrez'];
    v_entrenadores  TEXT[] := ARRAY['Luis Carrasco','Marcelo Vidal','Jorge Pizarro','Héctor Bravo','Raúl Navarro','Patricio Lagos'];
    -- Fixture a dos ruedas (índices 1..6 sobre v_equipos). La jornada 1 ya existe desde 04.
    v_fixture       INT[][] := ARRAY[
        [1,2],[3,4],[5,6],   [1,3],[2,5],[4,6],   [1,4],[2,6],[3,5],   [1,5],[2,4],[3,6],   [1,6],[2,3],[4,5]];
    v_horas         TIME[] := ARRAY['10:00','12:00','16:00'];
    v_canchas       TEXT[] := ARRAY['Estadio Municipal','Cancha 1','Cancha 2'];
    v_equipo        INT;
    v_jugador       INT;
    v_partido       INT;
    v_jornada       INT;
    v_slot          INT;
    v_local         INT;
    v_visita        INT;
    v_fecha         TIMESTAMP;
    v_estado        TEXT;
    v_gl            INT;
    v_gv            INT;
    v_i             INT;
    v_k             INT;
    v_seed          BIGINT;
    v_lado          TEXT;
    v_eq_gol        INT;
    v_goleador      INT;
    v_asistente     INT;
    v_rut_num       INT;
    v_suma          INT;
    v_mult          INT;
    v_dv            TEXT;
    v_pos           TEXT;
    v_liq           INT;
    v_cobro         INT;
    v_tarifa_arb    NUMERIC := 25000;
    v_tarifa_est    NUMERIC := 15000;
BEGIN
    SELECT id INTO v_torneo FROM deportivo.torneos WHERE nombre = 'Copa Apertura 2027';
    IF v_torneo IS NULL THEN
        RAISE NOTICE '05_demo_completo: falta la Copa Apertura de 04_datos_prueba.sql, no se hace nada';
        RETURN;
    END IF;
    IF EXISTS (SELECT 1 FROM deportivo.partidos WHERE torneo_id = v_torneo AND jornada >= 2) THEN
        RAISE NOTICE '05_demo_completo: los datos ya estaban cargados';
        RETURN;
    END IF;
    SELECT id INTO v_torneo2 FROM deportivo.torneos WHERE nombre = 'Liga Metropolitana 2027';

    SELECT id INTO v_arbitro     FROM seguridad.usuarios WHERE correo = 'arbitro@statshub.cl';
    SELECT id INTO v_estadigrafo FROM seguridad.usuarios WHERE correo = 'estadigrafo@statshub.cl';
    SELECT id INTO v_organizador FROM seguridad.usuarios WHERE correo = 'organizador@statshub.cl';

    SELECT array_agg(id ORDER BY id) INTO v_equipos
    FROM deportivo.equipos
    WHERE nombre IN ('Deportivo Puente Alto','Atlético Cordillera','Unión Sur','Real Maipo','Club Municipal','Estrella Roja');

    -- ---------- Torneos ----------
    UPDATE deportivo.torneos
       SET fecha_inicio = v_inicio, fecha_fin = v_inicio + 7 * 9 + 14, estado = 'ACTIVO',
           cupos = 8, formato = 'LIGA', costo_inscripcion = 50000
     WHERE id = v_torneo;
    UPDATE deportivo.torneo_equipos SET estado_inscripcion = 'INSCRITO' WHERE torneo_id = v_torneo;

    IF v_torneo2 IS NOT NULL THEN
        UPDATE deportivo.torneos
           SET fecha_inicio = CURRENT_DATE + 60, fecha_fin = CURRENT_DATE + 180, estado = 'INSCRIPCIONES',
               cupos = 8, formato = 'LIGA_Y_PLAYOFF', costo_inscripcion = 60000
         WHERE id = v_torneo2;
        INSERT INTO deportivo.torneo_equipos (torneo_id, equipo_id, estado_inscripcion)
        VALUES (v_torneo2, v_equipos[1], 'INSCRITO'), (v_torneo2, v_equipos[3], 'INSCRITO'),
               (v_torneo2, v_equipos[4], 'PENDIENTE'), (v_torneo2, v_equipos[6], 'PENDIENTE')
        ON CONFLICT (torneo_id, equipo_id) DO NOTHING;
    END IF;

    -- Oficiales del torneo con su tarifa por partido.
    INSERT INTO deportivo.torneo_oficiales (torneo_id, usuario_id, tarifa)
    VALUES (v_torneo, v_arbitro, v_tarifa_arb), (v_torneo, v_estadigrafo, v_tarifa_est)
    ON CONFLICT DO NOTHING;
    UPDATE seguridad.usuarios SET tarifa_partido = v_tarifa_arb WHERE id = v_arbitro;
    UPDATE seguridad.usuarios SET tarifa_partido = v_tarifa_est WHERE id = v_estadigrafo;

    -- ---------- Equipos y planteles ----------
    FOR v_i IN 1..6 LOOP
        UPDATE deportivo.equipos SET entrenador = v_entrenadores[v_i] WHERE id = v_equipos[v_i];
    END LOOP;

    -- Jugadores de 04 (vinculados a cuentas): número y posición con el formato de la app.
    UPDATE deportivo.jugadores SET numero = 9,  posicion = 'Delantero'     WHERE rut = '11111111-1';
    UPDATE deportivo.jugadores SET numero = 10, posicion = 'Mediocampista' WHERE rut = '22222222-2';
    UPDATE deportivo.jugadores SET numero = 4,  posicion = 'Defensa'       WHERE rut = '33333333-3';

    FOR v_i IN 1..6 LOOP
        FOR v_k IN 1..10 LOOP
            -- Se saltan los números que ya usan los jugadores de 04.
            CONTINUE WHEN (v_i = 1 AND v_k IN (9, 10)) OR (v_i = 2 AND v_k = 4);
            v_pos := CASE WHEN v_k = 1 THEN 'Portero' WHEN v_k <= 4 THEN 'Defensa'
                          WHEN v_k <= 7 THEN 'Mediocampista' ELSE 'Delantero' END;
            -- RUT con dígito verificador válido (módulo 11).
            v_rut_num := 15000000 + v_i * 100000 + v_k * 137;
            v_suma := 0; v_mult := 2;
            FOR v_seed IN REVERSE length(v_rut_num::text)..1 LOOP
                v_suma := v_suma + substr(v_rut_num::text, v_seed, 1)::int * v_mult;
                v_mult := CASE WHEN v_mult = 7 THEN 2 ELSE v_mult + 1 END;
            END LOOP;
            v_dv := CASE 11 - (v_suma % 11) WHEN 11 THEN '0' WHEN 10 THEN 'K' ELSE (11 - (v_suma % 11))::text END;

            INSERT INTO deportivo.jugadores (nombre, rut, fecha_nacimiento, posicion, numero)
            VALUES (v_nombres[1 + ((v_i * 7 + v_k * 3) % 24)] || ' ' || v_apellidos[1 + ((v_i * 5 + v_k * 11) % 24)],
                    v_rut_num || '-' || v_dv,
                    DATE '1990-01-01' + ((v_i * 977 + v_k * 431) % 4800),
                    v_pos, v_k)
            RETURNING id INTO v_jugador;

            INSERT INTO deportivo.equipo_jugador (equipo_id, jugador_id, fecha_desde)
            VALUES (v_equipos[v_i], v_jugador, v_inicio - 30);
            INSERT INTO deportivo.estadisticas_jugador (jugador_id) VALUES (v_jugador);
        END LOOP;
    END LOOP;
    UPDATE deportivo.equipo_jugador SET fecha_desde = v_inicio - 30
     WHERE jugador_id IN (SELECT id FROM deportivo.jugadores WHERE rut IN ('11111111-1','22222222-2','33333333-3'));

    -- Una transferencia: el 8 de Unión Sur pasa a Real Maipo hace tres semanas.
    SELECT ej.jugador_id INTO v_jugador
    FROM deportivo.equipo_jugador ej JOIN deportivo.jugadores j ON j.id = ej.jugador_id
    WHERE ej.equipo_id = v_equipos[3] AND j.numero = 8 AND ej.activo;
    UPDATE deportivo.equipo_jugador SET activo = false, fecha_hasta = CURRENT_DATE - 21
     WHERE jugador_id = v_jugador AND activo;
    UPDATE deportivo.jugadores SET numero = 11 WHERE id = v_jugador;
    INSERT INTO deportivo.equipo_jugador (equipo_id, jugador_id, fecha_desde)
    VALUES (v_equipos[4], v_jugador, CURRENT_DATE - 21);
    INSERT INTO deportivo.transferencias (jugador_id, desde_equipo_id, hacia_equipo_id, fecha, registrado_por)
    VALUES (v_jugador, v_equipos[3], v_equipos[4], now() - INTERVAL '21 days', v_organizador);

    -- ---------- Partidos ----------
    -- Los eventos de 04 se reemplazan por eventos coherentes con los resultados.
    DELETE FROM deportivo.eventos_partido WHERE partido_id IN (SELECT id FROM deportivo.partidos WHERE torneo_id = v_torneo);

    FOR v_jornada IN 1..10 LOOP
        FOR v_slot IN 1..3 LOOP
            v_k := ((v_jornada - 1) % 5) * 3 + v_slot;           -- par del fixture
            IF v_jornada <= 5 THEN
                v_local := v_equipos[v_fixture[v_k][1]]; v_visita := v_equipos[v_fixture[v_k][2]];
            ELSE                                              -- segunda rueda: localías invertidas
                v_local := v_equipos[v_fixture[v_k][2]]; v_visita := v_equipos[v_fixture[v_k][1]];
            END IF;
            v_fecha := (v_inicio + 7 * (v_jornada - 1)) + v_horas[v_slot];
            v_estado := CASE WHEN v_jornada <= 6 THEN 'FINALIZADO'
                             WHEN v_jornada = 8 AND v_slot = 3 THEN 'SUSPENDIDO'
                             ELSE 'PROGRAMADO' END;

            IF v_jornada = 1 THEN
                SELECT id INTO v_partido FROM deportivo.partidos
                WHERE torneo_id = v_torneo AND equipo_local = v_local AND equipo_visita = v_visita;
                UPDATE deportivo.partidos
                   SET fecha_partido = v_fecha, cancha = v_canchas[v_slot], jornada = 1, estado = v_estado
                 WHERE id = v_partido;
            ELSE
                INSERT INTO deportivo.partidos (torneo_id, equipo_local, equipo_visita, fecha_partido, cancha, estado, jornada)
                VALUES (v_torneo, v_local, v_visita, v_fecha, v_canchas[v_slot], v_estado, v_jornada)
                RETURNING id INTO v_partido;
            END IF;

            UPDATE deportivo.partidos SET arbitro_id = v_arbitro, estadigrafo_id = v_estadigrafo WHERE id = v_partido;
            CONTINUE WHEN v_estado <> 'FINALIZADO';

            -- Resultado: la jornada 1 conserva los marcadores de 04; el resto es pseudoaleatorio y reproducible.
            IF v_jornada = 1 THEN
                SELECT goles_local, goles_visita INTO v_gl, v_gv FROM deportivo.resultados WHERE partido_id = v_partido;
            ELSE
                v_gl := (abs(0::bigint + hashtext('L' || v_partido)) % 5 + abs(0::bigint + hashtext('l' || v_partido)) % 2) / 2;
                v_gv := (abs(0::bigint + hashtext('V' || v_partido)) % 4 + abs(0::bigint + hashtext('v' || v_partido)) % 2) / 2;
                INSERT INTO deportivo.resultados (partido_id, goles_local, goles_visita, registrado_por, fecha_registro)
                VALUES (v_partido, v_gl, v_gv, v_estadigrafo, v_fecha + INTERVAL '2 hours');
            END IF;

            UPDATE deportivo.partidos
               SET minuto = 90, iniciado_en = v_fecha, acta_cerrada_en = v_fecha + INTERVAL '2 hours',
                   acta_cerrada_por = v_estadigrafo,
                   acta_validada_en = CASE WHEN v_jornada <= 5 THEN v_fecha + INTERVAL '1 day' END,
                   acta_validada_por = CASE WHEN v_jornada <= 5 THEN v_arbitro END,
                   informe_arbitral = CASE WHEN v_jornada <= 5 THEN 'Partido disputado con normalidad. Sin incidentes que informar.' END
             WHERE id = v_partido;

            -- Goles (con asistencia el 60 % de las veces), repartidos en el tiempo y favoreciendo a los delanteros.
            FOR v_i IN 1..(v_gl + v_gv) LOOP
                v_lado := CASE WHEN v_i <= v_gl THEN 'LOCAL' ELSE 'VISITA' END;
                v_eq_gol := CASE WHEN v_lado = 'LOCAL' THEN v_local ELSE v_visita END;
                v_seed := abs(0::bigint + hashtext('g' || v_partido || '-' || v_i));

                SELECT j.id INTO v_goleador
                FROM deportivo.equipo_jugador ej JOIN deportivo.jugadores j ON j.id = ej.jugador_id
                WHERE ej.equipo_id = v_eq_gol AND ej.fecha_desde <= v_fecha::date
                  AND (ej.fecha_hasta IS NULL OR ej.fecha_hasta > v_fecha::date) AND j.posicion <> 'Portero'
                ORDER BY (CASE j.posicion WHEN 'Delantero' THEN 0 WHEN 'Mediocampista' THEN 1 ELSE 2 END) * 1000
                         + abs(0::bigint + hashtext(j.id || '-' || v_seed)) % 1700
                LIMIT 1;

                v_asistente := NULL;
                IF v_seed % 10 < 6 THEN
                    SELECT j.id INTO v_asistente
                    FROM deportivo.equipo_jugador ej JOIN deportivo.jugadores j ON j.id = ej.jugador_id
                    WHERE ej.equipo_id = v_eq_gol AND ej.fecha_desde <= v_fecha::date
                      AND (ej.fecha_hasta IS NULL OR ej.fecha_hasta > v_fecha::date) AND j.id <> v_goleador
                    ORDER BY (CASE j.posicion WHEN 'Mediocampista' THEN 0 WHEN 'Delantero' THEN 1 ELSE 2 END) * 1000
                             + abs(0::bigint + hashtext(j.id || 'a' || v_seed)) % 1500
                    LIMIT 1;
                END IF;

                INSERT INTO deportivo.eventos_partido
                    (partido_id, jugador_id, asistencia_jugador_id, tipo_evento, lado, minuto, descripcion, registrado_por, creado_en)
                VALUES (v_partido, v_goleador, v_asistente, 'GOL', v_lado, 3 + (v_seed % 87), NULL, v_estadigrafo, v_fecha + INTERVAL '1 hour');
            END LOOP;

            -- Tarjetas: 0-3 amarillas por partido y una roja ocasional.
            FOR v_i IN 1..(abs(0::bigint + hashtext('t' || v_partido)) % 4 + CASE WHEN v_partido % 7 = 0 THEN 1 ELSE 0 END) LOOP
                v_seed := abs(0::bigint + hashtext('c' || v_partido || '-' || v_i));
                v_lado := CASE WHEN v_seed % 2 = 0 THEN 'LOCAL' ELSE 'VISITA' END;
                SELECT j.id INTO v_jugador
                FROM deportivo.equipo_jugador ej JOIN deportivo.jugadores j ON j.id = ej.jugador_id
                WHERE ej.equipo_id = CASE WHEN v_lado = 'LOCAL' THEN v_local ELSE v_visita END
                  AND ej.fecha_desde <= v_fecha::date AND (ej.fecha_hasta IS NULL OR ej.fecha_hasta > v_fecha::date)
                ORDER BY abs(0::bigint + hashtext(j.id || 'c' || v_seed))
                LIMIT 1;
                INSERT INTO deportivo.eventos_partido (partido_id, jugador_id, tipo_evento, lado, minuto, registrado_por, creado_en)
                VALUES (v_partido, v_jugador,
                        CASE WHEN v_partido % 7 = 0 AND v_i = 1 THEN 'ROJA' ELSE 'AMARILLA' END,
                        v_lado, 10 + (v_seed % 80), v_estadigrafo, v_fecha + INTERVAL '1 hour');
            END LOOP;
        END LOOP;
    END LOOP;

    -- Alineaciones de los partidos jugados (el frontend cuenta los partidos jugados desde aquí):
    -- el plantel de cada equipo a la fecha del partido.
    UPDATE deportivo.partidos p
       SET alineacion = jsonb_build_object(
           'home', (SELECT jsonb_agg(ej.jugador_id ORDER BY ej.jugador_id) FROM deportivo.equipo_jugador ej
                    WHERE ej.equipo_id = p.equipo_local AND ej.fecha_desde <= p.fecha_partido::date
                      AND (ej.fecha_hasta IS NULL OR ej.fecha_hasta > p.fecha_partido::date)),
           'away', (SELECT jsonb_agg(ej.jugador_id ORDER BY ej.jugador_id) FROM deportivo.equipo_jugador ej
                    WHERE ej.equipo_id = p.equipo_visita AND ej.fecha_desde <= p.fecha_partido::date
                      AND (ej.fecha_hasta IS NULL OR ej.fecha_hasta > p.fecha_partido::date)))
     WHERE p.torneo_id = v_torneo AND p.estado = 'FINALIZADO';

    -- Estadísticas acumuladas por jugador, calculadas desde los eventos.
    INSERT INTO deportivo.estadisticas_jugador (jugador_id)
    SELECT j.id FROM deportivo.jugadores j
    WHERE NOT EXISTS (SELECT 1 FROM deportivo.estadisticas_jugador s WHERE s.jugador_id = j.id);
    UPDATE deportivo.estadisticas_jugador s
       SET goles       = (SELECT count(*) FROM deportivo.eventos_partido e WHERE e.jugador_id = s.jugador_id AND e.tipo_evento = 'GOL'),
           asistencias = (SELECT count(*) FROM deportivo.eventos_partido e WHERE e.asistencia_jugador_id = s.jugador_id AND e.tipo_evento = 'GOL'),
           amarillas   = (SELECT count(*) FROM deportivo.eventos_partido e WHERE e.jugador_id = s.jugador_id AND e.tipo_evento = 'AMARILLA'),
           rojas       = (SELECT count(*) FROM deportivo.eventos_partido e WHERE e.jugador_id = s.jugador_id AND e.tipo_evento = 'ROJA'),
           partidos    = (SELECT count(*) FROM deportivo.partidos p
                          JOIN deportivo.equipo_jugador ej ON ej.jugador_id = s.jugador_id
                           AND ej.equipo_id IN (p.equipo_local, p.equipo_visita)
                           AND ej.fecha_desde <= p.fecha_partido::date
                           AND (ej.fecha_hasta IS NULL OR ej.fecha_hasta > p.fecha_partido::date)
                          WHERE p.estado = 'FINALIZADO');

    -- ---------- Pagos ----------
    -- Inscripción a la Copa Apertura: cuatro equipos pagados, dos pendientes.
    FOR v_i IN 1..6 LOOP
        INSERT INTO pagos.cobros (torneo_id, equipo_id, tipo, concepto, monto, estado, creado_por, creado_en, pagado_en)
        VALUES (v_torneo, v_equipos[v_i], 'INSCRIPCION', 'Inscripción Copa Apertura', 50000,
                CASE WHEN v_i <= 4 THEN 'PAGADO' ELSE 'PENDIENTE' END, v_organizador,
                (v_inicio - 20)::timestamptz, CASE WHEN v_i <= 4 THEN (v_inicio - 15 + v_i)::timestamptz END)
        RETURNING id INTO v_cobro;
        IF v_i <= 4 THEN
            INSERT INTO pagos.transacciones
                (usuario_id, monto, estado, flow_id, fecha, equipo_id, torneo_id, orden_comercio, medio_pago,
                 fecha_pago, tipo, cobro_id, concepto)
            VALUES (v_organizador, 50000, 'PAGADO', 'DEMO-' || v_cobro, (v_inicio - 15 + v_i)::timestamp,
                    v_equipos[v_i], v_torneo, 'DEMO-INS-' || v_cobro, 'Webpay',
                    (v_inicio - 15 + v_i)::timestamptz, 'INSCRIPCION', v_cobro, 'Inscripción Copa Apertura');
        END IF;
    END LOOP;

    -- Planillas (arbitraje) de la última jornada jugada: pendientes de pago.
    INSERT INTO pagos.cobros (torneo_id, equipo_id, partido_id, tipo, concepto, monto, estado, creado_por, creado_en)
    SELECT v_torneo, e.equipo, p.id, 'PLANILLA', 'Planilla jornada ' || p.jornada, 20000, 'PENDIENTE', v_organizador,
           p.fecha_partido + INTERVAL '3 hours'
    FROM deportivo.partidos p
    CROSS JOIN LATERAL (VALUES (p.equipo_local), (p.equipo_visita)) AS e(equipo)
    WHERE p.torneo_id = v_torneo AND p.jornada = 6;

    -- Liquidación pagada al árbitro por las jornadas 1 y 2.
    INSERT INTO pagos.liquidaciones
        (oficial_id, creada_por, torneo_id, cantidad_partidos, monto_total, estado, medio_pago, referencia, pagada_en, creada_en)
    SELECT v_arbitro, v_organizador, v_torneo, count(*), count(*) * v_tarifa_arb, 'PAGADA', 'Transferencia', 'DEMO-LIQ-001',
           (v_inicio + 10)::timestamptz, (v_inicio + 9)::timestamptz
    FROM deportivo.partidos WHERE torneo_id = v_torneo AND jornada <= 2
    RETURNING id INTO v_liq;
    INSERT INTO pagos.liquidacion_partidos (liquidacion_id, partido_id, funcion, tarifa)
    SELECT v_liq, id, 'ARBITRO', v_tarifa_arb FROM deportivo.partidos WHERE torneo_id = v_torneo AND jornada <= 2;
    INSERT INTO pagos.partidos_liquidados (partido_id, funcion, liquidacion_id)
    SELECT id, 'ARBITRO', v_liq FROM deportivo.partidos WHERE torneo_id = v_torneo AND jornada <= 2;

    -- ---------- Notificaciones generales (para todos los usuarios) ----------
    INSERT INTO deportivo.notificaciones (usuario_id, titulo, mensaje, tipo, partido_id, fecha)
    SELECT NULL, 'Resultado final',
           el.nombre || ' ' || r.goles_local || ' - ' || r.goles_visita || ' ' || ev.nombre,
           'resultado', p.id, p.fecha_partido + INTERVAL '2 hours'
    FROM deportivo.partidos p
    JOIN deportivo.resultados r ON r.partido_id = p.id
    JOIN deportivo.equipos el ON el.id = p.equipo_local
    JOIN deportivo.equipos ev ON ev.id = p.equipo_visita
    WHERE p.torneo_id = v_torneo AND p.jornada = 6;

    INSERT INTO deportivo.notificaciones (usuario_id, titulo, mensaje, tipo, partido_id, fecha)
    SELECT NULL, 'Partido suspendido',
           el.nombre || ' vs ' || ev.nombre || ' (jornada 8) fue suspendido', 'cambio', p.id, now() - INTERVAL '1 day'
    FROM deportivo.partidos p
    JOIN deportivo.equipos el ON el.id = p.equipo_local
    JOIN deportivo.equipos ev ON ev.id = p.equipo_visita
    WHERE p.torneo_id = v_torneo AND p.estado = 'SUSPENDIDO';

    INSERT INTO deportivo.notificaciones (usuario_id, titulo, mensaje, tipo, fecha)
    VALUES (NULL, 'Jornada 7 hoy', 'Hoy se juega la jornada 7 de la Copa Apertura. ¡Revisa el calendario!',
            'recordatorio', now() - INTERVAL '2 hours');
END $$;
