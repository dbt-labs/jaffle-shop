with

supplies as (

    select * from {{ ref('stg_supplies') }} limit 1000000

)

select * from supplies
