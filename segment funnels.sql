--Buyers (by visit)
SELECT
(CASE WHEN buyer_segment IS NULL THEN 'No Segment' ELSE buyer_segment END) AS buyer_segment,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT a.visit_id) AS gms_per_visit,
COUNT(DISTINCT CASE WHEN has_click = 1 THEN a.visit_id ELSE NULL END) / COUNT(DISTINCT a.visit_id) AS click_rate,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN a.visit_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN a.visit_id ELSE NULL END) AS post_click_cart_rate,
COUNT(DISTINCT CASE WHEN same_day_gms > 0 THEN visit_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN a.visit_id ELSE NULL END) AS post_click_conversion_rate
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
LEFT JOIN `etsy-data-warehouse-prod.arizona.user_buyer_segment` c
  ON a.user_id = c.user_id
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;

--Categories (by query)
SELECT
(CASE WHEN top_category IS NULL THEN 'No Category' ELSE top_category END) AS top_category,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT CONCAT(a.visit_id,a.query_raw)) AS gms_per_query,
COUNT(DISTINCT CASE WHEN has_click = 1 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.visit_id,a.query_raw)) AS click_rate,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) AS post_click_cart_rate,
COUNT(DISTINCT CASE WHEN same_day_gms > 0 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) AS post_click_conversion_rate
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;

--Platforms (by visit)
SELECT
(CASE WHEN platform IS NULL THEN 'No Platform' ELSE platform END) AS platform,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT a.visit_id) AS gms_per_visit,
COUNT(DISTINCT CASE WHEN has_click = 1 THEN a.visit_id ELSE NULL END) / COUNT(DISTINCT a.visit_id) AS click_rate,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN a.visit_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN a.visit_id ELSE NULL END) AS post_click_cart_rate,
COUNT(DISTINCT CASE WHEN same_day_gms > 0 THEN visit_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN a.visit_id ELSE NULL END) AS post_click_conversion_rate
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;

--Bins (by visit)
SELECT
(CASE WHEN bin IS NULL THEN 'No Bin' ELSE bin END) AS bin,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT CONCAT(a.visit_id,a.query_raw)) AS gms_per_query,
COUNT(DISTINCT CASE WHEN has_click = 1 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.visit_id,a.query_raw)) AS click_rate,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) AS post_click_cart_rate,
COUNT(DISTINCT CASE WHEN same_day_gms > 0 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) AS post_click_conversion_rate
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;

--Labels (by query)
SELECT
(CASE WHEN label IS NULL THEN 'No Label' ELSE label END) AS label,
SUM(same_day_gms) AS total_gms,
SUM(same_day_gms) / COUNT(DISTINCT CONCAT(a.visit_id,a.query_raw)) AS gms_per_query,
COUNT(DISTINCT CASE WHEN has_click = 1 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) / COUNT(DISTINCT CONCAT(a.visit_id,a.query_raw)) AS click_rate,
COUNT(DISTINCT CASE WHEN has_cart = 1  THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) AS post_click_cart_rate,
COUNT(DISTINCT CASE WHEN same_day_gms > 0 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN CONCAT(a.visit_id,a.query_raw) ELSE NULL END) AS post_click_conversion_rate
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;
