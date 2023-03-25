USE Practica;
GO

if object_id('Libros') is not null
  drop table Libros;
 if object_id('Editoriales') is not null
  drop table Editoriales;

 create table Libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) default 'Desconocido',
  codigoeditorial tinyint not null,
  precio decimal(5,2)
 );
 create table Editoriales(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

 insert into Editoriales values('Planeta');
 insert into Editoriales values('Emece');
 insert into Editoriales values('Siglo XXI');

 insert into Libros values('El aleph','Borges',2,20);
 insert into Libros values('Martin Fierro','Jose Hernandez',1,30);
 insert into Libros values('Aprenda PHP','Mario Molina',3,50);
 insert into Libros values('Java en 10 minutos',default,3,45);

 update Libros set precio=precio+(precio*0.1)
  from Libros 
  join Editoriales as e
  on codigoeditorial=e.codigo
  where nombre='Planeta';

 select titulo,autor,e.nombre,precio
  from Libros as l
  join Editoriales as e
  on codigoeditorial=e.codigo;

 delete Libros
  from Libros
  join Editoriales
  on codigoeditorial = Editoriales.codigo
  where Editoriales.nombre='Emece';

 select titulo,autor,e.nombre,precio
  from Libros as l
  join Editoriales as e
  on codigoeditorial=e.codigo;
