use employees;
show tables;
select * from salaries
limit 10;

select * from employees
where first_name in ('Kellie', 'Mark');

select distinct emp_no, avg(salary) from salaries
group by emp_no
order by avg(salary);

select 
	first_name, count(first_name)
from employees
where 
	first_name like "T%"
group by first_name
having count(*)>5;

select 
	distinct emp_no, avg(salary) from salaries
where 
	salary >= '100000' and from_date >= "1997.01.01"
group by emp_no
order by avg(salary);

select 
	distinct emp_no, avg(salary) from salaries
where 
	from_date >= "1997.01.01"
group by salary having avg(salary)
order by avg(salary);

select round(avg(salary),2) from salaries;

select 
	distinct gender, first_name 
from 
	employees;

-----

select 
	concat( first_name, ' ', last_name),
    concat(round(salary/1000),'K$')
from 
	employees
inner join
	salaries
on
	employees.emp_no = salaries.emp_no;
    
----

select 
	emp_no, salary, to_date
from	
	salaries
where 
	emp_no = 10001 and to_date >= curdate();
    
----

select 
	first_name, last_name
from
	employees
order by first_name asc;


select 
	first_name, last_name
from
	employees
order by last_name desc;

----

select 
	first_name, last_name, hire_date
from 
	employees
order by 
	hire_date desc
limit 
	10;
    
select
	salary, to_date
from
	salaries
order by
	to_date desc
limit 50; 

-- --
select 
	dayname(birth_date), monthname(birth_date)
from
	employees;

-- --
select 
	concat(first_name,' ',last_name) as Full_Name,
    concat((round(datediff(hire_date,birth_date)/365)),' Age')
from
	employees;

-- --

select *
from
	employees
order by
	rand() limit 100 ;
    
-- -- 

select 
	round(avg(datediff(to_date, from_date)/365),2)
from 
	dept_manager
where
	curdate()> to_date;
    
-- --

select 
	emp_no, count(salary) 
from
	salaries
group by emp_no
order by count(salary) desc;


select
	year(hire_date), count(hire_date)
from
	employees
group by year(hire_date);


select
	year(hire_date) as Year, monthname(hire_date) as Month, count(hire_date) as Count
from
	employees
group by 
	year(hire_date), monthname(hire_date), month(hire_date)
order by 
	year(hire_date), month(hire_date);

-- --

select
	year(hire_date) as Year, count(hire_date)
from
	employees
group by
	year(hire_date)
having 
	count(*)>=20000;
;


select
	dept_no, count(dept_no)
from
	dept_manager
where 
	year(from_date) >= 1990
group by
	dept_no
having
	count(dept_no)>1; 
    
    
-- -- 

select 
	monthname(hire_date) as 'Month and Year', count(emp_no) as 'Employees'
from
	employees
where 
	monthname(hire_date) = 'March'
group by
	monthname(hire_date)
union
	select
		year(hire_date), count(emp_no)
	from 
		employees
	where 
		year(hire_date) = 1987
	group by
		year(hire_date);
        
-- --

with salaries_sample as (select 
	salary 
from
	salaries
where 
	to_date >= curdate()
order by
	rand() limit 100
)

select
	avg(salary), min(salary), max(salary), count(salary)
from
	salaries_sample;
    
    
-- --

select 
	stddev(salary)
from
	salaries
where 
	to_date >= curdate();


    
select 
	stddev(salary), year(to_date)
from
	salaries
group by
	year(to_date);
    
    
    -- adding time to date column in database--

select * from dept_manager;

select addtime(from_date, '10:10:10') from dept_manager;

select convert_tz(from_date, '-07:00', '+02:00') from dept_manager; -- converting time zones 


select curdate();


select date_format(to_date,'%D %Y %a %d %n %b %j') from salaries;

select date_format(hire_date, '%D %m %Y  %a') from employees;

select dayofyear('23.08.02');
select dayofmonth('23.08.02');
select dayofweek('23.08.02');

select dayofyear(hire_date) as HIRE, 
dayofyear(now()), 
count(hire_date),
sum(dayofyear(hire_date)-dayofyear(now())) as 'SUMMA' 

from employees

group by hire_date;

select week(from_date) from dept_manager;

select weekday(from_date) from dept_manager;


select

