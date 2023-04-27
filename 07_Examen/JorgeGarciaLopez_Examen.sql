#2.1. Mostrar los nombres y apellidos de todos los actores de la tabla actor
select first_name Nombre, last_name Apellidos from actor;

/*2.2. Devuelva los actores cuyos apellidos contengan las letras LI. Esta vez, 
ordene las filas por apellido y nombre, en ese orden */
select first_name Nombre, last_name Apellidos
from actor
where last_name like '%li%'
order by 2, 1;

/*2.3. Con IN, muestre las columnas country_id y country de los siguientes países:
Afganistán, Bangladesh y China */
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

/*2.4. Enumere los apellidos de los actores y la cantidad de actores que tienen ese
apellido, pero solo para los nombres que comparten al menos dos actores */
select last_name, count(last_name) Apellidos
from actor
group by last_name
having count(last_name) > 1 && count(first_name) > 1;

#2.5. Muestre el importe total cobrado por cada trabajador en agosto de 2005
select st.staff_id, concat(st.first_name, " ", st.last_name) Nombre, sum(pa.amount) Total_Agosto2005
from staff st join payment pa using(staff_id)
where pa.payment_date between '2005-08-01 00:00:00' and '2005-08-31 23:59:59'
group by st.staff_id;

#2.6. Liste todas las películas y el numero de actores que aparecen en cada película
select fi.title, count(fa.actor_id) Actores
from film fi join film_actor fa using(film_id)
group by fi.film_id; 

#2.7. ¿Cuántas copias de la película Hunchback Impossible existen en el inventario?
select fi.title, count(i.inventory_id) Numero_Copias
from inventory i join film fi using(film_id)
where fi.title = 'Hunchback Impossible';

/*2.8. Liste los 5 géneros principales en ingresos en orden descendente
(Es posible que necesite usar: category, film_category, inventory, payment y rental) */
select ca.name, sum(pa.amount) Generado
from category ca join film_category fc using(category_id)
join inventory i using(film_id) join rental re using(inventory_id)
join payment pa using(rental_id)
group by ca.category_id
order by 2 desc limit 5;

#2.9. Muestre el importe pagado para aquellos clientes de Estados Unidos
select concat(cu.first_name, " ", cu.last_name) Cliente, sum(pa.amount) Total_pagado
from customer cu join address ad using(address_id) join city ci using(city_id)
join country co using(country_id) join rental using(customer_id)
join payment pa using(rental_id)
where co.country = 'United States'
group by cu.customer_id;

/*2.10. La música de Queen y Kris Kristofferson ha visto un resurgimiento impensable.
Como consecuencia inseperada, las películas que comienzan con 'K' y 'Q' también se han disparado
en cuánto a alquileres. Use subconsultas para mostrar los títulos de películas que
comienzan con 'K' o 'Q' cuyo idioma sea inglés */
select title
from film
where (title like 'K%' or title like 'Q%') &&
language_id = (select language_id from language where name = 'English');