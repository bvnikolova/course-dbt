{{
  config(
    materialized='table'
  )
}}


select 
pv.product_id
, pv.product_name
, pv.year 
, pv.month 
, pv.day
, pv.page_view_by_product
, po.orders_by_product
from {{ ref ('int_product_page_views') }} pv
left join {{ ref ('int_product_orders') }} po using (product_id, year,month,day)
order by year, month,day, product_id