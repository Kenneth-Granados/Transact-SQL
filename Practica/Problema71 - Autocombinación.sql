USE Practica;
GO

IF OBJECT_ID('Clientes') is not null
 drop table Clientes;
GO

create table Clientes(
 nombre varchar(30),
 sexo char(1),--'f'=femenino, 'm'=masculino
 edad int,
 domicilio varchar(30)
);
GO

insert into Clientes values('Maria Lopez','f',45,'Colon 123');
insert into Clientes values('Liliana Garcia','f',35,'Sucre 456');
insert into Clientes values('Susana Lopez','f',41,'Avellaneda 98');
insert into Clientes values('Juan Torres','m',44,'Sarmiento 755');
insert into Clientes values('Marcelo Oliva','m',56,'San Martin 874');
insert into Clientes values('Federico Pereyra','m',38,'Colon 234');
insert into Clientes values('Juan Garcia','m',50,'Peru 333');
GO

--3- La agencia necesita la combinación de todas las personas de sexo femenino con las de sexo 
--masculino. Use un  "cross join" (12 registros)
SELECT c1.nombre, c2.nombre FROM Clientes AS c1 
CROSS JOIN Clientes AS c2
WHERE c1.sexo = 'm' AND c2.sexo = 'f';
GO
--4- Obtenga la misma salida enterior pero realizando un "join".
SELECT c1.nombre, c2.nombre FROM Clientes AS c1 
JOIN Clientes AS c2 ON c1.sexo <> c2.sexo
WHERE c1.sexo = 'm' AND c2.sexo = 'f';
GO
--5- Realice la misma autocombinación que el punto 3 pero agregue la condición que las parejas no 
--tengan una diferencia superior a 5 años (5 registros)
SELECT c1.nombre, c2.nombre FROM Clientes AS c1 
CROSS JOIN Clientes AS c2
WHERE ( c1.sexo = 'm' AND c2.sexo = 'f') AND (c1.edad - c2.edad)<5;
GO
-----------------------------------------------------------------------------------------------
-- SEGUNDO PROBLEMA
IF OBJECT_ID('Equipos') is not null
 DROP TABLE Equipos;
GO
create table Equipos(
 nombre varchar(30),
 barrio varchar(20),
 domicilio varchar(30),
 entrenador varchar(30)
);

insert into Equipos values('Los tigres','Gral. Paz','Sarmiento 234','Juan Lopez');
insert into Equipos values('Los leones','Centro','Colon 123','Gustavo Fuentes');
insert into Equipos values('Campeones','Pueyrredon','Guemes 346','Carlos Moreno');
insert into Equipos values('Cebollitas','Alberdi','Colon 1234','Luis Duarte');

--4- Cada equipo jugará con todos los demás 2 veces, una vez en cada sede. Realice un "cross join" 
--para combinar los equipos teniendo en cuenta que un equipo no juega consigo mismo (12 registros)
SELECT e1.nombre, e2.nombre FROM Equipos As e1 
CROSS JOIN Equipos AS e2
WHERE e1.nombre <> e2.nombre;
GO
--5- Obtenga el mismo resultado empleando un "join".
SELECT e1.nombre, e2.nombre FROM Equipos As e1 
 JOIN Equipos AS e2 ON e1.nombre <> e2.nombre;
GO
--6- Realice un "cross join" para combinar los equipos para que cada equipo juegue con cada uno de los 
--otros una sola vez (6 registros)
SELECT e1.nombre, e2.nombre FROM Equipos As e1 
CROSS JOIN Equipos AS e2
WHERE (e1.nombre <> e2.nombre) AND (e1.nombre < e2.nombre);
GO