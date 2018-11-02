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

/****** Object:  Database [PMS]    Script Date: 7/21/2016 3:08:41 PM ******/
CREATE DATABASE [PMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PMS', FILENAME = N'D:\rdsdbdata\DATA\PMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PMS_log', FILENAME = N'D:\rdsdbdata\DATA\PMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [PMS] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [PMS] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [PMS] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [PMS] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [PMS] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [PMS] SET ARITHABORT OFF 
GO

ALTER DATABASE [PMS] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [PMS] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [PMS] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [PMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [PMS] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [PMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [PMS] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [PMS] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [PMS] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [PMS] SET  DISABLE_BROKER 
GO

ALTER DATABASE [PMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [PMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [PMS] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [PMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [PMS] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [PMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [PMS] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [PMS] SET RECOVERY FULL 
GO

ALTER DATABASE [PMS] SET  MULTI_USER 
GO

ALTER DATABASE [PMS] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [PMS] SET DB_CHAINING OFF 
GO

ALTER DATABASE [PMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [PMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [PMS] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [PMS] SET QUERY_STORE = OFF
GO

USE [PMS]
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

ALTER DATABASE [PMS] SET  READ_WRITE 
GO

-- verify the database files and sizes
select name, physical_name, size, size*1.0/128 as [size in mbs]
from sys.master_files
where physical_name like N'%PMS_dat.mdf' or
physical_name like N'%PMS_log.ldf';
go

CREATE LOGIN PMS WITH PASSWORD = 'newpassword'
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'PMS')
BEGIN
    CREATE USER [PMS] FOR LOGIN [PMS]
    EXEC sp_addrolemember N'db_owner', N'PMS'
END;
GO

use PMS
GO

set nocount on
-- A build table is useful if you develop a lot of databases,
-- when you make changes you can always insert another
-- row and have a personalized audit trail
create table [dbo].[tblBuild] (
[strscripttype] [nvarchar] (60) not null constraint def_tblBuild_strscripttype default '~na~',
[strscriptran] [nvarchar] (150) not null constraint def_tblBuild_strscriptran default '~na~'
) on [primary]
go

declare @build [nvarchar] (150)
set @build = N'Create_PMS_Database.sql version 1.0 (RBW)'
insert into tblBuild (strscripttype, strscriptran) values (@build, (cast(getdate() as nvarchar)))
select * from tblBuild
go
