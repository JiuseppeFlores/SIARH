-- ----------------------------
-- Table structure for catalogo_pozo_litologico_tipo
-- ----------------------------
DROP TABLE IF EXISTS `catalogo_pozo_litologico_redondez`;
CREATE TABLE `catalogo_pozo_litologico_redondez`  (
  `itemId` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
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
INSERT INTO `catalogo_pozo_litologico_redondez` VALUES (1, 'Redondeado', 1, '2025-07-18 10:11:14', '2025-07-18 10:11:15', 1, 1);
INSERT INTO `catalogo_pozo_litologico_redondez` VALUES (2, 'Subredondeado', 1, '2025-07-18 10:11:38', '2025-07-18 10:11:39', 1, 1);
INSERT INTO `catalogo_pozo_litologico_redondez` VALUES (3, 'Anguloso', 1, '2025-07-18 10:11:01', '2025-07-18 10:11:02', 1, 1);
INSERT INTO `catalogo_pozo_litologico_redondez` VALUES (4, 'Subanguloso', 1, '2025-07-18 10:11:31', '2025-07-18 10:11:31', 1, 1);