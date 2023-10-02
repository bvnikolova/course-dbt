{{
  config(
    materialized='view'
  )
}}

select 
product_id
,order_product_name                       
, date_part (year, order_created_at)   as year 
, date_part (month, order_created_at) as month 
, date_part (day, order_created_at)    as day
, count(distinct order_id)             as orders_by_product
from {{ ref ('fact_orders') }}
group by all
