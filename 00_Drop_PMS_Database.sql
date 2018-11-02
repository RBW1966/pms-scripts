USE [master]
GO

SELECT DB_ID(N'PMS') AS [Database ID];  
GO 
-- if PMS exists already delete it
--IF db_id (N'PMS') is not null 

IF DB_ID(N'PMS') IS NOT NULL
   ALTER DATABASE [PMS] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
   DROP DATABASE [PMS]
GO

SELECT DB_ID(N'PMS') AS [Database ID];  
GO
