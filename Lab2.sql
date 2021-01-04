-- lab2 tasks
-- 0. Drop table INSTRUCTOR in case it already exists

--1. Create table INSTRUCTOR

--2A. Insert single row for Rav Ahuja

--2B. Insert the two rows for Raul and Hima

--3. Select all rows in the table

--3b. Select firstname, lastname and country where city is Toronto

--4. Change the city for Rav to Markham

--5. Delete the row for Raul Chong

--5b. Retrieve all rows from the table
	
-- lab2
-- task 0
drop table INSTRUCTOR;		

-- tast 1
create table INSTRUCTOR (
	INS_ID integer PRIMARY KEY NOT NULL,
	LASTNAME varchar(60) NOT NULL,
	FIRSTNAME varchar(60) NOT NULL,
	CITY varchar(20),
	COUNTRY Char(2)
	);

-- task 2A
INSERT INTO INSTRUCTOR
	(INS_ID, LASTNAME, FIRSTNAME, CITY, COUNTRY)
	
	VALUES
	('1', 'AHUJA', 'RAV',  'TORONTO', 'CA');

-- task 2B
INSERT INTO INSTRUCTOR
	(INS_ID, LASTNAME, FIRSTNAME, CITY, COUNTRY)
	
	VALUES
	('2', 'CHONG', 'RAUL', 'TORONTO', 'CA'),
	('3', 'VASUDEVAN', 'HIMA', 'CHICAGO', 'US');

-- task 3
select * from INSTRUCTOR;

-- task 3B
select FIRSTNAME, LASTNAME, COUNTRY from INSTRUCTOR where CITY = 'TORONTO';

-- task 4
update INSTRUCTOR set CITY='MARKHAM' where INS_ID=1;

-- task 5
delete from INSTRUCTOR where INS_ID=2;

-- task 5B
select * from INSTRUCTOR;