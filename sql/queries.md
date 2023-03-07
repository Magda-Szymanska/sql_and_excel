:office:	
**1. Count the number of employees per department and find which department has the biggest
    monthly income:**

```sql
SELECT
	COUNT(*) as n_workers,
	SUM(monthly_income) as departments_earnings,
	department
FROM emp_attrition
GROUP BY department
ORDER BY departments_earnings DESC
```

:school:	
**2. Display how many employees are college educated and if their level of education corelates with their position at the company:**

```sql
SELECT
	COUNT(CASE WHEN sd.education_description = 'College' THEN 1
		WHEN sd.education_description IN ('Bachelor','Master','Doctor') THEN 1 END) AS college_educated,
	COUNT(*) AS total_workers
FROM emp_history eh
LEFT JOIN survey_details sd
	ON eh.education = sd.id;
SELECT
	COUNT(ea.emp_id) as workers,
    	ea.job_lvl,
    	sd.education_description
FROM emp_attrition ea
LEFT JOIN emp_history eh
	USING (emp_id)
LEFT JOIN survey_details sd
	ON eh.education = sd.id
GROUP BY ea.job_lvl, sd.education_description
ORDER BY sd.education_description, job_lvl, workers DESC
```

:moneybag:
**3. What is the lowest salary of a phD educated employee and what is the highest salary of employee without college education?**
    
```sql
WITH joined_tables AS (
  SELECT ea.emp_id, ea.monthly_income, eh.education, sd.education_description
FROM emp_attrition ea
LEFT JOIN emp_history eh
	ON ea.emp_id = eh.emp_id
LEFT JOIN survey_details sd 
	ON eh.education = sd.id
)
SELECT
	MIN(CASE WHEN education_description = 'Doctor' THEN monthly_income END) AS doctor_lowest_income,
	MAX(CASE WHEN education_description = 'Below College' THEN monthly_income END) AS b_college_highest_income
FROM joined_tables

```
:briefcase:
**4. How many employees are installed at directorial positions 
    and out of all employees what percentage they make?**
    
```sql
WITH n_dir AS (
  SELECT COUNT(CASE WHEN job_role LIKE '%director%' THEN 1 END) AS n_directors
  FROM emp_attrition
)
SELECT
n_directors,
ROUND((n_dir.n_directors) / (SELECT COUNT(*) from emp_attrition ea) * 100, 1)
AS percent_of_directors
FROM n_dir
```

:money_with_wings:	
**5. A rank of top 10 biggest earners at the company:**

```sql
SELECT *
FROM (
  SELECT
    emp_id,
    monthly_income,
    DENSE_RANK() OVER (ORDER BY monthly_income DESC) AS income_rank
  FROM emp_attrition
) AS subquery
WHERE income_rank <= 10;
```

:chart_with_upwards_trend:	
**6. Find the average salary per department and the average salary per department before the company-wide salary hike.**

```sql
WITH department_average AS
(SELECT
	department,
	ROUND(AVG(Monthly_Income),1) AS dept_avg_income,
    ROUND(AVG(Percent_Salary_Hike),1) AS dept_avg_hike
FROM emp_attrition
GROUP BY department)
SELECT
	department,
	dept_avg_income,
	ROUND(dept_avg_income / (1 + dept_avg_hike / 100),1) as dept_previous_income
FROM department_average
GROUP BY department
ORDER BY dept_avg_income DESC
```

:calendar:	
**7. Years needed for promotion (data includes only the employees who have been promoted at least once):**

```sql
	SELECT 
		ROUND(AVG(Years_At_Company) / AVG(Years_Since_Last_Promotion), 1) 
AS years_needed_for_promotion
FROM emp_history
WHERE Years_Since_Last_Promotion > 0
```

:pushpin:	
**8. Number of people who have never been promoted:**

```sql
SELECT
	COUNT(*) AS never_promoted
FROM emp_history
WHERE years_at_company = years_since_last_promotion
```

:ring:
**9. Is there a correlation between working overtime and employees’ marital status?**

```sql
SELECT
	marital_status,
	COUNT(*) AS all_employees,
	SUM(CASE WHEN overtime = 'yes' THEN 1 ELSE 0 END) as employees_with_overtime,
	ROUND(SUM(CASE WHEN overtime = 'yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1)
	AS percentage_with_overtime
FROM emp_attrition
GROUP BY marital_status
```

:bar_chart:
**10. Years and attrition. Who was more keen to leave the company: long-time employees or the ones who’ve only just started?**

```sql
WITH seniority_data as (
	SELECT
	emp_id,
	years_at_company,
		CASE 
			WHEN years_at_company <2 THEN 'junior'
			WHEN years_at_company BETWEEN 2 AND 5 THEN 'mid'
			WHEN years_at_company >5 THEN 'senior' 
            END AS seniority_level
FROM emp_history eh)
SELECT
	sd.seniority_level,
	COUNT(*) AS all_employees,
	SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS resigned,
	ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / (COUNT(*)) * 100, 1) as percentage_resigned
FROM emp_attrition ea
LEFT JOIN seniority_data sd
	USING (emp_id)
GROUP BY sd.seniority_level
ORDER BY percentage_resigned DESC
```


:page_facing_up:
**11. The results of the survey juxtaposed with reality. How many people who evaluated their job satisfaction as low stayed at company and the opposite – how many employees who described their satisfaction as very high ended up leaving:**

```sql 
WITH joined_tables AS (
  SELECT 
		ea.attrition,
        ea.emp_id,
        su.job_satisfaction,
		sd.satisfaction_description
FROM emp_attrition ea
LEFT JOIN satisfaction_survey su
	USING (emp_id)
LEFT JOIN survey_details sd 
	ON su.job_satisfaction = sd.id
)
SELECT left_data.n_left, stayed_data.n_stayed
FROM
  (SELECT COUNT(emp_id) AS n_left
   FROM joined_tables
   WHERE attrition = 'yes' AND satisfaction_description = 'very high') left_data
JOIN
  (SELECT COUNT(emp_id) AS n_stayed
   FROM joined_tables
   WHERE attrition = 'no' AND satisfaction_description = 'low') stayed_data
   ```
