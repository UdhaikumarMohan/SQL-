use Stored_ProceduresDB
Go
-- Stored Procedures.

-- Create a table by the name of Employee.

Create table Employee(EmpID int, EmpName varchar(50), Add_Id int);

-- Create another table to store Employee Address.

Create table Emp_Address(Add_ID int Primary key, City varchar(50));

-- Create stored procedure for inserting data int Employee.

-- Create/Alter Procedure Procedure_Name(@Parameter_1 type, @Parameter_2 type....)

-- as
-- begin
-- Code
-- end

Create Procedure STP_Employee_insert(@id int, @name varchar(50), @adid int)
as
begin
	insert into Employee values(@id, @name, @adid)
end;

-- Now Execute stored procedure.

-- Note Create/Alter SP and Executing SP should be done seperately

exec STP_Employee_insert 1, 'Udhai', 1;
exec STP_Employee_insert 2, 'Ramesh', 2;
exec STP_Employee_insert 3, 'Chandran', 3;

select * from dbo.Employee;

-- We can execute SP using keys and values also. Using keys does not require any order.

exec STP_Employee_insert @name = 'Nancy', @adid = 4, @id = 4

select * from dbo.Employee;

-- Employee table does not contain any primary key, so it will accept repated values.

-- Even if we give PK and provide repeated values, it will throw an PK error, which is not understandable for user.

-- To counter that we create a SP for inserting data into employee and to check Primary Key constraint.

alter Procedure STP_Employee_Insert(@id int, @name varchar(50), @adid int)
as
begin
	if exists (Select EmpID from dbo.Employee where EmpID = @id)

		begin
			
			raiserror('Employee_ID is already exists...', 17,1)

		end

	else

		begin
			
			insert into dbo.Employee values(@id, @name, @adid)

		end
end

exec STP_Employee_Insert @name = 'Akram', @id = 1, @adid = 5

exec STP_Employee_Insert @name = 'Akram', @id = 5, @adid = 5

Select * from dbo.Employee;
			





