--create a retirement titles table
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
Order by emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Retrieve the number of retiring employees by job title
Select count (title) as "count", title
INTO retiring_titles
from unique_titles
group by title
order by "count" DESC;

--create a mentorship eligibilty table
SELECT DISTINCT ON (emp_no)
	e.emp_no,
    e.first_name,
    e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
    t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
Order by emp_no;

--create a second retirement titles table
--for individuals from 1956-1959
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO further_retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1956-01-01' AND '1959-12-31')
Order by emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
emp_no,
first_name,
last_name,
title
INTO further_unique_titles
FROM further_retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Retrieve the number of retiring employees by job title
Select count (title) as "count", title
INTO further_retiring_titles
from further_unique_titles
group by title
order by "count" DESC;

select * from further_retiring_titles;
select sum(count) from further_retiring_titles;

--create a second mentorship eligibilty table
--this one has employees from 1965-1968
SELECT DISTINCT ON (emp_no)
	e.emp_no,
    e.first_name,
    e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
    t.title
INTO further_mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1962-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
Order by emp_no;

select count(*) from further_mentorship_eligibilty;

--Retrieve the number of mid-career employees by job title
Select count (title) as "count", title
INTO midcareer_titles
from further_mentorship_eligibilty
group by title
order by "count" DESC;

select * from midcareer_titles;
