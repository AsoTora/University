Create database B1;
use b1;
CREATE TABLE Basic (
    SongTitle VARCHAR(35),
    Quality varchar(1),
    Duration INT,
    DateRecord DATE,
    AlbumTitle varchar(35), 
    price decimal (5,2),
    ArtistName varchar(35),
    [e-mail] varchar(35)
    );
insert into Basic (SongTitle, Quality, Duration, DateRecord, AlbumTitle, price, ArtistName, [e-mail]) values 
('Sing Me To Sleep', 'H', 176, '2019-08-29',null, null, 'Alan Walke', 'AlanWalker@mail.com'),
('The Greatest', 'L', 88, '2020-10-24', 'The Greatest', 2.38, 'Sia', null),
('Cheap Thrills', 'M', 115, '2017-07-16', 'The Greatest', 2.38, 'Sia', null),
('Ocean Drive', 'M', 101,	'2019-12-04', null, null, 'Duke Dumont', null),
('No Money', 'M',	126, '2019-05-11', 'In The Lonely Hour', 3.63, null, null),
('Thinking About It', 'L', 170, '2020-01-14', 'Evolution', 1.88, 'Nathan Goshen', null),
('Perfect Strangers', 'L', 189, '2019-09-06', 'Runway', 2.75, 'Jonas Blue', null),
('Perfect Strangers', 'L', 189, '2019-09-06', 'Runway', 2.75, 'Jp Cooper', null),
('Thinking About It', 'M', 179, '2018-10-25','In The Lonely Hour',3.25, 'Alan Walke', 'AlanWalker@mail.com'),
('Thinking About It', 'M', 179, '2018-10-25','In The Lonely Hour',3.25, 'Jp Cooper', null),
('My Way', 'H', 163, '2020-07-26','My Way', 1.63, 'Frank Sinatra', null),	
('My Way', 'H', 157,	'1985-01-11','The Christmas', 3.63, 'Frank Sinatra', null),
('Let It Snow!', 'M', 158, '1984-03-05','World On A String', 3.38, 'Frank Sinatra', null);

SELECT * FROM basic;
drop table artist;
drop table album;
drop table songs;
drop table ArtistsSongs;

-- Выполнить представленные выше запросы.
-- Нормальзвать базу данных. 
-- Создать новые таблицы (назания полей взять из таблицы Basic),
-- заполнить их с помощью запросов из таблицы Basic

create table artist (
	ArtistId INT IDENTITY(1,1) PRIMARY KEY,
	ArtistName varchar(35),
	[e-mail] varchar(35)
	);
drop table artist;

insert into artist (ArtistName, [e-mail]) 
select Basic.ArtistName, Basic.[e-mail] from Basic
where Basic.ArtistName is not NUll
group by Basic.ArtistName, Basic.[e-mail];

select * from artist;
'drop table artist;'

create table album (
	AlbumId INT IDENTITY(1,1) PRIMARY KEY,
	AlbumTitle varchar(35),
	Price decimal (5, 2)
	);

insert into album (AlbumTitle, Price) 
select Basic.AlbumTitle, Basic.price from Basic
where Basic.AlbumTitle is not NUll
group by Basic.AlbumTitle, Basic.price;

select * from album;

create table quality (
	QualityId INT IDENTITY(1,1) PRIMARY KEY,
	Quality varchar(1)
	);

insert into Quality (quality.Quality) 
select Basic.Quality from Basic
where Basic.Quality is not NULL
group by Basic.Quality;

select * from quality;
drop table songs;
create table songs (
	SongId INT IDENTITY(1,1) PRIMARY KEY,
	SongTitle VARCHAR(35),
	QualityId int,
	Duration INT,
	DateRecord DATE,
	AlbumId int
	);

select * from basic;

insert into songs (songs.SongTitle, songs.QualityId, songs.Duration, songs.DateRecord, album.AlbumId) 
select Basic.SongTitle, quality.QualityId, Basic.Duration, Basic.DateRecord, album.AlbumId from Basic
inner join quality
on Basic.Quality = quality.Quality
left join album
on Basic.AlbumTitle = album.AlbumTitle and Basic.Price = album.Price
where Basic.SongTitle is not NUll
group by Basic.SongTitle, quality.QualityId, Basic.Duration, Basic.DateRecord, album.AlbumId;

select * from songs;
select SongTitle, Quality, Duration, DateRecord, AlbumTitle from basic;

create table ArtistsSongs (
	ArtistsSongsId INT IDENTITY(1,1) PRIMARY KEY,
	ArtistId int,
	SongId int
	);

insert into ArtistsSongs (ArtistsSongs.ArtistId, ArtistsSongs.SongId)
select artist.ArtistId, songs.SongId from artist
right join Basic on Basic.ArtistName = artist.ArtistName
inner join Songs on Basic.SongTitle = songs.SongTitle and Basic.DateRecord = songs.DateRecord
group by artist.ArtistId, songs.SongId;