extract(Year from birth_date ) as year,
extract(month from birth_date ) as Month,
extract(Quarter from birth_date ) as Quarter,
extract(DAY from birth_date ) as DAy
from employees;


select from_days(739099);
select to_days('2023.08.02');

select period_diff(7039099, 7039092);


select period_diff(to_days(hire_date), to_days(birth_date)) from employees;

select to_days(hire_date) from employees; 

select unix_timestamp(hire_date) as try, from_unixtime(birth_date) from employees;

select hire_date, birth_date from employees;
describe employees;

select str_to_date('01,01,2014', '%d, %m , %y')


-- JOINS ---

select 
	concat(first_name, ' ', last_name) as Full_Name, salary
from
	employees
join
	salaries  on employees.emp_no = salaries.emp_no
where 
	to_date >= curdate();
    
    
select 
	departments.dept_name, round(avg(salary),2), round(stddev(salary),2)
from
	salaries
join
	dept_emp on dept_emp.emp_no = salaries.emp_no
join
	departments on departments.dept_no = dept_emp.dept_no
group by
	departments.dept_name;
    

select
	departments.dept_name, title, count(titles.emp_no) as 'Count of Employees'
from
	departments
join
	dept_emp on dept_emp.dept_no = departments.dept_no
join
	titles on dept_emp.emp_no = titles.emp_no
where 
	titles.to_date >= curdate() and dept_emp.to_date >= curdate()
group by
	departments.dept_name, titles.title ;

 
 
 select
	new_salaries.emp_no, new_salaries.from_date, prev_salaries.salary as previous_salary, new_salaries.salary as new_salary, 
    concat(round(100*(new_salaries.salary/prev_salaries.salary-1)),' %') as Percentage
from
	salaries as prev_salaries
join
	salaries as new_salaries on prev_salaries.emp_no = new_salaries.emp_no and prev_salaries.to_date = new_salaries.from_date;
    
    
-- --

with salary_stats as (
select 
	avg(salary) as avg_salary, stddev(salary) as stdv_salary
from
	salaries
where 
	curdate() < to_date)

select
	concat(first_name, ' ', last_name) as 'Full_Name',
    (salary-avg_salary)/stdv_salary as 'zscore'
from
	employees
join 
	salaries on employees.emp_no = salaries.emp_no
cross join 
	salary_stats
where 
	salaries.to_date>curdate()
order by 
	zscore desc;
    
    
    
-- SUB QUERIES--

 select
	emp_no
from
	dept_manager
where
	to_date>= curdate();
    


select *
from
	employees
where 
	emp_no 
in (select
		emp_no
	from
		dept_manager
	where
		to_date>= curdate());
    
    
    
select *
from
	employees
where 
	emp_no 
in (select
		emp_no
	from
		dept_manager
	where
		to_date <= curdate());
    
    
    


select 
	title, count(*)
from
	titles
where 
	emp_no 
in (select
		emp_no
	from
		dept_manager
	where
		to_date <= curdate())
group by
	title;
    
    


-- -- -- -- -- -- -- -- -- -- - --

select
	concat(emps.first_name, ' ', emps.last_name) as 'Employee Name', dept_manager.dept_no, dept_manager.emp_no,
    concat(managers.first_name, ' ', managers.last_name) as 'Managers Name'
from
	employees as emps
join
	dept_emp on emps.emp_no = dept_emp.emp_no
join
	dept_manager on dept_manager.dept_no = dept_emp.dept_no
join
	employees as managers  on managers.emp_no = dept_manager.emp_no
where
	dept_emp.to_date > curdate() and dept_manager.to_date > curdate();
    
    
    
    
select
	*
from
	titles as prev_titles
join
	titles as new_titles on prev_titles.emp_no = new_titles.emp_no and prev_titles.to_date = new_titles.from_date;
    
    

select
	sign(prev_salaries.salary - new_salaries.salary) as change_sign, count(*)
from
	salaries as prev_salaries
join
	salaries as new_salaries on prev_salaries.emp_no = new_salaries.emp_no and prev_salaries.to_date = new_salaries.from_date
group by 
	change_sign;
 
select
	concat(first_name, ' ', last_name) as 'Full Name', salaries.emp_no, salary, 
    case 
		when salary < 60000 then 'Less than Average'
        when salary < 100000 then 'Average'
        else 'Above Average'
	end as 'Salary_Status'
from
	salaries
