--Overall (by query)
SELECT
MIN(_date) AS start_date,
MAX(_date) AS end_date,
COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) total_queries,
AVG(total_listings) AS avg_listings,
AVG(total_seens) AS avg_listings_seen,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS gms_per_query,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS cart_rate,
COUNT(DISTINCT CASE WHEN has_click = 0 THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS pct_no_click_queries,
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL;
--Buyers (by query)
SELECT
(CASE WHEN buyer_segment IS NULL THEN 'No Segment' ELSE buyer_segment END) AS buyer_segment,
MIN(_date) AS start_date,
MAX(_date) AS end_date,
COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) total_queries,
AVG(total_listings) AS avg_listings,
AVG(total_seens) AS avg_listings_seen,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS gms_per_query,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS cart_rate,
COUNT(DISTINCT CASE WHEN has_click = 0 THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS pct_no_click_queries,
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
LEFT JOIN `etsy-data-warehouse-prod.arizona.user_buyer_segment` c
  ON a.user_id = c.user_id
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;
--Top Category (by query)
SELECT
(CASE WHEN top_category IS NULL THEN 'No Category' ELSE top_category END) AS top_category,
MIN(_date) AS start_date,
MAX(_date) AS end_date,
COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) total_queries,
AVG(total_listings) AS avg_listings,
AVG(total_seens) AS avg_listings_seen,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS gms_per_query,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS cart_rate,
COUNT(DISTINCT CASE WHEN has_click = 0 THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS pct_no_click_queries,
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;
--Label (by query)
SELECT
(CASE WHEN label IS NULL THEN 'No Label' ELSE label END) AS label,
MIN(_date) AS start_date,
MAX(_date) AS end_date,
COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) total_queries,
AVG(total_listings) AS avg_listings,
AVG(total_seens) AS avg_listings_seen,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS gms_per_query,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS cart_rate,
COUNT(DISTINCT CASE WHEN has_click = 0 THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS pct_no_click_queries,
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;
--Bins (by query)
SELECT
(CASE WHEN bin IS NULL THEN 'No Bin' ELSE bin END) AS bin,
MIN(_date) AS start_date,
MAX(_date) AS end_date,
COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) total_queries,
AVG(total_listings) AS avg_listings,
AVG(total_seens) AS avg_listings_seen,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS gms_per_query,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS cart_rate,
COUNT(DISTINCT CASE WHEN has_click = 0 THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS pct_no_click_queries,
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;
--Platforms (by query)
SELECT
(CASE WHEN platform IS NULL THEN 'No Platform' ELSE platform END) AS platform,
MIN(_date) AS start_date,
MAX(_date) AS end_date,
COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) total_queries,
AVG(total_listings) AS avg_listings,
AVG(total_seens) AS avg_listings_seen,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS gms_per_query,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS cart_rate,
COUNT(DISTINCT CASE WHEN has_click = 0 THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS pct_no_click_queries,
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;
--Markets (by query)
WITH visit_geo AS
(
SELECT DISTINCT visit_id,
  CASE
    WHEN name IN ('United States', 'Canada', 'United Kingdom', 'Australia', 'France', 'Germany', 'India') THEN name
    ELSE 'Rest of World'
  END AS market_label
FROM `etsy-data-warehouse-prod.weblog.visits` a
LEFT JOIN `etsy-data-warehouse-prod.etsy_v2.countries` b 
  ON a.canonical_region = b.iso_country_code
WHERE _date >= '2023-05-05'
)
SELECT
market_label,
MIN(_date) AS start_date,
MAX(_date) AS end_date,
COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) total_queries,
AVG(total_listings) AS avg_listings,
AVG(total_seens) AS avg_listings_seen,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS gms_per_query,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS cart_rate,
COUNT(DISTINCT CASE WHEN has_click = 0 THEN CONCAT(a.query_raw,a.visit_id) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.query_raw,a.visit_id)) AS pct_no_click_queries,
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
JOIN visit_geo b
  ON a.visit_id = b.visit_id
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;
