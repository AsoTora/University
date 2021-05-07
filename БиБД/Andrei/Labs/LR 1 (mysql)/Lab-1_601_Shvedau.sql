-- Переименовать название файла. Вместо "x" - номер группы. Фамилию указать латиницей. (shift + ctrl + S -> сохранить как)
-- Все решения должны быть оформлены в виде запросов, и записаны в этот текстовый файл (в том числе создание хранимых процедур, функций и т.д.).
-- Задания рекомендуется выполнять по порядку.
-- Задания **{} - выполнять по желанию.
-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№1 Создать базу данных.
 Открыть SQL скрипты InsertABC, где ABC название таблицы.
 Создать необходимые таблицы, названия и порядок полей взять в первой строке SQL скрипта, название таблицы из его названия. 
 Выполнить запросы для заполнения таблиц
 */
-- Решение (только создания БД и таблиц):
-- CREATE DATABASE lab1;
USE maindb;

DROP DATABASE maindb;

CREATE DATABASE maindb;

ALTER DATABASE maindb CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE BA (
  IDB INT,
  NameA VARCHAR(100),
  PRIMARY KEY (IDB, NameA)
);

CREATE TABLE Books (
  IDB INT,
  Title VARCHAR(250),
  ISBN VARCHAR(20),
  EAN VARCHAR(20),
  Cover VARCHAR(300),
  AgeLimit VARCHAR(4),
  Pages INT,
  Price DOUBLE,
  PRIMARY KEY (IDB)
);

CREATE TABLE BT (IDB INT, IDT INT, PRIMARY KEY (IDB, IDT));

CREATE TABLE bubuy (
  IDU INT,
  IDB INT,
  Datatime DATETIME,
  PRIMARY KEY (IDU, IDB)
);

CREATE TABLE users (
  IDU INT,
  mail VARCHAR(45),
  login VARCHAR(45),
  pass VARCHAR(45),
  PRIMARY KEY (IDU)
);

CREATE TABLE Theme (
  IDT INT,
  Theme VARCHAR(45),
  Description VARCHAR(100),
  PRIMARY KEY (IDT)
);

SHOW TABLES;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№2 Найти книги, которым в соответствие ставится только одна тема. */
-- Решение:
SELECT
  tmp.TITLE
FROM
  (
    SELECT
      TITLE,
      COUNT(IDT) as count1
    FROM
      BT
      JOIN Books ON BT.IDB = Books.IDB
    GROUP BY
      BT.IDB
  ) AS tmp
WHERE
  tmp.count1 = 1;

-- ---------------------------------------------------------------------------------------------------------------------------------------
/* 	№3 Найти все книги автора – Толстой Лев Николаевич. Учесть все возможные комбинации имени. */
-- Решение:
SELECT
  *
FROM
  Books B
  INNER JOIN BA ON B.IDB = BA.IDB
  AND (
    BA.NameA LIKE '%Толстой%'
    AND (
      (
        BA.NameA LIKE '%Лев%'
        AND BA.NameA LIKE '%Николаевич%'
      )
      OR (
        BA.NameA LIKE '%Л.Н.%'
        OR BA.NameA LIKE 'Н.Л.%'
      )
    )
  );

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* №4 Найти самую дорогую книгу или книги. */
-- Решение №1 (только одну самую дорогую книгу):
SELECT
  *
FROM
  Books
WHERE
  Price in (
    SELECT
      MAX(Price)
    FROM
      Books
  )
LIMIT
  1;

-- Решение №2 (Все самые дорогие книги):
SELECT
  *
FROM
  Books
WHERE
  Price = (
    SELECT
      MAX(Price)
    FROM
      Books
  );

-- Решение №3 (одну самую дорогую книгу, которая стоит больше, чем все остальные. Если такой книги нет – вывести null):
SELECT
  *
FROM
  (
    SELECT
      *
    FROM
      Books
    WHERE
      Price = (
        SELECT
          MAX(Price)
        FROM
          Books
      )
  ) tMAX
WHERE
  (
    SELECT
      COUNT(*)
    FROM
      (
        SELECT
          *
        FROM
          Books
        WHERE
          Price = (
            SELECT
              MAX(Price)
            FROM
              Books
          )
      ) t2MAX
  ) = 1;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№5 Найти тему, в которой было выпущено больше всего книг. */
-- Решение:
SELECT
  Theme,
  countIDB as CountOfBooks
FROM
  Theme
  JOIN (
    SELECT
      BT.IDT,
      COUNT(BT.IDB) as CountIDB
    FROM
      BT
    GROUP BY
      BT.IDT
    HAVING
      CountIDB = (
        SELECT
          MAX(BooksCount.countIDB) as maxBooksCount
        FROM
          (
            SELECT
              COUNT(BooksAndThemes.IDB) AS countIDB
            FROM
              BT AS BooksAndThemes
            GROUP BY
              BooksAndThemes.IDT
          ) AS BooksCount
      )
  ) as IdtToMaxBooksCount ON Theme.IDT = IdtToMaxBooksCount.IDT;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№6 Для каждого автора вывести все жанры, в которых он публиковался, объединить все значения жанров в один столбец. */
SELECT
  AuthorsAndThemes.NameA as Author,
  group_concat(DISTINCT AuthorsAndThemes.Theme) as Theme
FROM
  (
    SELECT
      NameA,
      Theme
    FROM
      BT
      JOIN BA on BT.IDB = BA.IDB
      JOIN Theme on Theme.IDT = BT.IDT
  ) AS AuthorsAndThemes
