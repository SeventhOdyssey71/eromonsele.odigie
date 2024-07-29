-- Review on the SELECT statement --
SELECT *
FROM employeeinfo;

SELECT DISTINCT gender, AVG (age)
FROM employeeinfo
GROUP BY gender;

SELECT AVG (salary)
FROM employeesalary;

SELECT *
FROM employeesalary;

-- Review on Creating and Updating Tables --

CREATE TABLE company_managers (
manager_id int,
first_name varchar(30), 
last_name varchar(30), 
age int, 
gender text, 
nationality varchar (30)
);

INSERT INTO company_managers 
VALUES (101, 'Eromonsele', 'Odigie', 22, 'male', 'Nigerian'),
	   (102, 'Charles', 'Schweinsteiger', 34, 'male', 'German'),
       (103, 'Meredith', 'Lewis', 21, 'female', 'Canadian'),
       (104, 'Ogheneovo', 'Wetan', 33, 'male', 'Nigerian'),
       (105, 'Victoria', 'Coquelin', 26, 'female', 'French')
;

CREATE TABLE managers_salary (
manager_id int,
first_name varchar(30), 
last_name varchar(30), 
salary int, 
company_role text
);
INSERT INTO managers_salary 
VALUES (101, 'Eromonsele', 'Odigie', 525000, 'owner'),
	   (102, 'Charles', 'Schweinsteiger', 110000, 'HR'),
       (103, 'Meredith', 'Lewis', 250000, 'data-analyst'),
       (104, 'Ogheneovo', 'Wetan', 425000, 'co-owner'),
       (105, 'Victoria', 'Coquelin', NULL, NULL)
;

SELECT *
FROM company_managers
;

-- Using WHERE clause (Logic AND OR, Values, Like) --

SELECT COUNT(manager_id)
FROM company_managers
WHERE age + 20 < 45
;   -- This query basically answers the question of 'How many of our workers would be less than 45 years old in 20 years time --

SELECT *
FROM company_managers
WHERE nationality LIKE '%er%'
; -- This query shows managers with 'er' in their nationality. The outputs were nigERian and gERman --

SELECT *
FROM company_managers
WHERE manager_id < 105 AND age > 24
; -- This query shows the id of managers below 105 are older than 24 years --

SELECT *
FROM company_managers
WHERE gender = 'male' OR age > 24
; -- This query shows managers who are male or are older than 24 years --

-- Next, GROUP BY and ORDER BY, Using aggregate functions MAX, MIN, COUNT, AVG --

SELECT gender, age
FROM company_managers
GROUP BY gender, age
; 

SELECT gender, AVG(age)
FROM company_managers
GROUP BY gender
; -- This query groups the gender of managers and draws up a column showing their average age --

SELECT gender, MAX(age)
FROM company_managers
GROUP BY gender
;  -- This query selects the maximum age of males and females--

SELECT gender, age
FROM company_managers
ORDER BY gender, age DESC
;  -- This query selects both gender and age and arranges them in descending order --

-- Up Next, we would be talking about Having vs Where statements --

-- Consider the Error below:

SELECT gender, AVG(age)
FROM company_managers
WHERE AVG(age) > 23
GROUP BY gender; -- This code would not run because you cannot take an avg when the table hasn't been grouped yet --

-- The solution to the error is by using a HAVING statement. Note, the having statement always comes after the GROUP BY statement

SELECT gender, AVG(age)
FROM company_managers
GROUP BY gender
HAVING AVG(age) > 24
; -- This then shows the grouping of managers by gender and shows the groupings as well as their avg age --

-- Let's try using HAVING and WHERE in one statement --

SELECT nationality, AVG(age)
FROM company_managers
WHERE nationality LIKE '%er%'
GROUP BY nationality
HAVING AVG(age) > 20
; -- Yes Sirr! This is an example of how you can use the HAVING and WHERE statements in one query --

-- Let's move on to the last topic in the SQL beginner series, LIMIT and ALIASING --
-- Limit restricts the number of outputs that are displayed 
-- Aliasing is used to change column names, especially when the column names are long and weirdly formatted

SELECT first_name, 
concat(first_name, ' ', last_name) AS full_name -- Basically, I used AS to change the name of that column --
FROM company_managers
; -- Oops, I used concat too early, lol.. but that's how to do aliasing.

SELECT *
FROM company_managers
LIMIT 2,1 -- This counts the first two rows and takes the next line after it --
;

SELECT *
FROM company_managers
LIMIT 4 -- This takes only the first four rows and displays them--
;

-- With that, we have come to the end of the beginner series for SQL. I hope you learnt enough and had fun?? Let's move on to the intermediate --

-- In the intermediate, there are SIX topics 1. Joins 2. Unions 3. String Functions 4. Case Statements 5. Subqueries 6. Window Functions --
-- Step by Step and we would get it all done

-- 1. Joins
SELECT *
FROM managers_salary
; 
-- We would join the company_managers table and the managers_salary table now --
SELECT info.manager_id, concat(info.first_name, ' ', info.last_name) AS full_name,
		info.age, sal.salary, sal.company_role
FROM company_managers AS info
JOIN managers_salary AS sal
	ON info.manager_id = sal.manager_id
; -- Now, we have joined the two tables on the manager_id and have selected the fields we want to be visualized. We can now use order by here.

SELECT info.manager_id, concat(info.first_name, ' ', info.last_name) AS full_name,
		info.age, sal.salary, sal.company_role
FROM company_managers AS info
JOIN managers_salary AS sal
	ON info.manager_id = sal.manager_id
ORDER BY age, salary DESC
;
-- What we have done here represents ONLY an INNER join. Let's take a look at the other types of join
-- We have four types of joins: INNER Join, LEFT Join, RIGHT Join and FULL OUTER Join -- Please Confirm THIS !--
SELECT *
FROM employeeinfo AS emp
LEFT JOIN employeesalary AS empsal
	ON emp.employee_id = empsal.employee_id
