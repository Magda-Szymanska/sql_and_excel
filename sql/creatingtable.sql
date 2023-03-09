CREATE TABLE emp_history
 (Emp_id INT,
  Education VARCHAR(100),
  Education_Field VARCHAR(100),
  Num_Companies_Worked INT,
  Years_At_Company INT,
  Years_In_Current_Role INT,
  Years_Since_Last_Promotion INT,
  Total_Worked_Years INT,
  Training_Last_Year INT,
  years_With_Curr_Manager INT);
  
INSERT INTO emp_history 
  (Emp_id,
  Education,
  Education_Field,
  Num_Companies_Worked,
  Years_At_Company,
  Years_In_Current_Role,
  Years_Since_Last_Promotion,
  Total_Worked_Years,
  Training_Last_Year,
  years_With_Curr_Manager)
  SELECT
  Emp_id,
  Education,
  Education_Field,
  Num_Companies_Worked,
  Years_At_Company,
  Years_In_Current_Role,
  Years_Since_Last_Promotion,
  Total_Worked_Years,
  Training_Last_Year,
  years_With_Curr_Manager
  FROM emp_attrition;
  
  CREATE TABLE satisfaction_survey
  (Emp_id INT,
  Job_Satisfaction INT,
  Relationship_Satisfaction INT,
  Environment_Satisfaction INT,
  Distance_From_Home INT,
  Work_Life_Balance INT
  );

INSERT INTO satisfaction_survey
(Emp_id,
  Job_Satisfaction,
  Relationship_Satisfaction,
  Environment_Satisfaction,
  Distance_From_Home,
  Work_Life_Balance)
SELECT 
Emp_id,
  Job_Satisfaction,
  Relationship_Satisfaction,
  Environment_Satisfaction,
  Distance_From_Home,
  Work_Life_Balance
  FROM emp_attrition;
  
ALTER TABLE emp_attrition
DROP Education,
DROP Education_Field,
DROP Num_Companies_Worked,
DROP Years_At_Company,
DROP Years_In_Current_Role,
DROP Years_Since_Last_Promotion,
DROP Total_Worked_Years,
DROP  Training_Last_Year,
DROP  years_With_Curr_Manager,
DROP  Job_Satisfaction,
DROP  Relationship_Satisfaction,
DROP  Environment_Satisfaction,
DROP  Distance_From_Home,
DROP  Work_Life_Balance;

CREATE TABLE survey_details
(
    id INT PRIMARY KEY,
    satisfaction_description VARCHAR(100),
    education_description VARCHAR(100)
);
INSERT INTO survey_details (id, satisfaction_description, education_description)
VALUES 
	(1, 'Low', 'Below College'), 
	(2, 'Medium', 'College'),
    (3, 'High', 'Bachelor'),
    (4, 'Very High', 'Master'),
    (5, NULL , 'Doctor');

ALTER TABLE emp_history
ADD CONSTRAINT fk_emp_id
FOREIGN KEY (emp_id)
REFERENCES emp_attrition(emp_id);

ALTER TABLE satisfaction_survey
ADD CONSTRAINT fk_emp_2_id
FOREIGN KEY (emp_id)
REFERENCES emp_attrition(emp_id);
    
ALTER TABLE satisfaction_survey
ADD CONSTRAINT fk_job_satisf
FOREIGN KEY (job_satisfaction) 
REFERENCES survey_details(id);

ALTER TABLE satisfaction_survey
ADD CONSTRAINT fk_relationship_satisf
FOREIGN KEY (relationship_satisfaction) 
REFERENCES  survey_details(id);

ALTER TABLE satisfaction_survey
ADD CONSTRAINT fk_environment_satisf
FOREIGN KEY (Environment_Satisfaction) 
REFERENCES survey_details(id);

ALTER TABLE satisfaction_survey
ADD CONSTRAINT fk_wlb
FOREIGN KEY (Work_Life_Balance) 
REFERENCES survey_details(id); 
    
ALTER TABLE emp_history
ADD CONSTRAINT fk_education_lvl
FOREIGN KEY (Education) 
REFERENCES survey_details(id);

