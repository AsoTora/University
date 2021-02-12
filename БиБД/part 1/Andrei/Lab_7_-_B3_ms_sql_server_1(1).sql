-- B3
use b2
go;
-- ??? Таблица "Supply" требует исправлений (по какой причине?). -- не соблюдается 3я нормальная форма

Create table AlbumSupply
(
	AlbumSupplyId INT IDENTITY(1,1) PRIMARY KEY,
	AlbumTitle varchar(35),
	Author varchar(35)
);

insert into AlbumSupply
	(AlbumTitle, Author)
select Distinct AlbumTitle, ArtistName
from Supply;

/* 1. Создать таблицу "Firm" с полями: 
	IDF – первичный ключ, целочисленное, авто инкремент; 
	FirmName – текстовое поле;
	Address – текстовое поле; 
	Rate – числовое поле с хранением двух знаков после запятой. */
-- ----------------------------------------------------------------------
-- Решение:

create table Firm
(
	IDF INT IDENTITY(1,1) PRIMARY KEY,
	FirmName varchar(50),
	Address varchar(50),
	Rate decimal(3, 2)
);

-- ----------------------------------------------------------------------
/* 2. Теперь ее нужно заполнить соответствующими данными из таблицы "Supply". 
Cтавка “Rate” будет считаться: находим среднее значение “Rate,%”  
для каждой фирмы и если оно будет до 10, то новое значение – 0,1; 
				   если от 10 до 20 – 0,2; 
				   если от 20 до 30 – 0,3; 
				   в остальных случаях – 0,4. */
-- ----------------------------------------------------------------------
-- Решение:

insert into Firm
	(FirmName, Address, Rate)
select Firm, Address, IIF(
	AVG([Rate,%]) < 10, 0.1, IIF(
		AVG([Rate,%]) >= 10 and AVG([Rate,%]) < 20, 0.2, IIF(
			AVG([Rate,%]) >= 20 and AVG([Rate,%]) < 30, 0.3, 0.4
			)
		)
	) as Rate
from Supply
group by Firm, Address;


-- ----------------------------------------------------------------------
/* 3. После того как данные были перенесены в новую таблицу, можно удалить ненужные колонки “Address”, “Rate,%”.*/
-- ----------------------------------------------------------------------
-- Решение:

alter table Supply drop column Address, [Rate,%];

-- ----------------------------------------------------------------------
/* 4. Для хранения текущего количества альбомов от каждого поставщика создадим таблицу “Store” с полями: 
IDST – первичный ключ, целочисленное, авто инкремент; 
IDFi – целочисленное (хранит код фирмы); 
IDAl – целочисленное (хранит код альбома); 
Amount – целочисленное (хранит количество альбомов).*/
-- ----------------------------------------------------------------------
-- Решение:

create table Store
(
	IDST int identity(1, 1) primary key,
	IDFi int,
	IDAl int,
	Amount int
);

Go;

-- ----------------------------------------------------------------------
/* 5. Заполнить таблицу “Store”, данные для заполнения брать из таблицы “Supply”. */
-- ----------------------------------------------------------------------
-- Решение №1 (использовать view/cursor):

-- Cursor
-- переменные
declare @firm varchar(50), @albumId varchar(50), @amount int
declare cur cursor FOR
	select firm.IDF, AlbumSupply.AlbumSupplyId, SUM(Supply.amount) as am
	from Supply
		inner join AlbumSupply on AlbumSupply.AlbumTitle = Supply.AlbumTitle and AlbumSupply.Author = Supply.ArtistName
		inner join Firm on Firm.FirmName = Supply.Firm
	group by firm.IDF, AlbumSupply.AlbumSupplyId;

open cur
fetch next from cur into @firm, @albumId, @amount
--если данные в курсоре есть, то заходим в цикл
--и крутимся там до тех пор, пока не закончатся строки в курсоре
while @@FETCH_STATUS=0
begin
	insert into Store
		(IDFi, IDAl, amount)
	values
		(@firm, @albumId, @amount)
	--считываем следующую строку курсора
	fetch next from cur into @firm, @albumId, @amount
end

close cur
deallocate cur
GO

-- Veiw
create view forTable
(
	firm,
	albumid,
	amount
)
as
	select firm.IDF, AlbumSupply.AlbumSupplyId, SUM(Supply.amount)
	from Supply
		inner join AlbumSupply on AlbumSupply.AlbumTitle = Supply.AlbumTitle
		inner join Firm on Firm.FirmName = Supply.Firm
	group by firm.IDF, AlbumSupply.AlbumSupplyId;

insert into Store
	(IDFi, IDAl, amount)
select *
from forTable;


-- Решение №2 (не использовать view/cursor):
insert into Store
	(IDFi, IDAl, amount)
