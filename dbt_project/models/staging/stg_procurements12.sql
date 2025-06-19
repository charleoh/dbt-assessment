{{ config(materialized='view', tags=["source12", "procurements"]) }}

select
  *
  , '{{ run_started_at }}'::timestamp as load_datetime
from {{ source('source_12', 'procurements_12') }}