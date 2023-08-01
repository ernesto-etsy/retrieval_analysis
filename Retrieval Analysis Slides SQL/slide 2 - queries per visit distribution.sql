-- Slide 2: distribution of visits by # of queries
WITH cte AS (
  SELECT DISTINCT visit_id, query_session_id, query_raw, 
                 RANK() OVER (PARTITION BY visit_id ORDER BY start_epoch_ms ASC) AS query_rank
  FROM `etsy-data-warehouse-prod.search.query_sessions_all` a
  WHERE _date >= CURRENT_DATE() - 63
  AND query_raw <> ""
  ORDER BY 1,4
),
cte2 AS (
  SELECT
    visit_id,
    MAX(query_rank) AS total_queries_in_visit
  FROM cte
  GROUP BY 1
),
cte3 AS (
  SELECT
    total_queries_in_visit,
    COUNT(DISTINCT visit_id) AS total_visits
  FROM cte2
  GROUP BY 1
)
SELECT
  total_queries_in_visit,
  total_visits,
  total_visits * 100.0 / SUM(total_visits) OVER () AS percentage_of_total_visits
FROM cte3
ORDER BY total_visits DESC;

-- Slide 2: distribution of no-click visits by # of queries
WITH cte AS (
  SELECT DISTINCT visit_id, query_session_id, query_raw, has_click,
                 RANK() OVER (PARTITION BY visit_id ORDER BY start_epoch_ms ASC) AS query_rank,
  FROM `etsy-data-warehouse-prod.search.query_sessions_all` a
  WHERE _date >= CURRENT_DATE() - 63
  AND query_raw <> ""
  ORDER BY 1,4
),
cte2 AS (
  SELECT
    visit_id,
    MAX(query_rank) AS total_queries_in_visit,
    SUM(has_click) AS total_clicks
  FROM cte
  GROUP BY 1
),
cte3 AS (
  SELECT
    total_queries_in_visit,
    COUNT(DISTINCT visit_id) AS total_visits
  FROM cte2
  WHERE total_clicks = 0
  GROUP BY 1
)
SELECT
  total_queries_in_visit,
  total_visits,
  total_visits * 100.0 / SUM(total_visits) OVER () AS percentage_of_total_visits
FROM cte3
ORDER BY total_visits DESC
