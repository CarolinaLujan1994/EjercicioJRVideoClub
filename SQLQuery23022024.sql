--a. Mostrar un ranking de las pel�culas m�s alquiladas.
SELECT COUNT(*) AS cantidadAlquilados, ci.nombreCinta
FROM ArchivadorPrestamo ap
JOIN Cintas ci ON ap.idCinta = ci.idCinta
GROUP BY ci.nombreCinta
ORDER BY cantidadAlquilados DESC
--El buf�n
--Madame Web
--Bob Marley


--b. Mostrar un ranking de los clientes que m�s pel�culas alquilan.
SELECT COUNT(*) AS cantidadAlquilados, so.nombreSocio
FROM ArchivadorPrestamo ap
JOIN Socios so ON ap.idSocio = so.idSocio
GROUP BY so.nombreSocio
ORDER BY cantidadAlquilados DESC
--45 Abigail
--15 Mercedes
--456 Roberto


--c. Mostrar un listado de las pel�culas que est�n en lista de espera y los datos de los socios que las pidieron.
SELECT ci.nombreCinta, so.nombreSocio 
FROM ListaDeEspera le
JOIN Cintas ci ON le.idCinta = ci.idCinta
JOIN Socios so ON le.idSocio = so.IdSocio


--d. Mostrar un listado de clientes que no hayan alquilado ninguna pel�cula en los �ltimos 90 d�as.
SELECT so.nombreSocio
FROM Socios so
WHERE so.idSocio NOT IN (
    SELECT ap.idSocio
    FROM ArchivadorPrestamo ap
    WHERE ap.fechaAlquiler >= getdate()-90)


--e. Mostrar un listado de cantidad de alquileres por d�a de semana y g�nero. (?)
SELECT COUNT(*) AS cantidadAlquileres, ci.generoCinta, DATEPART(dw, ap.fechaAlquiler) AS diaDeLaSemana
FROM ArchivadorPrestamo ap
JOIN Cintas ci ON ap.idCinta = ci.idCinta
GROUP BY DATEPART(dw, ap.fechaAlquiler), ci.generoCinta
ORDER BY diaDeLaSemana ASC
--2 terror el domingo
--2 accion el s�bado


--f. Mostrar un listado de clientes que tienen pel�culas sin devolver y clasificar en prioridad �baja� 
--(los d�as de retraso son 3 o menos), �media� (los d�as de retraso son entre 3 y 6), �alta� (los d�as de retraso son m�s de 6).
SELECT ap.fechaAlquiler, ap.devolucionEstimada, so.nombreSocio,
       CASE
           WHEN datediff(day, ap.devolucionEstimada, getdate()) <= 3 THEN 'Baja'
           WHEN datediff(day, ap.devolucionEstimada, getdate()) BETWEEN 4 AND 6 THEN 'Media'
           ELSE 'Alta'
       END AS Prioridad
FROM ArchivadorPrestamo ap
JOIN Socios so ON ap.idSocio = so.idSocio
WHERE ap.fechaDevolucion is null


--------------------------------

--Colocar a un socio en la lista de espera.
--INSERT INTO ListaDeEspera (idLista, idSocio, idCinta) values (6, 45, 3)


--Hacer un pr�stamo a un socio.
--INSERT INTO ArchivadorPrestamo (idSocio, idCinta, fechaAlquiler, fechaEstimada) values (45, 2, '2024-02-23', '2024-02-28')


--Al prestar, el n�mero de copias disminuye. 
--UPDATE CopiasCintas
--SET cantidadDeCopias = cantidadDeCopias - 1
--WHERE idCinta = 2 and cantidadDeCopias >= 1


--Consultar si la cinta tiene copias disponibles.
--SELECT cc.idCopia, cc.idCinta, c.nombreCinta, cc.cantidadDeCopias
--FROM CopiasCintas cc
--JOIN Cintas c on cc.idCinta = c.idCinta
--WHERE estaDisponible = 1


--Devolver una cinta.
--UPDATE ArchivadorPrestamo
--SET fechaDevolucion = getdate()
--WHERE idSocio = 45 and fechaDevolucion is null and idCinta = 2
--INSERT INTO ArchivadorDevueltas (idDevolucion, fechaDevolucion) values (10, '2024-02-22')


--Conuslar la lista de espera y llamar al primer socio.
--DELETE FROM ListaDeEspera
--WHERE idLista IN (
--    SELECT idLista
--    FROM ListaDeEspera
--    WHERE idCinta = 2)