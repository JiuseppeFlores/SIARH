![SIRHLogo](http://sys.sirh.gob.bo/template/user/sirh/images/login/login_titulo.png)

# SISTEMA DE INFORMACIÓN DE RECURSOS HIDRICOS

## CONTENIDO DE ESTE ARCHIVO

- Sobre SIRH
- Instalación
- Configuración
- Librerias

## Sobre SIRH

Es aplicación informática que gestiona información de la base de datos de Recursos Hídricos que permite la generación de reportes para su análisis estadístico.

Este análisis describe la situación y tendencias del sector, que son insumos para la toma de decisiones del Ministerio de Medio Ambiente y Agua

Sistema de Información de Recursos Hídricos. Es la plataforma principal del sector que está preparada para seguir los lineamientos del Plan de Implementación de Gobierno Electrónico.

# Instalación

Una vez descargado el código fuente, se debe crear el directorio "dataFile" con la siguiente estructura
Una de las cosas que podemos incluir es código:

- /**dataFile**/
- -->/**cache**/
- -->/**template**/
- -->index.html
- -->debugManager.log
- -->debugWeb.log
- -->errordb.log

Una vez creado se debe realizar la configuracion de la dirección de la url en el archivo de configuración

Se debe realizar la configuración correspondiente en apache para usarlo como virtualHost.

> <VirtualHost \*:80><br />
> ServerName sys.sirh.bo<br />
> ServerAlias www.sys.sirh.bo<br />
> DocumentRoot "d:/srv/vhost/sys.sirh.gob.bo/sys"<br />
> <Directory "d:/srv/vhost/sys.sirh.gob.bo/sys"><br />
> Options Indexes FollowSymLinks Includes ExecCGI<br />
> AllowOverride All<br />
> Require all granted<br /> > </Directory><br />
> ErrorLog "d:/srv/vhost/sys.sirh.gob.bo/logs/error.log"<br />
> CustomLog "d:/srv/vhost/sys.sirh.gob.bo/logs/access.log" common<br /> ></VirtualHost><br />

# Configuración

Para la configuración se debe editar el siguiente archivo

```[php]
<?php
    ..
    ..
    var $data = "./../dataFile/"; //La dirección de la carpeta de archivos
    ..
    ..
    /* Configuración de la base de datos */
    var $dbType         = "mysql";
    var $dbServer       = "localhost";
    var $dbUser         = "tu_usuario";
    var $dbPassword     = "tu_contraseña";
    var $dbDatabase     = "vrhr_snir";
?>
```

# Librerias

- Jquery:[https://jquery.com/](https://jquery.com/)
- Jquery UI:[https://jqueryui.com/](https://jqueryui.com/)
- Jquery DataTable:[https://datatables.net/](https://datatables.net/)
- Jquery Layout:[http://layout.jquery-dev.com/](http://layout.jquery-dev.com/)
- jquery.msgbox:[https://www.smarty.net/](https://www.smarty.net)
- OpenLayers:[https://openlayers.org/](https://openlayers.org/)
- ADOdb: [http://adodb.org](http://adodb.org/dokuwiki/doku.php?id=v5:reference:reference_index)
- PHP Smarty:[https://www.smarty.net/](https://www.smarty.net)
- dompdf:[https://github.com/dompdf/dompdf](https://github.com/dompdf/dompdf)
- phpexcel:[https://github.com/PHPOffice/PHPExcel](https://github.com/PHPOffice/PHPExcel)

## Herramientas

Se recomienda el uso de las siguientes herramientas para el desarrollo del SIRH

### Ide

- PHPStorm: [https://www.jetbrains.com/phpstorm/](https://www.jetbrains.com/phpstorm/)
- PHPDesigner: [http://www.mpsoftware.dk](http://www.mpsoftware.dk)
- SublimeText: [https://www.sublimetext.com](https://www.sublimetext.com)

### Base de Datos

- HeidiSQL: [https://www.heidisql.com](https://www.heidisql.com)
- SQLYog Ultimate: [https://www.webyog.com/product/sqlyog](https://www.webyog.com/product/sqlyog)
- Navicat: [https://www2.navicat.com/es/products/navicat-premium](https://www2.navicat.com/es/products/navicat-premium)
- Workbench: [https://www.mysql.com/products/workbench/](https://www.mysql.com/products/workbench/)
- PGAdmin: [https://www.pgadmin.org](https://www.pgadmin.org)

### Otros

- XAMPP (Win/Mac): [https://www.apachefriends.org](https://www.apachefriends.org/)
- mTail: [http://ophilipp.free.fr/op_tail.htm](http://ophilipp.free.fr/op_tail.htm)

# Creación de Base de Datos

```[sql]
CREATE DATABASE `vrhr_catalogo` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_contrato` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_cuenca` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_estudio` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_evento` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_exante` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_expost` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_fiv` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_fps` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_indicadorcuenca` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_inforiego` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_institucion` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_inventario` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_invsectorial` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_linea_base` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_monitor_cuenca` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_presa` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_proyecto` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_reuso` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_senamhi` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_siasbo` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_sig` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_sir` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_sisin` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_snir` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_sora` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_temp` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_territorio` /*!40100 COLLATE 'latin1_general_ci' */;
CREATE DATABASE `vrhr_web` /*!40100 COLLATE 'latin1_general_ci' */;




CREATE DATABASE `vrhr_territorio` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_sora` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_snir` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_sir` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_sig` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_siasbo` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_reuso` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_proyecto` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_presa` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_monitor_cuenca` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_inventario` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_institucion` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_indicadorcuenca` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_fiv` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_cuenca` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `vrhr_catalogo` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `public_core` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `personal_mmaya` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `mmaya_catalogo` /*!40100 COLLATE 'utf8_general_ci' */;
CREATE DATABASE `mmaya_entidad` /*!40100 COLLATE 'utf8_general_ci' */;
```
