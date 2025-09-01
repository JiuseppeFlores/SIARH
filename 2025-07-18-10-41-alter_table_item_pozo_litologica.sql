-- ----------------------------
-- Alter table for item_pozo_litologica
-- ----------------------------
ALTER TABLE item_pozo_litologica ADD COLUMN litologiaId1 INT(3) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN redondezId1 INT(3) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN tamano1 VARCHAR(128) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN litologiaId2 INT(3) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN redondezId2 INT(3) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN tamano2 VARCHAR(128) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN litologiaId3 INT(3) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN redondezId3 INT(3) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN tamano3 VARCHAR(128) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN litologiaId4 INT(3) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN redondezId4 INT(3) NULL DEFAULT NULL;
ALTER TABLE item_pozo_litologica ADD COLUMN tamano4 VARCHAR(128) NULL DEFAULT NULL;

-- ----------------------------
-- Alter table for item_pozo_litologica [Rollback]
-- ----------------------------
ALTER TABLE item_pozo_litologica DROP COLUMN litologiaId1;
ALTER TABLE item_pozo_litologica DROP COLUMN redondezId1;
ALTER TABLE item_pozo_litologica DROP COLUMN tamano1;
ALTER TABLE item_pozo_litologica DROP COLUMN litologiaId2;
ALTER TABLE item_pozo_litologica DROP COLUMN redondezId2;
ALTER TABLE item_pozo_litologica DROP COLUMN tamano2;
ALTER TABLE item_pozo_litologica DROP COLUMN litologiaId3;
ALTER TABLE item_pozo_litologica DROP COLUMN redondezId3;
ALTER TABLE item_pozo_litologica DROP COLUMN tamano3;
ALTER TABLE item_pozo_litologica DROP COLUMN litologiaId4;
ALTER TABLE item_pozo_litologica DROP COLUMN redondezId4;
ALTER TABLE item_pozo_litologica DROP COLUMN tamano4;
