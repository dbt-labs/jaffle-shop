with

order_items as (

    select * from {{ ref('stg_order_items') }}

),


orders as (

    select * from {{ ref('stg_orders') }}
),

products as (

    select * from {{ ref('stg_products') }}

),

supplies as (

    select * from {{ ref('stg_supplies') }}

),

order_supplies_summary as (

    select
        product_id,
        sum(supply_cost) as supply_cost

    from supplies

    group by 1
),

joined as (
    select
        order_items.*,
        products.product_price,
        order_supplies_summary.supply_cost,
        products.is_food_item,
        products.is_drink_item,
        orders.ordered_at

    from order_items

    left join orders on order_items.order_id = orders.order_id

    left join products on order_items.product_id = products.product_id

    left join
        order_supplies_summary
        on order_items.product_id = order_supplies_summary.product_id

)

select * from joined
