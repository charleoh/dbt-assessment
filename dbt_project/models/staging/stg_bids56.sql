{{ config(materialized='view', tags=["source56", "bids"]) }}

select
  *
  , '{{ run_started_at }}'::timestamp as load_datetime
from {{ source('source_56', 'bids_56') }}