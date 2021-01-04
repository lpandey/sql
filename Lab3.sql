-- drop tables if they existed before
drop table employees, job_history, jobs, departments, locations ;

-- run Script_Create_Tables.sql to create tables (employees, job_history, jobs, departments, locations)

-- variable with path to files
--\set mydir '/Users/User/SQL-for-DataScience'
-- \set scrptf : mydir '/Script_Create_Tables.sql'

-- \i allows including another sql file
-- \i scrptf
\i Script_Create_Tables.sql

-- copy employees data into employees table
--\set emplf : mydir '/Employees.csv'
-- copy employees from 'emplf' delimiter ',' csv ; -- (didn't work, required \copy)
\copy employees from 'Employees.csv' delimiter ',' csv ; -- (header if in csv)

-- Lab 3: String Patterns, Sorting, and Grouping

-- Query 1: Retrieve all employees whose address is in Elgin,IL
select * from employees where address like '%Elgin%' ;

-- Query 2: Retrieve all employees who were born during the 1970's.
select * from employees where b_date like '197%' ;

-- Query 3: Retrieve all employees in department 5 whose salary is between 60000 and 70000
select * from employees
where (salary between 60000 and 70000) and dep_id = 5 ;

-- Query 4A: Retrieve a list of employees ordered by department ID
select * from employees order by dep_id ;

-- Query 4B: Retrieve a list of employees ordered in descending order by department ID
-- and within each department ordered alphabetically in descending order by last name.
select l_name, f_name, b_date, address, salary, dep_id
	from employees
	order by dep_id desc, l_name desc ;
	
-- Query 5A: For each department ID retrieve the number of employees in the department.
select dep_id, count(*) as Num_of_Employees
	from employees
	group by dep_id ;
	
-- Query 5BC: For each department retrieve the number of employees in the department, 
-- and the average employees salary in the department. label computed columns
select dep_id, count(*) as Num_Employees, avg(salary) as avg_salary
	from employees
	group by dep_id ;

-- Query 5D: In Query 5BC order the result set by Average Salary.	
select dep_id, count(*) as Num_of_Employees, avg(salary) as avg_salary
	from employees
	group by dep_id
	order by avg(salary) ;
	
-- Query 5E: In Query 5D limit the result to departments with fewer than 4 employees
select dep_id, count(*) as Num_of_Employees, avg(salary) as avg_salary
	from employees
	group by dep_id having count(*) < 4
	order by avg(salary) ;

-- see contents of table departments
-- \copy departments from 'Departments.csv' delimiter ',' csv ; -- had duplicate "no null id"
\copy departments from 'Departments-copy.csv' delimiter ',' csv ; -- header (if header)
select * from departments ;

-- BONUS Query 6: Similar to 4B but instead of department ID use department name.
-- Retrieve a list of employees ordered by department name, and within each department
-- ordered alphabetically in descending order by last name.
select d.dep_name, e.l_name, e.f_name
from employees as e, departments as d
where e.dep_id = d.dept_id_dep
order by d.dep_name, e.l_name desc ;
