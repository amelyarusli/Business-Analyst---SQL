# Business-Analyst---SQL

/*
 Which category faced lowest % (most shrinking) in terms of order number with status shipped on Dec 2022 compared to previous month?
*/

with order_nov22 AS(
  SELECT  
  EXTRACT(MONTH FROM oi.created_at) month
  , EXTRACT(YEAR FROM oi.created_at) year
  , product.category
  , COUNT(oi.order_id) total_order_nov
  FROM `sql-project-376612.thelook_ecommerce.order_items` oi
  left join  `sql-project-376612.thelook_ecommerce.products` product
    ON oi.product_id = product.id
  WHERE EXTRACT(YEAR FROM oi.created_at) IN (2022)
  AND EXTRACT(MONTH FROM oi.created_at) IN (11)
  AND UPPER(oi.status) = 'SHIPPED'
  GROUP BY 1,2,3
  ORDER BY 1 DESC
),
order_des22 AS(
  SELECT  
  EXTRACT(MONTH FROM oi.created_at) month_des
  , EXTRACT(YEAR FROM oi.created_at) year_des
  , product.category
  , COUNT(oi.order_id) total_order_des
  FROM `sql-project-376612.thelook_ecommerce.order_items` oi
  left join  `sql-project-376612.thelook_ecommerce.products` product
    ON oi.product_id = product.id
  WHERE EXTRACT(YEAR FROM oi.created_at) IN (2022)
  AND EXTRACT(MONTH FROM oi.created_at) IN (12)
  AND UPPER(oi.status) = 'SHIPPED'
  GROUP BY 1,2,3
  ORDER BY 1 DESC
)

SELECT 
des.category
, ROUND(((total_order_des-total_order_nov)/total_order_nov)*100,2) growth
FROM order_nov22 nov
INNER JOIN order_des22 des
 ON nov.category = des.category
ORDER BY 2 
