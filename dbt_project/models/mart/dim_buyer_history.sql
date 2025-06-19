{{ config(
    materialized='view',
    tags=["buyer"]
) }}

select distinct
    buyer_hash as buyer_key,
    buyer as name,
    date_accessed,
    load_datetime
from {{ ref('int_procurements_history') }}
