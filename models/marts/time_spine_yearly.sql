{{
    config(
        materialized = 'table',
    )
}}

with years as (

    {{
        dbt.date_spine(
            'year',
            "to_date('01/01/2000','mm/dd/yyyy')",
            "to_date('01/01/2025','mm/dd/yyyy')"
        )
    }}

),

final as (
    select cast(date_year as date) as date_year
    from years
)

select * from final
-- filter the time spine to a specific range
where date_year >= date_trunc('year', dateadd(year, -4, current_timestamp())) 
  and date_year < date_trunc('year', dateadd(year, 1, current_timestamp()))
