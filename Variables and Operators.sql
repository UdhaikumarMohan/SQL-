
use Northwind;
Go

declare @local char(13);
select @local = 'Local Phone';

-- or We can use

set @local = 'Local Phone';

select @local as value;

declare @local char(13);
select @local = 'Local Phone';
select lastname, firstname, @local+HomePhone as Phone from dbo.Employees;
Go

-- Single statement declaration and initialisation in 2008

-- Declare in single line.

-- Compound Operators in 2008

declare @Variable varchar(50) = 'Hello World'
select @Variable as Message
print @Variable


declare @i int = 5
set @i+=1
print @i

-- Or

declare @i int = 5
set @i+=1
select @i as Increment

-- Above give is the example for the Increment, we can do this for decrement, multiplication, division, modulus, bitwise and, or, not, ex-or.

-- Decrement

declare @i int = 5
set @i-=1
select @i as Decrement

-- Multiplication

declare @i int = 5
set @i*=2
select @i as Multiplication

-- Division

declare @i float = 5
set @i/=2
select @i as Division

-- Modulus

declare @i int = 5
set @i%=2
select @i as Modulus

-- And

declare @i int = 5
set @i&=2
select @i as Bitwise_And

--OR

declare @i int = 5
set @i|=2
select @i as Bitwise_OR

-- Ex-OR

declare @i int = 5
set @i^=2
select @i as Bitwise_ExOR

