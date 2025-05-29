CREATE DATABASE SALARY_SURVEY;
USE SALARY_SU;
drop table salary;
select count(*) from salary_survey;
SELECT * FROM SALARY_SURVEY;


-- 1.Average Salary by Industry and Gender

select Industry,Gender,Concat("$ ",round(avg(annual_salary_USD),2)) as Average_Salary from salary_survey group by Industry,Gender;

--  2.Total Salary Compensation by Job Title

select Job_Title, sum(annual_salary_USD), sum(Additional_Monetary_Compensation_USD),
concat("$ ",sum(annual_salary_USD + Additional_Monetary_Compensation_USD)) as Total_Salary
from salary_survey group by Job_Title;

-- 3.Salary Distribution by Education Level

select Education,concat("$ ",round(avg(annual_Salary_USD),2)) as Average_Salary,
 concat("$ ",min(annual_Salary_USD)) as Minimum_Salary,
 concat("$ ",max(annual_Salary_USD)) as Maximum_Salary
from salary_survey group by Education;

-- 4. Number of Employees by Industry and Years of Experience

select count(Industry) as No_Of_Employees,Industry,Years_of_Professional_Experience_Overall
from salary_survey 
group by Industry,Years_of_Professional_Experience_Overall;

-- 5.Median Salary by Age Range and Gender

select Age_Range,Gender,concat("$ ",round(avg(annual_Salary_USD),2)) as Median_Salary
from salary_survey
group by Age_Range,Gender
order by Age_Range asc;

-- 6. Job Titles with the Highest Salary in Each Country

select Job_Title,Country,concat("$ ",max(annual_Salary_USD)) as Maximum_Salary
from salary_survey
group by Job_Title,Country;

-- 7. Average Salary by City and Industry

select Industry,City,concat("$ ",round(avg(annual_Salary_USD),2)) as Average_Salary
from salary_survey
group by Industry,City;

-- 8. Percentage of Employees with Additional Monetary Compensation by Gender

select * from salary_survey;

select Gender,
    round(100 * sum(
    case when 
        Additional_Monetary_Compensation > 0 
        then 1 
        else 0 
        end) / count(*), 2) as Additional_Monetary_Compensation
from salary_survey
group by Gender
order by Gender;

-- 9. Total Compensation by Job Title and Years of Experience

select Job_Title,Years_of_Professional_Experience_in_Field,
concat("$ ",sum(annual_Salary_USD+Additional_Monetary_Compensation_USD)) as Total_Salary
from salary_survey
group by Job_Title,Years_of_Professional_Experience_in_Field;

-- 10. Average Salary by Industry, Gender, and Education Level

select Industry,Gender,Education, concat("$ ",round(avg(annual_Salary_USD),2)) as Average_Salary
from salary_survey
group by Industry,Gender,Education;
