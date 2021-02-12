-- 1. создать базу данных.
CREATE DATABASE IF NOT EXISTS Tutorial;
USE Tutorial;


-- 2. создать таблицы:

-- manuf : таблица, хранящая названия фирм 
-- 		ГДЕ:
-- IDM : код фирмы (первичный ключ)
-- Name: название фирмы
-- city: город, где находится фирма
CREATE TABLE IF NOT EXISTS manuf (
    idm INTEGER NOT NULL PRIMARY KEY,
    name TEXT,
    city TEXT
);


-- cpu : таблица, хранящая названия и характеристики процессоров
-- 		ГДЕ:
-- IDС :  код модели процессора (первичный ключ)
-- IDM: код фирмы производителя процессора
-- Name:  название модели процессора
-- clock: частота работы процессора с точностью до одной десятой

CREATE TABLE IF NOT EXISTS cpu (
    idc INTEGER NOT NULL PRIMARY KEY,
    idm INTEGER,
    name TEXT,
    clock DECIMAL(10,1)
);

-- hdisk : таблица, хранящая названия и характеристики дисков
-- 		ГДЕ:
-- IDD: код модели диска (первичный ключ)
-- IDM: код фирмы производителя диска
-- Name: название модели диска
-- type: тип диска 
-- size: размер диска

CREATE TABLE IF NOT EXISTS hdisk(
    idd INTEGER NOT NULL PRIMARY KEY,
    idm INTEGER,
    name TEXT,
    type TEXT,
    size INTEGER
);

-- nb : таблица, хранящая комплектацию ноутбука
-- 		ГДЕ:
-- IDN: код модели (первичный ключ)
-- IDM: код фирмы производителя ноутбука
-- name: название модели ноутбука
-- IDC: код модели процессора 
-- IDD: код модели диска

CREATE TABLE IF NOT EXISTS nb(
    idn INTEGER NOT NULL PRIMARY KEY,
    idm INTEGER,
    name TEXT,
    idc INTEGER,
    idd INTEGER
);


-- Phone : таблица, хранящая телефон менеджера 
-- 		ГДЕ:
-- IDP: табельный номер сотрудники (первичный ключ)
-- IDM: код фирмы на которой работает сотрудник 
-- Number: номер телефона
-- NameManager: имя менеджера

CREATE TABLE IF NOT EXISTS phone (
    idp INTEGER NOT NULL PRIMARY KEY,
    idm INTEGER,
    NameManager TEXT,
    Number DECIMAL(9,0)
);

-- 3. Выполнить запросы:

insert into manuf
values
    (1, 'Intel', 'Santa Clara'),
    (2, 'AMD', 'Santa Clara'),
    (3, 'WD', 'San Jose'),
    (4, 'seagete', 'Cupertino'),
    (5, 'Asus', 'Taipei'),
    (6, 'Dell', 'Round Rock');

insert into cpu
values
    (1, 1, 'i5', 3.2),
    (2, 1, 'i7', 4.7),
    (3, 2, 'Ryzen 5', 3.2),
    (4, 2, 'Ryzen 7', 4.7),
    (5, null, 'Power9', 3.5);

insert into hdisk
values
    (1, 3, 'Green', 'hdd', 1000),
    (2, 3, 'Black', 'ssd', 256),
    (3, 1, '6000p', 'ssd', 256),
    (4, 1, 'Optane', 'ssd', 16);

insert into nb
values
    (1, 5, 'Zenbook', 2, 2),
    (2, 6, 'XPS', 2, 2),
    (3, 9, 'Pavilion', 2, 2),
    (4, 6, 'Inspiron', 3, 4),
    (5, 5, 'Vivobook', 1, 1),
    (6, 6, 'XPS', 4, 1);

-- 4. Заполнить таблицу Phone произвольными данными.
insert into phone
values
    (1, 1, 'Pete', 37544),
    (2, 1, 'Jhon', 37555),
    (3, 2, 'Kate', 37567);



-- 5. Написать запросы чтобы вывести данные: 

-- 5.1	Название фирмы и модель диска (Список не должен содержать значений NULL)
-- ----------------------------------------------------------------------
-- Решение:

SELECT
    manuf.name as manuf_name,
    hdisk.name as disk_type
FROM
    manuf
    INNER JOIN hdisk ON hdisk.idm = manuf.idm;


-- 5.2	Модель процессора и, если есть информация в БД, название фирмы;
-- ----------------------------------------------------------------------
-- Решение:

SELECT
    cpu.name as cpu_name,
    manuf.name as manuf_name
FROM
    cpu
    LEFT JOIN manuf ON cpu.idm = manuf.idm;
    
-- or

SELECT
    cpu.name,
    manuf.name
FROM
    manuf
    RIGHT JOIN cpu ON cpu.idm = manuf.idm;

-- ----------------------------------------------------------------------
-- 5.3	Название фирмы, которая производит несколько типов товара;
-- ----------------------------------------------------------------------
-- Решение:

SELECT
    manuf.Name AS manuf_name,
    COUNT(hdisk.Name) as DISK,
    COUNT(cpu.Name) as CPU,
    COUNT(nb.name) as NOTEBOOK
FROM
    manuf
    LEFT JOIN hdisk USING (IDM)
    LEFT JOIN cpu USING (IDM)
    LEFT JOIN nb USING (IDM)
GROUP BY
    manuf_name
HAVING
    (
        DISK <> 0
        AND CPU <> 0
    )
    OR (
        DISK <> 0
        AND NOTEBOOK <> 0
    )
    OR (
        CPU <> 0
        AND NOTEBOOK <> 0
    );


-- ----------------------------------------------------------------------
-- 5.4	Модели ноутбуков без информации в базе данных о фирме изготовителе;
-- ----------------------------------------------------------------------
-- Решение:
SELECT
    name
FROM
    nb
WHERE
    idm NOT IN (
        SELECT
            idm
        FROM
            manuf
    );


-- ----------------------------------------------------------------------
-- 5.5	Модель ноутбука и название производителя ноутбука, название модели процессора, название модели диска.
-- ----------------------------------------------------------------------
-- Решение:

SELECT
    nb.name as nb_name,
    manuf.name as nb_manuf_name,
    hdisk.name as disk_model,
    cpu.name as proc_model
from
    nb
    INNER JOIN manuf ON nb.idm = manuf.idm
    INNER JOIN cpu ON nb.idc = cpu.idc
    INNER JOIN hdisk on nb.idd = hdisk.idd;


-- ----------------------------------------------------------------------
-- 5.6	Модель ноутбука, фирму производителя ноутбука, а также для этой модели: 
-- 				модель и название фирмы производителя процессора,
-- 				модель и название фирмы производителя диска.
-- ----------------------------------------------------------------------
-- Решение:

SELECT
    nb.name as nb_name,
    nb_m.name as nb_manuf_name,
    d.name as disk_model,
    disk_m.name as disk_manuf_name,
    c.name as proc_model,
    proc_m.name as proc_manuf_name
from
    nb
    INNER JOIN manuf nb_m ON nb.idm = nb_m.idm
    INNER JOIN cpu c ON nb.idc = c.idc
    INNER JOIN hdisk d on nb.idd = d.idd
    INNER JOIN manuf proc_m ON proc_m.idm = c.idm
    INNER JOIN manuf disk_m ON d.idm = disk_m.idm;

-- ----------------------------------------------------------------------
-- 5.7	 Абсолютно все названия фирмы и все модели процессоров 
-- ----------------------------------------------------------------------
-- Решение:
SELECT
    m.name as all_names
FROM
    manuf m
UNION ALL
SELECT
    c.name as proc_name
FROM
    cpu c;
