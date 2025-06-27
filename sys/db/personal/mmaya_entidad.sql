/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 5.7.20-log : Database - mmaya_entidad
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `area` */

DROP TABLE IF EXISTS `area`;

CREATE TABLE `area` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `unidad_id` int(11) DEFAULT NULL COMMENT 'Tabla:unidad',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de Creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'Nombre de la área',
  `sigla` varchar(50) DEFAULT NULL COMMENT 'Sigla de la entidad',
  `activo` tinyint(4) DEFAULT '1' COMMENT 'Activo o no activo',
  PRIMARY KEY (`itemId`),
  KEY `fk_area_unidad1_idx` (`unidad_id`),
  CONSTRAINT `fk_area_unidad1` FOREIGN KEY (`unidad_id`) REFERENCES `unidad` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='áreas que tiene la unidad';

/*Data for the table `area` */

insert  into `area`(`itemId`,`unidad_id`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`nombre`,`sigla`,`activo`) values 
(1,18,'2018-03-02 11:17:47','2018-03-02 11:17:48',1,1,'Sistemas','SIS',1),
(2,19,'2018-03-02 12:43:42','2018-03-02 12:43:43',1,1,'SIG','SIG',1);

/*Table structure for table `direccion` */

DROP TABLE IF EXISTS `direccion`;

CREATE TABLE `direccion` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `entidad_id` int(11) DEFAULT NULL COMMENT 'tabla: entidad',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  `cod1` tinyint(4) DEFAULT NULL COMMENT 'Codigo segun norma',
  `cod2` tinyint(4) DEFAULT NULL COMMENT 'Codigo segun norma',
  `cod3` tinyint(4) DEFAULT NULL COMMENT 'Codigo segun norma',
  `cod4` tinyint(4) DEFAULT NULL COMMENT 'Codigo segun norma',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'nombre de la dirección',
  `sigla` varchar(50) DEFAULT NULL COMMENT 'Sigla',
  `activo` tinyint(4) DEFAULT '1' COMMENT 'activo o no activo',
  PRIMARY KEY (`itemId`),
  KEY `fk_direccion_entidad_idx` (`entidad_id`),
  CONSTRAINT `fk_direccion_entidad` FOREIGN KEY (`entidad_id`) REFERENCES `entidad` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Direcciones que tiene una entidad';

/*Data for the table `direccion` */

insert  into `direccion`(`itemId`,`entidad_id`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`cod1`,`cod2`,`cod3`,`cod4`,`nombre`,`sigla`,`activo`) values 
(1,1,'2018-03-02 08:54:25','2018-03-02 08:54:26',1,1,1,0,0,0,'Despacho Ministro MMAyA','DES',1),
(2,1,'2018-03-02 08:56:24','2018-03-02 08:56:24',1,1,1,0,1,0,'Dirección General de Asuntos Jurídicos','DGAJ',1),
(3,1,'2018-03-02 08:56:49','2018-03-02 08:56:50',1,1,1,0,2,0,'Dirección General de Asuntos Administrativos','DGAA',1),
(4,1,'2018-03-02 09:28:44','2018-03-02 09:28:44',1,1,1,0,3,0,'Dirección General de Planificación','DGP',1),
(5,2,'2018-03-02 09:58:39','2018-03-02 09:58:39',1,1,1,1,0,0,'Viceministerio de Agua Potable y Saneamiento Básico','VAPSB',1),
(6,2,'2018-03-02 09:59:34','2018-03-02 09:59:34',1,1,1,1,1,0,'Dirección General de Agua Potable y Alcantarillado Sanitario','DGAPAS',1),
(7,2,'2018-03-02 10:00:29','2018-03-02 10:00:30',1,1,1,1,2,0,'Dirección General de Gestión Integral de Residuos Sólidos','DGGIRS',1),
(8,3,'2018-03-02 10:03:06','2018-03-02 10:03:06',1,1,1,2,0,0,'Viceministerio de Recursos Hídricos y Riego','VRHR',1),
(9,3,'2018-03-02 10:03:35','2018-03-02 10:03:36',1,1,1,2,1,0,'Dirección General de Cuencas y Recursos Hídricos','DGCRH',1),
(10,3,'2018-03-02 10:04:07','2018-03-02 10:04:07',1,1,1,2,2,0,'Dirección General de Riego','DGR',1),
(11,4,'2018-03-02 10:04:33','2018-03-02 10:04:33',1,1,1,3,0,0,'Viceministerio de Medio Ambiente, Biodiversidad, Cambios Climáticos y de Gestión y Desarrollo Forestal','VMABCCGDF',1),
(12,4,'2018-03-02 10:12:20','2018-03-02 10:12:20',1,1,1,3,1,0,'Dirección General de Biodiversidad y Áreas Protegidas','DGBAP',1),
(13,4,'2018-03-02 10:13:04','2018-03-02 10:13:05',1,1,1,3,2,0,'Dirección Dirección General de Medio Ambiente y Cambios Climáticos','DGMACC',1),
(14,4,'2018-03-02 10:14:00','2018-03-02 10:14:00',1,1,1,3,3,0,'Dirección General de Gestión y Desarrollo Forestal','DGGDF',1),
(15,5,'2018-03-16 09:41:57','2018-03-16 09:41:58',1,1,NULL,NULL,NULL,NULL,'Dirección General','DG',1);

