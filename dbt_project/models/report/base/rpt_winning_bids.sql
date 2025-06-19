{{ config(materialized='view') }}

SELECT
    bids.bid_key,
    supplier.name as supplier_name,
    bids.value_currency,
    bids.value_amount
FROM {{ ref('fct_bid') }} bids
JOIN {{ ref('dim_supplier') }} supplier
    ON bids.supplier_key = supplier.supplier_key
JOIN {{ ref('dim_procurement') }} procurement
    ON bids.procurement_key = procurement.procurement_key
    AND procurement.is_won = true
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY bids.procurement_key
    ORDER BY value_amount ASC
) = 1
