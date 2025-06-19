{{ config(
    materialized='view',
) }}

select 
    supplier_hash as supplier_key,
    bid_hash as bid_key, 
    procurement_hash as procurement_key,
    value_currency,
    value_amount,
    date_accessed,
    source,
    load_datetime,
    date_accessed as valid_from,
    coalesce(lead(date_accessed) OVER (
        PARTITION BY bid_hash
        ORDER BY date_accessed ASC, value_amount DESC, load_datetime ASC
    ), DATE '9999-12-31') as valid_to
from {{ ref('int_bids_history') }}
