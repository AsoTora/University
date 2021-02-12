delimiter //
create function zad3(str VARCHAR(60)) returns bool
begin
declare yes bool;
select str regexp '^MD-[0-9]{8}' into yes;
return yes;
end;
//

-- Создать функции для:
-- 3)	Проверки паспортных данных типа MD-77889900
