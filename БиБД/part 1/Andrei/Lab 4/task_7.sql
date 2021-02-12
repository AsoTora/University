delimiter //
create function zad7(str VARCHAR(60)) returns bool
begin
declare yes bool;
select str regexp '^[^a-z]*' into yes;
if yes=0 then
	return 1;
else
	return 0;
end if;
end;
//

-- Создать функции для:
-- 7)	Проверки, что в названии товара нет английских букв.
