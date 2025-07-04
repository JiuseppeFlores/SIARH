-- script en mysql, cambios par el tipo de dato en la base de datos mmaya_siasbo 
ALTER TABLE item_pozo_hidra MODIFY porosidad DECIMAL(7,5);
ALTER TABLE item_pozo MODIFY constructivo_diametro VARCHAR(50);
INSERT INTO catalogo_manantial_usoagua (nombre,activo,dateCreate,dateUpdate,userCreate,userUpdate) VALUES ('Desconocido, Otro',1,NOW(),NOW(),1,1);