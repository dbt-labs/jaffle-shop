with

locations as (

    select * from {{ ref('stg_orders') }}

)

select * from locations
