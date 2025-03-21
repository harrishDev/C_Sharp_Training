create database HMBank

use HMBank

create table Customers(
customer_id int identity primary key,
first_name varchar(255),
last_name varchar(255),
DOB date,
email varchar(255),
phone_number bigint,
address varchar(255)
)

create table Accounts(
account_id int identity primary key,
customer_id int not null,
account_type varchar(255),
balance decimal(15,3),
foreign key (customer_id) references Customers(customer_id) on delete cascade
)

create table Transactions(
transaction_id int identity primary key,
account_id int not null,
transaction_type varchar(255),
amount decimal(15,3),
transaction_date date
foreign key (account_id) references accounts(account_id) on delete cascade
)

select * from Customers
select * from Accounts
select * from Transactions

--TASK2:
--1. 1. Insert at least 10 sample records into each of the following tables.   
-- • Customers  
-- • Accounts 
-- • Transactions 

/*
2. Write SQL queries for the following tasks: 
1. Write a SQL query to retrieve the name, account type and email of all customers. 
*/ 
select c.first_name, a.account_type, c.email
from Customers c
join Accounts a on c.customer_id=a.customer_id

--2. Write a SQL query to list all transaction corresponding customer.
select c.first_name, t.transaction_type, t.amount, t.transaction_date
from Customers c
join Accounts a on c.customer_id=a.customer_id
join Transactions t on a.account_id=t.account_id

select * from Customers
select * from Accounts
select * from Transactions

--3. Write a SQL query to increase the balance of a specific account by a certain amount. 
update Accounts
set balance=2500
where account_id=1

-- 4.  Write a SQL query to Combine first and last names of customers as a full_name
select CONCAT(first_name,space(1),last_name) as full_name
from Customers

--5. Write a SQL query to remove accounts with a balance of zero where the account type is savings
update Accounts
set balance=0
where account_id=10

delete from Accounts
where account_type='savings' and balance=0

--6. Write a SQL query to Find customers living in a specific city.
select first_name, address as city from Customers
where address like '%chennai%'

--7. Write a SQL query to Get the account balance for a specific account. 
select balance from Accounts
where account_id=5

select * from Customers
select * from Accounts
select * from Transactions
--8. Write a SQL query to List all current accounts with a balance greater than $1,000.
select account_type, balance
from Accounts
where balance>1000 and account_type='current'

--9. Write a SQL query to Retrieve all transactions for a specific account.
select * from Transactions
where account_id=2

--10.  Write a SQL query to Calculate the interest accrued on savings accounts based on a 
-- given interest rate. 
select account_id, balance, balance*0.05 as interestAccrued
from Accounts
where account_type='savings'

--11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
select account_id, account_type, balance
from Accounts
where (account_type='savings' and balance<2500)
or (account_type='current' and balance<25000)
or (account_type='zero_balance' and balance<=0)

--12.  Write a SQL query to Find customers not living in a specific city. 
select first_name, address as city
from Customers
where address not like '%chennai%'

select * from Customers
select * from Accounts
select * from Transactions
--task3
--1. Write a SQL query to Find the average account balance for all customers.
select c.first_name, avg(balance) as averageBalance
from Customers c
join Accounts a on c.customer_id=a.customer_id
group by c.first_name

--2. Write a SQL query to Retrieve the top 10 highest account balances. 
select top 10 * from Accounts
order by balance desc

--3. Write a SQL query to Calculate Total Deposits for All Customers in specific date. 
select sum(amount) AS totalDeposits FROM Transactions WHERE transaction_date = '2025-03-22';

--4. Write a SQL query to Find the Oldest and Newest Customers. 
select top 1 first_name as oldestCustomer from Customers
order by DOB asc
select top 1 first_name as newestCustomers from Customers
order by DOB desc

--5. Write a SQL query to Retrieve transaction details along with the account type.
select t.*, a.account_type from Transactions t
join Accounts a on t.account_id=a.account_id

--6. Write a SQL query to Get a list of customers along with their account details.
select c.first_name, a.*
from Customers c
join Accounts a on c.customer_id=a.customer_id

--7. Write a SQL query to Retrieve transaction details along with customer information for a 
-- specific account. 
select c.*, t.*
from Customers c
join Accounts a on c.customer_id=a.customer_id
join Transactions t on a.account_id=t.account_id
where amount=1000

select * from Customers
select * from Accounts
select * from Transactions
--8.Write a SQL query to Identify customers who have more than one account.
select c.customer_id, count(a.account_id) as account_count
from Customers c
join Accounts a on c.customer_id=a.customer_id
group by c.customer_id
having count(a.account_id)>1

--9. write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals
SELECT 
    a.account_id,
    SUM(CASE WHEN t.transaction_type = 'Deposit' THEN t.amount ELSE 0 END) AS total_deposits,
    SUM(CASE WHEN t.transaction_type = 'Withdrawal' THEN t.amount ELSE 0 END) AS total_withdrawals,
    SUM(CASE WHEN t.transaction_type = 'Deposit' THEN t.amount ELSE 0 END) - 
    SUM(CASE WHEN t.transaction_type = 'Withdrawal' THEN t.amount ELSE 0 END) AS transaction_difference
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
GROUP BY a.account_id;

--10. Write a SQL query to Calculate the average daily balance for each account over a specified period. 
select a.account_id, AVG(a.balance) as averageBalance
from Accounts a
join Transactions t on a.account_id=t.account_id
where transaction_date between '2025-03-21' and '2025-03-25'
group by a.account_id

--11. Calculate the total balance for each account type.
select account_type, sum(balance) as totalBalance
from Accounts
group by account_type

--12. Identify accounts with the highest number of transactions order by descending order
select a.account_id, count(t.transaction_id) as transactionCount
from Accounts a
join Transactions t on a.account_id=t.account_id
group by a.account_id
order by transactionCount desc

--13. List customers with high aggregate account balances, along with their account types
select c.first_name, sum(a.balance) as totalBalance, a.account_type
from Customers c
join Accounts a on c.customer_id=a.customer_id
group by c.first_name, a.account_type

select * from Customers
select * from Accounts
select * from Transactions
--14. Identify and list duplicate transactions based on transaction amount, date, and account.
select account_id, amount, transaction_date, COUNT(*) AS duplicateCount from Transactions
group by account_id, amount, transaction_date
having COUNT(*) > 1
