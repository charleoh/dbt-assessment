{{ config(materialized='view', tags=["source34", "procurements"]) }}

select
  *
  , '{{ run_started_at }}'::timestamp as load_datetime
from {{ source('source_34', 'procurements_34') }}