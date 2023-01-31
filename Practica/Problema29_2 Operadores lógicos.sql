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
  values('Harry Potter y la piedra filosofal','Daniel R.',180);
 insert into peliculas
  values('Harry Potter y la camara secreta','Daniel R.',190);
 insert into peliculas
  values('Mision imposible 2','Tom Cruise',120);
 insert into peliculas
  values('Mujer bonita','Richard Gere',120);
 insert into peliculas
  values('Tootsie','D. Hoffman',90);
 insert into peliculas
  values('Un oso rojo','Julio Chavez',100);
 insert into peliculas
  values('Elsa y Fred','China Zorrilla',110);
  GO

SELECT * FROM peliculas
WHERE (actor='Tom Cruise') OR (actor='Richard Gere');

SELECT * FROM peliculas
WHERE (actor='Tom Cruise') AND (duracion<100);

UPDATE peliculas
SET duracion=200
WHERE (actor='Daniel R.') AND (duracion=180);

DELETE peliculas
WHERE NOT actor='Tom Cruise' AND (duracion>=100);