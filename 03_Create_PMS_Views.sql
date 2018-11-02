USE [PMS]
GO
/****** Object:  View [dbo].[Person_View]    Script Date: 04/13/2014 00:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Person_View]
AS
SELECT		dbo.Person.Person_ID, dbo.Person.Person_Lastname, dbo.Person.Person_Firstname, dbo.Person.Person_Phone_Number_Home,
			dbo.Person.Person_Phone_Number_Mobile, dbo.Person.Person_Phone_Number_Work, dbo.Address.Address_ID, 
            dbo.Address.Address_Name, dbo.Address.Address_Street_Number, dbo.Address.Address_Street_Name, 
            dbo.Address.Address_Street_Type, dbo.Address.Address_City, dbo.Address.Address_ZIP,
            dbo.Address.Address_State, dbo.Address.Address_Country
FROM        dbo.Person INNER JOIN
            dbo.Address ON dbo.Person.Person_Address_ID = dbo.Address.Address_ID

GO

CREATE VIEW [dbo].[SubTask_View]
AS
SELECT		dbo.Task.Task_ID AS Parent_Task_ID, P.Task_ID, P.Task_Description, P.Task_Owner_ID
FROM		dbo.Task RIGHT OUTER JOIN
			dbo.Task AS P ON P.Task_Owner_ID = dbo.Task.Task_ID
GO