-- Переименовать название файла. Вместо "x" - номер группы. Фамилию указать латиницей. (shift + ctrl + S -> сохранить как)
-- Все решения должны быть оформлены в виде запросов, и записаны в этот текстовый файл (в том числе создание хранимых процедур, функций и т.д.).
-- Задания рекомендуется выполнять по порядку.
-- Задания **{} - выполнять по желанию.
-- Проверить таблицу BUBuy, для поля IDU значения должны быть не более 350, для поля IDB около 1500. Если наоборот то выполнить запрос:
-- ALTER TABLE bubuy CHANGE COLUMN IDU IDB INT, CHANGE COLUMN IDB IDU INT;
-- ??? - Что такое представление (VIEW). Для решения каких задач применяется VIEW?
/*
 Представление (VIEW) — объект базы данных, являющийся результатом выполнения запроса к базе данных, 
 определенного с помощью оператора SELECT, в момент обращения к представлению.
 
 Применяются для:
 -  Гибкой настройки прав доступа к данным за счет того, что права даются не на таблицу, а на представление.
 - Разделения логики хранения данных и программного обеспечения. Можно менять структуру данных, 
 не затрагивая программный код, нужно лишь создать представления, аналогичные таблицам, к которым раньше обращались приложения.
 - Удобства в использовании за счет автоматического выполнения таких действий как доступ к определенной 
 части строк и/или столбцов, получение данных из нескольких таблиц и их преобразование с помощью различных функций.
 */
-- ??? - Что такое триггер, для каких задач его можно применять, какие ограничения применения есть в MySQL?
/* Триггер — это хранимая процедура, которая не вызывается непосредственно, а исполняется при наступлении 
 определенного события ( вставка, удаление, обновление строки ) 
 
 Триггер не может использовать инструкцию CALL, чтобы вызвать сохраненные процедуры, которые возвращают данные пользователю или применяют динамический SQL. Процедурам позволяется возвратить данные триггеру через параметры OUT или INOUT.
 
 Триггер не может использовать инструкции, которые явно или неявно начинают или заканчивают транзакцию, типа START TRANSACTION, COMMIT или ROLLBACK.
 
 Виды:
 - Data Definition Language (DDL) triggers
 - Data Manipulation Language (DML) triggers
 - CLR triggers
 - Logon triggers.
 
 До MySQL 5.0.10 триггер не может содержать прямые ссылки к именам таблиц.
 */
-- ??? - Какие функции бывают в  MySQL, как их применять?
-- AVG: вычисляет среднее значение
-- SUM: вычисляет сумму значений
-- MIN: вычисляет наименьшее значение
-- MAX: вычисляет наибольшее значение
-- COUNT: вычисляет количество строк в запросе
-- Процедура
/*
 A procedure is a subroutine (like a subprogram) in a regular scripting language, stored in a database. 
 In the case of MySQL, procedures are written in MySQL and stored in the MySQL database/server. A MySQL procedure has a name, a parameter list, and SQL statement(s).
 
 There are four different types of MySQL procedures:
 1. Procedure with no parameters
 2. Procedure with IN parameter
 3. Procedure with OUT parameter
 4. Procedure with IN-OUT parameter
 */
-- Разница
/*
 The most significant difference between procedures and functions is that they are invoked differently and for different purposes. Other than that following are the differences between procedure and functions −
 
 - A procedure does not return a value. Instead, it is invoked with a CALL statement to perform an operation such as modifying a table or processing retrieved records.
 - On the other hand, a function is invoked within an expression and returns a single value directly to the caller to be used in the expression. That is, a function is used in expressions the same way as a constant, a built-in function, or a reference to a table column.
 - We cannot invoke a function with a CALL statement. We cannot invoke a procedure in an expression.
 */
USE maindb;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№1 Создать таблицу для хранения просмотров книг зарегистрированными пользователями. BUView - состоит из двух полей IDB, IDU. 
 При создании таблицы прописать FOREIGN KEY */
-- Решение:
CREATE TABLE BUView (
  IDB INT,
  IDU INT,
  FOREIGN KEY (IDB) REFERENCES Books (IDB),
  FOREIGN KEY (IDU) REFERENCES users (IDU)
);

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№2 Создать таблицу для хранения закладок "BUMark", где пользователь может пометить страницу в купленной книге и оставить короткое 
 текстовое описание, важно также знать время создания закладки.		
 **{При создании таблицы прописать FOREIGN KEY к оптимальной таблице} */
