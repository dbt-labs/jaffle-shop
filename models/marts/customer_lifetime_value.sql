{{ config(
    materialized='table',
    schema='marts'
) }}

with customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as total_orders,
        sum(amount) as lifetime_spend
    from {{ ref('stg_orders') }}
    group by customer_id
),

customer_metrics as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        co.first_order_date,
        co.most_recent_order_date,
        datediff(day, co.first_order_date, current_date) as customer_age_days,
        co.total_orders,
        co.lifetime_spend,
        round(co.lifetime_spend / nullif(co.total_orders, 0), 2) as avg_order_value
    from {{ ref('stg_customers') }} c
    left join customer_orders co 
        on c.customer_id = co.customer_id
)

select
    *,
    case 
        when lifetime_spend >= 1000 then 'High Value'
        when lifetime_spend >= 500 then 'Medium Value'
        else 'Low Value'
    end as customer_segment
from customer_metrics
order by lifetime_spend desc