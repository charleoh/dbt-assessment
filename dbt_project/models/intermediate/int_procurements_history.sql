{{ config(materialized='view', tags=["procurements"]) }}

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
    regexp_replace(title, '^\d+(-\d+)?\s*-\s*', '') as cleaned_title, -- The title shouldn't have identification codes (e.g. '1-560')
    content,
    project_id,
    project_name,
    publish_date,
    publish_date_raw, 
    IF(type = 'announcement of winning bid', true, false) as is_won, -- The procurement type should be 'announcement of winning bid' to be considered won
    TRY_CAST(strptime(date_accessed, '%Y-%m-%d') AS DATE) as date_accessed,
    date_accessed as date_accessed_raw, 
    source,
    procurement_number,
    load_datetime
FROM procurements
WHERE title IS NOT NULL --- All procurements should have a title
