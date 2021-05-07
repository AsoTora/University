USE AdventureWorks2012;
GO

-- добавьте в таблицу dbo.Address поле PersonName типа nvarchar размерностью 100 символов

ALTER TABLE dbo.Address ADD PersonName NVARCHAR(100);

-- объявите табличную переменную с такой же структурой как dbo.Address и заполните ее данными
-- из dbo.Address, где StateProvinceID = 77. Поле AddressLine2 заполните значениями из
-- CountryRegionCode таблицы Person.CountryRegion, Name таблицы Person.StateProvince и City из
-- Address. Разделите значения запятыми

DECLARE @Addr2 TABLE (
    AddressLine1 NVARCHAR(60) NOT NULL,
    AddressLine2 NVARCHAR(60) NOT NULL DEFAULT 'Unknown',
    StateProvinceID INT NOT NULL,
    PostalCode NVARCHAR(15) NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    ID INT NOT NULL,
    PersonName NVARCHAR(100) NULL,
    CHECK ((StateProvinceID % 2) = 1)
)

-- -- or 

-- Declare @ProductsSQL nvarchar(max);
--     SET @ProductsSQL = '
--     DECLARE @Addr2 TABLE (
--         AddressLine1 NVARCHAR(60) NOT NULL,
--         AddressLine2 NVARCHAR(60) NOT NULL,
--         StateProvinceID INT NOT NULL,
--         PostalCode NVARCHAR(15) NOT NULL,
--         ModifiedDate DATETIME NOT NULL,
--         ID INT NOT NULL,
--         PersonName NVARCHAR(100) NULL,
--         CHECK ((StateProvinceID % 2) = 1)
--     )
--     '
-- EXECUTE(@ProductsSQL);


INSERT INTO @Addr2
    SELECT AddressLine1, 
            T1.CountryRegionCode + ', ' + T1.Name + ', ' + T1.City AS AddressLine2,
            T1.StateProvinceID, 
            PostalCode, 
            ModifiedDate, 
            ID, 
            PersonName 
    FROM dbo.Address JOIN (
        SELECT StateProvince.StateProvinceID, StateProvince.Name, CountryRegionCode, City 
        FROM Person.StateProvince JOIN Person.Address
        ON StateProvince.StateProvinceId = Address.StateProvinceID
    ) AS T1
    ON dbo.Address.StateProvinceID = T1.StateProvinceID AND dbo.Address.StateProvinceID = 77


-- обновите поле AddressLine2 в dbo.Address данными из табличной переменной. Также обновите
-- данные в поле PersonName данными из Person.Person, соединив значения полей FirstName и LastName

UPDATE dbo.Address
SET AddressLine2 = Addr2.AddressLine2 
FROM @Addr2 AS Addr2
WHERE dbo.Address.ID = Addr2.ID

UPDATE dbo.Address
SET PersonName = T2.FirstName + ' ' + T2.LastName
FROM (
    SELECT FirstName, LastName, AddressLine1 FROM (
    SELECT BusinessEntityAddress.BusinessEntityID, StateProvinceID, City , AddressLine1
    FROM Person.BusinessEntityAddress JOIN Person.Address
    ON Address.AddressID = BusinessEntityAddress.AddressID
) AS T1 JOIN Person.Person ON Person.BusinessEntityID = T1.BusinessEntityID) AS T2
WHERE dbo.Address.AddressLine1 = T2.AddressLine1

SELECT * from @Addr2;

-- удалите данные из dbo.Address, которые относятся к типу ‘Main Office’ из таблицы
-- Person.AddressType

DELETE FROM dbo.Address
WHERE PersonName IN (
    SELECT FirstName + ' ' + LastName AS PersonName FROM Person.Person
    JOIN (
    SELECT BusinessEntityID, AddressTypeID 
    FROM Person.BusinessEntityAddress 
    ) AS T1 ON Person.BusinessEntityID = T1.BusinessEntityID 
    AND AddressTypeID = (SELECT AddressTypeID FROM Person.AddressType WHERE Name = 'Main Office')
)

-- удалите поле PersonName из таблицы, удалите все созданные ограничения и значения по
-- умолчанию Имена ограничений вы можете найти в метаданных

ALTER TABLE dbo.Address DROP COLUMN PersonName;


DECLARE @sql1 NVARCHAR(MAX);
SELECT @sql1 = c
FROM
(
    SELECT 'ALTER TABLE dbo.Address DROP CONSTRAINT ' + CONSTRAINT_NAME + '; '
    FROM AdventureWorks2012.INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Address'
) T(c);

EXEC(@sql1);

DECLARE @sql2 NVARCHAR(MAX);
SELECT @sql2 = c
FROM
(
    SELECT 'ALTER TABLE dbo.Address DROP CONSTRAINT ' + T1.name + '; '
    FROM (
        SELECT o.name FROM sysobjects o 
        JOIN syscolumns c
        ON o.id = c.cdefault
        JOIN sysobjects t
        ON c.id = t.id AND c.[collation] IS NOT NULL
        WHERE o.xtype = 'D'
        AND t.name = 'Address'
        ) as T1
) T(c);

EXEC(@sql2);


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Address]') AND type in (N'U'))
DROP TABLE [dbo].[Address]
GO
