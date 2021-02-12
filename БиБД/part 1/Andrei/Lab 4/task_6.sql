delimiter //
create function zad6(str VARCHAR(60)) returns bool
begin
declare yes bool;
select str regexp 'букв|пог|уф|баш|роч|юк' into yes;
return yes;
end;
//

-- Создать функции для:
-- 6)	Проверки, что в названии товара встречается сочетание букв  пог, уф, баш, роч, юк.
