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
    indicator.indicator_code ='SN.ITK.MSFI.ZS' --population % of moderate or severe food insecurity (2015 to 2019)
    OR
    indicator.indicator_code = 'SH.H2O.BASW.ZS' --population % using drinking water services (2011 to 2020)
    OR 
    indicator.indicator_code = 'SP.DYN.LE00.IN' --life expectancy in years (2011 to 2019)
    OR 
    indicator.indicator_code = 'SH.STA.POIS.P5' --death rate of unintentional poisoning (2011 to 2019)
    OR 
    indicator.indicator_code = 'SN.ITK.DEFC.ZS' --population % of undernourishment (2011 to 2019)
    OR
    indicator.indicator_code = 'SP.DYN.CBRT.IN' --birth rate per 1000 (2011 to 2019)
    OR
    indicator.indicator_code = 'SP.DYN.CDRT.IN' --death rate per 1000 (2011 to 2019)
    OR 
    indicator.indicator_code = 'SP.ADO.TFRT' --adolescent fertility rate per 1000 females (2011 to 2019)
    OR
    indicator.indicator_code = 'SP.DYN.TFRT.IN' --fertility rate per 1000 females (2011 to 2019)
  ) 
  
  --Getting target range of years
  AND
  indicator.year BETWEEN 2011 AND 2020
