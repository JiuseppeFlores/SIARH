-- ----------------------------------------------------------
-- Author: José L. Flores
-- Function: Creación de un nuevo catalogo para el almacenamiento
--           de litologías para la subsección de "Columna Litológica"
--           de la sección "Pozos"
-- Request: Hidrogema-Siasbo Requerimiento 2.7
-- ----------------------------------------------------------

-- ----------------------------
-- Table structure for catalogo_pozo_litologico_tipo
-- ----------------------------
DROP TABLE IF EXISTS `catalogo_pozo_litologico`;
CREATE TABLE `catalogo_pozo_litologico`  (
  `itemId` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `imagen` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `activo` tinyint(4) NULL DEFAULT NULL,
  `dateCreate` datetime NULL DEFAULT NULL,
  `dateUpdate` datetime NULL DEFAULT NULL,
  `userCreate` int(11) NULL DEFAULT NULL,
  `userUpdate` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`itemId`) USING BTREE,
  UNIQUE INDEX `nombre`(`nombre`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of catalogo_pozo_litologico_tipo
-- ----------------------------
INSERT INTO `catalogo_pozo_litologico` VALUES (1, 'Arena gruesa', 'arena-gruesa.png', 1, '2025-07-18 09:26:14', '2025-07-18 09:26:15', 1, 1);
INSERT INTO `catalogo_pozo_litologico` VALUES (2, 'Grava media', 'grava-media.png', 1, '2025-07-18 09:26:38', '2025-07-18 09:26:39', 1, 1);
INSERT INTO `catalogo_pozo_litologico` VALUES (3, 'Grava gruesa', 'grava-gruesa.png', 1, '2025-07-18 09:26:01', '2025-07-18 09:26:02', 1, 1);
INSERT INTO `catalogo_pozo_litologico` VALUES (4, 'Grava fina', 'grava-fina.png', 1, '2025-07-18 09:26:31', '2025-07-18 09:26:31', 1, 1);
INSERT INTO `catalogo_pozo_litologico` VALUES (5, 'Arcilla', 'arcilla.png', 1, '2025-07-18 09:26:31', '2025-07-18 09:26:31', 1, 1);

