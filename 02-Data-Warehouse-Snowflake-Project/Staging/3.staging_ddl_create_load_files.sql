-------------------------------------------------------------------------------
-- Author       Fabio Augusto Pereira
-- Created      04/07/2021
-- Purpose      Upload files to Staging area
-- Copyright ©2021
-------------------------------------------------------------------------------
-- Modification History
--
-- 31/05/20201  Fabio Augusto Pereira
--      Upload files

USE YELP_REVIEW_DATABASE;
USE SCHEMA STAGING;

-- 1. Yelp academic dataset business.
-- PUT FILE
PUT file:///home/pereira/Projetos/data-architecture-nanodegree/02-Data-Warehouse-Snowflake-Project/files/yelp_academic_dataset_business.json @STAGE_YELP auto_compress=true;

-- LOAD STAGE TABLE
COPY INTO Business FROM @stage_yelp/yelp_academic_dataset_business.json.gz FILE_FORMAT = JSON_FORMAT ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

-- 2. Yelp academic dataset checkin.
-- PUT FILE
PUT file:///home/pereira/Projetos/data-architecture-nanodegree/02-Data-Warehouse-Snowflake-Project/files/yelp_academic_dataset_checkin.json @STAGE_YELP auto_compress=true;

-- LOAD STAGE TABLE
COPY INTO checkin FROM @stage_yelp/yelp_academic_dataset_checkin.json.gz FILE_FORMAT = JSON_FORMAT ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

-- 3. Yelp academic dataset review
-- PUT FILE
PUT file:///home/pereira/Projetos/data-architecture-nanodegree/02-Data-Warehouse-Snowflake-Project/files/yelp_academic_dataset_review.json @STAGE_YELP auto_compress=true;

--LOAD STAGE TABLE
COPY INTO Review FROM @stage_yelp/yelp_academic_dataset_review.json.gz FILE_FORMAT = JSON_FORMAT ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

-- 4. Yelp academic dataset tip
-- PUT FILE
PUT file:///home/pereira/Projetos/data-architecture-nanodegree/02-Data-Warehouse-Snowflake-Project/files/yelp_academic_dataset_tip.json @STAGE_YELP auto_compress=true;

--LOAD STAGE TABLE 
COPY INTO Tip FROM @stage_yelp/yelp_academic_dataset_tip.json.gz FILE_FORMAT = JSON_FORMAT ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

--5. Yelp academic dataset user

-- PUT FILE
PUT file:///home/pereira/Projetos/data-architecture-nanodegree/02-Data-Warehouse-Snowflake-Project/files/yelp_academic_dataset_user.json  @STAGE_YELP auto_compress=true;

COPY INTO Users FROM @stage_yelp/yelp_academic_dataset_user.json.gz FILE_FORMAT = JSON_FORMAT ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

--6.Yelp academic dataset covid features
PUT file:///home/pereira/Projetos/data-architecture-nanodegree/02-Data-Warehouse-Snowflake-Project/files/covid_19_dataset_2020_06_10/yelp_academic_dataset_covid_features.json @STAGE_YELP auto_compress=true;

COPY INTO Covid_Features FROM @stage_yelp/yelp_academic_dataset_covid_features.json.gz FILE_FORMAT = JSON_FORMAT ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

-- Load data about Precipitation and Temperature

--7. Temperature

PUT file:///home/pereira/Projetos/data-architecture-nanodegree/02-Data-Warehouse-Snowflake-Project/files/USW00023169-temperature-degreeF.csv @STAGE_CLIMATE auto_compress=true;

COPY INTO Temperature FROM @stage_climate/USW00023169-temperature-degreeF.csv.gz FILE_FORMAT = CSV_FORMAT ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

--8. Precipitation

PUT file:///home/pereira/Projetos/data-architecture-nanodegree/02-Data-Warehouse-Snowflake-Project/files/USW00023169-LAS_VEGAS_MCCARRAN_INTL_AP-precipitation-inch.csv @STAGE_CLIMATE auto_compress=true;

COPY INTO Precipitation FROM @stage_climate/USW00023169-LAS_VEGAS_MCCARRAN_INTL_AP-precipitation-inch.csv.gz FILE_FORMAT = CSV_FORMAT ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;