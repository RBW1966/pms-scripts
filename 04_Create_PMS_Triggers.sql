Use [PMS]
GO

-- Delete existing table
IF OBJECT_ID('[dbo].[LOG_TABLE_CHANGES]') IS NOT NULL 
  DROP TABLE [dbo].[LOG_TABLE_CHANGES]
GO


-- Add the table
CREATE TABLE [dbo].[LOG_TABLE_CHANGES]
(
  [CHG_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
  [CHG_DATE] [datetime] NOT NULL,
  [CHG_TYPE] [varchar](20) NOT NULL,
  [CHG_BY] [nvarchar](256) NOT NULL,
  [APP_NAME] [nvarchar](128) NOT NULL,
  [HOST_NAME] [nvarchar](128) NOT NULL,
  [SCHEMA_NAME] [sysname] NOT NULL,
  [OBJECT_NAME] [sysname] NOT NULL,
  [XML_RECSET] [xml] NULL,
 CONSTRAINT [PK_LTC_CHG_ID] PRIMARY KEY CLUSTERED ([CHG_ID] ASC)
) ON [PRIMARY]
GO

-- Add defaults for key information
ALTER TABLE [dbo].[LOG_TABLE_CHANGES] ADD CONSTRAINT [DF_LTC_CHG_DATE] DEFAULT (getdate()) FOR [CHG_DATE];
ALTER TABLE [dbo].[LOG_TABLE_CHANGES] ADD CONSTRAINT [DF_LTC_CHG_TYPE] DEFAULT ('') FOR [CHG_TYPE];
ALTER TABLE [dbo].[LOG_TABLE_CHANGES] ADD CONSTRAINT [DF_LTC_CHG_BY] DEFAULT (coalesce(suser_sname(),'?')) FOR [CHG_BY];
ALTER TABLE [dbo].[LOG_TABLE_CHANGES] ADD CONSTRAINT [DF_LTC_APP_NAME] DEFAULT (coalesce(app_name(),'?')) FOR [APP_NAME];
ALTER TABLE [dbo].[LOG_TABLE_CHANGES] ADD CONSTRAINT [DF_LTC_HOST_NAME] DEFAULT (coalesce(host_name(),'?')) FOR [HOST_NAME];


-- Delete Person_Change trigger
IF OBJECT_ID('[dbo].[Person_Change]') IS NOT NULL 
  DROP TRIGGER [dbo].[Person_Change]
GO
-- Add Person_Change trigger to log all changes
CREATE TRIGGER [dbo].[Person_Change] ON [dbo].[Person]
  FOR INSERT, UPDATE, DELETE AS
BEGIN
  -- Detect inserts
  IF EXISTS (select * from inserted) AND NOT EXISTS (select * from deleted)
  BEGIN
    INSERT [dbo].[LOG_TABLE_CHANGES] ([CHG_TYPE], [SCHEMA_NAME], [OBJECT_NAME], [XML_RECSET])
    SELECT 'INSERT', '[dbo]', '[Person]', (SELECT * FROM inserted as Record for xml auto, elements , root('RecordSet'), type)
    RETURN;
  END
  -- Detect deletes
  IF EXISTS (select * from deleted) AND NOT EXISTS (select * from inserted)
  BEGIN
    INSERT [dbo].[LOG_TABLE_CHANGES] ([CHG_TYPE], [SCHEMA_NAME], [OBJECT_NAME], [XML_RECSET])
    SELECT 'DELETE', '[dbo]', '[Person]', (SELECT * FROM deleted as Record for xml auto, elements , root('RecordSet'), type)
    RETURN;
  END
  -- Update inserts
  IF EXISTS (select * from inserted) AND EXISTS (select * from deleted)
  BEGIN
    INSERT [dbo].[LOG_TABLE_CHANGES] ([CHG_TYPE], [SCHEMA_NAME], [OBJECT_NAME], [XML_RECSET])
    SELECT 'UPDATE', '[dbo]', '[Person]', (SELECT * FROM deleted as Record for xml auto, elements , root('RecordSet'), type)
    RETURN;
  END
END;
GO

-- Delete Address_Change trigger
IF OBJECT_ID('[dbo].[Address_Change]') IS NOT NULL 
  DROP TRIGGER [dbo].[Address_Change]
GO
-- Add Address_Change trigger to log all changes
CREATE TRIGGER [dbo].[Address_Change] ON [dbo].[Address]
  FOR INSERT, UPDATE, DELETE AS
BEGIN
  -- Detect inserts
  IF EXISTS (select * from inserted) AND NOT EXISTS (select * from deleted)
  BEGIN
    INSERT [dbo].[LOG_TABLE_CHANGES] ([CHG_TYPE], [SCHEMA_NAME], [OBJECT_NAME], [XML_RECSET])
    SELECT 'INSERT', '[dbo]', '[Address]', (SELECT * FROM inserted as Record for xml auto, elements , root('RecordSet'), type)
    RETURN;
  END
  -- Detect deletes
  IF EXISTS (select * from deleted) AND NOT EXISTS (select * from inserted)
  BEGIN
    INSERT [dbo].[LOG_TABLE_CHANGES] ([CHG_TYPE], [SCHEMA_NAME], [OBJECT_NAME], [XML_RECSET])
    SELECT 'DELETE', '[dbo]', '[Address]', (SELECT * FROM deleted as Record for xml auto, elements , root('RecordSet'), type)
    RETURN;
  END
  -- Update inserts
  IF EXISTS (select * from inserted) AND EXISTS (select * from deleted)
  BEGIN
    INSERT [dbo].[LOG_TABLE_CHANGES] ([CHG_TYPE], [SCHEMA_NAME], [OBJECT_NAME], [XML_RECSET])
    SELECT 'UPDATE', '[dbo]', '[Address]', (SELECT * FROM deleted as Record for xml auto, elements , root('RecordSet'), type)
    RETURN;
  END
END;
GO

-- Delete Task_Change trigger
IF OBJECT_ID('[dbo].[Task_Change]') IS NOT NULL 
  DROP TRIGGER [dbo].[Task_Change]
GO
-- Add Task_Change trigger to log all changes
CREATE TRIGGER [dbo].[Task_Change] ON [dbo].[Task]
  FOR INSERT, UPDATE, DELETE AS
BEGIN
  -- Detect inserts
  IF EXISTS (select * from inserted) AND NOT EXISTS (select * from deleted)
  BEGIN
    INSERT [dbo].[LOG_TABLE_CHANGES] ([CHG_TYPE], [SCHEMA_NAME], [OBJECT_NAME], [XML_RECSET])
    SELECT 'INSERT', '[dbo]', '[Task]', (SELECT * FROM inserted as Record for xml auto, elements , root('RecordSet'), type)
    RETURN;
  END
  -- Detect deletes
  IF EXISTS (select * from deleted) AND NOT EXISTS (select * from inserted)
  BEGIN
    INSERT [dbo].[LOG_TABLE_CHANGES] ([CHG_TYPE], [SCHEMA_NAME], [OBJECT_NAME], [XML_RECSET])
    SELECT 'DELETE', '[dbo]', '[Task]', (SELECT * FROM deleted as Record for xml auto, elements , root('RecordSet'), type)
    RETURN;
  END
  -- Update inserts
  IF EXISTS (select * from inserted) AND EXISTS (select * from deleted)
  BEGIN
    INSERT [dbo].[LOG_TABLE_CHANGES] ([CHG_TYPE], [SCHEMA_NAME], [OBJECT_NAME], [XML_RECSET])
    SELECT 'UPDATE', '[dbo]', '[Task]', (SELECT * FROM deleted as Record for xml auto, elements , root('RecordSet'), type)
    RETURN;
  END
END;
GO