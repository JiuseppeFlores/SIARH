-- ----------------------------------------------------------
-- Author: José L. Flores
-- Function: Adición de campos para nivel estático, nivel 
--           dinámico y caudal en la tabla "item_pozo_hidra" 
--           para la sección "Pozos", sub-sección "Datos 
--           Hidráulicos" al crear una "Nueva Prueba Bombeo"
-- Request: Hidrogema-Siasbo Requerimiento 2.21.f
-- ----------------------------------------------------------

ALTER TABLE item_pozo_hidra ADD COLUMN nivel_estatico decimal(10, 2) NULL DEFAULT NULL COMMENT 'Nivel estatico (m)';
ALTER TABLE item_pozo_hidra ADD COLUMN nivel_dinamico decimal(10, 2) NULL DEFAULT NULL COMMENT 'Nivel dinamico final (m)';
ALTER TABLE item_pozo_hidra ADD COLUMN caudal decimal(10, 2) NULL DEFAULT NULL COMMENT 'Caudal (l/s)';