USE Practica;

IF OBJECT_ID('libros') IS NOT NULL
DROP TABLE libros;
GO

CREATE TABLE Libros(
Titulo VARCHAR(40)NOT NULL,
Autor VARCHAR (30) DEFAULT 'DESCONOCIDO',
Editorial VARCHAR(20),
Edicion DATETIME,
Precio DECIMAL(6,2)
);
GO

--
--SQL Server reconoce varios formatos de entrada de datos de tipo fecha. Para establecer el orden de las partes de una fecha (dia, mes y a�o) 
--empleamos "set dateformat". Estos son los formatos: -mdy: 4/15/96 (mes y d�a con 1 � 2 d�gitos y a�o con 2 � 4 d�gitos), 
---myd: 4/96/15, -dmy: 15/4/1996 -dym: 15/96/4, -ydm: 96/15/4, -ydm: 1996/15/4, Para ingresar una fecha con formato "d�a-mes-a�o",
--tipeamos: set dateformat dmy; El formato por defecto es "mdy".
--

SET DATEFORMAT ymd;
INSERT INTO Libros 
  VALUES('El aleph','Borges','Emece','1980/10/10',25.33);
INSERT INTO Libros 
  VALUES('Java en 10 minutos','Mario Molina','Siglo XXI','2000/05/05',50.65);
INSERT INTO Libros 
VALUES('Alicia en el pais de las maravillas','Lewis Carroll','Emece','2000/08/09',19.95);
INSERT INTO Libros 
  VALUES('Aprenda PHP','Mario Molina','Siglo XXI','2000/02/04',45);
-- Mostramos el t�tulo del libro y el a�o de edici�n:
SELECT Titulo, DATEPART (YEAR,Edicion) FROM libros;
-- Mostramos el t�tulo del libro y el nombre del mes de edici�n:
SELECT titulo, DATENAME (MONTH,Edicion) FROM libros;

-- Mostramos el t�tulo del libro y los a�os que tienen de editados:
SELECT Titulo, DATEDIFF(YEAR,Edicion,GETDATE()) FROM libros;

-- Muestre los t�tulos de los libros que se editaron el d�a 9, de cualquier mes de cualquier a�o:
 SELECT Titulo FROM Libros
  WHERE DATEPART(DAY,Edicion)=9;
