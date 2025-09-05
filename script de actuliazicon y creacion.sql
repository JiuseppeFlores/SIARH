-- script en mysql, cambios par el tipo de dato en la base de datos mmaya_siasbo 
ALTER TABLE item_pozo_hidra MODIFY porosidad DECIMAL(7,5);
ALTER TABLE item_pozo MODIFY constructivo_diametro VARCHAR(50);
INSERT INTO catalogo_manantial_usoagua (nombre,activo,dateCreate,dateUpdate,userCreate,userUpdate) VALUES ('Desconocido',1,NOW(),NOW(),1,1);
INSERT INTO catalogo_manantial_usoagua (nombre,activo,dateCreate,dateUpdate,userCreate,userUpdate) VALUES ('Otro',1,NOW(),NOW(),1,1);
INSERT INTO catalogo_captacion_usoagua (nombre,activo,dateCreate,dateUpdate,userCreate,userUpdate) VALUES ('Desconocido',1,NOW(),NOW(),1,1);
INSERT INTO catalogo_captacion_usoagua (nombre,activo,dateCreate,dateUpdate,userCreate,userUpdate) VALUES ('Otro',1,NOW(),NOW(),1,1);
ALTER TABLE item_pozo_monitor_calidad_dato MODIFY valor DECIMAL(12,8);
ALTER TABLE item ADD COLUMN tipoFuenteId INT;
ALTER TABLE item_pozo ADD COLUMN redMonitoreoId INT;
ALTER TABLE item ADD COLUMN codigoAnterior varchar (255);
UPDATE item SET codigoAnterior = codigo;
UPDATE item SET tipoFuenteId = 6 WHERE tipoFuenteId IS NULL and tipo = 4;

