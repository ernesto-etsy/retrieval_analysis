--Get the top 25 results for every search query in the past 90 days
SELECT DISTINCT a.visit_id,a.query,a.listing_id, position,b.top_category,a.price_usd
FROM `etsy-data-warehouse-prod.rollups.organic_impressions` a
JOIN `etsy-data-warehouse-prod.listing_mart.listing_attributes` b
  ON a.listing_id = b.listing_id
WHERE a.placement = 'search'
AND page_number = '1'
AND _date >= CURRENT_DATE() - 90
AND SAFE_CAST(position AS INT64) <= 25
ORDER BY a.visit_id, a.query, SAFE_CAST(position AS INT64)