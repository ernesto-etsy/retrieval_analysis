--Price data overall
SELECT
AVG(price_usd) AS avg_impression_price,
AVG(CASE WHEN n_clicked > 0 THEN price_usd ELSE NULL END) AS avg_click_price,
AVG(CASE WHEN (purchased_in_visit_first_click > 0 OR purchased_in_visit_last_click > 0 OR purchased_same_day_first_click > 0 OR purchased_same_day_last_click > 0) THEN price_usd ELSE NULL END) AS avg_purchase_price,
FROM `etsy-data-warehouse-prod.rollups.organic_impressions` a
WHERE _date >= CURRENT_DATE() - 63
AND placement = 'search';

--Price data by platform
SELECT
platform,
AVG(price_usd) AS avg_impression_price,
AVG(CASE WHEN n_clicked > 0 THEN price_usd ELSE NULL END) AS avg_click_price,
AVG(CASE WHEN (purchased_in_visit_first_click > 0 OR purchased_in_visit_last_click > 0 OR purchased_same_day_first_click > 0 OR purchased_same_day_last_click > 0) THEN price_usd ELSE NULL END) AS avg_purchase_price,
FROM `etsy-data-warehouse-prod.rollups.organic_impressions` a
WHERE _date >= CURRENT_DATE() - 63
AND placement = 'search'
GROUP BY 1;