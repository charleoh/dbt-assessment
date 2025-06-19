{{ config(
    materialized='view',
    tags=["supplier"]
) }}

select distinct
    supplier_hash as supplier_key,
    supplier as name,
    date_accessed,
    load_datetime
from {{ ref('int_bids_history') }}