# Orion-Data-Systems-Workforce-SQL-Analytics

Orion Data Systems is a multinational consulting and technology firm headquartered in  San Francisco, USA, with offices spanning Europe, Asia, and the Americas. This project  simulates a real-world data analyst engagement where the HR &amp; Strategy team needed  SQL-driven insights from their workforce database to support business decision-making.

This capstone covers eight business questions spanning workforce distribution, salary 
analysis, country-level operations, and workforce gap identification.


## Database Schema
| Table | Key Columns |
|-------|------------|
| `employees` | employee_id, emp_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_name, department_id, country_id |
| `departments` | department_id, department_name, manager_id, location_id |
| `jobs` | job_id, job_title, min_salary, max_salary |
| `countries` | country_id, country_name, region |

The first statement on the SQL dataset runs a stored procedure to return all associated tables in the dataset.
## Dataset Tables
![Tables](table_pg1.png)

## 📂 Dataset
The raw data used for this analysis is provided as CSV files. These were imported into 
MySQL under the `capstone` schema to form the working database.
