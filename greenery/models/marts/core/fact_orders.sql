{{
  config(
    materialized='table'
  )
}}

SELECT 
    o.order_id
    , pr.product_id
    , pr. name                as order_product_name
    , pr.price                as order_product_price
    , oi.quantity             as order_product_quantity   
    , o.created_at            as order_created_at
    , o.order_cost
    , o.shipping_cost         as order_shipping_cost
    , o.order_total 
    , o.tracking_id           as order_tracking_id
    , o.shipping_service      as order_shipping_service
    , o.estimated_delivery_at as order_estimated_delivery_at
    , o.delivered_at          as order_delivered_at
    , o.status                as order_status
    , p.promo_id
    , p.discount              as promo_discount
    , p.status                as promo_status
    , o.user_id
    , a.address_id
    , a.address       
    , a.zipcode       
    , a.state         
    , a.country        

FROM {{ ref ('stg_orders') }} o
INNER JOIN {{ ref ('stg_order_items') }} oi on o.order_id = oi.order_id
INNER JOIN {{ ref ('stg_products') }} pr on oi.product_id = pr.product_id
INNER JOIN {{ ref ('stg_users') }} u on o.user_id = u.user_id
LEFT JOIN {{ ref ('stg_addresses') }} a on u.address_id = a.address_id
LEFT JOIN {{ ref ('stg_promos') }} p on o.promo_id = p.promo_id
order by o.order_id, o.created_at
