USE AdventureWorks2012;
GO

-- Вывести значения полей [AddressID], [City]из таблицы [Person].[Address] и полей [StateProvinceID]
-- и [CountryRegionCode] из таблицы [Person].[StateProvince] в виде xml, сохраненного в переменную.
-- Формат xml должен соответствовать примеру:

-- <Addresses>
    --  <Address ID="532">
    --    <City>Ottawa</City>
    --      <Province ID="57">
    --          <Region>CA</Region>
    --      </Province>
    --  </Address>
    --  <Address ID="497">
        --  <City>Burnaby</City>    
            --  <Province ID="7">
            --  <Region>CA</Region>
        --  </Province>
    --  </Address>
-- </Addresses>
-- Создать хранимую процедуру, возвращающую таблицу, заполненную из xml переменной
-- представленного вида. Вызвать эту процедуру для заполненной на первом шаге переменной.

CREATE PROCEDURE getTableFromXMLData @XML_data XML
AS 
BEGIN
    SELECT  
        T1.Address.value('@ID', 'INT') AS AddressId,
        T1.Address.value('./City[1]', 'NVARCHAR(30)') AS City,
        T2.Province.value('@ID', 'INT') AS StateProvinceID,
        T2.Province.value('./Region[1]', 'NVARCHAR(3)') AS CountryRegionCode
        FROM  @XML_data.nodes('//Addresses/Address') AS T1(Address) 
        CROSS APPLY T1.Address.nodes('//Province') AS T2(Province)
END;

DECLARE @XMLData XML  
SET @XMLData = (
                SELECT * FROM (
                    SELECT 
                        1 AS Tag,
                        NULL AS Parent, 
                        A.AddressId AS [Address!1!ID],
                        A.City AS [Address!1!City!ELEMENT],
                        NULL AS [Province!2!ID],
                        NULL AS [Province!2!Region!ELEMENT]
                    FROM Person.Address A
                    UNION ALL
                    SELECT
                        2 AS Tag,
                        1 AS Parent, 
                        A.AddressId,
                        A.City,
                        B.StateProvinceID,
                        B.CountryRegionCode
                    FROM Person.Address A
                    INNER JOIN Person.StateProvince B
                    ON A.StateProvinceID = B.StateProvinceID  
                ) A ORDER BY [Address!1!ID], [Province!2!ID]
               FOR XML EXPLICIT, TYPE, ROOT ('Addresses')
               )  

-- EXECUTE getTableFromXMLData @XMLData
-- SELECT @XMLData;

SELECT @XMLData.query('/Addresses')
GO
