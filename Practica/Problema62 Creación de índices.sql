USE Practica;
GO

if object_id('Alumnos') is not null drop table Alumnos;
create table Alumnos( 
legajo char(5) not null,
documento char(8) not null,
apellido varchar(30), 
nombre varchar(30),
notafinal decimal(4,2) ); 
GO
--2- Ingresamos algunos registros:
insert into Alumnos values ('A123','22222222','Perez','Patricia',5.50); 
insert into Alumnos values ('A234','23333333','Lopez','Ana',9); 
insert into Alumnos values ('A345','24444444','Garcia','Carlos',8.5);   
insert into Alumnos values ('A348','25555555','Perez','Daniela',7.85); 
insert into Alumnos values ('A457','26666666','Perez','Fabian',3.2);    
insert into Alumnos values ('A589','27777777','Gomez','Gaston',6.90);
GO
--3- Intente crear un índice agrupado único para el campo "apellido".
CREATE UNIQUE CLUSTERED INDEX I_Alumnos_apellido
ON Alumnos(apellido);
--No lo permite porque hay valores duplicados.
GO
--4- Cree un índice agrupado, no único, para el campo "apellido".
CREATE CLUSTERED INDEX I_Alumnos_apellido
ON Alumnos(apellido);
GO
--5- Intente establecer una restricción "primary key" al campo "legajo" especificando que cree un índice agrupado.
ALTER TABLE Alumnos
ADD CONSTRAINT PK_Alumnos_Legajo
PRIMARY KEY CLUSTERED (legajo);
--No lo permite porque ya existe un índice agrupado y solamente puede haber uno por tabla. 
GO
--6- Establezca la restricción "primary key" al campo "legajo" especificando que cree un índice NO agrupado.
ALTER TABLE Alumnos
ADD CONSTRAINT PK_Alumnos_Legajo
PRIMARY KEY NONCLUSTERED (legajo);
GO
--7- Vea los índices de "alumnos": exec sp_helpindex alumnos; 2 índices: uno "I_alumnos_apellido", agrupado, con "apellido" y otro "PK_alumnos_legajo",
--no agrupado, unique, con "legajo" que se creó automáticamente al crear la restricción "primary key".
EXEC sp_helpindex Alumnos;
GO
--8- Analice la información que muestra "sp_helpconstraint" En la columna "constraint_type" aparece "PRIMARY KEY" y entre paréntesis, el tipo de índice creado.
EXEC sp_helpconstraint Alumnos;
GO
--9- Cree un índice unique no agrupado para el campo "documento".
CREATE UNIQUE NONCLUSTERED INDEX I_Alumnos_Documento
ON Alumnos(documento);
GO
--10- Intente ingresar un alumno con documento duplicado. 
insert into Alumnos values ('A589E','27777777','Goméz','Gastón',6.90);
--No lo permite.
GO
--11- Veamos los indices de "alumnos". Aparecen 3 filas, uno por cada índice.
EXEC sp_helpindex Alumnos;
GO
--12- Cree un índice compuesto para el campo "apellido" y "nombre". Se creará uno no agrupado porque no 
--especificamos el tipo, además, ya existe uno agrupado y solamente puede haber uno por tabla. 
CREATE INDEX I_Alumnos_ApellidoNombre
ON Alumnos (apellido,nombre);
GO
--13- Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados para "alumnos": 
select name from sysindexes where name like '%Alumnos%'; --4 índices. 
GO
--14- Cree una restricción unique para el campo "documento".
ALTER TABLE Alumnos
ADD CONSTRAINT UQ_Alumnos_Documento
UNIQUE (documento);
GO
--15- Vea la información de "sp_helpconstraint". 
EXEC sp_helpconstraint Alumnos;
GO
--16- Vea los índices de "alumnos". Aparecen 5 filas, uno por cada índice. 
EXEC sp_helpindex Alumnos;
GO
--17- Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados para "alumnos":
select name from sysindexes where name like '%Alumnos%'; --5 índices. 
GO
--18- Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados por usted:
select name from sysindexes where name like 'I_%'; --3 índices. Recuerde que los índices que crea SQL Server
--automáticamente al agregarse una restricción "primary" o "unique" no comienzan con "I_".