# 1. Visualiza los 10 actores que han participado en más películas.
select fa.actor_id ID, concat(a.first_name, " ", a.last_name) as Name, count(*) as Num_Films
from film_actor fa join actor a using(actor_id)
group by fa.actor_id
order by 3 desc, 2 asc limit 10;

# 2. Visualiza los clientes de países que empiezan por S.
select cu.customer_id, cu.first_name, co.country
from customer cu join address ad using(address_id)
join city ci using (city_id) join country co using (country_id)
where co.country like "S%";

# 3. Visualiza el top-10 de países con más clientes.
select co.country as Country, count(cu.customer_id) Num_customers
from country co join city ci using(country_id)
join address ad using(city_id) join customer cu using(address_id)
group by co.country_id
order by 2 desc limit 10;

/* 4. Saca las 10 primeras películas alfabéticamente y el número de copias que se
disponen de cada una de ellas. */
select f.film_id, f.title, count(i.inventory_id) Num_copys
from film f join inventory i using(film_id)
group by f.title order by 3 desc, 1 limit 10;

# 5. Saca todas las películas que ha alquilado el cliente Deborah Walker.
select f.film_id, f.title, count(*) num_veces
from customer cu join rental r using(customer_id)
join inventory i using(inventory_id) join film f using(film_id)
where cu.first_name = "Deborah" and cu.last_name = "Walker"
group by f.film_id;

# 6. Visualiza los 10 mejores clientes.
select cu.customer_id, concat(cu.first_name, " ", cu.last_name) as Name, sum(p.amount) Total
from customer cu join rental r using(customer_id)
join payment p using(rental_id)
group by cu.customer_id
order by 3 desc limit 10;

/* 7. Averigua la popularidad de las categorías cinematográficas entre los clientes
españoles. */
select fc.category_id, ca.name, count(*) num_alquileres
from customer cu join address ad using(address_id) join city ci using(city_id)
join country co using(country_id) join rental re using(customer_id)
join inventory i using(inventory_id) join film_category fc using(film_id)
join category ca using(category_id)
where co.country = 'spain'
group by fc.category_id
order by 3 desc;

# 8. Selecciona los 10 actores más populares en Argentina.
select fa.actor_id, concat(ac.first_name, " ", ac.last_name) nombre, count(*)
from customer cu join address ad using(address_id) join city ci using(city_id)
join country co using(country_id) join rental re using(customer_id)
join inventory i using(inventory_id) join film_actor fa using(film_id)
join actor ac using(actor_id)
where co.country = 'argentina'
group by fa.actor_id
order by 3 desc limit 10;

/* 9. Averigua cuál es la película más alquilada de entre las que trabaja Sandra Kilmer
(Aunque hay dos películas, con mostrar cualquiera de las dos sería suficiente) */
select i.film_id, f.title, count(*) alquileres
from actor ac join film_actor fa using(actor_id) join film f using(film_id)
join inventory i using(film_id) join rental re using(inventory_id)
where ac.first_name = 'Sandra' and ac.last_name = 'Kilmer'
group by i.film_id
order by 3 desc limit 1;
## mejora para sacar las que tengan el mismo numero de alquileres
select i.film_id, f.title, count(*) alquileres
from actor ac join film_actor fa using(actor_id) join film f using(film_id)
join inventory i using(film_id) join rental re using(inventory_id)
where ac.first_name = 'Sandra' and ac.last_name = 'Kilmer'
group by i.film_id
having count(*) = (select count(*) alquileres from actor ac
	join film_actor fa using(actor_id) join inventory i using(film_id)
	join rental re using(inventory_id)
	where ac.first_name = 'Sandra' and ac.last_name = 'Kilmer'
	group by i.film_id order by 1 desc limit 1);
 
/* 10. Averigua cuál es la duración media de las películas que están ahora mismo
alquiladas. */
/* 11. Cómo lo has hecho? Te has planteado tener en cuenta que una misma película puede
estar alquilada varias veces? Podrías entonces re-calcular la media contando cada
película una vez, sabiendo que en este caso no hay dos películas con la misma
duración? */
select avg(peliculas.duracion) duracion_media from (
select distinct(f.film_id), f.length duracion
from rental re join inventory i using(inventory_id) join film f using(film_id)
where re.return_date is null) peliculas ;

/* 12. Calcula la tienda que más alquileres de películas del género infantil (Children)
realizó entre agosto y septiembre de 2005. */
select st.store_id Tienda, re.rental_date, count(*)
from store st join inventory i using(store_id) join rental re using(inventory_id)
join film fi using(film_id) join film_category fc using(film_id)
join category ca using(category_id)
where re.rental_date between '2005-08-01 00:00:00' and '2005-09-30 23:59:59'
and ca.name = 'children'
group by st.store_id
order by 3 desc limit 1;

# 13. Visualiza los trabajadores que trabajan en la misma ciudad donde residen.
select * from 
(select concat(st.first_name, " ", st.last_name) Nombre, ci.city as city
from staff st join address ad using(address_id) join city ci using(city_id)) tablaA
join (select ci.city as city
from store st join address ad using(address_id) join city ci using(city_id)) tablaB
using(city);

# 14. Averigua los 10 clientes que más dinero han gastado.
select cu.customer_id, concat(cu.first_name, " ", cu.last_name) customer_name, sum(pa.amount) total_gastado
from customer cu join payment pa using(customer_id)
group by cu.customer_id
order by 3 desc limit 10;

# 15. Calcula ahora las 10 películas que más dinero han generado a la empresa.
select sum(pa.amount) cantidad_generada, fi.title
from film fi join inventory i using(film_id) join rental re using(inventory_id)
join payment pa using(rental_id)
group by fi.film_id
order by 1 desc limit 10;