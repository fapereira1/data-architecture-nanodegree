
-------------------------------------------------------------------------------
-- Author       Fabio Augusto Pereira
-- Created      31/05/2021
-- Purpose      Create Schema and tables for Humam Resource Database at
--              Tech ABC Corp
-- Copyright ©2021, Tech ABC Corp, All Rights Reserved
-------------------------------------------------------------------------------
-- Modification History
--
-- 31/05/2021  Fabio Augusto Pereira
--      DDL Script to create database Objects
-- 05/06/2021  Fabio Augusto Pereira
--      Model corrections
-------------------------------------------------------------------------------
 create schema if not exists human_resources authorization postgres;

create table if not exists human_resources.job( job_id serial primary key,
job_nm varchar(50) not null,
created_at timestamp not null default now(),
updated_at timestamp not null default now() );

create table if not exists human_resources.salary( salary_id serial primary key,
salary_value money not null,
created_at timestamp not null default now(),
updated_at timestamp not null default now() );

create table if not exists human_resources.department( department_id serial primary key,
department_nm varchar(50) not null,
created_at timestamp not null default now(),
updated_at timestamp not null default now() );

create table if not exists human_resources.education( education_id serial primary key,
education_level varchar(70) not null,
created_at timestamp not null default now(),
updated_at timestamp not null default now() );

create table if not exists human_resources.location( location_id serial primary key,
location_nm varchar(50) not null,
created_at timestamp not null default now(),
updated_at timestamp not null default now() );

create table if not exists human_resources.state( state_id serial primary key,
state_nm varchar(2) not null,
location_id int references human_resources.location(location_id) not null,
created_at timestamp not null default now(),
updated_at timestamp not null default now() );

create table if not exists human_resources.city( city_id serial primary key,
city_nm varchar(50) not null,
state_id int references human_resources.state(state_id) not null,
created_at timestamp not null default now(),
updated_at timestamp not null default now() );

create table if not exists human_resources.address( address_id serial primary key,
address_desc varchar(100) not null,
city_id int references human_resources.city(city_id) not null,
created_at timestamp not null default now(),
updated_at timestamp not null default now() );

create table if not exists human_resources.employee( employee_id varchar(8),
employee_nm varchar(50) not null,
employee_email varchar(50) not null,
education_id int references human_resources.education(education_id) not null,
hire_date date not null,
created_at timestamp not null default now(),
updated_at timestamp not null default now(),
primary key (employee_id) );

create table if not exists human_resources.employee_registry( id serial primary key,
employee_id varchar(8) references human_resources.employee(employee_id) not null,
job_id int references human_resources.job(job_id) not null,
start_date date not null,
end_date date,
manager_id varchar(8) references human_resources.employee(employee_id),
salary_id int references human_resources.salary(salary_id) not null,
department_id int references human_resources.department(department_id) not null,
address_id int references human_resources.address(address_id) not null,
created_at timestamp not null default now(),
updated_at timestamp not null default now() );

create table if not exists human_resources.proj_stg ( Emp_ID varchar(8),
Emp_NM varchar(50),
Email varchar(100),
hire_dt date,
job_title varchar(100),
salary int,
department_nm varchar(50),
manager varchar(50),
start_dt date,
end_dt date,
location varchar(50),
address varchar(100),
city varchar(50),
state varchar(2),
education_lvl varchar(50) );