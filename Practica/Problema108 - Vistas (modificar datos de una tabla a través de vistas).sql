USE Practica;
GO

 if object_id('Inscriptos') is not null  
  drop table Inscriptos;
 if object_id('Socios') is not null  
  drop table Socios;
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

 create table Cursos(
  numero tinyint identity,
  deporte varchar(20),
  dia varchar(15),
   constraint CK_Inscriptos_dia check (dia in('lunes','martes','miercoles','jueves','viernes','sabado')),
  profesor varchar(20),
  constraint PK_Cursos_numero
   primary key (numero),
 );

 create table Inscriptos(
  documentosocio char(8) not null,
  numero tinyint not null,
  matricula char(1),
  constraint PK_Inscriptos_documento_numero
   primary key (documentosocio,numero),
  constraint FK_Inscriptos_documento
   foreign key (documentosocio)
   references Socios(documento)
   on update cascade,
  constraint FK_Inscriptos_numero
   foreign key (numero)
   references Cursos(numero)
   on update cascade
  );
  GO
--3- Ingrese algunos registros para todas las tablas:
 insert into Socios values('30000000','Fabian Fuentes','Caseros 987');
 insert into Socios values('31111111','Gaston Garcia','Guemes 65');
 insert into Socios values('32222222','Hector Huerta','Sucre 534');
 insert into Socios values('33333333','Ines Irala','Bulnes 345');

 insert into Cursos values('tenis','lunes','Ana Acosta');
 insert into Cursos values('tenis','martes','Ana Acosta');
 insert into Cursos values('natacion','miercoles','Ana Acosta');
 insert into Cursos values('natacion','jueves','Carlos Caseres');
 insert into Cursos values('futbol','sabado','Pedro Perez');
 insert into Cursos values('futbol','lunes','Pedro Perez');
 insert into Cursos values('basquet','viernes','Pedro Perez');

 insert into Inscriptos values('30000000',1,'s');
 insert into Inscriptos values('30000000',3,'n');
 insert into Inscriptos values('30000000',6,null);
 insert into Inscriptos values('31111111',1,'s');
 insert into Inscriptos values('31111111',4,'s');
 insert into Inscriptos values('32222222',1,'s');
 insert into Inscriptos values('32222222',7,'s');
 GO
--4- Realice un join para mostrar todos los datos de todas las tablas, sin repetirlos:
 select documento,nombre,domicilio,c.numero,deporte,dia, profesor,matricula
  from Socios as s
  join Inscriptos as i
  on s.documento=documentosocio
  join Cursos as c
  on c.numero=i.numero;
GO
--5- Elimine, si existe, la vista "vista_Cursos":
 if object_id('Vista_Cursos') is not null
  drop view Vista_Cursos;
GO
--6- Cree la vista "vista_Cursos" que muestre el número, deporte y día de todos los Cursos.
CREATE VIEW Vista_Cursos AS
SELECT c.numero,c.deporte,c.dia FROM Cursos AS C
GO
--7- Consulte la vista ordenada por deporte.
SELECT numero,deporte,dia FROM Vista_Cursos
ORDER BY deporte;
GO
--8- Ingrese un registro en la vista "vista_Cursos" y vea si afectó a "Cursos".
 insert into Vista_Cursos values('futbol','martes');
 select * from Cursos;
--Puede realizarse el ingreso porque solamente afecta a una tabla base.
GO
--9- Actualice un registro sobre la vista y vea si afectó a la tabla "Cursos".
--Puede realizarse la actualización porque solamente afecta a una tabla base.
UPDATE Vista_Cursos SET dia = 'miercoles'
WHERE numero = 8;
SELECT * FROM Cursos;
GO
--10- Elimine un registro de la vista para el cual no haya Inscriptos y vea si afectó a "Cursos".
DELETE Vista_Cursos 
WHERE numero = 8;
SELECT * FROM Cursos;
--Puede realizarse la eliminación porque solamente afecta a una tabla base.
GO

--11- Intente eliminar un registro de la vista para el cual haya Inscriptos.
DELETE Vista_Cursos 
WHERE numero = 1;
--No lo permite por la restricción "foreign key".
GO
--12- Elimine la vista "vista_Inscriptos" si existe y créela para que muestre el documento y nombre 
--del socio, el numero de curso, el deporte y día de los Cursos en los cuales está inscripto.
IF OBJECT_ID('Vista_Inscriptos') IS NOT NULL
DROP VIEW Vista_Inscriptos;
GO
CREATE VIEW Vista_Inscriptos AS
SELECT s.documento AS docSocio,s.nombre AS Socio,domicilio,c.numero AS Numero,deporte,dia
  FROM Inscriptos as i
  JOIN Socios as s 
  ON s.documento=i.documentosocio
  JOIN Cursos as c
  ON c.numero=i.numero;
GO
--13- Intente ingresar un registro en la vista.
 insert into vista_inscriptos values('32222222','Hector Huerta',6,'futbol','lunes');
 
--No lo permite porque la modificación afecta a más de una tabla base. 
GO
--14- Actualice un registro de la vista.
 update vista_inscriptos set Socio='Fabio Fuentes' where Socio='Fabian Fuentes';
--Lo permite porque la modificación afecta a una sola tabla base.
GO
--15- Vea si afectó a la tabla "Socios":
 select * from Socios;
 GO
--16- Intente actualizar el documento de un socio.
 update vista_inscriptos set docSocio='30000111' where docSocio='30000000';
--No lo permite por la restricción.
GO
--17- Intente eliminar un registro de la vista.
 delete from vista_inscriptos where docSocio='30000111' and deporte='tenis';
--No lo permite porque la vista incluye varias tablas.
GO