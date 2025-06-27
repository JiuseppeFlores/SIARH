select 
g.itemId
, g.itemId as gestion
from mmaya_catalogo.gestion as g
where g.itemId not in
(
select 
itemId
from item as i
)
;
