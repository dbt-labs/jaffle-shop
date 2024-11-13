SELECT 

    /* IDs */
    {{ dbt_utils.generate_surrogate_key(['id', 'sku']) }}   AS supply_id,
    id                                                      AS supply_type_id,
    sku                                                     AS product_id,

    /* DIMENSIONS */
    name            AS supply_type_name,
    perishable      AS is_perishable,        

    /* METRICS */
    cost     AS supply_cost_cents

FROM {{ source('dl', 'supplies') }}