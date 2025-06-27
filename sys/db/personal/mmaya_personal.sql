/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 10.1.21-MariaDB : Database - mmaya_personal
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `catalogo_afp` */

DROP TABLE IF EXISTS `catalogo_afp`;

CREATE TABLE `catalogo_afp` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'nombre',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='AFP';

/*Data for the table `catalogo_afp` */

insert  into `catalogo_afp`(`itemId`,`nombre`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,'AFP Futuro','2017-12-26 12:48:52','2017-12-26 12:48:56',1,1),
(2,'AFP Prevision','2017-12-26 12:50:20','2017-12-26 12:50:21',1,1);

/*Table structure for table `catalogo_categoria` */

DROP TABLE IF EXISTS `catalogo_categoria`;

CREATE TABLE `catalogo_categoria` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'nombre',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Catalogo de categorias: superior, ejecutivo, operativo';

/*Data for the table `catalogo_categoria` */

insert  into `catalogo_categoria`(`itemId`,`nombre`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,'SUPERIOR','2017-12-26 13:42:58','2017-12-26 13:42:58',1,1),
(2,'EJECUTIVO','2017-12-26 13:43:12','2017-12-26 13:43:13',1,1),
(3,'OPERATIVO','2017-12-26 13:43:34','2017-12-26 13:43:28',1,1);

/*Table structure for table `catalogo_estado_civil` */

DROP TABLE IF EXISTS `catalogo_estado_civil`;

CREATE TABLE `catalogo_estado_civil` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'nombre',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalogo de estado civil';

/*Data for the table `catalogo_estado_civil` */

/*Table structure for table `catalogo_genero` */

DROP TABLE IF EXISTS `catalogo_genero`;

CREATE TABLE `catalogo_genero` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'nombre',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Catalogo de genero';

/*Data for the table `catalogo_genero` */

insert  into `catalogo_genero`(`itemId`,`nombre`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,'Femenino','2017-12-26 12:51:13','2017-12-26 12:51:14',1,1),
(2,'Masculino','2017-12-26 12:51:20','2017-12-26 12:51:20',1,1);

/*Table structure for table `catalogo_modalidad` */

DROP TABLE IF EXISTS `catalogo_modalidad`;

CREATE TABLE `catalogo_modalidad` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'Nombre',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'usuario actualizador',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Modalidad: permanente, consultor';

/*Data for the table `catalogo_modalidad` */

insert  into `catalogo_modalidad`(`itemId`,`nombre`,`dateCreate`,`dateUpdate`,`userCreate`,`userUpdate`) values 
(1,'Planta','2017-12-26 12:52:12','2017-12-26 12:52:12',1,1),
(2,'Consultor de Linea','2017-12-26 12:52:17','2017-12-26 12:52:17',1,1),
(3,'Consultor por Producto','2018-03-01 17:06:02','2018-03-01 17:06:05',1,1),
(4,'Personal eventual','2018-03-19 11:09:01','2018-03-19 11:09:11',1,1);

/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave',
  `cargo` varchar(255) DEFAULT NULL COMMENT 'Nombre del cargo',
  `nivel` varchar(255) DEFAULT NULL COMMENT 'Nivel',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'Nombre del Item',
  `unidad_organizacional` varchar(255) DEFAULT NULL COMMENT 'Unidad Organizacional',
  `fuente` int(11) DEFAULT NULL COMMENT 'Fuente de financiamiento',
  `observaciones` text COMMENT 'Planilla salarial Gestion 2017 al 20 de diciembre 2017',
  `lugar` varchar(255) DEFAULT NULL COMMENT 'Lugar',
  `unidad` varchar(255) DEFAULT NULL COMMENT 'Unidad',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Items disponibles para el MMAyA';

/*Data for the table `item` */

/*Table structure for table `persona` */

DROP TABLE IF EXISTS `persona`;

