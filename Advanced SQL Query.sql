
-- Advanced SQL Query options.

-- SQL Union

-- The union operator is used to combine the results set of two or more select statements.

-- Every select statement within union must have the same number of columns

-- The columns must also have similar data types.

-- The columns in every select statement must also be in the same order.

-- The union operator selects only distinct values by default. To allow duplicate values, use union all.

-- The column name in the result-set are usually equal to the column names in the first select statement.

select Companyname, Contactname, City from dbo.Customers 
union
select Companyname, Contactname, City from dbo.Suppliers;

------------------------------------------------------------------------------------------------------------

select City from dbo.Customers where Country = 'France'
union
select City from dbo.Suppliers where Country = 'France';

------------------------------------------------------------------------------------------------------------

select City from dbo.Customers where Country = 'France'
union
select City from dbo.Suppliers where Country = 'France'
order by City;

------------------------------------------------------------------------------------------------------------

select City from dbo.Customers where Country = 'France'
union all
select City from dbo.Suppliers where Country = 'France'
order by City;

------------------------------------------------------------------------------------------------------------

select City from dbo.Customers
union
select City from dbo.Suppliers
union
select City from dbo.Employees;

-------------------------------------------------------------------------------------------------------------

select City from dbo.Customers
union all
select City from dbo.Suppliers
union all
select City from dbo.Employees;

-------------------------------------------------------------------------------------------------------------