# Business-Analyst---SQL

with cohort_table as(
select
user_id user_id
, MIN(date(date_trunc(created_at,month))) as cohort_month
from `sql-project-376612.thelook_ecommerce.order_items`
group by 1
)
, user_activities as(
  select oi.user_id user_id
  , date_diff(date(date_trunc(created_at,month)),cohort.cohort_month,month) month_number
  from `sql-project-376612.thelook_ecommerce.order_items` oi
  left join cohort_table cohort
   on oi.user_id = cohort.user_id
  where extract(year from cohort.cohort_month) in (2022)
  group by 1,2
)
, cohort_size as (
  SELECT 
  cohort_month
  , count(1) as num_user
  from cohort_table
  group by 1
  order by 1
)
, retention_table as (
  select
  c.cohort_month
  , a.month_number
  , count(1) num_user
  from user_activities a
  left join cohort_table c
  on a.user_id = c.user_id
  group by 1,2
)

select
rt.cohort_month
, cs.num_user cohort_size
, rt.month_number
, rt.num_user total_user
from retention_table rt
left join cohort_size cs
on rt.cohort_month = cs.cohort_month
order by 1,3
