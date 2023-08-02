--Slide 4: durations of no-clicks and click visits
WITH CTE AS (
  SELECT visit_id, visit_duration_in_minutes, SUM(has_click) AS total_clicks
  FROM `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year`
  GROUP BY 1,2
),
CTE2 AS (
SELECT
CASE
  WHEN visit_duration_in_minutes < 1 THEN 0
  WHEN visit_duration_in_minutes >= 1 AND visit_duration_in_minutes < 2 THEN 1
  WHEN visit_duration_in_minutes >= 2 AND visit_duration_in_minutes < 3 THEN 2
  WHEN visit_duration_in_minutes >= 3 AND visit_duration_in_minutes < 4 THEN 3
  WHEN visit_duration_in_minutes >= 4 AND visit_duration_in_minutes < 5 THEN 4
  WHEN visit_duration_in_minutes >= 5 AND visit_duration_in_minutes < 6 THEN 5
  WHEN visit_duration_in_minutes >= 6 AND visit_duration_in_minutes < 7 THEN 6
  WHEN visit_duration_in_minutes >= 7 AND visit_duration_in_minutes < 8 THEN 7
  WHEN visit_duration_in_minutes >= 8 AND visit_duration_in_minutes < 9 THEN 8
  WHEN visit_duration_in_minutes >= 9 AND visit_duration_in_minutes < 10 THEN 9
  WHEN visit_duration_in_minutes >= 10 AND visit_duration_in_minutes < 11 THEN 10
  WHEN visit_duration_in_minutes >= 11 AND visit_duration_in_minutes < 12 THEN 11
  WHEN visit_duration_in_minutes >= 12 AND visit_duration_in_minutes < 13 THEN 12
  WHEN visit_duration_in_minutes >= 13 AND visit_duration_in_minutes < 14 THEN 13
  WHEN visit_duration_in_minutes >= 14 AND visit_duration_in_minutes < 15 THEN 14
  WHEN visit_duration_in_minutes >= 15 AND visit_duration_in_minutes < 16 THEN 15
  WHEN visit_duration_in_minutes >= 16 AND visit_duration_in_minutes < 17 THEN 16
  WHEN visit_duration_in_minutes >= 17 AND visit_duration_in_minutes < 18 THEN 17
  WHEN visit_duration_in_minutes >= 18 AND visit_duration_in_minutes < 19 THEN 18
  WHEN visit_duration_in_minutes >= 19 AND visit_duration_in_minutes < 20 THEN 19
  WHEN visit_duration_in_minutes >= 20 AND visit_duration_in_minutes < 21 THEN 20
  WHEN visit_duration_in_minutes >= 21 AND visit_duration_in_minutes < 22 THEN 21
  WHEN visit_duration_in_minutes >= 22 AND visit_duration_in_minutes < 23 THEN 22
  WHEN visit_duration_in_minutes >= 23 AND visit_duration_in_minutes < 24 THEN 23
  WHEN visit_duration_in_minutes >= 24 AND visit_duration_in_minutes < 25 THEN 24
  WHEN visit_duration_in_minutes >= 25 AND visit_duration_in_minutes < 26 THEN 25
  WHEN visit_duration_in_minutes >= 26 AND visit_duration_in_minutes < 27 THEN 26
  WHEN visit_duration_in_minutes >= 27 AND visit_duration_in_minutes < 28 THEN 27
  WHEN visit_duration_in_minutes >= 28 AND visit_duration_in_minutes < 29 THEN 28
  WHEN visit_duration_in_minutes >= 29 AND visit_duration_in_minutes < 30 THEN 29
  WHEN visit_duration_in_minutes >= 30 AND visit_duration_in_minutes < 31 THEN 30
  WHEN visit_duration_in_minutes >= 31 AND visit_duration_in_minutes < 32 THEN 31
  WHEN visit_duration_in_minutes >= 32 AND visit_duration_in_minutes < 33 THEN 32
  WHEN visit_duration_in_minutes >= 33 AND visit_duration_in_minutes < 34 THEN 33
  WHEN visit_duration_in_minutes >= 34 AND visit_duration_in_minutes < 35 THEN 34
  WHEN visit_duration_in_minutes >= 35 AND visit_duration_in_minutes < 36 THEN 35
  WHEN visit_duration_in_minutes >= 36 AND visit_duration_in_minutes < 37 THEN 36
  WHEN visit_duration_in_minutes >= 37 AND visit_duration_in_minutes < 38 THEN 37
  WHEN visit_duration_in_minutes >= 38 AND visit_duration_in_minutes < 39 THEN 38
  WHEN visit_duration_in_minutes >= 39 AND visit_duration_in_minutes < 40 THEN 39
  WHEN visit_duration_in_minutes >= 40 THEN 40
END AS duration_bucket,
COUNT(DISTINCT CASE WHEN total_clicks = 0 THEN visit_id ELSE NULL END) no_click_visits,
COUNT(DISTINCT CASE WHEN total_clicks > 0 THEN visit_id ELSE NULL END) click_visits
FROM CTE
GROUP BY 1
ORDER BY 1
)
SELECT
  duration_bucket,
  SUM(no_click_visits) OVER (ORDER BY duration_bucket ASC) / SUM(no_click_visits) OVER () AS cumulative_percentage_of_total_visits_no_click,
  SUM(click_visits) OVER (ORDER BY duration_bucket ASC) / SUM(click_visits) OVER () AS cumulative_percentage_of_total_visits_click
FROM CTE2
ORDER BY duration_bucket;
