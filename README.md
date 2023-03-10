
# IBM Attrition Data: SQL and Excel Project

By: Magda Szymanska

:e-mail: szymanskamagda11@gmail.com

___

## Introduction:

The project was created using free data provided on [Kaggle](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset/discussion), which supposedly contains information, gathered by IBM, concerning the link between employees leaving the company and various workplace and life related factors. I did however transform the data to my liking and I came up with the questions for the project.

I have chosen this data **purely** because I thought it would allow me to showcase several SQL and Excel related skills. My project is **not** meant to be a serious analysis on attrition and nor do I think the questions posed by me are in any way helpful in understanding the factors leading to employees leaving a company. I purposefully split the data in many tables to up the challenge.

**SQL project can be found here:** [SQL Project](https://github.com/Magda-Szymanska/sql_and_excel/tree/main/sql). The SQL Project is composed of [queries.md](https://github.com/Magda-Szymanska/sql_and_excel/edit/main/sql/queries.md) which stores the exercises and [creatingtable.sql](https://github.com/Magda-Szymanska/sql_and_excel/blob/main/sql/creatingtable.sql) which documents the process of transforming the table. 

**Excel project can be found here:** [Excel Project](https://github.com/Magda-Szymanska/sql_and_excel/tree/main/excel). The folder contains [calculations.md](https://github.com/Magda-Szymanska/sql_and_excel/blob/main/excel/calculations.md) with all the exercises, a separate file with only [pivot tables](https://github.com/Magda-Szymanska/sql_and_excel/blob/main/excel/ibm_emp%20-%20pivot%20table%201.csv) included (in csv format) and the spreadsheet itself, [ibm_emp.xlsx](https://github.com/Magda-Szymanska/sql_and_excel/blob/main/excel/ibm_emp.xlsx), in xlsx format. **Please note the ibm_emp.xlsx is too big to be displayed on Github and clicking on the 'view raw' will result in automatic download.**
___


## Transforming data:

As I have already mentioned the project was meant to be a showcase of skills and therefore I deliberately split the database into four tables.

In its original state the database contained one table with 35 columns. Part of the data consisted of employees' personal information (such as age, martial status, position), while another showed information about each employee's working environment and satisfaction - both from the point of view of employee (*how happy I am at this place?*) and from the point of view of employer (*what do I think about this employee's performance?*). 

After much headache I concocted a hypothetical scenario in which half of the information (personal information, education) has been collected by the company and put it in ```emp_attrition``` and ```emp_history``` tables. Meanwhile, the other half comes from employees themselves who have been told to fill a survey, leading to the creation of ```satisfaction_survey``` table. I deleted the columns which pertained to employer's view to fit my vision of employee-only survey better.

With three tables done I've moved onto creating the last table, ```survey_details```. When it came to columns such as Job_Satisfaction or Work_Life_Balance a large chunk of the original data was expressed using numerical values instead of descriptions. For example, the Job_Satisfaction with 1 typed in was supposed to mean the satisfaction level was 'low'. However, the description 'low' was only available on the Kaggle website itself. I decided to include this information in my database with  ```survey_details``` table and I connected it to the other tables by establishing foreign keys.

Lastly, I exported the database to Excel in csv. form.