GROUP BY
  Author;

-- Решение:
-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	** {Найти все разные почтовые домены (например: gmail.com, mail.ru и т.д.)} */
SELECT
  DISTINCT SUBSTR(mail, LOCATE('@', mail) + 1, LENGTH(mail)) as domain
FROM
  users;

-- Решение:
-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	** {Найти количество пользователей по каждому почтовому домену} */
SELECT
  domainsToUsers.domain,
  count(domainsToUsers.IDU) as usersCount
FROM
  (
    SELECT
      SUBSTR(mail, LOCATE('@', mail) + 1, LENGTH(mail)) as domain,
      IDU
    FROM
      users
  ) as domainsToUsers
GROUP BY
  domainsToUsers.domain;

-- Решение:
-- ----------------------------------------------------------------------------------------------------------------------------------------
/*  ** {Найти самый часто встречающийся почтовый домен} */
-- Решение:
SELECT
  domainToMaxCount.domain
FROM
  (
    SELECT
      domainsToUsers.domain,
      count(domainsToUsers.IDU) as usersCount
    FROM
      (
        SELECT
          SUBSTR(mail, LOCATE('@', mail) + 1, LENGTH(mail)) as domain,
          IDU
        FROM
          users
      ) as domainsToUsers
    GROUP BY
      domainsToUsers.domain
    HAVING
      usersCount = (
        SELECT
          MAX(domainsToUsersCount.usersCount) as maxCount
        FROM
          (
            SELECT
              domainsToUsers.domain,
              count(domainsToUsers.IDU) as usersCount
            FROM
              (
                SELECT
                  SUBSTR(mail, LOCATE('@', mail) + 1, LENGTH(mail)) as domain,
                  IDU
                FROM
                  users
              ) as domainsToUsers
            GROUP BY
              domainsToUsers.domain
          ) AS domainsToUsersCount
      )
  ) AS domainToMaxCount;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№7 Найти книги, которым в соответствие ставится только одна тема. */
-- Решение:
SELECT
  Title
FROM
  Books
  JOIN (
    SELECT
      BT.IDB,
      COUNT(BT.IDT) as ThemeCount
    FROM
      BT
    GROUP BY
      BT.IDB
  ) AS IDBtoThemeCount ON Books.IDB = IDBtoThemeCount.IDB
  AND IDBtoThemeCount.ThemeCount = 1;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№8 Найти самого покупаемого автора. */
-- Решение:
SELECT
  NameA,
  COUNT(NameA) as countA
FROM
  BA
  JOIN (
    SELECT
      bubuy.IDB
    FROM
      bubuy
  ) AS buyList ON BA.IDB = buyList.IDB
GROUP BY
  NameA
HAVING
  countA = (
    SELECT
      MAX(A.countA)
    FROM
      (
        SELECT
          NameA,
          COUNT(NameA) as countA
        FROM
          BA
          JOIN (
            SELECT
              bubuy.IDB
            FROM
              bubuy
          ) AS buyList ON BA.IDB = buyList.IDB
        GROUP BY
          NameA
      ) AS A
  );

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	** {Найти самую покупаемую книгу для каждого автора} */
-- Решение:
SELECT
  A.NameA,
  Books.TITLE,
  A.maks
FROM
  (
    SELECT
      MAX(idcount.count1) as maks,
      BA.NameA
    FROM
      BA
      INNER JOIN(
        SELECT
          bubuy.IDB,
          COUNT(bubuy.IDB) as count1
        FROM
          bubuy
        GROUP BY
          bubuy.IDB
      ) AS idcount ON BA.IDB = idcount.IDB
    GROUP BY
      BA.NameA
  ) AS A
  INNER JOIN(
    SELECT
      author.NameA,
      buy.IDB,
      COUNT(buy.IDB) as count2
    FROM
      bubuy AS buy
      JOIN BA as author ON buy.IDB = author.IDB
    GROUP BY
      buy.IDB,
      author.NameA
  ) AS B ON A.maks = B.count2
  AND a.NameA = b.nameA
  JOIN Books ON Books.IDB = B.IDB;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№9 Найти первую книгу приобретенную читателем. */
-- Решение:
SELECT
  A.IDU,
  bubuy.IDB,
  A.minDate
FROM
  bubuy
  JOIN (
    SELECT
      bubuy.IDU,
      MIN(DATATIME) as minDate
    FROM
      bubuy
    GROUP BY
      IDU
  ) AS A ON bubuy.Datatime = A.minDate;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№10 Вывести статистику: количество купленных книг по каждому дню. */
-- Решение:
SELECT
  DATE(Datatime),
  Count(IDB) AS BuyCount
FROM
  bubuy
GROUP BY
  DATE(Datatime);

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	№11 Вывести статистику: количество купленных разных книг по каждому дню. */
-- Решение:
SELECT
  A.dat,
  COUNT(A.IDB)
FROM
  (
    SELECT
      distinct DATE(DATATIME) AS dat,
      IDB
    FROM
      bubuy
  ) AS A
GROUP BY
  A.dat;

-- ----------------------------------------------------------------------------------------------------------------------------------------
/* 	** {Вывести среднее количество (одно число, порядок: до одного знака после запятой) приобретенных книг для всех пользователей которые совершали покупки} */
-- Решение:
SELECT
  ROUND(AVG(A.count1), 1)
FROM
  (
    SELECT
      IDU,
      COUNT(IDB) AS count1
    FROM
      bubuy
    GROUP BY
      IDU
  ) AS A;

-- ----------------------------------------------------------------------------------------------------------------------------------------