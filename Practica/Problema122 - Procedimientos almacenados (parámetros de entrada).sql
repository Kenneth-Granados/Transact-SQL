USE Practica;
GO

if object_id('Empleados') is not null
  drop table Empleados;

 create table Empleados(
  documento char(8),
  nombre varchar(20),
  apellido varchar(20),
  sueldo decimal(6,2),
  cantidadhijos tinyint,
  seccion varchar(20),
  primary key(documento)
 );
GO

 insert into Empleados values('22222222','Juan','Perez',300,2,'Contaduria');
 insert into Empleados values('22333333','Luis','Lopez',300,0,'Contaduria');
 insert into Empleados values ('22444444','Marta','Perez',500,1,'Sistemas');
 insert into Empleados values('22555555','Susana','Garcia',400,2,'Secretaria');
 insert into Empleados values('22666666','Jose Maria','Morales',400,3,'Secretaria');
GO
--3- Elimine el procedimiento llamado "pa_Empleados_sueldo" si existe:
 if object_id('pa_Empleados_sueldo') is not null
  drop procedure pa_Empleados_sueldo;

--4- Cree un procedimiento almacenado llamado "pa_Empleados_sueldo" que seleccione los nombres, 
--apellidos y sueldos de los Empleados que tengan un sueldo superior o igual al enviado como 
--parámetro.
create procedure pa_Empleados_sueldo
  @sueldo decimal(6,2)
 as
  select nombre,apellido,sueldo
   from Empleados
    where sueldo>=@sueldo;
GO
--5- Ejecute el procedimiento creado anteriormente con distintos valores:
 exec pa_Empleados_sueldo 400;
 exec pa_Empleados_sueldo 500;
 GO
--6- Ejecute el procedimiento almacenado "pa_Empleados_sueldo" sin parámetros.
--Mensaje de error.
exec pa_Empleados_sueldo;
GO
--7- Elimine el procedimiento almacenado "pa_Empleados_actualizar_sueldo" si existe:
 if object_id('pa_Empleados_actualizar_sueldo') is not null
  drop procedure pa_Empleados_actualizar_sueldo;

--8- Cree un procedimiento almacenado llamado "pa_Empleados_actualizar_sueldo" que actualice los 
--sueldos iguales al enviado como primer parámetro con el valor enviado como segundo parámetro.
create procedure pa_Empleados_actualizar_sueldo
  @sueldoanterior decimal(6,2),
  @sueldonuevo decimal(6,2)
 as
  update Empleados set sueldo=@sueldonuevo
   where sueldo=@sueldoanterior;
GO
--9- Ejecute el procedimiento creado anteriormente y verifique si se ha ejecutado correctamente:
 exec pa_Empleados_actualizar_sueldo 300,350;
 select * from Empleados;
GO
--10- Ejecute el procedimiento "pa_Empleados_actualizar_sueldo" enviando un solo parámetro.
--Error.
 exec pa_Empleados_actualizar_sueldo 350;
GO
--11- Ejecute el procedimiento almacenado "pa_Empleados_actualizar_sueldo" enviando en primer lugar el 
--parámetro @sueldonuevo y en segundo lugar @sueldoanterior (parámetros por nombre).
exec pa_Empleados_actualizar_sueldo @sueldonuevo=400,@sueldoanterior=350;
GO
--12- Verifique el cambio:
 select * from Empleados;
GO
--13- Elimine el procedimiento almacenado "pa_sueldototal", si existe:
 if object_id('pa_sueldototal') is not null
  drop procedure pa_sueldototal;
GO
--14- Cree un procedimiento llamado "pa_sueldototal" que reciba el documento de un empleado y muestre 
--su nombre, apellido y el sueldo total (resultado de la suma del sueldo y salario por hijo, que es de 
--$200 si el sueldo es menor a $500 y $100, si el sueldo es mayor o igual a $500). Coloque como valor 
--por defecto para el parámetro el patrón "%".
create procedure pa_sueldototal
  @documento varchar(8) = '%'
 as
  select nombre,apellido,
   sueldototal=
   case 
    when sueldo<500 then sueldo+(cantidadhijos*200)
    when sueldo>=500 then sueldo+(cantidadhijos*100)
   end
   from Empleados
   where documento like @documento;
GO
--15- Ejecute el procedimiento anterior enviando diferentes valores:
 exec pa_sueldototal '22333333';
 exec pa_sueldototal '22444444';
 exec pa_sueldototal '22666666';
 GO
--16-  Ejecute el procedimiento sin enviar parámetro para que tome el valor por defecto.
--Muestra los 5 registros.
 exec pa_sueldototal;
GO