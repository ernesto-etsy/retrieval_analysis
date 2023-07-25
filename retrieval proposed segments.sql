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
