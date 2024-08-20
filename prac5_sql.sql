use bda_23162121020;

desc employees;
select * from employees;

select dep_id, count(emp_id) as employee_count from employees group by dep_id;
select dep_id, count(distinct job_name) as job_role_count from employees group by dep_id;
select distinct emp_name, salary from employees where salary > 2000;
select count(emp_id) as employee_count from employees where hire_date > '1991-04-03';
select job_name, count(emp_id) as employee_count from employees group by job_name order by employee_count desc;
select dep_id, count(emp_id) as employee_count from employees group by dep_id having count(emp_id) > 3;
select dep_id, sum(salary) as total_salary from employees group by dep_id;
select dep_id, count(emp_id) as employee_count from employees where emp_name like '%n' group by dep_id;
select dep_id, count(emp_id) as employee_count from employees where emp_name like '%a%' group by dep_id;
select dep_id, count(emp_id) as employee_count from employees e1 where salary > (select avg(salary) from employees e2 where e2.dep_id = e1.dep_id) group by dep_id;
select dep_id, count(emp_id) as employee_count from employees group by dep_id having count(emp_id) > 2 order by dep_id desc;
select dep_id, avg(salary) as average_salary from employees group by dep_id;
select dep_id, max(salary) as max_salary from employees group by dep_id;
select dep_id, min(salary) as min_salary from employees group by dep_id;