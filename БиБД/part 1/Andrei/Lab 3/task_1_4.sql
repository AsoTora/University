delimiter //
CREATE PROCEDURE zad1_4(IN tov VARCHAR(25), OUT kolvo INT)
BEGIN
DECLARE cur CURSOR for SELECT COUNT(tovar) FROM sklad WHERE tovar=tov;
OPEN cur;
FETCH cur INTO kolvo;
CLOSE cur;
END;
// 

-- Создать хранимые процедуры для
-- 4)	Работы с курсором (подсчитать число  записей с одинаковым названием товара).