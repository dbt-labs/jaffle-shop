{{ config(
    materialized = 'table'
) }}

with minutes as (

    {{
        dbt.date_spine(
            'minute',
            "to_date('01/01/2024','mm/dd/yyyy')",
            "to_date('01/02/2024','mm/dd/yyyy')"
        )
    }}

),

final as (
    select cast(date_minute as timestamp) as date_minute
    from minutes
)

select * from final
-- filter the time spine to a specific range
where date_minute > dateadd(day, -1, current_timestamp()) 
and date_minute < dateadd(day, 1, current_timestamp())
