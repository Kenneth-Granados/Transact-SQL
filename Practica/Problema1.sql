USE Practica;

IF OBJECT_ID('Agenda') IS NOT NULL
DROP TABLE Agenda;
GO

CREATE TABLE Agenda(
Nombre VARCHAR(50),
Apellido VARCHAR(50),
Domicilio VARCHAR(60),
Telefono VARCHAR(12)

);
GO

EXECUTE sp_tables @table_owner='dbo';
EXECUTE sp_columns Agenda;