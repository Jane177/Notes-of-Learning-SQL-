use bank;
#types of where clause
## 1. where condition A and/or condition B 
## 2. Where condition A and/or (condition B and/or condition C) # parentheses
## 3. Where condition A and/or NOT (condition B and/or condition C) # not operatot which equal to !=


# Building a Condition
## condition contains: 1. >=1 expression 2. >=1 operator
### expression: 1. a num 2. a column 3. a string literal 4. a build-in function 5. a subquery 6. a list of expression
### operator: 1. comparison operators: =, !=, <, >, like, in, between 2. arithmetic operator: +, -, *, /.


# Condition Types
## Equality conditions: 
### title = 'Teller'. dept_id = (select dept_id from department where name = 'loans')one expression equal to another
select pt.name product_type, p.name product
from product p inner join product_type pt
	on p.product_type_cd = pt.product_type_cd
where pt.name = 'Customer Accounts';
### Inequality conditions: <>
select pt.name product_type, p.name product
from product p inner join product_type pt
	on p.product_type_cd = pt.product_type_cd
where pt.name <> 'Customer Accounts';
### data modification using equality conditions
delete from account
where status = 'CLOSE' and year(close_date) = 2002;

## Range Conditions
select emp_id, fname, lname, start_date
from employee
where start_date < '2007-01-01';

select emp_id, fname, lname, start_date
from employee
where start_date < '2007-01-01'
	and start_date >= '2001-01-01';

### between operator: consisted of >= lower limit and <= upper limit 
#### date
select emp_id, fname, lname, start_date
from employee
where start_date between '2001-01-01' and '2007-01-01'  # always specify from lower limit to upper limit with and
#### number
select account_id, product_cd, cust_id, avail_balance
from account
where avail_balance between 3000 and 5000;
#### string range: SSN
select cust_id, fed_id
from customer
where cust_type_cd ='I'
	and fed_id between '500-00-0000' and '999-99-9999';
    
## Membership Conditions
select account_id, product_cd, cust_id, avail_balance
from account
where product_cd = 'CHK' or product_cd = 'SAV'
	or product_cd = 'CD' or product_cd = 'MM';
#### use in operator
select account_id, product_cd, cust_id, avail_balance
from account
where product_cd in ('CHK', 'SAV', 'CD', 'MM'); 
#### use subqueries
select account_id, product_cd, cust_id, avail_balance
from account
where product_cd in (select product_cd from product	
						where product_type_cd = 'ACCOUNT');
#### use not in 
select account_id, product_cd, cust_id, avail_balance
from account
where product_cd not in ('CHK', 'SAV', 'CD', 'MM'); 

## Matching Conditions
select emp_id, fname, lname
from employee
where left(lname,1) = 'T';  # substring from left, one character

### using wildcase:
#### 1. String begain/end with a certain character or substring;
#### 2. Strings containing a certain character or substring;
#### 3. Stiring with a specific format, regardless of individual characters;
#### wildcard character : _ Excatly one character; % any number of characters (including 0)
select lname
from employee
where lname like '_a%e%';

#### search the format of fed_id as SSN
select cust_id, fed_id
from customer
where fed_id like '___-__-____';  

#### sophidticate search
select emp_id, fname, lname
from employee
where lname like 'F%' or lname like 'G%';

### Uisng regular expressions
select emp_id, fname, lname
from employee
where lname regexp '^[FG]'; # last name begain with F or G # regexp takes a regular expression, Jeffrey  E.F.  Friedl’s  Mastering  Regular  Expressions  (http://oreilly.com/catalog/ 9780596528126/) (O’Reilly)

# NULL: That Four-Letter Word
## not applicable; value not yet known; value undefined
## remenber: an expression can be null, but never equal null; two null are never equal to each other
## test null using 'is'
select emp_id, fname, lname, superior_emp_id
from employee
where superior_emp_id is null; # if use '=', then you will get nothing but with no error

## test whether a value has assign to a column
select emp_id, fname, lname, superior_emp_id
from employee
where superior_emp_id is not null;

## pitfall. investigat who are not manage by HF(emp_id =6)
select emp_id, fname, lname, superior_emp_id
from employee
where superior_emp_id != 6; # in this way, emp with superior with null are not shown

select emp_id, fname, lname, superior_emp_id
from employee
where superior_emp_id != 6 or superior_emp_id is null; # let's be thoughtful.

# Exercise
# 4-3
select account_id, open_date
from account
where year(open_date) = 2002;

## or
select account_id, open_date
from account
where open_date between '2002-1-1' and '2002-12-31';


# 4-4
select cust_id, lname, fname
from individual
where lname like '_a%e%';