-- Решение:
CREATE TABLE BUMark (
  IDU INT,
  IDB INT,
  L_NUM INT,
  Mark VARCHAR(1000),
  Datatime DATETIME,
  PRIMARY KEY (IDU, IDB),
  FOREIGN KEY (IDU, IDB) REFERENCES bubuy (IDU, IDB)
);

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	**{Создать таблицу для специального предложения месяца "BStock".Таблица состоит из колонок: 
 Код книги, доступное количество книг по предложению, цена книги, месяц и год проведения предложения (формат дата)
 Первых этих 5 покупок будут по цене 99, скидки покупателя не влияют на цену.} */
-- Решение:
CREATE TABLE BStock (
  IDB INT,
  Books_limit INT,
  Price DOUBLE,
  Stock_Date Date,
  FOREIGN KEY (IDB) REFERENCES Books (IDB)
);

-- ----------------------------------------------------------------------------------------------------------------------------------------
-- Выполнить все запросы из файла "For_LR2.sql"
-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№3 Создать хранимую процедуру для добавления записей в таблицу "BUMark".
 **{Предусмотреть защиту от появления ошибок при заполнения данных}*/
-- Решение:
DELIMITER / / CREATE PROCEDURE CreateMark (
  IDU INT,
  IDB INT,
  L_NUM INT,
  Mark VARCHAR(1000)
) BEGIN DECLARE CurrentTime DATE;

IF (
  SELECT
    COUNT(bubuy.IDU)
  FROM
    bubuy
  WHERE
    bubuy.IDU = IDU
    AND bubuy.IDB = IDB
) != 0 THEN
SET
  CurrentTime = CURRENT_DATE();

INSERT INTO
  BUMark
VALUES
  (IDU, IDB, L_NUM, Mark, CurrentTime);

END IF;

END / / DELIMITER;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№4 Добавить в таблицу "BUMark" по 3 записи для пользователей: 'Denis', 'Dunn', 'Dora'.*/
-- Решение:
CALL CreateMark(
  (
    SELECT
      users.IDU
    FROM
      users
    WHERE
      users.login = "Denis"
  ),
  245,
  33,
  "Выписать цитату"
);

CALL CreateMark(
  (
    SELECT
      users.IDU
    FROM
      users
    WHERE
      users.login = "Denis"
  ),
  245,
  11,
  "Стереть карандаш"
);

CALL CreateMark(
  (
    SELECT
      users.IDU
    FROM
      users
    WHERE
      users.login = "Denis"
  ),
  245,
  2,
  "Вырвать страницу"
);

CALL CreateMark(
  (
    SELECT
      users.IDU
    FROM
      users
    WHERE
      users.login = "Dunn"
  ),
  454,
  21,
  "Перевести слово"
);

CALL CreateMark(
  (
    SELECT
      users.IDU
    FROM
      users
    WHERE
      users.login = "Denis"
  ),
  245,
  33,
  "Выписать цитату"
);

CALL CreateMark(
  (
    SELECT
      users.IDU
    FROM
      users
    WHERE
      users.login = "Denis"
  ),
  245,
  33,
  "Выписать цитату"
);

CALL CreateMark(
  (
    SELECT
      users.IDU
    FROM
      users
    WHERE
      users.login = "Dora"
  ),
  1224,
  12,
  "Заклеить порванную страницу"
);

CALL CreateMark(
  (
    SELECT
      users.IDU
    FROM
      users
    WHERE
      users.login = "Denis"
  ),
  245,
  33,
  "Выписать цитату"
);

CALL CreateMark(
  (
    SELECT
      users.IDU
    FROM
      users
    WHERE
      users.login = "Denis"
  ),
  245,
  33,
  "Выписать цитату"
);

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№5 Для каждого покупателя посчитать скидку в зависимости от количества купленных книг:
 +------------------------+------+-------+-------+-------+-------+
 | Количество книг, более |	0   |	3	|	5	|	7	|	10	|
 +------------------------+------+-------+-------+-------+-------+
 | Скидка, %		    	 |	0	|	1	|	2	|	3	|	5	|
 +------------------------+------+-------+-------+-------+-------+
 Решение этой задачи должно быть таким, чтобы потом им можно было воспользоваться для подсчета стоимости при покупке книги.*/
