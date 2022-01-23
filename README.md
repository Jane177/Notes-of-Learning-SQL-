# Notes-of-Learning-SQL-
This repository contains notes when I learn SQL using Alan Beaulieu's book 'Learning SQL'
## Install MySQL and MySQL Workbench on mac
### 1. Download MySQL Database Serve from https://dev.mysql.com/downloads/mysql/.
### 2. Follow the instruction to install MySQL. Note that you need to set a password for root user.
### 3. Then download MySQL workbench at https://dev.mysql.com/downloads/workbench/.
## Access the example database Bank in this book
### 1. Open the terminal.
### 2. log in to MySQL as root by running the command line: 
```
/user/local/mysql/bin/mysql -u root -p
```
This step will ask you for the password, which is the one you set during installing MySQL. And then, you can access your root account, you can type commands after `mysql>`. 

### 3. Create sample data:
```
create databasr bank;
```
### 4. Create a user (lrngsql) with full privileges on the bank database:
```
grant all privileges on bank.* to 'lrngsql'@'localhost' identified by 'xyz';
```
Where `xyz` is the password of user `lrngsql`.
Then run `quit;` to exit mysql tool.
### 5. Log in to MySQL as lrngsql, and at the same time attach to bank database:
```
/user/local/mysql/bin/mysql -u lrngsql -p bank
```
### 6. To create a database and populate it with sample data, download the script of this book from https://resources.oreilly.com/examples/9780596007270/, and then running command:
```
source pathway/LearningSQLExample.sql;
```
