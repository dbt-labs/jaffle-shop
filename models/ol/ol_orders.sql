SELECT 

    /* IDs */
    order_id,
    location_id,
    customer_id,

    /* TIMESTAMPS */
    ordered_at,

    /* METRICS */
    subtotal_cents / 100    AS subtotal,
    tax_paid_cents / 100    AS tax_paid,
    order_total_cents / 100 AS order_total

FROM {{ ref('cl_orders') }}