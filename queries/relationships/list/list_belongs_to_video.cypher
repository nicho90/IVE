MATCH (v:Videos)-[r:belongs_to]->(s:Scenarios)
WITH count(r) AS full_count
MATCH (v:Videos)-[r:belongs_to]->(s:Scenarios)
RETURN
    full_count,
    ID(v) AS video_id,
    v.created AS video_created,
    v.updated AS video_updated,
    v.video_uuid AS video_uuid,
    v.name AS video_name,
    v.description AS video_description,
    v.url AS video_url,
    v.recorded AS video_recorded,
    v.thumbnails AS thumbnails,
    ID(r) AS relationship_id,
    r.created AS relationship_created,
    r.updated AS relationship_updated,
    ID(s) AS scenario_id,
    s.created AS scenario_created,
    s.updated AS scenario_updated,
    s.scenario_uuid AS scenario_uuid,
    s.name AS scenario_name,
    s.description AS scenario_description
ORDER BY
    CASE WHEN {orderby} = 'created.asc'         THEN r.created END ASC,
    CASE WHEN {orderby} = 'created.desc'        THEN r.created END DESC,
    CASE WHEN {orderby} = 'updated.asc'         THEN r.updated END ASC,
    CASE WHEN {orderby} = 'updated.desc'        THEN r.updated END DESC,
    CASE WHEN {orderby} = 'video_name.asc'      THEN v.name END ASC,
    CASE WHEN {orderby} = 'video_name.desc'     THEN v.name END DESC,
    CASE WHEN {orderby} = 'scenario_name.asc'   THEN s.name END ASC, v.name ASC,
    CASE WHEN {orderby} = 'scenario_name.desc'  THEN s.name END DESC, v.name ASC
SKIP toInt({skip})
LIMIT toInt({limit});
