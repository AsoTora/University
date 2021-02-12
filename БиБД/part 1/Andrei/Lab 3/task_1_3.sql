delimiter //
CREATE PROCEDURE zad1_3(IN str VARCHAR(25), OUT tov VARCHAR(25))
BEGIN
SELECT tovar INTO tov FROM sklad WHERE tovar LIKE CONCAT(str, '%');
END;

-- Создать хранимые процедуры для
-- 3)	Получения точного названия товара по первым буквам.
4)	Работы с курсором (подсчитать число  записей с одинаковым названием товара).