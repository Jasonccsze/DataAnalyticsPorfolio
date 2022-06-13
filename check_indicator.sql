--1. Using COUNT with GROUP BY to check completeness of data
SELECT country_code, country_name, indicator_name, COUNT(year)

--2. Extracting values of indicators
--SELECT country_code, country_name, indicator_name, year, value

FROM `bigquery-public-data.world_bank_wdi.indicators_data` 

WHERE
  --Filtering OUT unnecessary groups
  country_name NOT LIKE '%excluding high income%'
  AND country_name NOT LIKE '%IDA%'
  AND country_name NOT LIKE '%IBRD%'
  --Filtering by demographic dividend groups
  --AND country_name LIKE '%dividend%'
  --Filtering by income groups
  --AND country_name LIKE '%income%'
  --Filtering by REGIONS and INCOME GROUPS
  --AND country.region IS NULL

  --## Using indicator codes obtained from series summary table for this query
  
  --ECONOMIC
  --AND indicator_code = 'NY.GDP.PCAP.CD' --GDP per capita (current US$)
  --AND indicator_code = 'NY.GDP.MKTP.CD' --GDP (current US$)

  --EDUCATION
  --Getting % of adolescents out of school (2011 to 2020)
  --AND indicator_code = 'SE.SEC.UNER.LO.ZS'
  --Getting % of children out of school (2011 to 2020)
  --AND indicator_code = 'SE.PRM.UNER.ZS'
  --Getting no. of years of compulsary educaiton (2011 to 2020)
  --AND indicator_code = 'SE.COM.DURS'
  --Getting secondary school pupil:teacher ratio; data only available (2011 to 2018)
  --AND indicator_code = 'SE.SEC.ENRL.TC.ZS'
  --Getting primary school pupil:teacher ratio; data only available (2011 to 2018)
  --AND indicator_code = 'SE.PRM.ENRL.TC.ZS'
  --Getting literacy rate of ages 15-24 (2011 to 2020)
  --AND indicator_code = 'SE.ADT.1524.LT.ZS'

  --HEALTH
  --Getting population % of moderate or severe food insecurity (2015 to 2019)
  --AND indicator_code ='SN.ITK.MSFI.ZS'
  --Getting population % using basic drinking water services (2011 to 2020)
  --AND indicator_code = 'SH.H2O.BASW.ZS'
  --Getting life expectancy in years (2011 to 2019)
  --AND indicator_code = 'SP.DYN.LE00.IN'
  --Getting death rate of unintentional poisoning (2011 to 2019)
  --AND indicator_code = 'SH.STA.POIS.P5'
  --Getting population % of undernourishment (2011 to 2019)
  --AND indicator_code = 'SN.ITK.DEFC.ZS'
  --Getting birth rate per 1000 (2011 to 2019)
  --AND indicator_code = 'SP.DYN.CBRT.IN'
  --Getting death rate per 1000 (2011 to 2019)
  --AND indicator_code = 'SP.DYN.CDRT.IN'
  --Getting adolescent fertility rate per 1000 females (2011 to 2019)
  --AND indicator_code = 'SP.ADO.TFRT'
  --Getting fertility rate per 1000 females (2011 to 2019)
  --AND indicator_code = 'SP.DYN.TFRT.IN'

  --ENVIRONMENT
  --Getting urban population %
  --AND indicator_code = 'SP.URB.TOTL.IN.ZS'
  --Getting cereal yield (kg per hectare)
  --AND indicator_code = 'AG.YLD.CREL.KG'
  --Getting CO2 emission (metric tons per capita) (2011 to 2018)
  --AND indicator_code = 'EN.ATM.CO2E.PC'
  --Getting CO2 emission % from gas fuel (2011 to 2016)
  --AND indicator_code = 'EN.ATM.CO2E.GF.ZS'
  --Getting CO2 emission % from liquid fuel (2011 to 2016)
  --AND indicator_code = 'EN.ATM.CO2E.LF.ZS'
  --Getting CO2 emission % from solid fuel (2011 to 2016)
  --AND indicator_code = 'EN.ATM.CO2E.SF.ZS'
  --Getting Energy use (kg of oil equivalent) per $1,000 GDP (constant 2017 PPP) (2011 to 2015)
  --AND indicator_code = 'EG.USE.COMM.GD.PP.KD'

  --INFRASTRUCTURE
  --Getting population % using the Internet
  --AND indicator_code = 'IT.NET.USER.ZS'
  --Getting high-tech exports in USD
  --AND indicator_code = 'TX.VAL.TECH.CD'
  --Getting pax carried by railways (million passenger-km)
  --AND indicator_code = 'IS.RRS.PASG.KM'

  --SOCIAL
  --Getting Labor force participation rate for ages 15-24, total (%) (modeled ILO estimate)
  --AND indicator_code = 'SL.TLF.ACTI.1524.ZS'
  --Getting Labor force participation rate, total (% of total population ages 15+) (modeled ILO estimate)
  --AND indicator_code = 'SL.TLF.CACT.ZS'
  --Getting Labor force with basic education (% of total working-age population with basic education)
  --AND indicator_code = 'SL.TLF.BASC.ZS'
  --Getting Share of youth not in education, employment or training, total (% of youth population)
  --AND indicator_code = 'SL.UEM.NEET.ZS'

  --POVERTY
  --Getting GINI index
  --AND indicator_code = 'SI.POV.GINI'
  --Getting income chare beld by top 20%
  --AND indicator_code = 'SI.DST.05TH.20'

  --PUBLIC - Conflict
  --Getting Battle-related deaths
  --AND indicator_code = 'VC.BTL.DETH'
  --Getting Intentional homicides (per 100,000 people)
  --AND indicator_code = 'VC.IHR.PSRC.P5'

  --FINANCIAL
  --Getting real interest rate
  --AND indicator_code = 'FR.INR.RINR'
  --Getting inflation
  --AND indicator_code = 'NY.GDP.DEFL.KD.ZG'

  --Getting target range of years
  AND year BETWEEN 2011 AND 2020

GROUP BY 1, 2, 3
ORDER BY 4, 1
