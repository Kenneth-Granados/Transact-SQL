USE Practica;

IF OBJECT_ID ('articulos') IS NOT NULL
  DROP TABLE articulos;

 CREATE TABLE articulos(
  codigo INT IDENTITY,
  nombre VARCHAR(20),
  descripcion VARCHAR(30),
  precio SMALLMONEY,
  cantidad TINYINT DEFAULT 0,
  CONSTRAINT pk_articulos PRIMARY KEY (codigo)
 );
GO
 INSERT INTO articulos (nombre, descripcion, precio,cantidad)
  VALUES ('impresora','Epson Stylus C45',400.80,20);
 INSERT INTO articulos (nombre, descripcion, precio)
  VALUES ('impresora','Epson Stylus C85',500);
 INSERT INTO articulos (nombre, descripcion, precio)
  VALUES ('monitor','Samsung 14',800);
 INSERT INTO articulos (nombre, descripcion, precio,cantidad)
  VALUES ('teclado','ingles Biswal',100,50);
GO

UPDATE articulos SET precio= precio + (precio*0.1);
SELECT * FROM articulos

SELECT nombre+ ', '+descripcion FROM articulos

SELECT nombre,descripcion,cantidad=cantidad-5 
FROM articulos
WHERE nombre='teclado'