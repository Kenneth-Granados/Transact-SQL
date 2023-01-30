USE Practica;

IF OBJECT_ID('Usuarios') IS NOT NULL
DROP TABLE Usuarios;
GO

CREATE TABLE Usuarios(
Nombre VARCHAR(30),
Clave VARCHAR(10)
);
GO

EXECUTE sp_tables @table_owner='dbo';
EXECUTE sp_columns Usuarios;
GO
