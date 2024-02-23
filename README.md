Se desea diseñar una base de datos relacional que almacene la información sobre los préstamos de las películas de un vídeo club. En la actualidad la gestión de esta información se lleva cabo del siguiente modo:

Cuando se hace un préstamo se rellena una ficha en la que se anota el socio que se lleva la película, la fecha y el número de la cinta que se lleva, que es único (de cada película hay varias copias en cintas distintas) y la fecha de devolución. 
Esta ficha se deposita en el archivador de películas prestadas. 
Cuando el socio devuelve la cinta, la ficha se pasa al archivador de películas devueltas. El vídeo club tiene, además, un archivador con fichas de películas ordenadas por título. 
Cada ficha tiene además el género de la película (comedia, terror, ...), su director y los nombres de los actores que intervienen. 
También se tiene un archivador con las fichas de los socios, ordenadas por el código que el vídeo club les da cuando les hace el carnet. 
Cada ficha tiene el nombre del socio, su dirección y teléfono, los nombres de sus directores favoritos, los nombres de sus actores favoritos y los géneros cinematográficos de su preferencia. 
Cuando un socio quiere tomar prestada una película de la que no hay copias disponibles, se le puede anotar en la lista de espera de esa película. Cada vez que se devuelve una película, se comprueba si hay alguien en su lista de espera, y si es así se llama por teléfono al primer socio de la lista para decirle que ya puede pasar a recogerla, borrándolo luego de la lista.

Se requiere:

1. Desarrollar el diagrama entidad-relación correspondiente a la especificación de requisitos.
2. Se deben señalar los atributos que son clave primaria y los que son clave foránea, especificando si aceptan nulos.
3. Escribir consultas en lenguaje SQL o en su defecto expresiones regulares para:
- a. Mostrar un ranking de las películas más alquiladas.
- b. Mostrar un ranking de los clientes que más películas alquilan.
- c. Mostrar un listado de las películas que están en lista de espera y los datos de los socios que las pidieron.
- d. Mostrar un listado de clientes que no hayan alquilado ninguna película en los últimos 90 días.
- e. Mostrar un listado de cantidad de alquileres por día de semana y género.
- f. Mostrar un listado de clientes que tienen películas sin devolver y clasificar en prioridad “baja” (los días de retraso son 3 o menos), “media” (los días de retraso son entre 3 y 6), “alta” (los días de retraso son más de 6).
