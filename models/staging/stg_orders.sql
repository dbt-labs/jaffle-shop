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
        {{ cents_to_dollars('order_total') }} as order_total,
        {{ cents_to_dollars('tax_paid') }} as tax_paid,

        ---------- timestamps
        {{ dbt.date_trunc('day','ordered_at') }} as ordered_at

    from source

)

select * from renamed
