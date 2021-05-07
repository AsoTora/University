
USE AdventureWorks2012;
GO

-- Вывести на экран количество отделов, которые входят в группу ‘Executive General and Administration’.

SELECT COUNT(*) as DepCount
FROM [AdventureWorks2012].[HumanResources].[Department]
WHERE GroupName='Executive General and Administration'


-- Вывести на экран 5(пять) самых молодых сотрудников.
SELECT TOP (5) [BusinessEntityID]
      ,[NationalIDNumber]
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      ,[VacationHours]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2012].[HumanResources].[Employee]
  ORDER BY [BirthDate] DESC


-- Вывести на экран список сотрудников женского пола, принятых на работу во вторник (Tuesday). В поле [LoginID] заменить домен ‘adventure-works’ на ‘adventure-works2012’

SELECT [BusinessEntityID]
      ,CONCAT(SUBSTRING([LoginID], 1, 15), '2012') as adv
      ,[JobTitle]
      ,[BirthDate]
      ,[Gender]
      ,Format([HireDate], 'dddd') as wd
  FROM [AdventureWorks2012].[HumanResources].[Employee]
  WHERE Gender='F' AND Format([HireDate], 'dddd')='Tuesday'