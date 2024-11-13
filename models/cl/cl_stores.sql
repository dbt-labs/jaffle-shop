SELECT 

    /* IDs */
    id                                          AS store_id,

    /* TIMESTAMPS */
    {{ dbt.date_trunc('day', 'opened_at') }}    AS opened_date,

    /* DIMENSIONS */
    name                                        AS location,

    /* METRICS */
    tax_rate                                    AS location_tax_rate
    
FROM {{ source('dl', 'stores') }}