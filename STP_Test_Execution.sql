

-- Insert Room Number

exec STP_Room_Category_Insert @Category = 'O+', @Description = 'Premier Room', @Rent = 5000.00

exec STP_Room_Category_Insert @Category = 'A+', @Description = 'Double Bed with View', @Rent = 4000.00

exec STP_Room_Category_Insert @Category = 'A', @Description = 'Double Bed without View', @Rent = 3500.00

exec STP_Room_Category_Insert @Category = 'B+', @Description = 'Standard room with Double Bed', @Rent = 2500.00

exec STP_Room_Category_Insert @Category = 'B', @Description = 'Standard Room with Single Bed', @Rent = 2000.00

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

exec STP_Check_IN @Customer_ID = 1, @Room_Number = 'P1', @Reason = 'Bussiness Meeting'

exec STP_Check_IN @Customer_ID = 1, @Room_Number = 'P2', @Reason = 'Bussiness Meeting'

select * from Room_Availability

select * from Room_Allotment 



