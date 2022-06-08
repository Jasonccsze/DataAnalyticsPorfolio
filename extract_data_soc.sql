--## Extracting countries' codes, names, and region, indicators' codes and names, values of metrics within target range of years
SELECT country.country_code, country.table_name, country.region, indicator.indicator_code, indicator.indicator_name, indicator.year, indicator.value

FROM `bigquery-public-data.world_bank_wdi.country_summary` AS country

--Joining indicators data table for values of metrics
LEFT JOIN `bigquery-public-data.world_bank_wdi.indicators_data` AS indicator
  ON country.country_code = indicator.country_code

WHERE
  --Filtering OUT unnecessary groups, result: 249
  country.table_name NOT LIKE '%excluding high income%'
  AND country.table_name NOT LIKE '%IDA%'
  AND country.table_name NOT LIKE '%IBRD%'

  --Use 1 of 3 filters depending on data availability
  --1. Filtering LOCATION and REGION
  AND (country.income_group IS NOT NULL
  OR country.region IS NULL)

  --2. Filtering LOCATION, result: 216
  --  AND country.income_group IS NOT NULL

  --3. Filtering REGION and INCOME GROUP, result: 20
  --  AND country.region IS NULL
  
  --Getting values from indicators
  AND
  (
    indicator_code = 'SL.TLF.ACTI.1524.ZS' --Labor force participation rate for ages 15-24, total (%) (modeled ILO estimate)
    OR
    indicator_code = 'SL.TLF.CACT.ZS' --Labor force participation rate, total (% of total population ages 15+) (modeled ILO estimate)
    OR
    indicator_code = 'SL.TLF.BASC.ZS' --Labor force with basic education (% of total working-age population with basic education)
    OR
    indicator_code = 'SL.UEM.NEET.ZS' --Share of youth not in education, employment or training, total (% of youth population)
  ) 
  
  --Getting target range of years
  AND
  indicator.year BETWEEN 2011 AND 2020
