SELECT 

    /* IDs */
    customer_id,

    /* DIMENSIONS */
    customer_name,

FROM {{ ref('cl_customers') }}
