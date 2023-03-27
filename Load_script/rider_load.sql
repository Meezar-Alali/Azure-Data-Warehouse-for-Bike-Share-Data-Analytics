IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'udacitymeezar1_udacitymeezar1_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [udacitymeezar1_udacitymeezar1_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://udacitymeezar1@udacitymeezar1.dfs.core.windows.net', 
		TYPE = HADOOP 
	)
GO

CREATE EXTERNAL TABLE dbo.staging_rider (
	[rider_id] bigint,
	[firstName] nvarchar(4000),
	[lastName] nvarchar(4000),
	[address] nvarchar(4000),
	[birthday] VARCHAR(50),
	[account_start_date] VARCHAR(50),
	[account_end_date] VARCHAR(50),
	[is_Member] bit
	)
	WITH (
	LOCATION = 'publicrider.txt',
	DATA_SOURCE = [udacitymeezar1_udacitymeezar1_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_rider
GO