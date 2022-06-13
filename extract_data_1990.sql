--## Extracting countries' names and region, indicators' names, values of metrics within target range of years
SELECT country.region, country.table_name, indicator.year, indicator.indicator_name, indicator.value

FROM `bigquery-public-data.world_bank_wdi.country_summary` AS country

--Joining indicators data table for values of metrics
LEFT JOIN `bigquery-public-data.world_bank_wdi.indicators_data` AS indicator
  ON country.country_code = indicator.country_code

WHERE
  --Filtering OUT unnecessary groups
  country.table_name NOT LIKE '%excluding high income%'
  AND country.table_name NOT LIKE '%IDA%'
  AND country.table_name NOT LIKE '%IBRD%'

  --Use 1 of 3 filters depending on data availability
  --1. Filtering LOCATION and REGION
  AND (country.income_group IS NOT NULL
  OR country.region IS NULL)

  --2. Filtering LOCATION
  --  AND country.income_group IS NOT NULL

  --3. Filtering REGION and INCOME GROUP
  --  AND country.region IS NULL
  
  --Getting values from indicators
  AND
  (
    indicator_code = 'NY.GDP.PCAP.CD' --GDP per capita (current US$)
    OR
    indicator_code = 'NY.GDP.MKTP.CD' --GDP (current US$)
    OR
    indicator_code = 'EN.ATM.CO2E.PC' --CO2 emission (metric tons per capita) (to 2018)
    OR
    indicator.indicator_code = 'SE.ADT.1524.LT.ZS' --literacy rate of ages 15-24
  ) 
  
  --Getting target range of years
  AND
  indicator.year BETWEEN 1990 AND 2020
