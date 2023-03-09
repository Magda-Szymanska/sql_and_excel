:office:	
**1. Count the number of employees per department and find which department has the biggest
    monthly income:**
    
![department](https://i.imgur.com/oN5Aamg.png)
___
:school:💰	
**2. Display how many employees are college educated and if their level of education corelates with their position at the company:**

**3. What is the lowest salary of a pHD educated employee and what is the highest salary of employee without college education?**

![education and income](https://i.imgur.com/ruh8pYt.png)
___
:briefcase:
**4. How many employees hold a director level position and out of all employees what percentage they make?**
```excel
=COUNTIF(attrition!H:H,"*director*")
```
```excel
=($B$20/COUNTA(attrition!H2:H))
```
___
:money_with_wings:	
**5. A rank of top 10 biggest earners at the company:**

a) Ten highest salaries
```excel
=LARGE(INDIRECT("attrition!J$2:J$1471"), ROW(A1))
```

b) Additional information ('emp_id' column)
```excel
=INDEX(attrition!E2:E1471, MATCH(LARGE(attrition!J2:J1471, ROW(A1)), attrition!J2:J1471, 0))
```

c) Rank column
```excel
=RANK.EQ($B6,$B$6:$B$15,0)
```


*Explanation:*
- I used =LARGE formula to find the biggest salary in 'attrition!J$2:J$1471' a.k.a 'monthly_income' column.
- The formula is supplemented by ROW(A1) which allowed me to find the second, third, forth etc. values.
- Next, I chose INDEX&MMATCH to find my additional data - each employee's id. I added '0' value to find the exact value for each row. The 'attrition!E2:E11471' column contains emp_id.
- The $B6 in =RANK.EQ formula stands for a first cell in the 'ten highest salaries' column, while '$B$6:$B$15' is the range of 'ten highest salaries'.



**Result:**
|Monthy Income| Emp_Id| Rank|
|------------|--------|-----|
|19999	|259   | 1|
|19973	|1035	|2|
|19943	|1191	|3|
|19847	|1282	|4|
|19845	|1038	|5|
|19833	|1255	|6|
|19740	|1338	|7|
|19717	|1069	|8|
|19701	|1128	|9|
|19665	|549	|10|

___

:ring:
**9. Is there a correlation between working overtime and employees’ marital status?**

![last](https://i.imgur.com/WYJTxmC.png)
___

:bar_chart:
**10. Years and attrition. Who was more keen to leave the company: long-time employees or the ones who’ve only just started working at the company?**

![seniority](https://i.imgur.com/JfOppbw.png)


___
:page_facing_up:
**11. The results of the survey versus reality. How many people who evaluated their job satisfaction as low stayed at company and the opposite – how many employees who described their satisfaction as very high ended up leaving:**

![job_satisfaction](https://i.imgur.com/xlmWFb0.png)

:money_with_wings:	

:pushpin:	
**8. Find the average distance from home and the number of employees who live further than the average:**

a) The average distance:
```excel
=ROUND(AVERAGE('satisfaction survey'!E:E),1)
```

b) Employees who live further than that:
```excel
=COUNTIF('satisfaction survey'!E:E,">"&$B$2)
```

*Explanation:*
- $B$2 in =COUNTIF formula refers to a cell containing 'average distance' data.

**Results:**

a)

|Average Distance|
|----|
|9.2|


b)

|Employees who live far|
|----|
|530|
