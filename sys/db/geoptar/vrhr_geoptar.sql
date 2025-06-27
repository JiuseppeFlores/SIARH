-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.28-0ubuntu0.18.04.4 - (Ubuntu)
-- Server OS:                    Linux
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for vrhr_geoptar
DROP DATABASE IF EXISTS `vrhr_geoptar`;
CREATE DATABASE IF NOT EXISTS `vrhr_geoptar` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `vrhr_geoptar`;

-- Dumping structure for table vrhr_geoptar.catalogo_parametro
DROP TABLE IF EXISTS `catalogo_parametro`;
CREATE TABLE IF NOT EXISTS `catalogo_parametro` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `eliminado` tinyint(1) DEFAULT '0' COMMENT 'Bandera para definir si el registro fue eliminado',
  `nombre` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `unidad` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `max_A` double DEFAULT NULL,
  `min_A` double DEFAULT NULL,
  `max_B` double DEFAULT NULL,
  `min_B` double DEFAULT NULL,
  `max_C` double DEFAULT NULL,
  `min_C` double DEFAULT NULL,
  `max_D` double DEFAULT NULL,
  `min_D` double DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.catalogo_parametro: ~2 rows (approximately)
/*!40000 ALTER TABLE `catalogo_parametro` DISABLE KEYS */;
INSERT INTO `catalogo_parametro` (`itemId`, `eliminado`, `nombre`, `unidad`, `max_A`, `min_A`, `max_B`, `min_B`, `max_C`, `min_C`, `max_D`, `min_D`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`, `activo`) VALUES
	(1, 0, 'Parametro 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
	(2, 0, 'Parametro 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
/*!40000 ALTER TABLE `catalogo_parametro` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.catalogo_tecnologia
DROP TABLE IF EXISTS `catalogo_tecnologia`;
CREATE TABLE IF NOT EXISTS `catalogo_tecnologia` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `eliminado` tinyint(1) DEFAULT '0' COMMENT 'Bandera para definir si el registro fue eliminado',
  `nombre` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `descripcion` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tipo` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.catalogo_tecnologia: ~60 rows (approximately)
/*!40000 ALTER TABLE `catalogo_tecnologia` DISABLE KEYS */;
INSERT INTO `catalogo_tecnologia` (`itemId`, `eliminado`, `nombre`, `descripcion`, `tipo`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`, `activo`) VALUES
	(55, 0, 'Sin obra de ingreso', NULL, 'obras', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(56, 0, 'Emisario', NULL, 'obras', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(57, 0, 'Pozo de gruesos', NULL, 'obras', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(58, 0, 'Carcamo de bombeo', NULL, 'obras', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(59, 0, 'BY PASS', NULL, 'obras', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(60, 0, 'Aliviadero', NULL, 'obras', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(61, 0, 'Medidor de flujo', NULL, 'obras', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(62, 0, 'Sensores de parámetros', NULL, 'obras', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(63, 0, 'Sin pretratamiento', NULL, 'pretratamiento', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(64, 0, 'Reja gruesa', NULL, 'pretratamiento', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(65, 0, 'Reja fina', NULL, 'pretratamiento', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(66, 0, 'Reja automatica', NULL, 'pretratamiento', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(67, 0, 'Tamiz', NULL, 'pretratamiento', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(68, 0, 'Desarenador', NULL, 'pretratamiento', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(69, 0, 'Canal parshal', NULL, 'pretratamiento', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(70, 0, 'Desengrasado', NULL, 'pretratamiento', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(71, 0, 'Sin tratamiento primario', NULL, 'primario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(72, 0, 'Tanque séptico', NULL, 'primario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(73, 0, 'Tanque Imho', NULL, 'primario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(74, 0, 'Sedimentador primario', NULL, 'primario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(75, 0, 'Filtro Anaerobio de Flujo Ascendente (FAFA)', NULL, 'primario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(76, 0, 'Reactor Anaerobio de Flujo Ascendente (RAFA / UASB)', NULL, 'primario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(77, 0, 'Reactor Anaeróbico con Deflectores', NULL, 'primario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(78, 0, 'Laguna anaeróbica convencional', NULL, 'primario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(79, 0, 'Laguna anaeróbica con absorción de lodos y gases', NULL, 'primario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(80, 0, 'Sin tratamiento secundario', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(81, 0, 'Laguna facultativa', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(82, 0, 'Laguna con aireación', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(83, 0, 'Filtro percolador', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(84, 0, 'Filtro aereado', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(85, 0, 'Humedad artificial vertical', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(86, 0, 'Humedad artificial horizontal', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(87, 0, 'Contactor biológico rotativo (Biodisco)', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(88, 0, 'Lombrifiltro', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(89, 0, 'Tratamiento de lodos activados convencional', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(90, 0, 'Tratamiento de lodos activados con aireación extendida', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(91, 0, 'Filtro Anaerobio de Flujo Ascendente (FAFA)', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(92, 0, 'Reactor Anaerobio de Flujo Ascendente (RAFA / UASB)', NULL, 'secundario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(93, 0, 'Sin tratamiento terciario', NULL, 'terciario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(94, 0, 'Tamizado', NULL, 'terciario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(95, 0, 'Cloración', NULL, 'terciario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(96, 0, 'Radiación ultravioleta', NULL, 'terciario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(97, 0, 'Laguna de maduración', NULL, 'terciario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(98, 0, 'Humedad artificial horizontal', NULL, 'terciario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(99, 0, 'Humedad artificial superficial', NULL, 'terciario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(100, 0, 'Remoción de nitrógeno', NULL, 'terciario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(101, 0, 'Remoción de fósforo', NULL, 'terciario', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(102, 0, 'Sin línea lodos', NULL, 'linealodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(103, 0, 'Espesamiento', NULL, 'linealodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(104, 0, 'Estabilización', NULL, 'linealodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(105, 0, 'Lechos de secado', NULL, 'linealodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(106, 0, 'Humedales artificiales', NULL, 'linealodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(107, 0, 'Sin disposición de lodos', NULL, 'disposicionlodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(108, 0, 'Reúso agricola informal', NULL, 'disposicionlodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(109, 0, 'Reúso agricola formal', NULL, 'disposicionlodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(110, 0, 'Compostaje', NULL, 'disposicionlodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(111, 0, 'Aprovechamiento biogas', NULL, 'disposicionlodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(112, 0, 'Incineración', NULL, 'disposicionlodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(113, 0, 'Relleno sanitario', NULL, 'disposicionlodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1),
	(114, 0, 'Vertedero', NULL, 'disposicionlodos', '2019-11-21 01:13:41', '2019-11-21 01:13:41', 1, 1, 1);
/*!40000 ALTER TABLE `catalogo_tecnologia` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item
DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(1) DEFAULT '0' COMMENT 'Bandera para definir si el registro fue eliminado',
  `ptar_anio_construccion` int(11) DEFAULT NULL,
  `ptar_anio_puesta_servicio` int(11) DEFAULT NULL,
  `ptar_anio_rehabilitacion` int(11) DEFAULT NULL,
  `ptar_capacidad_ls` double DEFAULT NULL,
  `ptar_costo_construccion` double DEFAULT NULL,
  `ptar_costo_anual_mantenimiento` double DEFAULT NULL,
  `ptar_existe_otro` tinyint(1) DEFAULT NULL,
  `ptar_cantidad_ptar` int(11) DEFAULT NULL,
  `ptar_descripcion` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ptar_funciona` int(11) DEFAULT NULL,
  `ptar_tarifa_saneamiento` tinyint(1) DEFAULT NULL,
  `ptar_descripcion_estado` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ptar_causa` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1=Sin OyM\\r\\n            2=Diseño de la PTAR\\r\\n            3=Vida Util\\r\\n            4=Tratamiento deficiente\\r\\n            5=Abandonada\\r\\n            6=En construcción\\r\\n            7=Otros',
  `ptar_reciben_capacitacion` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. SI\\r\\n            2. No',
  `ptar_percepcion_social` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ptar_observacion` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ptar_mantenimiento_preventivo` varchar(255) DEFAULT NULL,
  `ptar_mantenimiento_correctivo` varchar(255) DEFAULT NULL,
  `ptar_intervencion_requerida` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `caudal_minimo_ls` double DEFAULT NULL,
  `caudal_maximo_ls` double DEFAULT NULL,
  `caudal_medio_ls` double DEFAULT NULL,
  `caudal_afluente_ls` double DEFAULT NULL,
  `caudal_efluente_ls` double DEFAULT NULL,
  `caudal_afluente_fecha_hora` datetime DEFAULT NULL,
  `caudal_efluente_fecha_hora` datetime DEFAULT NULL,
  `caudal_forma_efluente_medicion` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. Medio\\\\r\\\\n            2. Estimado',
  `caudal_forma_afluente_medicion` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. Medio\\\\r\\\\n            2. Estimado',
  `caudal_comentarios` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `poblacion_servida` int(11) DEFAULT NULL,
  `porcentaje_cobertura` double DEFAULT NULL,
  `estado_general_funcionamiento` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `otra_ptar` tinyint(4) DEFAULT NULL,
  `tecnologia_principal` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1=Anaerobio\\r\\n            2=Intensivo\\r\\n            3=Extensivo\\r\\n            4=Decantación\\r\\n            5=No tiene PTAR',
  `tecnologia_descripcion` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tecnologia_estado_visual` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tecnologia_estado_visual2` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tecnologia_lodos_gestion` int(11) DEFAULT NULL COMMENT '1. si \\r\\n            2. no',
  `tecnologia_lodos_volumen` int(11) DEFAULT NULL,
  `tecnologia_descripcion_obras` varchar(250) DEFAULT NULL,
  `tecnologia_descripcion_pretratamiento` varchar(250) DEFAULT NULL,
  `tecnologia_descripcion_primario` varchar(250) DEFAULT NULL,
  `tecnologia_descripcion_secundario` varchar(250) DEFAULT NULL,
  `tecnologia_descripcion_terciario` varchar(250) DEFAULT NULL,
  `tecnologia_descripcion_linea` varchar(250) DEFAULT NULL,
  `tecnologia_descripcion_disposicion` varchar(250) DEFAULT NULL,
  `general_ptar` tinyint(4) DEFAULT NULL,
  `general_nombre` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Nombre del proyecto',
  `general_latitud` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Latitud en formato grados minutos segundos',
  `general_longitud` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Longitud en formato grados minutos segundos',
  `general_latitud_dec` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Latitud en formato decimales',
  `general_longitud_dec` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Longitud en formato decimales',
  `general_utm_este` int(11) DEFAULT NULL COMMENT 'UTM este',
  `general_utm_norte` int(11) DEFAULT NULL COMMENT 'UTM Norte',
  `general_utm_zona` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT 'UTM Zona',
  `general_altitud` int(11) DEFAULT NULL COMMENT 'Altitud metros sobre el nivel del mar',
  `general_departamento_id` int(11) DEFAULT NULL COMMENT 'tabla: vrhr_territorio.departamento',
  `general_provincia_id` int(11) DEFAULT NULL COMMENT 'tabla: vrhr_territorio.provincia',
  `general_municipio_id` int(11) DEFAULT NULL COMMENT 'tabla: vrhr_territorio.municipio',
  `general_comunidad_id` int(11) DEFAULT NULL,
  `general_localidad_id` int(11) DEFAULT NULL,
  `general_descripcion_lugar` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `general_zona_ecologica` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. Altiplano,2. Valle, 3. Llano',
  `general_segmento_esa` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. Rural, 2. 2000 a 10000, 3. mayores a 10000',
  `general_fecha_inspeccion` date DEFAULT NULL,
  `general_poblacion_2012` int(11) DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='1=Bueno\\r\\n2=Regular\\r\\n3=No funciona\\r\\n4=Construc';

-- Dumping data for table vrhr_geoptar.item: ~3 rows (approximately)
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` (`itemId`, `eliminado`, `ptar_anio_construccion`, `ptar_anio_puesta_servicio`, `ptar_anio_rehabilitacion`, `ptar_capacidad_ls`, `ptar_costo_construccion`, `ptar_costo_anual_mantenimiento`, `ptar_existe_otro`, `ptar_cantidad_ptar`, `ptar_descripcion`, `ptar_funciona`, `ptar_tarifa_saneamiento`, `ptar_descripcion_estado`, `ptar_causa`, `ptar_reciben_capacitacion`, `ptar_percepcion_social`, `ptar_observacion`, `ptar_mantenimiento_preventivo`, `ptar_mantenimiento_correctivo`, `ptar_intervencion_requerida`, `caudal_minimo_ls`, `caudal_maximo_ls`, `caudal_medio_ls`, `caudal_afluente_ls`, `caudal_efluente_ls`, `caudal_afluente_fecha_hora`, `caudal_efluente_fecha_hora`, `caudal_forma_efluente_medicion`, `caudal_forma_afluente_medicion`, `caudal_comentarios`, `poblacion_servida`, `porcentaje_cobertura`, `estado_general_funcionamiento`, `otra_ptar`, `tecnologia_principal`, `tecnologia_descripcion`, `tecnologia_estado_visual`, `tecnologia_estado_visual2`, `tecnologia_lodos_gestion`, `tecnologia_lodos_volumen`, `tecnologia_descripcion_obras`, `tecnologia_descripcion_pretratamiento`, `tecnologia_descripcion_primario`, `tecnologia_descripcion_secundario`, `tecnologia_descripcion_terciario`, `tecnologia_descripcion_linea`, `tecnologia_descripcion_disposicion`, `general_ptar`, `general_nombre`, `general_latitud`, `general_longitud`, `general_latitud_dec`, `general_longitud_dec`, `general_utm_este`, `general_utm_norte`, `general_utm_zona`, `general_altitud`, `general_departamento_id`, `general_provincia_id`, `general_municipio_id`, `general_comunidad_id`, `general_localidad_id`, `general_descripcion_lugar`, `general_zona_ecologica`, `general_segmento_esa`, `general_fecha_inspeccion`, `general_poblacion_2012`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`) VALUES
	(1, 0, 2020, 0, 0, 0, 0, 0, 1, 0, '', 1, 1, '', '1', '1', 'aaaa', '', '', '', NULL, 0, 0, 0, 0, 0, '2019-11-20 14:55:00', '2019-11-22 19:30:00', '1', '2', '', NULL, NULL, NULL, NULL, '1', '', '', '', NULL, NULL, 'aaa', 'nnnn', '', '', '', '', '', 1, 'NOMBRE PTAR', NULL, NULL, '', NULL, 0, 0, '', 0, 3, 32, 20101, 3108, 13696, '', 'Altiplano', '2', '2019-03-12', NULL, '2019-11-19 22:36:19', '2019-11-22 23:52:18', 1, 1),
	(2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', '', 0, 12, '', '', '', '', '', '', '', 1, 'PTAR LA PAZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-11-21 11:35:37', '2019-11-21 15:37:32', 1, 1),
	(3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Otro nombre', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-11-21 22:26:16', '2019-11-22 08:07:20', 1, 1);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item_agua_potable
DROP TABLE IF EXISTS `item_agua_potable`;
CREATE TABLE IF NOT EXISTS `item_agua_potable` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `item_id` int(11) DEFAULT NULL COMMENT 'Tabla:item',
  `eliminado` tinyint(1) DEFAULT '0' COMMENT 'Bandera para definir si el registro fue eliminado',
  `abastecimiento_agua` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1=superficial\\r\\n            2=subterráneo\\r\\n            3=superficial y subterráneo',
  `anio_construccion` int(11) DEFAULT NULL,
  `anio_puesta_servicio` int(11) DEFAULT NULL,
  `anio_puesta_rehabilitacion` int(11) DEFAULT NULL,
  `horas_servicio` int(11) DEFAULT NULL,
  `tratamiento_sistema` varchar(25) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistema_micromedicion` varchar(255) DEFAULT NULL,
  `descripcion_sistema` varchar(255) DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`),
  KEY `FK_Reference_9` (`item_id`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.item_agua_potable: ~3 rows (approximately)
/*!40000 ALTER TABLE `item_agua_potable` DISABLE KEYS */;
INSERT INTO `item_agua_potable` (`itemId`, `item_id`, `eliminado`, `abastecimiento_agua`, `anio_construccion`, `anio_puesta_servicio`, `anio_puesta_rehabilitacion`, `horas_servicio`, `tratamiento_sistema`, `sistema_micromedicion`, `descripcion_sistema`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`) VALUES
	(2, 3, 0, 'Superficial', 2019, 2019, 0, 0, '', '', '', '2019-11-22 14:00:03', '2019-11-22 14:00:03', 1, 1),
	(3, 1, 0, 'Superficial', 0, 0, 0, 0, '3', '', '', '2019-11-22 14:14:06', '2019-11-22 22:16:33', 1, 1),
	(4, 1, 0, 'Superficial', 0, 0, 0, 0, '6', '', '', '2019-11-22 22:14:43', '2019-11-22 22:15:41', 1, 1);
/*!40000 ALTER TABLE `item_agua_potable` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item_alcantarillado
DROP TABLE IF EXISTS `item_alcantarillado`;
CREATE TABLE IF NOT EXISTS `item_alcantarillado` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `item_id` int(11) DEFAULT NULL COMMENT 'Tabla:item',
  `eliminado` tinyint(1) DEFAULT '0' COMMENT 'Bandera para definir si el registro fue eliminado',
  `tiene_alcantarillado` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1.si\\r\\n            2.no\\r\\n            ',
  `numero_conexiones` int(11) DEFAULT NULL,
  `anio_construccion` int(11) DEFAULT NULL,
  `anio_rehabilitacion` int(11) DEFAULT NULL,
  `porcentaje_tuberia_convencional` double DEFAULT NULL,
  `porcentaje_tuberia_condominial` double DEFAULT NULL,
  `porcentaje_banios_secos` double DEFAULT NULL,
  `porcentaje_otros` double DEFAULT NULL,
  `estado_red` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1=bueno\\r\\n            2=regular\\r\\n            3=no funciona\\r\\n            4=construccion\\r\\n            5= sin dato',
  `descripcion_sistema_pluvial` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `descripcion_red_acantarillado` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`),
  KEY `FK_Reference_10` (`item_id`),
  CONSTRAINT `FK_Reference_10` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.item_alcantarillado: ~0 rows (approximately)
/*!40000 ALTER TABLE `item_alcantarillado` DISABLE KEYS */;
INSERT INTO `item_alcantarillado` (`itemId`, `item_id`, `eliminado`, `tiene_alcantarillado`, `numero_conexiones`, `anio_construccion`, `anio_rehabilitacion`, `porcentaje_tuberia_convencional`, `porcentaje_tuberia_condominial`, `porcentaje_banios_secos`, `porcentaje_otros`, `estado_red`, `descripcion_sistema_pluvial`, `descripcion_red_acantarillado`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`) VALUES
	(2, 1, 0, 'SI', 20, 2019, 0, 0, 0, 0, 0, 'Bueno', '', NULL, '2019-11-22 14:14:15', '2019-11-22 22:30:58', 1, 1);
/*!40000 ALTER TABLE `item_alcantarillado` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item_epsa
DROP TABLE IF EXISTS `item_epsa`;
CREATE TABLE IF NOT EXISTS `item_epsa` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `item_id` int(11) DEFAULT NULL COMMENT 'Tabla:item',
  `eliminado` tinyint(1) DEFAULT '0' COMMENT 'Bandera para definir si el registro fue eliminado',
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `regulado` varchar(5) DEFAULT NULL,
  `tipo_epsa` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1=EPSA municipal\\r\\n            2=CAPyS\\r\\n            3=Cooperativa\\r\\n            4=Asosiaciòn\\r\\n            5=otros',
  `total_personal_epsa` int(11) DEFAULT NULL,
  `numero_personal_ptar` int(11) DEFAULT NULL,
  `reciben_capacitacion` varchar(25) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. SI\\\\r\\\\n            2. NO',
  `nombre_responsable_ptar` varchar(200) DEFAULT NULL,
  `epsa_econom_sostenible` varchar(25) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. SI\\\\r\\\\n            2. NO',
  `ingreso_anual` double DEFAULT NULL,
  `egreso_anual` double DEFAULT NULL,
  `sistema_tarifario` varchar(25) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. SI\\\\r\\\\n            2. NO',
  `tarifa_media` double DEFAULT NULL,
  `descripcion_sist_tarifario` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`),
  KEY `FK_Reference_8` (`item_id`),
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.item_epsa: ~0 rows (approximately)
/*!40000 ALTER TABLE `item_epsa` DISABLE KEYS */;
INSERT INTO `item_epsa` (`itemId`, `item_id`, `eliminado`, `nombre`, `regulado`, `tipo_epsa`, `total_personal_epsa`, `numero_personal_ptar`, `reciben_capacitacion`, `nombre_responsable_ptar`, `epsa_econom_sostenible`, `ingreso_anual`, `egreso_anual`, `sistema_tarifario`, `tarifa_media`, `descripcion_sist_tarifario`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`) VALUES
	(2, 1, 0, '1231', 'SI', 'EPSA municipal', 20, 45, '', '', 'SI', 0, 0, 'SI', 0, '', '2019-11-22 14:13:24', '2019-11-22 21:27:30', 1, 1);
/*!40000 ALTER TABLE `item_epsa` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item_generales
DROP TABLE IF EXISTS `item_generales`;
CREATE TABLE IF NOT EXISTS `item_generales` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `poblacion_ine_2012` int(11) DEFAULT NULL,
  `poblacion_proyectado_2016` int(11) DEFAULT NULL,
  `fecha_inspeccion` date DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`),
  KEY `FK_Reference_27` (`item_id`),
  CONSTRAINT `FK_Reference_27` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.item_generales: ~0 rows (approximately)
/*!40000 ALTER TABLE `item_generales` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_generales` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item_ptar_archivo
DROP TABLE IF EXISTS `item_ptar_archivo`;
CREATE TABLE IF NOT EXISTS `item_ptar_archivo` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `item_id` int(11) DEFAULT NULL COMMENT 'Tabla:item',
  `nombre` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `tipo_id` int(11) DEFAULT NULL,
  `adjunto_nombre` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `adjunto_extension` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `adjunto_tamano` bigint(20) DEFAULT NULL,
  `adjunto_tipo` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL,
  `dateUpdate` datetime DEFAULT NULL,
  `userCreate` int(11) DEFAULT NULL,
  `userUpdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemId`),
  KEY `FK_Reference_7` (`item_id`),
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.item_ptar_archivo: ~0 rows (approximately)
/*!40000 ALTER TABLE `item_ptar_archivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_ptar_archivo` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item_ptar_calidad
DROP TABLE IF EXISTS `item_ptar_calidad`;
CREATE TABLE IF NOT EXISTS `item_ptar_calidad` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `item_id` int(11) DEFAULT NULL COMMENT 'Tabla:item',
  `eliminado` tinyint(1) DEFAULT '0' COMMENT 'Bandera para definir si el registro fue eliminado',
  `parametro_id` int(11) DEFAULT NULL,
  `laboratorio_propio` varchar(25) DEFAULT NULL COMMENT 'SI, NO',
  `efluente_valor` double DEFAULT NULL,
  `efluente_fecha` date DEFAULT NULL,
  `efluente_hora` time DEFAULT NULL,
  `afluente_valor` double DEFAULT NULL,
  `afluente_fecha` date DEFAULT NULL,
  `afluente_hora` time DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`),
  KEY `FK_Reference_6` (`item_id`),
  KEY `FK_Reference_11` (`parametro_id`),
  CONSTRAINT `FK_Reference_11` FOREIGN KEY (`parametro_id`) REFERENCES `catalogo_parametro` (`itemId`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='VALIDACIONES DE ACUERDO PARAMETRO';

-- Dumping data for table vrhr_geoptar.item_ptar_calidad: ~2 rows (approximately)
/*!40000 ALTER TABLE `item_ptar_calidad` DISABLE KEYS */;
INSERT INTO `item_ptar_calidad` (`itemId`, `item_id`, `eliminado`, `parametro_id`, `laboratorio_propio`, `efluente_valor`, `efluente_fecha`, `efluente_hora`, `afluente_valor`, `afluente_fecha`, `afluente_hora`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`) VALUES
	(2, 1, 0, 1, 'SI', 0, NULL, NULL, 0, NULL, NULL, '2019-11-22 16:13:55', '2019-11-22 16:13:55', 1, 1);
/*!40000 ALTER TABLE `item_ptar_calidad` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item_ptar_caudal
DROP TABLE IF EXISTS `item_ptar_caudal`;
CREATE TABLE IF NOT EXISTS `item_ptar_caudal` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(1) DEFAULT '0' COMMENT 'Bandera para definir si el registro fue eliminado',
  `item_id` int(11) DEFAULT NULL COMMENT 'Tabla:item',
  `caudal_minimo_ls` double DEFAULT NULL,
  `caudal_maximo_ls` double DEFAULT NULL,
  `caudal_medio_ls` double DEFAULT NULL,
  `caudal_afluente_ls` double DEFAULT NULL,
  `caudal_efluente_ls` double DEFAULT NULL,
  `caudal_afluente_fecha_hora` datetime DEFAULT NULL,
  `caudal_efluente_fecha_hora` datetime DEFAULT NULL,
  `caudal_forma_efluente_medicion` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. Medio\\\\\\\\r\\\\\\\\n            2. Estimado',
  `caudal_forma_afluente_medicion` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. Medio\\\\\\\\r\\\\\\\\n            2. Estimado',
  `caudal_comentarios` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.item_ptar_caudal: ~0 rows (approximately)
/*!40000 ALTER TABLE `item_ptar_caudal` DISABLE KEYS */;
INSERT INTO `item_ptar_caudal` (`itemId`, `eliminado`, `item_id`, `caudal_minimo_ls`, `caudal_maximo_ls`, `caudal_medio_ls`, `caudal_afluente_ls`, `caudal_efluente_ls`, `caudal_afluente_fecha_hora`, `caudal_efluente_fecha_hora`, `caudal_forma_efluente_medicion`, `caudal_forma_afluente_medicion`, `caudal_comentarios`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`) VALUES
	(1, 0, 1, 12, 123, 23, 0, 0, '2019-11-22 23:07:00', '2019-11-22 23:07:00', '', '', '', '2019-11-22 23:03:38', '2019-11-22 23:08:25', 1, 1),
	(2, 0, 2, 0, 213, 0, 0, 0, '2019-11-22 23:05:00', '2019-11-22 23:05:00', '', '', '', '2019-11-22 23:05:47', '2019-11-22 23:05:47', 1, 1),
	(3, 0, 3, 0, 345, 0, 0, 0, '2019-11-22 23:06:00', '2019-11-22 23:06:00', '', '', '', '2019-11-22 23:06:32', '2019-11-22 23:06:32', 1, 1),
	(4, 0, 1, 0, 12.32, 0, 0, 0, '2019-11-22 23:07:00', '2019-11-22 23:07:00', '', '', '', '2019-11-22 23:07:11', '2019-11-22 23:08:33', 1, 1);
/*!40000 ALTER TABLE `item_ptar_caudal` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item_ptar_efluente
DROP TABLE IF EXISTS `item_ptar_efluente`;
CREATE TABLE IF NOT EXISTS `item_ptar_efluente` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `item_id` int(11) DEFAULT NULL COMMENT 'Tabla:item',
  `eliminado` tinyint(1) DEFAULT '0' COMMENT 'Bandera para definir si el registro fue eliminado',
  `cuerpo_receptor` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1=Río\\r\\n            2=Lago\\r\\n            3=Suelo\\r\\n            4=Humedal\\r\\n            5=Sin dato ',
  `efluente_reutilizado_riego` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. si\\r\\n            2. no',
  `nombre_cuerpo_agua` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `cuerpo_agua` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1. A\\r\\n            2. B\\r\\n            3. C\\r\\n            4. D',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`),
  KEY `FK_Reference_5` (`item_id`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.item_ptar_efluente: ~4 rows (approximately)
/*!40000 ALTER TABLE `item_ptar_efluente` DISABLE KEYS */;
INSERT INTO `item_ptar_efluente` (`itemId`, `item_id`, `eliminado`, `cuerpo_receptor`, `efluente_reutilizado_riego`, `nombre_cuerpo_agua`, `cuerpo_agua`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`) VALUES
	(1, 3, 0, 'Río', 'SI', 'aaaaa', 'B', '2019-11-22 13:45:01', '2019-11-22 13:45:01', 1, 1),
	(2, 1, 0, 'Sin dato', 'No', 'EF1', 'D', '2019-11-22 14:09:12', '2019-11-22 14:15:32', 1, 1),
	(3, 1, 0, 'Lago', 'SI', 'aaaa', 'B', '2019-11-22 14:23:44', '2019-11-22 14:26:48', 1, 1);
/*!40000 ALTER TABLE `item_ptar_efluente` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item_ptar_poblacion
DROP TABLE IF EXISTS `item_ptar_poblacion`;
CREATE TABLE IF NOT EXISTS `item_ptar_poblacion` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `item_id` int(11) DEFAULT NULL COMMENT 'Tabla:item',
  `eliminado` tinyint(1) DEFAULT '0' COMMENT 'Bandera para definir si el registro fue eliminado',
  `gestion_id` int(11) DEFAULT NULL,
  `comunidad_id` int(11) DEFAULT NULL,
  `poblacion_proyectada` int(11) DEFAULT NULL COMMENT 'Vacia de una tabla prehecha',
  `poblacion_servida` int(11) DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`),
  KEY `FK_Reference_28` (`item_id`),
  CONSTRAINT `FK_Reference_28` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.item_ptar_poblacion: ~2 rows (approximately)
/*!40000 ALTER TABLE `item_ptar_poblacion` DISABLE KEYS */;
INSERT INTO `item_ptar_poblacion` (`itemId`, `item_id`, `eliminado`, `gestion_id`, `comunidad_id`, `poblacion_proyectada`, `poblacion_servida`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`) VALUES
	(1, 1, 0, 2018, 3766, 300, 150, '2019-11-22 18:38:19', '2019-11-22 18:40:54', 1, 1),
	(2, 1, 0, 2017, 3950, 300, 344, '2019-11-22 18:40:27', '2019-11-22 18:40:27', 1, 1);
/*!40000 ALTER TABLE `item_ptar_poblacion` ENABLE KEYS */;

-- Dumping structure for table vrhr_geoptar.item_ptar_tecnologia
DROP TABLE IF EXISTS `item_ptar_tecnologia`;
CREATE TABLE IF NOT EXISTS `item_ptar_tecnologia` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `item_id` int(11) DEFAULT NULL,
  `tecnologia_id` int(11) DEFAULT NULL,
  `indice` tinyint(4) DEFAULT NULL,
  `estado` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '1=Bueno\\r\\n            2=Regular\\r\\n            3=Malo\\r\\n            4=Sin dato',
  `cantidad` int(11) DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`),
  KEY `FK_Reference_25` (`tecnologia_id`),
  KEY `FK_Reference_29` (`item_id`),
  CONSTRAINT `FK_Reference_25` FOREIGN KEY (`tecnologia_id`) REFERENCES `catalogo_tecnologia` (`itemId`),
  CONSTRAINT `FK_Reference_29` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vrhr_geoptar.item_ptar_tecnologia: ~5 rows (approximately)
/*!40000 ALTER TABLE `item_ptar_tecnologia` DISABLE KEYS */;
INSERT INTO `item_ptar_tecnologia` (`itemId`, `item_id`, `tecnologia_id`, `indice`, `estado`, `cantidad`, `dateCreate`, `dateUpdate`, `userCreate`, `userUpdate`) VALUES
	(18, 1, 55, NULL, '2', 12, '2019-11-21 10:22:11', '2019-11-21 10:22:11', 1, 1),
	(19, 1, 57, NULL, '1', 20, '2019-11-21 10:22:11', '2019-11-21 10:22:11', 1, 1),
	(20, 1, 60, NULL, '2', 10, '2019-11-21 10:22:11', '2019-11-21 10:22:11', 1, 1),
	(21, 1, 63, NULL, '1', 0, '2019-11-21 10:22:11', '2019-11-21 10:22:11', 1, 1),
	(22, 1, 65, NULL, '1', 0, '2019-11-21 10:22:11', '2019-11-21 10:22:11', 1, 1);
/*!40000 ALTER TABLE `item_ptar_tecnologia` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
