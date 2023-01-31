USE Practica;

IF OBJECT_ID('Empleados') IS NOT NULL
DROP TABLE Empleados;
GO

CREATE TABLE Empleados(
Nombre VARCHAR(40) NOT NULL,
Apellido VARCHAR(40) NOT NULL,
Documento CHAR(8),
FechaNacimiento DATETIME,
FechaIngreso DATETIME,
Sueldo DECIMAL(6,2),
PRIMARY KEY(Documento)
);GO
SET DATEFORMAT ymd;

INSERT INTO Empleados
VALUES ('Ana','Acosta','22222222','1970/10/10','1995/05/05',228.50);
INSERT INTO Empleados
VALUES ('Carlos','Caseres','25555555','1978/02/06','1998/05/05',309);
INSERT INTO Empleados
VALUES ('Francisco','Garcia','26666666','1978/10/15','1998/10/02',250.68);
INSERT INTO Empleados
VALUES ('Gabriela','Garcia','30000000','1985/10/25','2000/12/22',300.25);
INSERT INTO Empleados
VALUES ('Luis','Lopez','31111111','1987/02/10','2000/08/21',350.98);

SELECT CONCAT(Nombre,' ',UPPER(Apellido)) AS NombreCompleto,'DNI Nº: '+Documento AS Identificador,
'$ '+ STR(Sueldo,7,2) AS Sueldo
FROM Empleados;
SELECT CEILING(Sueldo) FROM Empleados;
SELECT Nombre,Apellido FROM Empleados
WHERE DATENAME(MONTH,FechaNacimiento)='Octubre'
SELECT Nombre,Apellido FROM Empleados
WHERE DATEPART(YEAR,FechaIngreso)=2000