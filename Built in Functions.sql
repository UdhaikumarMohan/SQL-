-- Built in functionṣ.

-- Using IS Numeric (Returns True(1) or False(0) according to the entities in the string.

-- If all the entities are Numbers, then it will return true.

-- If any entitiy other than the number present inside the string, then it will return false.

select PostalCode, ISNUMERIC(PostalCode) from dbo.Customers;

-- Some Non-Numeric characters will pass (For eg. e and d used as a exponential)

select ISNUMERIC('123e4'), ISNUMERIC('123d4'), CAST('123e4' as float), CAST('123d4' as float);

-- Generate Random Numbers using Rand().

-- With an automatic random seed,

-- different numbers every time.

-- Execute multiple times.

select RAND(), RAND(), RAND();

-- with a fixed seed,

-- the same series every time,

-- Execute multiple times:

select RAND(1), RAND(), RAND();

-- Using Round

-- Syntax

-- Round (expression, length[,function])

select UnitPrice,
ROUND(UnitPrice, 0) as RoundedDollars,
ROUND(UnitPrice, 0, 1) as TruncatedDollars,
ROUND(UnitPrice, 1) as To_tens_of_Cents,
ROUND(UnitPrice, -1) as To_tens_of_Dollars
from dbo.Products;

-- Combining Rand and Round

Declare @minid int, @maxid int
set @minid = (select MIN(EmployeeID) from dbo.Employees)
set @maxid = (select MAX(EmployeeID) from dbo.Employees)
select EmployeeID as LuckyID, LastName as LuckyName from dbo.Employees
where EmployeeID = ROUND(@minid+(Rand()*(@maxid-@minid)), 0);

-- Using Replace

-- Syntax

-- Replace (String expression, StringPattern, StringReplacement)

select QuantityPerUnit, REPLACE(QuantityPerUnit, '12 ', 'twelve ') as Twelve from dbo.Products;

-- Using Stuff

-- Syntax

-- Stuff(expression 1, Start, Length, expression 2)

select STUFF ('123456', 3, 2, 'xxxx')

select STUFF(Phone, 3, 2, '****') from dbo.Customers

-- Using Len, Left, Right.

-- Syntax (String expression)

-- Left (String expression, Integer_Numchars)

-- Right (String expression, Integer_Numchars)

select ProductName,
LEFT(ProductName, 3) as lefty,
Right(ProductName, 3) as Righty
from dbo.Products;

select ProductName,
LEFT(ProductName, len(ProductName) - 3) as lefty,
Right(ProductName, len(ProductName) - 3) as Righty
from dbo.Products;

-- Using Substring

-- Syntax

-- Substring (Value_expression, Start_expression, Length_expression)

select SUBSTRING(FirstName, 1, 1)+'.'+ LastName  as Employee_Name from dbo.Employees;

-- Using CharIndex

-- Syntax

-- CharIndex (expression1, expression 2[, Start Location])

select HomePhone, CHARINDEX(')', HomePhone) as Startpos from dbo.Employees;

select left(HomePhone, CHARINDEX(')', HomePhone)) as AreaCode,
substring(HomePhone, CharIndex(')', HomePhone)+2, LEN(HomePhone)-CharIndex(')', HomePhone)) as Number
from dbo.Employees;

select ProductName as TofuProd from dbo.Products where CHARINDEX('Tofu', ProductName)>0;

-- Using PatIndex

-- Syntax

-- Patindex('%Pattern%', expression)

-- Patindex supports wildcards.

select ProductName, QuantityPerUnit from dbo.Products where PATINDEX ('24 - %g Pkgs.', QuantityPerUnit)>0;

select ProductName, QuantityPerUnit from dbo.Products where PATINDEX ('24 - ____g Pkgs.', QuantityPerUnit)>0;

-- Using Bracketed Values

select PostalCode from dbo.Customers where PATINDEX('%[0-9]%', PostalCode)>0;

select PostalCode from dbo.Customers where PATINDEX('%[^0-9]%', PostalCode)=0;

-- PatIndex can be used with text, ntext and image coulumns.

select categoryname, description, PATINDEX('%sweet%', description) as sweetfoundat from dbo.Categories where PATINDEX('%sweet%', description)>0;


-- Using Space

-- (display results as text)

-- Syntax

-- Space (Integer_Expressions)

-- (Go to Query ==> Results to ==> Results to text)

select FirstName + SPACE(15 - LEN(FirstName)) + LastName as NameIncolumns from dbo.Employees;

-- Using Char

-- Syntax

-- Char(integer_expression)

-- (13 is the ascii code for enter)

select CHAR(71) + CHAR(13) + CHAR(72) as CharacterWithCarriageReturn;

-- Using ASCII

-- Syntax

-- ASCII (Character_expression)

select ASCII('G') as ASCII_G;

--Using Upper and lower case.

-- Syntax

-- Lower (Character_Expression)

-- Upper (Character_Expression)

select UPPER(FirstName) as FirstName, LOWER(LastName) from dbo.Employees;

-- Use for Case-insensitive filtering of Case-sensitive data.

select CompanyName from dbo.Customers where CHARINDEX(Upper('the'), Upper(CompanyName))>0;

-- (The most efficient way to perform)

-- Case-Sensitive or case insensitive

-- Searches is to specify a collection of the query


-- Case-Sensitive

select CompanyName from dbo.Customers where CompanyName like '%the%' Collate SQL_Latin1_General_CP1_CS_AS;

-- Case-insensitive

select CompanyName from dbo.Customers where CompanyName like '%the%' Collate SQL_Latin1_General_CP1_CI_AI;
