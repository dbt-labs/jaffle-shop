with

source as (

    select * from {{ source('ecom', 'raw_items') }}

),

renamed as (

    select

        ----------  ids
        id as order_item_id,
        order_id,
        sku as product_id

    from source

    where order_id in (select order_id from {{ ref('stg_orders') }})
)

select * from renamed
