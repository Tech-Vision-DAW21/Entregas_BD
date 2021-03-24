--1)Obtener los productos entregados en el a�o 2000:
SET DATEFORMAT dmy


SELECT M.Clave,Descripcion,fecha 
FROM Materiales M, Entregan E
WHERE M.Clave = E.Clave -- Join Natural
AND Fecha between '01/01/2000' AND '31/12/2000'

SELECT * FROM Proyectos

--2)Obtener los productos entregados en el a�o 2000 e 
--indicar el n�mero de veces que fue entregado:

SET DATEFORMAT dmy

--No se puede incluir fecha por que sino todos son -
-- diferentes.
SELECT M.Clave,Descripcion, COUNT(*) as 'Total de Entregas' 
FROM Materiales M, Entregan E
WHERE M.Clave = E.Clave -- Join Natural
AND Fecha between '01/01/2000' AND '31/12/2000'
GROUP BY M.Clave,Descripcion
HAVING COUNT(*) >= 2
ORDER BY 'Total de Entregas' DESC

--3)Descripci�n del producto y unidades entregadas

SELECT M.Clave,Descripcion, SUM(*) as 'Total de Unidades' 
FROM Materiales M, Entregan E
WHERE M.Clave = E.Clave -- Join Natural
GROUP BY Descripcion
ORDER BY 'Total de Unidades' DESC

--4) Total de totales

SELECT SUM(Cantidad) as 'Total de Unidades' 
FROM Materiales M, Entregan E
WHERE M.Clave = E.Clave -- Join Natural





--LAB 
/*
Pel�cula (t�tulo, a�o, duraci�n, encolor, presupuesto, nomestudio, idproductor)
Elenco (t�tulo, a�o, nombre, sueldo)
Actor (nombre, direcci�n, telefono, fechanacimiento, sexo)
Productor (idproductor, nombre, direcci�n, tel�fono)
Estudio (nomestudio, direcci�n)


*/
--1) El El ingreso total recibido por cada actor,
-- sin importar en cuantas pel�culas haya participado.

SELECT nombre, SUM(sueldo)
FROM Elenco
GROUP BY nombre  



--2)El monto total destinado a pel�culas por 
--cada Estudio Cinematogr�fico, durante la d�cada de los 80's.

SELECT nomestudio,SUM(presupuesto) as 'Total Presupuesto'
FROM Pelicula 
WHERE a�o between '1980' AND '1989'
GROUP BY nomestudio 

--3) Nombre y sueldo promedio de los actores (s�lo hombres) 
--que reciben en promedio un pago superior a 5 millones de dolares por pel�cula.

SELECT nombre,AVG(sueldo) as 'Promedio Sueldo'
FROM Elenco E, Actor A
WHERE E.nombre=A.nombre AND sexo='masculino'
GROUP BY nombre
HAVING AVG(sueldo) > 5000000



--4)T�tulo y a�o de producci�n de las pel�culas con menor presupuesto. 
--(Por ejemplo, la pel�cula de Titanic se ha producido en varias veces entre
--la lista de pel�culas estar�a la producci�n de Titanic y el a�o que fue 
--filmada con menor presupuesto).

SELECT t�tulo,a�o,MIN(presupuesto) as 'Menor Presuesto'
FROM Pelicula
GROUP BY t�tulo -- no se considera a�o por que se registra todo por separado.
				-- ya que no encuentra coincidencias y por lo tanto
				-- no existira un m�nimo de la misma pel�cula porque fueron
				-- hechas en diferente a�o.
ORDER BY 'Menor Presupuesto' 

--5) Mostrar el sueldo de la actriz mejor pagada.

SELECT MAX(sueldo) as 'Sueldo Mejor Pagado(Actriz)'
FROM Elenco E,Actor A
WHERE E.nombre=A.nombre 
AND sexo='femenino'

-- NOMBRE DE LA ACTRIZ MEJOR PAGADA

SELECT Nombre, Sueldo
FROM Actor
WHERE Sueldo = (SELECT MAX(sueldo) as 'Sueldo Mejor Pagado(Actriz)'
				FROM Elenco E,Actor A
				WHERE E.nombre=A.nombre 
				AND A.sexo='femenino')

AND A.sexo='femenino'



