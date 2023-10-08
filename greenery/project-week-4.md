Part 1. dbt Snapshots

Which products had their inventory change from week 3 to week 4? 
- Pothos, Philodendron, Bamboo,ZZ Plant, Monstera,String of pearls
 
 SQL:
select * from product_snapshot
where date_trunc (week, dbt_valid_to) = date_trunc (week, current_date)
order by product_id, dbt_updated_at

 Can you use the inventory changes to determine which products had the most fluctuations in inventory?
 Did we have any items go out of stock in the last 3 weeks? 
 - Pothos, String of pearls

 SQL:

    select * from product_snapshot
    where product_id in (
       select product_id from product_snapshot
       group by 1
       having count(1)>1) and inventory = 0
    order by product_id, dbt_valid_from      


Part 2. Modeling challenge

SQL:

select 
pe.product_id,
p.name as product_name,
count(distinct case when pe.page_views > 0 then session_id end) as page_views,
count(distinct case when pe.add_to_carts > 0 then session_id end) as add_to_carts,
count(distinct case when pe.checkouts > 0 then session_id end) as checkouts
from fact_product_events as pe
left join stg_products as p on p.product_id = pe.product_id
group by 1,2
order by p.name

Part 3: Reflection questions
If your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?

- I would recommend adding exposures
