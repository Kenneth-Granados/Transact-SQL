USE Practica;
GO

 if object_id('Libros') is not null
  drop table Libros;

 create table Libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo) 
 );
 GO
--Eliminamos el procedimiento llamado "pa_Libros_autor", si existe:
 if object_id('pa_Libros_autor') is not null
  drop procedure pa_Libros_autor;
GO
--Creamos el procedimiento almacenado "pa_Libros_autor" con la opción de encriptado:
 create procedure pa_Libros_autor
  @autor varchar(30)=null
  with encryption
  as
   select *from Libros
    where autor=@autor;
--Ejecutamos el procedimiento almacenado del sistema "sp_helptext" para ver su contenido:
GO
 exec sp_helptext pa_Libros_autor;
--no aparece.