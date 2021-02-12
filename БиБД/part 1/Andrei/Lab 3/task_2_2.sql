delimiter //
create function zad2_2(tov VARCHAR(25)) returns float
begin
declare sr float;
select AVG(price) into sr from sklad where tovar=tov;
return sr; 
end;
//

-- Создать функции для:
-- 2)	Вычисления средней цены товара по таблице