/*Table structure for table `entidad` */

DROP TABLE IF EXISTS `entidad`;

CREATE TABLE `entidad` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de Creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  `cod1` tinyint(4) DEFAULT NULL,
  `cod2` tinyint(4) DEFAULT NULL,
  `cod3` tinyint(4) DEFAULT NULL,
  `cod4` tinyint(4) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL COMMENT 'Nombre de la entidad',
  `sigla` varchar(50) DEFAULT NULL COMMENT 'Sigla de la entidad',
  `activo` tinyint(4) DEFAULT '1' COMMENT 'Activo o no activo',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `entidad` */

insert  into `entidad`(`itemId`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`cod1`,`cod2`,`cod3`,`cod4`,`nombre`,`sigla`,`activo`) values 
(1,'2018-03-01 18:34:55','2018-03-01 18:34:55',1,1,1,0,0,0,'Ministerio de Medio Ambiente y Agua','MMAyA',1),
(2,'2018-03-02 08:45:04','2018-03-02 08:45:05',1,1,1,1,0,0,'Viceministerio de Agua Potable y Aaneamiento Básico','VAPSB',1),
(3,'2018-03-01 18:35:25','2018-03-01 18:35:26',1,1,1,2,0,0,'Viceministerio de Recursos Hídricos y Riego','VRHR',1),
(4,'2018-03-02 08:45:28','2018-03-02 08:45:28',1,1,1,2,0,0,'Viceministerio de Medio Ambiente, Biodiversidad, Cambios Climáticos y de Gestión y Desarrollo Forestal','VMABCCGDF',1),
(5,'2018-03-16 09:38:57','2018-03-16 09:38:57',1,1,NULL,NULL,NULL,NULL,'Servicio Nacional para la Sostenibilidad de Servicios en Saneamiento Básico','SENASBA',1);

/*Table structure for table `lugar` */

DROP TABLE IF EXISTS `lugar`;

CREATE TABLE `lugar` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'LLave',
  `entidad_id` int(11) DEFAULT NULL COMMENT 'table:entidad',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de Creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'Nombre del lugar',
  `direccion` varchar(255) DEFAULT NULL COMMENT 'Dirección del lugar',
  `activo` tinyint(4) DEFAULT '1' COMMENT 'Activo o no activo',
  PRIMARY KEY (`itemId`),
  KEY `fk_lugar_entidad1_idx` (`entidad_id`),
  CONSTRAINT `fk_lugar_entidad1` FOREIGN KEY (`entidad_id`) REFERENCES `entidad` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='es el lugar donde se encuentran las oficinas físicas';

/*Data for the table `lugar` */

insert  into `lugar`(`itemId`,`entidad_id`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`nombre`,`direccion`,`activo`) values 
(1,1,'2018-03-02 11:06:54','2018-03-02 11:06:55',1,1,'Oficina Central','Calle Capitan Castrillo',1),
(2,1,'2018-03-02 11:09:45','2018-03-02 11:09:45',1,1,'Edificio Mollinedo','Av. 20 de Octubre',1),
(3,1,'2018-03-02 11:09:52','2018-03-02 11:09:53',1,1,'Edificio Sartawi','Av. Heroes del Acre',1),
(4,1,'2018-03-02 11:10:04','2018-03-02 11:10:04',1,1,'Casa Unicom','Calle Capitan Castrillo',1);

/*Table structure for table `unidad` */

DROP TABLE IF EXISTS `unidad`;

CREATE TABLE `unidad` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `direccion_id` int(11) DEFAULT NULL COMMENT 'Tabla:direccion',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de Creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  `cod1` tinyint(4) DEFAULT NULL COMMENT 'Codigo segun norma',
  `cod2` tinyint(4) DEFAULT NULL COMMENT 'Codigo segun norma',
  `cod3` tinyint(4) DEFAULT NULL COMMENT 'Codigo segun norma',
  `cod4` tinyint(4) DEFAULT NULL COMMENT 'Codigo segun norma',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'Nombre de la Unidad',
  `sigla` varchar(50) DEFAULT NULL COMMENT 'Sigla de la entidad',
  `activo` tinyint(4) DEFAULT '1' COMMENT 'Activo o no activo',
  PRIMARY KEY (`itemId`),
  KEY `fk_unidad_direccion1_idx` (`direccion_id`),
  CONSTRAINT `fk_unidad_direccion1` FOREIGN KEY (`direccion_id`) REFERENCES `direccion` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='Unidades que tiene la dirección';

