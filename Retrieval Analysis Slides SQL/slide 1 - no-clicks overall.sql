--% of no-click queries
SELECT
COUNT(DISTINCT query_session_id) / COUNT(DISTINCT _date) AS avg_visits_per_day,
COUNT(DISTINCT CASE WHEN has_click = 0 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT query_session_id) AS pct_no_click_queries,
COUNT(DISTINCT CASE WHEN has_click = 1 THEN query_session_id ELSE NULL END) / COUNT(DISTINCT query_session_id) AS pct_click_queries
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year`;

--% of no-click visits
WITH cte as (select visit_id, SUM(has_click) AS total_clicks from `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` group by 1)

SELECT
COUNT(DISTINCT a.visit_id) / COUNT(DISTINCT _date) AS avg_visits_per_day,
COUNT(DISTINCT CASE WHEN total_clicks = 0 THEN a.visit_id ELSE NULL END) / COUNT(DISTINCT a.visit_id) AS pct_no_click_visits,
COUNT(DISTINCT CASE WHEN total_clicks > 0 THEN a.visit_id ELSE NULL END) / COUNT(DISTINCT a.visit_id) AS pct_click_visits
FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` a
JOIN cte b
  ON a.visit_id = b.visit_id;