-- 5 таблиц. Санаторий (Работники, Посетители, Диагнозы, Процедуры, Номера и т.д.);


-- Создать базу данных. База данных должна состоять не менее, чем из 5 таблиц. База данных и все объкты базы данных должны создаваться инструкциями SQL;
CREATE DATABASE SANATORI_PLEASURE;
USE SANATORI_PLEASURE;

-- Создать таблицы. Заполнить таблицы тестовыми данными. Все таблицы, без исключения, должны иметь первичный ключ;
CREATE TABLE Worker (
  id INT PRIMARY KEY NOT NULL,
  Name VARCHAR(100),
  salary FLOAT,
  department INT FOREIGN KEY REFERENCES Departments(id),
  speciality VARCHAR(100)
);

CREATE TABLE Visitor (
  id INT PRIMARY KEY NOT NULL,
  Name VARCHAR(100),
  Surname VARCHAR(100),
  room INT,
  class VARCHAR(30), -- premium/ vip/ classic,
  Date_in DATETIME NOT NULL DEFAULT GETDATE(),
  Date_out DATETIME NOT NULL DEFAULT DATEADD(d, 7, GETDATE()),
  Diagnosis INT
);


CREATE TABLE Departments (
  id INT PRIMARY KEY NOT NULL,
  Name VARCHAR(100),
  room INT
);

CREATE TABLE Procedures (
  id INT PRIMARY KEY NOT NULL,
  Name VARCHAR(100),
  Department INT FOREIGN KEY REFERENCES Departments(id)
);

CREATE TABLE Diagnosis (
  id INT PRIMARY KEY NOT NULL,
  Name VARCHAR(100),
  Procedr INT FOREIGN KEY REFERENCES Procedures(id),
);

-- 3. Создайте ограничения DEFAULT для тех полей, где создание данного ограничения имеет значение. Например, поле скидки должно имееть значение 0 по умолчанию.
-- База данных должна содержать хотя бы одно ограничение DEFAULT;

ALTER TABLE Visitor
ADD CONSTRAINT check_class DEFAULT  N'classic' FOR class;

ALTER TABLE Worker
ADD CONSTRAINT check_salary DEFAULT 0 FOR salary;


INSERT INTO Visitor (id, Name, Surname, room, class) VALUES (1, 'andrei', 'shvedau', 100, 'premium');

-- 4. Создайте ограничения CHECK для тех полей, где создание данного ограничения имеет значение. Например, дата получения товара не может быть позже даты реализации товара или стоимость/скидка не может быть отрицательным значением. База данных должна содержать хотя бы одно ограничение CHECK;
ALTER TABLE Visitor
ADD CONSTRAINT check_dates CHECK (DATEDIFF(day, Date_in, Date_out) >= 0);

-- check will fail the insert
INSERT INTO Visitor (id, Name, Surname, room, class, Date_in, Date_out) VALUES (2, 'andrei', 'shvedau', 100, 'premium', DATEADD(d, 4, GETDATE()), GETDATE())

-- 5. Создать представления VIEW для наиболее часто выполняемых запросов. База данных должна содержать хотя бы одно представление VIEW, которое возвращает данные из нескольких таблиц;

INSERT INTO Visitor (id, Name, Surname, room) VALUES (2, 'vasya', 'puppkin', 23);
INSERT INTO Visitor (id, Name, Surname, room) VALUES (3, 'katya', 'm', 25);

INSERT INTO Worker VALUES (1, 'Habib', 888, 3, 'coach'), (3, 'Igor', 1000, 2, 'doctor');
INSERT INTO Worker VALUES (4, 'Anzella', 1666, 2, 'doctor');

Insert INTO Departments VALUES (1, 'swimming', 11), (2, 'therapy', 22), (3, 'massage', 33);

INSERT INTO Procedures VALUES (1, 'aqua-dance', 1), (2, 'talking', 2), (3, 'sex', 3);

INSERT INTO Diagnosis VALUES (1, 'obesity', 1), (2, 'depression', 2), (3, 'bad mood', 3);

INSERT INTO Visitor (id, Name, Surname, room, class, Diagnosis) VALUES (5, 'peter', 'dinkler', 80, 'vip', 1);
INSERT INTO Visitor (id, Name, Surname, room, class, Diagnosis) VALUES (4, 'adam', 'honover', 77, 'classis', 2);
INSERT INTO Visitor (id, Name, Surname, room, class, Diagnosis) VALUES (6, 'billy', 'corolla', 101, 'premium', 3);

-- visitor_count
GO
CREATE VIEW visitors_count AS (
    SELECT COUNT([id]) as count FROM Visitor
);
GO

SELECT * From visitors_count;


-- department_workers
GO
CREATE VIEW department_workers AS (
    SELECT Departments.id, Departments.Name,
    STUFF((SELECT '; ' + Worker.Name 
            FROM Worker
            WHERE Worker.department = Departments.id
            ORDER BY Worker.Name
            FOR XML PATH('')), 1, 1, '') [Workers]
  FROM Departments 
  GROUP BY Departments.ID, Departments.Name
);
GO

DROP VIEW department_workers;

SELECT * from department_workers;


-- visitors + diagnosis + procedure + trainer 
GO
CREATE VIEW visitor_pleasures AS (
  SELECT [Visitor].[Name], [Visitor].room, [Class], Diagnosis.Name as Diagnosis, Procedures.Name as Reccomended_routine, department_workers.Workers as available_workers
  from Visitor
  LEFT JOIN Diagnosis On Visitor.Diagnosis = Diagnosis.id
  LEFT JOIN Procedures On Diagnosis.Procedr = Procedures.id
  LEFT JOIN department_workers on department_workers.id = Procedures.Department
);
GO

SELECT * from visitor_pleasures;
