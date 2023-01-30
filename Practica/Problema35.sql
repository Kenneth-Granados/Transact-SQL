USE Practica;

 if object_id('medicamentos') is not null
  drop table medicamentos;
SET DATEFORMAT ymd;
GO

create table medicamentos(
codigo int identity,
nombre varchar(20),
laboratorio varchar(20),
precio decimal(6,2),
cantidad tinyint,
fechavencimiento datetime not null,
numerolote int default null,
primary key(codigo)
);
GO

insert into medicamentos
values('Sertal','Roche',5.2,1,'2015-02-01',null);
insert into medicamentos 
values('Buscapina','Roche',4.10,3,'2016-03-01',null);
insert into medicamentos 
values('Amoxidal 500','Bayer',15.60,100,'2017-05-01',null);
insert into medicamentos
values('Paracetamol 500','Bago',1.90,20,'2018-02-01',null);
insert into medicamentos 
values('Bayaspirina',null,2.10,null,'2019-12-01',null); 
insert into medicamentos 
values('Amoxidal jarabe','Bayer',null,250,'2019-12-15',null); 
GO

--4- Muestre la cantidad de registros empleando la función "count(*)" (6 registros)
SELECT COUNT_BIG(*) FROM medicamentos
--5- Cuente la cantidad de medicamentos que tienen laboratorio conocido (5 registros)
SELECT COUNT_BIG(laboratorio) FROM medicamentos
--6- Cuente la cantidad de medicamentos que tienen precio distinto a "null" y que tienen cantidad 
--distinto a "null", disponer alias para las columnas.
SELECT COUNT_BIG(precio) AS PRECIO,COUNT_BIG(cantidad) AS CANTIDAD FROM medicamentos
--7- Cuente la cantidad de remedios con precio conocido, cuyo laboratorio comience con "B" (2 
--registros)
SELECT COUNT_BIG(precio) AS PRECIO FROM medicamentos
WHERE laboratorio LIKE 'B%'
--8- Cuente la cantidad de medicamentos con número de lote distitno de "null" (0 registros)
SELECT COUNT_BIG(numerolote) FROM medicamentos