--a. Mostrar un ranking de las películas más alquiladas.
SELECT COUNT(*) AS cantidadAlquilados, ci.nombreCinta
FROM ArchivadorPrestamo ap
JOIN Cintas ci ON ap.idCinta = ci.idCinta
GROUP BY ci.nombreCinta
ORDER BY cantidadAlquilados DESC
--El bufón
--Madame Web
--Bob Marley


--b. Mostrar un ranking de los clientes que más películas alquilan.
SELECT COUNT(*) AS cantidadAlquilados, so.nombreSocio
FROM ArchivadorPrestamo ap
JOIN Socios so ON ap.idSocio = so.idSocio
GROUP BY so.nombreSocio
ORDER BY cantidadAlquilados DESC
--45 Abigail
--15 Mercedes
--456 Roberto


--c. Mostrar un listado de las películas que están en lista de espera y los datos de los socios que las pidieron.
SELECT ci.nombreCinta, so.nombreSocio 
FROM ListaDeEspera le
JOIN Cintas ci ON le.idCinta = ci.idCinta
JOIN Socios so ON le.idSocio = so.IdSocio


--d. Mostrar un listado de clientes que no hayan alquilado ninguna película en los últimos 90 días.
SELECT so.nombreSocio
FROM Socios so
WHERE so.idSocio NOT IN (
    SELECT ap.idSocio
    FROM ArchivadorPrestamo ap
    WHERE ap.fechaAlquiler >= getdate()-90)


--e. Mostrar un listado de cantidad de alquileres por día de semana y género. (?)
SELECT COUNT(*) AS cantidadAlquileres, ci.generoCinta, DATEPART(dw, ap.fechaAlquiler) AS diaDeLaSemana
FROM ArchivadorPrestamo ap
JOIN Cintas ci ON ap.idCinta = ci.idCinta
GROUP BY DATEPART(dw, ap.fechaAlquiler), ci.generoCinta
ORDER BY diaDeLaSemana ASC
--2 terror el domingo
--2 accion el sábado


--f. Mostrar un listado de clientes que tienen películas sin devolver y clasificar en prioridad “baja” 
--(los días de retraso son 3 o menos), “media” (los días de retraso son entre 3 y 6), “alta” (los días de retraso son más de 6).
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


--Hacer un préstamo a un socio.
--INSERT INTO ArchivadorPrestamo (idSocio, idCinta, fechaAlquiler, fechaEstimada) values (45, 2, '2024-02-23', '2024-02-28')


--Al prestar, el número de copias disminuye. 
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