
:office:
**1. Count the number of employees per department and find which department has the biggest monthly income:**

```sql
SELECT
	COUNT(*) as n_workers,
	department,
	SUM(monthly_income) as departments_earnings
FROM emp_attrition
GROUP BY department
ORDER BY departments_earnings DESC
```

**Result:**

|n_workers	| departments_earnings	| department|
|----------------|:---------------------:|:----------:|
|961		|6036284| Research & Development|
|446		| 3103791| Sales|
|63		| 419234| Human Resources|

___

:school:	
**2. Display how many employees are college educated and if their level of education correlates with their position at the company:**

**a) Number of college educated employees**
```sql
SELECT
	COUNT(CASE WHEN sd.education_description = 'College' THEN 1
		WHEN sd.education_description IN ('Bachelor','Master','Doctor') THEN 1 END) AS college_educated,
	COUNT(*) AS total_workers
FROM emp_history eh
LEFT JOIN survey_details sd
	ON eh.education = sd.id
```

*Explanation:*
- I decided to use equal sign '=' in ```COUNT(CASE WHEN sd.education_description = 'College' THEN 1``` instead of IN because employees without college diploma were noted as 'below college'. 

**Result**:
|college_educated|total_workers|
|:---------------:|:----------:|
|1300|1470|

___
	
**b) The correlation between education history and the level of job position**
```sql
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

**Result:**
|workers|job_lvl|education_description|
|-------|-------|---------------------|
|231|1|Bachelor|
|171|2|Bachelor|
|98|3|Bachelor|
|44|4|Bachelor|
|28|5|Bachelor|
|89|1|Below College|
|47|2|Below College|
|20|3|Below College|
|8|4|Below College|
|6|5|Below College|
|94|1|College|
|125|2|College|
|33|3|College|
|17|4|College|
|13|5|College|
|8|1|Doctor|
|20|2|Doctor|
|9|3|Doctor|
|9|4|Doctor|
|2|5|Doctor|
|121|1|Master|
|171|2|Master|
|58|3|Master|
|28|4|Master|
|20|5|Master|

___

:moneybag:
**3. What is the lowest salary of a pHD educated employee and what is the highest salary of employee without college education?**
    
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

**Result**:

|doctor_lowest_income |below_college_highest_income|
|:-------------------:|:--------------------------:|
|2127                |19973             |

___

:briefcase:
**4. How many employees hold a director level position and out of all employees what percentage they make?**
    
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


**Result**:
|n_directors|percent_of_directors|
|-----------|--------------------|
|225|15.3|

___

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
|emp_id	|monthly_income|income_rank|
|-------|--------------|-----------|
|259	|19999|	1|
|1035	|19973|	2|
|1191	|19943|	3|
|226	|19926|	4|
|787	|19859|	5|
|1282	|19847|	6|
|1038	|19845|	7|
|1740	|19833|	8|
|1255	|19740|	9|
|1338	|19717|	10|

___

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

**Result**:
|department|dept_avg_income|dept_previous_income|
|----------|---------------|--------------------|
|Sales|6959.2|6046.2|
|Human Resources|6654.5|5796.6|
|Research & Development|6281.3|5447.8|

___

:calendar:	
**7. Years needed for promotion (data includes only the employees who have been promoted at least once):**

```sql
	SELECT 
		ROUND(AVG(Years_At_Company) / AVG(Years_Since_Last_Promotion), 1) 
AS years_needed_for_promotion
FROM emp_history
WHERE Years_Since_Last_Promotion > 0
```
**Result:**
|years_needed_for_promotion|
|--------------------------|
|2.4|

___

:pushpin:	
**8. Find the average distance from home and the number of employees who live further than the average :**

a) The average distance:
```sql
SELECT
	ROUND(AVG(Distance_From_Home),1) AS avg_distance
FROM satisfaction_survey
```

b) Employees who live further than that:
```sql
SELECT
	COUNT(*) as workers_who_live_far
FROM satisfaction_survey 
WHERE distance_from_home > (SELECT AVG(distance_from_home)
							FROM satisfaction_survey)
```
**Results:**
a)
|avg_distance|
|-----------|
|9.2|


b)
|workers_who_live_far|
|-------|
|530|

___

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
**Result:**
|marital_status|all_employees|employees_with_overtime|percentage_with_overtime|
|:------------:|:-----------:|:--------------------:|:----------------------:|
|Divorced| 327|99| 30.3|
|Single| 470| 131| 27.9|
|Married| 673|186|27.6|

___

:bar_chart:
**10. Years and attrition. Who was more keen to leave the company: long-time employees or the ones who’ve only just started working at the company?**

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

**Result**:

|seniority_level|all_employees|resigned|percentage_resigned|
|---------------|-------------|--------|------------------|
|junior|215|75|34.9|
|mid|561|87|15.5|
|senior|694|75|10.8|

___

:page_facing_up:
**11. The results of the survey versus reality. How many people who evaluated their job satisfaction as low stayed at company and the opposite – how many employees who described their satisfaction as very high ended up leaving:**

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

**Result:**
|n_left|n_stayed|
|------|--------|
|52|223|
