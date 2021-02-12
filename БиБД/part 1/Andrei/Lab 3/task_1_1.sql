delimiter //
CREATE PROCEDURE zad1_1(tov VARCHAR(25), pr INT, kl INT, post DATE)
BEGIN
DECLARE yes INT DEFAULT 0;
SELECT COUNT(tovar) INTO yes FROM sklad WHERE tovar=tov AND postavka=post;
IF yes=0 THEN
	INSERT INTO sklad(tovar, price, kol, postavka) VALUES(tov, pr, kl, post);
ELSE
	UPDATE sklad SET tovar=tov, price=pr, kol=kl, postavka=post WHERE tovar=tov AND postavka=post;
END IF;
END
//

-- Создать хранимые процедуры для
-- 1)	Вставки записи и ее обновления.

