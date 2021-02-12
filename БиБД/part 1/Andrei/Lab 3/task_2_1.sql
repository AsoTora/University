delimiter //
create function zad2_1(pr INT, kolvo INT) returns FLOAT
begin
declare ng FLOAT;
if pr<500 and kolvo<100 then
	set ng=pr*0.1+kolvo*0.1;
elseif pr>500 and pr<1000 and kolvo<100 then
	set ng=pr*0.2+kolvo*0.25;
elseif pr>500 and pr<1000 and kolvo>100 and kolvo<500 then
	set ng=pr*0.2+kolvo*0.2;
else
	set ng=pr*0.3+kolvo*0.25;
end if;
return ng;
end;
//

-- Создать функции для:
-- 1)	Вычисления налога в зависимости от цены и количества товара
