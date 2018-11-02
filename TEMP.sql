USE [PMS]
GO
SELECT * FROM [PMS].[dbo].[SubTask_View]
ORDER BY Task_Owner_ID, Task_ID








CREATE LOGIN PMS WITH PASSWORD = 'newpassword'
GO

Use [PMS];
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'PMS')
BEGIN
    CREATE USER [PMS] FOR LOGIN [PMS]
    EXEC sp_addrolemember N'db_owner', N'PMS'
END;
GO