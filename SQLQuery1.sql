
--MUZE ISLETIM SISTEMI SQL SORGULARI

--SORGU1: MuzeYonetimSistemi veritabanýnýn recovery modelini bulan sql sorgusunu yazýnýz.

SELECT DATABASEPROPERTYEX ('MuzeYonetimSistemi','recovery')

--SORGU2: MuzeYonetimSistemi veritabanýnýn recovery modelinde deðiþiklik yapan sql sorgusunu yazýnýz.

ALTER DATABASE MuzeYonetimSistemi SET RECOVERY FULL

--SORGU3: tblEserler tablosundan üstten 5 satýrý gösteren sql sorgusunu yazýnýz.

SELECT TOP 5*
FROM tblEserler
ORDER BY NEWID()

--SORGU4: tblEserler tablosundan eserTarih'den eserAd'a doðru sýralayan ve eserUlke sütununu gösteren sql sorgusunu yazýnýz.

SELECT eserUlke, eserTarih, eserAd
FROM tblEserler
ORDER BY eserTarih, eserAd ASC

--SORGU5: tblCalisan tablosundan maaþý 2500 ile 5000 arasýnda olan kiþilerin Isim, SoyIsim bilgilerini gösterip 
--maaþý enbüyükten, maaþý küçüðe doðru sýralayan sql sorgusunu yazýnýz.

SELECT Isim, SoyIsim, Maas, Gorev
FROM tblCalisan
WHERE Maas BETWEEN 2500 AND 5000
ORDER BY Maas DESC

--SORGU6: tblBilet tablosundan biletKod ve biletTur bilgilerini gösteren sql sorgusunu yazýnýz.

SELECT biletKod , biletTur
FROM tblBilet
WHERE biletFiyat is not null

--SORGU7: tblEserler tablosundan üretildiði ülke USA olan ve eser türü uçak olanlarý
-- gösteren sql sorgusunu yazýnýz.

SELECT eserUlke, eserTur
FROM tblEserler
WHERE eserUlke='USA' and eserTur='UÇAK'

--SORGU8: MusteriBilet adýnda bir view oluþturan sql sorgusunu yazýnýz.
CREATE VIEW vwMusteriBilet
AS
SELECT biletKod FROM tblBilet
INNER JOIN tblMusteri ON tblBilet.biletKod = tblMusteri.biletKod


--SORGU9: tblCalisan tablosunda Adres bilgilerini güncelleyecek olan sql sorgusunu yazýnýz.

SELECT * 
FROM tblCalisan
UPDATE tblCalisan
SET ADRES = 'ÝSTANBUL' , MuzeTatilGunu = 'PAZAR'
WHERE ADRES is not null AND MuzeTatilGunu is not null


--SORGU10: tblMusteri tablosuna musteriSira, musteriAd, musteriSoyAd, musteriTel, musteriYas sütunlarýna sql sorgusu ile veri
--giriþi yapýnýz.

INSERT INTO
tblMusteri(musteriSira, musreriAd, musteriSoyAd, musteriTel, musteriYas)
VALUES ('11','VELÝ','KESER','232323','45')
SELECT *
FROM tblMusteri

--SORGU11: PROCDENEME adýnda bir procedure oluþturan sql sorgusunu yazýnýz.

CREATE PROCEDURE PROCDENEME
@musteriAd nvarchar(50), @musteriSoyAd nvarchar(50), @musteriYas nvarchar(50)
AS
SELECT*
FROM tblMusteri
WHERE musreriAd=@musteriAd AND musteriSoyAd=@musteriSoyAd AND musteriYas=@musteriYas
EXEC PROCDENEME'AHMET','GUL','27'

--SORGU12: Hata satýrý, sayýsý, önemi, durumu ve mesajý veren sql sorgusunu yazýnýz.

BEGIN TRY
SELECT sonuc=0/3
End try

BEGIN CATCH
	SELECT
		[Hatanýn_Satiri]=ERROR_LINE(),
		[Hatanýn_Sayisi]=ERROR_NUMBER(),
		[Hatanýn_Durumu]=ERROR_STATE(),
		[Hatanýn_Önemi]=ERROR_SEVERITY(),
		[Hatanýn_Mesajý]=ERROR_MESSAGE()
END CATCH



--SORGU14: tblCalisan tablosunda maaþý 4000'den fazla olup olmadýðýný kontrol eden, maaþý 4000 den fazla olan çalýþan varsa 
-- "maaþý 4000'den yüksek çalýþan bulunmaktadýr" þeklinde yazan, yoksa 'Maaþý 4000 den yüksek çalýþan yoktur' yazdýran sql sorgusunu yazýnýz.

IF EXISTS (SELECT * FROM tblCalisan WHERE Maas>4000)
PRINT 'Maaþý 4000 den yüksekçalýþan bulunmaktadýr.'
ELSE 
PRINT 'Maaþý 4000 den yüksek çalýþan yoktur.'

--SORGU15: En yüksek bilet fiyatýný gösteren sql sorgusunu yazýnýz.

SELECT MAX(biletFiyat) AS enYuksek FROM tblBilet

--SORGU16: En düþük bilet fiyatýný gösteren sql sorgusunu yazýnýz.

SELECT MIN(biletFiyat) AS enDusuk FROM tblBilet

select * from vwMusteriBilet