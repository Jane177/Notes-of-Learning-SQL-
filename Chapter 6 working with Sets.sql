# Set (rbind)
## guidelines: 1. both data sets have same number of columns 2. the data types of each column across two data sets must be the same
select 1 num, 'abc' str
union  # a compound query, otherwise independent query
select 9 num, 'xyz' str;

# Set operators
## The union Operator: union and union all (don't remove duplication)
select 'IND' type_cd, cust_id, lname name
from individual
union all
select 'BUS' type_cd, cust_id, name
from business;

SELECT 'IND' type_cd, cust_id, lname name
FROM individual
UNION ALL
SELECT 'BUS' type_cd, cust_id, name
	FROM business
UNION ALL
SELECT 'BUS' type_cd, cust_id, name
	FROM business;

SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
	AND (title = 'Teller' OR title = 'Head Teller')
UNION ALL
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;

# use union to exclude duplicate row
SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
	AND (title = 'Teller' OR title = 'Head Teller')
UNION
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;

## The intersect Operator: cannot run from here, works in SQL Server 2008. There is also intersect all, only work in IBM's DB2
SELECT emp_id, fname, lname
FROM employee
INTERSECT
SELECT cust_id, fname, lname
FROM individual;

SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
  AND (title = 'Teller' OR title = 'Head Teller')
INTERSECT
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;

## The except Operator: MySQL 6.0 cannot use. Also an except all, remove once.
SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
  AND (title = 'Teller' OR title = 'Head Teller')
EXCEPT
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;


# Set Operation Rules
## Sort Compund Query Results: 'order by'
SELECT emp_id, assigned_branch_id
FROM employee
WHERE title = 'Teller'
UNION
SELECT open_emp_id, open_branch_id
FROM account
WHERE product_cd = 'SAV'
ORDER BY emp_id;

SELECT emp_id, assigned_branch_id
FROM employee
WHERE title = 'Teller'
UNION
SELECT open_emp_id, open_branch_id
FROM account
WHERE product_cd = 'SAV'
ORDER BY open_emp_id; # open_emp_id is unknown. It's better to give alias.

## Set Operation Precedence
### order doesn't matter, in order from top to bottom. Note: 1. ANSI SQL specification 2. dicate the order using parenthese (MySQL don't allow)
SELECT cust_id
FROM account
WHERE product_cd IN ('SAV', 'MM')
UNION ALL
SELECT a.cust_id
FROM account a INNER JOIN branch b
    ON a.open_branch_id = b.branch_id
WHERE b.name = 'Woburn Branch'
UNION
SELECT cust_id
FROM account
WHERE avail_balance BETWEEN 500 AND 2500;

SELECT cust_id
FROM account
WHERE product_cd IN ('SAV', 'MM')
UNION 
SELECT a.cust_id
FROM account a INNER JOIN branch b
    ON a.open_branch_id = b.branch_id
WHERE b.name = 'Woburn Branch'
UNION ALL
SELECT cust_id
FROM account
WHERE avail_balance BETWEEN 500 AND 2500;

# not work in MySQL
(SELECT cust_id
 FROM account
 WHERE product_cd IN ('SAV', 'MM')
 UNION ALL
 SELECT a.cust_id
 FROM account a INNER JOIN branch b
   ON a.open_branch_id = b.branch_id
 WHERE b.name = 'Woburn Branch')
INTERSECT
(SELECT cust_id
 FROM account
 WHERE avail_balance BETWEEN 500 AND 2500
 EXCEPT
 SELECT cust_id
 FROM account
 WHERE product_cd = 'CD'
  AND avail_balance < 1000);

# Exercise
## 6-2
select fname, lname
from individual
union
select fname, lname
from employee;

## 6-3
select fname, lname
from individual
union
select fname, lname
from employee
order by lname;