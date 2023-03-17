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

Alter Procedure STP_Employee_Insert(@id int, @name varchar(50), @adid int)
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

-- Checking Foreign Key constraint.

Alter Procedure STP_Employee_Insert (@id int, @name varchar(50), @adid int)
as
begin
	if exists(Select EmpID from dbo.Employee where EmpID = @id)
	begin
		raiserror('Employee ID is already Exists', 17, 1)
	end

	else
	begin
		if exists(Select Add_Id from dbo.Emp_Address where Add_ID = @adid)
		begin
			insert into dbo.Employee values (@id, @name, @adid)
		end

		else
		begin
			raiserror('No Data for the given Address_Id...', 16, 1)
		end
	end
end

exec STP_Employee_Insert @name = 'Ragu', @id = 6, @adid = 1

-- Throws error, because there is no data for address id 1 in address table.

insert into Emp_Address values (1, 'Trichy')

insert into Emp_Address values (2, 'Chennai')

insert into Emp_Address values (3, 'Madurai')

insert into Emp_Address values (4, 'Salem')

insert into Emp_Address values (5, 'Coiambatore')

select * from dbo.Emp_Address;

-- Now we have given some data to address table now lets execute stored procedure.


exec STP_Employee_Insert @name = 'Ragu', @id = 6, @adid = 1

select * from dbo.Employee



-- Create SP insert with auto increment support dependent tables.

drop table Employee; 

drop table Emp_Address;

Create table Employee (Emp_ID int not null, Emp_Name varchar(50), Address_ID int);

Create table Emp_Address(Address_ID int not null identity(1,1) Primary Key, City varchar(50));

-- Create SP to insert Employee Details.

Alter Procedure STP_Employee_Details (@ID int, @Name varchar(50), @City varchar(50))
as
begin
	declare @Address_ID int

	if exists(select City from dbo.Emp_Address where City = @City)
	begin
		set @Address_ID = (Select Address_ID from dbo.Emp_Address where City = @City)

		if exists(select Emp_ID from dbo.Employee where Emp_ID = @id)
		begin
			raiserror('Employee ID is already exists', 16, 1)
		end

		else
		begin
			insert into dbo.Employee values(@id, @name, @Address_ID)
		end
	end

	else
	begin
		insert into Emp_Address values(@City)
		set @Address_ID = (select Address_ID from dbo.Emp_Address where City = @City) 

		if exists(select Emp_ID from dbo.Employee where Emp_ID = @id)
		begin
			raiserror('Employee ID is already exists', 16, 1)
		end

		else
		begin
			insert into dbo.Employee values(@id, @name, @Address_ID)
		end
	end
end
-- executing STP

select * from dbo.Employee

select * from dbo.Emp_Address

exec STP_Employee_Details @ID = 1, @Name = 'Udhai', @City = 'Trichy'

exec STP_Employee_Details @ID = 2, @Name = 'Chandran', @City = 'Trichy'

exec STP_Employee_Details @ID = 3, @Name = 'Nancy', @City = 'Trichy'

exec STP_Employee_Details @ID = 4, @Name = 'Ragu', @City = 'Chennai'

exec STP_Employee_Details @ID = 5, @Name = 'Varsha', @City = 'Coimbatore'

exec STP_Employee_Details @ID = 6, @Name = 'Sathish', @City = 'Trichy'

exec STP_Employee_Details @ID = 7, @Name = 'Arun', @City = 'Coimbatore'

exec STP_Employee_Details @ID = 8, @Name = 'Ashik', @City = 'Karur'


-- Validation using SP
-- Some text conversions are also possible.

Create table Customers (Cust_Name varchar(50), email varchar(50), Country varchar(50), City varchar(50));


Create Procedure STP_Customer_Insert(@Name varchar(50), @email varchar(50), @Country varchar(50), @City varchar(50))
as
begin
	-- Validate PrimaryKey.
	if exists (Select Cust_Name from dbo.Customers where Cust_Name = @Name)
	begin
		raiserror('Customer name is already exists', 16,1)
	end

	else
	-- If customer is not already there.
	begin
		-- to change upper case.
		set @Name = upper(@Name)
		set @Country = upper(@Country)
		set @City = upper(@City)

		-- Validate email
		declare @val_email tinyint
		set @val_email = charindex('@', @email)

		if @val_email < 2
		begin
			raiserror('Invalid email id....', 16, 1)
			return
		end

		else
		begin
			insert into dbo.Customers values(@Name, @email, @Country, @City)
		end
	end
end

exec STP_Customer_Insert 'Udhai', 'udhaikumar4@gmail.com', 'India', 'Trichy'

select * from dbo.Customers;

exec STP_Customer_Insert 'Sathish', 'S@athish.com', 'India', 'Trichy'






			






