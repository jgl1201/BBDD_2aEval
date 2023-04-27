/* Listar el nombre del empleado, la oficina en la que trabaja
indicando la ciudad y las ventas de la oficina */
## JOIN
select codEmpleado, nombre, oficina, codOficina, ciudad, ventas
from empleados join oficinas on oficina = codOficina;

## PRODUCTO CARTESIANO
select codEmpleado, nombre, oficina, codOficina, ciudad, ventas
from empleados, oficinas
where oficina = codOficina;

/* Listar los pedidos indicando el nombre del cliente.
El codCliente se llama igual en las dos tablas */
## JOIN
select codPedido, fechaPedido, codCliente, nombre
from pedidos join clientes using(codCliente);

## PRODUCTO CARTESIANO
select codPedido, fechaPedido, clientes.codCliente, nombre
from pedidos, clientes
where pedidos.codCliente = clientes.codCliente;

/* Listar el codPedido, el nombre del producto, cantidad, precio de venta e importe */
## JOIN
select codPedido, descripcion, cantidad, precioVenta,
cantidad * precioventa as Importe
from lineaspedido join productos on idFabricante = fabricante &&
idProducto = producto;

## PRODUCTO CARTESIANO
select codPedido, descripcion, cantidad, precioVenta,
cantidad * precioventa as Importe
from lineaspedido, productos
where idFabricante = fabricante && idProducto = producto;

/* Listar el código del pedido, codigo y nombre del cliente
y codigo del empleado que hizo la venta */
## JOIN
select pedidos.codPedido, pedidos.fechaPedido, clientes.codCliente, clientes.nombre,
empleados.codEmpleado, empleados.nombre
from clientes join pedidos using (codCliente)
join empleados on codCliente = pedidos.codRepresentante;

## PRODUCCTO CARTESIANO
select pedidos.codPedido, pedidos.fechaPedido, clientes.codCliente, clientes.nombre,
empleados.codEmpleado, empleados.nombre
from Clientes, pedidos, empleados
where clientes.codCliente = pedidos.codCliente &&
pedidos.codRepresentante = empleados.codEmpleado;

/* Listar los clientes con el codigo de su representante */
## JOIN
select clientes.codCliente, clientes.nombre,
clientes.codRepresentante, empleados.nombre
from clientes join empleados
on clientes.codRepresentante = empleados.codEmpleado;

## PRODUCTO CARTESIANO
select clientes.codCliente, clientes.nombre,
clientes.codRepresentante, empleados.nombre
from clientes, empleados
where clientes.codRepresentante = empleados.codEmpleado;

/* Listar los productos que no se han vendido */
select idFabricante, fabricante, descripcion, existencias, precioCompra
from productos left join lineaspedido
on idFabricante = fabricante &&
idProducto = producto
where codPedido is null;