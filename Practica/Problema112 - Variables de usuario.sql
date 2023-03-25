USE Practica;
GO

if object_id('Alumnos') is not null
  drop table Alumnos;
 if object_id('Notas') is not null
  drop table Notas;
GO
 create table Alumnos(
  documento char(8) not null
   constraint CK_Alumnos_documento check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  nombre varchar(30),
  constraint PK_Alumnos
  primary key(documento)
 );

 create table Notas(
  documento char(8) not null,
  nota decimal(4,2)
   constraint CK_Notas_nota check (nota between 0 and 10),
  constraint FK_Notas_documento
  foreign key(documento)
  references Alumnos(documento)
  on update cascade
 );
GO

 insert into Alumnos values('30111111','Ana Algarbe');
 insert into Alumnos values('30222222','Bernardo Bustamante');
 insert into Alumnos values('30333333','Carolina Conte');
 insert into Alumnos values('30444444','Diana Dominguez');
 insert into Alumnos values('30555555','Fabian Fuentes');
 insert into Alumnos values('30666666','Gaston Gonzalez');

 insert into Notas values('30111111',5.1);
 insert into Notas values('30222222',7.8);
 insert into Notas values('30333333',4);
 insert into Notas values('30444444',2.5);
 insert into Notas values('30666666',9.9);
 insert into Notas values('30111111',7.3);
 insert into Notas values('30222222',8.9);
 insert into Notas values('30444444',6);
 insert into Notas values('30666666',8);
GO
--4- Declare una variable llamada "@documento" de tipo "char(8)" y vea su contenido:
 declare @documento char(8)
 select @documento;
GO
--5- Intente usar la variable "@documento" para almacenar el documento del alumno con la nota más alta:
 select @documento= documento from Notas
  where nota=(select max(nota) from Notas);
--No se puede porque la variable fue declarada en otro lote de sentencias y no es reconocida.
GO
--6- Declare una variable llamada "@documento" de tipo "char(8)" y almacene en ella el documento del 
--alumno con la nota más alta, luego recupere el nombre del alumno:
 declare @documento char(8)
 select @documento= documento from Notas
  where nota=(select max(nota) from Notas)
 select nombre from Alumnos where documento=@documento;
 GO