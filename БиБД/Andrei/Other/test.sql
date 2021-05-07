
CREATE TABLE deff_lab_3(
    Title NVARCHAR(60) NOT NULL,
    creationDate DATETIME NOT NULL DEFAULT GETDATE(),
    ID INT NOT NULL IDENTITY(1, 1),
    PRIMARY KEY (ID)
);

INSERT INTO deff_lab_3 VALUES ('MIR', DEFAULT), ('TRUD', DEFAULT), ('MAI', DEFAULT);

ALTER TABLE dbo.deff_lab_3 
WITH NOCHECK 
ADD CONSTRAINT CHK_words CHECK (Title LIKE 'a%');


-- создать view и trigget на 3 операции
GO
CREATE VIEW deff_lab_3_view AS (
  SELECT ID, Title, creationDate FROM deff_lab_3
)
GO

CREATE TRIGGER deff_lab_3_view_Insert_Update_delete
ON deff_lab_3_view
INSTEAD OF UPDATE, INSERT, DELETE
AS
BEGIN
-- insert
  IF EXISTS(SELECT * FROM INSERTED) AND NOT EXISTS(SELECT * FROM DELETED)
  BEGIN
    INSERT INTO dbo.deff_lab_3(ID, Title, creationDate)
      SELECT ID, Title, creationDate
      FROM INSERTED;
  END

-- update

IF EXISTS(SELECT * FROM INSERTED) AND EXISTS(SELECT * FROM DELETED)
BEGIN
  IF (UPDATE(Title))
    UPDATE dbo.deff_lab_3 SET Title = (SELECT Title FROM INSERTED) WHERE
    ID=(SELECT ID FROM DELETED);

    IF (UPDATE(creationDate))
    UPDATE dbo.deff_lab_3 SET creationDate = (SELECT creationDate FROM INSERTED) WHERE
    ID=(SELECT ID FROM DELETED);
  END

-- delete 
  IF NOT EXISTS(SELECT * FROM INSERTED) AND EXISTS(SELECT * FROM DELETED)
    BEGIN
    DELETE FROM dbo.deff_lab_3
      WHERE ID=(SELECT ID FROM DELETED)
  END
END;
GO

-- CREATE TRIGGER deff_lab_3_view_Update
-- ON deff_lab_3_view
-- INSTEAD OF UPDATE
-- AS
-- BEGIN	
--   IF (UPDATE(Title))
--   UPDATE dbo.deff_lab_3 SET Title = (SELECT Title FROM INSERTED) WHERE
--   ID=(SELECT ID FROM DELETED);

--   IF (UPDATE(creationDate))
--   UPDATE dbo.deff_lab_3 SET creationDate = (SELECT creationDate FROM INSERTED) WHERE
--   ID=(SELECT ID FROM DELETED);
-- END;
-- GO

-- CREATE TRIGGER deff_lab_3_view_Delete
-- ON deff_lab_3_view
-- INSTEAD OF DELETE
-- AS
-- BEGIN
-- 	DELETE FROM dbo.deff_lab_3
-- 	WHERE ID=(SELECT ID FROM DELETED)
-- END;
-- GO
