--Diversity of Taxonomies
WITH CTE AS (
  SELECT DISTINCT visit_id, query, COUNT(DISTINCT taxonomy_id) AS variety_of_taxonomies
  FROM `etsy-data-warehouse-prod.rollups.organic_impressions`
  WHERE _date >= CURRENT_DATE() - 5
  AND placement = 'search'
  GROUP BY 1,2
)
SELECT
top_category,
AVG(CASE WHEN label = 'Broad' THEN 1 ELSE 0 END) AS pct_broad_queries,
AVG(b.variety_of_taxonomies) AS avg_taxonomies_in_results,
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
JOIN CTE b
  ON a.visit_id = b.visit_id
  AND a.query_raw = b.query
WHERE a.total_listings IS NOT NULL
--AND label IS NOT NULL
AND top_category IS NOT NULL
GROUP BY 1;

--Diversity of Taxonomies
WITH CTE AS (
  SELECT DISTINCT visit_id, query, COUNT(DISTINCT taxonomy_id) AS variety_of_taxonomies
  FROM `etsy-data-warehouse-prod.rollups.organic_impressions`
  WHERE _date >= CURRENT_DATE() - 90
  AND placement = 'search'
  GROUP BY 1,2
)
SELECT
label,
AVG(b.variety_of_taxonomies) AS avg_taxonomies_in_results,
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
JOIN CTE b
  ON a.visit_id = b.visit_id
  AND a.query_raw = b.query
WHERE a.total_listings IS NOT NULL
--AND label IS NOT NULL
AND top_category IS NOT NULL
GROUP BY 1;
