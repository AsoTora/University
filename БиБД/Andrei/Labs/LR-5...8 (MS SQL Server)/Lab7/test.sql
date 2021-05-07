-- кросс-таблица yes/no посчитать сколько каждый сдал и записать в XML pivot + xml
-- пользователь -> сдал -> не сдал

CREATE TABLE success
(
  ID [int] NOT NULL UNIQUE IDENTITY(1,1),
  [name] [nvarchar](25) NOT NULL,
  [lab1] [TINYINT] NOT NULL,
  [lab2] [TINYINT] NOT NULL,
  [lab3] [TINYINT] NOT NULL
);


INSERT INTO success
VALUES
  ('Vasyl', 1, 0, 1);
INSERT INTO success
VALUES
  ('Pytha', 1, 0, 0);
INSERT INTO success
VALUES
  ('ANdrei', 1, 1, 1);
INSERT INTO success
VALUES
  ('Kate', 0, 0, 0);

SELECT *
FROM success;

-- select [name], COUNT(name)
-- from (SELECT [name], col, num
--   FROM success
--    UNPIVOT(
--           num for col in ( [lab1],[lab2],[lab3]
--                                      )
--            )AS unpvt) as Person
--   where num=1
-- GROUP BY [name]
-- FOR xml	path('Student'), root ('Students');



DECLARE @xmlvar XML
SET @xmlvar = (select [name], COUNT(name)
from (SELECT [name], col, num
  FROM success
   UNPIVOT(
          num for col in ( [lab1],[lab2],[lab3]
                                     )
           )AS unpvt) as Person
  where num=1
GROUP BY [name]
FOR XML PATH('Student'
    ), ROOT ('SuccessfulStudents')
)
SELECT @xmlvar;
