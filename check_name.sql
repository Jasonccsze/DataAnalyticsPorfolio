--1. Checking country summary for info of countries included, result: 265 rows in total
SELECT *

FROM `bigquery-public-data.world_bank_wdi.country_summary`

--Filter out unneccessary groups, result: 249
WHERE table_name NOT LIKE '%excluding high income%'
AND table_name NOT LIKE '%IDA%'
AND table_name NOT LIKE '%IBRD%'

--Filter REGION and INCOME GROUPS, result: 32
--AND region IS NULL

--Filter REGION, result: 22
--AND region IS NULL
--AND table_name NOT LIKE '%dividend%'
--AND table_name NOT LIKE '%income%'

--Filter LOCATION, result: 216
--AND income_group IS NOT NULL
