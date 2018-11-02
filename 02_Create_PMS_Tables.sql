use [PMS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON

GO
CREATE TABLE [dbo].[PMS_DataObject_Type] (
	[PMS_DataObject_Type_ID] [int] IDENTITY(1,1) NOT NULL,
	[PMS_DataObject_Type_Name] [varchar](50) NOT NULL,
	CONSTRAINT [PK_PMS_DataObject_Type] PRIMARY KEY CLUSTERED
(
	[PMS_DataObject_Type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
	
GO
CREATE TABLE [dbo].[PMS_Table] (
	[PMS_Table_ID] [int] IDENTITY(1,1) NOT NULL,
	[PMS_Table_Name] [varchar](50) NOT NULL,
	CONSTRAINT [PK_PMS_Table] PRIMARY KEY CLUSTERED
(
	[PMS_Table_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


GO
CREATE TABLE [dbo].[PMS_DataObject] (
	[PMS_DataObject_ID] [int] IDENTITY(1,1) NOT NULL,
	[PMS_DataObject_Name] [varchar](50),
	[PMS_DataObject_Type_ID] [int] NOT NULL,
	CONSTRAINT [PK_PMS_DataObject] PRIMARY KEY CLUSTERED
(
	[PMS_DataObject_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PMS_DataObject]  WITH CHECK ADD  CONSTRAINT [FK_PMS_DataObject_Type] FOREIGN KEY([PMS_DataObject_Type_ID])
REFERENCES [dbo].[PMS_DataObject_Type] ([PMS_DataObject_Type_ID])
GO
ALTER TABLE [dbo].[PMS_DataObject] CHECK CONSTRAINT [FK_PMS_DataObject_Type]

GO
CREATE TABLE [dbo].[PMS_DataObject_XREF](
	[PMS_DataObject_XREF_ID] [int] IDENTITY(1,1) NOT NULL,
	[PMS_Parent_DataObject_ID] [int] NOT NULL,
	[PMS_Child_DataObject_ID] [int] NOT NULL,
 CONSTRAINT [PK_PMS_DataObject_XREF] PRIMARY KEY CLUSTERED 
(
	[PMS_DataObject_XREF_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[PMS_DataObject_XREF]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Parent_DataObject_XREF] FOREIGN KEY([PMS_Parent_DataObject_ID])
REFERENCES [dbo].[PMS_DataObject] ([PMS_DataObject_ID])
GO
ALTER TABLE [dbo].[PMS_DataObject_XREF] CHECK CONSTRAINT [FK_PMS_Parent_DataObject_XREF]

GO
ALTER TABLE [dbo].[PMS_DataObject_XREF]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Child_DataObject_XREF] FOREIGN KEY([PMS_Child_DataObject_ID])
REFERENCES [dbo].[PMS_DataObject] ([PMS_DataObject_ID])
GO
ALTER TABLE [dbo].[PMS_DataObject_XREF] CHECK CONSTRAINT [FK_PMS_Child_DataObject_XREF]

GO
CREATE TABLE [dbo].[Address] (
	[Address_ID] [int] IDENTITY(1,1) NOT NULL,
	[Address_Name] [varchar](50),
	[Address_Street_Number] [varchar](50) NOT NULL,
	[Address_Street_Name] [varchar](50) NOT NULL,
	[Address_Street_Type] [varchar] (50),
	[Address_City] [varchar](50) NOT NULL,
	[Address_ZIP] [varchar](50) NOT NULL,
	[Address_State] [varchar](50) NOT NULL,
	[Address_Country] [varchar](50) NOT NULL,
	CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED
(
	[Address_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



GO
/****** Object:  Table [dbo].[Person]    Script Date: 05/19/2014 23:49:24 ******/
CREATE TABLE [dbo].[Person](
	[Person_ID] [int] IDENTITY(1,1) NOT NULL,
	[Person_Lastname] [varchar](50) NOT NULL,
	[Person_Firstname] [varchar](50) NOT NULL,
	[Person_Address_ID] [int] NOT NULL,
	[Person_Phone_Number_Home] [varchar](50) NULL,
	[Person_Phone_Number_Mobile] [varchar](50) NULL,
	[Person_Phone_Number_Work] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Person_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Address] FOREIGN KEY([Person_Address_ID])
REFERENCES [dbo].[Address] ([Address_ID])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Address]

GO
CREATE TABLE [dbo].[Task](
	[Task_ID] [int] IDENTITY(1,1) NOT NULL,
	[Task_Description] [varchar](50) NOT NULL,
	[Task_Owner_ID] [int] NOT NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[Task_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO