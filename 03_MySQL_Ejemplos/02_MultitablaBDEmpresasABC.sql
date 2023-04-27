# hay que listar el mismo número de columnas
/* PRODUCTOS:
	idFabricante e idProducto de los productos con existencias mayor que 100
LINEASPEDIDO:
	fabricante y producto de los productos con precioVenta mayor que 300 */
select idFabricante, idProducto, existencias
from productos
where existencias > 100
union
select fabricante, producto, precioVenta
from lineaspedido
where precioVenta > 300;