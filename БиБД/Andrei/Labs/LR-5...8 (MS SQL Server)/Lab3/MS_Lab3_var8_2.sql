USE AdventureWorks2012;
GO

-- выполните код, созданный во втором задании второй лабораторной работы. Добавьте в таблицу
-- dbo.Address поля AccountNumber NVARCHAR(15) и MaxPrice MONEY. Также создайте в таблице
-- вычисляемое поле AccountID, которое будет добавлять к значению в поле AccountNumber приставку
-- 'ID'

ALTER TABLE dbo.Address 
ADD AccountNumber NVARCHAR(15);

ALTER TABLE dbo.Address 
ADD MaxPrice MONEY;

ALTER TABLE dbo.Address 
ADD AccountID AS (AccountNumber + 'ID');

-- создайте временную таблицу #Address, с первичным ключом по полю ID. Временная таблица
-- должна включать все поля таблицы dbo.Address за исключением поля AccountID

CREATE TABLE [#Address] (
    ID INT NOT NULL IDENTITY(1, 1),
    AddressLine1 NVARCHAR(60) NOT NULL,
    AddressLine2 NVARCHAR(60) NOT NULL,
    StateProvinceID INT NOT NULL,
    PostalCode NVARCHAR(15) NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    AccountNumber NVARCHAR(15),
    MaxPrice MONEY,
    PRIMARY KEY (ID)
)

DROP TABLE [#Address];

SELECT * FROM Address;
SELECT * FROM [#Address];

-- заполните временную таблицу данными из dbo.Address. Поле AccountNumber заполните данными
-- из таблицы Purchasing.Vendor. Определите максимальную цену продукта (StandardPrice),
-- поставляемого каждым постащиком (BusinessEntityID) в таблице Purchasing.ProductVendor и
-- заполните этими значениями поле MaxPrice. Подсчет максимальной цены осуществите в Common Table Expression (CTE)

SET IDENTITY_INSERT #Address ON;

WITH ProductsMaxPrices (BusinessEntityID, MaxPrice) 
AS
(
  SELECT ProductVendor.BusinessEntityID, Max(StandardPrice) as MaxPrice
  FROM Purchasing.ProductVendor JOIN Production.Product 
  ON Product.ProductID = ProductVendor.ProductID
  GROUP BY ProductVendor.BusinessEntityID
)

-- INSERT INTO [#Address] 
SELECT ID, T4.AddressLine1, AddressLine2, StateProvinceID, PostalCode , ModifiedDate, T4.AccountNumber, ProductsMaxPrices.MaxPrice
FROM (
  SELECT ID, T3.AddressLine1, AddressLine2, StateProvinceID, PostalCode , ModifiedDate, T3.AccountNumber, BusinessEntityID FROM (
    SELECT AccountNumber, AddressLine1, Vendor.BusinessEntityID FROM (
      SELECT BusinessEntityID, AddressLine1 FROM (
          SELECT BusinessEntityAddress.BusinessEntityID, StateProvinceID, City , AddressLine1
          FROM Person.BusinessEntityAddress JOIN Person.Address
          ON Address.AddressID = BusinessEntityAddress.AddressID
      ) AS T1
    ) AS T2 JOIN Purchasing.Vendor
    ON Vendor.BusinessEntityID = T2.BusinessEntityID
  ) AS T3 JOIN dbo.Address
  ON T3.AddressLine1 = dbo.Address.AddressLine1
) AS T4 JOIN ProductsMaxPrices ON T4.BusinessEntityID = ProductsMaxPrices.BusinessEntityID;


-- удалите из таблицы dbo.Address одну строку (где ID = 293)

DELETE FROM dbo.Address WHERE ID = 293;

-- напишите Merge выражение, использующее dbo.Address как target, а временную таблицу как source.
-- Для связи target и source используйте ID. Обновите поля AccountNumber и MaxPrice, если запись
-- присутствует в source и target. Если строка присутствует во временной таблице, но не существует в
-- target, добавьте строку в dbo.Address. Если в dbo.Address присутствует такая строка, которой не
-- существует во временной таблице, удалите строку из dbo.Address

MERGE dbo.Address AS TARGET
USING  #Address AS SOURCE
ON TARGET.ID = SOURCE.ID

-- When records are matched, update if there is any change
WHEN MATCHED THEN UPDATE SET AccountNumber = Source.AccountNumber, MaxPrice = Source.MaxPrice

--When no records are matched, insert the incoming records from source table to target table
WHEN NOT MATCHED BY TARGET
THEN INSERT (ID, AddressLine1, AddressLine2, StateProvinceID, PostalCode, ModifiedDate, AccountNumber, MaxPrice) 
VALUES(Source.ID, Source.AddressLine1, Source.AddressLine2, Source.StateProvinceID, Source.PostalCode, Source.ModifiedDate, Source.AccountNumber, Source.MaxPrice)

--When there is a row that exists in target and same record does not exist in source then delete this record target
WHEN NOT MATCHED BY SOURCE THEN
DELETE;



/*
MERGE statement is used to synchronize two tables by inserting, deleting, and updating the target table rows based on the join condition with the source table. 

The MERGE statement basically merges data from a source result set to a target table based on a condition that you specify and if the data from the source already exists in the target or not.
The new SQL command combines the sequence of conditional INSERT, UPDATE and DELETE commands in a single atomic statement, depending on the existence of a record. 

The SQL Server MERGE command is the combination of INSERT, UPDATE and DELETE commands consolidated into a single statement. Here is how to get started with the SQL Server MERGE command:
  Start off by identifying the target table which will be used in the logic.
  Next identify the source table which will be used in the logic.
  Determine the appropriate search conditions in the ON clause in order to match rows.
  Specify logic when records are matched or not matched between the target and source i.e. comparison conditions.
  For each of these comparison conditions code the logic. When matched, generally an update condition is used. When not matched, generally an insert or delete condition is used.


*/