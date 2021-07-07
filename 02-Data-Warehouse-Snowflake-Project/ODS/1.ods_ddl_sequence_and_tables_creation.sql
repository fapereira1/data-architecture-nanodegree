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

-- Sequences

CREATE OR REPLACE SEQUENCE sequence_tip_identity;
CREATE OR REPLACE SEQUENCE sequence_covid_identity;
CREATE OR REPLACE SEQUENCE sequence_checkin_identity;

-- Climate Data

CREATE OR REPLACE TABLE Temperature (
    date_t date,
    min_t number,
    max_t number,
    normal_min float,
    normal_max float,
    constraint pk_date_t PRIMARY KEY(date_t)
);

CREATE OR REPLACE TABLE Precipitation (
    date_t date,
    precipitation float, 
    precipitation_normal float,
    CONSTRAINT pk_date_t PRIMARY KEY(date_t)
);

------------------------------------------------------
-- Table User
------------------------------------------------------
create or replace table Users(
  user_id String,
  user_name String,
  review_count number,
  yelping_since Date,
  average_stars float,
  useful number,
  cool number,
  elite variant,
  fans number,
  funny number,
  friends variant,
  compliment_cool number,
  compliment_cute number,
  compliment_funny number,
  compliment_hot number,
  compliment_list number,
  compliment_more number,
  compliment_note number,
  compliment_photos number,
  compliment_plain number,
  compliment_profile number,
  compliment_writer number, 
  constraint pk_user_id primary key(user_id)
);

------------------------------------------------------
-- Table Business
------------------------------------------------------
CREATE OR REPLACE TABLE Business (
business_id string,
name string,
review_count number,
stars float,
is_open number,
address string,
postal_code string,
city string,
state string,
latitude float,
longitude float,
attributes variant,
categories variant,
hours variant,
constraint pk_business_id primary key(business_id)
);

------------------------------------------------------
-- Table Tip
------------------------------------------------------
CREATE OR REPLACE TABLE tip (
tip_id number default sequence_tip_identity.nextval,
business_id string,
compliment_count Number,
tip_date date,
tip_text string,
user_id string,
constraint pk_tip_id primary key(tip_id),
CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(user_id),
CONSTRAINT fk_business_id FOREIGN KEY (business_id) REFERENCES Business(business_id)
);

------------------------------------------------------
-- Table Checkin
------------------------------------------------------
CREATE OR REPLACE TABLE Checkin (
  checkin_id number default sequence_checkin_identity.nextval,
  business_id string,
  checkin_date timestamp,
  constraint pk_checkin_id  PRIMARY KEY(checkin_id),
  CONSTRAINT fk_business_id FOREIGN KEY (business_id) REFERENCES Business(business_id)
);

------------------------------------------------------
-- Table Covid
------------------------------------------------------
CREATE OR REPLACE TABLE Covid_Features (
covid_id number default sequence_covid_identity.nextval,
business_id string,
virtual_services_offered  string,
delivery_or_takeout boolean,
temporary_closed_until string,
call_to_action_enabled boolean,
request_a_quote boolean,
grubhub_enabled boolean,
covid_banner string,
highlights string,
 CONSTRAINT pk_covid_id PRIMARY KEY(covid_id),
 CONSTRAINT fk_business_id FOREIGN KEY (business_id) REFERENCES business(business_id)
);

------------------------------------------------------
-- Table Reviews
------------------------------------------------------
CREATE OR REPLACE TABLE Reviews(
review_id string,
business_id string,
user_id String,
review_date DATE,
stars number,
funny number,
cool number,
useful number,
review_text String,
constraint pk_review_id PRIMARY KEY(review_id),
CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES Users(user_id),
CONSTRAINT fk_business_id FOREIGN KEY (business_id) REFERENCES Business(business_id),
CONSTRAINT fk_date_t FOREIGN KEY (review_date) REFERENCES Temperature(date_t),
CONSTRAINT fk_date_p FOREIGN KEY (review_date) REFERENCES Precipitation(date_t)
);