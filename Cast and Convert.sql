-- Casting and Conversion

-- Transact-SQL is strictly typed, so it requires explicit Casting and Conversion when incompitable types are used.

-- Syntax

-- Cast(expression as data type[(length)]

-- Convert(data type [(Length)], expression[, style])

Declare @msg varchar(20) = 'The result is: ' + cast((2+2) as varchar(20))
print @msg

Declare @msg varchar(20) = 'The result is: ' + convert(varchar(20), (2+2))
print @msg

-- There is data type precedence (Check Online)

-- Casting and Conver is hlepful to not to worry about data type precedence

Declare @msg varchar(20) = 'The result is: ' + (2+2)
print @msg

-- The above query will not work because integer is the first precedence here, so it will try to convert things into integer.

-- While converting to integer, it was not able to convert the string into integer, so it will throw error.

-- That's why we are using casting and conversion in the queries.

-- But in the below case it will work. Because of certain limitations

Declare @msg varchar(20) = '1' + (2+2)
print @msg

-- Definition for the Precedence

-- When sql server evaluates an expression that include multiple data types, it pick one data type for the result and attempts to convert each part of the expression to that one resulting type.
-- The type that sql server picks is the one with highest type precedence.

-- SQL server does have limited support for converting the data types (implicit conversion)


-- Using STR to convert format

-- Syntax

-- Str (float_expression[, length[, deciaml]])

select UnitPrice, STR(UnitPrice, 5, 1) as formatted from dbo.Products order by UnitPrice Desc;