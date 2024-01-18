--CAST() Function is used to change the data type or format

SELECT
  CAST(purchase_price AS FLOAT64)
  purchase_price


FROM `bi-analytics-project-001.customer_data.customer_purchase`

ORDER BY

  CAST(purchase_price AS FLOAT64) DESC

-------

SELECT
  CAST(date AS date) AS date_only,
  purchase_price


FROM `bi-analytics-project-001.customer_data.customer_purchase`

WHERE

  date BETWEEN '2020-12-01' AND '2020-12-31'


----------------------------------------------------
--CONCAT() Function is used to join two strings from different tables

SELECT
  CONCAT(product_code, product_color) AS new_product_code


FROM `bi-analytics-project-001.customer_data.customer_purchase`

WHERE

  product = 'couch'

----------------------------------------------------

--COALESCE() used to skip any null values and replaced with another column's value.

 SELECT
  
   COALESCE(product, product_code) AS product_info

FROM `bi-analytics-project-001.customer_data.customer_purchase`


---------------------------------------
DISTINCT

SELECT count(DISTINCT customer_id)
FROM
invoice

---------------------------------------

SUBSTR


SELECT
employee_id,
SUBSTR(last_name, 1,3) AS new_last_name
FROM
employee
ORDER BY
postal_code


----------------------

SELECT * FROM invoices WHERE BillingCountry='Germany' AND Total > 5. 

-------------------------------


select * 

from bi-analytics-project-001.movie_data.movies 

WHERE Genre = "Comedy" AND Revenue > 300000000

ORDER BY
  Release_Date DESC

  ---------------------

  SELECT * FROM Tracks
WHERE Composer = 'Chris Cornell'
ORDER BY GenreId DESC

-----------------------------


SELECT 
  *
FROM 
  bigquery-public-data.sdoh_cdc_wonder_natality.county_natality 
WHERE 
  Year = '2018-01-01'
ORDER BY
  Births
DESC
LIMIT 
  10



  ----------------------------------

  CONCAT Function


  SELECT 
    usertype,
    CONCAT(start_station_name," to ", end_station_name) AS route,
    COUNT(*) as num_trips,
    ROUND(AVG(cast (tripduration as int64)/60),2) AS duration
FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`


GROUP BY

    start_station_name,
    end_station_name,
    usertype


ORDER BY
    num_trips DESC

LIMIT 10

-------------------------------------------

How to use JOIN
*** So much useful example!

SELECT 

    employees.name AS employee_name,
    employees.role AS employee_role,
    departments.name AS department_name
    


 FROM 
    employee_data.employees LEFT JOIN employee_data.departments
    ON
    employees.department_id = departments.department_id


Alternatively

SELECT 

    e.name AS employee_name,
    e.role AS employee_role,
    d.name AS department_name
    


 FROM 
    employee_data.employees AS e LEFT JOIN employee_data.departments AS d
    ON
   e.department_id = d.department_id
  


  ---------------------------

  SELECT 
    edu.country_name, 
    summary.country_code, 
    SUM(edu.value) AS country_value
FROM 
    bigquery-public-data.world_bank_intl_education.international_education AS edu
INNER JOIN 
    bigquery-public-data.world_bank_intl_education.country_summary AS summary 
ON  summary.country_code = edu.country_code

GROUP BY 
  country_name,
  country_code


--------------------------------


SELECT

    warehouse.state as state,

    COUNT(DISTINCT orders.order_id) AS num_orders

FROM

    `bi-analytics-project-001.warehouse_orders.orders` AS orders
JOIN
    `bi-analytics-project-001.warehouse_orders.warehouse` as warehouse

ON

    warehouse.warehouse_id = orders.warehouse_id

GROUP BY
    warehouse.state


---------------------------------------

SubQuery

 SELECT  

  station_id,
  num_bikes_available,

  (SELECT

      AVG(num_bikes_available)

  FROM `bigquery-public-data.new_york_citibike.citibike_stations`) AS avg_num_bikes_available

FROM `bigquery-public-data.new_york_citibike.citibike_stations`

-----------------------------------------------

SELECT
  id,
  name,
  number_of_rides AS number_of_rides_starting_station
FROM
  (
    SELECT
      start_station_id,
      COUNT(*) AS number_of_rides
    FROM
      bigquery-public-data.london_bicycles.cycle_hire
    GROUP BY
      start_station_id
  )
  AS station_num_trips
  INNER JOIN
  bigquery-public-data.london_bicycles.cycle_stations ON id = start_station_id
  ORDER BY
    number_of_rides DESC
-----------------------------------------------------------------

SELECT 

  station_id,
  name

FROM `bigquery-public-data.new_york_citibike.citibike_stations`

WHERE

  station_id IN

  (

    SELECT
      start_station_id
    FROM
      `bigquery-public-data.new_york_citibike.citibike_trips`

    WHERE
      usertype = 'Subscriber'

  )

-------------------------------------------------------------------------------


SELECT

    warehouse.warehouse_id,
    CONCAT(warehouse.state, ':', warehouse.warehouse_alias) AS warehouse_name,
    COUNT(orders.order_id) AS number_of_orders,
    (SELECT 
      COUNT(*)
     FROM `bi-analytics-project-001.warehouse_orders.orders` AS orders)
     AS total_orders,

     CASE 
      WHEN COUNT (orders.order_id)/(SELECT COUNT(*) FROM `bi-analytics-project-001.warehouse_orders.orders`) <= 0.20
      THEN "fulfilled 0-20% of orders"
      WHEN COUNT (orders.order_id)/(SELECT COUNT(*) FROM `bi-analytics-project-001.warehouse_orders.orders`) > 0.20
      AND COUNT (orders.order_id)/(SELECT COUNT(*) FROM `bi-analytics-project-001.warehouse_orders.orders`) <= 0.60
      THEN "fulfilled 21-60% of orders"
      ELSE "Fulfilled more than 60% orders"
    END AS fulfillment_summary




FROM 

    `bi-analytics-project-001.warehouse_orders.warehouse` AS warehouse
  
  LEFT JOIN
  
    `bi-analytics-project-001.warehouse_orders.orders` AS orders
  
  ON
    orders.warehouse_id = warehouse.warehouse_id


GROUP BY

    warehouse.warehouse_id,
    warehouse_name

HAVING
    COUNT(orders.order_id) >0

--------------------------------------------------


SELECT
  EXTRACT (YEAR FROM STARTTIME) AS year,
  COUNT(*) AS number_of_rides

FROM bigquery-public-data.new_york_citibike.citibike_trips

GROUP BY YEAR
ORDER BY YEAR


-------------------------

Temporary Table

WITH trips_over_1_hr AS (

  SELECT *
  FROM
    bigquery-public-data.new_york_citibike.citibike_trips
  WHERE
    tripduration >= 60

  )

SELECT
  COUNT(*) AS cnt
FROM
  trips_over_1



----------------------------------------------------
LeetCode Challange number 1581

SELECT DISTINCT v.customer_id, COUNT(v.visit_id) AS count_no_trans
FROM Visits as v FULL JOIN Transactions as t
ON v.visit_id = t.visit_id
WHERE t.visit_id IS null 
GROUP BY v.customer_id
ORDER BY count_no_trans ASC


/* Alternate Solution */
select customer_id , count(1) as count_no_trans
from Visits
where visit_id not in (select visit_id from Transactions)
Group by customer_id

/* Write your T-SQL query statement below */
select v.customer_id as customer_id, Count(v.visit_id)as count_no_trans 
from Visits v left join Transactions t 
on v.visit_id=t.visit_id 
WHERE transaction_id IS NULL
GROUP BY customer_id

