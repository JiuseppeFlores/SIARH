/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 5.7.22 : Database - mmaya_rrhh_escala_salarial
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mmaya_rrhh_escala_salarial` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `mmaya_rrhh_escala_salarial`;

/*Table structure for table `catalogo_escala_maestra_area` */

DROP TABLE IF EXISTS `catalogo_escala_maestra_area`;

CREATE TABLE `catalogo_escala_maestra_area` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID area escala salarial',
  `dateCreate` datetime DEFAULT NULL,
  `dateUpdate` datetime DEFAULT NULL,
  `userCreate` int(11) DEFAULT NULL,
  `userUpdate` int(11) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `catalogo_escala_maestra_area` */

insert  into `catalogo_escala_maestra_area`(`itemId`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`nombre`) values (1,'2018-06-13 00:00:00','2018-06-13 00:00:00',1,1,'Sustantiva');
insert  into `catalogo_escala_maestra_area`(`itemId`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`nombre`) values (2,'2018-06-13 00:00:00','2018-06-13 00:00:00',1,1,'Administrativa');
insert  into `catalogo_escala_maestra_area`(`itemId`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`nombre`) values (3,'2018-06-13 00:00:00','2018-06-13 00:00:00',1,1,'Sustantiva/Administrativa');

/*Table structure for table `catalogo_escala_maestra_categoria` */

DROP TABLE IF EXISTS `catalogo_escala_maestra_categoria`;

CREATE TABLE `catalogo_escala_maestra_categoria` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID categoria del cargo en la escala salarial',
  `dateCreate` datetime DEFAULT NULL,
  `dateUpdate` datetime DEFAULT NULL,
  `userCreate` int(11) DEFAULT NULL,
  `userUpdate` int(11) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `catalogo_escala_maestra_categoria` */

insert  into `catalogo_escala_maestra_categoria`(`itemId`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`nombre`) values (1,'2018-06-13 00:00:00','2018-06-13 00:00:00',1,1,'SUPERIOR');
insert  into `catalogo_escala_maestra_categoria`(`itemId`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`nombre`) values (2,'2018-06-13 00:00:00','2018-06-13 00:00:00',1,1,'EJECUTIVO');
insert  into `catalogo_escala_maestra_categoria`(`itemId`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`nombre`) values (3,'2018-06-13 00:00:00','2018-06-13 00:00:00',1,1,'OPERATIVO');

/*Table structure for table `demanda` */

DROP TABLE IF EXISTS `demanda`;

CREATE TABLE `demanda` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `dateCreate` datetime DEFAULT NULL,
  `dateUpdate` datetime DEFAULT NULL,
  `userCreate` int(11) DEFAULT NULL,
  `userUpdate` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `gestion_id` int(11) DEFAULT NULL,
  `url` varchar(256) DEFAULT NULL,
  `detalle` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `demanda` */

/*Table structure for table `escala_maestra` */

DROP TABLE IF EXISTS `escala_maestra`;

CREATE TABLE `escala_maestra` (
  `itemId` int(11) NOT NULL COMMENT 'ItemId es el Nivel segun la escala maestra',
  `categoria_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `nivel_interno` int(11) DEFAULT NULL COMMENT 'Codigo del nivel segun MMAyA',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'Puesto o cargo según escala salarial',
  `clase` varchar(2) DEFAULT NULL COMMENT '1º, 2º, — 5º',
  `requisito_minimo` longtext,
  `experiencia_general` longtext,
  `experiencia_especifica` longtext,
  `dateCreate` datetime DEFAULT NULL,
  `dateUpdate` datetime DEFAULT NULL,
  `userCreate` int(11) DEFAULT NULL,
  `userUpdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemId`),
  KEY `fk_escala_maestra_catalogo_escala_maestra_categoria_idx` (`categoria_id`),
  KEY `fk_escala_maestra_catalogo_escala_maestra_area1_idx` (`area_id`),
  CONSTRAINT `fk_escala_maestra_catalogo_escala_maestra_area1` FOREIGN KEY (`area_id`) REFERENCES `catalogo_escala_maestra_area` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_escala_maestra_catalogo_escala_maestra_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `catalogo_escala_maestra_categoria` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='lista de escala maestra';

/*Data for the table `escala_maestra` */

insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (1,1,NULL,1,'MINISTRO','2º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (2,1,NULL,2,'VICEMINISTROS','2º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (3,2,NULL,3,'DIRECTOR GENERAL','3º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (4,2,1,4,'JEFE DE UNIDAD I - ASESOR DESPACHO','4º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (5,2,1,5,'JEFE DE UNIDAD II - JEFE DE GABINETE','4º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (6,2,1,6,'JEFE DE UNIDAD III - ESPECIALISTA I','4º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (7,2,1,7,'JEFE DE UNIDAD IV - ESPECIALISTA II','4º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (8,NULL,1,NULL,'Responsable I - Especialidad III',NULL,NULL,NULL,NULL,'2018-06-14 18:16:50','2018-06-14 18:16:50',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (9,NULL,1,NULL,'Responsable II - Profesional I',NULL,NULL,NULL,NULL,'2018-06-14 18:17:29','2018-06-14 18:17:30',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (10,3,1,8,'RESPONSABLE III - PROFESIONAL II','5º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (11,3,1,9,'RESPONSABLE IV - PROFESIONAL III','5º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (12,3,1,10,'PROFESIONAL IV','5º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (13,3,1,11,'PROFESIONAL V','5º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (14,3,1,12,'PROFESIONAL VI','5º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (15,3,3,13,'PROFESIONAL VII - TECNICO I','5º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (16,3,3,14,'PROFESIONAL VIII - TECNICO II','5º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (17,3,3,15,'PROFESIONAL IX- TECNICO III Sec. Ministro','5º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (18,3,3,16,'TECNICO IV','6º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (19,3,3,17,'TECNICO V - Secretaria Viceministro','6º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (20,3,3,18,'TECNICO VI-Sec.Dir.Gral.-Chofer Ministro-Ujier Min','6º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (21,3,2,19,'ADMINISTRATIVO I - Sec. U.-Chofer V.M.-Ujier V.M.','7º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (22,3,2,20,'ADMINISTRATIVO II - Ujier de Dirección General','7º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (23,NULL,2,NULL,'Administrativo III - Ujier Jefatura de Unidad',NULL,NULL,NULL,NULL,'2018-06-14 18:18:07','2018-06-14 18:18:08',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (24,3,2,21,'ADMINISTRATIVO IV','7º','','','','2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (25,3,2,22,'AUXILIAR I','8º','','',NULL,'2018-06-13 00:00:00','2018-06-13 00:00:00',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (26,NULL,2,NULL,'Auxiliar II',NULL,NULL,NULL,NULL,'2018-06-14 18:30:06','2018-06-14 18:30:06',1,1);
insert  into `escala_maestra`(`itemId`,`categoria_id`,`area_id`,`nivel_interno`,`nombre`,`clase`,`requisito_minimo`,`experiencia_general`,`experiencia_especifica`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (27,NULL,2,NULL,'Auxiliar III',NULL,NULL,NULL,NULL,'2018-06-14 18:30:40','2018-06-14 18:30:40',1,1);

/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `itemId` int(11) NOT NULL COMMENT 'ID escala salarial, este id sera el mismo de la gestion',
  `gestion_id` int(11) DEFAULT NULL COMMENT 'tabla:mmaya_catalogo.gestion',
  `vigencia_fecha_inicio` date DEFAULT NULL COMMENT 'Fecha de inicio de vigencia de la escala salarial',
  `vigencia_fecha_fin` date DEFAULT NULL COMMENT 'Fecha final de vigencia de la escala salarial',
  `decreto_supremo` varchar(45) DEFAULT NULL COMMENT 'Norma que respalda la escala salarial',
  `decreto_supremo_fecha` date DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL COMMENT 'si la escala se encuentra activa  valor: 1;0',
  `observaciones` text,
  `adjunto` tinyint(4) DEFAULT NULL,
  `adjunto_nombre` varchar(255) DEFAULT NULL COMMENT 'nombre del adjunto',
  `adjunto_extension` varchar(255) DEFAULT NULL COMMENT 'extensión del adjunto',
  `adjunto_tamano` bigint(20) DEFAULT NULL COMMENT 'Tamaño en bytes del adjunto',
  `adjunto_dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización del adjunto',
  `adjunto_tipo` varchar(255) DEFAULT NULL COMMENT 'tipo de archivo, MIME type, ejemplo: application/pdf',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación del registro',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item` */

insert  into `item`(`itemId`,`gestion_id`,`vigencia_fecha_inicio`,`vigencia_fecha_fin`,`decreto_supremo`,`decreto_supremo_fecha`,`activo`,`observaciones`,`adjunto`,`adjunto_nombre`,`adjunto_extension`,`adjunto_tamano`,`adjunto_dateUpdate`,`adjunto_tipo`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (2015,2015,'2018-06-14','2018-06-14','1111','2018-06-14',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-06-14 21:41:07','2018-06-14 21:41:07',1,1);
insert  into `item`(`itemId`,`gestion_id`,`vigencia_fecha_inicio`,`vigencia_fecha_fin`,`decreto_supremo`,`decreto_supremo_fecha`,`activo`,`observaciones`,`adjunto`,`adjunto_nombre`,`adjunto_extension`,`adjunto_tamano`,`adjunto_dateUpdate`,`adjunto_tipo`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (2016,2016,'2018-06-15','2018-06-15','2222','2018-06-15',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-06-15 08:55:55','2018-06-15 08:55:57',1,1);
insert  into `item`(`itemId`,`gestion_id`,`vigencia_fecha_inicio`,`vigencia_fecha_fin`,`decreto_supremo`,`decreto_supremo_fecha`,`activo`,`observaciones`,`adjunto`,`adjunto_nombre`,`adjunto_extension`,`adjunto_tamano`,`adjunto_dateUpdate`,`adjunto_tipo`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (2017,2017,'2018-06-15','2018-06-15','3333','2018-06-15',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-06-15 08:56:14','2018-06-15 08:56:16',1,1);

/*Table structure for table `item_escala_maestra_gestion` */

DROP TABLE IF EXISTS `item_escala_maestra_gestion`;

CREATE TABLE `item_escala_maestra_gestion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `escala_maestra_id` int(11) DEFAULT NULL,
  `haber_basico` int(11) DEFAULT '0',
  `cantidad_fuente10` int(11) DEFAULT NULL,
  `cantidad_fuente11` int(11) DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL,
  `dateUpdate` datetime DEFAULT NULL,
  `userCreate` int(11) DEFAULT NULL,
  `userUpdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_item_escala_maestra_gestion_item1_idx` (`item_id`),
  KEY `fk_item_escala_maestra_gestion_escala_maestra1_idx` (`escala_maestra_id`),
  CONSTRAINT `fk_item_escala_maestra_gestion_escala_maestra1` FOREIGN KEY (`escala_maestra_id`) REFERENCES `escala_maestra` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_escala_maestra_gestion_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `item_escala_maestra_gestion` */

insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (1,2017,1,20432,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (2,2017,2,19156,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (3,2017,3,18517,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (4,2017,4,17751,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (5,2017,5,16346,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (6,2017,6,16022,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (7,2017,7,15456,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (8,2017,10,12995,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (9,2017,11,12521,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (10,2017,12,11844,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (11,2017,13,11235,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (12,2017,14,10355,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (13,2017,15,9746,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (14,2017,16,9272,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (15,2017,17,8460,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (16,2017,18,7919,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (17,2017,19,7038,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (18,2017,20,6294,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (19,2017,21,5442,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (20,2017,22,5008,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (21,2017,24,4128,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);
insert  into `item_escala_maestra_gestion`(`id`,`item_id`,`escala_maestra_id`,`haber_basico`,`cantidad_fuente10`,`cantidad_fuente11`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (22,2017,25,3654,NULL,NULL,'2018-06-14 21:50:05','2018-06-14 21:50:05',1,1);

/*Table structure for table `puesto` */

DROP TABLE IF EXISTS `puesto`;

CREATE TABLE `puesto` (
  `itemId` int(11) NOT NULL COMMENT 'ItemId es el numero de ITEM',
  `escala_maestra_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `direccion_id` int(11) DEFAULT NULL,
  `unidad_id` int(11) DEFAULT NULL,
  `activo` tinyint(4) DEFAULT NULL COMMENT 'Activo: 1:Activo,0:No Activo',
  `programa_id` varchar(5) DEFAULT '00',
  `proyecto_id` varchar(5) DEFAULT '00',
  `actividad_id` varchar(5) DEFAULT '00',
  `fuente` varchar(5) DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL,
  `dateUpdate` datetime DEFAULT NULL,
  `userCreate` int(11) DEFAULT NULL,
  `userUpdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemId`),
  KEY `fk_puesto_escala_maestra1_idx` (`escala_maestra_id`),
  KEY `fk_puesto_entidad1_idx` (`entidad_id`),
  KEY `fk_puesto_direccion1_idx` (`direccion_id`),
  KEY `fk_puesto_unidad1_idx` (`unidad_id`),
  CONSTRAINT `fk_puesto_direccion1` FOREIGN KEY (`direccion_id`) REFERENCES `mmaya_entidad`.`direccion` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_puesto_entidad1` FOREIGN KEY (`entidad_id`) REFERENCES `mmaya_entidad`.`entidad` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_puesto_escala_maestra1` FOREIGN KEY (`escala_maestra_id`) REFERENCES `escala_maestra` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_puesto_unidad1` FOREIGN KEY (`unidad_id`) REFERENCES `mmaya_entidad`.`unidad` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='lista de escala maestra';

/*Data for the table `puesto` */

insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (1,1,'MINISTRO',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (2,4,'ASESOR DE DESPACHO',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (3,7,'Asesor Legal Despacho',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (4,17,'SECRETARIA MINISTRO',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (5,20,'CHOFER MINISTRO',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (6,20,'Ujier Ministro',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (7,5,'JEFE DE GABINETE',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (8,7,'Jefe Unidad de Transparencia',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (9,13,'Profesional en Transparencia y Lucha Contra la Corrupción',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (10,19,'Técnico Apoyo en Transparencia y Lucha Contra la Corrupción',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (11,7,'Jefe Unidad de Auditoria Interna',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (12,13,'Auditor Interno Senior',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (13,14,'Auditor Interno',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (14,24,'Secretaria',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (15,7,'Jefe Unidad de Comunicación Social',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (16,17,'Analista Comunicación 1',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (17,19,'Analista Comunicación 2',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (18,20,'Técnico Comunicación Forestal',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (19,21,'Secretaria Comunicación',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (20,24,'Asistente en Comunicación',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (21,3,'Director General de Planificación',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (22,15,'Profesional en Negociación y Articulación con Movimientos Sociales',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (23,7,'Jefe Unidad de Gestion de Programas y Convenios',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (24,13,'Profesional en Gestion de Convenios Programas y Proyectos en Medio Ambiente',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (25,7,'Jefe Unidad de Gestion Institucional Integral',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (26,13,'Profesional Responsable de Gestión de la Información y el Conocimiento',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (27,15,'Profesional Responsable de Programación y Gestión Integral',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (28,11,'Responsable de Sistemas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (29,19,'Técnico en Soporte Informático 1',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (30,21,'Técnico en Soporte Informático 2',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (31,7,'Jefe Unidad de Estudios Especiales',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (32,13,'Profesional Responsable Área SIG',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (33,13,'Profesional en Coordinación Temas Estratégicos SIG',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (34,15,'Profesional SIG Geomática',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (35,15,'Profesional en Sensores Remotos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (36,20,'Técnico de Datos SIG',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (37,3,'Director General de Asuntos Administrativos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (38,20,'Secretaria de la DGAA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (39,22,'Ujier DGAA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (40,7,'Jefe Unidad de Recursos Humanos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (41,14,'Encargado de Remuneraciones',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (42,19,'Técnico en Control de Personal',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (43,20,'Técnico en Planillas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (44,6,'Jefe Unidad Financiera',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (45,11,'Responsable Financiero',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (46,11,'Responsable Presupuesto',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (47,12,'Profesional en Presupuesto',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (48,12,'Contador General',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (49,15,'Contador TGN',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (50,15,'Contador Fuente Externa',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (51,15,'Profesional Apoyo Presupuestario',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (52,16,'Contador',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (53,17,'Tesorero',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (54,20,'Especialista Contable',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (55,21,'Secretaria',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (56,25,'Auxiliar Financiero',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (57,6,'Jefe Unidad Administrativa',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (58,11,'Responsable de Desarrollo Organizacional',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (59,11,'Responsable de Contrataciones',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (60,13,'Profesional en Contrataciones 1',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (61,15,'Profesional en Contrataciones 2',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (62,15,'Encargado de Activos Fijos',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (63,16,'Encargado de Pasajes y Viáticos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (64,16,'Encargado de Servicios Generales',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (65,18,'Técnico en Contrataciones',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (66,19,'Encargado de Almacenes',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (67,21,'Técnico en Almacenes',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (68,21,'Técnico de Pasajes y Viáticos VMA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (69,21,'Secretaria Unidad Administrativa',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (70,21,'Telefonista Central Ministerio',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (71,24,'Encargado ORDC',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (72,24,'Asistente Archivo Central',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (73,25,'Auxiliar en Servicios Generales',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (74,25,'Auxiliar ORDC',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (75,3,'Director General de Asuntos Jurídicos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (76,20,'Secretaria DGAJ',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (77,6,'Jefe Unidad de Análisis Jurídico',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (78,13,'Abogado Administrativo',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (79,13,'Abogado Análisis Convenios y Acuerdos Intergubernativos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (80,15,'Abogado en Desarrollo Normativo',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (81,15,'Abogado en Análisis Presupuestario Institucional',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (82,6,'Jefe Unidad de Gestión Jurídica',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (83,13,'Abogado en Asuntos Internos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (84,13,'Abogado en Procesos Judiciales',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (85,13,'Abogado en Asuntos Parlamentarios',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (86,15,'Abogado en Gestión Judicial',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (87,16,'Abogado Especialista en Procesos Administrativos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (88,16,'Abogado en Contrataciones',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (89,21,'Procurador',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (90,6,'Jefe Unidad de Recursos Jerárquicos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (91,11,'Responsable Recursos Jerárquicos en Agua Potable y Saneamiento Básico',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (92,11,'Responsable Recursos Jerárquicos en Medio Ambiente',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (93,13,'Abogado Especialista en Medio Ambiente',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (94,14,'Profesional Ingeniero Forestal',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (95,15,'Abogado Especialista en Agua Potable y Saneamiento Básico',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (96,17,'Abogado en Sistemas Regulatorios',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (97,20,'Abogado Junior',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (98,2,'Viceministro de Agua Potable y Saneamiento Basico',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (99,19,'Secretaria VAPSB',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (100,21,'Chofer VAPSB',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (101,3,'Director General de Agua Potable y Alcantarillado Sanitario',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (102,22,'Asistente Administrativo DGAPAS',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (103,7,'Jefe de Unidad de Preinversión y Gestión de Financiamiento',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (104,11,'Responsable de Preinversión',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (105,13,'Profesional en Gestión de Financiamiento de Programas y proyectos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (106,15,'Profesional en Gestión Sostenible de Programas y Proyectos',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (107,24,'Asistente Administrativo UPGF',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (108,7,'Jefe de Unidad de Desarrollo Sectorial y Gestión de la información',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (109,16,'Profesional en Gestión Sectorial de la Información',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (110,7,'Jefe de Unidad de Infraestructura Sanitaria e Inversión Pública',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (111,12,'Profesional de la Gestión Integral de Sistemas de Tratamiento de Aguas Residuales',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (112,12,'Profesional en Gestión de Fuentes de Abastecimiento, Redes y Calidad de Agua',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (113,13,'Prof. de Tecnlgias Altnat, Resilencia Climát y Gestión de Riesgos en Sistema de Agua y Saneamiento',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (114,13,'Prof. Segmnto y Monit de Progr y Proyts. de Sist. Agua Potbl, Sistema de Saneamto y Drenaje Pluvial',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (115,3,'Director General de Gestión Integral de Residuos Sólidos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (116,10,'Responsable de la Gestión Integral de Residuos Sólidos e Innovación Tecnológica',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (117,12,'Profesional de Programas y Proyectos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (118,15,'Profesional de Gestión Estratégica y Responsabilidad Extendida del Productor',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (119,17,'Profesional en Gestión de Servicios de Aseo',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (120,19,'Técnico en Planificación DGGIRS',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (121,19,'Técnico en Normativa DGGIRS',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (122,21,'Asistente Administrativo DGGIRS',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (123,2,'Viceministro de Recursos Hidricos y Riego',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (124,19,'Secretaria VRHR',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (125,21,'Chofer VRHR',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (126,21,'Ujier VRHyR',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (127,3,'Director General de Cuencas y Recursos Hídricos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (128,14,'Profesional Seguimiento y Evaluación Proyectos UD',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (129,7,'Jefe Unidad Gestión de Riesgos Hidrologicos, Proyectos y Temas Estratégicos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (130,11,'Responsable Seguimiento de Proyectos en Recursos Hídricos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (131,14,'Profesional Seguimiento de Proyectos MIC/GIRH',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (132,14,'Seguimiento y Evaluación Proyectos MIC',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (133,20,'Tecnico en Seguimiento y Proyectos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (134,13,'Profesional Responsable de Desarrollo Capacidades Gestión Local',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (135,13,'Profesional Responsable en Cuencas Pedagógicas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (136,14,'Profesional en Cuencas Pedagógicas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (137,11,'Responsable en Gestión de Riesgos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (138,13,'Profesional Responsable Forestación y Cambio Climático en Cuencas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (139,15,'Profesional Seguimiento y Evaluación Gestión de Riesgos PNC',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (140,7,'Jefe Unidad Planificación Hídrica y Calidad de Aguas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (141,11,'Responsable de Aguas Internacionales',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (142,13,'Profesional Responsable de Planes Directores y Estudios Hidrológicos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (143,14,'Profesional en Planes Directores de Cuencas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (144,13,'Profesional Responsable en Calidad de Aguas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (145,20,'Técnico en Calidad de Aguas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (146,17,'Técnico en Calidad de Aguas 1',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (147,3,'Director General de Riego',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (148,20,'Secretaria',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (149,22,'Ujier',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (150,7,'Jefe Unidad Gestión de Riego',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (151,13,'Profesional en Normas Técnicas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (152,13,'Profesional en Riego',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (153,13,'Profesional en Seguimiento y Monitoreo Riego',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (154,14,'Profesional Coordinacion a Seguimiento de Proyectos de Riego',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (155,7,'Jefe Unidad de Programas y Proyectos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (156,10,'Profesional en Riego de Programas y Proyectos de Infraestructura',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (157,13,'Profesional en Riego de Programas y Proyectos Gestión en Riego',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (158,14,'Profesional Seguimiento y Evaluación Proyectos Cuencas Riego 1',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (159,15,'Profesional Seguimiento y Evaluación Proyectos Cuencas Riego 2',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (160,15,'Profesional Seguimiento y Evaluación Proyectos Riego',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (161,15,'Ingeniero Agrónomo',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (162,2,'Viceministro de Medio Ambiente, Biodiversidad, Cambios Climaticos y de Gestion y Desarrollo Forestal',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (163,15,'Asesor Legal',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (164,17,'Enlace Administrativo Viceministerial',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (165,19,'Secretaria VMABCC',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (166,21,'Chofer VMABCC',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (167,21,'Ujier VMABCC',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (168,25,'Recepcionista',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (169,25,'Telefonista VMA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (170,3,'Director General Biodiversidad y Áreas Protegidas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (171,20,'Secretaria DGBAP',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (172,22,'Ujier DGBAP',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (173,7,'Jefe de Unidad de Gestión y Convervación Ecoregional de la Amazonía, Yungas, Chiquitanía y Pantanal',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (174,14,'Profesional en Recursos Genéticos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (175,14,'Profesional Ecosistemas y Áreas Protegidas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (176,15,'Profesional en Articulación y Coordinación para la Gestión Integral de las Ecoregiones',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (177,15,'Profesional en Gestión de la Biodiversidad y Flora Vida Silvestre',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (178,15,'Profesional en Fauna Silvestre',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (179,15,'Profesional en Recursos Hidrobiológicos y Zoocriaderos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (180,19,'Técnico en Control y Monitoreo',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (181,7,'Jefe de Unidad de Gestión y Conservación Ecoregional del Altiplano, Valles y Chaco',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (182,14,'Profesional en Fauna Vida Silvestre',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (183,14,'Profesional de Recursos Genéticos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (184,14,'Profesional Ecosistemas y Áreas Protegidas',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (185,15,'Profesional en articulación y coordinación para la Gestión Integral de las Ecoregiones',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (186,15,'Profesional en Gestión de la Biodiversidad y Flora Vida Silvestre',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (187,19,'Técnico en Control y Monitoreo ',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (188,13,'Coordinador de Monitoreo y Evaluación de Gestión Integral de Biodiversidad',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (189,14,'Profesional en Gestión de Normativas en Conflictos de la Biodiversidad',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (190,14,'Profesional en Gestión de la Información, Conocimiento e Investigación',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (191,14,'Profesional en Gestión de Normativas Estratégicas para la Biodiversidad',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (192,15,'Profesiomal en Seguimiento y Cumplimiento de Convenios interles de Biodivdad CDB, CMS, RAMSAR',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (193,15,'Profesional Responsable de la Gestión CITES',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (194,19,'Técnico Auxiliar de DGBAP',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (195,3,'Director General Medio Ambiente y Cambios Climáticos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (196,19,'Técnico de Enlace Social',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (197,20,'Secretaria DGMACC',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (198,22,'Ujier DGMACC',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (199,24,'Asistente Correspondencia',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (200,7,'Jefe Unidad Prevención y Control Ambiental Multisector',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (201,14,'Asesor Legal Multisector',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (202,17,'Técnico Ambiental Multisector 1',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (203,17,'Técnico Ambiental Multisector 2',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (204,17,'Técnico Ambiental Multisector 3',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (205,12,'Encargado de Área Multisector',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (206,15,'Profesional en Prevención y Control Multisector 1',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (207,15,'Profesional en Prevención y Control Multisector 2',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (208,15,'Profesional en Prevención y Control Multisector 3',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (209,15,'Profesional en Prevención y Control Multisector 4',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (210,15,'Profesional en Prevención y Control Multisector 5',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (211,15,'Profesional en Prevención y Control Multisector 6',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (212,15,'Profesional en Prevención y Control Multisector 7',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (213,15,'Profesional en Prevención y Control Multisector 8',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (214,7,'Jefe Unidad de Prevención y Control Ambiental de Minería e Hidrocarburos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (215,12,'Encargado Área de Hidrocarburos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (216,14,'Asesor Legal Hidrocarburos',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (217,14,'Asesor Legal Minería',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (218,14,'Encargado Área Minería',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (219,15,'Profesional en Prevención y Control Minería 1',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (220,15,'Profesional en Prevención y Control Minería 2',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (221,15,'Profesional en Prevención y Control Minería 3',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (222,15,'Profesional en Prevención y Control Minería 4',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (223,15,'Profesional en Prevención y Control Minería 5',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (224,15,'Profesional en Prevención y Control Hidrocarburos 1',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (225,15,'Profesional en Prevención y Control Hidrocarburos 2',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (226,15,'Profesional en Prevención y Control Hidrocarburos 3',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (227,15,'Profesional en Prevención y Control Hidrocarburos 4',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (228,15,'Profesional en Prevención y Control Hidrocarburos 5',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (229,17,'Técnico Ambiental Minería e Hidrocarburos 1',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (230,17,'Técnico Ambiental Minería e Hidrocarburos 2',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (231,7,'Jefe Unidad Programas Medio Ambiente y Evaluación Plaguicidas Químicos de Uso Agrícola PQUA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (232,14,'Prof Respble en Eval. Plaguicidas de Uso Agrícola PQUA y Eval. Ambiental Estratégica EAEs',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (233,14,'Profesional Responsable del Programa Nacional de Contaminantes Orgánicos Persistentes',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (234,15,'Profesional Analista del PRONACOPs',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (235,15,'Encargado del Sistema Nacional de Información Ambiental',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (236,15,'Profesional Analista SNIA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (237,17,'Técnico Administrativo Financiero',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (238,19,'Técnico en Educación Ambiental',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (239,19,'Técnico en Gestión Ambiental - CEDOCA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (240,19,'Técnico en Sistematización de Licencias Ambientales',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (241,19,'Técnico RENCA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (242,21,'Apoyo CEDOCA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (243,21,'Apoyo CEDOCA - RENCA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (244,22,'Apoyo RENCA',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (245,3,'Director General de Gestión y Desarrollo Forestal',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (246,15,'Asesor Legal Normativa Forestal',NULL,NULL,NULL,1,'00','00','00','11','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (247,16,'Profesional en Políticas y Planificación',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (248,21,'Asistente Administrativo DGGDF',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (249,7,'Jefe Unidad de Manejo y Conservación de Bosques',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (250,16,'Profesional en Manejo y Conservación de Bosques',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (251,16,'Profesional en Manejo Integral y Sustentable de Bosques',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (252,19,'Técnico en Manejo Comunitario de Bosques',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (253,19,'Técnico en Aprovechamiento Sustentable',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (254,7,'Jefe de Unidad de Gestión y Desarrollo Forestal',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (255,16,'Profesional en Desarrollo Social Forestal',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (256,16,'Profesional en Forestación y Reforestación',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);
insert  into `puesto`(`itemId`,`escala_maestra_id`,`nombre`,`entidad_id`,`direccion_id`,`unidad_id`,`activo`,`programa_id`,`proyecto_id`,`actividad_id`,`fuente`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values (257,19,'Técnico en Monitoreo de Proyectos de Plantaciones Forestales',NULL,NULL,NULL,1,'00','00','00','10','2018-06-14 21:33:52','2018-06-14 21:34:04',1,1);

/*Table structure for table `tramites_mefp` */

DROP TABLE IF EXISTS `tramites_mefp`;

CREATE TABLE `tramites_mefp` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `dateCreate` datetime DEFAULT NULL,
  `dateUpdate` datetime DEFAULT NULL,
  `userCreate` int(11) DEFAULT NULL,
  `userUpdate` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `gestion_id` int(11) DEFAULT NULL,
  `url` varchar(256) DEFAULT NULL,
  `detalle` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tramites_mefp` */

/* Procedure structure for procedure `item_escala_salarial` */

/*!50003 DROP PROCEDURE IF EXISTS  `item_escala_salarial` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `item_escala_salarial`(
	IN `gestion` INT

)
BEGIN



select 
c.nombre as categoria
,em.itemId as nivel_escala_salarial
,em.nivel_interno
, em.clase
, em.nombre as cargo
, img.haber_basico as sueldo_mensual
, 
(select 
count(*) as total
from puesto as p
where p.fuente = 10
and p.escala_maestra_id = em.itemId
group by p.escala_maestra_id) as f10_num_puesto

, 
(select 
count(*) as total
from puesto as p
where p.fuente = 10
and p.escala_maestra_id = em.itemId
group by p.escala_maestra_id)  * img.haber_basico as f10_total

, 
(select 
count(*) as total
from puesto as p
where p.fuente = 11
and p.escala_maestra_id = em.itemId
group by p.escala_maestra_id) as f11_num_puesto

, 
(select 
count(*) as total
from puesto as p
where p.fuente = 11
and p.escala_maestra_id = em.itemId
group by p.escala_maestra_id)  * img.haber_basico as f11_total

,i.gestion_id
, i.activo

from item_escala_maestra_gestion as img 
left join item as i on i.itemId = img.item_id
left join escala_maestra as em on em.itemId = img.escala_maestra_id
left join catalogo_escala_maestra_categoria as c on c.itemId = em.categoria_id

where i.itemId = gestion
;



END */$$
DELIMITER ;

/*Table structure for table `puesto_estructura_personal` */

DROP TABLE IF EXISTS `puesto_estructura_personal`;

/*!50001 DROP VIEW IF EXISTS `puesto_estructura_personal` */;
/*!50001 DROP TABLE IF EXISTS `puesto_estructura_personal` */;

/*!50001 CREATE TABLE  `puesto_estructura_personal`(
 `itemId` int(11) ,
 `categoria` varchar(50) ,
 `area` varchar(50) ,
 `nivel` int(11) ,
 `clase` varchar(2) ,
 `puesto` varchar(255) ,
 `cargo` varchar(255) ,
 `nivel_interno` int(11) ,
 `entidad` varchar(255) ,
 `direccion` varchar(255) ,
 `unidad` varchar(255) 
)*/;

/*View structure for view puesto_estructura_personal */

/*!50001 DROP TABLE IF EXISTS `puesto_estructura_personal` */;
/*!50001 DROP VIEW IF EXISTS `puesto_estructura_personal` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `puesto_estructura_personal` AS select `p`.`itemId` AS `itemId`,`c`.`nombre` AS `categoria`,`a`.`nombre` AS `area`,`p`.`itemId` AS `nivel`,`m`.`clase` AS `clase`,`p`.`nombre` AS `puesto`,`m`.`nombre` AS `cargo`,`m`.`nivel_interno` AS `nivel_interno`,`e`.`nombre` AS `entidad`,`d`.`nombre` AS `direccion`,`u`.`nombre` AS `unidad` from ((((((`mmaya_rrhh_escala_salarial`.`puesto` `p` left join `mmaya_rrhh_escala_salarial`.`escala_maestra` `m` on((`m`.`itemId` = `p`.`escala_maestra_id`))) left join `mmaya_rrhh_escala_salarial`.`catalogo_escala_maestra_area` `a` on((`a`.`itemId` = `m`.`area_id`))) left join `mmaya_rrhh_escala_salarial`.`catalogo_escala_maestra_categoria` `c` on((`c`.`itemId` = `m`.`categoria_id`))) left join `mmaya_entidad`.`entidad` `e` on((`e`.`itemId` = `p`.`entidad_id`))) left join `mmaya_entidad`.`direccion` `d` on((`d`.`itemId` = `p`.`direccion_id`))) left join `mmaya_entidad`.`unidad` `u` on((`u`.`itemId` = `p`.`unidad_id`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
