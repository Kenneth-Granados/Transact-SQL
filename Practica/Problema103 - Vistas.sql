USE Practica;
GO

if object_id('Inscriptos') is not null  
  drop table Inscriptos;
 if object_id('Socios') is not null  
  drop table Socios;
 if object_id('Profesores') is not null  
  drop table Profesores; 
 if object_id('Cursos') is not null  
  drop table Cursos;
GO
 create table Socios(
  documento char(8) not null,
  nombre varchar(40),
  domicilio varchar(30),
  constraint PK_Socios_documento
   primary key (documento)
 );

 create table Profesores(
  documento char(8) not null,
  nombre varchar(40),
  domicilio varchar(30),
  constraint PK_Profesores_documento
   primary key (documento)
 );

 create table Cursos(
  numero tinyint identity,
  deporte varchar(20),
  dia varchar(15),
   constraint CK_Inscriptos_dia check (dia in('lunes','martes','miercoles','jueves','viernes','sabado')),
  documentoprofesor char(8),
  constraint PK_Cursos_numero
   primary key (numero),
 );

 create table Inscriptos(
  documentosocio char(8) not null,
  numero tinyint not null,
  matricula char(1),
  constraint CK_Inscriptos_matricula check (matricula in('s','n')),
  constraint PK_Inscriptos_documento_numero
   primary key (documentosocio,numero)
 );
 GO
--2- Ingrese algunos registros para todas las tablas:
 insert into Socios values('30000000','Fabian Fuentes','Caseros 987');
 insert into Socios values('31111111','Gaston Garcia','Guemes 65');
 insert into Socios values('32222222','Hector Huerta','Sucre 534');
 insert into Socios values('33333333','Ines Irala','Bulnes 345');

 insert into Profesores values('22222222','Ana Acosta','Avellaneda 231');
 insert into Profesores values('23333333','Carlos Caseres','Colon 245');
 insert into Profesores values('24444444','Daniel Duarte','Sarmiento 987');
 insert into Profesores values('25555555','Esteban Lopez','Sucre 1204');

 insert into Cursos values('tenis','lunes','22222222');
 insert into Cursos values('tenis','martes','22222222');
 insert into Cursos values('natacion','miercoles','22222222');
 insert into Cursos values('natacion','jueves','23333333');
 insert into Cursos values('natacion','viernes','23333333');
 insert into Cursos values('futbol','sabado','24444444');
 insert into Cursos values('futbol','lunes','24444444');
 insert into Cursos values('basquet','martes','24444444');

 insert into Inscriptos values('30000000',1,'s');
 insert into Inscriptos values('30000000',3,'n');
 insert into Inscriptos values('30000000',6,null);
 insert into Inscriptos values('31111111',1,'s');
 insert into Inscriptos values('31111111',4,'s');
 insert into Inscriptos values('32222222',8,'s');
 GO
--3- Elimine la vista "vista_club" si existe:
 if object_id('Vista_Club') is not null drop view Vista_Club;
--4- Cree una vista en la que aparezca el nombre y documento del socio, el deporte, el día y el nombre 
--del profesor.
 GO
CREATE VIEW Vista_Club AS
SELECT s.documento AS docSocio,s.nombre AS Socio,c.deporte,c.dia,p.nombre AS Profesor,i.matricula FROM Socios AS s
FULL JOIN Inscriptos AS i ON s.documento = i.documentosocio
FULL JOIN Cursos AS c ON c.numero = i.numero
FULL JOIN Profesores AS p ON p.documento = c.documentoprofesor;
GO
--5- Muestre la información contenida en la vista.
SELECT * FROM Vista_Club;
GO
--6- Realice una consulta a la vista donde muestre la cantidad de Socios Inscriptos en cada deporte 
--ordenados por cantidad.
SELECT deporte,dia,COUNT(Socio) AS Cantidad FROM Vista_Club
WHERE deporte IS NOT NULL
GROUP BY deporte,dia
ORDER BY Cantidad
GO
--7- Muestre (consultando la vista) los Cursos (deporte y día) para los cuales no hay Inscriptos.
SELECT deporte,dia FROM Vista_Club
WHERE deporte IS NOT NULL AND Socio IS NOT NULL
GO
--8- Muestre los nombres de los Socios que no se han inscripto en ningún curso (consultando la vista)
SELECT Socio FROM Vista_Club
WHERE deporte IS NOT NULL AND Socio IS NOT NULL
GO
--9- Muestre (consultando la vista) los Profesores que no tienen asignado ningún deporte aún.
SELECT Profesor FROM Vista_Club
WHERE deporte IS NOT NULL AND Profesor IS NOT NULL
GO
--10- Muestre (consultando la vista) el nombre y documento de los Socios que deben matrículas.
SELECT Socio,docSocio FROM Vista_Club
WHERE deporte IS NOT NULL AND matricula <> 's'
GO
--11- Consulte la vista y muestre los nombres de los Profesores y los días en que asisten al club para 
--dictar sus clases.
SELECT DISTINCT Profesor,dia FROM Vista_Club
WHERE Profesor IS NOT NULL 
GO
--12- Muestre la misma información anterior pero ordenada por día.
SELECT DISTINCT Profesor,dia FROM Vista_Club
WHERE Profesor IS NOT NULL 
ORDER BY dia
GO
--13- Muestre todos los Socios que son compañeros en tenis los lunes.
SELECT Socio FROM Vista_Club
WHERE deporte LIKE 'tenis' AND dia = 'lunes'
GO
--14- Elimine la vista "vista_Inscriptos" si existe y créela para que muestre la cantidad de 
--Inscriptos por curso, incluyendo el número del curso, el nombre del deporte y el día.
if object_id('Vista_Inscriptos') is not null drop view Vista_Inscriptos;
GO

CREATE VIEW Vista_Inscriptos AS
SELECT c.deporte,c.dia,(
SELECT COUNT(*) FROM Inscriptos AS i 
WHERE i.numero=c.numero) AS cantidad
FROM Cursos AS c
GO
--15- Consulte la vista:
 select *from vista_Inscriptos;
GO
