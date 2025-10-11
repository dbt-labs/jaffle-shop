with

source as (

    select * from {{ source('ecom', 'raw_orders') }}

),

renamed as (

    select

        ----------  ids
        id as order_id,
        store_id as location_id,
        customer as customer_id,

        ---------- numerics
        subtotal as subtotal_cents,
        tax_paid as tax_paid_cents,
        order_total as order_total_cents,
        {{ function('cents_to_dollars') }}(subtotal) as subtotal,
        {{ function('cents_to_dollars') }}(tax_paid) as tax_paid,
        {{ function('cents_to_dollars') }}(order_total) as order_total,

        ---------- timestamps
        {{ dbt.date_trunc('day','ordered_at') }} as ordered_at,
        {{ function("add_days") }}(ordered_at, 7) as estimated_delivery_date

    from source

)

select * from renamed
