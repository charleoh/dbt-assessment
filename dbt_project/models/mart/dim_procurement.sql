{{ config(
    materialized='view',
    tags=["procurement"]
) }}

select 
    *
from {{ ref('dim_procurement_history') }}
where valid_to = '9999-12-31'