-------------------------------------------------------------------------------
-- Author       Fabio Augusto Pereira
-- Created      04/07/2021
-- Purpose      Create a Star Schema on Snowflake
-- Copyright ©2021
-------------------------------------------------------------------------------
-- Modification History
--
-- 05/07/20201  Fabio Augusto Pereira
--      DDL Script to create database Objects

USE DATABASE YELP_REVIEW_DATABASE;
USE SCHEMA DATAWAREHOUSE;

---------------------------------------------------------------------
-- Create Dimensional Table Temperature 
---------------------------------------------------------------------
CREATE OR REPLACE TABLE DIM_Temperature (
   Date_t date,
   Min_t number,
   Max_t number,
   Normal_min float,
   Normal_max float,
   CONSTRAINT pk_date_t PRIMARY KEY(Date_t)
);

INSERT INTO DIM_Temperature
SELECT DISTINCT DATE_T,MIN_T,MAX_T, Normal_MIN,Normal_MAX
FROM YELP_REVIEW_DATABASE.ODS.Temperature;


---------------------------------------------------------------------
-- Create Dimensional Table Precipitation
---------------------------------------------------------------------
CREATE OR REPLACE TABLE DIM_Precipitation (
date_p date,
precipitation float,
precipitation_normal float,
CONSTRAINT pk_date_p primary key(date_p)
);

INSERT INTO DIM_PRECIPITATION
SELECT DISTINCT DATE_T,precipitation,precipitation_normal
FROM YELP_REVIEW_DATABASE.ODS.PRECIPITATION;

---------------------------------------------------------------------
--  Create Dimensional Table Business
---------------------------------------------------------------------

CREATE OR REPLACE TABLE DIM_Business(
business_id string,
name string,
address string,
postal_code string,
city string,
state string,
CONSTRAINT pk_business_id PRIMARY KEY(business_id)
);

INSERT INTO DIM_BUSINESS
SELECT DISTINCT business_id,name,address,postal_code,city,state
FROM YELP_REVIEW_DATABASE.ODS.BUSINESS;
---------------------------------------------------------------------
-- Create Dimensional Table Users
---------------------------------------------------------------------
CREATE OR REPLACE TABLE DIM_USERS(
  user_id String,
  name String,
  yelping_since Date,
  CONSTRAINT pk_user_id PRIMARY KEY(user_id)
);

INSERT INTO DIM_USERS
SELECT DISTINCT user_ID,user_name,yelping_since 
FROM YELP_REVIEW_DATABASE.ODS.users;

---------------------------------------------------------------------
-- Create Fact Table for Reviews
---------------------------------------------------------------------

CREATE OR REPLACE TABLE Fact_Review (
Review_id String,
Business_Id String,
User_id String,
Date_Temperature Date,
Date_Precipitation Date,
Stars number,
User_review_count number,
Business_review_count number,
CONSTRAINT fk_review_id FOREIGN KEY (Review_id) REFERENCES YELP_REVIEW_DATABASE.ODS.Reviews (review_id),
CONSTRAINT fk_business_id FOREIGN KEY (business_id) REFERENCES YELP_REVIEW_DATABASE.ODS.BUSINESS  (BUSINESS_ID),
CONSTRAINT fk_user_id  FOREIGN KEY (user_id ) REFERENCES YELP_REVIEW_DATABASE.ODS.USERS  (USER_ID),
CONSTRAINT fk_Date_Temperature FOREIGN KEY (Date_Temperature) REFERENCES YELP_REVIEW_DATABASE.ODS.TEMPERATURE (DATE_T),
CONSTRAINT fk_Date_Precipitation FOREIGN KEY (Date_Precipitation) REFERENCES YELP_REVIEW_DATABASE.ODS.PRECIPITATION (DATE_T)
);

INSERT INTO Fact_Review
SELECT R.review_id,B.Business_ID,U.User_ID,T.Date_T,P.Date_t,R.stars,U.review_Count,B.review_Count
FROM YELP_REVIEW_DATABASE.ODS.REVIEWS as R
JOIN YELP_REVIEW_DATABASE.ODS.BUSINESS as B ON R.business_ID=B.business_ID
JOIN YELP_REVIEW_DATABASE.ODS.USERS as U ON R.user_ID=U.user_ID
JOIN YELP_REVIEW_DATABASE.ODS.TEMPERATURE as T ON R.review_date=T.Date_T
JOIN YELP_REVIEW_DATABASE.ODS.PRECIPITATION as P ON R.review_date=P.Date_T;

SELECT
    B.NAME as Business_Name,
	 T.MIN_T as Min_Temp,
    T.MAX_T as Max_Temp,
    P.precipitation as precipitation,
    P.precipitation_normal as normal_precipitation,
    AVG(R.Stars) as Avg_Rating,
    Count(R.Stars) as Num_Rating
FROM Fact_Review R 
INNER JOIN Dim_Temperature AS T ON (R.Date_Temperature = T.DATE_T)
INNER JOIN Dim_Precipitation as  P ON (R.Date_Precipitation = P.DATE_P)
INNER JOIN Dim_Business B ON (R.business_id = B.business_id)
GROUP BY B.NAME,T.MIN_T,T.MAX_T,P.precipitation,P.precipitation_normal
ORDER BY Num_Rating desc;