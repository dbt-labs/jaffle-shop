SELECT 

    /* IDs */
    supply_id,
    supply_type_id,
    product_id,

    /* DIMENSIONS */
    supply_type_name,
    is_perishable,        

    /* METRICS */
    supply_cost_cents / 100 AS cost

FROM {{ ref('cl_supplies') }}