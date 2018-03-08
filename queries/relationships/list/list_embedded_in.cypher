MATCH (o:Overlays)-[r:embedded_in]->(v:Videos)
WITH count(r) AS full_count
MATCH (o:Overlays)-[r:embedded_in]->(v:Videos)
RETURN
    full_count,
    ID(o) AS overlay_id,
    o.created AS overlay_created,
    o.updated AS overlay_updated,
    o.overlay_uuid AS overlay_uuid,
    o.name AS overlay_name,
    o.description AS overlay_description,
    o.category AS overlay_category,
    o.url AS overlay_url,
    ID(r) AS relationship_id,
    r.created AS relationship_created,
    r.updated AS relationship_updated,
    r.description AS relationship_description,
    r.w AS relationship_w,
    r.h AS relationship_h,
    r.d AS relationship_d,
    r.x AS relationship_x,
    r.y AS relationship_y,
    r.z AS relationship_z,
    r.rx AS relationship_rx,
    r.ry AS relationship_ry,
    r.rz AS relationship_rz,
    r.display AS relationship_display,
    ID(v) AS video_id,
    v.created AS video_created,
    v.updated AS video_updated,
    v.video_uuid AS video_uuid,
    v.name AS video_name,
    v.description AS video_description,
    v.url AS video_url,
    v.recorded AS video_recorded,
    v.thumbnails AS thumbnails
ORDER BY
    CASE WHEN {orderby} = 'created.asc'         THEN r.created END ASC,
    CASE WHEN {orderby} = 'created.desc'        THEN r.created END DESC,
    CASE WHEN {orderby} = 'updated.asc'         THEN r.updated END ASC,
    CASE WHEN {orderby} = 'updated.desc'        THEN r.updated END DESC,
    CASE WHEN {orderby} = 'overlay_name.asc'    THEN o.name END ASC,
    CASE WHEN {orderby} = 'overlay_name.desc'   THEN o.name END DESC,
    CASE WHEN {orderby} = 'video_name.asc'      THEN v.name END ASC, o.name ASC,
    CASE WHEN {orderby} = 'video_name.desc'     THEN v.name END DESC, o.name ASC
SKIP toInt({skip})
LIMIT toInt({limit});