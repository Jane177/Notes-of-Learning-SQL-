# We can see our MySQL connection id for pur own machine when we first log in.
# Quary Clauses: Select, From, Where, Group by, Having, Order by 
use bank;

# Select Clause: one of the last clauses that the database server evaluates.
## Basic
select *   # * indicates all columns
from department; 
select name   # * indicates all columns
from department; 

## a literal or expression
select emp_id,
'ACTIVE' status, # create a column with all entries equal 'ACTIVE', with new column name
emp_id*3.14159 as empid_x_pi, # can also use keyword as before alias name
upper(lname) last_name_upper    # make characters upper case
from employee;

## Run a built in func, don't need from
select version(),
user(),
database();

## Removing Duplicates
select distinct cust_id  # distinct keyword make sure no duplication
from account;

# From clause
## Tables : permanent tables, temporary tables, virtual tables
## subquery_generated tables
select e.emp_id, e.fname, e.lname
from (select emp_id, fname, lname, start_date, title
	  from employee) e;

## Views
create view employee_vw as	# create a view
select emp_id, fname, lname, 
	year(start_date) start_year  # retrieve year from date
from employee;

select emp_id, start_year
from employee_vw;

## table links
select employee.emp_id, employee.fname, employee.lname, department.name dept_name
from employee inner join department  # join department info to employee
	on employee.dept_id = department.dept_id; # using dept_id as the key

## Defining Table Aliases
select e.emp_id, e.fname, e.lname,
	d.name dept_name
from employee e inner join department as d # assign the alias right after the table name in from clause, or use key as
	on e.dept_id = d.dept_id;
    
# Where Clause
select emp_id, fname, lname, start_date, title
from employee
where title = 'Head Teller';

select emp_id, fname, lname, start_date, title
from employee
where title = 'Head Teller'
	 and start_date > '2001-01-01';
     
select emp_id, fname, lname, start_date, title
from employee
where title = 'Head Teller'
	 or start_date > '2001-01-01';
     
select emp_id, fname, lname, start_date, title
from employee
where (title = 'Head Teller' and start_date > '2001-01-01')
	or (title = 'Teller' and start_date > '2004-01-01');
    
# Group by and having Clauses
select d.name, count(e.emp_id) num_employees
from department d inner join employee e
	on d.dept_id = e.dept_id
group by d.name
having count(e.emp_id) > 2;

# Order by Clause
select open_emp_id, product_cd
from account
order by open_emp_id;

select open_emp_id, product_cd
from account
order by open_emp_id, product_cd;

## ascending versus desending sort order
select account_id, product_cd, open_date, avail_balance
from account
order by avail_balance desc;

## sort via expression
select cust_id, cust_type_cd, city, state, fed_id
from customer
order by right(fed_id,3); # order by last 3 digits 

## sort via numeric placeholders
select emp_id, title,  start_date, fname, lname
from employee
order by 2,5;
