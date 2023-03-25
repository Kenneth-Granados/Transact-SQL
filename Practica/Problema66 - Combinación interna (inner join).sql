USE Practica;
GO

if (object_id('Clientes')) is not null drop table Clientes; 
if (object_id('Provincias')) is not null drop table Provincias;
GO
create table Clientes ( 
codigo int identity,
nombre varchar(30),
domicilio varchar(30),
ciudad varchar(20), 
codigoprovincia tinyint not null,
primary key(codigo) );

create table Provincias( 
codigo tinyint identity,
nombre varchar(20), 
primary key (codigo),
prueba UNIQUEIDENTIFIER DEFAULT NEWID() );
GO
--3- Ingrese algunos registros para ambas tablas:
insert into Provincias (nombre) values('Cordoba');
insert into Provincias (nombre) values('Santa Fe');
insert into Provincias (nombre) values('Corrientes'); 
insert into Clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
insert into Clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
insert into Clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
insert into Clientes values ('Perez Luis','Sarmiento 444','Rosario',2); 
insert into Clientes values ('Pereyra Lucas','San Martin 555','Cruz del Eje',1);
insert into Clientes values ('Gomez Ines','San Martin 666','Santa Fe',2); 
insert into Clientes values ('Torres Fabiola','Alem 777','Ibera',3);
GO

--4- Obtenga los datos de ambas tablas, usando alias: 
select c.nombre,domicilio,ciudad,p.nombre from Clientes as c
join Provincias as p on c.codigoprovincia=p.codigo; 
GO
--5- Obtenga la misma información anterior pero ordenada por nombre de provincia. 
SELECT c.nombre,domicilio,ciudad,p.nombre FROM Clientes AS c
JOIN Provincias AS p ON c.codigoprovincia=p.codigo
ORDER BY p.nombre;
GO
--6- Recupere los Clientes de la provincia "Santa Fe" (2 registros devueltos)
SELECT c.nombre,domicilio,ciudad,p.nombre AS Provincia FROM Clientes AS c
JOIN Provincias AS p ON c.codigoprovincia=p.codigo
WHERE p.nombre LIKE 'Santa Fe';
GO
---------------------------------------------------------------------
--EJECICIO 2
if (object_id('Inscriptos')) is not null drop table Inscriptos;
if (object_id('Inasistencias')) is not null drop table Inasistencias; 
create table Inscriptos( 
nombre varchar(30), 
documento char(8),
deporte varchar(15), 
matricula char(1), --'s'=paga 'n'=impaga 
primary key(documento,deporte) );
GO
create table Inasistencias( 
documento char(8), 
deporte varchar(15),
fecha datetime ); 
-- 2- Ingrese algunos registros para ambas tablas: 
insert into Inscriptos values('Juan Perez','22222222','tenis','s');
insert into Inscriptos values('Maria Lopez','23333333','tenis','s');
insert into Inscriptos values('Agustin Juarez','24444444','tenis','n');
insert into Inscriptos values('Marta Garcia','25555555','natacion','s');
insert into Inscriptos values('Juan Perez','22222222','natacion','s'); 
insert into Inscriptos values('Maria Lopez','23333333','natacion','n');
insert into Inasistencias values('22222222','tenis','2006-12-01'); 
insert into Inasistencias values('22222222','tenis','2006-12-08'); 
insert into Inasistencias values('23333333','tenis','2006-12-01'); 
insert into Inasistencias values('24444444','tenis','2006-12-08'); 
insert into Inasistencias values('22222222','natacion','2006-12-02');
insert into Inasistencias values('23333333','natacion','2006-12-02');
GO
--3- Muestre el nombre, el deporte y las fechas de Inasistencias, ordenado por nombre y deporte. Note que la condición 
--es compuesta porque para identificar los registros de la tabla "Inasistencias" necesitamos ambos campos.
SELECT i.nombre,ina.deporte,ina.fecha FROM Inscriptos AS i
JOIN Inasistencias AS ina ON i.deporte=ina.deporte AND i.documento=ina.documento
ORDER BY i.nombre,ina.deporte;
GO

--4- Obtenga el nombre, deporte y las fechas de Inasistencias de un determinado inscripto en un determinado deporte (3 registros)
SELECT i.nombre,ina.deporte,ina.fecha FROM Inscriptos AS i
JOIN Inasistencias AS ina ON i.deporte=ina.deporte AND i.documento=ina.documento
WHERE i.documento LIKE '22222222'
GO
--5- Obtenga el nombre, deporte y las fechas de Inasistencias de todos los Inscriptos que pagaron la matrícula(4 registros)
SELECT i.nombre,ina.deporte,ina.fecha FROM Inscriptos AS i
JOIN Inasistencias AS ina ON i.deporte=ina.deporte AND i.documento=ina.documento
WHERE i.matricula LIKE 's'
GO