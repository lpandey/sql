-- runing .sql file in mac (after brew install postgresql)
-- start/stop server: start at beginning (and stop when done)
-- pg_ctl -D /usr/local/var/postgres start (or stop)
-- psql -d postgres -a -f Lab2.sql -- postgers is the default database

drop table AUTHOR;
create table AUTHOR (
	AUTHOR_ID varchar(2) PRIMARY KEY NOT NULL,
	LASTNAME varchar(60),
	FIRSTNAME varchar(60),
	EMAIL varchar(60),
	CITY varchar(20),
	COUNTRY Char(2)
	);

-- single line comments start with --
-- multiple line comments start with /* and end with */ as below
/*
 * select COLUMN1, COLUMN2, ... from TABLE1 ;
 * select * from COUNTRY ; -- select all rows
 * select * from COUNTRY where ID < 5 ;
 * select * from COUNTRY where CCODE = 'CA';
 * select COUNT(*) from tablename;
 * select count(COUNTRY) from MEDALS where COUNTRY = 'CA';
 * update TABLENAME SET LASTNAME=lastname FIRSTNAME=firstname where AUTHOR_ID=A2;
 * delete from AUTHOR where author_id in('A2', 'A3');
*/

INSERT INTO AUTHOR
	(AUTHOR_ID, LASTNAME, FIRSTNAME, EMAIL, CITY, COUNTRY)

	VALUES
	('A1', 'CHONG', 'RAUL', 'RFC@IBM.COM', 'TORONTO', 'CA'),
	('A2', 'AHUJA', 'RAV', 'RA@IBM.COM', 'TORONTO', 'CA'),
	('A3', 'HAKES', 'IAN', 'IH@IBM.COM', 'TORONTO', 'CA'),
	('A4', 'SHARMA', 'NEERAJ', 'NS@IBM.COM', 'CHENNAI', 'IN'),
	('A5', 'PERNIU', 'LIVIU', 'LP@IBM.COM', 'TRANSYLVANIA', 'RO');

-- Retrieving Rows using String Pattern
\* select firstname from author
    where firstname like 'R%'; -- % is wildcard
*\

\* select title, pages from book
    where pages between 290 and 300; -- edges inclusive
-- equivalent to: where pages >= 290 and pages <=300
-- or is also allowed. in ('option', 'option2', ...) if more than two
*\

select firstname, lastname, country from Author
    where country='AU' or country='BR';

select firstname, lastname, country from Author
    where country in ('AU', 'BR');

-- Sorting Results Sets
-- Ordery By clause
select title from Book
    Order by title; -- ascending order

-- for decending order
select title from Book
    Order by title Desc; -- descending order

-- order by column position
select title, pages from Book
    order by 2; -- pages the second column

-- Grouping Result Sets
select distinct(country) from Author; -- distinct avoids duplicates

select country, count(*)
    from Author Group by country; -- second result column has 
                                  -- author counts from the same country

select country, count(*) as Count
    from Author Group by country; -- result column gets name "Count"

select country, count(*) as Count
    from Author group by country
    having count(country) > 4 ; -- only counts > 4 displayed in results
    
-- some builtin functions: sum(), min(), max(), avg(),
--    round(), length(), ucase, lcase, distinct(), etc.
select avg(cost/quantity) from petrescue where animal = 'Dog' ;


select (rescuedate + 3 days) from petresque

-- including another sql file
\i Script_Create_Tables.sql -- \i allows calling script file

-- copy file.csv data into table
\copy employees from 'Employees.csv' delimiter ',' csv ; -- (header if exists)

-- Sub-Queries and Nested Selects
select column1 from table
    where column2 = (select max(column2) from table) ;
   
-- aggregate functions like avg() cannot be used in Where clause therefore it is necessary to use them as sub-Queries
select f_name, l_name, salary
    from employees
    where salary > (select avg(salary) from employees) ;
    
select emp_id, salary,
    ( select avg(salary) from employees) ) as avg_salary
    from employees ;
    
-- derived tables and table excpressions
select * from 
    (select emp_id, f_name, l_name, dep_id from employees) as emp4all ;
    
-- working with multiple tables
select * from employees
    where dep_id in 
    (select dept_id_dep from departments) ;
    
select * from employees
    where dep_id in 
    (select dept_id_dep from departments where loc_id = 'L0002') ;
    
select dept_id_dep, dep_name from departments
    where dept_id_dep in
    (select dep_id from employees where salary > 70000 ) ;

-- full join (cartesian join)
select * from employees, departments ;

-- limit result set
select emp_id, dep_name from employees e, departments d
    where e.dep_id = d.dept_id_dep ;
    
select e.emp_id, d.dep_name from employees e, departments d
    where e.dep_id = d.dept_id_dep ;

-- visualizations and tools
---------------------------
-- seaborn swarmplot seaborn.swarmplot(x='', y='', data=dataframe)
-- plt.setp(plot.get_xticklabels(), rotation=70)
-- df['columnTitle'].describe()
-- df['ColumnTitle'].idmax() # index of the max data
-- df.at[indexnumber, 'ColumnTitle']
-- seaborn scatterplot by 'jointplot' option sns.jointplot(x, y, data=dataframe)

-- boxplot
\* plot = sns.set_style('whitegrid')
ax = sns.boxplot(x=df['Sugars'])
plot.show()
*\

-- limit result rows
select * from table limit 3; -- limits to 3 rows only

-- get all column names in a table
select * from information_schema.columns where table_name = 'myTable';