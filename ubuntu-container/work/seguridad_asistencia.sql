CREATE ROLE rol_profesor;
CREATE ROLE rol_control_escolar;
CREATE ROLE rol_consulta;

CREATE ROLE u_profesor_demo LOGIN PASSWORD 'password';
GRANT rol_profesor TO u_profesor_demo;

CREATE ROLE u_control_escolar_demo LOGIN PASSWORD 'password';
GRANT rol_control_escolar TO u_control_escolar_demo;

CREATE ROLE u_consulta_demo LOGIN PASSWORD 'password';
GRANT rol_consulta TO u_consulta_demo;

GRANT USAGE ON SCHEMA public TO rol_profesor, rol_control_escolar, rol_consulta;

GRANT SELECT ON vw_asistencia_estudiante_detalle,
             vw_asistencia_maestro_grupo,
             vw_resumen_asistencia_grupo,
             vw_estudiantes_riesgo_inasistencia TO rol_profesor;
GRANT INSERT, UPDATE ON t_asistencias TO rol_profesor;


GRANT SELECT ON ALL TABLES IN SCHEMA public TO rol_control_escolar;
GRANT INSERT, UPDATE, DELETE ON t_estudiantes TO rol_control_escolar;
GRANT INSERT, UPDATE, DELETE ON t_grupos TO rol_control_escolar;
GRANT INSERT, UPDATE ON t_asistencias TO rol_control_escolar;


GRANT SELECT ON vw_asistencia_estudiante_detalle,
             vw_asistencia_maestro_grupo,
             vw_resumen_asistencia_grupo,
             vw_estudiantes_riesgo_inasistencia TO rol_consulta;

