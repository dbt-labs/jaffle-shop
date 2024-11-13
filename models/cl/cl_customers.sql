SELECT 

    /* IDs */
    id      AS customer_id,

    /* DIMENSIONS */
    name    AS customer_name

FROM {{ source('dl', 'customers') }}