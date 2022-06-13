--1. Checking topics of indicators, result: 89
--SELECT COUNT(series_code), topic
--FROM `bigquery-public-data.world_bank_wdi.series_summary`
--WHERE 
--  topic LIKE '%Education%' --result: 4
--  topic LIKE '%Health%' --result: 11
--  topic LIKE '%Environment%' --result: 8
--  topic LIKE '%Infrastructure%' --result: 3
--  topic LIKE '%Social%' --result: 5
--  topic LIKE '%Poverty%' --result: 4
--  topic LIKE '%Financial%' --result: 6
--  topic LIKE '%Conflict%' --result: 7
--GROUP BY topic
--ORDER BY topic

--2. Extracting indicators' info for other queries
SELECT series_code, topic, indicator_name, long_definition, periodicity

FROM `bigquery-public-data.world_bank_wdi.series_summary` 

WHERE
  --Filter indicators by topic
  topic LIKE '%Education%'
  OR topic LIKE '%Health%'
  OR topic LIKE '%Environment%'
  OR topic LIKE '%Infrastructure%'
  OR topic LIKE '%Social%'
  OR topic LIKE '%Poverty%'
  OR topic LIKE '%Financial%'

  --Filter GDP indicators
  OR indicator_name LIKE 'GDP%'

  --Filter Public Sector - Conflict-related indicators
  OR topic LIKE '%Conflict%'

  --Excluding gender-specfic indicators for simplicity
  AND indicator_name NOT LIKE '%male%'
  AND indicator_name NOT LIKE '%female%'

ORDER BY topic
