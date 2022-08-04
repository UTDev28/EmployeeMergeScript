
/*
Author: Kevin R
Date: 08/04/2022
*/

	----------------------------------------
	-- Drop OrganizationLevel Column from HumanResources.Employee. This column is dumb and is ruining all the fun
	----------------------------------------

	DROP INDEX IX_Employee_OrganizationLevel_OrganizationNode ON HumanResources.Employee
	DROP INDEX AK_Employee_LoginID ON HumanResources.Employee
	DROP INDEX AK_Employee_rowguid ON HumanResources.Employee
	DROP TABLE IF EXISTS HumanResources.MergeLogs

	ALTER TABLE HumanResources.Employee
	DROP COLUMN OrganizationLevel
	GO 

	ALTER TABLE HumanResources.Employee
	DROP CONSTRAINT IF EXISTS FK_Employee_Person_BusinessEntityID 

	