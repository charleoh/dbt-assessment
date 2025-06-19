{{ config(
    materialized='view',
) }}

select distinct
    id,
    procurement_hash as procurement_key,
    cleaned_title as title,
    content,
    project_id,
    project_name,
    buyer_hash as buyer_key,
    publish_date,
    is_won,
    date_accessed,
    source,
    load_datetime,
    coalesce(publish_date, date_accessed) as valid_from,
    coalesce(lead(coalesce(publish_date, date_accessed)) OVER (
        PARTITION BY procurement_hash
        ORDER BY date_accessed ASC
    ), DATE '9999-12-31') as valid_to
from {{ ref('int_procurements_history') }}
