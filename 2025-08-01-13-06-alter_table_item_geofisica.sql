-- ----------------------------------------------------------
-- Author: José L. Flores
-- Function: Adición de campos para coordenadas en
--           los extremos de un punto de una tomografía en la
--           sección "Geofísica" en la subsección "Tomografía"
-- Request: Hidrogema-Siasbo Requerimiento 2.24
-- ----------------------------------------------------------

ALTER TABLE item_geofisica ADD COLUMN latitudUtm1 decimal(10, 3) NULL DEFAULT NULL;
ALTER TABLE item_geofisica ADD COLUMN longitudUtm1 decimal(10, 3) NULL DEFAULT NULL;
ALTER TABLE item_geofisica ADD COLUMN latitudUtm2 decimal(10, 3) NULL DEFAULT NULL;
ALTER TABLE item_geofisica ADD COLUMN longitudUtm2 decimal(10, 3) NULL DEFAULT NULL;
ALTER TABLE item_geofisica ADD COLUMN sev_distancia decimal(10, 2) NULL DEFAULT NULL;