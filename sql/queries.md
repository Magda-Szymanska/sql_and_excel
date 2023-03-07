1. Count the number of employees per department and find which department has the biggest
    monthly income:


```sql
SELECT
	COUNT(*) as n_workers,
	SUM(monthly_income) as departments_earnings,
	department
FROM emp_attrition
GROUP BY department
ORDER BY departments_earnings DESC
```
