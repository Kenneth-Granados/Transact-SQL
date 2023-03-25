USE Practica;
GO

if object_id('Inscriptos') is not null
  drop table Inscriptos;
 if object_id('Socios') is not null
  drop table Socios;
 if object_id('Profesores') is not null
  drop table Profesores;
 if object_id('Deportes') is not null
  drop table Deportes;
GO
--2- Considere que:
--- un socio puede inscribirse en varios Deportes, pero no dos veces en el mismo.
--- un socio tiene un documento único y un número de socio único.
--- el documento del socio debe contener 8 dígitos.
--- un deporte debe tener asignado un profesor que exista en "Profesores" o "null" si aún no tiene un 
--instructor definido.
--- el campo "dia" de "Deportes" puede ser: lunes, martes, miercoles, jueves, viernes o sabado.
--- el campo "dia" de "Deportes" por defecto debe almacenar 'sabado'.
--- un profesor puede ser instructor de varios Deportes o puede no dictar ningún deporte.
--- un profesor no puede estar repetido en "Profesores".
--- el documento del profesor debe contener 8 dígitos.
--- un inscripto debe ser socio, un socio puede no estar inscripto en ningún deporte.
--- una inscripción debe tener un valor en socio existente en "Socios" y un deporte que exista en 
--"Deportes".
--- el campo "matricula" de "Inscriptos" debe aceptar solamente los caracteres 's' o 'n'.
GO
--3- Cree las tablas con las restricciones necesarias:
 create table Profesores(
  documento char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  constraint CK_Profesores_documento_patron check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  constraint PK_Profesores_documento
   primary key (documento)
 );

 create table Deportes(
  codigo tinyint identity,
  nombre varchar(20) not null,
  dia varchar(30)
   constraint DF_Deportes_dia default('sabado'),
  profesor char(8) FOREIGN KEY REFERENCES Profesores(documento),--documento del profesor
  constraint CK_Deportes_dia_lista check (dia in ('lunes','martes','miercoles','jueves','viernes','sabado')),
  constraint PK_Deportes_codigo
   primary key (codigo),
  --CONSTRAINT FK_Profesor_Deportes FOREIGN KEY (profesor) REFERENCES Profesores(documento)
 );

 create table Socios(
  numero int identity,
  documento char(8),
  nombre varchar(30),
  domicilio varchar(30),
  constraint CK_documento_patron check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  constraint PK_Socios_numero
   primary key nonclustered(numero),
  constraint UQ_Socios_documento
   unique clustered(documento)
 );

 create table Inscriptos(
  numerosocio int not null,
  codigodeporte tinyint,
  matricula char(1),
  constraint PK_Inscriptos_numerodeporte
   primary key clustered (numerosocio,codigodeporte),
  constraint FK_Inscriptos_deporte
   foreign key (codigodeporte)
   references Deportes(codigo)
   on update cascade,
  constraint FK_Inscriptos_Socios
   foreign key (numerosocio)
   references Socios(numero)
   on update cascade
   on delete cascade,
  constraint CK_matricula_valores check (matricula in ('s','n'))
);
GO
--4- Ingrese registros en "Profesores":
 insert into Profesores values('21111111','Andres Acosta','Avellaneda 111');
 insert into Profesores values('22222222','Betina Bustos','Bulnes 222');
 insert into Profesores values('23333333','Carlos Caseros','Colon 333');

--5- Ingrese registros en "Deportes". Ingrese el mismo día para distintos Deportes, un deporte sin día 
--confirmado, un deporte sin profesor definido:
 insert into Deportes values('basquet','lunes',null);
 insert into Deportes values('futbol','lunes','23333333');
 insert into Deportes values('natacion',null,'22222222');
 insert into Deportes values('padle',default,'23333333');
 insert into Deportes (nombre,dia) values('tenis','jueves');
 GO
--6- Ingrese registros en "Socios":
 insert into Socios values('30111111','Ana Acosta','America 111');
 insert into Socios values('30222222','Bernardo Bueno','Bolivia 222');
 insert into Socios values('30333333','Camila Conte','Caseros 333');
 insert into Socios values('30444444','Daniel Duarte','Dinamarca 444');
 GO
--7- Ingrese registros en "Inscriptos". Inscriba a un socio en distintos Deportes, inscriba varios 
--Socios en el mismo deporte.
 insert into Inscriptos values(1,3,'s');
 insert into Inscriptos values(1,5,'s');
 insert into Inscriptos values(2,1,'s');
 insert into Inscriptos values(4,1,'n');
 insert into Inscriptos values(4,4,'s');
GO
--8- Realice un "join" (del tipo que sea necesario) para mostrar todos los datos del socio junto con 
--el nombre de los Deportes en los cuales está inscripto, el día que tiene que asistir y el nombre del 
--profesor que lo instruirá.
--5 registros.
SELECT s.*,d.nombre,d.dia,p.nombre FROM Socios AS s
INNER JOIN Inscriptos AS i ON i.numerosocio = s.numero
INNER JOIN Deportes AS d ON i.codigodeporte =d.codigo
LEFT JOIN Profesores AS p ON d.profesor = p.documento
GO
--9- Realice la misma consulta anterior pero incluya los Socios que no están Inscriptos en ningún 
--deporte.
--6 registros.
SELECT s.*,d.nombre,d.dia,p.nombre FROM Socios AS s
FULL JOIN Inscriptos AS i ON i.numerosocio = s.numero
LEFT JOIN Deportes AS d ON i.codigodeporte =d.codigo
LEFT JOIN Profesores AS p ON d.profesor = p.documento
GO
--10- Muestre todos los datos de los Profesores, incluido el deporte que dicta y el día, incluyendo 
--los Profesores que no tienen asignado ningún deporte.
--4 registros.
SELECT p.nombre AS 'Profesor',d.nombre AS Deporte,d.dia FROM Profesores AS p
LEFT JOIN Deportes AS d ON p.documento =d.profesor
GO
--11- Muestre todos los Deportes y la cantidad de Inscriptos, incluyendo aquellos Deportes para los 
--cuales no hay Inscriptos.
--5 registros.
SELECT d.nombre,COUNT(i.codigodeporte) AS 'Cantidad inscritos' FROM Deportes AS d
LEFT JOIN Inscriptos AS i ON  d.codigo = i.codigodeporte
GROUP BY d.nombre
GO
--12- Muestre las restricciones de "Socios".
--3 restricciones y 1 "foreign key" de "Inscriptos" que la referencia.
EXEC sp_helpconstraint Socios;
GO
--13- Muestre las restricciones de "Deportes".
--3 restricciones y 1 "foreign key" de "Inscriptos" que la referencia.
EXEC sp_helpconstraint Deportes;
GO
--14- Muestre las restricciones de "Profesores".
--2 restricciones.
EXEC sp_helpconstraint Profesores;
GO
--15- Muestre las restricciones de "Inscriptos".
--4 restricciones.
EXEC sp_helpconstraint Inscriptos;
GO