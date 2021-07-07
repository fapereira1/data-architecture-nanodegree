-------------------------------------------------------------------------------
-- Author       Fabio Augusto Pereira
-- Created      31/05/2021
-- Purpose      Question Project Tech ABC Corp
-- Copyright ©2021, Tech ABC Corp, All Rights Reserved
-------------------------------------------------------------------------------
-- Modification History
--
-- 31/05/20201  Fabio Augusto Pereira
--      Question response
-------------------------------------------------------------------------------


-- Question 1: Return a list of employees with Job Titles and Department Names

select
	e.employee_nm as employee_name,
	j.job_nm as job_title,
	d.department_nm as department
from
	human_resources.employee_registry er
inner join human_resources.employee e on
	er.employee_id = e.employee_id
inner join human_resources.job j on
	er.job_id = j.job_id
inner join human_resources.department d on
	er.department_id = d.department_id
order by
	d.department_nm

------------------------------------------------------------------------
-- Question 2: Insert Web Programmer as a new job title​

INSERT INTO human_resources.job (job_nm, created_at, updated_at)
VALUES('Web Programmer', now(), now());

select * from human_resources.job;

------------------------------------------------------------------------
 -- Question 3: Correct the job title from web programmer to web developer

UPDATE human_resources.job
SET job_nm='Web Developer', updated_at=now()
WHERE job_nm = 'Web Programmer';

select * from human_resources.job;

------------------------------------------------------------------------
-- Question 4: Delete the job title Web Developer from the database
delete from human_resources.job where job_nm = 'Web Developer';

select * from human_resources.job;

------------------------------------------------------------------------

--Question 5: How many employees are in each department?
select
	d.department_nm,
	count(er.employee_id) as total
from
	human_resources.employee_registry er
inner join human_resources.departament d on
	d.departament_id = er.departament_id
group by
	d.department_nm
order by
	d.department_nm

---------------------------------------------------------------------------
-- Question 6: Write a query that returns current and past jobs (include employee name, job title, 
-- department, manager name, start and end date for position) for employee Toni Lembeck.

select
	e.employee_nm,
	j.job_nm,
	mng.employee_nm as managet,
	er.start_date,
	er.end_date
from
	human_resources.employee_registry er
inner join human_resources.employee e on
	e.employee_id = er.employee_id
inner join human_resources.employee mng on
	mng.employee_id = er.employee_id
inner join human_resources.department d on
	d.department_id = er.department_id
inner join human_resources.job j on
	j.job_id = er.job_id
where
	e.employee_nm = 'Toni Lembeck';

-------------------------------------------------------------------------------------------------
-- Create a view that returns all employee attributes; results should resemble initial Excel file
create or replace
view human_resources.employee_attr as (
select
	e.employee_id as emp_id,
	e.employee_nm as emp_nm,
	e.employee_email as email,
	e.hire_date as hire_dt,
	j.job_nm as job_title,
	s.salary_value as salary,
	mng.employee_nm as manager,
	er.start_date as start_dt,
	er.end_date as end_dt,
	l.location_nm as location,
	adr.address_desc as address,
	c.city_nm as city,
	sta.state_nm as state,
	educ.education_level
from
	human_resources.employee_registry er
inner join human_resources.employee e on
	e.employee_id = er.employee_id
inner join human_resources.job j on
	j.job_id = er.job_id
inner join human_resources.salary s on
	s.salary_id = er.salary_id
inner join human_resources.department d on
	d.department_id = er.department_id
inner join human_resources.employee mng on
	mng.employee_id = er.manager_id
inner join human_resources.address adr on
	adr.address_id = er.address_id
inner join human_resources.city c on
	c.city_id = adr.city_id
inner join human_resources.state sta on
	sta.state_id = c.state_id
inner join human_resources."location" l on
	l.location_id = sta.location_id
inner join human_resources.education educ on
	educ.education_id = e.education_id);

------------------------------------------------------------------------------------------------

-- Create a stored procedure with parameters that returns current and past jobs 
-- (include employee name, job title, department, manager name, start and end date for position) 
-- when given an employee name.​

create or replace function human_resources.get_current_and_past_job(pname varchar) 
returns table ( 
employee_name VARCHAR,
job_title VARCHAR,
department VARCHAR,
manager_name VARCHAR,
start_dt date,
end_dt date ) as $$

begin 
	return query select
	e.employee_nm as employee_name,
	j.job_nm as job_title,
	d.department_nm as department,
	mng.employee_nm as manager_name,
	er.start_date,
	er.end_date
from
	human_resources.employee_registry er
inner join human_resources.employee e on
	e.employee_id = er.employee_id
inner join human_resources.employee mng on
	mng.employee_id = er.employee_id
inner join human_resources.department d on
	d.department_id = er.department_id
inner join human_resources.job j on
	j.job_id = er.job_id
where
	e.employee_nm = pname;
end; $$

language 'plpgsql';

select * from human_resources.get_current_and_past_job('Toni Lembeck');



------------------------------------------------------------------------------
-- Implement user security on the restricted salary attribute.​

CREATE ROLE "NoMgr" NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN PASSWORD 'pg@123#';

grant select on all tables in schema human_resources to "NoMgr";
grant insert on all tables in schema human_resources to "NoMgr";
grant update on all tables in schema human_resources to "NoMgr";
grant delete on all tables in schema human_resources to "NoMgr";
grant references on all tables in schema human_resources to "NoMgr";

REVOKE ALL ON TABLE human_resources.salary FROM "NoMgr";