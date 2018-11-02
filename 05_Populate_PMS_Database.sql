USE [PMS]
GO
--- Populate Address Table
--- Dennys, 123, Main Miller, 
GO
INSERT INTO Address ([Address_Name], [Address_Street_Number], [Address_Street_Name], [Address_Street_Type], [Address_City], 
					 [Address_ZIP], [Address_State], [Address_Country])
	VALUES ('DENNYS', '2800', 'Los Serranos', 'Blvd', 'Chino Hills', '91709', 'CA', 'USA');
GO
INSERT INTO Address ([Address_Name], [Address_Street_Number], [Address_Street_Name], [Address_Street_Type], [Address_City], 
					 [Address_ZIP], [Address_State], [Address_Country])
	VALUES ('STARBUCKS', '4200', 'Chino Hills', 'Pkwy', 'Chino Hills', '91709', 'CA', 'USA');
GO

--- Populate Person Table
--- Fred Miller, 
GO
INSERT INTO Person ([Person_Lastname], [Person_Firstname], [Person_Address_ID]) 
	VALUES ('MILLER', 'FRED', 1);
GO
INSERT INTO Person ([Person_Lastname], [Person_Firstname], [Person_Address_ID]) 
	VALUES ('The Dog', 'Louie', 2);
GO

--- Populate Task Table
--- clean the garage, Make the bed
GO
INSERT INTO Task ([Task_Description], [Task_Owner_ID])
	VALUES ('clean the garage', 0)
GO
INSERT INTO Task ([Task_Description], [Task_Owner_ID])
	VALUES ('make the bed', 1)
GO
INSERT INTO Task ([Task_Description], [Task_Owner_ID])
	VALUES ('rotate tires', 1)
GO