SELECT 

    /* IDs */
    id          AS order_id,
    store_id    AS location_id,
    customer    AS customer_id,

    /* TIMESTAMPS */
    ordered_at,

    /* METRICS */
    subtotal    AS subtotal_cents,
    tax_paid    AS tax_paid_cents,
    order_total AS order_total_cents

FROM {{ source('dl', 'orders') }}