select * from Basic;
select * from ArtistsSongs;

-- Создать запросы (таблицу basic использовать не допускается):
-- 1. Вывести поля: SongTitle, Quality, Duration, DateRecord, AlbumTitle, 
-- price, ArtistName, [e-mail] из полученных в ходе нормализации таблиц
-- ----------------------------------------------------------------------
-- Решение:

select songs.SongTitle, quality.Quality, songs.Duration, songs.DateRecord, album.AlbumTitle, album.Price, artist.ArtistName
from ArtistsSongs left join artist on artist.ArtistId = ArtistsSongs.ArtistId
inner join songs on songs.SongId = ArtistsSongs.SongId
inner join quality on quality.QualityId = songs.QualityId
left join album on album.AlbumId = songs.AlbumId;

-- ----------------------------------------------------------------------
-- 2. Добавить новую композицию - назание: "Can't Stop The Feeling", исполнителя: "Jonas Blue", 
-- продолжительностью 253 секунды, качество - "M" - 3, в "DateRecord" указать текущию дату.
-- ----------------------------------------------------------------------
-- Решение:

insert into songs (SongTitle, QualityId, Duration, DateRecord) values ('Can''t Stop The Feeling', 3, 253, getdate());
insert into ArtistsSongs (ArtistId, SongId, AlbumId) values (4, 12, Null);
select * from songs;
select * from artist;
select * from album;
select * from ArtistsSongs;

-- ----------------------------------------------------------------------
-- 3. Переименовать аудио запасись "Thinking About It" исполнитля "Nathan Goshen" в "Let It Go"
-- ----------------------------------------------------------------------
-- Решение:

update songs set SongTitle = 'Let it go'
where SongTitle in (
select SongTitle from ArtistsSongs inner join artist on artist.ArtistId = ArtistsSongs.ArtistId
inner join songs on songs.SongId = ArtistsSongs.SongId 
where ArtistName = 'Nathan Goshen' and SongTitle = 'Thinking About It'
);

select * from songs;

-- ----------------------------------------------------------------------
-- 4. Удалить колонку "e-mail", создать колонку "Сайт", задав по умолчанию значение «нет»
-- ----------------------------------------------------------------------
-- Решение:

alter table artist drop column [e-mail];
select * from artist;
alter table artist add Сайт varchar(50) NOT NULL default ('нет');
select * from artist;

-- ----------------------------------------------------------------------
-- 5. Вывести все аудио запасиси, отобразив, если имеется, имя исполнителя и альбом
-- ----------------------------------------------------------------------
-- Решение:

select songs.SongTitle, album.AlbumTitle, artist.ArtistName
from ArtistsSongs inner join artist on artist.ArtistId = ArtistsSongs.ArtistId
inner join songs on songs.SongId = ArtistsSongs.SongId
left join album on album.AlbumId = ArtistsSongs.AlbumId;

-- ----------------------------------------------------------------------
-- 6. Вывести все аудио запасиси, у которых в названии альбома есть «way» 
-- ----------------------------------------------------------------------
-- Решение:

select songs.SongTitle, album.AlbumTitle
from ArtistsSongs inner join songs 
on ArtistsSongs.SongId = songs.SongId
left join album on album.AlbumId = ArtistsSongs.AlbumId
where album.AlbumTitle like '%way%';

-- ----------------------------------------------------------------------
-- 7. Вывести: название, стоимость альбома и его исполнителя при условии, 
-- что он будет самым дорогим для каждого исполнителя.
-- ----------------------------------------------------------------------
-- Решение:

select album.AlbumTitle, album.Price, artist.ArtistName
from ArtistsSongs left join artist on artist.ArtistId = ArtistsSongs.ArtistId
inner join songs on songs.SongId = ArtistsSongs.SongId
left join album on album.AlbumId = ArtistsSongs.AlbumId
inner join (select MAX(album.Price) as max_price, artist.ArtistName
from ArtistsSongs inner join artist on artist.ArtistId = ArtistsSongs.ArtistId
inner join songs on songs.SongId = ArtistsSongs.SongId
inner join album on album.AlbumId = ArtistsSongs.AlbumId
group by artist.ArtistName) tmp
on tmp.max_price = album.Price and tmp.ArtistName = artist.ArtistName
group by album.AlbumTitle, album.Price, artist.ArtistName;

-- ----------------------------------------------------------------------
-- 8. Удалить запись "Can't Stop The Feeling" исполнителя "Jonas Blue".
-- ----------------------------------------------------------------------
-- Решение:
select * from songs;

delete songs 
where SongTitle in (
select SongTitle from ArtistsSongs inner join artist on artist.ArtistId = ArtistsSongs.ArtistId
inner join songs on songs.SongId = ArtistsSongs.SongId 
where ArtistName = 'Jonas Blue' and SongTitle = 'Can''t Stop The Feeling'
);

select * from songs;

-- ----------------------------------------------------------------------