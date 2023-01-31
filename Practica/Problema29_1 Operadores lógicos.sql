USE Practica;

IF OBJECT_ID('Medicamentos') IS NOT NULL
DROP TABLE Medicamentos;
GO

CREATE TABLE Medicamentos(
Codigo INT IDENTITY,
Nombre VARCHAR(20),
Laboratorio VARCHAR(20),
Precio DECIMAL(5,2),
Cantidad TINYINT,
PRIMARY KEY (codigo)
);
GO

INSERT INTO Medicamentos
VALUES('Sertal','Roche',5.2,100);
INSERT INTO Medicamentos
VALUES('Buscapina','Roche',4.10,200);
INSERT INTO Medicamentos
VALUES('Amoxidal 500','Bayer',15.60,100);
INSERT INTO Medicamentos
VALUES('Paracetamol 500','Bago',1.90,200);
INSERT INTO Medicamentos
VALUES('Bayaspirina','Bayer',2.10,150); 
INSERT INTO Medicamentos
VALUES('Amoxidal jarabe','Bayer',5.10,250); 
GO

SELECT Codigo,Nombre FROM Medicamentos
WHERE (Laboratorio='Roche') AND Precio<5;

SELECT * FROM Medicamentos
WHERE (Laboratorio='Roche') OR Precio<5;

SELECT * FROM Medicamentos
WHERE NOT Laboratorio='BAYER' AND Cantidad=100;

SELECT * FROM Medicamentos
WHERE Laboratorio='BAYER' AND NOT Cantidad=100;

DELETE FROM Medicamentos
WHERE Laboratorio='BAYER' AND Precio>10;

UPDATE Medicamentos
SET Cantidad=200
WHERE (Laboratorio='Roche') AND Precio>5;

DELETE FROM Medicamentos
WHERE Laboratorio='BAYER' OR Precio<3;

