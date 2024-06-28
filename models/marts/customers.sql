with

customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('orders') }}

),

customer_orders_summary as (

    select
        orders.customer_id,

        count(distinct orders.order_id) > 1 as is_repeat_buyer,
        count(distinct orders.order_id) as count_lifetime_orders,
        sum(orders.order_total) as lifetime_spend
        sum(orders.subtotal) as lifetime_spend_pretax,
        min(orders.ordered_at) as first_ordered_at,
        sum(orders.tax_paid) as lifetime_tax_paid,
        max(orders.ordered_at) as last_ordered_at,

    from orders

    group by 1

),

joined as (

    select
        customers.*,

        customer_orders_summary.lifetime_spend_pretax,
        customer_orders_summary.count_lifetime_orders,
        customer_orders_summary.lifetime_tax_paid,
        customer_orders_summary.lifetime_spend,
        customer_orders_summary.first_ordered_at,
        customer_orders_summary.last_ordered_at,

        case
            when customer_orders_summary.is_repeat_buyer then 'returning'
            else 'new'
        end as customer_type

    from customers

    left join customer_orders_summary
        on customers.customer_id = customer_orders_summary.customer_id

)

select * from joined
