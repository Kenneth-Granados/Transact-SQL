USE Practica;

if object_id('peliculas') is not null
  drop table peliculas;
  GO

create table peliculas(
codigo int identity,
titulo varchar(40) not null,
actor varchar(20),
duracion tinyint,
primary key (codigo)
);
GO

insert into peliculas
values('Mision imposible','Tom Cruise',120);
insert into peliculas
values('Harry Potter y la piedra filosofal','Daniel R.',null);
insert into peliculas
values('Harry Potter y la camara secreta','Daniel R.',190);
insert into peliculas
values('Mision imposible 2','Tom Cruise',120);
insert into peliculas
values('Mujer bonita',null,120);
insert into peliculas
values('Tootsie','D. Hoffman',90);
insert into peliculas (titulo)
values('Un oso rojo');

SELECT * FROM peliculas
WHERE actor IS NULL;

UPDATE peliculas
SET duracion=0
WHERE duracion IS NULL;

DELETE peliculas
WHERE (actor IS NULL) AND duracion=0;
