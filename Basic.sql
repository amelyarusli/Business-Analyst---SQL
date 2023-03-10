# Business-Analyst---SQL

/*
What is the best traffic source to get a session on thelook_ecommerce on Dec 2022?
*/

SELECT
traffic_source
, COUNT(session_id) total_traffic_source
FROM `sql-project-376612.thelook_ecommerce.events`
WHERE date(created_at) BETWEEN '2022-12-01' AND '2022-12-31'
GROUP BY 1
ORDER BY 2 DESC
