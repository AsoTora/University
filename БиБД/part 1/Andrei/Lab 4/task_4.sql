delimiter //
create function zad4(str VARCHAR(60)) returns bool
begin
declare yes bool;
select str regexp 'Минск|Киев|Москва|Петербург' into yes;
return yes;
end;
//

-- Создать функции для:
-- 4)	Проверки, что адрес поставщика есть Минск, Москва, Киев, Петербург.
