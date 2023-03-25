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
 insert into Inscriptos values('30000000',3,'s');
 insert into Inscriptos values('30000000',6,null);
 insert into Inscriptos values('31111111',1,'n');
 insert into Inscriptos values('31111111',4,'s');
 insert into Inscriptos values('32222222',1,'n');
 insert into Inscriptos values('32222222',7,'n');
 GO
--4- Elimine la vista "vista_deudores" si existe:
 if object_id('Vista_Deudores') is not null
  drop view Vista_Deudores;
GO
--5- Cree la vista "vista_deudores" que muestre el documento y nombre del socio, el deporte, el día y 
--la matrícula, de todas las inscripciones no pagas colocando "with check option".
 create view Vista_Deudores
 as
  select s.documento,s.nombre,c.deporte,c.dia,matricula
  from Socios as s
  join Inscriptos as i
  on s.documento=documentosocio
  join Cursos as c
  on c.numero=i.numero
  where matricula='n'
  with check option;
GO
--6- Consulte la vista:
 select * from Vista_Deudores;
GO
--7- Veamos el texto de la vista.
sp_helptext Vista_Deudores;
GO
--8- Intente actualizar a "s" la matrícula de una inscripción desde la vista.
 update Vista_Deudores set matricula='s' where documento='31111111';
--No lo permite por la opción "with check option".
 GO

--9- Modifique el documento de un socio mediante la vista.
 update Vista_Deudores set documento='31111113' where documento='31111111';
 GO
--10- Vea si se alteraron las tablas referenciadas en la vista:
 select * from Socios;
 select * from Inscriptos;
 GO
--11- Modifique la vista para que muestre el domicilio, coloque la opción de encriptación y omita 
--"with check option".
 ALTER VIEW Vista_Deudores
WITH ENCRYPTION
AS select s.documento,s.nombre,s.domicilio,c.deporte,c.dia,matricula
  from Socios as s
  join Inscriptos as i
  on s.documento=documentosocio
  join Cursos as c
  on c.numero=i.numero
  where matricula='n';
 GO
--12- Consulte la vista para ver si se modificó:
 select * from Vista_Deudores;
--Aparece el nuevo campo.
GO
--13- Vea el texto de la vista.
sp_helptext Vista_Deudores;
--No lo permite porque está encriptada.
GO

--14- Actualice la matrícula de un inscripto.
update Vista_Deudores set matricula='s' where documento='31111113';
--Si se permite porque la opción "with check option" se quitó de la vista.
GO
--15- Consulte la vista:
 select * from Vista_Deudores;
--Note que el registro modificado ya no aparece porque la matrícula está paga.
GO
--16- Elimine la vista "vista_Socios" si existe:
 if object_id('Vista_Socios') is not null
  drop view Vista_Socios;
GO
--17- Cree la vista "vista_Socios" que muestre todos los campos de la tabla "Socios".
CREATE VIEW Vista_Socios AS
SELECT * FROM Socios;
GO
--18- Consulte la vista.
SELECT * FROM Socios;
GO
--19- Agregue un campo a la tabla "Socios".
ALTER TABLE Socios
ADD Telefono CHAR(15);
GO
--20- Consulte la vista "vista_Socios".
SELECT * FROM Vista_Socios;
--El nuevo campo agregado a "Socios" no aparece, pese a que la vista indica que muestre todos los 
--campos de dicha tabla.
GO
--21- Altere la vista para que aparezcan todos los campos.
ALTER VIEW Vista_Socios
AS SELECT * FROM Socios;
GO
--22- Consulte la vista.
SELECT * FROM Vista_Socios;
GO