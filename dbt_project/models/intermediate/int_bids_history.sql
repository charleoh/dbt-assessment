{{ config(
    materialized='view',
    tags=["bids"]
) }}

{% set sources = ['12', '34', '56'] %}

{% for source_id in sources %}
    select 
        hash(supplier) as supplier_hash, 
        hash(supplier, source, procurement_number) as bid_hash,
        hash(source, procurement_number) as procurement_hash,
        supplier,
        procurement_number,
        value,
        CASE 
            WHEN regexp_matches(value, '^[^\d.,\s]+') THEN 
                regexp_extract(value, '^([^\d.,\s]+)', 1) -- capture the currency at the beginning of the value
            WHEN regexp_matches(value, '[^\d.,\s]+$') THEN 
                regexp_extract(value, '([^\d.,\s]+)$', 1) -- capture the currency at the end of the value
            ELSE NULL 
        END as value_currency, -- The bid currency should be separated in two columns.
        CAST(
            regexp_replace(
                regexp_extract(value, '([\d.,]+)', 1),  -- catch all numbers
                '[,]', '' -- remove commas
            ) AS DECIMAL(15,2)
        ) as value_amount, -- The bid value should be separated in two columns.
        TRY_CAST(strptime(date_accessed, '%Y-%m-%d') AS DATE) as date_accessed,
        date_accessed as date_accessed_raw, 
        source,
        load_datetime
    from {{ ref('stg_bids' ~ source_id) }}
    where supplier is not null -- All the bids should have a supplier name
    and value is not null -- All the bids should have a value
    
{% if not loop.last -%} union all {%- endif %}
{% endfor %}