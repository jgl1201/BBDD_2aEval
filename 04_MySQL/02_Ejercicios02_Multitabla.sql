/* 1) Listar las oficinas de Galicia indicando para cada una de ellas su número, ciudad, códigos y
nombres de sus empleados. Hacer una versión en la que aparecen sólo las que tienen empleados,
y hacer otra en las que aparezcan las oficinas de Galicia que no tienen empleados. */
## con right join (oficinas está a la derecha del join) seleccionamos las oficinas de galicia sin empleados
select o.codOficina, o.ciudad, o.region, e.codEmpleado, e.nombre
from empleados e right join oficinas o on e.oficina = o.codOficina
where o.region = 'Galicia';

## Listar el número de empleados
select o.codOficina, o.ciudad, o.region, count(e.codEmpleado)
from empleados e right join oficinas o on e.oficina = o.codOficina
where o.region = 'Galicia'
group by o.codOficina;

/* 2) Listar los pedidos mostrando su número, fecha del pedido, nombre del cliente, y el límite de
crédito del cliente correspondiente (todos los pedidos tienen cliente y representante). */
select p.codPedido, p.fechaPedido, c.nombre, c.limiteCredito
from pedidos p join clientes c using (codCliente);

/* 3) Listar los datos de cada uno de los empleados, la ciudad y región en donde trabaja. */
select e.codEmpleado, e.nombre, e.oficina, e.sueldo, o.ciudad, o.region
from empleados e join oficinas o on e.oficina = o.codOficina;

/* 4) Listar las oficinas con objetivo superior a 3.500€ indicando para cada una de ellas el nombre de
su director. */
select o.codOficina, o.ciudad, o.objetivo, e.nombre
from oficinas o join directores d using (codOficina)
join empleados e on d.codDirector = e.codEmpleado
where o.objetivo > 3500;

/* 5) Listar las líneas de pedido superiores a 150 €, incluyendo el nombre del empleado que tomó el
pedido y el nombre del cliente que lo solicitó. */
select lp.cantidad, lp.precioVenta, e.nombre, c.nombre, lp.cantidad * lp.precioVenta as Importe
from lineaspedido lp join pedidos p using (codPedido)
join clientes c using (codCliente)
join empleados e on p.codRepresentante = e.codEmpleado
where (lp.cantidad * lp.precioVenta) > 150;

/* 6) Hallar los empleados que realizaron su primer pedido el mismo día en que fueron contratados. */
select e.nombre, e.fecContrato, p.fechaPedido
from pedidos p join empleados e on p.codRepresentante = e.codEmpleado
where date(p.fechaPedido) = date(e.fecContrato);

/* 7) Listar los empleados con un sueldo superior al de su jefe; para cada empleado sacar sus datos y el
número, nombre y sueldo de su jefe. */
select e.codEmpleado, e.nombre, e.sueldo, j.codEmpleado, j.nombre, j.sueldo
from empleados e join empleados j on j.codEmpleado = e.codJefe
where e.sueldo > j.sueldo;

/* 8) Listar los códigos y nombre de los empleados que tienen una línea de pedido superior a 5.000 € o
que tengan un objetivo inferior a 200.000 €. (El empleado deberá mostrarse una vez) */
select e.codEmpleado, e 
from empleados e join lineaspedido lp

/* 9) Listar las 5 líneas de pedido con mayor importe indicando el nombre del cliente, del producto y
del representante. */

/* 10) Listar las oficinas que no tienen director. */

/* 11) Seleccionar los clientes que no han realizado ningún pedido. */

/* 12) Seleccionar los productos que no han sido vendidos. */

/* 13) Seleccionar los representantes que no han realizado ninguna venta, indicando el nombre del
empleado. */
