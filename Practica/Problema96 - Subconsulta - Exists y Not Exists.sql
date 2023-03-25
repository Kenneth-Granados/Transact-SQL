USE Practica;
GO

if object_id('Inscriptos') is not null
  drop table Inscriptos;
 if object_id('Socios') is not null
  drop table Socios;
GO
--2- Cree las tablas:
 create table Socios(
  numero int identity,
  documento char(8),
  nombre varchar(30),
  domicilio varchar(30),
  primary key (numero)
 );
 
 create table Inscriptos (
  numerosocio int not null,
  deporte varchar(20) not null,
  cuotas tinyint
  constraint CK_Inscriptos_cuotas
   check (cuotas>=0 and cuotas<=10)
  constraint DF_Inscriptos_cuotas default 0,
  primary key(numerosocio,deporte),
  constraint FK_Inscriptos_socio
   foreign key (numerosocio)
   references Socios(numero)
   on update cascade
   on delete cascade,
 );
 GO
--3- Ingrese algunos registros:
 insert into Socios values('23333333','Alberto Paredes','Colon 111');
 insert into Socios values('24444444','Carlos Conte','Sarmiento 755');
 insert into Socios values('25555555','Fabian Fuentes','Caseros 987');
 insert into Socios values('26666666','Hector Lopez','Sucre 344');

 insert into Inscriptos values(1,'tenis',1);
 insert into Inscriptos values(1,'basquet',2);
 insert into Inscriptos values(1,'natacion',1);
 insert into Inscriptos values(2,'tenis',9);
 insert into Inscriptos values(2,'natacion',1);
 insert into Inscriptos values(2,'basquet',default);
 insert into Inscriptos values(2,'futbol',2);
 insert into Inscriptos values(3,'tenis',8);
 insert into Inscriptos values(3,'basquet',9);
 insert into Inscriptos values(3,'natacion',0);
 insert into Inscriptos values(4,'basquet',10);
GO
--4- Emplee una subconsulta con el operador "exists" para devolver la lista de Socios que se 
--inscribieron en un determinado deporte.
--4 registros.
SELECT s.nombre, s.domicilio FROM Socios AS s
WHERE EXISTS (SELECT * FROM Inscriptos AS i
WHERE s.numero = i.numerosocio AND i.deporte LIKE 'basquet');
GO
--5- Busque los Socios que NO se han inscripto en un deporte determinado empleando "not exists".
--1 registro.
SELECT s.nombre, s.domicilio FROM Socios AS s
WHERE NOT EXISTS (SELECT * FROM Inscriptos AS i
WHERE s.numero = i.numerosocio AND i.deporte LIKE 'natacion');
GO
--6- Muestre todos los datos de los Socios que han pagado todas las cuotas.
--1 registro.
SELECT s.nombre, s.domicilio FROM Socios AS s
WHERE EXISTS (SELECT * FROM Inscriptos AS i
WHERE s.numero = i.numerosocio AND i.cuotas = 10);
GO