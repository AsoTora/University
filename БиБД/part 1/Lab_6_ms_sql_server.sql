-- B2
-- 1.	К созданной ранее базе данных, применяя только SQL, добавить таблицу «Supply» (поставки), состоящую из полей: 
-- IDSU – int, Firm – varchar, Address – varchar, Amount – int, Rate,% – int, ArtistName  – varchar, AlbumTitle – varchar. 
-- ----------------------------------------------------------------------
-- Решение:
use b1;

select * from basic;

create table Supply (
	IDSU int,
	Firm varchar(50),
	Address varchar(50),
	Amount int,
	"Rate,%" int,
	ArtistName varchar(50),
	AlbumTitle varchar(50)
	);
select * from Supply;
select * from Basic;
drop table Supply;
-- ----------------------------------------------------------------------
-- 2.	Выпольнить запросы:
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (1, 'Akvilon', 'Bereza', 66, 24, 'Sia', 'The Greatest');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (2, 'Atlant', 'Nesvizh', 23, 11, 'Sia', 'The Greatest');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (3, 'Venera', 'Myadel''', 6, 14, 'Nathan Goshen', ' In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (4, 'Vesta', 'Slavgorod', 27, 18, 'Jp Cooper', 'Runway');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (5, 'Vulkan', 'Zhabinka', 87, 5, 'Wiz Khalifa', 'In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (6, 'Gerkules', 'Pinsk', 42, 12, 'Calvin Harris', 'In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (7, 'Diana', 'Malorita', 55, 8, 'Frank Sinatra', 'My Way');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (8, 'Lyutsina', 'Svetlogorsk', 21, 6, 'Frank Sinatra', 'The Christmas');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (9, 'Mars', 'Borisov', 58, 21, 'Frank Sinatra', 'World On A String');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (10, 'Merkuriy', 'Minsk', 76, 4, 'Sia', 'The Greatest');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (11, 'Minerva', 'Skidel''', 22, 14, 'Jp Cooper', 'Runway');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (12, 'Salyus', 'Kalinkovichi', 59, 10, 'Jonas Blue', 'Runway');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (13, 'Talassiy', 'Ivanovo', 94, 7, 'Lil Wayne', 'In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (14, 'Tellus', 'Cherven''', 29, 10, 'Nathan Goshen', ' In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (15, 'Triviya', 'Kossovo', 3, 9, 'Jp Cooper', 'Runway');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (16, 'Favoniy', 'Dzerzhinsk', 59, 24, 'Wiz Khalifa', 'In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (17, 'Feb', 'Gomel''', 20, 25, 'Calvin Harris', 'In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (18, 'Elissa', 'Mogilev', 79, 20, 'Frank Sinatra', 'My Way');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (19, 'Yuventa', 'Slonim', 76, 12, 'Frank Sinatra', 'The Christmas');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (20, 'Yunona', 'Krichev', 59, 22, 'Frank Sinatra', 'World On A String');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (21, 'Yupiter', 'Molodechno', 87, 3, 'Sia', 'The Greatest');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (22, 'Diana', 'Malorita', 42, 12, 'Frank Sinatra', 'My Way');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (23, 'Lyutsina', 'Svetlogorsk', 55, 8, 'Jonas Blue', 'Runway');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (24, 'Mars', 'Borisov', 21, 6, 'Lil Wayne', 'In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (25, 'Merkuriy', 'Minsk', 58, 21, 'Nathan Goshen', ' In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (26, 'Minerva', 'Skidel''', 76, 4, 'Sia', 'The Greatest');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (27, 'Triviya', 'Kossovo', 22, 14, 'Sia', 'The Greatest');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (28, 'Favoniy', 'Dzerzhinsk', 59, 10, 'Nathan Goshen', ' In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (29, 'Feb', 'Gomel''', 94, 7, 'Jp Cooper', 'Runway');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (30, 'Elissa', 'Mogilev', 29, 10, 'Wiz Khalifa', 'In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (31, 'Lyutsina', 'Svetlogorsk', 3, 9, 'Calvin Harris', 'In The Lonely Hour');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (32, 'Mars', 'Borisov', 42, 24, 'Frank Sinatra', 'My Way');
insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (33, 'Merkuriy', 'Minsk', 55, 25, 'Frank Sinatra', 'The Christmas');

-- 3.	Добавить записи в таблицу supply используя многоуровневый insert:
-- 			"Minerva", "Skidel'",	21, 20,	"Frank Sinatra", "World On A String"
-- 			"Triviya", "Kossovo",	58,	12,	"Sia",	"The Greatest"
-- 			"Favoniy", "Dzerzhinsk",	76,	8,	"Sia",	"The Greatest"
-- ----------------------------------------------------------------------
-- Решение:

insert into supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (34, 'Minerva', 'Skidel''',	21, 20,	'Frank Sinatra', 'World On A String'), 
																						  (35, 'Triviya', 'Kossovo',	58,	12,	'Sia',	'The Greatest'),
																						  (36, 'Favoniy', 'Dzerzhinsk',	76,	8,	'Sia',	'The Greatest');
select * from Supply;
-- ----------------------------------------------------------------------
-- 4.	Написать хранимую процедуру для добавления записи в таблицу «Supply».
-- ----------------------------------------------------------------------
-- Решение:

go
create procedure add_row 
	@id int, 
	@firm varchar(50), 
	@Address varchar(50), 
	@Amount int, 
	@rate int, 
	@ArtistName varchar(50), 
	@AlbumTitle varchar(50)
as
	set nocount on;
	insert Supply (IDSU, Firm, Address, Amount, [Rate,%], ArtistName, AlbumTitle) values (@id, @firm, @Address, @Amount, @rate, @ArtistName, @AlbumTitle);


-- ----------------------------------------------------------------------
-- 5.	Добавить запись, используя хранимую процедуру из задания 4:
-- 			"Feb", "Gomel'",	22,	6,	"Jonas Blue",	"Runway"
-- ----------------------------------------------------------------------
-- Решение:

execute add_row 37, 'Feb', 'Gomel''',	22,	6,	'Jonas Blue',	'Runway';
select * from Supply;

-- ----------------------------------------------------------------------
-- 6.	Вывести название и качество записи трека отсортировав 
--сначала по качеству, затем по названию (обратный порядок), не включая плохие записи.
-- ----------------------------------------------------------------------
-- Решение:

select SongTitle, quality.Quality from songs inner join quality
on songs.qualityId = quality.qualityId
where quality.quality <> 'L'
order by quality.qualityId, songs.SongTitle desc;

-- ----------------------------------------------------------------------
-- 7.	Вывести название и цену трех самых дешевых альбомов.
-- ----------------------------------------------------------------------
-- Решение:

select top(3) AlbumTitle, Price from album
order by Price;

-- ----------------------------------------------------------------------
-- 8.	Вывести альбом второй по стоимости после самого дорогого альбома.
-- ----------------------------------------------------------------------
-- Решение:

select AlbumTitle, Price from album
where Price = (select MAX(Price) from album
			   where Price <> (select MAX(Price) from album)
			   );

-- ----------------------------------------------------------------------
-- 9.	Найти альбом, у которого нет исполнителя.
-- ----------------------------------------------------------------------
-- Решение №1:

select album.AlbumTitle
from ArtistsSongs left join artist on artist.ArtistId = ArtistsSongs.ArtistId
inner join songs on songs.SongId = ArtistsSongs.SongId
left join album on album.AlbumId = songs.AlbumId
where ArtistName is Null;

select * from ArtistsSongs;
-- Решение №2:

select album.AlbumTitle
from ArtistsSongs left join artist on artist.ArtistId = ArtistsSongs.ArtistId
inner join songs on songs.SongId = ArtistsSongs.SongId
left join album on album.AlbumId = songs.AlbumId
where ArtistsSongs.ArtistsSongsId not in (select ArtistsSongs.ArtistsSongsId
from ArtistsSongs inner join artist on artist.ArtistId = ArtistsSongs.ArtistId
inner join songs on songs.SongId = ArtistsSongs.SongId
left join album on album.AlbumId = songs.AlbumId)
group by album.AlbumTitle;

-- ----------------------------------------------------------------------
-- 10.	
-- ----------------------------------------------------------------------
-- Решение:


-- ----------------------------------------------------------------------
-- 11.	Найти треки, у которых название начинается не с букв.
-- ----------------------------------------------------------------------
-- Решение:

select SongTitle from songs
where SongTitle like '[^a-z]%';

-- ----------------------------------------------------------------------
-- 12.	Найти все треки, которые начинаются на гласные буквы.
-- ----------------------------------------------------------------------
-- Решение:

select SongTitle from songs
where SongTitle like '[aeiouy]%'

-- ----------------------------------------------------------------------
-- 13.	Посчитать отпускную цену альбомов по формуле: 
-- Price_Shop = Price*(1+ Rate, %/100+w); 
--		 где: Price – цена альбома из таблицы Album; 
-- Rate,% – из таблицы «Supply» ; 
-- w=10% при Amount < 50,
-- w=20% при Amount = 50, 
-- w=30% при Amount > 50
-- Результат отсортировать сначала по названию в алфавитном порядке, затем по убыванию цены. 
-- ----------------------------------------------------------------------
-- Решение:

select album.AlbumTitle, IIF(SUM(amount) < 50, album.Price*(1+SUM(Supply.[Rate,%])/100 + 0.1), 
						 IIF(SUM(amount) = 50, album.Price*(1+SUM(Supply.[Rate,%])/100 + 0.2), 
											   album.Price*(1+SUM(Supply.[Rate,%])/100 + 0.3))) as Price_Shop, album.Price
from ArtistsSongs inner join album
on ArtistsSongs.AlbumId = album.AlbumId
inner join songs
on ArtistsSongs.SongId = songs.SongId
inner join artist
on ArtistsSongs.ArtistId = artist.ArtistId
inner join Supply
on album.AlbumTitle = Supply.AlbumTitle and artist.ArtistName = Supply.ArtistName
group by album.AlbumTitle, album.Price;

select * from album;

select album.AlbumTitle,
case 
when SUM(amount) < 50
then album.Price*(1+SUM(Supply.[Rate,%])/100 + 0.1)
when SUM(amount) = 50
then album.Price*(1+SUM(Supply.[Rate,%])/100 + 0.2)
else album.Price*(1+SUM(Supply.[Rate,%])/100 + 0.3)
end price_shop, album.Price
from ArtistsSongs
inner join songs
on ArtistsSongs.SongId = songs.SongId
inner join artist
on ArtistsSongs.ArtistId = artist.ArtistId
inner join album
on album.AlbumId = songs.AlbumId
inner join Supply
on album.AlbumTitle = Supply.AlbumTitle and artist.ArtistName = Supply.ArtistName
group by album.AlbumTitle, album.Price;


select * from ArtistsSongs;
select * from Supply;
select * from basic;

-------------------------------------------------------------------------
Задание
-----------------------------
GO
CREATE PROCEDURE lab6
@alTitle VARCHAR(30), 
@pr INT, 
@songTitle VARCHAR(30), 
@quality CHAR(1), 
@duration INT, 
@dateRecord DATE, 
@artistName VARCHAR(30), 
@email VARCHAR(30) 
	AS
BEGIN
DECLARE @yes INT;
DECLARE @alId INT;
DECLARE @songId INT;
DECLARE @artistId INT;
SELECT @yes=COUNT(Album.albumId)
FROM Album JOIN Song ON Album.albumId=Song.albumId
JOIN SongArtist ON SongArtist.songId=Song.songId
JOIN Artist ON SongArtist.artistId=Artist.artistId
WHERE Album.AlbumTitle=@alTitle AND Song.SongTitle=@songTitle AND Artist.ArtistName=@artistName;
IF @yes=0
BEGIN
INSERT INTO Album(albumTitle, price) VALUES(@alTitle, @pr);

SELECT @alId=MAX(albumId)
FROM ALbum;

INSERT INTO Song(songTitle, quality, duration, dateRecord, albumId) VALUES(@songTitle, @quality, @duration, @dateRecord, @alId);

SELECT @songId=MAX(songId)
FROM Song;

INSERT INTO Artist(artistName, Сайт) VALUES(@artistName, @email);

SELECT @artistId=MAX(artistId)
FROM Artist;

INSERT INTO SongArtist(songId, artistId) VALUES(@songId, @artistId);
END;

END;
