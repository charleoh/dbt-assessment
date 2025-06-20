{{ config(
    materialized='incremental',
    unique_key='procurement_hash',
    tags=["procurements"]
) }}

WITH procurements12 AS (
    select 
        id,
        type,
        buyer,
        title,
        NULL AS content,
        project_id,
        NULL AS project_name,
        TRY_CAST(strptime(publish_date, '%m/%d/%Y') AS DATE) as publish_date,
        publish_date as publish_date_raw, 
        date_accessed,
        source,
        procurement_number,
        load_datetime
    from {{ ref('stg_procurements12') }}
    {% if is_incremental() %}
        -- Only process records newer than what's already in the table
        where load_datetime > (select max(load_datetime) from {{ this }} where source = 12)
    {% endif %}

), procurements34 AS (
    select 
        id,
        type,
        buyer,
        title,
        NULL as content,
        project_identity AS project_id,
        project_name,
        TRY_CAST(strptime(publish_date, '%m/%d/%Y') AS DATE) as publish_date,
        publish_date as publish_date_raw, 
        date_accessed,
        source,
        procurement_number,
        load_datetime
    from {{ ref('stg_procurements34') }}
    {% if is_incremental() %}
        where load_datetime > (select max(load_datetime) from {{ this }}  where source = 34)
    {% endif %}
    

), procurements56 AS (
    select 
        id,
        type,
        buyer,
        title,
        content,
        project_id,
        NULL as project_name,
        TRY_CAST(strptime(publish_date, '%m/%d/%Y') AS DATE) as publish_date,
        publish_date as publish_date_raw, 
        date_accessed,
        source,
        procurement_number,
        load_datetime
    from {{ ref('stg_procurements56') }}
    {% if is_incremental() %}
        where load_datetime > (select max(load_datetime) from {{ this }}  where source = 56)
    {% endif %}
    

), procurements AS (
    SELECT * FROM procurements12
    UNION ALL
    SELECT * FROM procurements34
    UNION ALL
    SELECT * FROM procurements56
)
SELECT
    id,  
    hash(source, procurement_number) as procurement_hash,
    type,
    hash(buyer) as buyer_hash,
    buyer,
    title,
    regexp_replace(title, '^\d+(-\d+)?\s*-\s*', '') as cleaned_title,
    content,
    project_id,
    project_name,
    publish_date,
    publish_date_raw, 
    IF(type = 'announcement of winning bid', true, false) as is_won,
    TRY_CAST(strptime(date_accessed, '%Y-%m-%d') AS DATE) as date_accessed,
    date_accessed as date_accessed_raw, 
    source,
    procurement_number,
    load_datetime
FROM procurements
WHERE title IS NOT NULL