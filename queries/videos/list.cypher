MATCH (v:Videos)
WITH count(*) AS full_count
MATCH (v:Videos)
RETURN
    full_count,
    ID(v) AS video_id,
    v.created AS created,
    v.updated AS updated,
    v.video_uuid AS video_uuid,
    v.name AS name,
    v.description AS description,
    v.url AS url,
    v.recorded AS recorded,
    v.thumbnails AS thumbnails,
    v.rating AS rating,
    v.comment AS comment
ORDER BY
    CASE WHEN {orderby} = 'created.asc' THEN v.created END ASC,
    CASE WHEN {orderby} = 'created.desc' THEN v.created END DESC,
    CASE WHEN {orderby} = 'updated.asc' THEN v.updated END ASC,
    CASE WHEN {orderby} = 'updated.desc' THEN v.updated END DESC,
    CASE WHEN {orderby} = 'name.asc' THEN v.name END ASC,
    CASE WHEN {orderby} = 'name.desc' THEN v.name END DESC
SKIP toInt({skip})
LIMIT toInt({limit});
