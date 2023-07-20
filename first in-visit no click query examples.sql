--Examples of first in-visit queries with no click (last two months of data)
WITH cte AS (
SELECT DISTINCT visit_id, a.query_raw, RANK() OVER (PARTITION BY visit_id ORDER BY start_epoch_ms ASC) AS query_rank
FROM `etsy-data-warehouse-prod.search.query_sessions_all` a
WHERE _date >= CURRENT_DATE() - 63
AND query_raw <> ""
ORDER BY 1,3
)
SELECT
a.query_raw,
label,
bin,
platform,
CONCAT("https://www.etsy.com/search?q=",a.query_raw,"&ref=search_bar") AS hyperlink,
AVG(total_listings) AS avg_unique_impressions,
COUNT(*) AS total_instances
FROM cte a
JOIN `etsy-data-warehouse-dev.ecanales.retrieval_search_data_one_year` b
  ON a.visit_id = b.visit_id
  AND a.query_raw = b.query_raw
WHERE query_rank = 1
AND has_click = 0
GROUP BY 1,2,3,4
ORDER BY 7 DESC