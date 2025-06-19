{{ config(materialized='view', tags=["source12", "bids"]) }}

select
  *
  , '{{ run_started_at }}'::timestamp as load_datetime
from {{ source('source_12', 'bids_12') }}