-- Решение:
SELECT
  UsersToBooksCount.IDU,
  UsersToBooksCount.login,
  UsersToBooksCount.numberOfBooks,
  CASE
    WHEN UsersToBooksCount.numberOfBooks < 3 THEN 0
    WHEN UsersToBooksCount.numberOfBooks >= 3
    AND UsersToBooksCount.numberOfBooks < 5 THEN 1
    WHEN UsersToBooksCount.numberOfBooks >= 5
    AND UsersToBooksCount.numberOfBooks < 7 THEN 2
    WHEN UsersToBooksCount.numberOfBooks >= 7
    AND UsersToBooksCount.numberOfBooks < 10 THEN 3
    WHEN UsersToBooksCount.numberOfBooks >= 10 THEN 5
  END as Discount
FROM
  (
    SELECT
      users.IDU,
      users.login,
      COUNT(bubuy.idb) AS numberOfBooks
    FROM
      bubuy
      JOIN users ON bubuy.idu = users.idu
    GROUP BY
      bubuy.idu
  ) AS UsersToBooksCount;

-- idu 1,5 | idb 5,7 | price-%
SELECT
  *,
  CASE
    WHEN UsersToBooksCountWithPricesToBooks.IDU = 1 THEN (
      SELECT
        Price
      FROM
        Books
      WHERE
        IDB = 5
    ) * (
      1 - (
        UsersToBooksCountWithPricesToBooks.Discount / 100
      )
    )
    WHEN UsersToBooksCountWithPricesToBooks.IDU = 5 THEN (
      SELECT
        Price
      FROM
        Books
      WHERE
        IDB = 5
    ) * (
      1 - (
        UsersToBooksCountWithPricesToBooks.Discount / 100
      )
    )
  END as Price5WithDiscount,
  CASE
    WHEN UsersToBooksCountWithPricesToBooks.IDU = 1 THEN (
      SELECT
        Price
      FROM
        Books
      WHERE
        IDB = 7
    ) * (
      1 - (
        UsersToBooksCountWithPricesToBooks.Discount / 100
      )
    )
    WHEN UsersToBooksCountWithPricesToBooks.IDU = 5 THEN (
      SELECT
        Price
      FROM
        Books
      WHERE
        IDB = 7
    ) * (
      1 - (
        UsersToBooksCountWithPricesToBooks.Discount / 100
      )
    )
  END as Price7WithDiscount
FROM
  (
    SELECT
      UsersToBooksCount.IDU,
      UsersToBooksCount.login,
      UsersToBooksCount.numberOfBooks,
      CASE
        WHEN UsersToBooksCount.numberOfBooks < 3 THEN 0
        WHEN UsersToBooksCount.numberOfBooks >= 3
        AND UsersToBooksCount.numberOfBooks < 5 THEN 1
        WHEN UsersToBooksCount.numberOfBooks >= 5
        AND UsersToBooksCount.numberOfBooks < 7 THEN 2
        WHEN UsersToBooksCount.numberOfBooks >= 7
        AND UsersToBooksCount.numberOfBooks < 10 THEN 3
        WHEN UsersToBooksCount.numberOfBooks >= 10 THEN 5
      END as Discount,
      CASE
        WHEN UsersToBooksCount.IDU = 1
        OR UsersToBooksCount.IDU = 5 THEN (
          SELECT
            Price
          FROM
            Books
          WHERE
            IDB = 5
        )
      END as Price5,
      CASE
        WHEN UsersToBooksCount.IDU = 1
        OR UsersToBooksCount.IDU = 5 THEN (
          SELECT
            Price
          FROM
            Books
          WHERE
            IDB = 7
        )
      END as Price7
    FROM
      (
        SELECT
          users.IDU,
          users.login,
          COUNT(bubuy.idb) AS numberOfBooks
        FROM
          bubuy
          JOIN users ON bubuy.idu = users.idu
          AND (
            bubuy.IDU = 1
            OR bubuy.IDU = 5
          )
        GROUP BY
          bubuy.idu
      ) AS UsersToBooksCount
  ) AS UsersToBooksCountWithPricesToBooks;