;
-- Let me just quickly delete data from the table --
DELETE FROM employeeinfo
WHERE firstname = 'Gary'; -- So I have been able to delete Gary from the table

-- Now let's run the code again --
SELECT *
FROM employeeinfo AS emp
LEFT JOIN employeesalary AS empsal
	ON emp.employee_id = empsal.employee_id
; -- With a left join, only elements on the left which are on the right are displayed

SELECT *
FROM employeeinfo AS emp
RIGHT JOIN employeesalary AS empsal
	ON emp.employee_id = empsal.employee_id
; 
-- Everything on the right is displayed and on the left, it will be shown as null values
-- The right join is an inverse of the case of the left join

SELECT *
FROM employeeinfo AS emp
JOIN employeesalary AS empsal
	ON emp.employee_id = empsal.employee_id
; 
-- Joining more than two tables
SELECT *
FROM employeeinfo AS emp
JOIN employeesalary As sal
	ON emp.employee_id = sal.employee_id
JOIN dept_info AS dep
	ON sal.dept_id = dep.dept_id
; -- With this query, I have successfully joined three tables together -

-- You can also join a table to itself
SELECT com1.first_name, com1.last_name, com2.age, com2.nationality
FROM company_managers AS com1
JOIN company_managers AS com2
	ON com1.manager_id = com2.manager_id
;
-- UNIONS in MySQL -- Let's look at Unions in MySQL 
SELECT employee_id, occupation, salary, dept_id
FROM employeesalary
UNION
SELECT employee_id, firstname, lastname, age
FROM employeeinfo
UNION
SELECT employee_id, occupation, salary, dept_id
FROM employeesalary
UNION
SELECT employee_id, firstname, lastname, age
FROM employeeinfo; -- Union is used to join rows of data together, it can be used more than once in a particular query --
-- By default, just using UNION selects distinct values. To show all values, you can use the UNION ALL syntax --

-- String Functions (Length or Len, Trim, LTrim, RTrim, Substring, Replace, Locate, Concat) --
-- 1. Length: This is gives the length of an element
SELECT salary, length(salary) AS 'Figures Earned(USD)'
FROM managers_salary;
-- 2. Trim: Trim is used to remove whitespaces and elements not needed
SELECT TRIM(         'Eromonsele.'                );
-- Now, I have trimmed the white spaces, TRIM can also be used to remove elements that are not needed --
SELECT ('    Eromonsele         ' ) AS original, TRIM(TRIM(TRAILING '.' FROM '           Eromonsele      ')) AS no_full_stop  ; 
-- Sweeeeeet!! -- Know that LTRIM and RTRIM only take off white spaces to the left and right respectively... Useless??

INSERT INTO company_managers 
VALUES (106, 'Oreva', 'Omanudhowho', 24, 'male', 'Uhrobo');
INSERT INTO managers_salary 
VALUES (106, 'Oreva', 'Omanudhowho', 99000, 'Data Intern'); --  Let's Sneak Oreva into the company quickly, but as an Intern first

-- 3. Substring (With substring, you can select a particular part of a string you wait)
SELECT first_name, SUBSTRING(first_name, 1, 5) AS short_name
FROM company_managers; -- With this, we started from the first character in the firstname and counted five characters --

-- Let's try something crazy now. I want to do something like a full security --
SELECT first_name, concat(SUBSTRING(first_name, 1, 3), '***') AS hidden_name
FROM company_managers;
-- Okayyy, this looks good --

-- 4. Replace
SELECT REPLACE ('Eromonsele', 'n', '')
;
-- Let's try this in an actual table
SELECT first_name, replace(first_name,'n', '') AS eliminating_the_n
FROM company_managers;
-- Now let me go all wild with this ! if this works, i'll be so ecstatic ..... DIDN'T WORK--
SELECT first_name, replace(first_name,'n', '') AS eliminating_the_n
FROM company_managers
LIMIT 0,1
;
-- 5. Locate- This is used to look for the position of an element. Let's check that out!
SELECT *, locate('Nigerian', nationality) AS location
FROM company_managers
ORDER BY location DESC
LIMIT 2;
-- 6. Concat ( I have already used this one a lot, but just to write one query) --
-- Let me make this query very fun --
SELECT manager_id, concat(first_name, ' ',last_name) AS full_name, concat(nationality, ' ',gender) AS manager_profile
FROM company_managers
;
-- Beautiful --
SELECT *
FROM company_managers
;
-- Case Statements --
-- Let's dive straight into this one
SELECT manager_id, concat(first_name, ' ',last_name) AS full_name, concat(nationality, ' ',gender) AS manager_profile, 
CASE 
	WHEN nationality = 'Nigerian' 
    OR nationality = 'Uhrobo'
    THEN 'Home Based Worker' 
    ELSE 'Foreign Worker'
END AS worker_status
FROM company_managers
;
/*SELECT *
FROM company_managers; */

-- Subqueries - A subquery is a query embedded in another query
SELECT manager_id, full_name, manager_profile 
FROM(
SELECT manager_id, concat(first_name, ' ',last_name) AS full_name, concat(nationality, ' ',gender) AS manager_profile, 
CASE 
	WHEN nationality = 'Nigerian' 
    OR nationality = 'Uhrobo'
    THEN 'Home Based Worker' 
    ELSE 'Foreign Worker'
END AS worker_status, age
FROM company_managers) AS what_the_boss_wants
WHERE age < 23
;
-- Window Functions --
-- Dataset too lim"|" , use larger dataset, preferably figures --
-- OVER(PARTITION BY column_name)







