SELECT
  p.itemId      AS itemId,
  c.nombre      AS categoria,
  a.nombre      AS area,
  p.itemId      AS nivel,
  m.clase       AS clase,
  p.nombre      AS puesto,
  m.nombre      AS cargo,
  m.nivel_interno,
  e.nombre      AS entidad,
  d.nombre      AS direccion,
  u.nombre      AS unidad,
  
  p.fuente,
  p.organismo_id,
  p.programa_id,
  p.proyecto_id,
  p.actividad_id,

  p.objeto_gasto
FROM

mmaya_rrhh_item.item p

LEFT JOIN mmaya_rrhh_escala_salarial.escala_maestra m ON m.itemId = p.escala_maestra_id
LEFT JOIN mmaya_rrhh_escala_salarial.catalogo_escala_maestra_area a  ON a.itemId = m.area_id
LEFT JOIN mmaya_rrhh_escala_salarial.catalogo_escala_maestra_categoria c ON c.itemId = m.categoria_id
LEFT JOIN mmaya_entidad.entidad e ON e.itemId = p.entidad_id
LEFT JOIN mmaya_entidad.direccion d ON d.itemId = p.direccion_id
LEFT JOIN mmaya_entidad.unidad u ON u.itemId = p.unidad_id