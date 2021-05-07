USE AdventureWorks2012;
GO

-- a) Создайте представление VIEW, отображающее данные из таблиц Person.CountryRegion и
-- Sales.SalesTerritory. Создайте уникальный кластерный индекс в представлении по полю TerritoryID.

CREATE VIEW Sales.CountryRegionWithSalesTerritory WITH SCHEMABINDING AS
(SELECT CountryRegion.CountryRegionCode, CountryRegion.Name AS CountryRegionName, CountryRegion.ModifiedDate AS CountryRegionModifiedDate, 
TerritoryID, SalesTerritory.Name AS SalesTerritoryName, SalesTerritory.[Group], SalesYTD, SalesLastYear, 
CostYTD, CostLastYear, rowguid, SalesTerritory.ModifiedDate AS SalesTerritoryModifiedDate 
FROM Person.CountryRegion JOIN Sales.SalesTerritory ON CountryRegion.CountryRegionCode = SalesTerritory.CountryRegionCode);
GO

CREATE UNIQUE CLUSTERED INDEX TerritoryIndex ON Sales.CountryRegionWithSalesTerritory(TerritoryID ASC);
GO


-- b) Создайте один INSTEAD OF триггер для представления на три операции INSERT, UPDATE,
-- DELETE. Триггер должен выполнять соответствующие операции в таблицах Person.CountryRegion и
-- Sales.SalesTerritory.

CREATE TRIGGER CountryRegionWithSalesTerritoryInsert
ON Sales.CountryRegionWithSalesTerritory
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO Person.CountryRegion(CountryRegionCode, Name, ModifiedDate)
		SELECT CountryRegionCode, CountryRegionName, CountryRegionModifiedDate
		FROM INSERTED;
	INSERT INTO Sales.SalesTerritory(TerritoryID, Name, CountryRegionCode, [Group], SalesYTD, SalesLastYear, CostYTD, CostLastYear, rowguid, ModifiedDate)
		SELECT TerritoryID, SalesTerritoryName, CountryRegionCode, [Group], SalesYTD, SalesLastYear, CostYTD, CostLastYear, rowguid, SalesTerritoryModifiedDate 
		FROM INSERTED;
END;
GO


CREATE TRIGGER CountryRegionWithSalesTerritoryUpdate
ON Sales.CountryRegionWithSalesTerritory
INSTEAD OF UPDATE
AS
BEGIN
IF (UPDATE(CountryRegionCode))
  UPDATE Person.CountryRegion 
	SET CountryRegionCode=(SELECT CountryRegionCode FROM INSERTED), ModifiedDate=(SELECT CountryRegionModifiedDate FROM INSERTED)  
	WHERE CountryRegionCode=(SELECT CountryRegionCode FROM INSERTED);

  UPDATE Sales.SalesTerritory
	SET CountryRegionCode=(SELECT CountryRegionCode FROM INSERTED), ModifiedDate=(SELECT SalesTerritoryModifiedDate FROM INSERTED)  
	WHERE TerritoryID=(SELECT TerritoryID FROM INSERTED);

IF (UPDATE(CountryRegionName) OR UPDATE(CountryRegionModifiedDate))
UPDATE Person.CountryRegion 
	SET Name=(SELECT CountryRegionName FROM INSERTED), ModifiedDate=(SELECT CountryRegionModifiedDate FROM INSERTED)  
	WHERE CountryRegionCode=(SELECT CountryRegionCode FROM INSERTED);

IF (UPDATE(SalesTerritoryName) OR UPDATE([Group]) OR UPDATE(SalesYTD) OR UPDATE(SalesLastYear)
  OR UPDATE(CostYTD) OR UPDATE(CostLastYear) OR UPDATE(rowguid) OR UPDATE(SalesTerritoryModifiedDate))
UPDATE Sales.SalesTerritory
  SET Name=(SELECT SalesTerritoryName FROM INSERTED),
    [Group]=(SELECT [Group] FROM INSERTED), SalesYTD=(SELECT SalesYTD FROM INSERTED), SalesLastYear=(SELECT SalesLastYear FROM INSERTED),
     CostYTD=(SELECT CostYTD FROM INSERTED),  CostLastYear=(SELECT CostLastYear FROM INSERTED),  rowguid=(SELECT rowguid FROM INSERTED), 
     ModifiedDate=(SELECT SalesTerritoryModifiedDate FROM INSERTED)
	WHERE TerritoryID=(SELECT TerritoryID FROM INSERTED);

END;
GO

CREATE TRIGGER CountryRegionWithSalesTerritoryDelete
ON Sales.CountryRegionWithSalesTerritory
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM Sales.SalesTerritory
	WHERE TerritoryID=(SELECT TerritoryID FROM DELETED)
END;
GO

-- c) Вставьте новую строку в представление, указав новые данные для CountryRegion и SalesTerritory.
-- Триггер должен добавить новые строки в таблицы Person.CountryRegion и Sales.SalesTerritory.
-- Обновите вставленные строки через представление. Удалите строки.
SET IDENTITY_INSERT Sales.SalesTerritory ON;

INSERT INTO Sales.CountryRegionWithSalesTerritory(CountryRegionCode, CountryRegionName, CountryRegionModifiedDate, TerritoryID,
SalesTerritoryName, [Group], SalesYTD, SalesLastYear, CostYTD, CostLastYear, rowguid, SalesTerritoryModifiedDate)
		VALUES ('VYN', 'VEYSHNORIYA', GETDATE(), 5000 ,'GREAT_BELARUS', 'USSR', 1000, 10000, 1000, 10000, NEWID(), GETDATE());

UPDATE Sales.CountryRegionWithSalesTerritory
SET CountryRegionName='VEYSHNORIYA_BEL' 
WHERE TerritoryID = 5000;

DELETE FROM Sales.CountryRegionWithSalesTerritory
WHERE TerritoryID = 5000;

