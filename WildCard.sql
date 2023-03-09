-- Select Demo

-- General format for naming a DB Object

-- Server.Database.schema.schema.object

select * from Northwind.dbo.Employees

-- Don't specify the server name for the local system.... use in network

use Northwind;
Go

-- Difference between Go and ;

-- ; is used for terminating a SQL Statement

-- Go is used to terminate or close a SQL Batch (All declared local variables will return their values with a batch

select FirstName, LastName from dbo.Employees;
select * from dbo.Employees;

-- Concatenating

select LastName+','+FirstName from dbo.Employees;

-- Aliasing (As). Use square brackets

select LastName+','+FirstName as [Full Name] from dbo.Employees;

--Select and Select Distince

select title from dbo.employees;

select distinct title from dbo.Employees;

-- Where

select CompanyName, city from dbo.Customers where city='Paris';

-- Like and Wild card characters.

-- Ending with s.

select CompanyName, city from dbo.Customers where CompanyName like '%s';

-- Starting with s

select CompanyName, city from dbo.Customers where CompanyName like 's%';

-- s in anywhere in the middle.

select CompanyName, city from dbo.Customers where CompanyName like '%s%';

-- Starting and ending with certain number of strings in the middle (_ used for count of strings)

select CompanyName, city from dbo.Customers where City like 'B___s';

-- Matching from the list.

select CompanyName, city from dbo.Customers where City like 'Ber[in]';

-- Specify Range

select CompanyName, city from dbo.Customers where City like 'Ber[A-s]';

-- Not Containing

select CompanyName, city from dbo.Customers where City like 'Ber[^l]';

-- Between

select lastname, firstname, postalcode from dbo.employees where PostalCode between '98000' and '98500';

-- Testing for Null

-- Three level Logic (True, False, Null)

select lastname, firstname, Region from dbo.employees where Region is Null;

-- AND Requires both conditions to be true.

select lastname, firstname, city, postalcode from dbo.employees where city = 'seattle' and PostalCode like '9%';

-- OR Requires one condition to be true

select lastname, firstname, city, postalcode from dbo.employees where city = 'seattle' or PostalCode like '9%';

-- Not

select lastname, firstname, city, postalcode from dbo.employees where PostalCode not like '9%';

-- Operator precedence: NOT, AND, OR

select lastname from dbo.employees where (lastname not like '%s') and (PostalCode like '9%'); 

-- IN Clause

-- Using IN to match the list of elements.

select customerid, country from dbo.customers where country in ('France', 'Spain')

-- IN with a subquery that returns a list of elements.

select customerid from dbo.customers where customerid not in (select customerid from dbo.orders);