CREATE TABLE `persona` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave',
  `dateCreate` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `dateUpdate` datetime DEFAULT NULL COMMENT 'Fecha de Actualización',
  `userCreate` int(11) DEFAULT NULL COMMENT 'Usuario Creador',
  `userUpdate` int(11) DEFAULT NULL COMMENT 'Usuario Actualizadro',
  `activo` tinyint(4) DEFAULT '0' COMMENT 'Activo:1; No Activo:0',
  `nombres` varchar(255) DEFAULT NULL COMMENT 'nombres',
  `apellido_paterno` varchar(255) DEFAULT NULL COMMENT 'Apellido paterno',
  `apellido_materno` varchar(255) DEFAULT NULL COMMENT 'Apellido materno',
  `apellidos_nombres_rh` varchar(255) DEFAULT NULL COMMENT 'Apellidos y nombres segun recursos humanos',
  `apellido_casada` varchar(255) DEFAULT NULL COMMENT 'Apellido de casada',
  `estado_civil` int(11) DEFAULT NULL COMMENT 'tabla: catalogo_estado_civil',
  `fecha_nacimiento` date DEFAULT NULL COMMENT 'Fecha de nacimiento',
  `direccion` text COMMENT 'Dirección',
  `cargo_form` varchar(255) DEFAULT NULL COMMENT 'Cargo segun formulario',
  `inmediato_superior` varchar(255) DEFAULT NULL COMMENT 'Inmediato Superior',
  `genero_id` int(11) DEFAULT NULL COMMENT 'Tabla:catalogo_genero',
  `profesional` varchar(255) DEFAULT NULL COMMENT 'Profesion',
  `modalidad_id` int(11) DEFAULT NULL COMMENT 'Tabla: catalogo_modalidad',
  `ci` varchar(255) DEFAULT NULL COMMENT 'Carnet de Identidad',
  `ci_exp` int(11) DEFAULT NULL COMMENT 'catalogo_territorio',
  `ci_num` bigint(20) DEFAULT NULL COMMENT 'Carnet de identidad en formato numerico',
  `telefono` varchar(255) DEFAULT NULL COMMENT 'Telefono fijo',
  `movil` int(11) DEFAULT NULL COMMENT 'Telefono celular personal',
  `movil_whatsapp` tinyint(4) DEFAULT NULL COMMENT 'Telefono celular personal - si:1;no:0;',
  `movil_corporativo` bigint(20) DEFAULT NULL COMMENT 'Telefono celular corporativo',
  `movil_corporativo_whatsapp` tinyint(4) DEFAULT NULL COMMENT 'Telefono celular corporativo whatsapp - si:1;no:0;',
  `telefono_interno` int(11) DEFAULT NULL COMMENT 'Telefono interno',
  `facebook_url` varchar(255) DEFAULT NULL COMMENT 'URL en facebook',
  `facebook_id` varchar(255) DEFAULT NULL COMMENT 'Id en facebook',
  `twitter_url` varchar(255) DEFAULT NULL COMMENT 'Url en twitter',
  `twitter_id` varchar(255) DEFAULT NULL COMMENT 'Id en twitter',
  `capacidad_especial` tinyint(4) DEFAULT NULL COMMENT 'tiene capacidades especiales',
  `hijos` int(11) DEFAULT NULL COMMENT 'Numero de hijos',
  `correo_personal` varchar(255) DEFAULT NULL COMMENT 'correo personal',
  `correo_institucional` varchar(255) DEFAULT NULL COMMENT 'correo institucional',
  `codigo_sigma` int(11) DEFAULT NULL COMMENT 'codigo sigma',
  `item_id` int(11) DEFAULT NULL COMMENT 'catalogo_item',
  `afp_id` int(11) DEFAULT NULL COMMENT 'tabla: catalgo_afp',
  `nua` bigint(20) DEFAULT NULL COMMENT 'codigo nua',
  `numero_cuenta` bigint(20) DEFAULT NULL COMMENT 'Numero de cuenta bancaria, actual',
  `fecha_ingreso` date DEFAULT NULL COMMENT 'Fecha de ingreso',
  `fecha_retiro` date DEFAULT NULL COMMENT 'Fecha de retiro',
  `categoria_programatica` varchar(255) DEFAULT NULL COMMENT 'Categoría programática',
  `sub_nivel` int(11) DEFAULT NULL COMMENT 'sub nivel',
  `categoria_id` int(11) DEFAULT NULL COMMENT 'tabla:catalogo_categoria',
  `clase` int(11) DEFAULT NULL COMMENT 'Clase',
  `cargo_escala` varchar(255) DEFAULT NULL COMMENT 'Cargo escala',
  `fuente` int(11) DEFAULT NULL COMMENT 'fuente de financiamiento',
  `fuente_descripcion` varchar(255) DEFAULT NULL,
  `organismo` int(11) DEFAULT NULL COMMENT 'organismo',
  `partida` int(11) DEFAULT NULL COMMENT 'partida',
  `telefono_personal` varchar(255) DEFAULT NULL COMMENT 'teléfono personal',
  `telefono_corporativo` int(11) DEFAULT NULL COMMENT 'teléfono corporativo',
  `correo_electronico` varchar(255) DEFAULT NULL COMMENT 'correo electrónico',
  `red_ip` varchar(255) DEFAULT NULL COMMENT 'Dirección IP',
  `red_mac` varchar(255) DEFAULT NULL COMMENT 'Dirección Mac',
  `notas` varchar(255) DEFAULT NULL COMMENT 'Notas sobre los ususarios.',
  `entidad_id` int(11) DEFAULT NULL COMMENT 'tabla:mmaya_entidad.entidad',
  `direccion_id` int(11) DEFAULT NULL COMMENT 'tabla:mmaya_entidad.direccion',
  `unidad_id` int(11) DEFAULT NULL COMMENT 'tabla:mmaya_entidad.unidad',
  `area_id` int(11) DEFAULT NULL COMMENT 'tabla:mmaya_entidad.area',
  `comision` tinyint(4) DEFAULT NULL,
  `comision_entidad_id` int(11) DEFAULT NULL COMMENT 'En comision\ntabla:mmaya_entidad.entidad',
  `comision_direccion_id` int(11) DEFAULT NULL COMMENT 'En comision\ntabla:mmaya_entidad.direccion',
  `comision_unidad_id` int(11) DEFAULT NULL COMMENT 'En comision\ntabla:mmaya_entidad.unidad',
  `comision_area_id` int(11) DEFAULT NULL COMMENT 'En comision\ntabla:mmaya_entidad.area',
  `lugar_id` int(11) DEFAULT NULL COMMENT 'Lugar donde se encuentra trabajando fisicamente\ntabla:mmaya_entidad.lugar',
  `codice_id` int(11) DEFAULT NULL COMMENT 'Codigo en codice\ntabla: codice_codice.users',
  `codice_usuario` varchar(255) DEFAULT NULL COMMENT 'Usuario codice actual',
  `codice_usuario_antiguo` varchar(255) DEFAULT NULL COMMENT 'Usuario Codice Antiguo',
  PRIMARY KEY (`itemId`),
  UNIQUE KEY `idx_ci` (`ci`),
  UNIQUE KEY `codic_id_unique` (`codice_id`),
  KEY `fk_persona_catalogo_genero1_idx` (`genero_id`),
  KEY `fk_persona_catalogo_afp1_idx` (`afp_id`),
  KEY `fk_persona_catalogo_modalidad1_idx` (`modalidad_id`),
  KEY `FK_persona_catalogo_categoria` (`categoria_id`),
  CONSTRAINT `FK_persona_catalogo_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `catalogo_categoria` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_catalogo_afp1` FOREIGN KEY (`afp_id`) REFERENCES `catalogo_afp` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_catalogo_genero1` FOREIGN KEY (`genero_id`) REFERENCES `catalogo_genero` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_catalogo_modalidad1` FOREIGN KEY (`modalidad_id`) REFERENCES `catalogo_modalidad` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='datos de las personas que trabajan en el vrhr';

/*Data for the table `persona` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
