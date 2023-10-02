{{
  config(
    materialized='table'
  )
}}

with session_timing_add as (
select session_id,
min (created_at) as session_started_at,
max (created_at) as session_ended_at
from {{ ref ('stg_events') }} 
group by 1
)

{% set event_types = dbt_utils.get_column_values(
table=ref('stg_events'),
column='event_type')
%}


select 
e.session_id,
e.user_id,
coalesce (e.product_id, oi.product_id) as product_id,
session_started_at,
session_ended_at,
{% for event_type in event_types %}
{{ sum_of('e.event_type', event_type) }} as {{event_type}}s,
{% endfor %}
datediff('minute', session_started_at, session_ended_at) as session_length_minutes
from {{ ref ('stg_events') }}  e
left join {{ ref ('stg_order_items') }} oi 
          on oi.order_id = e.order_id
left join session_timing_add s 
          on s.session_id = e.session_id
group by 1,2,3,4,5
