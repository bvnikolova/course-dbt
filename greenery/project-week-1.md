Questions and Answers Week 1 dbt project

1. How many users do we have?
Answer: We have 130 users

SQL:
select count(*) from stg_users 

2. On average, how many orders do we receive per hour? 
Answer: We receive per hour 7:52 orders

SQL:
Select
DATE_PART(YEAR, created_at) as Year,
DATE_PART(MONTH, created_at) as Month, 
DATE_PART(DAY, created_at) as Day,   
DATE_PART(HOUR, created_at) as Hour,
Count(*) as Total_Order_Per_Hour,
AVG(COUNT(*)) OVER () AS average_orders_per_hour
from stg_orders
group by 
DATE_PART(YEAR, created_at),
DATE_PART(MONTH, created_at), 
DATE_PART(DAY, created_at) ,   
DATE_PART(HOUR, created_at)
order by 
DATE_PART(YEAR, created_at),
DATE_PART(MONTH, created_at), 
DATE_PART(DAY, created_at) ,   
DATE_PART(HOUR, created_at)


3. On average, how long does an order take from being placed to being delivered? 
Answer: It takes 3.89 days (or 93.4 hours) on average for an order to be delivered

SQL:
SELECT
    AVG(DATEDIFF(DAY, created_at, delivered_at)) AS average_delivery_time_days,
    AVG(DATEDIFF(HOUR, created_at, delivered_at)) AS average_delivery_time_hours
FROM
    stg_orders
WHERE
    delivered_at IS NOT NULL;

4. How many users have only made one purchase? Two purchases? Three+ purchases? 
Answer: We have 25 users made only 1 purchase, 28 users made 2 purchases, 71 users made 3+ purchases

SQL:
SELECT
    CASE
        WHEN num_purchases = 1 THEN '1 purchase'
        WHEN num_purchases = 2 THEN '2 purchases'
        ELSE '3+ purchases'
    END AS purchase_group,
    COUNT(*) AS user_count
FROM (
    SELECT
        user_id,
        COUNT(DISTINCT order_id) AS num_purchases
    FROM
        stg_orders
    GROUP BY
        user_id
) AS purchase_counts
GROUP BY
    purchase_group
ORDER BY
    purchase_group;


5. On average, how many unique sessions do we have per hour?
Answer: We have 16.327 unique sessions per hour on average

SQL:

with sessions_per_hour as (select date_trunc('hour',created_at) session_hour, 
count(distinct session_id) sessions from stg_events group by 1 )

select avg(sessions) as avg_sessions from sessions_per_hour