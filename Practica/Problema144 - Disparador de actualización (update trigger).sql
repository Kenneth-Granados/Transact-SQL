USE Practica;
GO

if object_id('inscriptos') is not null
  drop table inscriptos;
 if object_id('socios') is not null
  drop table socios;
 if object_id('morosos') is not null
  drop table morosos;
GO
 create table socios(
  documento char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  constraint PK_socios primary key(documento)
 );

 create table inscriptos(
  numero int identity,
  documento char(8) not null,
  deporte varchar(20),
  matricula char(1),
  constraint FK_inscriptos_documento
   foreign key (documento)
   references socios(documento),
  constraint CK_inscriptos_matricula check (matricula in ('s','n')),
  constraint PK_inscriptos primary key(documento,deporte)
 );
 
 create table morosos(
  documento char(8) not null
 );
 GO
 insert into socios values('22222222','Ana Acosta','Avellaneda 800');
 insert into socios values('23333333','Bernardo Bustos','Bulnes 345');
 insert into socios values('24444444','Carlos Caseros','Colon 382');
 insert into socios values('25555555','Mariana Morales','Maipu 234');

 insert into inscriptos values('22222222','tenis','s');
 insert into inscriptos values('22222222','natacion','n');
 insert into inscriptos values('23333333','tenis','n');
 insert into inscriptos values('24444444','futbol','s');
 insert into inscriptos values('24444444','natacion','s');

 insert into morosos values('22222222');
 insert into morosos values('23333333');
 GO
--4- Cree un disparador para la tabla "inscriptos" que se active ante una sentencia "update" y no 
--permita actualizar m�s de un registro.
create trigger DIS_inscriptos_actualizar1
on inscriptos
for update
as
if (select count(*) from deleted) > 1
begin
raiserror('No puede actualizar m�s de un registro',16,1)
rollback transaction
end;
GO
--5- Cree otro disparador para la tabla "inscriptos" que se active ante una sentencia "update". Si se 
--actualiza el pago de la matr�cula a 's', el socio debe eliminarse de la tabla "morosos"; no debe 
--permitir modificar a 'n' una matr�cula paga.
create trigger DIS_inscriptos_actualizar_matricula
on inscriptos
for update
as
if update(matricula)
    if (select matricula from inserted)='n' and (select matricula from deleted)='s'
    begin
    raiserror('No puede colocar impaga una cuota paga.', 16, 1)
    rollback transaction
    end
    else
    if (select matricula from inserted)='s' and (select matricula from deleted)='n'
    delete morosos
    from morosos
    join deleted
    on deleted.documento=morosos.documento
    where morosos.documento=deleted.documento;
GO
--6- Actualice cualquier campo (diferente de "matricula") de un registro de la tabla "inscriptos".
--Ambos disparadores se activaron permitiendo la transacci�n.
  update inscriptos set deporte='basquet' where numero=1;
GO
--7- Actualice cualquier campo (diferente de "matricula") de varios registros de la tabla 
--"inscriptos".
--El disparador "dis_inscriptos_actualizar1" se activa y no permite la transacci�n. El disparador 
--"dis_inscriptos_actualizar_matricula" no llega a activarse.
update inscriptos set deporte='basquet' where numero between 3 and 4;
GO
--8- Actualice el campo "matricula" a 's' de un inscripto que deba la matr�cula.
--Ambos disparadores se activaron y permitieron la actualizaci�n.
 update inscriptos set matricula='s' where numero=2;
 GO
--9- Verifique que el campo se actualiz� y que el socio ya no est� en "morosos":
 select *from inscriptos;
 select *from morosos;
 GO
--10-Actualice el campo "matricula" a 'n' de un inscripto que tenga la matr�cula paga.
--Ambos disparadores se activaron; "dis_inscriptos_actualizar_matricula" deshace la transacci�n.
 update inscriptos set matricula='n' where numero=2;
GO