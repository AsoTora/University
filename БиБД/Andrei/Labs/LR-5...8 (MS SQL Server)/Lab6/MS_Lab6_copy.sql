USE AdventureWorks2012;
GO

-- Создайте хранимую процедуру, которая будет возвращать сводную таблицу (оператор PIVOT),
-- отображающую данные о суммарном количестве заказанных продуктов
-- (Production.WorkOrder.OrderQty) за определенный месяц (DueDate). Вывести информацию
-- необходимо для каждого года. Список месяцев передайте в процедуру через входной параметр.
-- Таким образом, вызов процедуры будет выглядеть следующим образом:
-- EXECUTE dbo.WorkOrdersByMonths ‘[January],[February],[March],[April],[May],[June]’

CREATE PROCEDURE dbo.WorkOrdersByMonths
    @Months VARCHAR(1000)
AS

Declare @SQL VarChar(1000)
DECLARE @YearFormat VARCHAR(10)
DECLARE @MonthFormat VARCHAR(10)

SET @YearFormat = 'yyyy'
SET @MonthFormat = 'MMMM'

SELECT @SQL = 'SELECT *
   FROM (SELECT FORMAT(DueDate, '''+@YearFormat+''') AS Year, FORMAT(DueDate, '''+@MonthFormat+''') AS Month, OrderQty FROM Production.WorkOrder) AS A
   PIVOT (SUM(OrderQty) for Month in ('+@Months+')
           ) AS B'
EXEC (@SQL)
GO

EXECUTE dbo.WorkOrdersByMonths '[January],[February],[March],[April],[May],[June]'
GO


-- Deff

CREATE TABLE EXDATA (
	Name NVARChAR(30),
	ex1 INT,
	ex2 INT,
	ex3 INT,
	ex4 INT,
	ex5 INT,
	ex6 INT,
);

INSERT INTO EXDATA VALUES 
	('StudentA', 1, 0, 0, 1, 0, 1),
	('StudentB', 1, 0, 1, 1, 0, 1),
	('StudentC', 1, 0, 0, 0, 0, 1),
	('StudentD', 1, 1, 0, 1, 1, 1),
	('StudentE', 1, 1, 1, 1, 1, 1),
	('StudentF', 1, 1, 0, 1, 0, 1);

SELECT * FROM EXDATA;

DECLARE @XMLData XML  

SET @XMLData = (
	SELECT 
	C.Name,
	C.ex1,
	C.ex2,
	C.ex3,
	C.ex4,
	C.ex5,
	C.ex6
	FROM (Select B.Name, ex1, ex2, ex3, ex4, ex5, ex6 FROM (
		SELECT A.Name, Sum(A.Result) AS Sum FROM (
		SELECT Name, Exam, Result
		FROM EXDATA
		UNPIVOT(
				Result for Exam in ([ex1], [ex2], [ex3], [ex4], [ex5], [ex6])
		) AS Results
		) AS A GROUP BY A.Name
	) AS B
	JOIN EXDATA ON B.Name = EXDATA.Name AND B.Sum = 6
	) AS C 
	FOR XML PATH('UserResult'), TYPE, ROOT ('Results')
)

SELECT @XMLData;