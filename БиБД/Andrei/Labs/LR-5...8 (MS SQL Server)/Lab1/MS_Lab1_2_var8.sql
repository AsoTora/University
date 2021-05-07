RESTORE DATABASE AdventureWorks2012
FROM DISK = N'/tmp/AdventureWorks2012-Full Database Backup.bak' WITH  FILE = 1,  NOUNLOAD;

CREATE DATABASE AdventureWorks2012;
USE AdventureWorks2012;
GO

-- Вывести на экран холостых сотрудников, которые родились не позже 1960 года включительно.

SELECT BusinessEntityID, BirthDate, MaritalStatus, Gender, HireDate
FROM HumanResources.Employee WHERE MaritalStatus = 'S' AND BirthDate <= '1960-01-01';

-- Вывести на экран сотрудников, работающих на позиции ‘Design Engineer’, отсортированных в
-- порядке убывания принятия их на работу.

SELECT BusinessEntityID, JobTitle, BirthDate, Gender, HireDate
FROM HumanResources.Employee WHERE JobTitle = 'Design Engineer'
ORDER BY HireDate DESC;

-- Вывести на экран количество лет, отработанных каждым сотрудником отделе ‘Engineering’

SELECT Employee.BusinessEntityID, DepartmentID, StartDate, EndDate,
CASE 
 WHEN EndDate IS NULL 
 THEN DATEDIFF(YEAR, StartDate, GETDATE()) 
 ELSE DATEDIFF(YEAR, StartDate, EndDate) 
 END Yearsworked 
FROM HumanResources.Employee 
JOIN HumanResources.EmployeeDepartmentHistory
ON Employee.BusinessEntityID = EmployeeDepartmentHistory.BusinessEntityID AND DepartmentID = 1;


-- слова из 5 букв первое a последнее e

SELECT A.FirstName FROM (
    SELECT FirstName, LEN(FirstName) AS length FROM Person.Person
) AS A WHERE length = 5 AND FirstName LIKE 'a%e';

SELECT * FROM Person.Person;