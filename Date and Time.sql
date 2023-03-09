

-- Using convert with S type

-- MS-SQL GetDate() returns current system date and time is standard internal format.

select Getdate();

-- Style 1 formats date in short format (YY).

-- Style 100 formats date in long format (YYYY).

select convert (varchar(20), Getdate(), 1) as '1 - mm/dd/yy US with yy';

select convert (varchar(20), Getdate(), 100) as '100 - mm/dd/yyyy US with yyyy: hh/mm AM(PM)';

select convert (varchar(20), Getdate(), 101) as '101 - mm/dd/yyyy US with yyyy';

select convert (varchar(20), Getdate(), 102) as '102 - yyyy.mm.dd ANSI';

select convert (varchar(20), Getdate(), 103) as '103 - British and French format';

select convert (varchar(20), Getdate(), 104) as 'German';

select convert (varchar(20), Getdate(), 105) as 'Italian';

select convert (varchar(20), Getdate(), 106);

select convert (varchar(20), Getdate(), 107);

select convert (varchar(20), Getdate(), 108);

select convert (varchar(20), Getdate(), 109);

select convert (varchar(20), Getdate(), 110);

select convert (varchar(20), Getdate(), 111) as 'Japan';

select convert (varchar(20), Getdate(), 112) as 'ISO';

select convert (varchar(20), Getdate(), 113);

select convert (varchar(20), Getdate(), 114);

select convert (varchar(20), Getdate(), 120);

select convert (varchar(20), Getdate(), 121);

select convert (varchar(20), Getdate(), 126);