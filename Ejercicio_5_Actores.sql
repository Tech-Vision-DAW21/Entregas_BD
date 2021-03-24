--1)Obtener los productos entregados en el año 2000:
SET DATEFORMAT dmy


SELECT M.Clave,Descripcion,fecha 
FROM Materiales M, Entregan E
WHERE M.Clave = E.Clave -- Join Natural
AND Fecha between '01/01/2000' AND '31/12/2000'

SELECT * FROM Proyectos

--2)Obtener los productos entregados en el año 2000 e 
--indicar el número de veces que fue entregado:

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

--3)Descripción del producto y unidades entregadas

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
Película (título, año, duración, encolor, presupuesto, nomestudio, idproductor)
Elenco (título, año, nombre, sueldo)
Actor (nombre, dirección, telefono, fechanacimiento, sexo)
Productor (idproductor, nombre, dirección, teléfono)
Estudio (nomestudio, dirección)


*/
--1) El El ingreso total recibido por cada actor,
-- sin importar en cuantas películas haya participado.

SELECT nombre, SUM(sueldo)
FROM Elenco
GROUP BY nombre  



--2)El monto total destinado a películas por 
--cada Estudio Cinematográfico, durante la década de los 80's.

SELECT nomestudio,SUM(presupuesto) as 'Total Presupuesto'
FROM Pelicula 
WHERE año between '1980' AND '1989'
GROUP BY nomestudio 

--3) Nombre y sueldo promedio de los actores (sólo hombres) 
--que reciben en promedio un pago superior a 5 millones de dolares por película.

SELECT nombre,AVG(sueldo) as 'Promedio Sueldo'
FROM Elenco E, Actor A
WHERE E.nombre=A.nombre AND sexo='masculino'
GROUP BY nombre
HAVING AVG(sueldo) > 5000000



--4)Título y año de producción de las películas con menor presupuesto. 
--(Por ejemplo, la película de Titanic se ha producido en varias veces entre
--la lista de películas estaría la producción de Titanic y el año que fue 
--filmada con menor presupuesto).

SELECT título,año,MIN(presupuesto) as 'Menor Presuesto'
FROM Pelicula
GROUP BY título -- no se considera año por que se registra todo por separado.
				-- ya que no encuentra coincidencias y por lo tanto
				-- no existira un mínimo de la misma película porque fueron
				-- hechas en diferente año.
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



