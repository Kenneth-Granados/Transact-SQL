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
primary key (codigo) );
GO
--3- Ingrese algunos registros para ambas tablas: 
insert into Provincias (nombre) values('Cordoba');
insert into Provincias (nombre) values('Santa Fe');
insert into Provincias (nombre) values('Corrientes');
insert into Clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
insert into Clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
insert into Clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
insert into Clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
insert into Clientes values ('Gomez Ines','San Martin 666','Santa Fe',2); 
insert into Clientes values ('Torres Fabiola','Alem 777','La Plata',4);
insert into Clientes values ('Garcia Luis','Sucre 475','Santa Rosa',5);
GO
--3- Muestre todos los datos de los Clientes, incluido el nombre de la provincia:
select c.nombre,domicilio,ciudad, p.nombre from Clientes as c 
left join Provincias as p on codigoprovincia = p.codigo;
GO
--4- Realice la misma consulta anterior pero alterando el orden de las tablas: 
select c.nombre,domicilio,ciudad, p.nombre from Provincias as p
left join Clientes as c on codigoprovincia = p.codigo;
GO
--5- Muestre solamente los Clientes de las Provincias que existen en "Provincias" (5 registros): 
select c.nombre,domicilio,ciudad, p.nombre from Clientes as c 
left join Provincias as p on codigoprovincia = p.codigo
where p.codigo is not null; 
GO
--6- Muestre todos los Clientes cuyo código de provincia NO existe en "Provincias" ordenados por nombre del cliente (2 registros):
select c.nombre,domicilio,ciudad, p.nombre from Clientes as c 
left join Provincias as p on codigoprovincia = p.codigo 
where p.codigo is null
order by c.nombre;
--7- Obtenga todos los datos de los Clientes de "Cordoba" (3 registros): 
select c.nombre,domicilio,ciudad, p.nombre from Clientes as c 
left join Provincias as p on codigoprovincia = p.codigo
where p.nombre='Cordoba';
GO