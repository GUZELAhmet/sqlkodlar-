CREATE table ogrenci (
	ogr_no INT,
ogr_isim VARCHAR(30),
	notlar REAL, 
	yas INT, 
	adres VARCHAR(50),
	kayit_tarih DATE);
	
	--VAROLAN TABLODAN YENI TABLO OLUSTURMA--
	CREATE TABLE org_notlari AS
	Select ogr_no notlar from ogrenci;
	
	select * from ogrenci;
	