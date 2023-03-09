
-- Using Getdate().

select GETDATE() as RightNow;

-- Using Month, Day and Year.

select MONTH(Getdate()) as ThisMonth;

select Day(Getdate()) as ThisDay;

select Year(Getdate()) as ThisYear;

-- Using DatePart.

select DATEPART(dy, Getdate()) as [Day of Year];

select DATEPART(dd, Getdate()) as [Date Number];

select DATEPART(ww, Getdate()) as [Week Number];

select DATEPART(dw, Getdate()) as [Week Day];

select DATEPART(hh, Getdate()) as [Hour];

select DATEPART(mi, Getdate()) as [Minute];

select DATEPART(ss, Getdate()) as [Seconds];

-- DateName and DatePart

select DATENAME(qq, Getdate()) as Quarter;

select DATENAME(dw, Getdate()) as WeekDay;

select DATENAME(MONTH, Getdate()) as [Month Name];

select DATENAME(hh, Getdate()) as Hour;

select DATENAME(mi, Getdate()) as Minute;

select DATENAME(ss, Getdate()) as [Seconds];

-- Using DateAdd.

select DATEADD(yy, 2, Getdate()) [Add Year];

select DATEADD(yy, 5, Getdate()) as [After Years], DATENAME(dw, (select DATEADD(yy, 5, Getdate()))) as [Week Day];

select DATEADD(yy, -2, Getdate()) [Sub Year]; 

select DATEADD(mm, 2, Getdate()) [Add Month]; 

select DATEADD(dd, 2, Getdate()) [Add Day]; 


-- Using Datediff

select OrderDate, RequiredDate, ShippedDate,
DATEDIFF(dd, OrderDate, RequiredDate) as [Required Time],
DATEDIFF(dd, OrderDate, ShippedDate) as [Days to Ship],
DATEDIFF(dd, ShippedDate, RequiredDate) as [Days Early]
from dbo.Orders;

Declare @date datetime
set @date = '1996-02-11'
select DateAdd(mm, 1, @date) - (select DATEPART(dd, @date)) as [Last Day of Month],
DATENAME(dw, (select DateAdd(mm, 1, @date) - (select DATEPART(dd, @date)))) as [Week Day Name];

-- Find the name of the weekday of the DEC 31 of this year.

Declare @lastdate datetime
set @lastdate = GETDATE()
select DateAdd(yy, 1, @lastdate) - (select DATEPART(dy, @lastdate)+1) as [Last Day of Year],
DATENAME(dw, (select DateAdd(yy, 1, @lastdate) - (select DATEPART(dy, @lastdate)+1))) as [Last Week Day of Year];




