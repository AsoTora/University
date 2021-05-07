-- Переименовать название файла. Вместо "x" - номер группы. Фамилию указать латиницей. (shift + ctrl + S -> сохранить как)
-- Все решения должны быть оформлены в виде запросов, и записаны в этот текстовый файл (в том числе создание хранимых процедур, функций и т.д.).
-- Задания рекомендуется выполнять по порядку.  
-- Задания **{} - выполнять по желанию.
-- ??? - Что такое транзакция? Как работает транзакция? Когда и для чего используют транзакции?
-- A transaction is a logical unit of work that contains one or more SQL statements.
-- Transactions are atomic units of work that can be committed or rolled back. 
-- When a transaction makes multiple changes to the database, either all the changes succeed when the transaction is committed,
-- or all the changes are undone when the transaction is rolled back.
/*
 Транзакция является рабочей единицей работы с базой данных (далее – БД). Это последовательность операций,
 выполняемых в логическом порядке пользователем, либо программой, которая работает с БД. Короче говоря, какое-то законченное изменение в БД
 
 Основные концепции транзакции описываются аббревиатурой ACID – Atomicity, Consistency, Isolation, Durability (Атомарность, Согласованность, Изолированность, Долговечность).
 */
-- ??? - Что такое индексы? Как работают индексы? Какие бывают индексы?
-- Indexes are used to find rows with specific column values quickly. Without an index,
-- MySQL must begin with the first row and then read through the entire table to find the relevant rows.
-- The larger the table, the more this costs. If the table has an index for the columns in question,
-- MySQL can quickly determine the position to seek to in the middle of the data file without having to look at all the data.
-- This is much faster than reading every row sequentially. 
-- https://www.tutorialspoint.com/sql/sql-indexes.htm
-- Types: 
--  o Single-Column Indexes
--  o Unique Indexes
--  o Composite Indexes
--  o Implicit Indexes
-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№1	Привести пример использования транзакции. Транзакция должна завершиться успешно. */
-- Решение:
SET
	autocommit = 0;

START TRANSACTION;

SELECT
	*
FROM
	Books;

COMMIT;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№2	Привести пример использования транзакции. Транзакция должна должна быть отклонена. */
-- Решение: 
START TRANSACTION;

INSERT INTO
	BA
VALUES
	(12345, "test");

ROLLBACK;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№3 Создать таблицу "Buy", которая состоит из полей: ID - первичный ключ, авто заполняемое. IDB, IDU, TimeBuy
 . Создать уникальный составной индекс для IDB, IDU. Создать обычный индекс TimeBuy, обратный порядок. 
 */
-- Решение:
CREATE TABLE Buy (
	ID INT NOT NULL AUTO_INCREMENT,
	IDB INT,
	IDU INT,
	TimeBuy DATETIME,
	PRIMARY KEY (ID),
	UNIQUE KEY BOOK_TO_USER (IDB, IDU),
	KEY TimeBuy (TimeBuy)
);

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№4  Модифицировать таблицу "Buy", добавить поле для хранения стоимости покупки "Cost".*/
-- Решение:
ALTER TABLE
	Buy
ADD
	Cost DOUBLE;

-- ----------------------------------------------------------------------------------------------------------------------------------------
-- **{Создать хранимую процедуру для добавления записи о покупке книги и подсчета итоговой цены книги с учетом всех скидок и предложений. Полученная стоимость записывается в поле "Cost". }
-- Решение:
DELIMITER  // 

create procedure add_purchase(idb_in int, idu_in int, timebuy_in datetime) 
begin 
	declare cost_counted float(6, 2);

	select
		price *(1 - Discounts.sale) into cost_counted
	from
		Books,
		Discounts
	where
		idb = idb_in
		and idu = idu_in;

	insert into
		buy(idb, idu, timebuy, cost)
	select
		idb_in,
		idu_in,
		timebuy_in,
		cost_counted;

END // DELIMITER;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№5	Изменить триггер для таблицы USERS, который теперь должен срабатывать при изменении адреса почтового ящика.*/
-- Решение:
-- DROP TRIGGER OnUpdateUsers;
DELIMITER / / CREATE TRIGGER OnUpdateUsers
AFTER
UPDATE
	ON users FOR EACH ROW BEGIN IF NEW.mail != OLD.mail THEN
INSERT INTO
	ArchiveTable