/*Data for the table `unidad` */

insert  into `unidad`(`itemId`,`direccion_id`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`,`cod1`,`cod2`,`cod3`,`cod4`,`nombre`,`sigla`,`activo`) values 
(1,1,'2018-03-02 09:18:38','2018-03-02 09:18:38',1,1,1,0,0,0,'Despacho Ministro','DES',1),
(2,1,'2018-03-02 09:19:16','2018-03-02 09:19:16',1,1,1,0,0,1,'Gabinete de Despacho','GAB',1),
(3,1,'2018-03-02 09:19:48','2018-03-02 09:19:48',1,1,1,0,0,2,'Asesoría de Despacho','ASD',1),
(4,1,'2018-03-02 09:32:52','2018-03-02 09:32:52',1,1,1,0,0,3,'Asesoría legal de Despacho','ASLD',1),
(5,1,'2018-03-02 09:33:19','2018-03-02 09:33:20',1,1,1,0,0,4,'Unidad de Auditoría Interna','UAI',1),
(6,1,'2018-03-02 09:33:41','2018-03-02 09:33:41',1,1,1,0,0,5,'Unidad de Comunicación Social','UNICOM',1),
(7,1,'2018-03-02 09:33:58','2018-03-02 09:33:59',1,1,1,0,1,6,'Unidad de Transparencia','UTRA',1),
(8,2,'2018-03-02 09:34:52','2018-03-02 09:34:53',1,1,1,0,1,0,'Dirección General de Asuntos Jurídicos','DGAJ',1),
(9,2,'2018-03-02 09:35:22','2018-03-02 09:35:23',1,1,1,0,1,1,'Unidad de Análisis Jurídico','UAJ',1),
(10,2,'2018-03-02 09:36:08','2018-03-02 09:36:09',1,1,1,0,1,2,'Unidad de Gestión Jurídica','UGJ',1),
(11,2,'2018-03-02 09:37:44','2018-03-02 09:37:45',1,1,1,0,1,3,'Unidad de Recursos Jerárquicos','URJ',1),
(12,3,'2018-03-02 09:47:32','2018-03-02 09:47:33',1,1,1,0,2,0,'Dirección General de Asuntos Administrativos','DGAA',1),
(13,3,'2018-03-02 09:48:00','2018-03-02 09:48:01',1,1,1,0,2,1,'Unidad de Recursos Humanos','URRHH',1),
(14,3,'2018-03-02 09:48:33','2018-03-02 09:48:33',1,1,1,0,2,2,'Unidad Financiera','UF',1),
(15,3,'2018-03-02 09:48:49','2018-03-02 09:48:49',1,1,1,0,2,3,'Unidad Administrativa','UA',1),
(16,4,'2018-03-02 09:49:08','2018-03-02 09:49:09',1,1,1,0,3,0,'Dirección General de Planificación','DGP',1),
(17,4,'2018-03-02 09:49:35','2018-03-02 09:49:35',1,1,1,0,3,1,'Unidad de Gestión de Programas y Convenios','UGPC',1),
(18,4,'2018-03-02 09:50:06','2018-03-02 09:50:06',1,1,1,0,3,2,'Unidad de Gestión Institucional Integral','UGII',1),
(19,4,'2018-03-02 09:50:31','2018-03-02 09:50:31',1,1,1,0,3,3,'Unidad de Estudios Especiales','UEE',1),
(20,5,'2018-03-02 10:17:25','2018-03-02 10:17:25',1,1,1,1,0,0,'Viceministerio de Agua Potable y Saneamiento Básico','VAPSB',1),
(21,6,'2018-03-02 10:18:33','2018-03-02 10:18:34',1,1,1,1,1,0,'Dirección General de Agua Potable y Alcantarillado Sanitario','DGAPAS',1),
(22,6,'2018-03-02 10:21:29','2018-03-02 10:21:29',1,1,1,1,1,1,'Unidad de Preinversión y Gestión de Financiamiento','UPGF',1),
(23,6,'2018-03-02 10:22:21','2018-03-02 10:22:21',1,1,1,1,1,2,'Unidad de Desarrollo Sectorial y Gestión de la Información','USEGI',1),
(24,6,'2018-03-02 10:23:33','2018-03-02 10:23:33',1,1,1,1,1,3,'Unidad de Infraestructura Sanitaria e Inversión Pública','USIP',1),
(25,7,'2018-03-02 10:24:13','2018-03-02 10:24:14',1,1,1,1,2,0,'Dirección General de Gestión Integral de Residuos Sólidos','DGGIRS',1),
(26,8,'2018-03-02 10:24:51','2018-03-02 10:24:52',1,1,1,2,0,0,'Viceministerio de Recursos Hídricos y Riego','VRHR',1),
(27,9,'2018-03-02 10:25:42','2018-03-02 10:25:43',1,1,1,2,1,0,'Dirección General de Cuencas y Recursos Hídricos','DGCRH',1),
(28,9,'2018-03-02 10:26:14','2018-03-02 10:26:15',1,1,1,2,1,1,'Unidad de Gestión de Riegos Hidrológicos, Proyectos y Temas Estratégicos','UGRHPTE',1),
(29,9,'2018-03-02 10:27:20','2018-03-02 10:27:21',1,1,1,2,1,2,'Unidad de Planificación Hídrica y Calidad de Aguas','UPHCA',1),
(30,10,'2018-03-02 10:27:52','2018-03-02 10:27:52',1,1,1,2,2,0,'Dirección General de Riego','DGR',1),
(31,10,'2018-03-02 10:28:46','2018-03-02 10:28:46',1,1,1,2,2,1,'Unidad Gestión de Riego','UGR',1),
(32,10,'2018-03-02 10:29:17','2018-03-02 10:29:17',1,1,1,2,2,2,'Unidad de Programas y Proyectos','UPP',1),
(33,11,'2018-03-02 10:30:15','2018-03-02 10:30:15',1,1,1,3,0,0,'Viceministerio de Medio Ambiente, Biodiversidad, Cambios Climáticos y de Gestión y Desarrollo Forestal','VMABCCGDF',1),
(34,12,'2018-03-02 10:30:39','2018-03-02 10:30:41',1,1,1,3,1,0,'Dirección General de Biodiversidad y Áreas Protegidas','DGBAP',1),
(35,12,'2018-03-02 10:31:32','2018-03-02 10:31:32',1,1,1,3,1,1,'Unidad de Gestión y Conservación Ecoregional de la Amazonía, Yungas, Chiquitanía y Pantanal','UAYCyP',1),
(36,12,'2018-03-02 10:32:36','2018-03-02 10:32:36',1,1,1,3,1,2,'Unidad de Gestión y Conservación Ecoregional del Altiplano, Valles y Chaco','UAVyC',1),
(37,13,'2018-03-02 10:33:20','2018-03-02 10:33:20',1,1,1,3,2,0,'Dirección Dirección General de Medio Ambiente y Cambios Climáticos','DGMACC',1),
(38,13,'2018-03-02 10:33:40','2018-03-02 10:33:41',1,1,1,3,2,1,'Unidad Prevención y Control Ambiental Multisectorial','UPCAM',1),
(39,13,'2018-03-02 10:34:23','2018-03-02 10:34:23',1,1,1,3,2,2,'Unidad de Prevención y Control Ambiental de Miner{ia e Hidrocarburos','UPCAMH',1),
(40,13,'2018-03-02 10:35:05','2018-03-02 10:35:05',1,1,1,3,2,3,'Unidad Programas Medio Ambiente y Evaluación Plaguicidas Químicos de uso Agrícola (PQUA)','UMAPQUA',1),
(41,14,'2018-03-02 10:36:11','2018-03-02 10:36:12',1,1,1,3,3,0,'Dirección General de Gestión y Desarrollo Forestal','DGGDF',1),
(42,14,'2018-03-02 10:36:40','2018-03-02 10:36:40',1,1,1,3,3,1,'Unidad de Manejo y Conservación de Bosques','UMCB',1),
(43,14,'2018-03-02 10:37:24','2018-03-02 10:37:24',1,1,1,3,3,2,'Unidad de Gestión y Desarrollo Forestal','UGDF',1),
(44,15,'2018-03-16 09:43:11','2018-03-16 09:44:08',1,1,NULL,NULL,NULL,NULL,'Dirección General','DG',1),
(45,15,'2018-03-16 09:44:35','2018-03-16 09:44:37',1,1,NULL,NULL,NULL,NULL,'Gerencia de Operaciones','GO',1),
(46,15,'2018-03-16 10:00:12','2018-03-16 10:00:19',1,1,NULL,NULL,NULL,NULL,'Gerencia de Gestión de Conocimiento y Comunicación ','GGCC',1),
(47,15,'2018-03-16 10:02:43','2018-03-16 10:02:45',1,1,NULL,NULL,NULL,NULL,'Gerencia Administrativa Financiera','GAF',1),
(48,15,'2018-03-16 10:06:07','2018-03-16 10:06:10',1,1,NULL,NULL,NULL,NULL,'Gerencia de Asuntos Jurídicos','GAJ',1),
(49,15,'2018-03-16 10:08:27','2018-03-16 10:08:30',1,1,NULL,NULL,NULL,NULL,'Gerencia de Planificación y Desarrollo Organizacional','GPDO',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
