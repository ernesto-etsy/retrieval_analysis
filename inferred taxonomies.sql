--pull all the inferred taxonomies from a single listing id
SELECT listing_id, taxonomy_id, display_name, full_path, score
FROM `etsy-data-warehouse-prod.knowledge_base.listing_inferred_categories`
WHERE _date = CURRENT_DATE() - 1
AND listing_id = 1428983431