USE Practica;

 if object_id('inscriptos') is not null
  drop table inscriptos;
GO

 create table inscriptos(
  documento char(8) not null, 
  nombre varchar(30),
  deporte varchar(15) not null,
  año datetime,
  matricula char(1),
  primary key(documento,deporte,año)
 );
 GO

--4- Inscriba a varios alumnos en el mismo deporte en el mismo año:
 insert into inscriptos
  values ('12222222','Juan Perez','tenis','2005','s');
 insert into inscriptos
  values ('23333333','Marta Garcia','tenis','2005','s');
 insert into inscriptos
  values ('34444444','Luis Perez','tenis','2005','n');
GO
--5- Inscriba a un mismo alumno en varios deportes en el mismo año:
 insert into inscriptos
  values ('12222222','Juan Perez','futbol','2005','s');
 insert into inscriptos
  values ('12222222','Juan Perez','natacion','2005','s');
 insert into inscriptos
  values ('12222222','Juan Perez','basquet','2005','n');
GO
--6- Ingrese un registro con el mismo documento de socio en el mismo deporte en distintos años:
 insert into inscriptos
  values ('12222222','Juan Perez','tenis','2006','s');
 insert into inscriptos
  values ('12222222','Juan Perez','tenis','2007','s');
GO

--7- Intente inscribir a un socio alumno en un deporte en el cual ya esté inscripto en un año en el cual ya se haya inscripto.
 insert into inscriptos
  values ('12222222','Juan Perez','tenis','2005','s');
--8- Intente actualizar un registro para que la clave primaria se repita.
 update inscriptos set deporte='tenis'
  where documento='12222222' and
  deporte='futbol' and
  año='2005';