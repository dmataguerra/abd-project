CREATE OR REPLACE PROCEDURE sp_porcentaje_asistencia_estudiante_periodo(
    IN  p_id_estudiante INT,
    IN  p_id_periodo INT,
    OUT p_pct NUMERIC(5,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INT;
    v_asistencias INT;
BEGIN
 -- Total de registros del estudiante en el periodo
    SELECT COUNT(*)
    INTO v_total
    FROM t_asistencias a
    JOIN t_horarios h ON h.id_horario = a.id_horario
    WHERE a.id_estudiante = p_id_estudiante
      AND h.id_periodo = p_id_periodo;

    -- Total deasistencias
    SELECT COUNT(*)
    INTO v_asistencias
    FROM t_asistencias a
    JOIN t_horarios h ON h.id_horario = a.id_horario
    JOIN cat_asistencias ta ON ta.id_tipo_asistencia = a.id_tipo_asistencia
    WHERE a.id_estudiante = p_id_estudiante
      AND h.id_periodo = p_id_periodo
      AND ta.nombre = 'ASISTENCIA';

  -- Si no hay registros,el porcentaje es 0
    IF v_total = 0 THEN
        p_pct := 0.00;
    ELSE
        p_pct := ROUND((v_asistencias * 100.0) / v_total, 2);
    END IF;
END;
$$;

--Ejemplo de llamada
--CALL sp_porcentaje_asistencia_estudiante_periodo(10, 1, NULL);
