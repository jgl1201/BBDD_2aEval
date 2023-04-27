/* TABLA customer */
#1 ¿Dónde vive 'JUDY GRAY'
select c.first_name, c.last_name, ci.city
from customer c join address ad using(address_id)
join city ci using(city_id)
where c.first_name = 'JUDY' and c.last_name = 'GRAY';

#2 ¿En cuántos países viven nuestros clientes? (países distintos)
select count(distinct co.country_id) as "Paises con clientes"
from customer cu join address ad using(address_id)
join city ci using (city_id) join country co using (country_id);
## en que pais no hay clientes
select co.country
from customer cu join address ad using(address_id)
join city ci using (city_id) right join country co using (country_id)
where cu.customer_id is null;

#3 ¿Cuántos clientes viven en Egipto?
select count(distinct cu.customer_id) as "Clientes Egipto"
from customer cu join address ad using(address_id)
join city ci using (city_id) join country co using (country_id)
where co.country = 'Egypt';

#4 ¿En qué ciudades de Egipto viven nuestros clientes?
select c.city
from city c join country co using(country_id)
where co.country = 'Egypt';

#5 ¿Cuántos clientes viven fuera de Estados Unidos? (UNITED STATES)
select count(*) as "clientes no americanos"
from customer cu join address ad using(address_id)
join city ci using (city_id) join country co using (country_id)
where co.country <> 'UNITED STATES';

/* TABLA film */
#1 Cuántas películas duran 90 o menos minutos?
select count(*), max(f.length), min(f.length), round((avg(length)), 2)
from film f
where f.length <= 90;

#2 Cuántas películas van de astronautas?
select count(*)
from film f
where f.description like '%astronaut%';

#3 Lista todas las películas que duren como mucho 90 minutos y sean de astronautas.
select f.*
from film f
where f.length <= 90 and f.description like '%astronaut%';

#4 Lista los títulos de todas las películas, ordenadas por duración, de forma descendente
select f.title, f.length
from film f
order by f.length desc;

/* TABLAS Customer y Customer_list */
/* 1- La tabla de clientes maneja el nombre y el apellido de los clientes en campos
separados, mientras que la tabla customer_list los almacena en un único campo.
Se desea usar la tabla de customer_list para obtener el nombre de los clientes, pero
queremos obtener la dirección de email y el estatus activo de los clientes de la tabla
de clientes. */
select cl.name, cu.email, cu.active
from customer_list cl join customer cu on (cl.ID = cu.customer_id);

/* 2- Haz una lista que muestre el customer_id, el nombre del cliente, la dirección de
correo electrónico y el estatus activo, ordenar la lista por el ID del cliente. */
select cu.customer_id, cl.name, cu.email, cu.active
from customer cu join customer_list cl on (cl.ID = cu.customer_id)
order by cu.customer_id;

/* 3- Muestra una lista que contenga el ID de la ciudad, nombre de las ciudades y el
nombre de su país para aquellas ciudades donde haya clientes. Ordenar la lista por el
nombre del país. */
select distinct(ci.city_id), ci.city, co.country
from customer cu join address ad using(address_id)
join city ci using (city_id) join country co using (country_id)
where cu.customer_id is not null
order by co.country;