create view Discounts as
select
  idu,
  count(idb) as bbought,
  case
    when count(idb) > 10 then 0.05
    when count(idb) > 7 then 0.03
    when count(idb) > 5 then 0.02
    when count(idb) > 3 then 0.01
    else 0
  end as sale
from
  bubuy
group by
  1;

-- ----------------------------------------------------------------------------------------------------------------------------------------
-- **{Предложить альтернативную идею или идеи для решения задачи №5.}
-- Решение:
-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№6 Создать представление, которое будет выводить список 10 самых покупаемых книг за предыдущий месяц 
 (при одинаковом значении проданных книг, сортировать по алфавиту) */
-- Решение:
CREATE VIEW PopularBooksForLastMonth AS
SELECT
  Books.title,
  COUNT(A.IDB) as boughtTimes
FROM
  (
    SELECT
      *
    FROM
      bubuy
    WHERE
      MONTH(bubuy.Datatime) = MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH))
      AND YEAR(bubuy.Datatime) = YEAR(2020)
  ) AS A
  JOIN Books ON Books.IDB = A.IDB
GROUP BY
  A.IDB
ORDER BY
  boughtTimes DESC,
  Books.title ASC
LIMIT
  10;

SELECT
  *
FROM
  PopularBooksForLastMonth2;

create view PopularBooksForLastMonth2 as
select
  Books.idb,
  title,
  bought
from
  (
    select
      idb,
      count(idu) as bought
    from
      bubuy
    where
      DATE_FORMAT(datatime, '%Y-%m') = DATE_FORMAT(date_add(now(), interval -12 month), '%Y-%m')
    group by
      1
    order by
      2 desc
    limit
      10
  ) filtered
  left join Books on Books.idb = filtered.idb
order by
  bought desc,
  title;


-- ----------------------------------------------------------------------------------------------------------------------------------------
-- **{Сделать выборку по условию задачи №6 и добавить к решению нумерацию строк}
-- Решение:


select
  @i := @i + 1 '№',
  title,
  bought as boughtTimes
from PopularBooksForLastMonth2;

select
  @i := @i + 1 '№',
  title,
  bought as boughtTimes
from
  (
    select
      title,
      boughtTimes
    from
      (
        select
          idb,
          count(idu) as bought
        from
          bubuy
        where
          DATE_FORMAT(datatime, '%Y-%m') = DATE_FORMAT(date_add(now(), interval -12 month), '%Y-%m')
        group by
          1
        order by
          2 desc
        limit
          10
      ) filtered
      left join Books on Books.idb = filtered.idb
    order by
      bought desc,
      title
  ) filtered,
  (
    SELECT
      @i := 0
  ) counter;

-- ----------------------------------------------------------------------------------------------------------------------------------------
-- **{Заполнить таблицу "BStock" на текущий месяц. 10 записей из списка задачи №6, ручной ввод IDB не допускается.}
-- Решение:


delimiter //

create procedure fill_bstock()
begin
	DECLARE done INT DEFAULT FALSE;
	DECLARE idb_next int;
    DECLARE Stock_Date Date;
    DECLARE price_next float(6,2);
	DECLARE cur CURSOR FOR SELECT idb FROM PopularBooksForLastMonth2;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
  set Stock_Date=date_add(now(), interval -1 month);

	OPEN cur;

	read_loop: LOOP
		FETCH cur INTO idb_next;
		IF done THEN
		LEAVE read_loop;
		END IF;
        SELECT price into price_next from Books where idb=idb_next;
		INSERT INTO BStock(idb, price, Stock_Date) VALUES (idb_next, price_next, Stock_Date);
	END LOOP;

	CLOSE cur;
end //

delimiter ;

call fill_bstock();

select * from BStock


-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№7 Написать хранимую процедуру. Для книг (если название и автор совпадает) вывести количество изданий, минимальную и максимальную стоимость. 
 Отобразить только те записи, у которых есть несколько упоминаний.*/
-- Решение:
delimiter //

create procedure book_info()
begin
	select Title, NameA, count(isbn) as Number, min(price) as 'min price', max(price) as 'max price' from Books join BA on Books.idb=BA.idb
  group by Title, NameA having count(isbn)>1;
end //

delimiter ;

