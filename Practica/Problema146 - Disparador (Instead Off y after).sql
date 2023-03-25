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
  nombre varchar(30),
  domicilio varchar(30),
  constraint PK_Socios primary key(documento)
 );
 create table Cursos(
  numero tinyint identity,
  deporte char(20),
  cantidadmaxima tinyint,
  constraint PK_Cursos primary key(numero)
 );

 create table Inscriptos(
  documento char(8) not null,
  numerocurso tinyint,
  fecha datetime,
  constraint PK_Inscriptos primary key(documento,numerocurso),
  constraint FK_Inscriptos_documento
   foreign key (documento)
   references Socios(documento),
  constraint FK_Inscriptos_curso
   foreign key (numerocurso)
   references Cursos(numero)
 );
GO
--Los Cursos tiene un número que los identifica, y según el deporte, hay un límite de Inscriptos (por 
--ejemplo, en tenis, no pueden inscribirse más de 4 Socios; en natación, solamente se aceptan 6 
--alumnos como máximo). Cuando un curso está completo, es decir, hay tantos Inscriptos como valor 
--tiene el campo "cantidadmaxima"), el socio  queda inscripto en forma condicional. El club guarda esa 
--información en una tabla denominada "Condicionales" que luego analiza, porque si se inscriben muchos 
--para un deporte determinado, se abrirá otro curso.

--2- Elimine la tabla "Condicionales" si existe:
 if object_id('Condicionales') is not null
  drop table Condicionales;

 create table Condicionales(
  documento char(8) not null,
  codigocurso tinyint not null,
  fecha datetime
 );
 GO
 insert into Socios values('22222222','Ana Acosta','Avellaneda 800');
 insert into Socios values('23333333','Bernardo Bustos','Bulnes 345');
 insert into Socios values('24444444','Carlos Caseros','Colon 382');
 insert into Socios values('25555555','Mariana Morales','Maipu 234');
 insert into Socios values('26666666','Patricia Palacios','Paru 587');

 insert into Cursos values('tenis',4);
 insert into Cursos values('natacion',6);
 insert into Cursos values('basquet',20);
 insert into Cursos values('futbol',20);

 insert into Inscriptos values('22222222',1,getdate());
 insert into Inscriptos values('22222222',2,getdate());
 insert into Inscriptos values('23333333',1,getdate());
 insert into Inscriptos values('23333333',3,getdate());
 insert into Inscriptos values('24444444',1,getdate());
 insert into Inscriptos values('24444444',4,getdate());
 insert into Inscriptos values('25555555',1,getdate());
GO
--5- Cree un trigger "instead of" para el evento de inserción para que, al intentar ingresar un 
--registro en "Inscriptos" controle que el curso no esté completo (tantos Inscriptos a tal curso como 
--su "cantidadmaxima"); si lo estuviese, debe ingresarse la inscripción en la tabla "Condicionales" y 
--mostrar un mensaje indicando tal situación. Si la "cantidadmaxima" no se alcanzó, se ingresa la 
--inscripción en "Inscriptos".
create trigger dis_Inscriptos_insertar
on Inscriptos
instead of insert
as
begin
declare @maximo tinyint
select @maximo=cantidadmaxima from Cursos as c
                join inserted as i
                on c.numero=i.numerocurso
if (@maximo=(select count(*) from Inscriptos as i
            join Cursos as c
            on i.numerocurso=c.numero
            join inserted as ins
            on i.numerocurso=ins.numerocurso))
-- esta completo
begin
insert into Condicionales select documento,numerocurso,fecha from inserted
select 'Inscripción condicional.'
end
else -- no esta completo
begin
insert into Inscriptos select documento,numerocurso,fecha from inserted
select 'Inscripción realizada.'
end
end;
GO
--6- Inscriba un socio en un curso que no esté completo.
--Verifique que el trigger realizó la acción esperada consultando las tablas:
insert into Inscriptos values('26666666',2,getdate());
 select *from Inscriptos;
 select *from Condicionales;
GO
--7- Inscriba un socio en un curso que esté completo.
--Verifique que el trigger realizó la acción esperada consultando las tablas:
insert into Inscriptos values('26666666',1,getdate());
 select *from Inscriptos;
 select *from Condicionales;
 GO