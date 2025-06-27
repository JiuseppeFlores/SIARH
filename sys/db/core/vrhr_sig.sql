/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 10.1.21-MariaDB : Database - vrhr_sig
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `catalogo_formato` */

DROP TABLE IF EXISTS `catalogo_formato`;

CREATE TABLE `catalogo_formato` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'formato',
  `formato` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizado',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Data for the table `catalogo_formato` */

insert  into `catalogo_formato`(`itemId`,`nombre`,`formato`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,'JPG','image/jpeg','2014-08-13 13:54:55','2014-08-13 13:54:56',1,1),
(2,'PNG','image/png','2014-08-13 13:55:30','2014-08-13 13:55:30',1,1),
(3,'GIF','image/gif','2014-08-13 13:55:54','2014-08-13 13:55:55',1,1),
(4,'SVG','image/svg+xml','2014-08-13 13:56:52','2014-08-13 13:56:52',1,1);

/*Table structure for table `server` */

DROP TABLE IF EXISTS `server`;

CREATE TABLE `server` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre del Servidor',
  `descripcion` text COLLATE latin1_general_ci COMMENT 'Descripción del servidor',
  `url` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'URL del servicio de mapas',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de Creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Data for the table `server` */

insert  into `server`(`itemId`,`nombre`,`descripcion`,`url`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,'Riego Bolivia','Servidor SIG de Riego Bolivia','http://sig01.riegobolivia.org:8080/geoserver/wms','2014-08-13 13:45:51','2015-02-04 19:02:15',1,31),
(2,'Geo Bolivia','Geo Bolivia','http://geo.gob.bo/geoserver/wms','2014-08-13 13:46:21','2014-11-25 14:11:49',1,1),
(3,'GeoSIRH','GeoSIRH','http://geosirh.riegobolivia.org/geoserver/wms','2015-04-22 07:08:43','2016-10-06 08:10:17',31,1);

/*Table structure for table `server_layer` */

DROP TABLE IF EXISTS `server_layer`;

CREATE TABLE `server_layer` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `serverId` int(11) DEFAULT NULL COMMENT 'Tabla: server',
  `tipo` int(11) DEFAULT '1' COMMENT '1:WMC;2WFS',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `descripcion` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Descripcion del layer',
  `layer` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Layer a extraer del servidor',
  `formatoId` int(11) DEFAULT NULL COMMENT 'Formato a visualizar',
  `visible` tinyint(1) DEFAULT NULL COMMENT 'Sera visible',
  `transparencia` tinyint(1) DEFAULT NULL COMMENT 'tendra transparencia',
  `opacidad` varchar(10) COLLATE latin1_general_ci DEFAULT '0.5' COMMENT 'de 0 a 1',
  `activo` tinyint(1) DEFAULT '1' COMMENT 'Activo para visualización',
  `orden` int(11) DEFAULT '0' COMMENT 'Orden de visualización',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'usuario actualizador',
  PRIMARY KEY (`itemId`),
  KEY `fk_server_layer_server_idx` (`serverId`),
  KEY `fk_server_layer_catalogo_formato1_idx` (`formatoId`),
  CONSTRAINT `fk_server_layer_catalogo_formato1` FOREIGN KEY (`formatoId`) REFERENCES `catalogo_formato` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_server_layer_server` FOREIGN KEY (`serverId`) REFERENCES `server` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Data for the table `server_layer` */

insert  into `server_layer`(`itemId`,`serverId`,`tipo`,`nombre`,`descripcion`,`layer`,`formatoId`,`visible`,`transparencia`,`opacidad`,`activo`,`orden`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,1,1,'Departamento','Departamentos de Bolivia','base:departamentos',1,1,1,'1',0,0,'2014-08-13 13:58:30','2015-02-04 19:02:03',1,31),
(2,2,1,'Areas Protegidas 2014','Poligonos de cuencas de nivel 5.','sernap:ap_nacional_wgs84_2014',1,0,1,'1',0,1,'2014-11-25 14:17:04','2014-12-12 18:12:25',1,1),
(3,1,1,'Cuenca Nivel 5','Cuenca Nivel 5','sirh:Cuenca_Nivel5',1,1,1,'0.6',0,1,'2014-11-25 14:49:46','2015-02-04 18:02:15',1,31),
(5,1,1,'Municipio','Municipios de Bolivia','base:municipios_339',1,0,1,'0.7',0,2,'2014-11-25 16:41:59','2015-02-04 19:02:44',1,31),
(6,3,1,'UH Bal HDR ESC','','geosirh:uh_bal_hdr_esc_2',1,1,1,'0.5',1,1,'2016-10-06 08:34:49','2016-10-06 08:34:49',1,1),
(7,3,1,'Cuenca Nivel 5','Cuenca Nivel 5','geosirh:uh_nivel5_nacional',1,1,1,'0.5',0,2,'2016-10-06 08:37:52','2016-10-06 10:10:01',1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
