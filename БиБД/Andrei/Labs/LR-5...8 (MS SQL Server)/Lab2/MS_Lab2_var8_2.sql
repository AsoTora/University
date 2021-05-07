USE AdventureWorks2012;

GO
  -- создайте таблицу dbo.Address с такой же структурой как Person.Address, кроме полей geography,
  -- uniqueidentifier, не включая индексы, ограничения и триггеры
SELECT
  AddressLine1,
  AddressLine2,
  StateProvinceID,
  PostalCode,
  ModifiedDate INTO dbo.Address
FROM
  Person.Address
WHERE
  1 = 0;

-- используя инструкцию ALTER TABLE, добавьте в таблицу dbo.Address новое поле ID с типом
-- данных INT, имеющее свойство identity с начальным значением 1 и приращением 1. Создайте для
-- нового поля ID ограничение UNIQUE
ALTER TABLE
  dbo.Address
ADD
  ID INT NOT NULL IDENTITY(1, 1);

ALTER TABLE
  dbo.Address
ADD
  UNIQUE (ID);

-- используя инструкцию ALTER TABLE, создайте для таблицы dbo.Address ограничение для поля
-- StateProvinceID, чтобы заполнить его можно было только нечетными числами
ALTER TABLE
  dbo.Address
ADD
  CONSTRAINT CHK_StateProvinceID CHECK ((StateProvinceID % 2) = 1);

-- используя инструкцию ALTER TABLE, создайте для таблицы dbo.Address ограничение DEFAULT
-- для поля AddressLine2, задайте значение по умолчанию 'Unknown'
ALTER TABLE
  dbo.Address
ADD
  CONSTRAINT DF_AddressLine2 DEFAULT 'Unknown' FOR AddressLine2;

-- заполните новую таблицу данными из Person.Address. Выберите для вставки только те адреса, где
-- значение поля Name из таблицы CountryRegion начинается на букву ‘а’. Также исключите данные, где
-- StateProvinceID содержит четные числа. Заполните поле AddressLine2 значениями по умолчанию
INSERT INTO
  dbo.Address
SELECT
  AddressLine1,
  AddressLine2,
  Address.StateProvinceID,
  PostalCode,
  Address.ModifiedDate
FROM
  Person.Address
  JOIN (
    SELECT
      StateProvince.StateProvinceID,
      CountryRegion.Name
    FROM
      Person.CountryRegion
      JOIN Person.StateProvince ON StateProvince.CountryRegionCode = CountryRegion.CountryRegionCode
  ) AS T1 ON Address.StateProvinceID = T1.StateProvinceID
  AND T1.Name LIKE 'a%'
  AND Address.StateProvinceID % 2 <> 0
  AND AddressLine2 IS NOT NULL;

INSERT INTO
  dbo.Address (
    AddressLine1,
    StateProvinceID,
    PostalCode,
    ModifiedDate
  )
SELECT
  AddressLine1,
  Address.StateProvinceID,
  PostalCode,
  Address.ModifiedDate
FROM
  Person.Address
  JOIN (
    SELECT
      StateProvince.StateProvinceID,
      CountryRegion.Name
    FROM
      Person.CountryRegion
      JOIN Person.StateProvince ON StateProvince.CountryRegionCode = CountryRegion.CountryRegionCode
  ) AS T1 ON Address.StateProvinceID = T1.StateProvinceID
  AND T1.Name LIKE 'a%'
  AND Address.StateProvinceID % 2 <> 0
  AND AddressLine2 IS NULL;

-- измените поле AddressLine2, запретив вставку null значений
ALTER TABLE
  dbo.Address DROP CONSTRAINT DF_AddressLine2
ALTER TABLE
  dbo.Address
ALTER COLUMN
  AddressLine2 NVARCHAR(60) NOT NULL
ALTER TABLE
  dbo.Address
ADD
  CONSTRAINT DF_AddressLine2 DEFAULT 'Unknown' FOR AddressLine2;

SELECT * FROM  dbo.Address