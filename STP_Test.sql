
-- Create stored procedure for the hotel billing system.

-- Create Tables.

-- Customer Details.

Create table Customer_Details (Customer_ID bigint not null, Name varchar(50) not null, Phone varchar(50) not null,
Address varchar(50) not null, Constraint My_PK_1 Primary Key(Customer_ID));

-- Room type and its Rent PerDay.

Create table Room_Category(Category varchar(5) not null, Description text, Rent numeric (10,2),
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
Room_Number varchar(50) not null, Rent_of_Stay numeric(10,2),
Constraint My_FK_5 Foreign Key (Booking_ID, Customer_ID, Room_Number) 
references Room_Allotment(Booking_ID, Customer_ID, Room_Number));

-- Prepare Bill

Create table Final_Bill(Bill_Number bigint not null Constraint My_PK_6 Primary Key,
Booking_ID bigint not null, Customer_ID bigint not null, Total_Bill_Amount numeric (10,2));


----------------------------------------------------------------------------------------------------------------------------

-- Creating Stored Procedures.

-- STP for Customer Entry

Create Procedure STP_Customer_Entry(@Customer_ID bigint, @Name varchar(50), @Phone varchar(50), @Address varchar(50))
as
begin
	if exists(select Customer_ID from Customer_Details where Customer_ID = @Customer_ID)
	begin
		raiserror('Customer_ID already exists...', 16, 1)
	end

	else
	begin
		insert into Customer_Details values(@Customer_ID, @Name, @Phone, @Address)
	end
end

exec STP_Customer_Entry 1, 'Udhai', '952496', 'Woraiyur, Trichy'


select * from Customer_Details

-- STP for room types and its rent per day

-- Create table Room_Category(Category varchar(5) not null, Description text, Rent numeric (10,2), Constraint My_PK_2 Primary Key(Category))


Create Procedure STP_Room_Category_Insert(@Category varchar(5), @Description text, @Rent numeric(10,2))
as
begin
	if exists(select Category from Room_Category where Category = @Category)
	begin
		raiserror('Room category already exists...', 16, 1)
	end

	else
	begin
		insert into Room_Category values(@Category, @Description, @Rent)
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

Alter Procedure STP_Check_IN (@Customer_ID bigint, @Room_Number varchar(50), @Reason text)
as
begin
	declare @Booking_ID bigint
	set @Booking_ID = ((select COUNT(Booking_ID) from Room_Allotment) + 1)

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















