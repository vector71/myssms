--# LinkedIn: SQL Complex companies Problem
-- Link: https://www.linkedin.com/posts/naraharsha224_sql-datascience-dataengineering-activity-7015519581171585024-kCxP?utm_source=share&utm_medium=member_desktop
-- Problem:  There's a company which allows only one entry to their employees in a day, so what happened is if a person A can only enter once into the 
-- company but while entering the employee should give their email-id and the problem here is the same person can enter again into the company by giving different email-id in a day.

-- Write a query to fetch that how many times an employee entered into the company, the most visited floors and resources used inside the company.
/*
Steps followed:
 Fetched distinct employee names by eliminating duplicates.

 Used COUNT function to count the number of floors visited by each employee.

 Used Window and COUNT function to fetch the most visited floors by an employee.

 Used string aggregate function to gather the distinct resources together used by an employee
*/

-- lets create table first
create table entries ( 
			name varchar(20),
			address varchar(20),
			email varchar(20),
			floor int,
			resources varchar(10)
);

-- lets insert some data
insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
('B','Bangalore','B@gmail.com',2,'DESKTOP'),
('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR')

SELECT * FROM entries

-- step 1 distint names
WITH enames AS
		( SELECT DISTINCT name as emp_name FROM entries)
-- step 2 count of floot visited
, visits AS
		( SELECT name, COUNT(address) as no_of_visits FROM entries group by name)
-- step 3 most visited floor
,visited_floor AS
		( SELECT name, floor as most_visited_floor,visited_floor_count
		  FROM (SELECT name, floor, count(floor) AS visited_floor_count, DENSE_RANK() OVER(PARTITION by name ORDER BY COUNT(floor) DESC) as dr
				FROM entries 
				GROUP BY name,floor
				) A
		  WHERE  dr = 1
		)
-- step 4 resources used
,res AS
	(SELECT name, STRING_AGG(resources,',') as resource_used
	FROM ( SELECT DISTINCT name, resources
			FROM entries
			) B
	GROUP BY name
	)

SELECT e.emp_name, v.no_of_visits, vf.most_visited_floor, r.resource_used
FROM enames e
JOIN visits v			ON v.name = e.emp_name
JOIN visited_floor vf	ON vf.name = e.emp_name
JOIN res r				ON r.name = e.emp_name 