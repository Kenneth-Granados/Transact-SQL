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
--4- Se necesita un listado de todos los Socios que incluya nombre y domicilio, la cantidad de 
--deportes a los cuales se ha inscripto, empleando subconsulta.
--4 registros.
SELECT s.nombre,s.domicilio,(SELECT COUNT(*) FROM Inscriptos AS i
WHERE i.numerosocio = s.numero) AS 'cantidad deportes inscripto'
FROM Socios AS s;
GO
--5- Se necesita el nombre de todos los Socios, el total de cuotas que debe pagar (10 por cada 
--deporte) y el total de cuotas pagas, empleando subconsulta.
--4 registros.
SELECT s.nombre,(SELECT COUNT(i.cuotas) * 10 FROM Inscriptos AS i
WHERE i.numerosocio = s.numero) AS Total, (SELECT SUM(i.cuotas) FROM Inscriptos AS i
WHERE i.numerosocio = s.numero AND i.cuotas > 0) AS TotalPagadas
FROM Socios AS s;
GO
--6- Obtenga la misma salida anterior empleando join.
SELECT s.nombre, COUNT(i.cuotas) * 10 AS TOTAL, SUM(i.cuotas) AS TOTALPAGADAS
FROM Socios AS s INNER JOIN Inscriptos AS i ON i.numerosocio = s.numero
GROUP BY s.nombre;
GO