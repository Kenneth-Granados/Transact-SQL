USE Practica;

 if object_id('medicamentos') is not null
  drop table medicamentos;
GO

 create table medicamentos(
  codigo int identity,
  nombre varchar(20),
  laboratorio varchar(20),
  precio decimal(6,2),
  cantidad tinyint,
  fechavencimiento datetime not null,
  primary key(codigo)
 );
GO

 insert into medicamentos
  values('Sertal','Roche',5.2,1,'2015-02-01');
 insert into medicamentos 
  values('Buscapina','Roche',4.10,3,'2016-03-01');
 insert into medicamentos 
  values('Amoxidal 500','Bayer',15.60,100,'2017-05-01');
 insert into medicamentos
  values('Paracetamol 500','Bago',1.90,20,'2018-02-01');
 insert into medicamentos 
  values('Bayaspirina','Bayer',2.10,150,'2019-12-01'); 
 insert into medicamentos 
  values('Amoxidal jarabe','Bayer',5.10,250,'2020-10-01'); 
GO
--4- Recupere los nombres y precios de los medicamentos cuyo laboratorio sea "Bayer" o "Bago" 
--empleando el operador "in" (4 registros)
SELECT nombre,precio FROM medicamentos
WHERE laboratorio in ('Bayer','Bago')
GO
--5- Seleccione los remedios cuya cantidad se encuentre entre 1 y 5 empleando el operador "between" y 
--luego el operador "in" (2 registros):
SELECT nombre FROM medicamentos
WHERE cantidad BETWEEN 1 AND 5
SELECT nombre FROM medicamentos
WHERE cantidad in (1,2,3,4,5)