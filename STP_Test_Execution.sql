-- Insert Customer_Details

exec STP_Customer_Entry 'Udhai', '952496', 'Woraiyur, Trichy'

exec STP_Customer_Entry 'Ramesh', '999382', 'Thuvarankuruchi, Trichy'

exec STP_Customer_Entry 'Muthuram', '889781', 'Adayar, Chennai'

exec STP_Customer_Entry 'Sada Sivan', '720102', 'Munichalai, Madurai'


select * from Customer_Details

-- Insert Room Number

exec STP_Room_Category_Insert @Category = 'O+', @Description = 'Premier Room', @Rent = 5000.00, @Tax = 10

exec STP_Room_Category_Insert @Category = 'A+', @Description = 'Double Bed with View', @Rent = 4000.00, @Tax = 5

exec STP_Room_Category_Insert @Category = 'A', @Description = 'Double Bed without View', @Rent = 3500.00, @Tax = 5

exec STP_Room_Category_Insert @Category = 'B+', @Description = 'Standard room with Double Bed', @Rent = 2500.00, @Tax = 2.50

exec STP_Room_Category_Insert @Category = 'B', @Description = 'Standard Room with Single Bed', @Rent = 2000.00, @Tax = 2.50

Select * from Room_Category

-- Execute update room number

exec STP_Room_Category_Update @Category = 'O+', @Rent = 5000.00

-- Room_Number and Room_Availability

exec STP_Room_Availability_Insert @Room_Number = 'G1', @Category = 'B'

exec STP_Room_Availability_Insert @Room_Number = 'G2', @Category = 'B'

exec STP_Room_Availability_Insert @Room_Number = 'G3', @Category = 'B'

exec STP_Room_Availability_Insert @Room_Number = 'G4', @Category = 'B'

exec STP_Room_Availability_Insert @Room_Number = 'G5', @Category = 'B'

exec STP_Room_Availability_Insert @Room_Number = 'G6', @Category = 'B'

exec STP_Room_Availability_Insert @Room_Number = 'F1', @Category = 'B+'

exec STP_Room_Availability_Insert @Room_Number = 'F2', @Category = 'B+'

exec STP_Room_Availability_Insert @Room_Number = 'F3', @Category = 'B+'

exec STP_Room_Availability_Insert @Room_Number = 'F4', @Category = 'B+'

exec STP_Room_Availability_Insert @Room_Number = 'S1', @Category = 'A'

exec STP_Room_Availability_Insert @Room_Number = 'S2', @Category = 'A'

exec STP_Room_Availability_Insert @Room_Number = 'S3', @Category = 'A'

exec STP_Room_Availability_Insert @Room_Number = 'S4', @Category = 'A'

exec STP_Room_Availability_Insert @Room_Number = 'T1', @Category = 'A+'

exec STP_Room_Availability_Insert @Room_Number = 'T2', @Category = 'A+'

exec STP_Room_Availability_Insert @Room_Number = 'T3', @Category = 'A+'

exec STP_Room_Availability_Insert @Room_Number = 'T4', @Category = 'A+'

exec STP_Room_Availability_Insert @Room_Number = 'P1', @Category = 'O+'

exec STP_Room_Availability_Insert @Room_Number = 'P2', @Category = 'O+'

exec STP_Room_Availability_Insert @Room_Number = 'P3', @Category = 'O+'

select * from Room_Availability

-- Executing Check_IN

exec STP_Check_IN @Booking_ID = 1, @Customer_ID = 1, @Room_Number = 'P1', @Reason = 'Bussiness Meeting'

exec STP_Check_IN @Booking_ID = 1, @Customer_ID = 1, @Room_Number = 'P2', @Reason = 'Bussiness Meeting'

exec STP_Check_IN @Booking_ID = 2, @Customer_ID = 2, @Room_Number = 'S1', @Reason = 'Transit'

exec STP_Check_IN @Booking_ID = 3, @Customer_ID = 4, @Room_Number = 'T3', @Reason = 'Tour'

exec STP_Check_IN @Booking_ID = 3, @Customer_ID = 4, @Room_Number = 'T2', @Reason = 'Tour'

exec STP_Check_IN @Booking_ID = 4, @Customer_ID = 3, @Room_Number = 'F1', @Reason = 'Conference'


exec STP_Check_OUT @Booking_ID = 3, @Room_Number = 'T2'

exec STP_Check_OUT @Booking_ID = 1, @Room_Number = 'P1'

exec STP_Check_OUT @Booking_ID = 1, @Room_Number = 'P2'

exec STP_Check_OUT @Booking_ID = 4, @Room_Number = 'F1'

exec STP_Check_OUT @Booking_ID = 3, @Room_Number = 'T3'

exec STP_Check_OUT @Booking_ID = 2, @Room_Number = 'S1'




select * from Room_Availability

select * from Room_Allotment 

select * from Time_of_Stay





