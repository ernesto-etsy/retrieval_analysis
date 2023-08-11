--What % of first-page results match the classified top-level taxonomy of each query?
WITH first_page AS (
SELECT DISTINCT a.visit_id,a.query,a.listing_id, b.top_category, price_usd
FROM `etsy-data-warehouse-prod.rollups.organic_impressions` a
JOIN `etsy-data-warehouse-prod.listing_mart.listing_attributes` b
  ON a.listing_id = b.listing_id
WHERE a.placement = 'search'
AND page_number = '1'
AND _date >= CURRENT_DATE() - 90
),
category_match AS (
SELECT
a.query_session_id,
a.top_category,
a.has_purchase,
COUNT(DISTINCT listing_id) AS total_listings_page_one,
COUNT(DISTINCT CASE WHEN a.top_category = b.top_category THEN listing_id ELSE NULL END) AS total_listings_match_category,
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
JOIN first_page b
  ON a.visit_id = b.visit_id
  AND a.query_raw = b.query
WHERE a.top_category IS NOT NULL
GROUP BY 1,2,3
)
SELECT
top_category,
SUM(total_listings_match_category) / SUM(total_listings_page_one) pct_matches_page_one,
COUNT(DISTINCT CASE WHEN has_purchase = 1 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT query_session_id) AS conversion_rate
FROM category_match
GROUP BY 1
