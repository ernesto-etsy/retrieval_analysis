--Create a table that tracks how many of the listing shown for a query session matched the query's implied category
WITH CTE AS(
SELECT DISTINCT a.visit_id,a.query,a.listing_id, SAFE_CAST(position AS INT64) AS position,b.top_category,a.price_usd
FROM `etsy-data-warehouse-prod.rollups.organic_impressions` a
JOIN `etsy-data-warehouse-prod.listing_mart.listing_attributes` b
  ON a.listing_id = b.listing_id
WHERE a.placement = 'search'
AND page_number = '1'
AND _date >= CURRENT_DATE() - 90
AND SAFE_CAST(position AS INT64) <= 25
ORDER BY a.visit_id, a.query, SAFE_CAST(position AS INT64)
)
SELECT
a.visit_id,
a.query_raw,
query_session_id,
a.top_category,
SUM(CASE WHEN a.top_category = b.top_category THEN 1 ELSE 0 END) / COUNT(*) pct_category_match
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
JOIN CTE b
  ON a.visit_id = b.visit_id
  AND a.query_raw = b.query
GROUP BY 1,2,3,4
ORDER BY 1;