/* 1) Listar los nombres de los clientes que tienen asignado el representante García Gómez, Luis
Antonio (suponiendo que no pueden haber representantes con el mismo nombre). */
select c.nombre
from clientes c
where c.codRepresentante = (select codEmpleado from empleados e where e.nombre = "García Gómez, Luis Antonio") ;

select c.nombre
from empleados e join clientes c on e.codEmpleado = c.codRepresentante
where e.nombre = "García Gómez, Luis Antonio";

/* 2) Listar los vendedores (codEmpleado, nombre, y no de oficina) que trabajan en oficinas "buenas"
(las que tienen ventas superiores a su objetivo). */
select e.codEmpleado, e.nombre
from empleados e
where e.oficina in (select codOficina from oficinas where objetivo > ventas);

/* 3) Listar los vendedores que no trabajan en oficinas dirigidas por el empleado 108. */
select e.*
from empleados e
where e.codJefe <> 108;

/* 4) Listar los productos (idfabricante, idproducto y descripción) para los cuales no se ha recibido
ningún pedido de 500 € o más. */
select p.idFabricante, p.idProducto, p.descripcion
from productos p
where p.idProducto not in(
select distinct lp.producto
from lineaspedido lp
where (lp.cantidad * lp.precioVenta) > 500);

/* 5) Listar los clientes asignados a García Gómez, Luis Antonio que no han remitido un pedido
superior a 5.000 €. */
select c.*
from clientes c
where c.codRepresentante =(select e.codEmpleado
from empleados e where e.nombre = "García Gómez, Luis Antonio") and c.codCliente in(
select distinct p.codCliente from pedidos p join lineaspedido lp on p.codPedido = lp.codPedido
group by p.codCliente, p.codPedido having sum(lp.cantidad * lp.precioVenta) > 5000);

## JOINS
select c.codCliente, c.nombre, e.codEmpleado, e.nombre
from clientes c join empleados e on c.codRepresentante = e.codEmpleado
where e.nombre = "García Gómez, Luis Antonio";

/* 6) Listar las oficinas en donde haya un vendedor cuyas ventas representen más del 55% del objetivo
de su oficina. */
## el profe decide no hacerlo con subconsultas
select e.codEmpleado, e.nombre, sum(lp.cantidad * lp.precioVenta) as "Total vendedor",
o.objetivo, round((o.objetivo * 0.55), 2) as "55%"
from empleados e
join pedidos p on e.codEmpleado = p.codRepresentante
join lineaspedido lp using(codPedido)
join oficinas o on e.oficina = o.codOficina
group by e.codEmpleado
having (sum(lp.cantidad * lp.precioVenta)) > (round((o.objetivo * 0.55), 2));

/* 7) Listar las oficinas en donde todos los vendedores tienen sueldos que superan al 50% del objetivo
de la oficina. */
/* select e.codEmpleado, e.nombre, e.sueldo, o.objetivo, round((o.objetivo * 0.5), 2) as "50%"
from empleados e
join oficinas o on e.oficina = o.codOficina
where e.sueldo > round((o.objetivo * 0.5), 2) && o.objetivo is not null; */
/* select tablaObjetivos.empleado, tablaObjetivos.nombre, tablaObjetivos.salario, tablaObjetivos.mitad_objetivo 
from (select e.codEmpleado as empleado, e.nombre as nombre, e.sueldo as salario,
o.objetivo as objeivo, round((o.objetivo * 0.5), 2) as mitad_objetivo
from empleados e
join oficinas o on e.oficina = o.codOficina
where e.sueldo > round((o.objetivo * 0.5), 2)) tablaObjetivos
where tablaObjetivos.salario > tablaObjetivos.mitad_objetivo; */
select o.codOficina, o.ciudad
from oficinas o
where (o.objetivo * 0.5) < (select min(e.sueldo) from empleados e where e.oficina = o.codOficina);

/* 8) Listar las oficinas que tengan un objetivo mayor que la suma de los objetivos de sus vendedores. */
select o.codOficina, o.objetivo, sum(e.sueldo)
from oficinas o join empleados e on o.codOficina = e.oficina
group by e.oficina
having o.objetivo is not null && sum(e.sueldo) < o.objetivo;

/* 9) Hallar cuántos pedidos (total de cada pedido) hay de más de 1800 €. */
select count(*)
from (
	select lp.codPedido, sum(lp.cantidad * lp.precioVenta)
	from lineaspedido lp
	group by lp.codPedido
	having sum(lp.cantidad * lp.precioVenta) > 1800)
pedidos1800;

/* 10) Saber cuántas oficinas tienen empleados con ventas superiores a su objetivo, no queremos saber
cuáles sino cuántas hay. */
select e.codEmpleado, e.nombre, e.objetivo, sum(lp.cantidad * lp.precioVenta)
from empleados e join pedidos p on e.codEmpleado = p.codRepresentante
join lineaspedido lp on p.codPedido = lp.codPedido;

/* 11) Listar las oficinas en donde todos los vendedores tienen ventas que superan al 50% del objetivo
de la oficina. */
select o.codOficina, o.objetivo, e.codEmpleado
from oficinas o join empleados e on e.oficina = o.codOficina
where o.objetivo is not null ;

/* 12) Seleccionar los pedidos, entendiendo por un pedido el Código del pedido y todas sus líneas, con
un importe superior a 30.000€. */


/* 13) Listar las oficinas que no tienen director. */
select o.codOficina
from oficinas o
where not exists (
	select * from directores d where d.codOficina = o.codOficina);
    
select o.codOficina, d.idDirector
from oficinas o left join directores d using(codOficina)
where d.idDirector is null;

/* 14) Seleccionar los clientes que no han realizado ningún pedido. */
select c.codCliente, c.nombre
from clientes c
where not exists(
	select * from pedidos p where p.codCliente = c.codCliente);

select c.codCliente, c.nombre, p.codPedido
from pedidos p right join clientes c using(codCliente)
where p.codPedido is null;

/* 15) Seleccionar los productos que no han sido vendidos. */
select p.idProducto, p.descripcion, p.existencias
from productos p
where (
	select count(*) from lineaspedido lp where lp.producto = p.idProducto
) = 0;

select p.idProducto, p.descripcion
from productos p left join lineaspedido lp on p.idProducto = lp.producto
where lp.codPedido is null;

/* 16) Seleccionar los representantes que no han realizado ninguna venta, indicando el nombre del
empleado. */
select * from (
	select distinct e.codEmpleado, e.nombre
	from empleados e left join pedidos p on e.codEmpleado = p.codRepresentante
	where p.codPedido is not null)
a; 