
-------------------------------------------------------------------------------
-- Author       Fabio Augusto Pereira
-- Created      31/05/2021
-- Purpose      Normalize data to HR tables
-- Copyright ©2021, Tech ABC Corp, All Rights Reserved
-------------------------------------------------------------------------------
-- Modification History
--
-- 31/05/20201  Fabio Augusto Pereira
--      Data normalization
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Author       Fabio Augusto Pereira
-- Created      31/05/2021
-- Purpose      Normalize data to HR tables
-- Copyright ©2021, Tech ABC Corp, All Rights Reserved
-------------------------------------------------------------------------------
-- Modification History
--
-- 31/05/20201  Fabio Augusto Pereira
--      Data normalization

-------------------------------------------------------------------------------
 insert
	into
	human_resources.job (job_nm)
select
	distinct job_title
from
	human_resources.proj_stg
order by
	job_title;

insert
	into
	human_resources.department (department_nm)
select
	distinct department_nm
from
	human_resources.proj_stg
order by
	department_nm;

insert
	into
	human_resources.education (education_level)
select
	distinct education_lvl
from
	human_resources.proj_stg
order by
	education_lvl;

insert
	into
	human_resources.location (location_nm)
select
	distinct location
from
	human_resources.proj_stg
order by
	location;

insert
	into
	human_resources.state (state_nm,
	location_id)
select
	st.state,
	l.location_id
from
	human_resources.proj_stg st
inner join human_resources.location l on
	st.location = l.location_nm
group by
	l.location_id,
	st.state
order by
	l.location_id;

insert
	into
	human_resources.city(city_nm,
	state_id)
select
	st.city,
	s.state_id
from
	human_resources.proj_stg st
inner join human_resources.state s on
	st.state = s.state_nm
group by
	st.city,
	s.state_id
order by
	st.city;

insert
	into
	human_resources.address (address_desc,
	city_id)
select
	st.address,
	c.city_id
from
	human_resources.proj_stg st
inner join human_resources.city c on
	st.city = c.city_nm
inner join human_resources.state s on
	st.state = s.state_nm
group by
	st.address,
	c.city_id
order by
	st.address;

insert
	into
	human_resources.employee (employee_id,
	employee_nm,
	employee_email,
	education_id,
	hire_date)
select
	distinct st.emp_id,
	st.emp_nm,
	lower(st.email),
	e.education_id,
	st.hire_dt
from
	human_resources.proj_stg st
inner join human_resources.education e on
	st.education_lvl = e.education_level
group by
	st.emp_id,
	st.emp_nm,
	lower(st.email),
	e.education_id,
	st.hire_dt
order by
	st.emp_nm;

insert
	into
	human_resources.salary (salary_value)
select
	distinct st.salary
from
	human_resources.proj_stg st;

insert
	into
	human_resources.employee_registry (employee_id,
	job_id,
	start_date,
	end_date,
	manager_id,
	salary_id,
	department_id,
	address_id)
select
	e.employee_id,
	j.job_id,
	st.start_dt,
	st.end_dt,
	emp_mg.employee_id,
	sal.salary_id,
	d.department_id,
	ad.address_id
from
	human_resources.proj_stg st
inner join human_resources.employee e on
	st.emp_nm = e.employee_nm
left join human_resources.employee emp_mg on
	st.manager = emp_mg.employee_nm
inner join human_resources.job j on
	st.job_title = j.job_nm
inner join human_resources.salary sal on
	cast(st.salary as money) = cast(sal.salary_value as money)
inner join human_resources.department d on
	st.department_nm = d.department_nm
inner join human_resources.address ad on
	st.address = ad.address_desc;