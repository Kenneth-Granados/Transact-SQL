USE Practica;

if object_id('empleados') is not null
  drop table empleados;
GO

 create table empleados (
  documento varchar(8),
  nombre varchar(30),
  fechanacimiento datetime,
  cantidadhijos tinyint,
  seccion varchar(20),
  sueldo decimal(6,2)
 );
 GO
 SET DATEFORMAT ymd
--3- Agregue una restricción "check" para asegurarse que no se ingresen valores negativos para el 
--sueldo:
 alter table empleados
   add constraint CK_empleados_sueldo_positivo
   check (sueldo>0);

--4- Ingrese algunos registros válidos:
 insert into empleados values ('22222222','Alberto Lopez','1965/10/05',1,'Sistemas',1000);
 insert into empleados values ('33333333','Beatriz Garcia','1972/08/15',2,'Administracion',3000);
 insert into empleados values ('34444444','Carlos Caseres','1980/10/05',0,'Contaduría',6000);

--5- Intente agregar otra restricción "check" al campo sueldo para asegurar que ninguno supere el 
--valor 5000:
 alter table empleados
   add constraint CK_empleados_sueldo_maximo
   check (sueldo<=5000);
--La sentencia no se ejecuta porque hay un sueldo que no cumple la restricción.

--6- Elimine el registro infractor y vuelva a crear la restricción:
 delete from empleados where sueldo=6000;

 alter table empleados
   add constraint CK_empleados_sueldo_maximo
   check (sueldo<=5000); 

--7- Establezca una restricción para controlar que la fecha de nacimiento que se ingresa no supere la 
--fecha actual:
 alter table empleados
   add constraint CK_fechanacimiento_actual
   check (fechanacimiento<getdate());

--8- Establezca una restricción "check" para "seccion" que permita solamente los valores "Sistemas", 
--"Administracion" y "Contaduría":
 alter table empleados
   add constraint CK_empleados_seccion_lista
   check (seccion in ('Sistemas','Administracion','Contaduria'));

--9- Establezca una restricción "check" para "cantidadhijos" que permita solamente valores entre 0 y 
--15.
ALTER TABLE empleados
ADD CONSTRAINT CK_empleados_cantidadhijos
CHECK (cantidadhijos>=0 AND cantidadhijos<=15)
--10- Vea todas las restricciones de la tabla (5 filas):
 exec sp_helpconstraint empleados;

--11- Intente agregar un registro que vaya contra alguna de las restricciones al campo "sueldo".
--Mensaje de error porque se infringe la restricción "CK_empleados_sueldo_positivo".
ALTER TABLE empleados
ADD CONSTRAINT CK_empleados_sueldo1
CHECK (sueldo<0)

--12- Intente agregar un registro con fecha de nacimiento futura.
--Mensaje de error.
INSERT INTO empleados VALUES('11111','Alberto Lopez','2022/10/05',1,'Sistemas',1000)
--13- Intente modificar un registro colocando en "cantidadhijos" el valor "21".
--Mensaje de error.
INSERT INTO empleados VALUES('11111','Alberto Lopez','2000/10/05',21,'Sistemas',1000)
--14- Intente modificar el valor de algún registro en el campo "seccion" cambiándolo por uno que no 
--esté incluido en la lista de permitidos.
--Mensaje de error.
INSERT INTO empleados VALUES('11111','Alberto Lopez','2000/10/05',1,'Legislador',1000)
--15- Intente agregar una restricción al campo sección para aceptar solamente valores que comiencen 
--con la letra "B":
 alter table empleados
   add constraint CK_seccion_letrainicial
   check (seccion like '%B');
--Note que NO se puede establecer esta restricción porque va en contra de la establecida anteriormente 
--para el mismo campo, si lo permitiera, no podríamos ingresar ningún valor para "seccion".
