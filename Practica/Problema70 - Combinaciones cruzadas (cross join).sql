USE Practica;
GO

if object_id('Mujeres') is not null
 drop table Mujeres;
if object_id('Varones') is not null
 drop table Varones;
GO
create table Mujeres(
 nombre varchar(30),
 domicilio varchar(30),
 edad int
);
create table Varones(
 nombre varchar(30),
 domicilio varchar(30),
 edad int
);
GO

insert into Mujeres values('Maria Lopez','Colon 123',45);
insert into Mujeres values('Liliana Garcia','Sucre 456',35);
insert into Mujeres values('Susana Lopez','Avellaneda 98',41);

insert into Varones values('Juan Torres','Sarmiento 755',44);
insert into Varones values('Marcelo Oliva','San Martin 874',56);
insert into Varones values('Federico Pereyra','Colon 234',38);
insert into Varones values('Juan Garcia','Peru 333',50);
GO

--3- La agencia necesita la combinación de todas las personas de sexo femenino con las de sexo masculino. Use un "cross join" (12 registros)
SELECT m.nombre,m.edad,v.nombre,v.edad FROM Mujeres As m
CROSS JOIN Varones AS v;
GO
--4- Realice la misma combinación pero considerando solamente las personas mayores de 40 años (6 registros)
SELECT m.nombre,m.edad,v.nombre,v.edad FROM Mujeres As m
CROSS JOIN Varones AS v
WHERE m.edad > 40 AND v.edad>40
GO
--5- Forme las parejas pero teniendo en cuenta que no tengan una diferencia superior a 10 años (8 registros)
SELECT m.nombre,m.edad,v.nombre,v.edad FROM Mujeres As m
CROSS JOIN Varones AS v
WHERE (v.edad-m.edad) < 10
GO
 -------------------------------------------------------------------------
 --SEGUNDO PROBLEMA
if object_id('Guardias') is not null
 drop table Guardias;
if object_id('Tareas') is not null
 drop table Tareas;
GO

create table Guardias(
 documento char(8),
 nombre varchar(30),
 sexo char(1), /* 'f' o 'm' */
 domicilio varchar(30),
 primary key (documento)
);

create table Tareas(
 codigo tinyint identity,
 domicilio varchar(30),
 descripcion varchar(30),
 horario char(2), /* 'AM' o 'PM'*/
 primary key (codigo)
);
GO

insert into Guardias values('22333444','Juan Perez','m','Colon 123');
insert into Guardias values('24333444','Alberto Torres','m','San Martin 567');
insert into Guardias values('25333444','Luis Ferreyra','m','Chacabuco 235');
insert into Guardias values('23333444','Lorena Viale','f','Sarmiento 988');
insert into Guardias values('26333444','Irma Gonzalez','f','Mariano Moreno 111');

insert into Tareas values('Colon 1111','vigilancia exterior','AM');
insert into Tareas values('Urquiza 234','vigilancia exterior','PM');
insert into Tareas values('Peru 345','vigilancia interior','AM');
insert into Tareas values('Avellaneda 890','vigilancia interior','PM');
GO

--4- La empresa quiere que todos sus empleados realicen todas las tareas. Realice una "cross join" (20 
--registros)
SELECT g.nombre,t.descripcion FROM Guardias As g
CROSS JOIN Tareas AS t;
GO

--5- En este caso, la empresa quiere que todos los guardias de sexo femenino realicen las tareas de 
--"vigilancia interior" y los de sexo masculino de "vigilancia exterior". Realice una "cross join" con 
--un "where" que controle tal requisito (10 registros)
SELECT g.nombre,t.descripcion FROM Guardias As g
CROSS JOIN Tareas AS t
WHERE (g.sexo LIKE 'm' AND t.descripcion LIKE 'vigilancia exterior') OR (g.sexo LIKE 'f' AND t.descripcion LIKE 'vigilancia interior')
GO