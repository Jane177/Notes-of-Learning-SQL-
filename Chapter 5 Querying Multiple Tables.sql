# What's a join?
desc employee;
desc department;

# Cartesian Product: every permutation of two tables
select e.fname, e.lname, d.name
from employee e join department d;

# Inner Joins, only work for both table has the value. If you want to contain all values, using outer join
select e.fname, e.lname, d.name
from employee e join department d
	on e.dept_id = d.dept_id;
    
select e.fname, e.lname, d.name
from employee e inner join department d # it's better to specify the inner, however, inner join is the defult
	on e.dept_id = d.dept_id;
    
select e.fname, e.lname, d.name
from employee e inner join department d 
	using (dept_id); # when names in two tables are identical then use 'using'
    
# The ANSI Join Syntax SQL92
## join and filter are separted. on and where
## older: 
select e.fname, e.lname, d.name
from employee e, department d 
where  e.dept_id = d.dept_id;

## a mass example
select a.account_id, a.cust_id, a.open_date, a.product_cd
from account a, branch b, employee e
where a.open_emp_id = e.emp_id
	and e.start_date < '2007-01-01'
    and e.assigned_branch_id = b.branch_id
    and (e.title = 'Teller' or e.title = 'Head Teller')
    and b.name = 'Woburn Branch';
    
## SQL92
select a.account_id, a.cust_id, a.open_date, a.product_cd
from account a inner join employee e
	on a.open_emp_id = e.emp_id
    inner join branch b
    on e.assigned_branch_id = b.branch_id
where e.start_date < '2007-01-01'
    and (e.title = 'Teller' or e.title = 'Head Teller')
    and b.name = 'Woburn Branch';
    
    
# joining three or more tables
select a.account_id, c.fed_id
from account a inner join customer c
	on a.cust_id = c.cust_id
where c.cust_type_cd - 'B';

select a.account_id, c.fed_id, e.fname, e.lname
from account a inner join customer c
	on a.cust_id = c.cust_id
    inner join employee e
    on a.open_emp_id = e.emp_id
where c.cust_type_cd = 'B';

## if want to join in a specific order: intermediate
select straight_join a.account_id, c.fed_id, e.fname, e.lname
from customer c inner join account a 
	on a.cust_id = c.cust_id
    inner join employee e
    on a.open_emp_id = e.emp_id
where c.cust_type_cd = 'B';

## using subqueries as tables
select a.account_id, a.cust_id, a.open_date, a.product_cd
from account a inner join 
	(select emp_id, assigned_branch_id
    from employee 
    where start_date < '2007-01-01'
		and (title = 'Teller' or title = 'Head Teller')) e
on a.open_emp_id = e.emp_id
inner join
(select branch_id
	from branch
	where name = 'Woburn Branch') b
on e.assigned_branch_id = b.branch_id;

## using the same table twice, assign different alias
select a.account_id, e.emp_id,
	b_a.name open_branch, b_e.name emp_branch
from account a inner join branch b_a
	on a.open_branch_id = b_a.branch_id
    inner join employee e
    on a.open_emp_id = e.emp_id
    inner join branch b_e
    on e.assigned_branch_id = b_e.branch_id
where a.product_cd = 'CHK';


# Self-Join
SELECT e.fname, e.lname,
	e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
FROM employee e INNER JOIN employee e_mgr
	ON e.superior_emp_id = e_mgr.emp_id;

# Equi-Joins Versus Non-Equi-Joins
SELECT e.emp_id, e.fname, e.lname, e.start_date
FROM employee e INNER JOIN product p
  ON e.start_date >= p.date_offered
  AND e.start_date <= p.date_retired
WHERE p.name = 'no-fee checking';


SELECT e1.fname, e1.lname, 'VS' vs, e2.fname, e2.lname
FROM employee e1 INNER JOIN employee e2
	ON e1.emp_id != e2.emp_id
WHERE e1.title = 'Teller' AND e2.title = 'Teller';

SELECT e1.fname, e1.lname, 'VS' vs, e2.fname, e2.lname
FROM employee e1 INNER JOIN employee e2
	ON e1.emp_id < e2.emp_id
WHERE e1.title = 'Teller' AND e2.title = 'Teller';

# Join Conditions Versus Filter Conditions
select a.account_id, a.product_cd, c.fed_id
from account a inner join customer c
	on a.cust_id = c.cust_id
where c.cust_type_cd = 'B';

select a.account_id, a.product_cd, c.fed_id
from account a inner join customer c
	on a.cust_id = c.cust_id
		and c.cust_type_cd = 'B';
        
select a.account_id, a.product_cd, c.fed_id
from account a inner join customer c
	where a.cust_id = c.cust_id
		and c.cust_type_cd = 'B';

# Exercise
## 5-1
SELECT e.emp_id, e.fname, e.lname, b.name
FROM employee e INNER JOIN branch b
	ON e.assigned_branch_id = b.branch_id;

## 5-2
select a.account_id, c.fed_id, p.name
from account a inner join customer c
	on a.cust_id = c.cust_id
	inner join product p
	on a.product_cd = p.product_cd
where c.cust_type_cd = 'I';

## 5-3
select e.emp_id, e.fname, e.lname
from employee e inner join employee em
	on e.superior_emp_id = em.emp_id
where e.dept_id != em.dept_id;
