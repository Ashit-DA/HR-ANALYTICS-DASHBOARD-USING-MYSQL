use hr_analytics;
select * from hr_1datacsv;
select * from hr_2datacsv;
create view Total_Employee as select count(*) as Total_Employee from hr_1datacsv;
drop view Total_Employee;
select * from Total_Employee;

create view Gender_Count as select Gender,count(*) as Gender_Count from hr_1datacsv group by Gender;
select * from Gender_Count;

create view Current_Employee as select count(Attrition) as Current_Empl from hr_1datacsv where Attrition='No';
select * from Current_Employee;

create view Ex_Employee as select count(Attrition) as Ex_Empl from hr_1datacsv where Attrition='Yes';
select * from Ex_Employee;

/*KPI 1 - AVERAGE ATTRITION RATE FOR ALL DEPARTMENT*/
select * from hr_1datacsv;

select Department,round(AVG(attrition = 'Yes')*100,2) as Average_Attr_Rate from hr_1datacsv group by Department;

select department, round(count(attrition)/(select count(employeenumber) from hr_1datacsv)*100,2)  as attrtion_rate
from hr_1datacsv where attrition = "yes" group by department;

/*KPI 2 - Average Hourly rate of Male Research Scientist*/
select Gender,JobRole,avg(HourlyRate) as Avg_hourly_Rate from hr_1datacsv where Gender='Male'and JobRole='Research Scientist';

/*KPI 3 - Attrition rate Vs Monthly income stats*/

select h1.department,
round(count(h1.attrition)/(select count(h1.employeenumber)from hr_1datacsv as h1 )*100,2) as Avg_Attr_Rate ,
round(avg(h2.MonthlyIncome),2) as average_incom from hr_1datacsv as h1 join hr_2datacsv as h2
on h1.EmployeeNumber = h2.`employee id`
where attrition = 'Yes'
group by h1.department;


/*KPI 4 - Average working years for each Department*/

select HR1.Department,round(avg(HR2.TotalWorkingYears),0) as Avg_Working_Years 
from hr_1datacsv as HR1 join hr_2datacsv as HR2 on HR1.EmployeeNumber = HR2.`employee id`
group by HR1.department;

/*KPI 5 - Job Role Vs Work life balance*/

SELECT HR1.JobRole,round(avg(HR2.WorkLifeBalance),0)  as Avg_WorkLifeBalance,count(HR2.WorkLifeBalance) as Employee_Count from 
hr_1datacsv as HR1 join hr_2datacsv as HR2 on HR1.EmployeeNumber = HR2.`employee id`
group by HR1.JobRole,HR2.WorkLifeBalance order by HR1.JobRole;

/*KPI 6 - Attrition rate Vs Year since last promotion relation*/

select count(HR1.Attrition) as attrition_count , HR2.YearsSinceLastPromotion
from hr_1datacsv as HR1 join hr_2datacsv as HR2 on HR1.EmployeeNumber = HR2.`employee id`
where HR1.Attrition = 'Yes'
group by YearsSinceLastPromotion
order by YearsSinceLastPromotion;