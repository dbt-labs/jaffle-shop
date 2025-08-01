with

locations as (

    select * from {{ ref('stg_locations') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

order_items as (

    select * from {{ ref('stg_order_items') }}

),

store_orders_summary as (

    select
        orders.location_id,
        
        count(distinct orders.order_id) as total_orders,
        count(distinct orders.customer_id) as unique_customers,
        sum(orders.subtotal) as total_revenue_pretax,
        sum(orders.tax_paid) as total_tax_collected,
        sum(orders.order_total) as total_revenue,
        avg(orders.order_total) as avg_order_value,
        min(orders.ordered_at) as first_order_date,
        max(orders.ordered_at) as last_order_date

    from orders

    group by 1

),

store_item_summary as (

    select
        orders.location_id,
        
        count(order_items.order_item_id) as total_items_sold,
        sum(order_items.product_price) as total_product_revenue
        -- Missing comma here - this is the deliberate syntax error
        avg(order_items.product_price) as avg_item_price

    from order_items
    
    left join orders 
        on order_items.order_id = orders.order_id

    group by 1

),

final as (

    select
        locations.location_id,
        locations.location_name,
        locations.tax_rate,
        locations.opened_date,
        
        coalesce(store_orders_summary.total_orders, 0) as total_orders,
        coalesce(store_orders_summary.unique_customers, 0) as unique_customers,
        coalesce(store_orders_summary.total_revenue_pretax, 0) as total_revenue_pretax,
        coalesce(store_orders_summary.total_tax_collected, 0) as total_tax_collected,
        coalesce(store_orders_summary.total_revenue, 0) as total_revenue,
        coalesce(store_orders_summary.avg_order_value, 0) as avg_order_value,
        
        coalesce(store_item_summary.total_items_sold, 0) as total_items_sold,
        coalesce(store_item_summary.avg_item_price, 0) as avg_item_price,
        
        store_orders_summary.first_order_date,
        store_orders_summary.last_order_date,
        
        case 
            when store_orders_summary.total_orders > 100 then 'high_volume'
            when store_orders_summary.total_orders > 50 then 'medium_volume'
            when store_orders_summary.total_orders > 0 then 'low_volume'
            else 'no_orders'
        end as store_category

    from locations

    left join store_orders_summary
        on locations.location_id = store_orders_summary.location_id
        
    left join store_item_summary
        on locations.location_id = store_item_summary.location_id

)

select * from final 