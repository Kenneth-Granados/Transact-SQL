USE Practica;

IF OBJECT_ID('Libros') IS NOT NULL
DROP TABLE Libros;
GO

CREATE TABLE Libros(
Codigo INT IDENTITY,
Titulo VARCHAR(40)NOT NULL,
Autor VARCHAR (30) DEFAULT 'DESCONOCIDO',
Editorial VARCHAR(20),
Precio DECIMAL(6,2),
PRIMARY KEY(Codigo)
);
GO

INSERT INTO Libros 
  VALUES('El aleph','Borges','Emece',25.33);
INSERT INTO Libros 
  VALUES('Java en 10 minutos','Mario Molina','Siglo XXI',50.65);
INSERT INTO Libros 
VALUES('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.95);
INSERT INTO Libros 
  VALUES('Alicia en el pais de las maravillas','Lewis Carroll','Planeta',15);
  GO

-- Recuperamos los registros ordenados por el título:
SELECT * FROM Libros
ORDER BY Titulo;
GO
-- Ordenamos los registros por el campo "precio", referenciando el campo por su posición en la lista de selección
SELECT Titulo,Autor,Precio
FROM Libros ORDER BY 3
GO

-- Los ordenamos por "editorial", de mayor a menor empleando "desc":
SELECT * FROM Libros
ORDER BY Editorial DESC;
GO
-- Ordenamos por dos campos:
 SELECT * FROM Libros
  ORDER BY Titulo,Editorial;
  GO
-- Ordenamos en distintos sentidos:
 SELECT * FROM Libros
  ORDER BY Titulo ASC, Editorial DESC;
GO
-- Ordenamos por un campo que no se lista en la selección:
 SELECT Titulo, Autor
  FROM Libros
  ORDER BY Precio;
  GO
-- Ordenamos por un valor calculado:
 SELECT Titulo, Autor, Editorial,
        Precio+(Precio*0.1) AS 'precio con descuento'
   FROM Libros
   ORDER BY 4;
