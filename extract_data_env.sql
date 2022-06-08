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

  --3. Filtering REGION, result: 20
  --  AND country.region IS NULL
  
  --Getting values from indicators
  AND
  (
    indicator_code = 'SP.URB.TOTL.IN.ZS' --urban population %
    OR
    indicator_code = 'AG.YLD.CREL.KG' --cereal yield (kg per hectare)
    OR
    indicator_code = 'EN.ATM.CO2E.PC' --CO2 emission (metric tons per capita) (2011 to 2018)
    OR
    indicator_code = 'EN.ATM.CO2E.GF.ZS' --CO2 emission % from gas fuel (2011 to 2016)
    OR
    indicator_code = 'EN.ATM.CO2E.LF.ZS' --CO2 emission % from liquid fuel (2011 to 2016)
    OR
    indicator_code = 'EN.ATM.CO2E.SF.ZS' --CO2 emission % from solid fuel (2011 to 2016)
    OR
    indicator_code = 'EG.USE.COMM.GD.PP.KD' --Energy use (kg of oil equivalent) per $1,000 GDP (constant 2017 PPP) (2011 to 2015)
  ) 
  
  --Getting target range of years
  AND
  indicator.year BETWEEN 2011 AND 2020