select firm.IDF, AlbumSupply.AlbumSupplyId, SUM(Supply.amount)
from Supply
	inner join AlbumSupply on AlbumSupply.AlbumTitle = Supply.AlbumTitle
	inner join Firm on Firm.FirmName = Supply.Firm
group by firm.IDF, AlbumSupply.AlbumSupplyId;

-- ----------------------------------------------------------------------
/* 6. Создадим таблицу “Purchases”, в ней будем хранить: 
IDP – первичный ключ, целочисленное, авто инкремент; 
IDST – целочисленное (хранит код альбома от конкретного поставщика); 
Amount – целочисленное (хранит количество приобретённых альбомов); 
PriceP – числовое поле с двумя знаками после запятой (стоимость альбома); 
DateP – хранит дату (день, месяц, год) покупки. */
-- ----------------------------------------------------------------------
-- Решение:

create table Purchases
(
	IDP int identity(1, 1) primary key,
	IDST int,
	Amount int,
	PriceP decimal(3, 2),
	DateP date
)
GO

-- ----------------------------------------------------------------------
/* 7. Создадим процедуру для одновременного добавления информации о покупке в таблицу "Purchases" 
и редактирования актуального числа альбомов в таблице “Store”.
 Неплохо бы учесть, что продать то, чего нет – невозможно.  
 PriceP считаем как:  Price * (1 + firm.Rate + 0.18)*/
-- ----------------------------------------------------------------------
-- Решение №1:

create procedure task7_1
	@Amount int,
	@AlbumName varchar(35),
	@Artist varchar(35),
	@date date
as
declare @am INT
declare @rate decimal(3, 2)
declare @IDST int
begin
	select @IDST = Store.IDST, @am = Store.Amount, @rate = (1+Firm.Rate+0.18)
	from Store
		inner join AlbumSupply on Store.IDAl = AlbumSupply.AlbumSupplyId
		inner join Firm on Store.IDFi = Firm.IDF
	where AlbumSupply.AlbumTitle = @AlbumName and AlbumSupply.Author = @Artist and Store.Amount >= @Amount and (1+Firm.Rate+0.18) = (
		select top(1)
			MIN(1+Firm.Rate+0.18)
		from Store
			inner join AlbumSupply on Store.IDAl = AlbumSupply.AlbumSupplyId
			inner join Firm on Store.IDFi = Firm.IDF
		where AlbumSupply.AlbumTitle = @AlbumName and AlbumSupply.Author = @Artist and Store.Amount >= @Amount
	)
	if @IDST is not Null
	begin
		update Store set Store.Amount = Store.Amount - @Amount
	where Store.IDST = @IDST
		insert into Purchases
			(IDST, Amount, PriceP, DateP)
		values
			(@IDST, @Amount, @rate, @date)
	end;
	begin
		PRINT 'Something went wrong!'
	end;
end;
GO

-- Решение №2:

create procedure task7_2
	@Amount int,
	@AlbumName varchar(35),
	@Artist varchar(35),
	@date date
as
declare @am INT
declare @rate decimal(3, 2)
declare @IDST int
declare cura cursor for
select Store.IDST, Store.Amount, (1+Firm.Rate+0.18)
from Store
	inner join AlbumSupply
	on Store.IDAl = AlbumSupply.AlbumSupplyId
	inner join Firm
	on Store.IDFi = Firm.IDF
where AlbumSupply.AlbumTitle = @AlbumName and AlbumSupply.Author = @Artist and Store.Amount >= @Amount and (1+Firm.Rate+0.18) = (
		select top(1)
		MIN(1+Firm.Rate+0.18)
	from Store
		inner join AlbumSupply
		on Store.IDAl = AlbumSupply.AlbumSupplyId
		inner join Firm
		on Store.IDFi = Firm.IDF
	where AlbumSupply.AlbumTitle = @AlbumName and AlbumSupply.Author = @Artist and Store.Amount >= @Amount
	)
begin
	open cura
	fetch next from cura into @IDST, @am, @rate
	if @IDST is not Null
	begin
		insert into Purchases
			(IDST, Amount, PriceP, DateP)
		values
			(@IDST, @Amount, @rate, @date);
		update Store set Store.Amount = Store.Amount - @Amount
		where Store.IDST = @IDST;
	end;
	else
	begin
		PRINT 'Something went wrong!'
	end;
	close cura
	deallocate cura
end;
GO

-- ----------------------------------------------------------------------
/* 8. Добавить несколько записей о покупках.*/
-- ----------------------------------------------------------------------
-- Решение:

execute task7_1 20, 'In The Lonely Hour', 'Nathan Goshen', '2018-08-21';
execute task7_2 12, 'My Way', 'Frank Sinatra', '2017-07-24';
execute task7_1 5, 'The Christmas', 'Frank Sinatra', '2015-06-15';
execute task7_2 6, 'In The Lonely Hour', 'Lil Wayne', '2020-11-17';
select *
from Purchases;
select *
from Store;