VALUES
	(old.idu, old.mail, old.login, old.pass);

END IF;

END / / DELIMITER;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№6	Для таблицы пользователей заменить пароль, который хранится в открытом виде, на тот же, но захешированный методом md5.*/
-- Решение:
UPDATE
	users
SET
	pass = (
		SELECT
			MD5(t2.pass)
		FROM
			(
				SELECT
					*
				FROM
					users
			) AS t2
		WHERE
			t2.pass = users.pass
	);

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№7	Вывести количество и среднее значение стоимости книг, которые были просмотрены, но не разу не были куплены.*/
-- Решение:
SELECT
	COUNT(B.IDB),
	AVG(B.PRICE)
FROM
	(
		SELECT
			Books.IDB,
			Books.PRICE
		FROM
			Books
			INNER JOIN (
				SELECT
					DISTINCT IDB
				FROM
					BUVIEW
				WHERE
					IDB NOT IN (
						SELECT
							BUVIEW.IDB
						FROM
							BUVIEW
							INNER JOIN bubuy ON bubuy.IDB = BUVIEW.IDB
					)
			) AS A ON A.IDB = Books.IDB
	) AS B;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№8	Вывести количество купленных книг, а также суммарную их стоимость для тем с кодом с 1 по 6 включительно.*/
-- Решение:
SELECT
	COUNT(C.IDB),
	SUM(C.Price)
FROM
	(
		SELECT
			DISTINCT Books.IDB,
			A.IDT,
			Books.Price
		FROM
			Books
			INNER JOIN (
				SELECT
					BT.IDB,
					BT.IDT
				FROM
					BT
					INNER JOIN bubuy ON BT.IDB = bubuy.IDB
					AND (
						BT.IDT >= 1
						AND BT.IDT <= 6
					)
			) AS A ON A.IDB = Books.IDB
	) AS C;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	№9	Вывести Название книги, Имя автора, Логин покупателя для книг, которые были куплены в период с июня по август 2018 года включительно, написаны
 в тематике 'фэнтези' и 'классика', при условии, что число страниц должно быть от 700 до 800 включительно и цена книги меньше 500.*/
-- Решение:
SELECT
	D.Title,
	D.NameA,
	users.login,
	D.Theme
FROM
	users
	INNER JOIN (
		SELECT
			C.Title,
			BA.NameA,
			C.IDU,
			C.Theme
		FROM
			BA
			INNER JOIN (
				SELECT
					B.IDB,
					B.Title,
					B.IDU,
					Theme.Theme
				FROM
					Theme
					INNER JOIN (
						SELECT
							A.IDB,
							A.Title,
							A.IDU,
							BT.IDT
						FROM
							BT
							INNER JOIN (
								SELECT
									Books.IDB,
									Books.Title,
									bubuy.IDU
								FROM
									Books
									INNER JOIN bubuy ON Books.IDB = bubuy.IDB
									AND Books.Price <= 500
									AND Books.Pages >= 700
									AND Books.Pages <= 800
									AND (
										bubuy.Datatime BETWEEN '2020-06-01'
										AND '2020-09-30'
									)
							) AS A ON A.IDB = BT.IDB
					) AS B ON B.IDT = Theme.IDT
					AND (
						Theme.Theme = "фэнтези"
						OR Theme.Theme = "классика"
					)
			) AS C ON C.IDB = BA.IDB
	) AS D ON users.IDU = D.IDU;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	**{Создать таблицу «Авторы», где бы хранились имена авторов без повторений (Варианты Толстой Лев, Толстой Л.Н. и др. считать уникальными) и его ID. }	*/
-- Решение:

create table Authors(
	IDA int primary key auto_increment,
	Name Varchar(50)
);
insert into Authors(Name) select distinct nameA from BA;

select * from Authors;


-- ----------------------------------------------------------------------------------------------------------------------------------------
/*	**{Создать новую таблицу «ВА» для связи таблиц «Книги» и «Авторы» через ID, и заполнить её.}	*/
-- Решение:
-- ----------------------------------------------------------------------------------------------------------------------------------------

create table BA2(
	IDB int,
	IDa int,
	foreign key(IDB) references Books(IDB),
	foreign key(IDa) references Authors(IDA)
);

insert into BA2
select Books.idb, Authors.ida from Books
	join BA on Books.idb=BA.idb
	join Authors on Authors.name=BA.nameA;

select * from BA2;





