
--Sorting Demo

-- Order By Ascending Order

select LastName, City from dbo.Employees order by City;

-- Order by Descending Order

select LastName, City from dbo.Employees order by City DESC;

-- Sorting by Multiple Columns (ASC is optional)

Select LastName, City from dbo.Employees order by City DESC, LastName;

-- Sorting on Expressions.

select LastName, City from dbo.Employees order by len(LastName);

-- Aggregate Functions

-- Count - Count the number of rows in the aggregate query (32 Bit).

-- Count Big - Counts the number of rows in the aggregate query (64 Bit)

select COUNT(*) as [Number of Records] from dbo.Employees;

-- Counting values in the column

-- Count(*) Efficient??

select count(*) as [Number of Employees], count (Region) as [Number of Region] from dbo.Employees;

-- Counting with Where

select count(*) as [Number of Employees in Seattle] from dbo.Employees where city = 'Seattle';

-- Grouping Results

-- Need no of Employees form each city

-- Gives an Error

select city, count(*) as NumEmp from dbo.Employees;

-- Using Groupby

-- Every field that you have in the select list, that is not part of the aggregate function.

-- Needs to be in the Group By clause

select city, count(*) as [Number of Employees] from dbo.Employees Group By city;

-- Order by with Group by using (using alias)

select city, count(*) as [Number of Employees] from dbo.Employees Group By city order by [Number of Employees] Desc;

select city, count(*) as [Number of Employees] from dbo.Employees Group By city order by count(*) Desc;

-- Having 

select city, count(*) as [Number of Employees] from dbo.Employees group by city having count(*)>1 order by [Number of Employees] Desc, City;

-- Difference between where and Having Clause

-- Aggregate functions are applied on groups

-- The where clause filters the rows before aggregation could be applied.

-- Having clause waits for aggregation to be completed before filtering the result set.


-- Alias in having clause

-- This will cause an error, because you can't use an alias in the having clause.


-- Limiting the results (Just the output - after the entire processing is complete)

-- Top

select Top 3 city, count(*) as [Number of Employees] from dbo.Employees Group by city order by count(*) desc;

-- Top 3 with ties

select Top 3 with Ties city, count(*) as [Number of Employees] from dbo.Employees Group by city order by count(*) desc;

-- Top with percent

select Top 20 percent with ties city, count(*) as [Number of Employees] from dbo.Employees Group by city order by count(*) desc;