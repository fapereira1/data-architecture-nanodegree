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

CREATE OR REPLACE DATABASE YELP_REVIEW_DATABASE COMMENT = 'Database for research: How weather affects restaurant ratting';
CREATE OR REPLACE SCHEMA Staging;
CREATE OR REPLACE SCHEMA ODS;
CREATE OR REPLACE SCHEMA DATAWAREHOUSE;

