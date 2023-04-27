#1 Averigua el nombre completo y dirección de correo electrónico de los clientes que han alquilado películas de acción.
select concat(cu.first_name, " ", cu.last_name) Nombre, cu.email, count(*) Copias_alquiladas
from customer cu join rental re using(customer_id) join inventory i using(inventory_id)
join film_category fc using(film_id) join category ca using(category_id)
where ca.name = 'Action'
group by cu.customer_id
order by 3 desc;

#2 Muestra el nombre de cada película, su categoría y el número total de películas de dicha categoría. (Pista: Se pueden hacer JOINS con subconsultas)
-- La subconsulta saca el numero de copias que hay en cada categoria
select fi.title, ca.name, Pelis_categoraia.Copias Copias_categoria
from film fi join film_category fc using(film_id) join category ca using(category_id)
join (select fc.category_id Categoria, count(*) Copias
	from film_category fc group by fc.category_id) Pelis_categoraia
on fc.category_id = Pelis_categoraia.Categoria;

#3 Calcula el importe medio de los pagos de cada usuario. (Sin subconsulta)
select cu.customer_id, concat(cu.first_name, " ", cu.last_name) Nombre, round(avg(pa.amount), 2) Media_pagos
from customer cu join payment pa using(customer_id)
group by cu.customer_id;

#4 Encuentra los pagos que superan la media de cada usuario, así como el total de pagos que superan la media.
select pa.customer_id, pa.amount
from payment pa
where pa.amount > (select avg(pa2.amount) from payment pa2 where pa2.customer_id = pa.customer_id);

#5 Obtén los actores que han trabajado en todas las películas en las que ha trabajado Christopher West
-- La primera subconsulta saca los actores que han trabajado en alguna de las peliculas de West
-- La segunda pide que haya trabajado en las 21 peliculas de West (no hay nadie que no sea el)
select fa.actor_id, a.first_name, a.last_name, count(*)
from film_actor fa join actor a using(actor_id) join (
	select fa.film_id as id_peli
	from actor ac join film_actor fa using(actor_id)
	where ac.first_name = 'Christopher' and ac.last_name = 'West') as pelis_Chris
on fa.film_id = pelis_Chris.id_peli
group by fa.actor_id
having count(*) = (
	select count(fa.film_id) as id_peli
	from actor ac join film_actor fa using(actor_id)
	where ac.first_name = 'Christopher' and ac.last_name = 'West');

#6 CONSULTA QUE OBTIENE LOS ACTORES QUE HAN COLABORADO EN ALGUNA LAS PELÍCULAS EN LAS QUE HA TRABAJADO EL ACTOR CHRISTOPHER WEST
-- Si el count es mayor que 0 significa que como poco ha participado en una de las peliculas
select fa.actor_id, a.first_name, a.last_name, count(*) as pelis_comunes
from film_actor fa join actor a using(actor_id) join (
	select fa.film_id as id_peli
	from actor ac join film_actor fa using(actor_id)
	where ac.first_name = 'Christopher' and ac.last_name = 'West') as pelis_Chris
on fa.film_id = pelis_Chris.id_peli
group by fa.actor_id
HAVING COUNT(*) > 0;

#9 Obtén el total de lo que ha gastado cada cliente en el alquiler de películas
select concat(cu.first_name, " ", cu.last_name), sum(pa.amount) as Total_pagado
from customer cu join payment pa using(customer_id)
group by pa.customer_id;

#10 Obtén el total de lo que ha gastado cada cliente en el alquiler de películas, siempre que éste sea mayor a 100.
select concat(cu.first_name, " ", cu.last_name), sum(pa.amount) as Total_pagado
from customer cu join payment pa using(customer_id)
group by pa.customer_id
having sum(pa.amount) > 100;

#11 Lista los alquileres cuyo importe esté por encima de la media
select re.rental_id, pa.amount
from rental re join payment pa using(rental_id)
where pa.amount > (select avg(pa.amount) from payment pa);

#12 Clientes con más películas alquiladas de los clientes que empiezan por ‘A’
select concat(cu.first_name, " ", cu.last_name) Cliente, count(*) Alquileres
from customer cu join rental re using(customer_id)
where cu.first_name like 'A%'
group by cu.customer_id
order by 2 desc;

#13 Clientes con más películas alquiladas que alguno de los clientes que empiezan por ‘A’
select concat(cu.first_name, " ", cu.last_name) Cliente, count(*) Alquileres
from customer cu join rental re using(customer_id)
where substring(cu.first_name, 1, 1) <> 'a'
group by cu.customer_id
having count(*) > any (select count(*)
	from customer cu join rental re using(customer_id)
    where cu.first_name like 'A%'
	group by cu.customer_id)
order by 2 desc;

#14 Clientes con más películas alquiladas que todos los clientes que empiezan por ‘A’
select concat(cu.first_name, " ", cu.last_name) Cliente, count(*) Alquileres
from customer cu join rental re using(customer_id)
where substring(cu.first_name, 1, 1) <> 'a'
group by cu.customer_id
having count(*) > all (select count(*)
	from customer cu join rental re using(customer_id)
    where cu.first_name like 'A%'
	group by cu.customer_id)
order by 2 desc;

#15 Actores con más películas que el actor de id 1
select concat(ac.first_name, " ", ac.last_name) Actor, count(*) Pelis
from actor ac join film_actor fa using(actor_id) join film fi using(film_id)
where ac.actor_id <> 1
group by ac.actor_id
having count(*) > (select count(*)
	from actor ac join film_actor fa using(actor_id) join film fi using(film_id)
	where ac.actor_id = 1)
order by 2 desc;

#16 Actores que trabajan en películas con rating ‘R’
select concat(ac.first_name, " ", ac.last_name) Actor
from actor ac join film_actor fa using(actor_id) join film fi using(film_id)
where fi.rating = 'R'
group by ac.actor_id;

#17 Actores que no han trabajado en películas con rating ‘R’
select concat(ac.first_name, " ", ac.last_name) Actor
from actor ac join film_actor fa using(actor_id) join film fi using(film_id)
where fi.rating <> 'R'
group by ac.actor_id;

#18 Actores que no hayan trabajado en películas de rating ‘R’ con exists


#19 Clientes que no han alquilado  películas de rating ‘R’


#20 ¿Qué actores no han trabajo en la categoría 'Música'?


#21 Actores que no están en la anterior consulta


#22 Media de películas por categoría


#23 Películas con más actores que la media de actores por película
