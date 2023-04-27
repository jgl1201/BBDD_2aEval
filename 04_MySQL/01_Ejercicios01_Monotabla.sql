/* 1) Obtener una lista de todos los productos indicando para cada uno su idfabricante, idproducto,
descripción, precio de compra, IVA y precio con I.V.A. incluido (es el precio anterior aumentado en
un 21%). */
select idFabricante, idProducto, descripcion, precioCompra,
format(precioCompra * 0.21, 2) as IVA, format(precioCompra * 1.21, 2) as precioTotal
from productos;

/* 2) De cada lineapedido queremos saber su número de pedido, fabricante, producto, cantidad, precio
de venta y el importe. */
select *, cantidad * precioVenta as Importe
from lineaspedido;

/* 3) Listar de cada empleado su nombre, nº de días que lleva trabajando en la empresa y su edad
(suponiendo que este año ya ha cumplido años). */
select nombre, fecContrato,
datediff(curdate(), fecContrato) as diasTrabajados,
year(curdate()) - year(fecNacimiento) as edad
from empleados;

/* 4) Obtener la lista de los clientes agrupados por código de representante asignado, visualizar todas
las columnas de la tabla. */
select * 
from clientes
order by codRepresentante;

/* 5) Obtener las oficinas ordenadas por orden alfabético de región y dentro de cada región por ciudad,
si hay más de una oficina en la misma ciudad, aparecerá primero la que tenga el número de oficina
mayor. */
select *
from oficinas
order by region, ciudad, codOficina;

/* 6) Obtener los pedidos ordenados por fecha de pedido.
Selección de filas. */
select * 
from pedidos
order by fechaPedido;

/* 7) Listar las ocho líneas de pedido más caras (las de mayor importe). */
select *, cantidad * precioVenta as Importe
from lineaspedido
order by Importe desc
limit 8;

/* 8) Obtener las mismas columnas que en el ejercicio anterior pero sacando únicamente las 5 líneas de
pedido de menor precio unitario. */
select *, cantidad * precioVenta as Importe
from lineaspedido
order by cantidad * precioVenta
limit 5;

/* 9) Listar toda la información de los pedidos de marzo del último año.*/
select *
from pedidos
where month(fechaPedido) = 3 and year(fechaPedido) = year(curdate()) - 1;

/* 10) Listar los pedidos del mes pasado. */
select *
from pedidos
where month(fechaPedido) = month(curdate() - 1) and year(fechaPedido) = year(curdate());

/* 11) Listar los números de los empleados que tienen una oficina asignada. */
select codEmpleado, nombre
from empleados
where oficina is not null;

/* 12) Listar los nombres de los empleados que no tienen asignada una oficina. */
select codEmpleado, nombre
from empleados
where oficina is null;

/* 13) Listar los datos de las oficinas de las regiones del Galicia y Euzkadi (tienen que aparecer primero las
de Euzkadi y después las de Galicia). */
select *
from oficinas
where region in ('Euzkadi','Galicia')
order by region desc;

/* 14) .Listar los clientes de nombre Julia. */
select *
from clientes
where nombre like 'Julia %';

/* 15) Listar los productos cuyo idproducto acabe en x. */
select *
from productos
where idProducto like '%x';

/* 16) Obtener toda la información de los empleados cuya edad este comprendida entre 40 y 60 años. */
/* si los 5 caracteres por la derecha (mes-dia) de la fecha de nacimiento es mayor
   que los actuales significa que aun no cumplio, si se cumple resto 1, si no 0*/
select *, year(curdate()) - year(fecNacimiento) -
if(right(fecNacimiento, 5) > right(curdate(), 5), 1, 0)
as Edad
from empleados
where year(curdate()) - year(fecNacimiento) -
if(right(fecNacimiento, 5) > right(curdate(), 5), 1, 0) between 40 and 60;

/* 17) Obtener todos los clientes cuyos representantes tengan los códigos 102, 104 y 109. */
select *
from clientes
where codRepresentante in (102, 104, 109)
order by codRepresentante;

/* 18) Obtener un listado de todos los productos ordenados alfabéticamente por fabricante y después de
mayor a menor precio. */
select *
from productos
order by idFabricante, precioCompra desc;

/* 19) Listar todos los empleados que lleven trabajando más de 25 años en la empresa. */
select *
from empleados
where year(curdate()) - year((fecContrato)) >= 25
order by fecContrato;

/* 20) Listar todas las oficinas que no tengan marcado ningún objetivo. */
select *
from oficinas
where objetivo is null;

/* 21) Obtener el nombre de todos los empleados cuyo salario acumulado hasta la fecha actual no han
llegado a cubrir el objetivo que tenían, además se deberá calcular el importe que les falta. */
select codEmpleado, nombre, sueldo,
sueldo * month(curdate()) as 'Sueldo acumulado', objetivo
from empleados
where sueldo * month(curdate()) < objetivo;
;

/* 21b. desde que están en la empresa */
select codEmpleado, nombre, sueldo,
(year(curdate()) - year(fecContrato) - 1) * 12 * sueldo + 
sueldo * month(curdate()) as 'Sueldo acumulado'
from empleados
where (year(curdate()) - year(fecContrato) - 1) * 12 * sueldo + 
sueldo * month(curdate()) < objetivo;

/* 22) Obtener el nombre del empleado, sueldo, comisión, sueldo bruto (sueldo + comisión), el importe
de las retenciones tanto del IRPF como de la S.S., y el sueldo neto (sueldo bruto – las retenciones). */
select nombre, sueldo, ifnull(comision, 0) as Comision,
format(sueldo + ifnull(comision, 0), 2) as Bruto,
retencionesIRPF,
format((sueldo + ifnull(comision, 0)) * retencionesIRPF, 2) as 'Retencion IRPF',
retencionesSS,
format((sueldo + ifnull(comision, 0)) * retencionesSS, 2) as 'Retencion SS',
format( (sueldo + ifnull(comision, 0)) -
((sueldo + ifnull(comision, 0)) * retencionesIRPF) -
((sueldo + ifnull(comision, 0)) * retencionesSS), 2) as Neto
from empleados;