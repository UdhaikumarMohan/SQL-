
-- Create stored procedure for the hotel billing system.

-- Create Tables.

-- Customer Details.

Create table Customer_Details (Customer_ID bigint not null, Name varchar(50) not null, Phone varchar(50) not null,
Address varchar(50) not null, Constraint My_PK_1 Primary Key(Customer_ID));

-- Room type and its Rent PerDay.

Create table Room_Category(Category varchar(5) not null, Description text, Rent numeric (10,2),
Tax_in_Percentage numeric(10,2), Total_Rent numeric(10,2),
Constraint My_PK_2 Primary Key(Category));

-- Room Numbers and its availability

Create table Room_Availability(Room_Number varchar(50) not null,
Category varchar(5) Constraint My_FK_1 Foreign Key references Room_Category(Category),
Availability varchar(50) Constraint Default_1 Default 'Yes', 
Constraint My_PK_3 Primary Key(Room_Number))

-- Room Allotment

Create table Room_Allotment(Booking_ID bigint not null,
Customer_ID bigint not null Constraint My_FK_2 Foreign Key references Customer_Details(Customer_ID),
Room_Number varchar(50) not null Constraint My_FK_3 Foreign Key references Room_Availability(Room_Number),
Reason text, Check_IN datetime,
Constraint My_PK_4 Primary Key(Booking_ID, Customer_ID, Room_Number));

-- Time of Stay

Create table Time_of_Stay(Booking_ID bigint not null,
Customer_ID bigint not null,
Room_Number varchar(50) not null, Check_Out datetime, Duration int,
Constraint My_FK_4 Foreign Key (Booking_ID, Customer_ID, Room_Number) 
references Room_Allotment(Booking_ID, Customer_ID, Room_Number));

-- Rent calculation

Create table Room_Rent(Booking_ID bigint not null,
Customer_ID bigint not null,
Room_Number varchar(50) not null, Duration_in_Days int, Rent_of_Stay numeric(10,2),
Constraint My_FK_5 Foreign Key (Booking_ID, Customer_ID, Room_Number) 
references Room_Allotment(Booking_ID, Customer_ID, Room_Number));

-- Prepare Bill

Create table Final_Bill(Bill_Number bigint not null Constraint My_PK_6 Primary Key,
Booking_ID bigint not null, Customer_ID bigint not null, Total_Bill_Amount numeric (10,2));


----------------------------------------------------------------------------------------------------------------------------

-- Creating Stored Procedures.

-- STP for Customer Entry

Alter Procedure STP_Customer_Entry(@Name varchar(50), @Phone varchar(50), @Address varchar(50))
as
begin
	Declare @Customer_ID bigint
	set @Customer_ID = ((select MAX(Customer_ID) from Customer_Details) + 1)
	insert into Customer_Details values(@Customer_ID, @Name, @Phone, @Address)
end


-- STP for room types and its rent per day

-- Create table Room_Category(Category varchar(5) not null, Description text, Rent numeric (10,2), Constraint My_PK_2 Primary Key(Category))


Alter Procedure STP_Room_Category_Insert(@Category varchar(5), @Description text, @Rent numeric(10,2), @Tax numeric(10,2))
as
begin
	declare @Total_Rent numeric
	set @Total_Rent = ((@Rent/100) * @Tax) + @Rent

	if exists(select Category from Room_Category where Category = @Category)
	begin
		raiserror('Room category already exists...', 16, 1)
	end

	else
	begin
		insert into Room_Category values(@Category, @Description, @Rent, @Tax, @Total_Rent)
	end
end

-- Update Room Rent

Create Procedure STP_Room_Category_Update(@Category varchar(5), @Rent numeric(10,2))
as
begin
	update Room_Category set Rent = @Rent where Category = @Category
end


select * from Room_Category


/*Create STP for Room_Availability
Create table Room_Availability(Room_Number varchar(50) not null,
Category varchar(5) Constraint My_FK_1 Foreign Key references Room_Category(Category),
Availability varchar(50) Constraint Default_1 Default 'Yes', 
Constraint My_PK_3 Primary Key(Room_Number))*/

Create Procedure STP_Room_Availability_Insert
(@Room_Number varchar(50), @Category varchar(5), @Availability varchar(50) = 'Yes')
as
begin
	if exists(select Room_Number from Room_Availability where Room_Number = @Room_Number)
	begin
		raiserror('The given room number is already exists...', 16, 1)
	end
	
	else
	begin
		if exists(select Category from Room_Category where Category = @Category)
		begin
			insert into Room_Availability values(@Room_Number, @Category, @Availability)
		end

		else
		begin
			raiserror('The given room number is does not exists in this hotel...', 16, 1)
		end
	end
