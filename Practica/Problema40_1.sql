USE Practica;

if object_id('ventas') is not null
  drop table ventas;

 create table ventas(
  numero int identity,
  montocompra decimal(6,2),
  tipopago char(1),--c=contado, t=tarjeta
  vendedor varchar(30),
  primary key (numero)
 );
GO

 insert into ventas
  values(100.50,'c','Marisa Perez');
 insert into ventas
  values(200,'c','Marisa Perez');
 insert into ventas
  values(50,'t','Juan Lopez');
 insert into ventas
  values(220,'c','Juan Lopez');
 insert into ventas
  values(150,'t','Marisa Perez');
 insert into ventas
  values(550.80,'c','Marisa Perez');
 insert into ventas
  values(300,'t','Juan Lopez');
 insert into ventas
  values(25,'c','Marisa Perez');
GO
--4- Agrupe por "tipopago" y "vendedor" y cuente la cantidad empleando "rollup".
--Las agrupaciones de resumen son las siguientes:
--- vendedor (tipopago seteado a "null"), 2 filas y
--- total (todos los campos seteados a "null"), 1 fila
SELECT tipopago,vendedor, COUNT(*) FROM ventas
GROUP BY tipopago,vendedor
WITH ROLLUP;
--5- Agrupe por "tipopago" y "vendedor" y cuente la cantidad empleando "cube".
--Las agrupaciones de resumen son las siguientes:
--- vendedor (tipopago seteado a "null"), 2 filas,
--- total (todos los campos seteados a "null"), 1 fila y
--- tipopago (vendedor seteado a "null"), 2 filas.
SELECT tipopago,vendedor, COUNT(*) FROM ventas
GROUP BY tipopago,vendedor
WITH CUBE;