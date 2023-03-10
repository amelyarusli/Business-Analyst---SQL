# Business-Analyst---SQL

/*
To understand which categories is the best sellers amongs all, Please find the categories that generate the most sales price with status shipped on Dec 2022?
*/

SELECT oi.status
, oi.product_id
, oi.shipped_at
, prod.category
, oi.sale_price
FROM `sql-project-376612.thelook_ecommerce.order_items` oi
left join`sql-project-376612.thelook_ecommerce.products` prod
ON oi.product_id=prod.id
WHERE status = 'Shipped' 
and shipped_at BETWEEN '2022-12-01' and '2022-12-31'
ORDER BY sale_price DESC
LIMIT 1
