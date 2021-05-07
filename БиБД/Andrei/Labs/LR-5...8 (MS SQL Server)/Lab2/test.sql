CREATE DATABASE NewDataBase2;
-- таьблица из 3х полей id, title, date
-- id автоинкремент, title not null,  date NOW()

CREATE TABLE table1
(
    ID INT NOT NULL IDENTITY(1, 2) PRIMARY KEY,
    Title NVARCHAR(60) NOT NULL,
    creationDate DATETIME NOT NULL DEFAULT GETDATE(),
);

INSERT INTO table1
VALUES
    ('mir', DEFAULT),
    ('otdix', DEFAULT),
    ('may', DEFAULT);

-- for titel 5 букв и первая должна быть a

ALTER TABLE table1
WITH NOCHECK 
ADD CONSTRAINT check_title CHECK (Title LIKE '' );


-- или 

ALTER TABLE table1
WITH NOCHECK 
ADD CONSTRAINT check_title CHECK (Title LIKE 'a%' AND LEN([Title]) = 5 );


INSERT INTO table1
VALUES
    ('amifsdffdr', DEFAULT);
INSERT INTO table1
VALUES
    ('a1234', DEFAULT);

-------------

DROP TABLE table1;
SELECT * FROM table1;

-- view и триггер 3in1
-- https://www.sqlservertutorial.net/sql-server-triggers/sql-server-instead-of-trigger/

GO
CREATE VIEW view_lab3
AS
    (
    SELECT ID, Title, creationDate
    FROM table1
);
GO

DROP view view_lab3

SELECT * FROM view_lab3;

GO
CREATE TRIGGER trigger1 ON view_lab3
INSTEAD OF UPDATE, INSERT, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND NOT EXISTS(SELECT * FROM DELETED)
    BEGIN
        INSERT INTO table1 (ID, Title, creationDate) SELECT ID, Title, creationDate FROM INSERTED;
    END

    IF NOT EXISTS (SELECT * FROM INSERTED) AND EXISTS(SELECT * FROM DELETED)
    BEGIN
        DELETE FROM table1 WHERE ID=(SELECT ID FROM DELETED)
    END

    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        IF (UPDATE(Title)) UPDATE table1 SET Title = (SELECT Title
        FROM INSERTED) WHERE ID=(SELECT ID FROM DELETED);

        IF (UPDATE(creationDate)) UPDATE table1 SET creationDate = (SELECT creationDate
        FROM INSERTED) WHERE ID=(SELECT ID FROM DELETED);
    END
END;





DROP TRIGGER trigger1;



INSERT INTO view_lab3
VALUES
    ('saasddasads', DEFAULT);

DELETE FROM view_lab3 where id=13;



SELECT * from table1;
SELECT * FROM view_lab3;
