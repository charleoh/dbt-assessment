{{ config(materialized='view') }}

SELECT
    dim_supplier.name as supplier_name -- Supplier Name
    , dim_buyer.name as buyer_name -- Buyer name
    , dim_procurement.publish_date as published_date -- Published date
    , dim_procurement.title as procurement_title -- Procurement Title
    , dim_procurement.content as procurement_content -- Procurement content
    , dim_procurement.project_id as project_id -- Project ID
    , dim_procurement.project_name as project_name -- Project Name
    , IF(winning_bids.bid_key IS NOT NULL, true, false) AS is_winner -- Is Winner
    , winning_bids.value_currency AS winner_bid_currency -- Winner bid currency
    , winning_bids.value_amount AS winner_bid_value -- Winner bid value
FROM {{ ref('dim_supplier') }} dim_supplier
LEFT JOIN {{ ref('fct_bid') }} fct_bid
    ON fct_bid.supplier_key = dim_supplier.supplier_key
LEFT JOIN {{ ref('dim_procurement') }} dim_procurement
    ON fct_bid.procurement_key = dim_procurement.procurement_key
LEFT JOIN {{ ref('dim_buyer') }} dim_buyer
    ON dim_procurement.buyer_key = dim_buyer.buyer_key

LEFT JOIN {{ ref('rpt_winning_bids') }} winning_bids
    ON fct_bid.bid_key = winning_bids.bid_key


