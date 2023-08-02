--Slide 6: Categories
SELECT
  (CASE WHEN top_category IS NULL THEN 'Unclassified' ELSE top_category END) AS top_category,
  COUNT(DISTINCT CASE WHEN has_click = 1 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT query_session_id) AS click_rate,
  COUNT(DISTINCT CASE WHEN has_cart = 1 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN query_session_id ELSE NULL END) AS post_click_cart_rate,
  COUNT(DISTINCT CASE WHEN same_day_gms > 0 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN query_session_id ELSE NULL END) AS post_click_conversion_rate,
  SUM(same_day_gms) AS total_gms,
  COUNT(DISTINCT query_session_id) AS total_queries,
  SUM(same_day_gms) / SUM(SUM(same_day_gms)) OVER () AS percentage_of_total_gms,
  COUNT(DISTINCT query_session_id) / SUM(COUNT(DISTINCT query_session_id)) OVER () AS percentage_of_total_queries,
  SUM(same_day_gms) / COUNT(DISTINCT query_session_id) AS gms_per_query,
  COUNT(DISTINCT CASE WHEN has_click = 0 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT query_session_id) AS no_click_rate
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL
GROUP BY 1;

--Classified vs. Unclassified Queries
SELECT
  (CASE WHEN classified_taxonomy_id IS NULL THEN 'Unclassified' ELSE 'Classified' END) AS taxo_classification,
  COUNT(DISTINCT CASE WHEN has_click = 1 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT query_session_id) AS click_rate,
  COUNT(DISTINCT CASE WHEN has_cart = 1 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN query_session_id ELSE NULL END) AS post_click_cart_rate,
  COUNT(DISTINCT CASE WHEN same_day_gms > 0 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN has_click = 1 THEN query_session_id ELSE NULL END) AS post_click_conversion_rate,
  SUM(same_day_gms) AS total_gms,
  COUNT(DISTINCT query_session_id) AS total_queries,
  SUM(same_day_gms) / SUM(SUM(same_day_gms)) OVER () AS percentage_of_total_gms,
  COUNT(DISTINCT query_session_id) / SUM(COUNT(DISTINCT query_session_id)) OVER () AS percentage_of_total_visits,
  SUM(same_day_gms) / COUNT(DISTINCT query_session_id) AS gms_per_query,
  COUNT(DISTINCT CASE WHEN has_click = 0 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT query_session_id) AS no_click_rate
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
WHERE total_listings IS NOT NULL
GROUP BY 1;
