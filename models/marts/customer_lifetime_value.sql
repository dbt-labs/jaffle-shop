{{ config(
    materialized='table',
    schema='marts'
) }}

-- Customer Lifetime Value Mart Model
-- Purpose: Enriches customer data with lifetime metrics and segmentation

with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

customer_orders_summary as (
    select
        customer_id,
        count(*) as lifetime_order_count,
        min(ordered_at) as first_order_at,
        max(ordered_at) as last_order_at,
        sum(order_total) as lifetime_spend
    from orders
    group by 1
)

select
    c.*,
    cos.lifetime_order_count,
    cos.first_order_at,
    cos.last_order_at,
    cos.lifetime_spend,
    datediff('day', cos.first_order_at, current_date) as days_as_customer,
    
    case 
        when cos.lifetime_spend >= 1000 then 'High Value'
        when cos.lifetime_spend >= 500 then 'Medium Value'
        else 'Low Value'
    end as customer_segment

from customers c
left join customer_orders_summary cos 
    on c.customer_id = cos.customer_id