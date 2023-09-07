with

source as (

    select * from {{ source('ecom', 'raw_stores') }}

    -- if you generate a larger dataset,
    -- you can limit the timespan to the current time with the following line
    -- where ordered_at <= {{ var('truncate_timespan_to') }}
),

renamed as (

    select

        ----------  ids
        id as location_id,

        ---------- text
        name as location_name,

        ---------- numerics
        tax_rate,

        ---------- timestamps
        {{ dbt.date_trunc('day', 'opened_at') }} as opened_at

    from source

)

select * from renamed
