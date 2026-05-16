
with semzero_base_customers as (

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

        count(distinct orders.order_id) as count_lifetime_orders,
        count(distinct orders.order_id) > 1 as is_repeat_buyer,
        min(orders.ordered_at) as first_ordered_at,
        max(orders.ordered_at) as last_ordered_at,
        sum(orders.subtotal) as lifetime_spend_pretax,
        sum(orders.tax_paid) as lifetime_tax_paid,
        sum(orders.order_total) as lifetime_spend

    from orders

    group by 1

),

joined as (

    select
        customers.*,

        customer_orders_summary.count_lifetime_orders,
        customer_orders_summary.first_ordered_at,
        customer_orders_summary.last_ordered_at,
        customer_orders_summary.lifetime_spend_pretax,
        customer_orders_summary.lifetime_tax_paid,
        customer_orders_summary.lifetime_spend,

        case
            when customer_orders_summary.is_repeat_buyer then 'returning'
            else 'new'
        end as customer_type

    from customers

    left join customer_orders_summary
        on customers.customer_id = customer_orders_summary.customer_id

)

select * from joined
-- SemZero dogfood no-op model change

),

semzero_customer_order_risk_features as (

    select
        *,
        case
            when count_lifetime_orders >= 3 then 'high_frequency'
            when count_lifetime_orders = 2 then 'repeat'
            when count_lifetime_orders = 1 then 'new'
            else 'unknown'
        end as semzero_customer_order_segment,

        case
            when lifetime_spend >= 100 then true
            else false
        end as semzero_high_value_customer_flag,

        coalesce(lifetime_spend, 0) - coalesce(lifetime_tax_paid, 0) as semzero_lifetime_spend_after_tax

    from semzero_base_customers

)

select *
from semzero_customer_order_risk_features
-- trigger SemZero model-change check 20260516050656
-- trigger SemZero action check 20260516053224
