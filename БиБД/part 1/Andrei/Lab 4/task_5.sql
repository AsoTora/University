delimiter //
create function zad5(str VARCHAR(60)) returns bool
begin
declare yes bool;
select str regexp '(ов|ев|ий|ой|ова|ева|ин|ын|ина|ына)$' into yes;
return yes;
end;
//

-- Создать функции для:
-- 5)	Проверки, что фамилия поставщика кончается на  ов, ев, ий, ой, ова, ева, ин, ын, ина, ына.
