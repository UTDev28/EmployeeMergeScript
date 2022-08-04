

Author: Kevin R.
Date: 08/04/2022
Language: SQL

Setup

    1. AdventureWorks2019 database
        You can find the latest version of the AdventureWorks database here: https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms 

    2. EnviromentSetup.sql
        You will need to run this script first. Because this is a sample db I had to adjust the columns and indexes to make the merge script work. 

    3. EmployeeMergeScript.sql
        This script is meant to be able to run multiple times. It inserts 20 "new records" into a temp table. This temp table is used as the SOURCE during the merge. The merge results are inserted into another temp table with the status of UPDATED or INSERTED. New records are inserted and existing records with modified columns are updated. This temp table inserts the results into a log table that is queried at the end of the script. 
