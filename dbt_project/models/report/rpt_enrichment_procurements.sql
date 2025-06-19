{{ config(materialized='view') }}

with bids_agg as (
    select 
        procurement_key,
        ARRAY_AGG(fct_bid.bid_key) as bid_keys,
        ARRAY_AGG(fct_bid.supplier_key) as supplier_keys,
        ARRAY_AGG(dim_supplier.name) as supplier_names,
        MIN(fct_bid.value_amount)::DECIMAL(15,2) as min_bid_value, -- Minimum bid value
        MAX(fct_bid.value_amount)::DECIMAL(15,2) as max_bid_value, -- Maximum bid value
        AVG(fct_bid.value_amount)::DECIMAL(15,2) as avg_bid_value, -- Average bid value
        MEDIAN(fct_bid.value_amount)::DECIMAL(15,2) as median_bid_value, -- Median bid value
        COUNT(fct_bid.bid_key) as bid_count -- Total number of bids
    from {{ ref('fct_bid') }} fct_bid
    LEFT JOIN {{ ref('dim_supplier') }} dim_supplier
        ON fct_bid.supplier_key = dim_supplier.supplier_key
    GROUP BY procurement_key
)

SELECT
    dim_procurement.title as procurement_title -- Procurement Title
    , dim_procurement.publish_date as published_date -- Published date
    , dim_buyer.name as buyer_name -- Buyer name
    , dim_procurement.project_id as project_id -- Project ID
    , dim_procurement.project_name as project_name -- Project Name
    , dim_procurement.is_won as is_won -- Is the procurement won
    , bids_agg.bid_keys as bid_keys -- List of bid keys
    , bids_agg.supplier_keys as supplier_keys -- List of supplier keys
    , bids_agg.supplier_names as supplier_names -- List of supplier names
    , bids_agg.min_bid_value as min_bid_value -- Minimum bid value
    , bids_agg.max_bid_value as max_bid_value -- Maximum bid value
    , bids_agg.avg_bid_value as avg_bid_value -- Average bid value
    , bids_agg.median_bid_value as median_bid_value -- Median bid value
    , COALESCE(bids_agg.bid_count, 0) as number_of_bids -- Total number of bids
FROM {{ ref('dim_procurement') }} dim_procurement
LEFT JOIN {{ ref('dim_buyer') }} dim_buyer
    ON dim_procurement.buyer_key = dim_buyer.buyer_key
LEFT JOIN bids_agg
    ON dim_procurement.procurement_key = bids_agg.procurement_key


