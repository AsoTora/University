delimiter //
CREATE PROCEDURE zad1_2(IN ng float, OUT ans float)
BEGIN
UPDATE sklad SET nalog=price*ng/100;
SELECT SUM(nalog) into ans FROM sklad;
END;

-- Создать хранимые процедуры для
-- 2)	Подсчета налога со всех товаров.
3)	Получения точного названия товара по первым буквам.
4)	Работы с курсором (подсчитать число  записей с одинаковым названием товара).