delimiter //
create function zad2(str VARCHAR(60)) returns bool
begin
declare yes bool;
select str regexp '^[0-9]*' into yes;
return yes;
end;
//

-- Создать функции для:
-- 2)	Проверки, что код товара есть число
