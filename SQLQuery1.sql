
--MUZE ISLETIM SISTEMI SQL SORGULARI

--SORGU1: MuzeYonetimSistemi veritaban�n�n recovery modelini bulan sql sorgusunu yaz�n�z.

SELECT DATABASEPROPERTYEX ('MuzeYonetimSistemi','recovery')

--SORGU2: MuzeYonetimSistemi veritaban�n�n recovery modelinde de�i�iklik yapan sql sorgusunu yaz�n�z.

ALTER DATABASE MuzeYonetimSistemi SET RECOVERY FULL

--SORGU3: tblEserler tablosundan �stten 5 sat�r� g�steren sql sorgusunu yaz�n�z.

SELECT TOP 5*
FROM tblEserler
ORDER BY NEWID()

--SORGU4: tblEserler tablosundan eserTarih'den eserAd'a do�ru s�ralayan ve eserUlke s�tununu g�steren sql sorgusunu yaz�n�z.

SELECT eserUlke, eserTarih, eserAd
FROM tblEserler
ORDER BY eserTarih, eserAd ASC

--SORGU5: tblCalisan tablosundan maa�� 2500 ile 5000 aras�nda olan ki�ilerin Isim, SoyIsim bilgilerini g�sterip 
--maa�� enb�y�kten, maa�� k����e do�ru s�ralayan sql sorgusunu yaz�n�z.

SELECT Isim, SoyIsim, Maas, Gorev
FROM tblCalisan
WHERE Maas BETWEEN 2500 AND 5000
ORDER BY Maas DESC

--SORGU6: tblBilet tablosundan biletKod ve biletTur bilgilerini g�steren sql sorgusunu yaz�n�z.

SELECT biletKod , biletTur
FROM tblBilet
WHERE biletFiyat is not null

--SORGU7: tblEserler tablosundan �retildi�i �lke USA olan ve eser t�r� u�ak olanlar�
-- g�steren sql sorgusunu yaz�n�z.

SELECT eserUlke, eserTur
FROM tblEserler
WHERE eserUlke='USA' and eserTur='U�AK'

--SORGU8: MusteriBilet ad�nda bir view olu�turan sql sorgusunu yaz�n�z.
CREATE VIEW vwMusteriBilet
AS
SELECT biletKod FROM tblBilet
INNER JOIN tblMusteri ON tblBilet.biletKod = tblMusteri.biletKod


--SORGU9: tblCalisan tablosunda Adres bilgilerini g�ncelleyecek olan sql sorgusunu yaz�n�z.

SELECT * 
FROM tblCalisan
UPDATE tblCalisan
SET ADRES = '�STANBUL' , MuzeTatilGunu = 'PAZAR'
WHERE ADRES is not null AND MuzeTatilGunu is not null


--SORGU10: tblMusteri tablosuna musteriSira, musteriAd, musteriSoyAd, musteriTel, musteriYas s�tunlar�na sql sorgusu ile veri
--giri�i yap�n�z.

INSERT INTO
tblMusteri(musteriSira, musreriAd, musteriSoyAd, musteriTel, musteriYas)
VALUES ('11','VEL�','KESER','232323','45')
SELECT *
FROM tblMusteri

--SORGU11: PROCDENEME ad�nda bir procedure olu�turan sql sorgusunu yaz�n�z.

CREATE PROCEDURE PROCDENEME
@musteriAd nvarchar(50), @musteriSoyAd nvarchar(50), @musteriYas nvarchar(50)
AS
SELECT*
FROM tblMusteri
WHERE musreriAd=@musteriAd AND musteriSoyAd=@musteriSoyAd AND musteriYas=@musteriYas
EXEC PROCDENEME'AHMET','GUL','27'

--SORGU12: Hata sat�r�, say�s�, �nemi, durumu ve mesaj� veren sql sorgusunu yaz�n�z.

BEGIN TRY
SELECT sonuc=0/3
End try

BEGIN CATCH
	SELECT
		[Hatan�n_Satiri]=ERROR_LINE(),
		[Hatan�n_Sayisi]=ERROR_NUMBER(),
		[Hatan�n_Durumu]=ERROR_STATE(),
		[Hatan�n_�nemi]=ERROR_SEVERITY(),
		[Hatan�n_Mesaj�]=ERROR_MESSAGE()
END CATCH



--SORGU14: tblCalisan tablosunda maa�� 4000'den fazla olup olmad���n� kontrol eden, maa�� 4000 den fazla olan �al��an varsa 
-- "maa�� 4000'den y�ksek �al��an bulunmaktad�r" �eklinde yazan, yoksa 'Maa�� 4000 den y�ksek �al��an yoktur' yazd�ran sql sorgusunu yaz�n�z.

IF EXISTS (SELECT * FROM tblCalisan WHERE Maas>4000)
PRINT 'Maa�� 4000 den y�ksek�al��an bulunmaktad�r.'
ELSE 
PRINT 'Maa�� 4000 den y�ksek �al��an yoktur.'

--SORGU15: En y�ksek bilet fiyat�n� g�steren sql sorgusunu yaz�n�z.

SELECT MAX(biletFiyat) AS enYuksek FROM tblBilet

--SORGU16: En d���k bilet fiyat�n� g�steren sql sorgusunu yaz�n�z.

SELECT MIN(biletFiyat) AS enDusuk FROM tblBilet

select * from vwMusteriBilet