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
--SQL Server reconoce varios formatos de entrada de datos de tipo fecha. Para establecer el orden de las partes de una fecha (dia, mes y año) 
--empleamos "set dateformat". Estos son los formatos: -mdy: 4/15/96 (mes y día con 1 ó 2 dígitos y año con 2 ó 4 dígitos), 
---myd: 4/96/15, -dmy: 15/4/1996 -dym: 15/96/4, -ydm: 96/15/4, -ydm: 1996/15/4, Para ingresar una fecha con formato "día-mes-año",
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
-- Mostramos el título del libro y el año de edición:
SELECT Titulo, DATEPART (YEAR,Edicion) FROM libros;
-- Mostramos el título del libro y el nombre del mes de edición:
SELECT titulo, DATENAME (MONTH,Edicion) FROM libros;

-- Mostramos el título del libro y los años que tienen de editados:
SELECT Titulo, DATEDIFF(YEAR,Edicion,GETDATE()) FROM libros;

-- Muestre los títulos de los libros que se editaron el día 9, de cualquier mes de cualquier año:
 SELECT Titulo FROM Libros
  WHERE DATEPART(DAY,Edicion)=9;
