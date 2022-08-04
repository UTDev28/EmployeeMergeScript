
USE AdventureWorks2019
GO 

BEGIN TRAN 


	DROP TABLE IF EXISTS #NewRecords
	DROP TABLE IF EXISTS #RecordOutput

	----------------------------------------
	-- Create Log table for updated records
	----------------------------------------

	CREATE TABLE HumanResources.MergeLogs
	(
		[Action] VARCHAR(255) NOT NULL,
		DestinationTable VARCHAR(255) NOT NULL,
		IsError BIT NOT NULL,
		UploadDate DATETIME NULL,
		NationalIDNumber INT NOT NULL 
	)

	-------------------------------------------
	-- Temp table that will store new records
	-------------------------------------------
	CREATE TABLE #NewRecords
	(
		BusinessEntityID INT NOT NULL,
		NationalIDNumber NVARCHAR(15) NOT NULL, 
		LoginID NVARCHAR(256) NOT NULL,
		OrganizationNode HIERARCHYID NULL,
		JobTitle NVARCHAR(50) NOT NULL, 
		BirthDate DATE NOT NULL,
		MaritalStatus NCHAR(1) NOT NULL,
		Gender NCHAR(1) NOT NULL,
		HireDate DATE NOT NULL,
		SalariedFlag BIT NOT NULL,
		VacationHours SMALLINT NOT NULL,
		SickLeaveHours SMALLINT NOT NULL,
		CurrentFlag BIT NOT NULL,
		rowguid VARCHAR(MAX) NOT NULL,
		ModifiedDate DATETIME NOT null

	)

	----------------------------------------
	-- Create temp table that will store the merge results
	----------------------------------------

	CREATE TABLE #RecordOutput
	(
		[Action] VARCHAR(100) NULL,
		DestinationTable VARCHAR(255) NULL,
		IsError BIT NULL,
		UploadDate DATETIME NULL,
		NationalIDNumber NCHAR(15) NULL
	)

	----------------------------------------
	-- Insert new records into the temp table
	----------------------------------------

	INSERT INTO #NewRecords ([BusinessEntityID],[NationalIDNumber], [LoginID], [OrganizationNode], [JobTitle], [BirthDate], [MaritalStatus], [Gender], [HireDate], [SalariedFlag], [VacationHours], [SickLeaveHours], [CurrentFlag], [rowguid], [ModifiedDate])
	VALUES
	(291,N'509647111', N'adventure-works\roberto0', 0x5ac0, N'Engineering Manager', N'1974-11-12', N'M', N'M', N'2007-11-11', 1, 2, 21, 1, '{9bbbfb2c-efbb-4217-9ab7-f97689328841}', N'2014-06-30T00:00:00' ), 
	(292,N'112457891', N'adventure-works\rob0', 0x5ad6, N'Senior Tool Designer', N'1974-12-23', N'S', N'M', N'2007-12-05', 0, 48, 80, 1, '{59747955-87b8-443f-8ed4-f8ad3afdf3a9}', N'2014-06-30T00:00:00' ), 
	(293,N'695256908', N'adventure-works\gail0', 0x5ada, N'Design Engineer', N'1952-09-27', N'M', N'F', N'2008-01-06', 1, 5, 22, 1, '{ec84ae09-f9b8-4a15-b4a9-6ccbab919b08}', N'2014-06-30T00:00:00' ), 
	(294,N'998320692', N'adventure-works\jossef0', 0x5ade, N'Design Engineer', N'1959-03-11', N'M', N'M', N'2008-01-24', 1, 6, 23, 1, '{e39056f1-9cd5-478d-8945-14aca7fbdcdd}', N'2014-06-30T00:00:00' ), 
	(295,N'134969118', N'adventure-works\dylan0', 0x5ae1, N'Research and Development Manager', N'1987-02-24', N'M', N'M', N'2009-02-08', 1, 61, 50, 1, '{4f46deca-ef01-41fd-9829-0adab368e431}', N'2014-06-30T00:00:00' ), 
	(296,N'811994146', N'adventure-works\diane1', 0x5ae158, N'Research and Development Engineer', N'1986-06-05', N'S', N'F', N'2008-12-29', 1, 62, 51, 1, '{31112635-663b-4018-b4a2-a685c0bf48a4}', N'2014-06-30T00:00:00' ), 
	(297,N'658797003', N'adventure-works\gigi0', 0x5ae168, N'Research and Development Engineer', N'1979-01-21', N'M', N'F', N'2009-01-16', 1, 63, 51, 1, '{50b6cdc6-7570-47ef-9570-48a64b5f2ecf}', N'2014-06-30T00:00:00' ), 
	(298,N'879342154', N'adventure-works\michael6', 0x5ae178, N'Research and Development Manager', N'1984-11-30', N'M', N'M', N'2009-05-03', 1, 16, 64, 1, '{eaa43680-5571-40cb-ab1a-3bf68f04459e}', N'2014-06-30T00:00:00' ), 
	(299,N'974026903', N'adventure-works\ovidiu0', 0x5ae3, N'Senior Tool Designer', N'1978-01-17', N'S', N'M', N'2010-12-05', 0, 7, 23, 1, '{f68c7c19-fac1-438c-9bb7-ac33fcc341c3}', N'2014-06-30T00:00:00' ), 
	(300,N'480068528', N'adventure-works\thierry0', 0x5ae358, N'Tool Designer', N'1959-07-29', N'M', N'M', N'2007-12-11', 0, 9, 24, 1, '{1d955171-e773-4fad-8382-40fd898d5d4d}', N'2014-06-30T00:00:00' ), 
	(301,N'486028782', N'adventure-works\janice0', 0x5ae368, N'Tool Designer', N'1989-05-28', N'M', N'F', N'2010-12-23', 0, 8, 24, 1, '{954b91b6-5aa7-48c2-8685-6e11c6e5c49a}', N'2014-06-30T00:00:00' ), 
	(302,N'42487730', N'adventure-works\michael8', 0x5ae5, N'Senior Design Engineer', N'1979-06-16', N'S', N'M', N'2010-12-30', 1, 3, 21, 1, '{46286ca4-46dd-4ddb-9128-85b67e98d1a9}', N'2014-06-30T00:00:00' ), 
	(303,N'56920285', N'adventure-works\sharon0', 0x5ae7, N'Design Engineer', N'1961-05-02', N'M', N'F', N'2011-01-18', 1, 4, 22, 1, '{54f2fdc0-87c4-4065-a7a8-9ac8ea624235}', N'2014-06-30T00:00:00' ), 
	(304,N'24776624', N'adventure-works\david0', 0x68, N'Marketing Manager', N'1975-03-19', N'S', N'M', N'2007-12-20', 1, 40, 40, 1, '{e87029aa-2cba-4c03-b948-d83af0313e28}', N'2014-06-30T00:00:00' ), 
	(305,N'253722876', N'adventure-works\kevin0', 0x6ac0, N'Marketing Assistant', N'1987-05-03', N'S', N'M', N'2007-01-26', 0, 42, 41, 1, '{1b480240-95c0-410f-a717-eb29943c8886}', N'2014-06-30T00:00:00' ), 
	(306,N'222769461', N'adventure-works\john5', 0x6b40, N'Marketing Specialist', N'1978-03-06', N'S', N'M', N'2011-02-07', 0, 48, 44, 1, '{64730415-1f58-4e5b-8fa8-5e4daeba53b4}', N'2014-06-30T00:00:00' ), 
	(307,N'52541318', N'adventure-works\mary2', 0x6bc0, N'Marketing Assistant', N'1978-01-29', N'S', N'F', N'2011-02-14', 0, 43, 41, 1, '{1f6da901-c7f7-48a8-8eef-d81868d72b52}', N'2014-06-30T00:00:00' ), 
	(308,N'323403273', N'adventure-works\wanida0', 0x6c20, N'Marketing Assistant', N'1975-03-17', N'M', N'F', N'2011-01-07', 0, 41, 40, 1, '{43cca446-da1c-454c-8530-873ad2923e1b}', N'2014-06-30T00:00:00' )

	------------------------------------------------------------
	-- Add new records to HumanResources.Employee and update existing ones.
	------------------------------------------------------------

