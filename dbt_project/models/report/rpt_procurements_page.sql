{{ config(materialized='view') }}

SELECT
    dim_procurement.title as procurement_title -- Procurement Title
    , dim_procurement.publish_date as published_date -- Published date
    , dim_buyer.name as buyer_name -- Buyer name
    , winning_bids.supplier_name AS winner_bid_supplier_name -- Winner bid supplier name
    , winning_bids.value_currency AS winner_bid_currency -- Winner bid currency
    , winning_bids.value_amount AS winner_bid_value -- Winner bid value
    , COALESCE(COUNT(fct_bid.bid_key), 0) AS number_of_bids -- Number of bids
FROM {{ ref('dim_procurement') }} dim_procurement
LEFT JOIN {{ ref('dim_buyer') }} dim_buyer
    ON dim_procurement.buyer_key = dim_buyer.buyer_key
LEFT JOIN {{ ref('fct_bid') }} fct_bid
    ON dim_procurement.procurement_key = fct_bid.procurement_key
LEFT JOIN {{ ref('rpt_winning_bids') }} winning_bids
    ON fct_bid.bid_key = winning_bids.bid_key
GROUP BY
    dim_procurement.title
    , dim_procurement.publish_date
    , dim_buyer.name
    , winning_bids.supplier_name
    , winning_bids.value_currency
    , winning_bids.value_amount

