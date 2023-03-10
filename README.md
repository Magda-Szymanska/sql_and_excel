
# IBM Attrition Data: SQL and Excel Project

By: Magda Szymanska

:e-mail: szymanskamagda11@gmail.com

___

## Introduction:

The project was created using free data provided on [Kaggle](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset/discussion), which supposedly contains information, gathered by IBM, concerning the link between employees leaving the company and various workplace and life related factors. I did however transform the data to my liking and I came up with the questions for the project.

I have chosen this data **purely** because I thought it would allow me to showcase several SQL and Excel related skills. My project is **not** meant to be a serious analysis on attrition and nor do I think the questions posed by me are in any way helpful in understanding the factors leading to employees leaving a company. I purposefully split the data in many tables to up the challenge.

**SQL project can be found here:** [SQL Project](https://github.com/Magda-Szymanska/sql_and_excel/tree/main/sql). The SQL Project is composed of [queries.md](https://github.com/Magda-Szymanska/sql_and_excel/edit/main/sql/queries.md) which stores the exercises and [creatingtable.sql](https://github.com/Magda-Szymanska/sql_and_excel/blob/main/sql/creatingtable.sql) which documents the process of transforming the table. 

**Excel project can be found here:** [Excel Project](https://github.com/Magda-Szymanska/sql_and_excel/tree/main/excel). **Please note the ibm_emp.xlsx is too big to be displayed and clicking on it will result in automatic download.**
___


## Transforming data:

As I have mentioned the project was meant to be a showcase of skills and therefore I deliberately split the database (which originally had contained one table with 35 columns) into four tables. 
I have assumed a hypothetical scenario in which part of the data (personal information, education) had been collected by the company. 

Hypothetical scenario – employees were handed a sheet.Due to missing information. I manipulated the data (or re-interpreted it for me own purposes). The same reason follows – I passed some of the more useful information to showcase more varied queries (to skip the endless barrage of aggregate counting exercises, instead of spamming average function). 

The first step was to clean up and alter the data, as well as make it suitable for Excel. 
The data was separated in two types: int and text and lacked a primarly key. All tables accepted NULL values.
Eliminate unnecessary data. DailyRate, HourlyRate and MonthlyRate pointless in presence of MonthlyIncome.  
Data satisfaction level expressed in numbers without explanation.  For excel purposes. 
Clean up data – business_travel expressed in text, but education in numbers. 
CHANGING THE DATA TO BE MORE PRACTICAL
Reared its ugly head. Survey method. 
Hypotetical information.
Assumes scenario workers who have taken a survey through business e-mail. Code that automatically strikes as those who quit. 
SPLITTING THE DATA
Assuming I decided to split the data. Employees table with their basic information – generated random names and email address. 
I have decided to transform the data. 
