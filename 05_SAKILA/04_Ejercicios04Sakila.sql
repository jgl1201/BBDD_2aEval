# 1. Actores que tienen de primer nombre ‘Scarlett’.
select *
from actor ac
where ac.first_name = 'Scarlett';

# 2. Actores que tienen de apellido ‘Johansson’.
select *
from actor ac
where ac.last_name = 'Johansson';

# 3. Actores que contengan una ‘O’ en su nombre.
select *
from actor ac
where ac.first_name like '%o%';

# 4. Actores que contengan dos ‘O’ en su nombre y en una ‘A’ en su apellido.
select *
from actor ac
where ac.first_name like '%o%o%' && ac.last_name like '%a%';

# 5. Listar las ciudades con nombres compuestos.
select *
from city ci
where ci.city like '% %' or ci.city like '%-%';

# 6. Listar las películas con una duración entre 80 y 100.
select *
from film fi
where fi.length between 80 and 100;

# 7. Mostrar las ciudades del country Spain (consulta multitabla).
select ci.city, co.country
from city ci join country co using(country_id)
where co.country = 'Spain';

# 8. Mostrar el nombre de la película y el nombre de los actores que participan en ella.
select concat(ac.first_name, " ", ac.last_name) Nombre, fi.title Peli
from film fi join film_actor fa using(film_id) join actor ac using(actor_id)
order by 2;
## CONSULTA CON UN group_concat; APARECEN TODOS LOS NOMBRES DE LA PELI EN UNA SOLA LINEA
select group_concat(ac.first_name, " ", ac.last_name) Actores, fi.title Peli
from film fi join film_actor fa using(film_id) join actor ac using(actor_id)
group by fi.film_id
order by 2;

# 9. Mostrar el country, la ciudad y dirección de cada miembro del staff.
select concat(st.first_name, " ", st.last_name) Nombre, ad.address, ci.city, co.country
from staff st join address ad using(address_id) join
city ci using(city_id) join country co using(country_id);

# 10. Mostrar el country, la ciudad y dirección de cada customer.
select concat(cu.first_name, " ", cu.last_name) Nombre, ad.address, ci.city, co.country
from customer cu join address ad using(address_id) join
city ci using(city_id) join country co using(country_id);

# 11. Direcciones de california que tengan ‘274’ en el número de teléfono
select *
from address ad join city ci using(city_id)
where ci.city = 'California' and ad.phone like '%274%';
-- NO HAY NINGUN REGISTRO PARA CALIFORNIA

# 12. Películas ‘Épicas’ (Epic) o ‘Brillantes’ (brilliant) que duren más de 180 minutos
select fi.title, fi.length, fi.description
from film fi
where fi.length > 180 and (fi.description like '%Epic%' or fi.description like '%Brilliant%');

# 13. Películas que duren entre 100 y 120 minutos o entre 50 y 70 minutos
select fi.title, fi.length
from film fi
where fi.length between 100 and 120 or fi.length between 50 and 70;

/* 14. Películas que cuesten 0.99, 2.99 y tengan un rating ‘g’ o ‘r’ y que hablen de cocodrilos
(cocodrile) */
select fi.title, fi.rating, fi.rental_rate
from film fi 
where fi.rating in ('g', 'r') and fi.description like '%crocodile%'
and fi.rental_rate in(0.99 ,2.99);

/* 15. Direcciones de Ontario o de Punjab o que su código postal acabe en 5 o que su teléfono
acabe en 5 */
select ad.address, ad.district, ad.postal_code, ad.phone
from address ad
where ad.district in ('Ontario', 'Punjab') or (ad.postal_code like '%5' or ad.phone like '%5');

# 16. Alquileres con un pago por encima de la media
select pa.payment_id, pa.amount
from payment pa
where pa.amount > (select avg(pa.amount) from payment pa)
order by 2;

# 17. Actores que no han trabajado en películas con rating ‘R’
select concat(ac.first_name, " ", ac.last_name) Nombre
from actor ac left join (select distinct ac.actor_id actor_id
	from actor ac join film_actor fa using(actor_id) join film fi using(film_id)
	where fi.rating = 'r') ActoresR using(actor_id)
where ActoresR.actor_id is null;

# 18. Mostrar la categoría con menos películas
select ca.category_id, ca.name, min(Tabla.Numero) 
from(select ca.category_id as category_id, count(*) Numero
	from film fi join film_category using(film_id) join category ca using(category_id)
	group by ca.category_id ) as Tabla join category ca using(category_id);

# 19. Películas en las que han trabajado más de 10 actores
select fi.title, count(ac.actor_id) Actores
from film fi join film_actor fa using(film_id) join actor ac using(actor_id)
group by fi.film_id
having count(ac.actor_id) > 10;

# 20. Películas en las que han trabajado más de 10 actores
select fi.title, count(ac.actor_id) Actores
from film fi join film_actor fa using(film_id) join actor ac using(actor_id)
group by fi.film_id
having count(ac.actor_id) > 10;

# 21. El título de la película que más se ha alquilado (en número de alquileres)
select fi.title, max(Num_alquileres.Alquileres) from (select fi.film_id film_id, count(re.rental_id) Alquileres
	from film fi join inventory i using(film_id) join rental re using(inventory_id)
	group by fi.film_id) Num_alquileres join film fi using(film_id);

# 22. El título de la película que más dinero ha dado (en suma de importe)
select fi.title, max(Suma_pagos.Total_pagado) from (select fi.film_id film_id, sum(pa.amount) Total_pagado
	from film fi join inventory i using(film_id) join rental re using(inventory_id)
	join payment pa using(rental_id)
	group by fi.film_id) Suma_pagos join film fi using(film_id);

# 23. Los 5 actores que han trabajado en menos películas
select concat(ac.first_name, " ", ac.last_name) Actor, count(fi.film_id) Peliculas
from actor ac join film_actor fa using(actor_id) join film fi using(film_id)
group by ac.actor_id
order by 2 asc limit 5;

/* 24. La referencia para los clientes es las dos primeras letras de su nombre y las dos primeras
letras de su apellido. */
select substr(cu.first_name, 1, 2) Nombre2, substr(cu.last_name, 1, 2) Apellido2
from customer cu;

# 25. Hacer una consulta que nos muestre el id del cliente y esa referencia.
select cu.customer_id, concat(substr(cu.first_name, 1, 2), " ", substr(cu.last_name, 1, 2)) Referencia
from customer cu;

# 26. Listar todos los pagos que se han hecho un viernes.
select pa.*, dayname(pa.payment_date) Nombre_dia
from payment pa
where dayname(pa.payment_date) = 'friday';

# 27. Clientes que no han alquilado documentales (‘documentary’)
select *
from customer where customer_id not in
(select cu.customer_id 
from customer cu join rental re using(customer_id) join inventory i using(inventory_id)
join film fi using(film_id) join film_category fc using(film_id) join category ca using(category_id)
where ca.name = 'documentary');