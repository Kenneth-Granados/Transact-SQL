 USE Practica;
 IF OBJECT_ID('Visitas') IS NOT NULL
  DROP TABLE Visitas;
GO

CREATE TABLE Visitas (
  Numero INT IDENTITY,
  Nombre VARCHAR(30) DEFAULT 'Anonimo',
  Mail VARCHAR(50),
  Pais VARCHAR (20),
  Fecha DATETIME,
  PRIMARY KEY(numero)
);
GO
                       
SET DATEFORMAT ymd;

INSERT INTO Visitas (Nombre,Mail,Pais,Fecha)
  VALUES ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10');
INSERT INTO Visitas (Nombre,Mail,Pais,Fecha)
  VALUES ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30');
INSERT INTO Visitas (Nombre,Mail,Pais,Fecha)
  VALUES ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45');
INSERT INTO Visitas (Nombre,Mail,Pais,Fecha)
  VALUES ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15');
INSERT INTO Visitas (Nombre,Mail,Pais,Fecha)
  VALUES ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45');
INSERT INTO Visitas (Nombre,Mail,Pais,Fecha)
  VALUES ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-12 16:20');
INSERT INTO Visitas (Nombre,Mail,Pais,Fecha)
  VALUES ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25');
  GO

SELECT * FROM Visitas
ORDER BY Fecha DESC;

SELECT Nombre,Pais,DATENAME(MONTH,Fecha) AS Mes FROM Visitas
ORDER BY Pais ASC, Mes DESC;

SELECT Pais,DATENAME(MONTH,Fecha) AS Mes,DATENAME(DAY,Fecha) AS Dia,DATEPART(YEAR,Fecha) AS Anios,
DATEPART(HOUR,Fecha) AS Hora, DATENAME(YEAR,Fecha) AS Prueba FROM Visitas
ORDER BY Mes,Dia,Hora;

SELECT Mail,Pais FROM Visitas
WHERE DATENAME(MONTH,Fecha)='Octubre'
ORDER BY Pais;
