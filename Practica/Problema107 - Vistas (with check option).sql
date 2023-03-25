USE Practica;
GO

if object_id('Clientes') is not null
  drop table Clientes;
 if object_id('Ciudades') is not null
  drop table Ciudades;
GO

 create table Ciudades(
  codigo tinyint identity,
  nombre varchar(20),
  constraint PK_Ciudades
   primary key (codigo)
 );

 create table Clientes(
  nombre varchar(20),
  apellido varchar(20),
  documento char(8),
  domicilio varchar(30),
  codigociudad tinyint
   constraint FK_Clientes_ciudad
    foreign key (codigociudad)
   references Ciudades(codigo)
   on update cascade
 );
 GO
--3- Ingrese algunos registros:
 insert into Ciudades values('Cordoba');
 insert into Ciudades values('Carlos Paz');
 insert into Ciudades values('Cruz del Eje');
 insert into Ciudades values('La Falda');

 insert into Clientes values('Juan','Perez','22222222','Colon 1123',1);
 insert into Clientes values('Karina','Lopez','23333333','San Martin 254',2);
 insert into Clientes values('Luis','Garcia','24444444','Caseros 345',1);
 insert into Clientes values('Marcos','Gonzalez','25555555','Sucre 458',3);
 insert into Clientes values('Nora','Torres','26666666','Bulnes 567',1);
 insert into Clientes values('Oscar','Luque','27777777','San Martin 786',4);
 GO
--4- Elimine la vista "vista_Clientes" si existe:
 if object_id('Vista_Clientes') is not null
  drop view Vista_Clientes;
GO
--5- Cree la vista "vista_Clientes" para que recupere el nombre, apellido, documento, domicilio, el 
--código y nombre de la ciudad a la cual pertenece, de la ciudad de "Cordoba" empleando "with check 
--option".
CREATE VIEW Vista_Clientes AS 
SELECT c.nombre,c.apellido,c.documento,c.domicilio,ciu.codigo,ciu.nombre AS Ciudad FROM Clientes AS c
INNER JOIN Ciudades AS ciu ON c.codigociudad=  ciu.codigo
GO
--6- Consulte la vista:
 select * from Vista_Clientes;
 GO
--7- Actualice el apellido de un cliente a través de la vista.
UPDATE Vista_Clientes SET apellido = 'Granados' 
WHERE documento = '22222222';
GO
--8- Verifique que la modificación se realizó en la tabla:
 select * from Clientes;
GO
--9- Intente cambiar la ciudad de algún registro.
UPDATE Vista_Clientes SET codigo = '1' 
WHERE documento = '22222222';
GO
--Mensaje de error.
