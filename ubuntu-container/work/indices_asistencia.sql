CREATE INDEX idx_asistencias_id_estudiante_hash ON t_asistencias USING hash (id_estudiante);

CREATE INDEX idx_asistencias_fecha_brin ON t_asistencias USING brin (fecha);

CREATE INDEX idx_horarios_grupo_materia_btree ON t_horarios USING btree (id_grupo, id_materia);
