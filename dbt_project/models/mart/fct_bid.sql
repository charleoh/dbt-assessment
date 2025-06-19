{{ config(
    materialized='view',
    tags=["bid"]
) }}

select 
    *
from {{ ref('fct_bid_history') }}
where valid_to = '9999-12-31'