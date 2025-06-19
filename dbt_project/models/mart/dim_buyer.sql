{{ config(
    materialized='view',
    tags=["buyer"]
) }}

select 
    *
from {{ ref('dim_buyer_history') }}
qualify ROW_NUMBER() OVER (
    PARTITION BY buyer_key
    ORDER BY date_accessed DESC
) = 1 -- Select the most recent record for each buyer