call book_info;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№8 Создать триггер который будет копировать исходную строку в "новую архивную таблицу" при редактирование данных в таблице "USERS".	*/
-- Решение:
CREATE TABLE ArchiveTable (
  idu INT,
  mail VARCHAR(255),
  login VARCHAR(255),
  pass VARCHAR(255)
);

DELIMITER / / CREATE TRIGGER OnUpdateUsers
AFTER
UPDATE
  ON users FOR EACH ROW BEGIN
INSERT INTO
  ArchiveTable
VALUES
  (OLD.idu, OLD.mail, OLD.login, OLD.pass);

END / / DELIMITER;

UPDATE
  users
SET
  users.mail = 'andreyw441@gmail.com'
WHERE
  users.idu = 1;

select
  *
from
  ArchiveTable;


-- ----------------------------------------------------------------------------------------------------------------------------------------
-- **{Написать триггер который будет поддерживать таблицу "BStock" в актуальном состоянии}  */
-- Решение:
CREATE EVENT BStock_update ON SCHEDULE EVERY 1 MONTH STARTS '2021-03-01 00:00:00' ENDS '2022-03-01 00:00:00' DO call fill_bstock;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* №9 Написать хранимую процедуру. Какая книга или книги, самая популярная как первая купленная.*/
-- Решение:
DELIMITER / / CREATE PROCEDURE MostPopularBooksAsFirstBought() BEGIN
SELECT
  Books.title,
  C.idb,
  C.numberOfBooks
FROM
  Books
  JOIN (
    SELECT
      bubuy.idb,
      COUNT(bubuy.idb) AS numberOfBooks
    FROM
      bubuy
      JOIN (
        SELECT
          bubuy.idu,
          MIN(bubuy.dataTime) AS firstDate
        FROM
          bubuy
        GROUP BY
          bubuy.idu
      ) AS A ON A.idu = bubuy.idu
      AND bubuy.dataTime = A.firstDate
    GROUP BY
      bubuy.idb
    HAVING
      numberOfBooks = (
        SELECT
          MAX(B.numberOfBooks)
        FROM
          (
            SELECT
              bubuy.idb,
              COUNT(bubuy.idb) AS numberOfBooks
            FROM
              bubuy
              JOIN (
                SELECT
                  bubuy.idu,
                  MIN(bubuy.dataTime) AS firstDate
                FROM
                  bubuy
                GROUP BY
                  bubuy.idu
              ) AS A ON A.idu = bubuy.idu
              AND bubuy.dataTime = A.firstDate
            GROUP BY
              bubuy.idb
          ) AS B
      )
  ) as C ON Books.idb = C.idb;

END / / DELIMITER;

CALL MostPopularBooksAsFirstBought;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№10 Вывести пользователей которые не проявили никакой активности (не просматривали книги, ничего не покупали)*/
-- Решение:
SELECT
  A.userId,
  A.login
FROM
  (
    SELECT
      users.idu AS userId,
      bubuy.idu,
      users.login
    FROM
      bubuy
      RIGHT JOIN users ON bubuy.idu = users.idu
    WHERE
      bubuy.idu IS NULL
  ) AS A
  JOIN (
    SELECT
      users.idu AS userId,
      BUView.idu,
      users.login
    FROM
      BUView
      RIGHT JOIN users ON BUView.idu = users.idu
    WHERE
      BUView.idu IS NULL
  ) AS B ON A.userId = B.userId;

-- ----------------------------------------



DELIMITER  // 

create procedure purchase(idb_in int) 
begin 
	declare cost_counted float(6, 2);
    select
        Books.price *(1 - tmp.sale) into cost_counted
    from
        Books,
        (	
            select
            users.IDU, Discounts.sale
            from users, Discounts
            Where (users.login LIKE '%alex%' or users.login LIKE '%den%') AND  Discounts.idu = users.IDU
        ) as tmp
    WHERE Books.IDB = idb_in;

    Select cost_counted;
END // DELIMITER;


select
    ROUND(SUM(Books.price *(1 - tmp.sale)),3)
from
    Books,
    (	
        select
        users.IDU, Discounts.sale
        from users, Discounts
        Where (users.login LIKE '%alex%' or users.login LIKE '%den%') AND  Discounts.idu = users.IDU
    ) as tmp
WHERE Books.IDB = 356

CALL purchase(356)
