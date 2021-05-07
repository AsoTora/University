USE AdventureWorks2012;
GO

-- Создайте хранимую процедуру, которая будет возвращать сводную таблицу (оператор PIVOT),
-- отображающую данные о суммарном количестве заказанных продуктов
-- (Production.WorkOrder.OrderQty) за определенный месяц (DueDate). Вывести информацию
-- необходимо для каждого года. Список месяцев передайте в процедуру через входной параметр.
-- Таким образом, вызов процедуры будет выглядеть следующим образом:
-- EXECUTE dbo.WorkOrdersByMonths ‘[January],[February],[March],[April],[May],[June]’

CREATE PROCEDURE WorkOrdersByMonths2 @months NVARCHAR(MAX)
AS 
BEGIN
DECLARE @exec NVARCHAR(MAX)
	SET @exec = 'SELECT *
					FROM 
					(		SELECT OrderQty as OrderQty, 
									DATENAME(Month, EndDate) as MEndDate,
									DATENAME(YEAR, EndDate) as YEndDate
							FROM Production.WorkOrder
					) as p
					PIVOT 
					(
						SUM(OrderQty)
						FOR MEndDate IN
						(' + @months + ')
					) as pvt
					ORDER BY pvt.YEndDate'
	EXECUTE(@exec)
END;

EXECUTE WorkOrdersByMonths2 '[January],[February],[March],[April],[May],[June]';
