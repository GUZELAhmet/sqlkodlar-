INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
--Parent tabloda olmayan id ile child tabloya ekleme yapamayiz (yukardakini yazdirmak istedik izin vermedi)
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');

--çalışanlar id ile adresler tablosundaki adres id ile eşleşenlere bak
select * from calisanlar, adresler where calisanlar.id=adresler.adres_id;


DRop table calisanlar;
--parent tabloyu silmek istediğimizde primary key olan tabloyu silmek istediğimizde
--silmez öce foreing key olan tabloyu silmek gerekir.


delete from calisanlar where id='10002';
-- child tableda  bağlantılı olan bir satır olduğu için silmez
--önce adresler tablosundaki id 10002 olan satırı silmemiz gerekir

delete from adresler where adres_id='10002'



Drop table calisanlar;

--on DELETE CASCADE--
-- her defasında önce child tablodaki verileri simek yerine 
--on delete cascade silme özelliğini aktif hale getirebilirz
--bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmamız yeterlidir

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);
INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from notlar;

delete from notlar where talebe_id='123';
delete from talebeler where id='126';

delete from talebeler;


drop table talebeler cascade
--parent tabloyu silmek kladırmak istersek sonuna cascade yazmamız gerrekir



-- talebeler tablosundaki isim sutununa not null kısıtlamsı ekleyiniz ve ver
--veri tipini varchar(30) olarak değiştiriniz
alter table talebeler
alter column isim type varchar(30),
alter column isim set not null;


-- talebeler tablosundaki yazılı notu 60 dan büyük olan rakam girilebilsin

alter table talebeler
Add constraint sinir Check (yazili_notu>60);

insert into talebeler values (128,'mustaf can', 'hasan ',45);
--yukarda 60'i sinir olarak belirledigimiz icin bunu eklemedi

create table ogrenciler(
id int, 
isim varchar(45),
adres varchar(100),
sinav_notu int
);
Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenciler;
select * from ogrenci_adres;

--tablodaki bir sütüna Pk ekleme

alter table ogrenciler
add primary key (id);

--ikinci yol ile PK oluşturma

alter table ogrenciler 
add constraint pk_id primary key(id);



--


--PK dan sonra FK ataması
alter table ogrenci_adres 
add foreign key (id) references ogrenciler;
--child tabloyu parent den oluşturduğumuz için sutun adı verilmedi



--pk yi constraint silme

alter table ogrenciler drop constraint pk_id;
önce FK silinmesi gerekir.

alter table ogrenci_adres drop constraint ogrenci_adres_id_fkey;

--yazılı notu 85 den buyuk  talebe bilgilerini getşrin
Select * from talebeler where yazili_notu>85;

--ismi Mustafa Bak olan Talebenin tüm bilgilerini getirin
select * from talebeler Where isim='Mustafa Bak';


--select komutunda between koşulu
--belirtiğimiz iki veri arasıdaki verileri listeler 
--between de belirtiğimiz değerlerde listelemeye dahildir


create table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

--and (ve) belirtilen şartların her ikiside gerçeleşiyorsa o kayıtlistelenir
--bir tanesi gerçekleşmesse listelenmez
--select * from matematik where sinav>50 and sinav2>50

select * from personel;

-- id si 1003 ile 1005 arasında olan personel bilgisini listeleyiniz
select * from personel where id between '1003' and '1005';


-- ikinci yolu 
select *from personel where id>='1003' and id<='1005';

--Derya Soylu ile Yavuz Bal arsındaki personel bilgisini listeleyiniz

select* from personel where isim between 'Derya Soylu' and 'Yavuz Bal';
--alfabetik sıralamaya göre getirir


--mmaşı 70000 veya ismi Sena olanapersoneli listele

select * from personel where maas=70000 or isim='Sena Beyaz';

--IN : Birden fazla mantıksal ifade ile tanımlayabileceğimiz durumları tek komutta yazabilme imkanı verir
--Farklı sütunlar için IN kullanılamaz


--id si 1001,1002 ve 1004 olan personelin bilgilerini listele 

Select * from personel Where id in('1001','1002','1004');


-- maaşı sadece 70000 ve 100000 olan personeli listele
Select * from personel Where maas in(100000,70000);

/*
SELECT - LIKE koşulu
LIKE : Sorgulama yaparken belirli kalıp ifadeleri kullanabilmemizi sağlar
ILIKE : Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir
LIKE : ~~
ILIKE : ~~*
NOT LIKE : !~~
NOT ILIKE :!~~*
% --> 0 veya daha fazla karakteri belirtir.
_ --> Tek bir karakteri belirtir
*/
-- ismi a harfile başlayan personeli listele

select * from personel where isim like 'A%';

--ismi t harfi ile biten personeli listele
 select * from personel where isim like '%t';


--isminin ikinci harfi e olan personeli listeleyiniz
select * from personel where isim like '_e%';

