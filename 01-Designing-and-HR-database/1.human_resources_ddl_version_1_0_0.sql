-------------------------------------------------------------------------------
-- Author       Fabio Augusto Pereira
-- Created      31/05/2021
-- Purpose      Create Schema and tables for Humam Resource Database at
--              Tech ABC Corp
-- Copyright ©2021, Tech ABC Corp, All Rights Reserved
-------------------------------------------------------------------------------
-- Modification History
--
-- 31/05/20201  Fabio Augusto Pereira
--      DDL Script to create database Objects
-------------------------------------------------------------------------------

create schema human_resources AUTHORIZATION postgres;

create table human_resources.job(
	job_id serial primary key,
	job_nm varchar(50) not null,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now()
);

create table human_resources.salary(
	salary_id serial primary key,
	salary_value money not null, 
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now()
);

create table human_resources.departament(
	departament_id serial primary key,
	department_nm varchar(50) not null,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now()
);

create table human_resources.education(
	education_id serial primary key,
	education_level varchar(70) not null,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now()
);

create table human_resources.location(
	location_id serial primary key,
	location_nm varchar(50) not null,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now()
);

create table human_resources.state(
	state_id serial primary key,
	state_nm varchar(2) not null,
	location_id int references human_resources.location(location_id) not null,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now()
);

create table human_resources.city(
	city_id serial primary key,
	city_nm varchar(50) not null,
	state_id int references human_resources.state(state_id) not null,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now()
);

create table human_resources.address(
	address_id serial primary key,
	address_desc varchar(100) not null,
	city_id int references human_resources.city(city_id) not null, 
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now()
);

create table human_resources.employee(
	employee_id serial,
	employee_nm varchar(50) not null,
	employee_email varchar(50) not null,
	education_id int references human_resources.education(education_id) not null,
	employee_key varchar(6),
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now(),
	primary key (employee_id),
	unique (employee_key)
);

create table human_resources.employee_registry(
	id serial primary key,
	employee_id int references human_resources.employee(employee_id) not null,
	job_id int references human_resources.job(job_id) not null,
	hire_date date not null,
	start_date date not null,
	end_date date not null,
	manager_id int references human_resources.employee(employee_id) not null,
	salary_id int references human_resources.salary(salary_id) not null,
	departament_id int references human_resources.departament(departament_id) not null,
	address_id int references human_resources.address(address_id) not null,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now()
);

create table human_resources.proj_stg (
	Emp_ID varchar(8),
	Emp_NM varchar(50),
	Email  varchar(100),
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
	education_lvl varchar(50)
);