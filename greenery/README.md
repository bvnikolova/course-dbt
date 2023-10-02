What is our overall conversion rate? 62.4%
Conversion rate is defined as the # of unique sessions with a purchase event / total number of unique sessions. 

SQL:
select 
   count(distinct case when checkouts > 0 then session_id end) / count(distinct session_id) as conversion_rate
from fact_product_events


What is our conversion rate by product?
Conversion rate by product is defined as the # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product

SQL:
select 
pe.product_id,
p.name as product_name,
count(distinct case when pe.checkouts > 0 then session_id end) / count(distinct pe.session_id) as conversion_rate
from fact_product_events as pe
left join stg_products as p on p.product_id = pe.product_id
group by 1,2