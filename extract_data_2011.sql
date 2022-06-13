--## Extracting countries' codes, names, and region, indicators' codes and names, values of metrics within target range of years
SELECT country.region, country.table_name, indicator.year, indicator.indicator_name, indicator.value

FROM `bigquery-public-data.world_bank_wdi.country_summary` AS country

--Joining indicators data table for values of metrics
LEFT JOIN `bigquery-public-data.world_bank_wdi.indicators_data` AS indicator
  ON country.country_code = indicator.country_code

WHERE
  --Filtering OUT unnecessary groups, result
  country.table_name NOT LIKE '%excluding high income%'
  AND country.table_name NOT LIKE '%IDA%'
  AND country.table_name NOT LIKE '%IBRD%'

  --Use 1 of 3 filters depending on data availability
  --1. Filtering LOCATION and REGION
  AND (country.income_group IS NOT NULL
  OR country.region IS NULL)

  --2. Filtering LOCATION, result
  --  AND country.income_group IS NOT NULL

  --3. Filtering REGION and INCOME GROUP
  --  AND country.region IS NULL
  
  --Getting values from indicators
  AND
  (
    indicator_code = 'SP.URB.TOTL.IN.ZS' --urban population %
    OR
    indicator_code = 'AG.YLD.CREL.KG' --cereal yield (kg per hectare)
    OR
    indicator_code = 'EN.ATM.CO2E.GF.ZS' --CO2 emission % from gas fuel (2011 to 2016)
    OR
    indicator_code = 'EN.ATM.CO2E.LF.ZS' --CO2 emission % from liquid fuel (2011 to 2016)
    OR
    indicator_code = 'EN.ATM.CO2E.SF.ZS' --CO2 emission % from solid fuel (2011 to 2016)
    OR
    indicator_code = 'EG.USE.COMM.GD.PP.KD' --Energy use (kg of oil equivalent) per $1,000 GDP (constant 2017 PPP) (2011 to 2015)
    OR
    indicator_code = 'VC.IHR.PSRC.P5' -- Intentional homicides (per 100,000 people)
    OR
    indicator_code = 'FR.INR.RINR' --real interest rate
    OR
    indicator_code = 'NY.GDP.DEFL.KD.ZG' --inflation
    OR
    indicator_code = 'NY.GDP.PCAP.CD' --GDP per capita (current US$)
    OR
    indicator_code = 'NY.GDP.MKTP.CD' --GDP (current US$)
    OR
    indicator_code = 'EN.ATM.CO2E.PC' --CO2 emission (metric tons per capita) (to 2018)
    OR
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
    OR
    indicator_code = 'IT.NET.USER.ZS' --population % using the Internet
    OR
    indicator_code = 'TX.VAL.TECH.CD' --high-tech exports in USD
    OR
    indicator_code = 'IS.RRS.PASG.KM' --pax carried by railways (million passenger-km)
    OR
    indicator_code = 'SI.POV.GINI' --GINI index
    OR
    indicator_code = 'SI.DST.05TH.20' --income chare beld by top 20%
    OR
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
