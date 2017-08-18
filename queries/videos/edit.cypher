MATCH (v:Videos)
WHERE ID(v) = toInt({video_id})
SET
    v.updated = timestamp(),
    v.v_id = {v_id},
    v.name = {name},
    v.description = {description},
    v.url = {url},
    v.recorded = {recorded},
    thumbnails = {thumbnails}
RETURN
    ID(v) AS video_id,
    v.created AS created,
    v.updated AS updated,
    v.v_id AS v_id,
    v.name AS name,
    v.description AS description,
    v.url AS url,
    v.recorded AS recorded,
    v.thumbnails AS thumbnails
;
