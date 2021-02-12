delimiter //
create function zad1(str VARCHAR(60)) returns bool
begin
declare yes bool;
select str regexp '^[^aeiou][a-z]*' into yes;
return yes;
end;
//

-- Создать функции для:
-- 1)	Проверки, что название товара в базе состоит из букв, причем первая буква - согласная
