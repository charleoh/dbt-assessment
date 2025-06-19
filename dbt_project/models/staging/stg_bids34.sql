{{ config(materialized='view', tags=["source34", "bids"]) }}

select
  *
  , '{{ run_started_at }}'::timestamp as load_datetime
from {{ source('source_34', 'bids_34') }}