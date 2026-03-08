USE capstone;
-- created a stored procedure to return all associated tables whenever i need them
DELIMITER //
CREATE PROCEDURE capstone.run_capstone_1()
BEGIN
	SELECT * FROM countries;
	SELECT * FROM departments;
	SELECT * FROM employees;
	SELECT * FROM jobs;
END //
DELIMITER ;
CALL run_capstone_1;

-- 1. Workforce Distribution (Total count of employees in each department & the department with the highest headcount)
SELECT 
    d.department_name, COUNT(e.employee_id) AS employee_count
FROM
    departments AS d
        INNER JOIN
    employees AS e ON d.department_id = e.department_id
GROUP BY department_name
ORDER BY employee_count DESC; -- From the Query, Shipping department has the highest headcount of employees

-- 2. Salary comparison (What is the average salary per department and which departments has the highest and lowest average salaries)
-- Average Salary per department
SELECT d.department_name, ROUND(AVG(salary),0) AS average_salary
FROM departments AS d
INNER JOIN employees as e
ON d.department_id = e.department_id
GROUP BY department_name
ORDER BY average_salary DESC;

-- Departments with the highest and lowest average salaries
WITH dept_avg AS (
SELECT d.department_name, ROUND(AVG(salary),0) AS average_salary
FROM departments AS d
INNER JOIN employees as e
ON d.department_id = e.department_id
GROUP BY d.department_name
)
SELECT *
FROM dept_avg
WHERE average_salary = (SELECT MAX(average_salary) FROM dept_avg)  
   OR average_salary = (SELECT MIN(average_salary) FROM dept_avg);
   
   -- 3. Salary Bands for employees
  SELECT 
    emp_name,
    salary,
    CASE
        WHEN salary > 10000 THEN 'High'
        WHEN salary BETWEEN 5000 AND 10000 THEN 'Medium'
        WHEN salary < 5000 THEN 'Low'
        ELSE 'No Value'
    END AS salary_category
FROM
    employees;

-- Count of employees on each category
 SELECT 
    COUNT(employee_id) AS employee_count,
    CASE
        WHEN salary > 10000 THEN 'High'
        WHEN salary BETWEEN 5000 AND 10000 THEN 'Medium'
        WHEN salary < 5000 THEN 'Low'
        ELSE 'No Value'
    END AS salary_category
FROM
    employees
GROUP BY salary_category;

-- 4. Country-Level Analysis (listed all countries in which Orion data systems operates, showing the No of dept located on each country respectively)
SELECT c.country_name, COUNT(DISTINCT e.department_id) AS department_count 
FROM countries AS c
INNER JOIN employees AS e
ON c.country_id = e.country_id
GROUP BY c.country_name;

-- 5. High Earners 
SELECT 
    emp_name, salary
FROM
    employees
WHERE
    salary > (SELECT 
            ROUND(AVG(salary), 0)
        FROM
            employees)
ORDER BY salary DESC;

-- 6. Job Analysis (shows the calculation of the average salary for each job title respectively and identifies the job titles with average salary > 12k
SELECT j.job_title,
       ROUND(AVG(e.salary), 0) AS average_salary
FROM jobs AS j
INNER JOIN employees AS e
    ON j.job_id = e.job_id
GROUP BY j.job_title
ORDER BY average_salary DESC;

-- jobs titles with average salaries > 12,000
SELECT j.job_title,
       ROUND(AVG(e.salary), 0) AS average_salary
FROM jobs AS j
INNER JOIN employees AS e
    ON j.job_id = e.job_id
GROUP BY j.job_title
HAVING AVG(e.salary) > 12000
ORDER BY average_salary DESC;

-- 7. salary growth trend (shows the total salaries paid to employees in each country)
SELECT c.country_name, SUM(e.salary) AS total_salary_cost
FROM employees AS e
INNER JOIN countries AS c
ON e.country_id = c.country_id
GROUP BY country_name
ORDER BY total_salary_cost DESC;

-- 8. Identify all job roles in the company (jobs table) that currently have no employees assigned
SELECT j.job_title, e.emp_name
FROM jobs AS j
INNER JOIN employees AS e
ON j.job_id = e.job_id
WHERE e.emp_name IS NULL;
