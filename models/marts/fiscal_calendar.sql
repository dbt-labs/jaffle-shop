with date_spine as (

    select 
        date_day,
        extract(year from date_day) as calendar_year,
        extract(week from date_day) as calendar_week

    from {{ ref('time_spine_daily') }}

),

fiscal_calendar as (

    select
        date_day,
        -- Define custom fiscal year starting in October
        case 
            when extract(month from date_day) >= 10 
                then extract(year from date_day) + 1
            else extract(year from date_day) 
        end as fiscal_year,

        -- Define fiscal weeks (e.g., shift by 1 week)
        extract(week from date_day) + 1 as fiscal_week

    from date_spine

)

select * from fiscal_calendar
