USE Practica;
GO

 if object_id('Facturas') is not null
  drop table Facturas;
 if object_id('Clientes') is not null
  drop table Clientes;
GO

 create table Clientes(
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  primary key(codigo)
 );

 create table Facturas(
  numero int not null,
  fecha datetime,
  codigocliente int not null,
  total decimal(6,2),
  primary key(numero),
  constraint FK_Facturas_cliente
   foreign key (codigocliente)
   references Clientes(codigo)
   on update cascade
 );
GO

 insert into Clientes values('Juan Lopez','Colon 123');
 insert into Clientes values('Luis Torres','Sucre 987');
 insert into Clientes values('Ana Garcia','Sarmiento 576');
 insert into Clientes values('Susana Molina','San Martin 555');

 insert into Facturas values(1200,'2007-01-15',1,300);
 insert into Facturas values(1201,'2007-01-15',2,550);
 insert into Facturas values(1202,'2007-01-15',3,150);
 insert into Facturas values(1300,'2007-01-20',1,350);
 insert into Facturas values(1310,'2007-01-22',3,100);

--4- El comercio necesita una tabla llamada "Clientespref" en la cual quiere almacenar el nombre y 
--domicilio de aquellos Clientes que han comprado hasta el momento más de 500 pesos en mercaderías. 
--Elimine la tabla si existe y créela con esos 2 campos:
 if object_id ('ClientesPref') is not null
  drop table ClientesPref;
  GO
 create table ClientesPref(
  nombre varchar(30),
  domicilio varchar(30)
 );

--5- Ingrese los registros en la tabla "Clientespref" seleccionando registros de la tabla "Clientes" y 
--"Facturas".
insert into clientespref
select nombre,domicilio from clientes 
where codigo in (select codigocliente from clientes as c
join facturas as f on codigocliente=codigo
group by codigocliente
having sum(total)>500);
--6- Vea los registros de "Clientespref":
select * from Clientespref;