BEGIN TRY 

	MERGE HumanResources.Employee TARGET
	USING 
	(
		SELECT 
			BusinessEntityID,
			NationalIDNumber,
			LoginID,
			OrganizationNode,
			JobTitle,
			BirthDate,
			MaritalStatus,
			Gender,
			HireDate,
			SalariedFlag,
			VacationHours,
			SickLeaveHours,
			CurrentFlag,
			rowguid,
			ModifiedDate
		FROM #NewRecords
	) SOURCE
	ON SOURCE.NationalIDNumber = TARGET.NationalIDNumber 
	WHEN MATCHED THEN 
		UPDATE SET
			TARGET.LoginID = SOURCE.LoginID,
			TARGET.OrganizationNode = SOURCE.OrganizationNode,
			TARGET.JobTitle = SOURCE.JobTitle,
			TARGET.BirthDate = SOURCE.BirthDate,
			TARGET.MaritalStatus = SOURCE.MaritalStatus,
			TARGET.Gender = SOURCE.Gender,
			TARGET.HireDate = SOURCE.HireDate,
			TARGET.SalariedFlag = SOURCE.SalariedFlag,
			TARGET.VacationHours = SOURCE.VacationHours,
			TARGET.SickLeaveHours = SOURCE.SickLeaveHours,
			TARGET.CurrentFlag = SOURCE.CurrentFlag,
			TARGET.rowguid = SOURCE.rowguid,
			TARGET.ModifiedDate = SOURCE.ModifiedDate
	WHEN NOT MATCHED THEN 
		INSERT
		(
			BusinessEntityID,
			NationalIDNumber,
			LoginID,
			OrganizationNode,
			JobTitle,
			BirthDate,
			MaritalStatus,
			Gender,
			HireDate,
			SalariedFlag,
			VacationHours,
			SickLeaveHours,
			CurrentFlag,
			rowguid,
			ModifiedDate
		)
		VALUES
		(SOURCE.BusinessEntityID,SOURCE.NationalIDNumber,SOURCE.LoginID,SOURCE.OrganizationNode,SOURCE.JobTitle,SOURCE.BirthDate,SOURCE.MaritalStatus,SOURCE.Gender,SOURCE.HireDate,
		SOURCE.SalariedFlag,SOURCE.VacationHours,SOURCE.SickLeaveHours,SOURCE.CurrentFlag,SOURCE.rowguid,SOURCE.ModifiedDate)

		-- Output table to store merge results 

		OUTPUT 
		$action AS [Action],
		'HumanResources.Employee',
		0,
		GETUTCDATE(),
		Inserted.NationalIDNumber
		INTO #RecordOutput;

		----------------------------------------
		-- Insert success records to the merge logs
		----------------------------------------

		INSERT INTO HumanResources.MergeLogs 
		(
			[Action],
		    DestinationTable,
		    IsError,
			UploadDate,
		    NationalIDNumber
		)
		SELECT 
			[Action],
			DestinationTable,
			0,
			UploadDate,
			NationalIDNumber
		FROM #RecordOutput

END TRY 
BEGIN CATCH

	-------------------------------------------
	-- Insert Errors into MergeLogs
	-------------------------------------------

	INSERT INTO HumanResources.MergeLogs 
	( 
		[Action],
	    DestinationTable,
	    IsError,
		UploadDate,
	    NationalIDNumber
	)
	SELECT 
		[Action],
		DestinationTable,
		1,
		UploadDate,
		NationalIDNumber
	FROM #RecordOutput


END CATCH

	------------------------------------
	-- Query MergeLogs table for affected records.
	------------------------------------

	SELECT *
	FROM HumanResources.MergeLogs

ROLLBACK TRAN 
--COMMIT TRAN


