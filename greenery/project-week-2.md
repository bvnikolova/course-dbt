Week 2 Project

Part 1: 
 - What is our user repeat rate?: 0.798

SQL: 
with orders as (

select user_id, count(distinct order_id) as number_orders
from stg_orders
group by 1
) 

, user_orders_count as (
select count(*) as users_all,
sum (case when number_orders >=2 then 1 else 0 end) as users_2more_orders
from orders
)

select 
users_all,
users_2more_orders,
(users_2more_orders/users_all) as repeat_rate
from user_orders_count

- Explain the product mart models you added. Why did you organize the models in the way you did?
Added two intermediate models for daily page views and daily orders by product and grouped by year, month, and day. Added one fact page view model using the 2 intermediate models to provide detailed info on the product performance.

Part 2: Tests added for uniqueness and not null values on key data. No bad data was found.

Part 3: 
Which products had their inventory change from week 1 to week 2? 4 products with DBT_VALID_TO 2023-09-23 21:34:41.981

Pothos
Philodendron
Monstera
String of pearls