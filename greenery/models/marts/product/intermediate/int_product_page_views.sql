{{
  config(
    materialized='view'
  )
}}

select 
e.product_id
,p.name                          as product_name
, date_part (year, e.created_at) as year 
, date_part (month, e.created_at)as month 
, date_part (day, e.created_at)  as day
, count(e.session_id)              as page_view_by_product
from  {{ ref ('stg_events') }}  e
inner join {{ ref ('stg_products') }} p on e.product_id = p.product_id
where e.event_type = 'page_view'
group by all