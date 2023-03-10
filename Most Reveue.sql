# Business-Analyst---SQL

/*
Following the request above, Sheila wants to know the top 3 user’s first traffic sources that provide the most revenue in the past 3 months (current date 01 January 2023)
*/


WITH first_created_table AS(
SELECT
user_id
, MIN(created_at) first_created
, traffic_source
FROM `sql-project-376612.thelook_ecommerce.events` 
WHERE DATE(created_at) >= DATE_SUB(DATE('2023-01-01'),INTERVAL 3 MONTH)
GROUP BY 1,3
ORDER BY 1,2
)
, ranked AS(
SELECT 
fct.user_id user
,fct.first_created first_created
, fct.traffic_source traffic_source
, row_number()over(partition by fct.user_id order by fct.user_id,fct.first_created) rank_traffic
FROM first_created_table fct
)

SELECT 
ranked.traffic_source
, SUM(oi.sale_price) revenue
FROM ranked
INNER JOIN `sql-project-376612.thelook_ecommerce.order_items` oi
 ON ranked.user = oi.user_id
WHERE rank_traffic = 1
AND status = 'Complete'
GROUP BY 1
order by 2 desc
