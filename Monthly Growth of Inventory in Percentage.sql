with table_a as(
select
date_trunc(date(oi.created_at), month) month
, oi.product_id product_id
, it.product_category category
, oi.sale_price sale_price
from `sql-project-376612.thelook_ecommerce.order_items` oi
left join `sql-project-376612.thelook_ecommerce.inventory_items` it
 on oi.inventory_item_id = it.id
WHERE oi.created_at > '2022-02-01'
AND oi.status = 'Complete'
order by 1
)
, table_b as(
select 
a.month month
, a.category category
, sum(a.sale_price) total_sale_current
from table_a a
group by 1,2
order by 2,1
)
, table_c as (
select
b.category category
, b.month month
, b.total_sale_current revenue_current
, lead(b.total_sale_current)over(partition by b.category order by b.category desc,b.month desc) revenue_previous
from table_b b
)

select 
c.*
, round(((c.revenue_current-c.revenue_previous)/c.revenue_previous)*100,2) growth
from table_c c
order by c.category, c.month desc
