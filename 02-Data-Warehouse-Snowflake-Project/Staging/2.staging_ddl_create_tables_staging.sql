-------------------------------------------------------------------------------
-- Author       Fabio Augusto Pereira
-- Created      04/07/2021
-- Purpose      Create a New Database on Snowflake
-- Copyright ©2021
-------------------------------------------------------------------------------
-- Modification History
--
-- 31/05/20201  Fabio Augusto Pereira
--      DDL Script to create database Objects

USE YELP_REVIEW_DATABASE;
USE SCHEMA STAGING;

-- CREATE Load File for JSON data structure. 

CREATE OR REPLACE FILE FORMAT JSON_FORMAT TYPE = 'JSON' COMPRESSION = 'AUTO' STRIP_OUTER_ARRAY = TRUE COMMENT = 'File format for JSON Loading';
CREATE OR REPLACE FILE FORMAT CSV_FORMAT TYPE = 'CSV' COMPRESSION = 'AUTO' FIELD_DELIMITER = ',' RECORD_DELIMITER = '\n' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY ='"' TRIM_SPACE = FALSE ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE ESCAPE = 'NONE' ESCAPE_UNENCLOSED_FIELD = '\134' DATE_FORMAT = 'AUTO' TIMESTAMP_FORMAT = 'AUTO' NULL_IF = ('\\N') COMMENT = 'File format for CSV Loading';

-- CREATE State area for Yelp and climate data
CREATE OR REPLACE STAGE STAGE_YELP COMMENT = 'Staging for Yelp files';
CREATE OR REPLACE STAGE STAGE_CLIMATE COMMENT = 'Staging for Climate files';

-- Create staging tables
CREATE OR REPLACE TABLE Business(jsonvar variant);
CREATE OR REPLACE TABLE Checkin(jsonvar variant);
CREATE OR REPLACE TABLE Review(jsonvar variant);
CREATE OR REPLACE TABLE Tip(jsonvar variant);
CREATE OR REPLACE TABLE Users(jsonvar variant);
CREATE OR REPLACE TABLE Covid_Features(jsonvar variant);

CREATE OR REPLACE TABLE Precipitation (
    date_p String,
    precipitation String,
    precipitation_normal String
);

CREATE OR REPLACE TABLE Temperature(
    date_t String,
    min_t String,
    max_t String,
    normal_min String,
    normal_max String
);

