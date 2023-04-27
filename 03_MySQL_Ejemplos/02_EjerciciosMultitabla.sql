/* 1) Listar las oficinas de Galicia indicando para cada una de ellas su número, ciudad, códigos y
nombres de sus empleados. Hacer una versión en la que aparecen sólo las que tienen empleados,
y hacer otra en las que aparezcan las oficinas de Galicia que no tienen empleados. */
## JOIN
select codOficina, ciudad, region, codEmpleado, nombre
from oficinas join empleados
on oficinas.codOficina = empleados.oficina
where oficinas.region = 'Galicia';

select codOficina, ciudad, region, codEmpleado, nombre
from oficinas left join empleados
on oficinas.codOficina = empleados.oficina
where oficinas.region = 'Galicia' and
empleados.codEmpleado is null; /* borrar para mostrar con y sin empleados */

## P.CARTESIANO
select codOficina, ciudad, region, codEmpleado, nombre
from oficinas, empleados
where oficinas.codOficina = empleados.oficina
and oficinas.region = 'Galicia';

/* 2) Listar los pedidos mostrando su número, fecha del pedido, nombre del cliente, y el límite de
crédito del cliente correspondiente (todos los pedidos tienen cliente y representante). */
select codPedido, fechaPedido, nombre
from clientes, pedidos
where clientes.codCliente = pedidos.codCliente;

/* 3) Listar los datos de cada uno de los empleados, la ciudad y región en donde trabaja. */
select codEmpleado, nombre, oficina, ciudad, region
from empleados left join oficinas
on oficinas.codOficina = empleados.oficina;

/* 4) Listar las oficinas con objetivo superior a 3.500€ indicando para cada una de ellas el nombre de
su director. */
select codOficina, ciudad, region, oficinas.objetivo, empleados.nombre
from oficinas join directores using(codOficina)
join empleados on empleados.codEmpleado = directores.codDirector
where oficinas.objetivo > 3500;

select oficinas.codOficina, ciudad, region, oficinas.objetivo, empleados.nombre
from oficinas, directores, empleados
where oficinas.objetivo > 3500 &&
oficinas.codOficina = directores.codOficina &&
empleados.codEmpleado = directores.codDirector;

/* 5) Listar las líneas de pedido superiores a 150 €, incluyendo el nombre del empleado que tomó el
pedido y el nombre del cliente que lo solicitó. */
select fabricante, producto, cantidad, precioVenta, cantidad*precioVenta as Importe,
	e.nombre as Comercial, c.nombre as Cliente
from lineaspedido as lp join pedidos as p using(codPedido)
	join clientes as c using(codCliente)
    join empleados as e on p.codRepresentante = e.codEmpleado
where cantidad*precioVenta > 150
order by Importe;

select fabricante, producto, cantidad, precioVenta, cantidad*precioVenta as Importe,
	e.nombre as Comercial, c.nombre as Cliente
from lineaspedido lp, pedidos p, clientes c, empleados e
where p.codPedido = lp.codPedido &&
	p.codCliente = c.codCliente &&
	p.codRepresentante = e.codEmpleado &&
	cantidad*precioVenta > 150
order by Importe;

/* 7) Listar los empleados con un sueldo superior al de su jefe; para cada empleado sacar sus datos y el
número, nombre y sueldo de su jefe. */
select e.codEmpleado, e.nombre, e.sueldo, j.codEmpleado, j.nombre, j.sueldo
from empleados e join empleados j
on j.codEmpleado = e.codJefe
where e.sueldo > j.sueldo;

/* 8) Listar los códigos y nombre de los empleados que tienen una línea de pedido superior a 5.000 € o
que tengan un objetivo inferior a 200.000 €. (El empleado deberá mostrarse una vez) */
select distinct e.codEmpleado, e.nombre
from lineaspedido l join pedidos p using(codPedido)
	join empleados e on codRepresentante = codEmpleado
where objetivo > 5000 or cantidad*precioVenta < 200000;

/* 9) Listar las 5 líneas de pedido con mayor importe indicando el nombre del cliente, del producto y
del representante. */
select fabricante, producto, descripcion, cantidad*precioVenta as Importe,
	e.nombre as Comercial, e.nombre as Cliente
from productos pr join lineaspedido l on idFabricante = fabricante && idProducto = producto
	join pedidos pe using(codPedido)
    join clientes c using(codCliente)
    join empleados e on pe.codRepresentante = codEmpleado
order by Importe desc
limit 5;

select fabricante, producto, descripcion, cantidad*precioVenta as Importe,
	e.nombre as Comercial, e.nombre as Cliente
from productos pr, lineaspedido l, pedidos pe, clientes c, empleados e
where pe.codPedido = l.codPedido &&
	pe.codCliente = c.codCliente &&
    e.codEmpleado = pe.codRepresentante &&
    pr.idFabricante = l.fabricante &&
    pr.idProducto = l.producto
order by Importe desc
limit 5;

/* 10) Listar las oficinas que no tienen director. */
select o.*, d.codDirector
from oficinas o left join directores d
	on d.codOficina = o.codOficina
where d.codDirector is null;

/* 11) Seleccionar los clientes que no han realizado ningún pedido. */
select c.*
from clientes c left join pedidos p
	using  (codCliente)
where p.codPedido is null;

/* 12) Seleccionar los productos que no han sido vendidos. */
select pr.*
from productos pr left join lineaspedido lp
on pr.idFabricante = lp.fabricante &&
	pr.idProducto = lp.producto
where lp.codPedido is null;

/* 13) Seleccionar los representantes que no han realizado ninguna venta, indicando el nombre del
empleado. */
