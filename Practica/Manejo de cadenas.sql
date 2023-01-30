USE Practica

--substring(cadena,inicio,longitud): devuelve una parte de la cadena especificada como primer argumento, empezando desde la posici�n especificada 
--por el segundo argumento y de tantos caracteres de longitud como indica el tercer argumento.Ejemplo: 
select substring('Buenas tardes',8,6); 
 
--- str(numero,longitud,cantidaddecimales): convierte n�meros a caracteres; el primer par�metro indica el valor num�rico a convertir, 
--el segundo la longitud del resultado (debe ser mayor o igual a la parte entera del n�mero m�s el signo si lo tuviese) y el tercero, 
--la cantidad de decimales. El segundo y tercer argumento son opcionales y deben ser positivos. String significa cadena en ingl�s.Ejemplo: se 
--convierte el valor num�rico "123.456" a cadena, especificando 7 de longitud y 3 decimales: 
select str(123.456,7,3); 
select str(-123.456,7,3); 
--Si no se colocan el segundo y tercer argumeno, la longitud predeterminada es 10 y la cantidad de decimales 0 y se redondea a entero. Ejemplo: 
--se convierte el valor num�rico "123.456" a cadena: 
select str(123.456); 
select str(123.456,3); -- Si el segundo par�metro es menor a la parte entera del n�mero, devuelve asteriscos (*). Ejemplo: 
select str(123.456,2,3); --retorna "**". 
-- stuff(cadena1,inicio,cantidad,cadena2): inserta la cadena enviada como cuarto argumento, en la posici�n indicada en el segundo argumento, 
--reemplazando la cantidad de caracteres indicada por el tercer argumento en la cadena que es primer par�metro. Stuff significa rellenar en ingl�s.Ejemplo: 
select stuff('abcde',3,2,'opqrs'); --retorna "abopqrse". Es decir, coloca en la posici�n 2 la cadena "opqrs" y reemplaza 2 caracteres de la primer cadena. 
--Los argumentos num�ricos deben ser positivos y menor o igual a la longitud de la primera cadena, caso contrario, retorna "null". Si el tercer argumento es 
--mayor que la primera cadena, se elimina hasta el primer car�cter. 
--- len(cadena): retorna la longitud de la cadena enviada como argumento. "len" viene de length, que significa longitud en ingl�s. Ejemplo:
select len('Hola'); --devuelve 4. 
--- char(x): retorna un caracter en c�digo ASCII del entero enviado como argumento. Ejemplo: 
select char(65); --retorna "A". 
--- left(cadena,longitud): retorna la cantidad (longitud) de caracteres de la cadena comenzando desde la izquierda, primer caracter. Ejemplo: 
select left('buenos dias',8); --retorna "buenos d". 
--- right(cadena,longitud): retorna la cantidad (longitud) de caracteres de la cadena comenzando desde la derecha, �ltimo caracter. Ejemplo: 
select right('buenos dias',8); --retorna "nos dias". 
---lower(cadena): retornan la cadena con todos los caracteres en min�sculas. lower significa reducir en ingl�s. Ejemplo: 
select lower('HOLA ESTUDIAnte'); --retorna "hola estudiante". 
---upper(cadena): retornan la cadena con todos los caracteres en may�sculas. Ejemplo: 
select upper('HOLA ESTUDIAnte'); 
---ltrim(cadena): retorna la cadena con los espacios de la izquierda eliminados. Trim significa recortar. Ejemplo: 
select ltrim(' Hola '); --retorna "Hola ".
--- rtrim(cadena): retorna la cadena con los espacios de la derecha eliminados. Ejemplo:
select rtrim(' Hola '); --retorna " Hola". 
--- replace(cadena,cadenareemplazo,cadenareemplazar): retorna la cadena con todas las ocurrencias de la subcadena reemplazo por la subcadena a reemplazar. Ejemplo: 
select replace('xxx.sqlserverya.com','x','w');-- retorna "www.sqlserverya.com'.
-- - reverse(cadena): devuelve la cadena invirtiendo el order de los caracteres. Ejemplo: 
select reverse('Hola'); --retorna "aloH".
--- patindex(patron,cadena): devuelve la posici�n de comienzo (de la primera ocurrencia) del patr�n especificado en la cadena enviada como segundo argumento. Si no la encuentra retorna 0. Ejemplos:
select patindex('%Luis%', 'Jorge Luis Borges'); --retorna 7. 
select patindex('%or%', 'Jorge Luis Borges');-- retorna 2. 
select patindex('%ar%', 'Jorge Luis Borges');-- retorna 0. 
--- charindex(subcadena,cadena,inicio): devuelve la posici�n donde comienza la subcadena en la cadena, comenzando la b�squeda desde la posici�n indicada por "inicio". 
--Si el tercer argumento no se coloca, la b�squeda se inicia desde 0. Si no la encuentra, retorna 0. Ejemplos: 
select charindex('or','Jorge Luis Borges',5);-- retorna 13.
select charindex('or','Jorge Luis Borges');-- retorna 2. 
select charindex('or','Jorge Luis Borges',14);-- retorna 0. 
select charindex('or', 'Jorge Luis Borges'); --retorna 0.
--- replicate(cadena,cantidad): repite una cadena la cantidad de veces especificada. Ejemplo: 
select replicate ('Hola',3);-- retorna "HolaHolaHola"; 
--- space(cantidad): retorna una cadena de espacios de longitud indicada por "cantidad", que debe ser un valor positivo. Ejemplo: 
select 'Hola'+space(1)+'que tal';-- retorna "Hola que tal".