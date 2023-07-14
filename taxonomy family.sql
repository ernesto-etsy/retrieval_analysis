--Get the whole taxonomy family tree from a taxonomy id
WITH RECURSIVE taxonomy_branch AS (
  SELECT taxonomy_id, parent_taxonomy_id, taxonomy_level
  FROM `etsy-data-warehouse-prod.structured_data.taxonomy`
  WHERE taxonomy_id = 9031 -- Replace with the actual taxonomy ID you want to search for
  
  UNION ALL
  
  SELECT t.taxonomy_id, t.parent_taxonomy_id, t.taxonomy_level
  FROM `etsy-data-warehouse-prod.structured_data.taxonomy` t
  INNER JOIN taxonomy_branch tb ON t.taxonomy_id = tb.parent_taxonomy_id
)
SELECT *
FROM taxonomy_branch
ORDER BY taxonomy_level ASC;