-- ----------------------------------------------------------------------
/* 9. Вывести название фирмы, название купленного альбома, количество и стоимость покупки, 
одновременно вывести общий итог и итог по фирме-поставщике.  */
-- ----------------------------------------------------------------------
-- Решение:

select Firm.FirmName, AlbumSupply.AlbumTitle, Purchases.Amount, PriceP * Purchases.Amount as Cost
from Purchases 
	inner join Store on Purchases.IDST = Store.IDST
	inner join Firm on Firm.IDF = Store.IDFi
	inner join AlbumSupply on Store.IDAl = AlbumSupply.AlbumSupplyId;

-- ----------------------------------------------------------------------
/* 10. С применением курсора посчитать число альбомов, которые имеют несколько фирм-поставщиков.*/
-- ----------------------------------------------------------------------
-- Решение:

create table albums_1
(
	albumId int
);
go

declare @fId int, @alid int, @counter int, @res_counter int, @fid1 int, @alid1 int

declare cur cursor for
	select Store.IDAl, Store.IDFi
	from Store
	set @counter = 0
	set @res_counter = 0

open cur
fetch next from cur into @alid, @fid
while @@FETCH_STATUS=0
begin
	declare cur1 cursor for
		select Store.IDAl, Store.IDFi
		from Store

	open cur1
	fetch next from cur1 into @alid1, @fid1
	while @@FETCH_STATUS=0
	begin
		if @alid = @alid1 and @fId <> @fid1 and @alid not in (select *
			from albums_1)
			begin
			set @counter = @counter + 1
		end
		fetch next from cur1 into @alid1, @fid1
	end
	close cur1
	deallocate cur1

	if @counter <> 0
		begin
		set @res_counter = @res_counter + 1
		insert into albums_1
			(albumID)
		values
			(@alid);
	end
	set @counter = 0
	fetch next from cur into @alid, @fid
end

close cur
deallocate cur
set @res_counter = @res_counter;

select *
from albums_1;
drop table albums_1;
select @res_counter;

-- ----------------------------------------------------------------------
/* 11. Вывести название треков, исполнителей и название альбомов, 
которые были куплены в этом месяце, также вывести название фирмы, стоимость альбома и цену, дату покупки.*/
-- ----------------------------------------------------------------------
-- Решение:
select AlbumSupply.Author, AlbumSupply.AlbumTitle, Firm.FirmName, Purchases.PriceP, Purchases.DateP
from
	Purchases inner join Store on Purchases.IDST = Store.IDST
	inner join Firm on Store.IDFi = Firm.IDF
	inner join AlbumSupply on Store.IDAl = AlbumSupply.AlbumSupplyId
where YEAR(Purchases.DateP) = YEAR(GETDATE()) and MONTH(Purchases.DateP) = MONTH(GETDATE());

-- ----------------------------------------------------------------------
/*  12* Продолжить исправление таблицы “Supply”. Теперь нужно заменить 
название фирмы на код фирмы, а название альбома и автора заменить на код альбома.*/
-- ----------------------------------------------------------------------
-- Решение:

update supply set supply.Firm = (select Firm.IDF
	from firm 
	where supply.Firm = Firm.FirmName), 
	supply.AlbumTitle = (select AlbumSupply.AlbumSupplyId
		from AlbumSupply
		where AlbumSupply.AlbumTitle = supply.AlbumTitle and AlbumSupply.Author = supply.ArtistName
		);
alter table supply drop column ArtistName;
ALTER TABLE supply ALTER COLUMN AlbumTitle int;
ALTER TABLE supply ALTER COLUMN Firm int;

-- ----------------------------------------------------------------------
/*  13 Добавить constraint foreign key для таблиц: “Supply”, “Firm”, “Purchases”, “Store”.*/
-- ----------------------------------------------------------------------
-- Решение:

ALTER TABLE Supply
	ADD CONSTRAINT fk_frim FOREIGN KEY (Firm) REFERENCES Firm (IDF);
ALTER TABLE Supply
	ADD CONSTRAINT fk_album FOREIGN KEY (AlbumTitle) REFERENCES AlbumSupply (AlbumSupplyId);
ALTER TABLE Purchases
	ADD CONSTRAINT fk_store FOREIGN KEY (IDST) REFERENCES Store (IDST);
ALTER TABLE Store
	ADD CONSTRAINT fk_firm FOREIGN KEY (IDFi) REFERENCES Store (IDST);
ALTER TABLE Store
	ADD CONSTRAINT fk_album FOREIGN KEY (IDAl) REFERENCES AlbumSupply (AlbumSupplyId);

-- ----------------------------------------------------------------------