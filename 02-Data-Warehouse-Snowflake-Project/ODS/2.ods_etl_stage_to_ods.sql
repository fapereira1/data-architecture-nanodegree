-------------------------------------------------------------------------------
-- Author       Fabio Augusto Pereira
-- Created      04/07/2021
-- Purpose      Create a New structure for Operation Data Store on Snowflake
-- Copyright ©2021
-------------------------------------------------------------------------------
-- Modification History
--
-- 05/07/20201  Fabio Augusto Pereira
--      DDL Script to create database Objects

USE DATABASE YELP_REVIEW_DATABASE;
USE SCHEMA ODS;

---------------------------------------------------------------------
-- Load tables with Climate Data
---------------------------------------------------------------------
INSERT INTO Temperature (date_t, min_t, max_t, normal_min, normal_max)
SELECT 
TRY_TO_DATE(DATE_T,'YYYYMMDD'),
TRY_TO_NUMBER(MIN_T),
TRY_TO_NUMBER(MAX_T),
TRY_CAST(NORMAL_MIN AS FLOAT),
TRY_CAST(NORMAL_MAX AS FLOAT)
FROM YELP_REVIEW_DATABASE.STAGING.TEMPERATURE;

INSERT INTO Precipitation (date_t, precipitation, precipitation_normal)
SELECT
TO_DATE(date_p, 'YYYYMMDD'),
TRY_CAST(precipitation as float),
TRY_CAST(precipitation_normal AS FLOAT)
FROM YELP_REVIEW_DATABASE.STAGING.precipitation;

---------------------------------------------------------------------
-- Load table Users
---------------------------------------------------------------------
INSERT INTO users
SELECT
parse_json($1):  user_id,
parse_json($1):  name,
parse_json($1):  review_count,
parse_json($1):  yelping_since,
parse_json($1):  average_stars,
parse_json($1):  useful,
parse_json($1):  cool,
parse_json($1):  elite,
parse_json($1):  fans,
parse_json($1):  funny,
parse_json($1):  friends,
parse_json($1):  compliment_cool,
parse_json($1):  compliment_cute,
parse_json($1):  compliment_funny,
parse_json($1):  compliment_hot,
parse_json($1):  compliment_list,
parse_json($1):  compliment_more,
parse_json($1):  compliment_note,
parse_json($1):  compliment_photos,
parse_json($1):  compliment_plain,
parse_json($1):  compliment_profile,
parse_json($1):  compliment_writer
FROM YELP_REVIEW_DATABASE.STAGING.Users;

---------------------------------------------------------------------
-- Load Table Business
---------------------------------------------------------------------

INSERT INTO Business
select
parse_json($1):business_id, 
parse_json($1):name, 
parse_json($1):review_count, 
parse_json($1):stars,
parse_json($1):is_open, 
parse_json($1):address, 
parse_json($1):city,
parse_json($1):postal_code, 
parse_json($1):state, 
parse_json($1):latitude, 
parse_json($1):longitude,
parse_json($1):attributes, 
parse_json($1):categories, 
parse_json($1):hours
from YELP_REVIEW_DATABASE.STAGING.Business;

---------------------------------------------------------------------
-- Load Table Tip
---------------------------------------------------------------------
INSERT INTO Tip
   SELECT
   sequence_tip_identity.nextval,
   parse_json($1):business_id, 
   parse_json($1):compliment_count,
   parse_json($1):date,
   parse_json($1):text, 
   parse_json($1):user_id
   from YELP_REVIEW_DATABASE.STAGING.Tip;

---------------------------------------------------------------------
-- Load Table Checkin
---------------------------------------------------------------------
INSERT INTO Checkin
SELECT sequence_checkin_identity.nextval,
jsonvar:business_id::string,
y.value::timestamp
FROM YELP_REVIEW_DATABASE.STAGING.Checkin,LATERAL FLATTEN(INPUT=>SPLIT(jsonvar:date,',')) y;

---------------------------------------------------------------------
-- Load Table Covid
---------------------------------------------------------------------
INSERT INTO covid_features
SELECT
sequence_covid_identity.nextval,
parse_json($1):business_id,
parse_json($1):"Virtual Services Offered",
parse_json($1):"Delivery or Takeout",
parse_json($1):"Temporary Closed Until",
parse_json($1):"Call To Action enabled",
parse_json($1):"Request a Quote Enabled" ,
parse_json($1):"Grubhub enabled",
parse_json($1):"Covid Banner",
parse_json($1):"Highlights"
FROM YELP_REVIEW_DATABASE.STAGING.covid_features;

---------------------------------------------------------------------
-- Load Table Reviews
---------------------------------------------------------------------
INSERT INTO Reviews
SELECT
parse_json($1):business_id,
parse_json($1):review_id,
parse_json($1):user_id,
parse_json($1):date,
parse_json($1):stars,
parse_json($1):funny,
parse_json($1):cool,
parse_json($1):useful,
parse_json($1):text
FROM YELP_REVIEW_DATABASE.STAGING.Review;