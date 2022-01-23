# SQL Schema Statement
## Create a table
create table person # person is the tabel name
(person_id smallint unsigned auto_increment, # person_id is a column name, smallint is the format, automatically generate person id from 1 with increasing
fname varchar(20),
lname varchar(20),
gender enum('M', 'F'), # only two value availible
birth_date date,
postal_code varchar(20),
constraint pk_person primary key (person_id) # set person_id as primary key
);
desc person; # see thr table definition
### create a table related to the above one
create table fav_food
(person_id smallint unsigned,
food varchar (20),
constraint pk_fav_food primary key (person_id, food),
constraint fk_fav_food foreign key (person_id) 
	references person (person_id) # set person_id as foreign key, no id beyond person table can be allowed.
);

## insert contents to table
insert into person # specify the table name
(person_id, fname, lname, gender, birth_date) #which column do you want to add info
values (null, 'William', 'Turner', 'M', '1972-05-27'); # what info? correspond to columns

## retrieves info
select fname # which column(s)
from person # which table
where person_id =1 # which row, can be ignore
order by lname; # order to show, can be ignore

## update data
update person # which table
set postal_code = '02138' # new info, can be more, seperated by ','
where person_id = 1; # constraint

## delete data
delete from person # which table
where person_id =1; #constraint

## others
### change format of date variable
update person
set birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y') # change date into DATE format
where person_id = 1;
#### other statements about formats are in page 38.
### see tables in the database
show tables; 
### delete tables
drop table person;


