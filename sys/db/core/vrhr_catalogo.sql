/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 10.1.21-MariaDB : Database - vrhr_catalogo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `agroecologica` */

DROP TABLE IF EXISTS `agroecologica`;

CREATE TABLE `agroecologica` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Codigo',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'nombre',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizado',
  PRIMARY KEY (`itemId`),
  UNIQUE KEY `itemId_UNIQUE` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Catalogo de zonas agroecologicas';

/*Data for the table `agroecologica` */

insert  into `agroecologica`(`itemId`,`code`,`nombre`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,'10','Altiplano norte','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(2,'20','Altiplano central','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(3,'30','Altiplano sud','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(4,'40','Valles cerrados','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(5,'50','Valles del norte','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(6,'60','Valles centrales','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(7,'70','Valles del sud','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(8,'80','Yungas del norte','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(9,'90','Yungas del sud (Chapare)','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(10,'100','Llanos de Santa Cruz','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(11,'110','Llanos del Chaco','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(12,'120','Escudo Chiquitano','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(13,'130','Amazonia','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(14,'140','Pampas de Moxos','2013-08-20 09:15:18','2013-08-20 09:15:18',1,1),
(15,'','Altiplano','2013-11-05 15:51:39','2013-11-05 15:51:39',1,1),
(16,'','Valles altos','2013-11-05 15:52:45','2013-11-05 15:52:45',1,1),
(17,'','Valles mesotérmicos','2013-11-05 15:53:09','2013-11-05 15:53:10',1,1),
(18,'','Chaco','2013-11-05 15:53:34','2013-11-05 15:53:35',1,1),
(19,'','Llanos','2013-11-05 15:53:48','2013-11-05 15:53:48',1,1);

/*Table structure for table `comercial` */

DROP TABLE IF EXISTS `comercial`;

CREATE TABLE `comercial` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre',
  `activo` tinyint(1) DEFAULT NULL COMMENT 'Activo',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Catalogo comercial';

/*Data for the table `comercial` */

insert  into `comercial`(`itemId`,`nombre`,`activo`,`dateCreate`,`dateUpdate`) values 
(1,'Parcela',1,'2014-07-10 07:35:07','2014-07-10 07:35:07'),
(2,'Feria local',1,'2014-07-10 07:36:44','2014-07-10 07:36:45'),
(3,'Mercado municipal',1,'2014-07-10 07:36:46','2014-07-10 07:36:46'),
(4,'Mercado urbano',1,'2014-07-10 07:36:47','2014-07-10 07:36:48'),
(5,'Exportación',1,'2014-07-10 07:36:48','2014-07-10 07:36:49'),
(6,'Otros',1,'2014-07-10 07:36:49','2014-07-10 07:36:50');

/*Table structure for table `cultivo` */

DROP TABLE IF EXISTS `cultivo`;

CREATE TABLE `cultivo` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `tipoId` int(11) DEFAULT NULL COMMENT 'tabla: cultivo_tipo',
  `codigo` varchar(5) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Codigo',
  `nombre` varchar(50) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre del cultivo',
  `activo` tinyint(1) DEFAULT '1' COMMENT 'Activo',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  PRIMARY KEY (`itemId`),
  KEY `fk_cultivo_cultivo_tipo_idx` (`tipoId`),
  CONSTRAINT `fk_cultivo_cultivo_tipo` FOREIGN KEY (`tipoId`) REFERENCES `cultivo_tipo` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Cultivos a detalle';

/*Data for the table `cultivo` */

insert  into `cultivo`(`itemId`,`tipoId`,`codigo`,`nombre`,`activo`,`dateCreate`,`dateUpdate`) values 
(1,9,'002','Papa',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(2,2,'003','Durazno',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(3,2,'004','Pera',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(4,2,'005','Manzana',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(5,1,'006','Trigo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(6,10,'007','Avena forrajera',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(7,1,'008','Quinua',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(8,11,'999','Otros',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(9,4,'010','Haba verde',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(10,10,'011','Cebada forrajera',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(11,3,'012','Tomate',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(12,11,'013','Lechuga',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(13,3,'014','Pimentón',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(14,3,'015','Repollo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(15,4,'016','Frejol',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(17,4,'018','Maní',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(18,3,'019','Coliflor',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(19,3,'020','Zanahoria',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(20,11,'021','Achojcha',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(21,3,'022','Cebolla verde',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(22,2,'023','Otros',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(23,2,'024','Vid',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(24,2,'025','Chirimoya',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(25,9,'026','Camote',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(26,13,'027','Caña',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(27,4,'028','Arveja verde',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(28,3,'029','Pepino',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(29,10,'030','Alfalfa',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(30,3,'031','Vainitas',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(31,2,'032','Limón',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(34,1,'035','Arroz',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(35,9,'036','Yuca',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(38,3,'039','Otros',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(40,9,'041','Oca',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(41,9,'042','Papaliza',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(43,2,'044','Naranja',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(44,2,'045','Palta',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(45,2,'046','Papaya',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(47,3,'048','Berenjena',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(48,3,'049','Maíz choclo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(49,3,'050','Zapallo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(50,3,'051','Ajo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(51,11,'052','Locoto',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(53,2,'054','Cirhuelo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(54,2,'055','Damasco',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(55,3,'056','Nabo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(56,11,'057','Acelga',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(57,12,'059','Otros',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(58,4,'060','Tarwi',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(59,13,'061','Soya',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(60,2,'062','Sandía',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(62,2,'064','Melón',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(64,3,'066','Betarraga',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(65,12,'067','Festuca',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(66,12,'068','Falaris',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(67,12,'069','Chilligua',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(68,2,'070','Nuez',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(72,1,'074','Cañahua',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(73,9,'075','Izaño',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(74,2,'076','Maracuyá',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(75,2,'077','Frutilla',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(76,2,'078','Membrillo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(77,11,'079','Linaza',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(78,2,'080','Guayaba',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(79,1,'081','Maíz grano',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(81,10,'083','Maíz forrajero',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(82,8,'084','Otros',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(83,11,'085','Quilquiña',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(85,8,'087','Claveles',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(86,8,'088','Gladiolos',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(87,10,'089','Otros',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(88,11,'090','Anís',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(89,11,'091','Comino',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(90,3,'092','Rabano',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(91,1,'093','Otros',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(92,2,'094','Lima',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(93,2,'095','Pacay',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(96,2,'098','Manga',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(97,10,'099','Sorgo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(98,13,'100','Algodón',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(100,4,'102','Arveja grano',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(101,1,'103','Avena grano',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(102,1,'104','Cebada grano',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(103,3,'105','Cebolla cabeza',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(104,4,'106','Haba grano',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(105,2,'107','Higo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(107,9,'109','Racacha',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(108,11,'110','Apio',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(109,11,'111','Perejil',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(113,11,'114','Manzanilla',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(115,2,'0242','Tumbo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(116,9,'9991','Maca',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(117,3,'250','Brócoli',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(120,2,'0245','Guinda',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(122,1,'0246','Amaranto',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(147,1,'0333','Centeno',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(148,8,'0334','Cartuchos',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(149,8,'0335','Crisantemos ',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(150,8,'0336','Ilusiones ',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(151,8,'0337','Liliums ',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(152,8,'0338','Margaritas ',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(153,8,'0339','Nardos',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(154,8,'0340','Rosas',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(155,10,'0341','Trébol ',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(156,10,'0342','Vicia ',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(157,4,'0343','Garbanzo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(158,13,'0344','Girasol',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(159,4,'0345','Otros',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(160,13,'0346','Otros',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(161,12,'0347','Bofedales',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(162,12,'0348','Pasto nativo ',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(163,9,'0349','Walusa',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(164,9,'0350','Otros',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(166,3,'0357','Ají',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(168,13,'0352','Sésamo',1,'2014-08-11 15:17:16','2014-08-11 15:17:16'),
(169,2,'0600','Plátano',1,'2014-08-11 15:17:16','2014-08-11 15:17:16');

/*Table structure for table `cultivo_tipo` */

DROP TABLE IF EXISTS `cultivo_tipo`;

CREATE TABLE `cultivo_tipo` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(100) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre del tipo de cultivo',
  `abreviatura` varchar(5) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Abreviatura',
  `activo` tinyint(1) DEFAULT '1' COMMENT 'Activo',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  PRIMARY KEY (`itemId`),
  UNIQUE KEY `itemId_UNIQUE` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Tipo de cultivo, agrupador general de cultivos';

/*Data for the table `cultivo_tipo` */

insert  into `cultivo_tipo`(`itemId`,`nombre`,`abreviatura`,`activo`,`dateCreate`,`dateUpdate`) values 
(1,'Cereales','C',1,'2014-08-11 15:11:17','2014-08-11 15:11:17'),
(2,'Frutales','FR',1,'2014-08-11 15:11:17','2014-08-11 15:11:17'),
(3,'Hortalizas','H',1,'2014-08-11 15:11:17','2014-08-11 15:11:17'),
(4,'Leguminosas','L',1,'2014-08-11 15:11:17','2014-08-11 15:11:17'),
(8,'Flores','FL',1,'2014-08-11 15:11:17','2014-08-11 15:11:17'),
(9,'Tubérculos','T',1,'2014-08-11 15:11:17','2014-08-11 15:11:17'),
(10,'Forrajes','FO',1,'2014-08-11 15:11:17','2014-08-11 15:11:17'),
(11,'Hortalizas Menores','HM',1,'2014-08-11 15:11:17','2014-08-11 15:11:17'),
(12,'Pastos','P',1,'2014-08-11 15:11:17','2014-08-11 15:11:17'),
(13,'Industriales','O',1,'2014-08-11 15:11:17','2014-08-11 15:11:17');

/*Table structure for table `pecuaria` */

DROP TABLE IF EXISTS `pecuaria`;

CREATE TABLE `pecuaria` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre',
  `activo` tinyint(1) DEFAULT NULL COMMENT 'Activo',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Catalogo pecuario';

/*Data for the table `pecuaria` */

insert  into `pecuaria`(`itemId`,`nombre`,`activo`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,'Vacuno',1,'2013-08-20 10:03:45','2013-08-20 10:03:46',1,1),
(2,'Ovino',1,'2013-08-20 10:03:59','2013-08-20 10:03:59',1,1),
(3,'Camelido',1,'2013-08-20 10:04:08','2013-08-20 10:04:11',1,1),
(4,'Porcino',1,'2013-08-20 10:04:25','2013-08-20 10:04:26',1,1),
(5,'Otros',1,'2013-08-20 10:04:34','2013-08-20 10:04:35',1,1),
(6,'Aves',1,'2013-08-20 10:04:42','2013-08-20 10:04:43',1,1),
(7,'Caprinos',1,'2014-08-11 16:04:50','2014-08-11 16:04:51',1,1),
(8,'Equinos',1,'2014-08-11 16:04:53','2014-08-11 16:04:52',1,1);

/*Table structure for table `situacion` */

DROP TABLE IF EXISTS `situacion`;

CREATE TABLE `situacion` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Situacion',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Catalogo de situacion de las fichas SNIR';

/*Data for the table `situacion` */

insert  into `situacion`(`itemId`,`nombre`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,'Nuevo','2014-08-01 10:01:51','2014-08-01 10:01:53',1,1),
(2,'Para Revisión','2014-08-01 10:01:54','2014-08-01 10:01:56',1,1),
(3,'Validado','2014-08-01 10:01:57','2014-08-01 10:01:58',1,1),
(4,'Observado','2014-08-01 10:02:00','2014-08-01 10:02:03',1,1),
(5,'Con Registro','2016-12-12 09:31:04','2016-12-12 09:31:11',1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
