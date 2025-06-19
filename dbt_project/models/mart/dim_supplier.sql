{{ config(
    materialized='view',
    tags=["supplier"]
) }}

select 
    *
from {{ ref('dim_supplier_history') }}
qualify ROW_NUMBER() OVER (
    PARTITION BY supplier_key
    ORDER BY date_accessed DESC
) = 1 -- Select the most recent record for each supplier