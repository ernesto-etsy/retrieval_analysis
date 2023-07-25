--Create a table that has all the data needed at the visit level (but include browsers too) to calculate
--  CVR
--  GMS and GMS / visit or GMS / impression
--  Dwell time
--  Abandonment
--  % of no click queries
WITH screenless_visits AS (
  SELECT DISTINCT visit_id,
  _date,
  case when (viewport_height = 0 or viewport_width = 0 or screen_height = 0 or screen_width = 0) and bounced = 1 then 1 else 0 end as is_screenless_bounced,
  case when (viewport_height = 0 or viewport_width = 0 or screen_height = 0 or screen_width = 0) then 1 else 0 end as is_screenless,  
  FROM `etsy-data-warehouse-prod.weblog.visits`
  WHERE _date >= current_date - 365
  AND event_source = 'web'
),
screenless_no_buy AS (
SELECT DISTINCT
a.visit_id
FROM screenless_visits a
JOIN `etsy-data-warehouse-prod.search.query_sessions_all` b
  ON a.visit_id = b.visit_id
WHERE b._date >= CURRENT_DATE() - 365
AND is_screenless = 1
AND has_purchase = 0
),
one_day_gms_attribution AS (
  SELECT visit_id,browser_id,query,
  SUM(CASE WHEN (purchased_in_visit_first_click = 1 OR purchased_in_visit_last_click = 1 OR purchased_same_day_first_click = 1 OR purchased_same_day_last_click = 1) THEN price_usd ELSE NULL END) AS same_day_gms,
  COUNT(DISTINCT listing_id) AS total_listings,
  SUM(n_seen) AS total_seens,
  MAX(page_number) AS pages_seen
  FROM `etsy-data-warehouse-prod.rollups.organic_impressions`
  --two months of data available
  WHERE _date >= '2023-05-13'
  GROUP BY 1,2,3
),
top_categories AS
(
SELECT DISTINCT taxonomy_id, top_category, full_path
FROM `etsy-data-warehouse-prod.listing_mart.listing_attributes`
)

SELECT DISTINCT
a._date,
a.visit_id,
b.browser_id,
b.user_id,
a.platform,
a.query,
a.query_raw,
a.query_session_id,
c.label,
d.bin,
classified_taxonomy_id,
g.top_category,
g.full_path
has_click,
has_cart,
has_purchase,
attributed_gms,
total_listings,
total_seens,
pages_seen,
same_day_gms,
TIMESTAMP_DIFF(b.end_datetime,b.start_datetime,SECOND) / 60.0 visit_duration_in_minutes
FROM `etsy-data-warehouse-prod.search.query_sessions_all` a
INNER JOIN (SELECT browser_id,user_id,visit_id, 
      start_datetime, end_datetime
      FROM `etsy-data-warehouse-prod.weblog.visits`
      WHERE _date >= CURRENT_DATE() - 365) b
  ON a.visit_id = b.visit_id
LEFT JOIN (SELECT query_raw, inference.label,
           RANK() OVER (PARTITION BY query_raw ORDER BY inference.confidence DESC) AS inf_rank
           FROM `etsy-data-warehouse-prod.arizona.query_intent_labels`
           ORDER BY query_raw) c
  ON a.query_raw = c.query_raw 
  AND c.inf_rank = 1
LEFT JOIN (SELECT query_raw, bin
           FROM `etsy-data-warehouse-prod.search.query_bins`) d
  ON a.query_raw = d.query_raw
LEFT JOIN screenless_no_buy e
  ON a.visit_id = e.visit_id
LEFT JOIN one_day_gms_attribution f
  ON a.visit_id = f.visit_id
  AND a.query_raw = f.query
LEFT JOIN top_categories g
  ON a.classified_taxonomy_id = g.taxonomy_id
WHERE e.visit_id IS NULL
AND a._date >= CURRENT_DATE() - 365