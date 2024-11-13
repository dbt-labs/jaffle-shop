SELECT 

    /* IDs */
    store_id,

    /* TIMESTAMPS */
    opened_date,

    /* DIMENSIONS */
    location,

    /* METRICS */
    location_tax_rate
    
FROM {{ ref('cl_stores') }}