end


-- Check_IN process

/*Create table Room_Allotment(Booking_ID bigint not null,
Customer_ID bigint not null Constraint My_FK_2 Foreign Key references Customer_Details(Customer_ID),
Room_Number varchar(50) not null Constraint My_FK_3 Foreign Key references Room_Availability(Room_Number),
Reason text, Check_IN datetime,
Constraint My_PK_4 Primary Key(Booking_ID, Customer_ID, Room_Number));*/


/*Create table Room_Rent(Booking_ID bigint not null,
Customer_ID bigint not null,
Room_Number varchar(50) not null, Duration_in_Days int, Rent_of_Stay numeric(10,2),
Constraint My_FK_5 Foreign Key (Booking_ID, Customer_ID, Room_Number) 
references Room_Allotment(Booking_ID, Customer_ID, Room_Number));*/

Alter Procedure STP_Check_IN (@Booking_ID bigint, @Customer_ID bigint, @Room_Number varchar(50), @Reason text)
as
begin
	
	/* We cannot call date function in the execution. So we declare Check_In date here in STP.
	If we want to give date and time manually then we wil give input through execution. */

	declare @Check_IN datetime
	set @Check_IN = GETDATE()

	if exists(select Customer_ID from Customer_Details where Customer_ID = @Customer_ID)
	begin
		
		if exists(select Room_Number from Room_Availability where Room_Number = @Room_Number)
		begin
			declare @is_avail varchar(50)
			set @is_avail = 'No'

			if (select Availability from Room_Availability where Room_Number = @Room_Number) = @is_avail
			begin
				raiserror('This Room is already booked...', 16,1)				
			end

			else
			begin
				insert into Room_Allotment values(@Booking_ID, @Customer_ID, @Room_Number, @Reason, @Check_IN)
				
				update Room_Availability set Availability = 'No' where Room_Number = @Room_Number

				declare @Check_OUT datetime
				declare @Duration int
				declare @Rent numeric(10,2)

				set @Check_OUT = Null
				set @Duration = Null
				set @Rent = Null

				insert into Time_of_Stay values(@Booking_ID, @Customer_ID, @Room_Number, @Check_OUT, @Duration)

				insert into Room_Rent values(@Booking_ID, @Customer_ID, @Room_Number, @Duration, @Rent)
			end
		end

		else
		begin
			raiserror('Room_Number does not exists in this Hotel...', 16, 1)
		end
	end

	else
	begin
		raiserror('Customer_ID does not exists. Please add Customer in Customer_Details...', 16, 1)
	end
end

-- Check_OUT process

/*Create table Time_of_Stay(Booking_ID bigint not null,
Customer_ID bigint not null,
Room_Number varchar(50) not null, Check_Out datetime, Duration int,
Constraint My_FK_4 Foreign Key (Booking_ID, Customer_ID, Room_Number) 
references Room_Allotment(Booking_ID, Customer_ID, Room_Number));*/

Alter Procedure STP_Check_OUT(@Booking_ID bigint, @Room_Number varchar(50))
as
begin
	
	if ((select Room_Number from Room_Allotment where Booking_ID = @Booking_ID and Room_Number = @Room_Number) = @Room_Number)
	begin
		
		if ((select Availability from Room_Availability where Room_Number = @Room_Number) = 'No')
		begin
			declare @Check_IN datetime
			set @Check_IN = (select Check_IN from Room_Allotment where Booking_ID = @Booking_ID and Room_Number = @Room_Number)

			declare @Check_OUT datetime
			set @Check_OUT = GETDATE()

			declare @Duration int
			set @Duration = DATEDIFF(dd, @Check_IN, @Check_OUT) + 1

			declare @Rent_of_Stay numeric(10,2)
			set @Rent_of_Stay = (select Total_Rent from 
			(select A.Room_Number, C.Category, C.Total_Rent 
			from Room_Availability as A 
			join Room_Category as C on A.Category = C.Category)
			as Room_Rent where Room_Number = @Room_Number)

			update Time_of_Stay set Check_Out = @Check_OUT, Duration = @Duration where Booking_ID = @Booking_ID and Room_Number = @Room_Number

			update Room_Rent set Duration_in_Days = @Duration, Rent_of_Stay = @Rent_of_Stay

			update Room_Availability set Availability = 'Yes' where Room_Number = @Room_Number
	
		end

		else
		begin
			raiserror('This Room_Number is already checked out...', 16, 1)
		end
	end
	
	else
	begin
		raiserror('This Room is not booked under this Booking_ID, Plese provide correct Room_Number or Booking_ID...', 16,1)
	end 
end





