join
	employees on salaries.emp_no = employees.emp_no
where
	salaries.to_date > curdate();
    
    
    
-- Variabeles

select @v_1 :=100000;

select * from salaries
where salary >@v_1;

use employees;
select 
	@msal := Max(salary)
 from salaries;
 
 
 select * from employees
 
 where emp_no in (select emp_no from salaries where salary = @msal);

select concat(first_name,"_",Last_name), gender from employees
where emp_no in (select emp_no from salaries where salary >100000);



select avg(Salary_Change_Frequnecy) from
	(select count(t.emp_no) as Salary_Change_Frequnecy, t.emp_no from salaries t
    group by t.emp_no) t;
 
 select count(emp_no) as "Salary_Change_Frequnecy" from salaries;
 
 
 -- If Function
 
 select *, if(dept_no is null, "N/A", dept_no) de from dept_manager;
 
 select *, if(salary > 40000, "Enough", salary) as salary1 from salaries;
 
 select  
 sum(if(title = "Staff",1,0)) AS Staff,
 sum(if(title = "Senior Staff",1,0)) AS "Senior Staff"
 from titles;
 
 select concat(first_name,"+",last_name), salary, if(salary>90000,"Bingo",Salary) as "Status"
 from employees inner join salaries where employees.emp_no = salaries.emp_no;
 
 
 select first_name, last_name, salary,
 case
	when salary <= 20000 then "Juniors"
    when salary <= 40000 then "Middles"
    when salary <= 60000 then "Seniors"
    when salary <= 80000 then "Unit Heads"
    when salary <= 90000 and first_name not like "A%" then "Leads"
    when salary <= 100000 then "CIDs"
	else "total"
    end  as Salary_Category
    
    from employees join salaries on employees.emp_no = salaries.emp_no inner join titles on employees.emp_no = titles.emp_no; 
    
    
    select
    sum(case
			when left(first_name,1) = "A" 
            then 1 else 0 end) as "A Starting Name",
    sum(case
			when left(first_name,1) = "B" 
            then 1 else 0 end) as "B Starting Name",
    sum(case        
            when left(first_name,1) = "C" 
            then 1 else 0 end) as "C Starting Name",
    sum(case
			when left(first_name,1) = "D" 
            then 1 else 0 end) as "D Starting Name"
            
	from employees; 

-- Window function

create table sales(
sales_employees varchar(50) not null, 
fiscal_year int not null,
sale decimal(14,2) not null,
primary key (sales_employees,fiscal_year));

insert into sales (sales_employees, fiscal_year,sale)
values 
("Bob", 2016,100),
("Bob", 2017,200),
("Bob", 2018,200),
("Alice", 2016,150),
("Alice", 2017,100),
("Alice", 2018,200),
("John", 2016,200),
("John", 2017,150),
("John", 2018,250);

select * from sales;


select 
fiscal_year,
sales_employees,
sum(sale) over (partition by fiscal_year) as Total_Year_Sales
from sales;

select 
year(from_date),
month(from_date),
sum(salary) as Total_Salary
from salaries
group by year(from_date),month(from_date);

select
Years, Months, Salary_Sum
from 
(select 
year(from_date) as Years,
month(from_date) as Months,
sum(salary) as Salary_Sum from salaries
group by years, months) t ;


-- Cume_dist function
create table scores (
name varchar(50) primary key,
score int not null);


insert into scores ( name, score)
values 
("Smith", 81),
("Jones", 55),
("Williams", 55),
("Taylor", 62),
("Brown", 63),
("Davies", 84),
("Evans", 87),
("Wilson", 72),
("Thomas", 72),
("Johnson", 100);


select
name, score, 
row_number() over (order by score) as row_num,
cume_dist() over (order by score) as "cume_dist_val"
from scores;


-- Dense_Rank

select 
	sales_employees,fiscal_year, sale, 
	dense_rank() over (partition by fiscal_year order by sale desc) as sales_rank
from  
	sales;



select
	years, months, month_salary_sum,
	dense_rank () over (partition by years order by month_salary_sum desc) as salary_rank
from
	(select 
		year(from_date) as Years,
		month(from_date) as Months,
		week(from_date) as weeks, 
		sum(salary) as month_salary_sum 
	from 
		salaries
	group by 
		years, months, weeks)t;
        
        
        
    




