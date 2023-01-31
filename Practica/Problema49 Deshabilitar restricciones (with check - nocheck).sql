USE Practica;

if object_id('empleados') is not null
  drop table empleados;

--2- Cr�ela con la siguiente estructura e ingrese los registros siguientes:
 create table empleados (
  documento varchar(8),
  nombre varchar(30),
  seccion varchar(20),
  sueldo decimal(6,2)
 );

 insert into empleados
  values ('22222222','Alberto Acosta','Sistemas',-10);
 insert into empleados
  values ('33333333','Beatriz Benitez','Recursos',3000);
 insert into empleados
  values ('34444444','Carlos Caseres','Contaduria',4000);

--3- Intente agregar una restricci�n "check" para asegurarse que no se ingresen valores negativos para 
--el sueldo:
 alter table empleados
 add constraint CK_empleados_sueldo_positivo
 check (sueldo>=0);
--No se permite porque hay un valor negativo almacenado.

--5- Vuelva a intentarlo agregando la opci�n "with nocheck":
 alter table empleados
 with nocheck
 add constraint CK_empleados_sueldo_positivo
 check (sueldo>=0);

--6- Intente ingresar un valor negativo para sueldo:
 insert into empleados
  values ('35555555','Daniel Duarte','Administracion',-2000);
--No es posible a causa de la restricci�n.

--7- Deshabilite la restricci�n e ingrese el registro anterior:
 alter table empleados
  nocheck constraint CK_empleados_sueldo_positivo;
 insert into empleados
  values ('35555555','Daniel Duarte','Administracion',2000);

--8- Establezca una restricci�n "check" para "seccion" que permita solamente los valores "Sistemas", 
--"Administracion" y "Contadur�a":
 alter table empleados
 add constraint CK_empleados_seccion_lista
 check (seccion in ('Sistemas','Administracion','Contaduria'));
--No lo permite porque existe un valor fuera de la lista.

--9- Establezca la restricci�n anterior evitando que se controlen los datos existentes.
ALTER TABLE empleados
WITH NOCHECK
ADD CONSTRAINT CK_empleados_seccion_lista
CHECK (seccion in ('Sistemas','Administracion','Contaduria')); 
GO
--10- Vea si las restricciones de la tabla est�n o no habilitadas:
 exec sp_helpconstraint empleados;
--Muestra 2 filas, una por cada restricci�n.

--11- Habilite la restricci�n deshabilitada.
ALTER TABLE empleados
CHECK CONSTRAINT CK_empleados_sueldo_positivo;
--12- Intente modificar la secci�n del empleado "Carlos Caseres" a "Recursos".
--No lo permite.
UPDATE empleados SET seccion='Recursos'
WHERE nombre='Carlos Caseres';
--13- Deshabilite la restricci�n para poder realizar la actualizaci�n del punto precedente.
ALTER TABLE empleados
NOCHECK CONSTRAINT CK_empleados_seccion_lista
UPDATE empleados SET seccion='Recursos'
WHERE nombre='Carlos Caseres';