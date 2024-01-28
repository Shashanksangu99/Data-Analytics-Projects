use hr_project;

select *
from hr_data;

describe hr_data;

alter table hr_data
change column id emp_id varchar(20) NULL; 

set sql_safe_updates=0;

update hr_data
set birthdate= case
	when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
    when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;

select *
from hr_data;

update hr_data
set hire_date=case
	when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
    when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;    

select birthdate,hire_date
from hr_data;

Alter table hr_data
modify column birthdate date;

Alter table hr_data
modify column hire_date date;

describe hr_data; 

update hr_data
set termdate= date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate!='';

select termdate 
from hr_data;

alter table hr_data
add column age int;

update hr_data
set age=timestampdiff(year,birthdate,curdate());

select birthdate,age 
from hr_data;

select min(age) as youngest,
max(age) as oldest
from hr_data;

select age
from hr_data
where age>18;

select count(age)
from hr_data
where age<18;

-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
select gender, count(*) as gender_count
from hr_data
where age>18 and termdate=''
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
select race,count(*) as race_count
from hr_data
where age>18 and termdate=''
group by race;

-- 3. What is the age distribution of employees in the company?
select 
 case
	when age>=18 and age<=24 then '18-24'
	when age>=25 and age<=34 then '25-34'
	when age>=35 and age<=44 then '35-44'
	when age>=44 and age<=57 then '44-57'
	else '57+'

 end as age_groups, 
count(*) as count_age_group
from hr_data
where age>18 and termdate=''

group by age_groups
order by age_groups; 

-- 4. How many employees work at headquarters versus remote locations?
select location, count(*)
from hr_data
where age>18 
group by location;

-- 5. What is the average length of employment for employees who have been terminated?
select avg(datediff(termdate,hire_date))/365 as avg_len_emp
from hr_data
where termdate<=curdate() and termdate != '' and age>18;

-- 6. How does the gender distribution vary across departments and job titles?
select department, jobtitle, gender, count(gender)
from hr_data
where age>18
group by department,jobtitle,gender
order by department;

-- 7. What is the distribution of job titles across the company?
select  jobtitle, gender, count(gender)
from hr_data
where age>=18
group by jobtitle,gender
order by jobtitle desc;

-- 8. Which department has the highest turnover rate?
select department,total_count,terminated_count, terminated_count/total_count as termination_rate
from (select department,count(department) as total_count,
sum(case when termdate!='' and termdate<=curdate() then 1 else 0 end) as terminated_count
from hr_data
where age>=18 
group by department) as subquery
order by termination_rate desc; 





 