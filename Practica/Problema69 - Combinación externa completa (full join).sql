USE Practica;
GO

if (object_id('Deportes')) is not null
drop table Deportes;
if (object_id('Inscriptos')) is not null
drop table Inscriptos;
GO

 create table Deportes(
codigo tinyint identity,
nombre varchar(30),
profesor varchar(30),
primary key (codigo)
);

create table Inscriptos(
documento char(8),
codigodeporte tinyint not null,
matricula char(1) --'s'=paga 'n'=impaga
);
GO
insert into Deportes values('tenis','Marcelo Roca');
insert into Deportes values('natacion','Marta Torres');
insert into Deportes values('basquet','Luis Garcia');
insert into Deportes values('futbol','Marcelo Roca');

insert into Inscriptos values('22222222',3,'s');
insert into Inscriptos values('23333333',3,'s');
insert into Inscriptos values('24444444',3,'n');
insert into Inscriptos values('22222222',2,'s');
insert into Inscriptos values('23333333',2,'s');
insert into Inscriptos values('22222222',4,'n'); 
insert into Inscriptos values('22222222',5,'n'); 
GO

--3- Muestre todos la información de la tabla "inscriptos", y consulte la tabla "deportes" para obtener el nombre de cada deporte (6 registros) 
SELECT i.documento,i.matricula,d.nombre FROM Deportes AS d 
JOIN Inscriptos AS i ON d.codigo = i.codigodeporte;
GO
--4- Empleando un "left join" con "deportes" obtenga todos los datos de los inscriptos (7 registros) 
SELECT i.documento,i.matricula,d.nombre FROM Deportes AS d 
LEFT JOIN Inscriptos AS i ON d.codigo = i.codigodeporte;
GO
--5- Obtenga la misma salida anterior empleando un "rigth join".
SELECT i.documento,i.matricula,d.nombre FROM Deportes AS d 
RIGHT JOIN Inscriptos AS i ON d.codigo = i.codigodeporte;
GO
--6- Muestre los deportes para los cuales no hay inscriptos, empleando un "left join" (1 registro)
SELECT d.nombre FROM Deportes AS d  
LEFT JOIN Inscriptos AS i ON d.codigo = i.codigodeporte
WHERE i.codigodeporte IS NULL;
GO
--7- Muestre los documentos de los inscriptos a deportes que no existen en la tabla "deportes" (1 registro)
SELECT i.documento FROM Inscriptos AS i
LEFT JOIN Deportes AS d ON i.codigodeporte = d.codigo
WHERE d.codigo IS NULL;
GO
--8- Emplee un "full join" para obtener todos los datos de ambas tablas, incluyendo las inscripciones a deportes inexistentes
--en "deportes" y los deportes que no tienen inscriptos (8 registros)
SELECT i.documento,i.matricula,d.nombre,d.profesor FROM Inscriptos AS i
FULL JOIN Deportes AS d ON i.codigodeporte = d.codigo
GO