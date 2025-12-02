CREATE INDEX idx_asistencias_id_estudiante_hash ON t_asistencias USING hash (id_estudiante);
--El índice hash es eficiente para búsquedas de igualdad, ideal para consultas que filtran por id_estudiante.

CREATE INDEX idx_asistencias_fecha_brin ON t_asistencias USING brin (fecha);
--El índice BRIN es adecuado para columnas con valores correlacionados, como fechas, optimizando consultas por rangos de fechas.

CREATE INDEX idx_horarios_grupo_materia_btree ON t_horarios USING btree (id_grupo, id_materia);
--El índice B-tree es versátil y eficiente para búsquedas, ordenamientos y rangos, ideal para consultas que involucran id_grupo e id_materia practiamente JOINS.