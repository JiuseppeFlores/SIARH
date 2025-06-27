/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 10.1.21-MariaDB : Database - vrhr_institucion
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `catalogo_componente` */

DROP TABLE IF EXISTS `catalogo_componente`;

CREATE TABLE `catalogo_componente` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizado',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Catalogo de Componente / actividades / resultados';

/*Data for the table `catalogo_componente` */

/*Table structure for table `catalogo_estado` */

DROP TABLE IF EXISTS `catalogo_estado`;

CREATE TABLE `catalogo_estado` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizado',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Orgainsmos Financiadores de programas';

/*Data for the table `catalogo_estado` */

/*Table structure for table `catalogo_modalidad` */

DROP TABLE IF EXISTS `catalogo_modalidad`;

CREATE TABLE `catalogo_modalidad` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizado',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Orgainsmos Financiadores de programas';

/*Data for the table `catalogo_modalidad` */

/*Table structure for table `catalogo_organismo` */

DROP TABLE IF EXISTS `catalogo_organismo`;

CREATE TABLE `catalogo_organismo` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizado',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Orgainsmos Financiadores de programas';

/*Data for the table `catalogo_organismo` */

insert  into `catalogo_organismo`(`itemId`,`nombre`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(2,'','2014-12-30 10:43:56','2014-12-30 10:43:56',48,48),
(3,'Prueba','2014-12-30 10:43:57','2014-12-30 10:43:57',48,48),
(4,'Prueba 2','2015-08-14 10:48:59','2015-08-14 10:48:59',8,8);

/*Table structure for table `catalogo_tipo` */

DROP TABLE IF EXISTS `catalogo_tipo`;

CREATE TABLE `catalogo_tipo` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre el tipo',
  `descripcion` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Descripcion',
  `dateCreate` date DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` date DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizado',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Tipo de Institución';

/*Data for the table `catalogo_tipo` */

insert  into `catalogo_tipo`(`itemId`,`nombre`,`descripcion`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,'Programa','Instituciones de Tipo Programa','2014-05-18','2014-05-18',1,1),
(2,'Publico','Entidad Pública','2014-08-14','2014-08-14',1,1);

/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `parentId` int(11) DEFAULT NULL COMMENT 'En caso de relacionar una institución como organismo financiado.',
  `tipoId` int(11) DEFAULT NULL COMMENT 'Tabla: catalogo_tipo',
  `sisin` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Codigo SISIN',
  `nombre` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Nombre de la institución',
  `descripcion` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Descripción de la institución',
  `sigla` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Sigla de la institución',
  `objetivo` text COLLATE latin1_general_ci COMMENT 'Objetivo',
  `cartera` text COLLATE latin1_general_ci COMMENT 'Ingresa la cantidad de proyectos',
  `convenio` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Convenio, suscriptores',
  `convenio_codigo` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Codigo de convenio',
  `financiador` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Financiador',
  `tipofinanciamiento` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Tipo de financiamiento',
  `unidad_monetaria` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Unidad monetaria',
  `fechaFin` date DEFAULT NULL COMMENT 'Fecha fin, en caso de ser programa',
  `fechaInicio` date DEFAULT NULL COMMENT 'Fecha inicio, en caso que sea programa',
  `estadoId` int(11) DEFAULT NULL COMMENT 'tabla: catalogo_estado',
  `dependencia` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Dependencia',
  `entidadEjecutora` varchar(255) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'Ente ejecutor',
  `ejecutado` decimal(18,2) DEFAULT NULL COMMENT 'Ejecutado',
  `ejecutado_saldo` decimal(18,2) DEFAULT NULL COMMENT 'Saldo por ejecutar',
  `comprometido` decimal(18,2) DEFAULT NULL COMMENT 'Comprometido',
  `comprometido_saldo` decimal(18,2) DEFAULT NULL COMMENT 'Comprometido Saldo',
  `tipoCambio` decimal(18,2) DEFAULT NULL COMMENT 'Tipo de cambio de dolar',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de Creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizador',
  PRIMARY KEY (`itemId`),
  KEY `fk_item_catalogo_tipo_idx` (`tipoId`),
  KEY `fk_item_catalogo_estado1_idx` (`estadoId`),
  CONSTRAINT `fk_item_catalogo_estado1` FOREIGN KEY (`estadoId`) REFERENCES `catalogo_estado` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_catalogo_tipo` FOREIGN KEY (`tipoId`) REFERENCES `catalogo_tipo` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Instituciones del estado, programas y otros';

/*Data for the table `item` */

insert  into `item`(`itemId`,`parentId`,`tipoId`,`sisin`,`nombre`,`descripcion`,`sigla`,`objetivo`,`cartera`,`convenio`,`convenio_codigo`,`financiador`,`tipofinanciamiento`,`unidad_monetaria`,`fechaFin`,`fechaInicio`,`estadoId`,`dependencia`,`entidadEjecutora`,`ejecutado`,`ejecutado_saldo`,`comprometido`,`comprometido_saldo`,`tipoCambio`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,NULL,1,'--','PRONAREC','Programa Nacional de Riego con Enfoque de Cuencas (PRONAREC)','','','','BID-02057','BID-02057','','','','2014-05-18','2014-05-18',NULL,'','',0.00,0.00,0.00,0.00,0.00,'2014-05-18 08:52:24','2014-12-05 11:12:20',1,1),
(2,NULL,1,'--','CONTRAVALOR','CONTRAVALOR','','','','','','','','','2014-08-14','2014-08-14',NULL,'','',0.00,0.00,0.00,0.00,6.96,'2014-07-27 21:45:14','2014-11-12 11:11:00',1,1),
(3,NULL,1,'','KOICA','COREA','','',NULL,'','','','','','0000-00-00','0000-00-00',NULL,'','',0.00,0.00,0.00,0.00,0.00,'2014-07-27 21:45:14','2014-10-31 15:10:00',1,1),
(4,NULL,1,NULL,'MIAGUA','MIAGUA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-07-27 21:45:14','2014-07-27 21:45:14',1,1),
(5,NULL,1,'--','MIAGUA 2','MIAGUA II','','','','','','','','','0000-00-00','0000-00-00',NULL,'','',0.00,0.00,0.00,0.00,0.00,'2014-07-27 21:45:14','2014-11-18 15:11:38',1,1),
(6,NULL,1,'--','MIAGUA 3','MIAGUA III','','','','','','','','','0000-00-00','0000-00-00',NULL,'','',0.00,0.00,0.00,0.00,0.00,'2014-07-27 21:45:14','2014-11-18 15:11:48',1,1),
(7,NULL,1,NULL,'PARC','Programa de Apoyo al Riego Comunitario',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-07-27 21:45:14','2014-07-27 21:45:14',1,1),
(8,NULL,1,NULL,'PIACC','PIACC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-07-27 21:45:14','2014-07-27 21:45:14',1,1),
(9,NULL,1,NULL,'PNC','PNC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-07-27 21:45:14','2014-07-27 21:45:14',1,1),
(10,NULL,1,NULL,'PROAR','PROAR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-07-27 21:45:14','2014-07-27 21:45:14',1,1),
(11,NULL,1,NULL,'SIRIC','Subprograma de Inversiones en Riego Inter Comunal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2014-07-27 21:45:14','2014-07-27 21:45:14',1,1),
(12,NULL,2,'','Servicio Nacional del Riego','Servicio Nacional de Riego','SENARI','',NULL,'','','','','','0000-00-00','0000-00-00',NULL,'','',0.00,0.00,0.00,0.00,0.00,'2014-08-14 15:16:45','2014-09-26 15:09:16',1,1),
(14,NULL,1,'-0-','Viceministerio de Recursos Hidricos y Riego','Dependencia del Ministerio de Medio Ambiente y Agua','VRHR','','000','000','000','','','','2015-04-21','2015-04-21',NULL,'00','',0.00,0.00,0.00,0.00,0.00,'2014-09-25 15:15:45','2015-04-21 08:04:19',1,1),
(15,NULL,1,'--','MIRIEGO','test','MIRIEGO','','','','','','','','2015-05-13','2015-05-13',NULL,'','',0.00,0.00,0.00,0.00,0.00,'2014-11-18 15:33:24','2015-05-13 09:05:29',1,1),
(16,NULL,1,'12-12312-31231','COREA','COREA, PROGRAMA QUE NO PERTENECE AL VRHR\r\n','COREA','','asdasdsa','campaña','213sad','prueba','Prueba','Dolar','2015-03-31','2015-03-16',NULL,'COREA','prueba',0.00,0.00,0.00,0.00,0.00,'2015-03-23 11:46:27','2015-04-02 02:04:27',31,1),
(17,NULL,1,NULL,'MMAyA','Ministerio de Medio Ambiente y Agua','MMAyA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-20','2017-10-20',NULL,'MMAyA',NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-20 10:45:02','2017-10-20 10:45:04',1,1);

/*Table structure for table `item_componente` */

DROP TABLE IF EXISTS `item_componente`;

CREATE TABLE `item_componente` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `fichaId` int(11) DEFAULT NULL COMMENT 'Tabla: ítem',
  `componenteId` int(11) DEFAULT NULL,
  `fuente_externa` float(18,2) DEFAULT NULL,
  `fuente_interna` float(18,2) DEFAULT NULL,
  `fuente_total` float(18,2) DEFAULT NULL,
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizado',
  PRIMARY KEY (`itemId`),
  KEY `fk_item_componente_item1_idx` (`fichaId`),
  KEY `fk_item_componente_catalogo_componente1_idx` (`componenteId`),
  CONSTRAINT `fk_item_componente_catalogo_componente1` FOREIGN KEY (`componenteId`) REFERENCES `catalogo_componente` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_componente_item1` FOREIGN KEY (`fichaId`) REFERENCES `item` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Componente / actividades / resultados';

/*Data for the table `item_componente` */

/*Table structure for table `item_departamento` */

DROP TABLE IF EXISTS `item_departamento`;

CREATE TABLE `item_departamento` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `fichaId` int(11) DEFAULT NULL COMMENT 'Tabla:ítem',
  `departamentoId` int(11) DEFAULT NULL COMMENT 'tabla: vrhr_territorio.departamento',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizado',
  PRIMARY KEY (`itemId`),
  KEY `fk_item_departamento_item1_idx` (`fichaId`),
  KEY `fk_item_departamento_departamento1_idx` (`departamentoId`),
  CONSTRAINT `fk_item_departamento_departamento1` FOREIGN KEY (`departamentoId`) REFERENCES `vrhr_territorio`.`departamento` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_departamento_item1` FOREIGN KEY (`fichaId`) REFERENCES `item` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Data for the table `item_departamento` */

insert  into `item_departamento`(`itemId`,`fichaId`,`departamentoId`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(5,16,1,'2015-04-02 02:14:27','2015-04-02 02:14:27',1,1);

/*Table structure for table `item_presupuesto` */

DROP TABLE IF EXISTS `item_presupuesto`;

CREATE TABLE `item_presupuesto` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT,
  `fichaId` int(11) DEFAULT NULL,
  `organismoId` int(11) DEFAULT NULL COMMENT 'Tabla: catalogo_organismo',
  `monto_bs` decimal(18,2) DEFAULT NULL COMMENT 'Monto en bolivianos',
  `monto_usd` decimal(18,2) DEFAULT NULL COMMENT 'Monto en solares',
  `modalidadId` int(11) DEFAULT NULL COMMENT 'Tabla: catalogo_modalidad',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualizacion',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizado',
  PRIMARY KEY (`itemId`),
  KEY `fk_item_presupuesto_item1_idx` (`fichaId`),
  KEY `fk_item_presupuesto_catalogo_organismo1_idx` (`organismoId`),
  KEY `fk_item_presupuesto_catalogo_modalidad1_idx` (`modalidadId`),
  CONSTRAINT `fk_item_presupuesto_catalogo_modalidad1` FOREIGN KEY (`modalidadId`) REFERENCES `catalogo_modalidad` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_presupuesto_catalogo_organismo1` FOREIGN KEY (`organismoId`) REFERENCES `catalogo_organismo` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_presupuesto_item1` FOREIGN KEY (`fichaId`) REFERENCES `item` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Data for the table `item_presupuesto` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
