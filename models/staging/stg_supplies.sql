with

source as (

    select * from {{ source('ecom', 'raw_supplies') }}

),

renamed as (

    select

        ----------  ids
        {{ dbt_utils.generate_surrogate_key(['id', 'sku']) }} as supply_uuid,
        id as supply_id,
        sku as product_id,


        ---------- numerics
        (cost / 100) as supply_cost,

        ---------- text
        name as supply_name,
        ---------- booleans
        perishable as is_perishable_supply

    from source

)

select * from renamed
