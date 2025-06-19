{{ config(materialized='view', tags=["source56", "procurements"]) }}

select
  *
  , '{{ run_started_at }}'::timestamp as load_datetime
from {{ source('source_56', 'procurements_56') }}