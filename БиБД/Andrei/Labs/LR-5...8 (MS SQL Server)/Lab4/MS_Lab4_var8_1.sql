USE AdventureWorks2012;
GO

-- а) Создайте таблицу Person.CountryRegionHst, которая будет хранить информацию об изменениях в
-- таблице Person.CountryRegion.
-- Обязательные поля, которые должны присутствовать в таблице: ID — первичный ключ
-- IDENTITY(1,1); Action — совершенное действие (insert, update или delete); ModifiedDate — дата и
-- время, когда была совершена операция; SourceID — первичный ключ исходной таблицы; UserName
--  имя пользователя, совершившего операцию. Создайте другие поля, если считаете их нужными.

CREATE TABLE Person.CountryRegionHst (
    ID INT NOT NULL IDENTITY(1, 1),
    Action NVARCHAR(60) NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    SourceID NVARCHAR(3) NOT NULL,
    UserName NVARCHAR(60) NOT NULL,
    PRIMARY KEY (ID)
);
GO

-- b) Создайте три AFTER триггера для трех операций INSERT, UPDATE, DELETE для таблицы
-- Person.CountryRegion. Каждый триггер должен заполнять таблицу Person.CountryRegionHst с
-- указанием типа операции в поле Action.

CREATE TRIGGER CountryRegionHst_Insert
ON Person.CountryRegion
AFTER INSERT
AS
INSERT INTO Person.CountryRegionHst(Action, ModifiedDate, SourceID, UserName) 
SELECT 'INSERT', GETDATE(), CountryRegionCode, current_user 
FROM INSERTED;
GO

CREATE TRIGGER CountryRegionHst_Update
ON Person.CountryRegion
AFTER UPDATE
AS
INSERT INTO Person.CountryRegionHst(Action, ModifiedDate, SourceID, UserName) 
SELECT 'UPDATE', GETDATE(), CountryRegionCode, current_user 
FROM INSERTED;
GO

CREATE TRIGGER CountryRegionHst_Deleted
ON Person.CountryRegion
AFTER DELETE
AS
INSERT INTO Person.CountryRegionHst(Action, ModifiedDate, SourceID, UserName) 
SELECT 'DELETE', GETDATE(), CountryRegionCode, current_user 
FROM DELETED;
GO

-- c) Создайте представление VIEW, отображающее все поля таблицы Person.CountryRegion. Сделайте
-- невозможным просмотр исходного кода представления

CREATE VIEW CountryRegionView WITH ENCRYPTION AS 
SELECT * FROM Person.CountryRegion
GO

-- d) Вставьте новую строку в Person.CountryRegion через представление. Обновите вставленную строку.
-- Удалите вставленную строку. Убедитесь, что все три операции отображены в
-- Person.CountryRegionHst

INSERT INTO CountryRegionView VALUES ('VYN', 'VEYSHNORIYA', GETDATE());

UPDATE CountryRegionView
SET Name = 'VEYSHNORIYA_ZYVE'
WHERE CountryRegionCode = 'VYN';

DELETE FROM CountryRegionView
WHERE CountryRegionCode = 'VYN';

SELECT * FROM Person.CountryRegionHst;