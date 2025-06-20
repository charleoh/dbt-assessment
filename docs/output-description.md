# Output description

## Introduction
The output of our pipelines are used by a different team to build our platform.
Use the description below, provided by the consumer team regarding how the data will be used and what are the expected outputs.
**Keep in mind that the description / input is not an exhaustive list on all the quality checks we must perform. It is a good starting point and 'minimum' requirements, however additional validations are usually needed.**


## Description

The data will enable two use cases in our platform:

#### 1 - Procurements page
This will be a page containing a table with all procurements that we can display.
The following information will be present in the table:
- Procurement Title
- Published date
- Buyer
- Number of bids
- Winner bid supplier name
- Winner bid value

Filters to narrow-down the search will also be available in the page.

#### 2 - Enrichment on the company profile page
The platform has a page for each company with details such as its operating status or website.
On this page, a table with all procurements the given company participated in (bidded on) will be presented.
The procurements this company has won will be flagged in this UI.


For this, we need two tables as output:
1 - A table that contains one procurement per row, also containing information about the bids.
2 - A table that allows to easily filter-down all procurements a given company participated in (bidded on).

As for the requisites:
- All procurements should have a title
- The title shouldn't have identification codes (e.g. '1-560')
- All the bids should have a supplier name
- The bid value and currency should be separated in two columns.