CREATE TABLE `item_fuente_superficial` (
`pozoId`  int(11),
`fecha`  date,
`hora`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci,
`tiempo`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
`flujo`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
`velocidad`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
`dateCreate`  datetime,
`dateUpdate`  datetime,
`userCreate`  int(11),
`userUpdate`  int(11),
`itemId`  int(11) NOT NULL AUTO_INCREMENT ,
`tipo`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
`conexionSubterranea`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
`alturaBorde`  decimal(10,2),
`alturaAgua`  decimal(10,2),
`altura`  decimal(10,2),
`tipoId`  int(11),
`tirante`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
`captaobservacion`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci,
`conexionesagua`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci,
`coberturaagua`  decimal(10,2),
`numero`  decimal(10,2),
`almacenamiento`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
`caudal`  decimal(10,2),
`capacidad`  decimal(10,2),
`aduccion`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
`red`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
`area`  decimal(10,2),
`fechaInstalacion`  date,
PRIMARY KEY (`itemId`),
INDEX `pozoId` (`pozoId`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='(Revisar si se usa)'
AUTO_INCREMENT=2
ROW_FORMAT=DYNAMIC
;

INSERT INTO item_fuente_superficial (
    caudal,
    almacenamiento,
    capacidad,
    aduccion,
    red,
    area,
    captaobservacion,
    conexionesagua,
    coberturaagua,
    numero,
    dateCreate,
    dateUpdate,
    userCreate,
    userUpdate,
		pozoId,
fecha
)
SELECT
    caudal,
    almacenamiento,
    capacidad,
    aduccion,
    red,
    area,
    captaobservacion,
    conexionesagua,
    coberturaagua,
    numero,
    dateCreate,
    dateUpdate,
    userCreate,
    userUpdate,
		itemId,
fechainicio
FROM item_captacion_superficial;

DROP TABLE IF EXISTS `copia_macrocuencas`;

CREATE TABLE `copia_macrocuencas` (
  `id` INT NOT NULL,
  `OBJECTID` BIGINT,
  `NOMBRE_N1` VARCHAR(40),
  `SUP_N1` DOUBLE,
  `TIPO_UH` VARCHAR(50),
  `CATEGORIA` VARCHAR(70),
  `COD_PFAFS` VARCHAR(10),
  `Shape_Length` DOUBLE,
  `Shape_Area` DOUBLE
);

INSERT INTO `copia_macrocuencas` 
(`id`, `OBJECTID`, `NOMBRE_N1`, `SUP_N1`, `TIPO_UH`, `CATEGORIA`, `COD_PFAFS`, `Shape_Length`, `Shape_Area`) VALUES
(1, 1, 'Región Hidrográfica Altiplano', 149749.246648, 'Endorreica', 'Macrocuenca', '0', 28.945718888061, 12.9300469723935),
(2, 2, 'Región Hidrográfica Amazonas', 707955.880432, 'Exorreica', 'Macrocuenca', '4', 54.8891698335737, 59.9268409414991),
(3, 3, 'Región Hidrográfica de la Plata', 221791.833808, 'Exorreica', 'Macrocuenca', '8', 45.4220120052591, 19.1812798761901);

-- script en mysql, ver menu principal desde la base de datos mmaya_siasbo observacion 11

SELECT *, CONCAT_WS('-', nv.COD_PFAFS, nv.codigo_ine, nv.tipo_letra, nv.itemId) AS nuevoCodigo FROM
(SELECT i.itemId, i.codigo, i.codigoAnterior, i.tipo,
    CASE i.tipo
        WHEN 1 THEN 'P'
        WHEN 2 THEN 'G'
        WHEN 3 THEN 'M'
        WHEN 4 THEN 'C'
        ELSE NULL
    END AS tipo_letra, i.cuencaId , cm.id, cm.COD_PFAFS, vd.nombre, vd.codigo_ine
FROM item i
JOIN catalogo_cuenca cc ON i.cuencaId = cc.itemId
JOIN copia_macrocuencas cm ON cc.itemId = cm.id
JOIN vrhr_territorio.departamento vd ON i.departamentoId = vd.itemId) AS nv;

-- Actualizar los códigos en la tabla item

UPDATE item i
JOIN catalogo_cuenca cc 
    ON i.cuencaId = cc.itemId
JOIN copia_macrocuencas cm 
    ON cc.itemId = cm.id
JOIN vrhr_territorio.departamento vd 
    ON i.departamentoId = vd.itemId
SET i.codigo = CONCAT_WS('-', 
    cm.COD_PFAFS, 
    vd.codigo_ine, 
    CASE i.tipo
        WHEN 1 THEN 'P'
        WHEN 2 THEN 'G'
        WHEN 3 THEN 'M'
        WHEN 4 THEN 'C'
        ELSE NULL
    END,
    i.itemId
);



-- script en mysql, ver menu principal desde la base de datos mmaya_siasbo
Select * from core_submodulo as sm where sm.moduloId = '17' and sm.parent=0 and sm.principal=0 and sm.activo=1 order by sm.orden;
-- string(10) "MENU 5::::" string(677) "
select m.carpeta as modulo_id_tipo_carpeta , sb.carpeta as submodulo_id_carpeta , m2.carpeta as submodulo_id_carpeta_padre ,sm.* from core_submodulo as sm left join core_modulo as m on m.itemId = sm.modulo_id_tipo left join core_submodulo as sb on sb.itemId = sm.submodulo_id left join core_modulo as m2 on m2.itemId = sb.moduloId where sm.moduloId = '17' and sm.parent='275' and sm.principal=0 and sm.activo=1 order by sm.orden
-- " string(10) "MENU 5::::" string(677) "
select m.carpeta as modulo_id_tipo_carpeta , sb.carpeta as submodulo_id_carpeta , m2.carpeta as submodulo_id_carpeta_padre ,sm.* from core_submodulo as sm left join core_modulo as m on m.itemId = sm.modulo_id_tipo left join core_submodulo as sb on sb.itemId = sm.submodulo_id left join core_modulo as m2 on m2.itemId = sb.moduloId where sm.moduloId = '17' and sm.parent='277' and sm.principal=0 and sm.activo=1 order by sm.orden
-- " string(10) "MENU 5::::" string(677) "
select m.carpeta as modulo_id_tipo_carpeta , sb.carpeta as submodulo_id_carpeta , m2.carpeta as submodulo_id_carpeta_padre ,sm.* from core_submodulo as sm left join core_modulo as m on m.itemId = sm.modulo_id_tipo left join core_submodulo as sb on sb.itemId = sm.submodulo_id left join core_modulo as m2 on m2.itemId = sb.moduloId where sm.moduloId = '17' and sm.parent='278' and sm.principal=0 and sm.activo=1 order by sm.orden
-- " string(10) "MENU 5::::" string(677) "
select m.carpeta as modulo_id_tipo_carpeta , sb.carpeta as submodulo_id_carpeta , m2.carpeta as submodulo_id_carpeta_padre ,sm.* from core_submodulo as sm left join core_modulo as m on m.itemId = sm.modulo_id_tipo left join core_submodulo as sb on sb.itemId = sm.submodulo_id left join core_modulo as m2 on m2.itemId = sb.moduloId where sm.moduloId = '17' and sm.parent='841' and sm.principal=0 and sm.activo=1 order by sm.orden

