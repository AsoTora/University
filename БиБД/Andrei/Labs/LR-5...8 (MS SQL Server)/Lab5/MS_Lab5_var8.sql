USE AdventureWorks2012;
GO

-- Создайте scalar-valued функцию, которая будет принимать в качестве входного параметра id подкатегории для продукта
-- (Production.ProductSubcategory.ProductSubcategoryID) и возвращать количество продуктов указанной 
-- подкатегории (Production.Product).

CREATE FUNCTION getProductsAmountFromSubCategory(@subCategoryId INT)
RETURNS MONEY
AS 
BEGIN
    RETURN (SELECT Count(Product.ProductID)
			FROM Production.Product
			WHERE ProductSubcategoryID = @subCategoryId
		   );
END;
GO

SELECT dbo.getProductsAmountFromSubCategory(3);
GO

-- Создайте inline table-valued функцию, которая будет принимать в качестве входного параметра 
-- id подкатегории для продукта (Production.ProductSubcategory.ProductSubcategoryID), а возвращать 
-- список продуктов указанной подкатегории из Production.Product, стоимость которых более 1000 (StandardCost).

CREATE FUNCTION getProductsFromSubCategory(@subCategoryId INT)
RETURNS TABLE
AS
RETURN
    (SELECT *
        FROM Production.Product
        WHERE ProductSubcategoryID = @subCategoryId AND StandardCost > 1000);
GO

SELECT * FROM dbo.getProductsFromSubCategory(3);

-- Вызовите функцию для каждой подкатегории, применив оператор CROSS APPLY. 
-- Вызовите функцию для каждой подкатегории, применив оператор OUTER APPLY.

SELECT * FROM Production.ProductSubcategory AS A CROSS APPLY 
(SELECT dbo.getProductsAmountFromSubCategory(A.ProductSubcategoryID) AS Amount) AS B;
 
SELECT * FROM Production.ProductSubcategory AS A OUTER APPLY dbo.getProductsFromSubCategory(A.ProductSubcategoryID) AS B;
GO;

-- Измените созданную inline table-valued функцию, сделав ее multistatement table-valued
--  (предварительно сохранив для проверки код создания inline table-valued функции).

CREATE FUNCTION getProductsFromSubCategory_MultiStatment(@subCategoryId INT)
RETURNS @return TABLE (
	ProductID INT NOT NULL,
	Name NVARCHAR(80) NOT NULL,
	ProductNumber NVARCHAR(25) NOT NULL,
    MakeFlag BIT NOT NULL,
    FinishedGoodsFlag BIT NOT NULL,
    Color NVARCHAR(15) NOT NULL,
    SafetyStockLevel SMALLINT NOT NULL
)
AS
BEGIN
	INSERT INTO @return
	SELECT ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel
	FROM Production.Product
        WHERE ProductSubcategoryID = @subCategoryId AND StandardCost > 1000
	RETURN;
END;
GO

SELECT * FROM getProductsFromSubCategory_MultiStatment(3);
