CREATE TABLE personel(
per_id int, 
	isim varchar(30),
	sehir varchar(30),
	maas int,
	sirket varchar(20),
	adres varchar(50));
	--varolan personel tablosundan id,sehir,adres fieldlarında sahip personel adres adında yeni tablo oluşturalım
	create table personel_adres 
	as 
	select per_id, sehir, adres from personel;
-- DML -->data manupuşation Lang.
-- INSERT --UPDATE -- DELETE
--TabloYA VERİ EKLEMEK tablodan veri güncellemek ve silme işlemi

create table student( 
id varchar(4),
st_name varchar(30),
age INT);

insert into student VALUES ('1001','ali can',25);
insert into student VALUES ('1002','vali cani',26);
insert into student VALUES ('1003','deli ycan',28);
insert into student VALUES ('1004','seli arcan',32);
insert into student VALUES ('1005','ayli  sanana',45);
-- tabloya parçalı veri eklemek
insert into student (st_name,age) values ('murat can' , 50);
--select 
select * from student;
-- select komutu where ko
select st_name from student;


--TLC -transection control Lang
--Begin  -Savepoit -rollback -coomit
--Transaction veritabanı sistemlerinde bir işlem başladığında başlar ve işlem bitince sona erer
--Bu işlemler veri tabanı oluşturma, veri silme, veri güncelleme, veriyi geri getirme gibi işlemler olabilir
CREATE TABLE ogrenciler2
(id serial,
isim VARCHAR(50),
veli_isim varchar(50),
yazili_notu real
);
begin;
INSERT INTO ogrenciler2 Values (default,'ali can ', 'hasan',75.5);
INSERT INTO ogrenciler2 Values (default,'canan gü ', 'ayşe',95.6);
SAVEPOINT x;
INSERT INTO ogrenciler2 Values (default,'feride', 'mahmet ali',45.9);
INSERT INTO ogrenciler2 Values (default,'saniye', 'dakika',60);
ROLLBACK to x;

SELECT * from ogrenciler2;


-- DML - DELETE -
--DELETE FROM tablo_adi --> Tablo'nun tüm içeriğini siler
-- Veriyi seçerek silmek için WHERE koşulu kullanılır
-- DELETE FROM tablo_adı WHERE sutun_adi = veri --> Tablodaki istediğimiz veriyi siler

commit;
-- transection kullnımında SERIAL data türü kullanımı tavsiye edilmez 
--save pointten sonra eklediğimiz veride sayaç manıtığı ile  çalıştığı için
--sayaçta en son hangi sayıda kaldıysa oradan devam eder.

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

CREATE TABLE ogrenciler
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
SELECT * from ogrenciler;
--Soru : id'si 124 olan öğrenciyi siliniz
DELETE FROM ogrenciler WHERE id=124 ;

DELETE FROM ogrenciler WHERE isim='Kemal Yasa';

DELETE FROM ogrenciler WHERE isim='Nesibe Yılmaz' or isim='Mustafa Bak';

DELETE FROM ogrenciler WHERE isim='Ali Can' or id=123;

delete from ogrenciler;

--DELETE -TRUNCATE --
--TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamını siler ancak seçmeli silme yapmaz

	Truncate table ogrenciler;
	
	
	-- DDL--  data defination lang.
	--create alter drop
	--ALTER TABLE tabloda ADD, TYPE, SET, RENAME veya DROP COLUMNS İşlemleri için kullnılır
	--Personel tablosuna cinsiyet Varchar(20) ve yas int seklinde yeni sutunlar ekleyiniz
	
	ALTER Table personel ADD cinsiyet VARCHAR(20), add yas int;
	SELECT * from personel;
	--personel tablosundan sirket Fieldini siliniz
	alter TABLE personel drop sirket;
	-- personel tablosundaki sehir adını ulke olarak değiştirin
	alter table personel RENAME sehir to ulke;
	
	-- personel tablosunun adını isciler olarak değiştiriiniz
	
	alter table personel RENAME to isciler;
	
	
	-- DDL -DROP 
	
	DROP table isciler;
	
	
	
	-- CONSTRANINT -- Kısıtlamalar
-- Primary Key --> Bir sutunun NULL içermemesini ve sutundaki verilerin BENZERSİZ olmasını sağlar (NOT NULL - UNIQUE)
-- FOREGIN KEY --> Başka bir tablodaki PRİMARY KEY'i referans göstermek için kullanılır. Böylelikle, tablolar arasında ilişki kurmuş oluruz.
-- UNIQUE --> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
-- NOT NULL --> Bir sutunun NULL içermemesini yani boş olmamasını sağlar
-- NOT NULL kısıtlaması için CONSTRAINT ismi tanımlanmaz. Bu kısıtlama veri türünden hemen sonra yerleştirilir
-- CHECK --> Bir sutuna yerleştirilebilecek değer aralığını sınırlamak için kullanılır.

CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,-->tüm değerlerin benzersiz olmasını sağlar
maas int NOT NULL, --> bir sütunun baş değer içermmemesini sağlar
ise_baslama DATE
);

CREATE TABLE calisanlar2(
id CHAR(5),
isim VARCHAR(50),
maas int NOT NULL,
ise_baslama DATE,
CONSTRAINT pk_id PRIMARY KEY(id),
CONSTRAINT ism_unq UNIQUE(isim)
);


INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14');--uniqe
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');-- not null
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- unique
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- not null
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');-- primary key
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--primary key
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --primary key not null

select * from calisanlar;

CREATE TABLE adresler (
adres_id char(5),
sokak Varchar(20),
cadde Varchar(20),
sehir varchar(20),
	CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id));
	
	
	INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

SELECT * from adresler;
