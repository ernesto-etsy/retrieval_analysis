--Diversity of Taxonomies
WITH CTE AS (
  SELECT DISTINCT visit_id, query, COUNT(DISTINCT taxonomy_id) AS variety_of_taxonomies
  FROM `etsy-data-warehouse-prod.rollups.organic_impressions`
  WHERE _date >= CURRENT_DATE() - 90
  AND placement = 'search'
  AND query <> ""
  GROUP BY 1,2
),
CTE2 AS (
SELECT
query_session_id,
label,
variety_of_taxonomies,
same_day_gms
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
JOIN CTE b
  ON a.visit_id = b.visit_id
  AND a.query_raw = b.query
WHERE a.total_listings IS NOT NULL
)
SELECT
label,
variety_of_taxonomies,
SUM(same_day_gms) / COUNT(DISTINCT query_session_id) AS gms_per_query,
COUNT(DISTINCT query_session_id) AS total_queries
FROM CTE2
GROUP BY 1,2
ORDER BY 2;

--Diversity of Taxonomies
WITH CTE AS (
  SELECT DISTINCT visit_id, query, COUNT(DISTINCT taxonomy_id) AS variety_of_taxonomies
  FROM `etsy-data-warehouse-prod.rollups.organic_impressions`
  WHERE _date >= CURRENT_DATE() - 90
  AND placement = 'search'
  AND query <> ""
  GROUP BY 1,2
),
CTE2 AS (
SELECT
query_session_id,
label,
variety_of_taxonomies,
same_day_gms
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
JOIN CTE b
  ON a.visit_id = b.visit_id
  AND a.query_raw = b.query
WHERE a.total_listings IS NOT NULL
AND top_category = "home_and_living"
)
SELECT
label,
variety_of_taxonomies,
SUM(same_day_gms) / COUNT(DISTINCT query_session_id) AS gms_per_query,
COUNT(DISTINCT query_session_id) AS total_queries
FROM CTE2
GROUP BY 1,2
ORDER BY 2;
