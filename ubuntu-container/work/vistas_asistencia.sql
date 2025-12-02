CREATE OR REPLACE VIEW vw_asistencia_estudiante_detalle AS
SELECT
e.id_estudiante,
e.primer_nombre,
e.segundo_nombre,
e.apellido_paterno,
e.apellido_materno,
g.id_grupo,
g.nombre_grupo,
m.id_materia,
m.nombre AS nombre_materia,
ma.id_maestro,
ma.primer_nombre AS maestro_nombre,
ma.apellido_paterno AS maestro_apellido,
p.id_periodo,
p.nombre_periodo,
h.id_horario,
h.hora_inicio,
h.hora_fin,
a.fecha,
ta.id_tipo_asistencia,
ta.nombre AS tipo_asistencia
FROM t_asistencias a
JOIN t_estudiantes e ON e.id_estudiante = a.id_estudiante
JOIN t_horarios h ON h.id_horario = a.id_horario
JOIN t_grupos g ON g.id_grupo = h.id_grupo
JOIN t_materias m ON m.id_materia = h.id_materia
JOIN t_maestros ma ON ma.id_maestro = h.id_maestro
JOIN t_periodos p ON p.id_periodo = h.id_periodo
JOIN cat_asistencias ta ON ta.id_tipo_asistencia = a.id_tipo_asistencia;


CREATE OR REPLACE VIEW vw_asistencia_maestro_grupo AS
SELECT
ma.id_maestro,
ma.primer_nombre AS maestro_nombre,
ma.segundo_nombre AS maestro_segundo,
ma.apellido_paterno AS maestro_apellido_paterno,
ma.apellido_materno AS maestro_apellido_materno,
g.id_grupo,
g.nombre_grupo,
m.id_materia,
m.nombre AS nombre_materia,
h.id_horario,
a.id_estudiante,
e.primer_nombre AS estudiante_nombre,
e.apellido_paterno AS estudiante_apellido_paterno,
a.fecha,
ta.nombre AS tipo_asistencia
FROM t_horarios h
JOIN t_maestros ma ON ma.id_maestro = h.id_maestro
JOIN t_grupos g ON g.id_grupo = h.id_grupo
JOIN t_materias m ON m.id_materia = h.id_materia
JOIN t_asistencias a ON a.id_horario = h.id_horario
JOIN t_estudiantes e ON e.id_estudiante = a.id_estudiante
JOIN cat_asistencias ta ON ta.id_tipo_asistencia = a.id_tipo_asistencia;


CREATE OR REPLACE VIEW vw_resumen_asistencia_grupo AS
SELECT
    g.id_grupo,
    g.nombre_grupo,
    COUNT(*)::int AS total_registros,
    SUM(CASE WHEN ta.nombre= 'ASISTENCIA' THEN 1 ELSE 0 END)::int AS total_asistencias,
    SUM(CASE WHEN ta.nombre ='RETARDO' THEN 1 ELSE 0 END)::int AS total_retardos,
    SUM(CASE WHEN ta.nombre = 'FALTA' THEN 1 ELSE 0 END)::int AS total_faltas,
    ROUND(100.0* SUM(CASE WHEN ta.nombre = 'ASISTENCIA' THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) AS pct_asistencias,
    ROUND(100.0 *SUM(CASE WHEN ta.nombre = 'RETARDO' THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) AS pct_retardos,
    ROUND(100.0 * SUM(CASE WHEN ta.nombre = 'FALTA' THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) AS pct_faltas
FROM t_asistencias a
JOIN t_horarios h ON h.id_horario = a.id_horario
JOIN t_grupos g ON g.id_grupo = h.id_grupo
JOIN cat_asistencias ta ON ta.id_tipo_asistencia = a.id_tipo_asistencia
GROUP BY g.id_grupo, g.nombre_grupo;




CREATE OR REPLACE VIEW vw_estudiantes_riesgo_inasistencia AS
SELECT
e.id_estudiante,
e.primer_nombre,
e.apellido_paterno,
COUNT(*)::int AS total_registros,
SUM(CASE WHEN ta.nombre = 'FALTA' THEN 1 ELSE 0 END)::int AS total_faltas,
(SUM(CASE WHEN ta.nombre = 'FALTA' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS pct_faltas
FROM t_asistencias a
JOIN t_estudiantes e ON e.id_estudiante = a.id_estudiante
JOIN cat_asistencias ta ON ta.id_tipo_asistencia = a.id_tipo_asistencia
GROUP BY e.id_estudiante, e.primer_nombre, e.apellido_paterno
HAVING COUNT(*) > 0
AND (SUM(CASE WHEN ta.nombre = 'FALTA' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) > 30.0
ORDER BY pct_faltas DESC;
