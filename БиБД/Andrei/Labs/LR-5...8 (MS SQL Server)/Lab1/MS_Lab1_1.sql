CREATE DATABASE NewDataBase;
GO;

USE NewDataBase;
GO;

CREATE SCHEMA sales;
GO

CREATE SCHEMA persons;
GO

CREATE TABLE sales.Orders (OrderNum INT NULL);

BACKUP DATABASE NewDataBase FILE = 'NewDataBase' 
TO DISK = '/tmp/NewDataBase.bak';
GO

USE master;
GO
ALTER DATABASE NewDataBase 
SET SINGLE_USER 
WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE NewDataBase;

RESTORE DATABASE NewDataBase
FROM DISK = N'/tmp/NewDataBase.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5
GO