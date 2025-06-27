CREATE DEFINER=`root`@`localhost` PROCEDURE `item_escala_salarial`(
	IN `gestion` INT


)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
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



END