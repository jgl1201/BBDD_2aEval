# Listar todos los clientes
select * from clientes;

select codCliente, nombre, codRepresentante, limiteCredito
from clientes;

# Listar el nombre y el sueldo de todos los empleados
select nombre, sueldo from empleados;

# Listar los datos del cliente inrementando en 5000 el limiteCredito
select nombre, limiteCredito, limiteCredito+5000 from clientes;

# Mostrar la fecha y hora de hoy
select now(), curdate();

# Listar de la tabla lineadPedido el fabricante, el pedido, el producto, la cantidad, el precio y el importe
select codPedido as pedido, fabricante, producto, cantidad, precioVenta,
cantidad * precioVenta as importe
from lineaspedido;

# Calcular 2 elevado a la sexta, la raiz cuadrada de 25 y el resto de dividir 8 entre 3
select pow(2,6) as potencia, sqrt(25) as 'raiz cuadrada',
mod(8,3) as resto01, 8%3 as resto02;

# Cláusula order by se usa para ordenar la lista de resultados que se muestran
## asc o desc

# Listar los empleados por orden ascendente
select codEmpleado, nombre, fecNacimiento, categoria, sueldo, oficina
from Empleados order by nombre asc; # order by ordena de manera ascendente por defecto

# Listar los empleados por orden descendente
select codEmpleado, nombre, fecNacimiento, categoria, sueldo, oficina
from Empleados order by nombre desc;

# También se puede usar el nº de columna dentro de la consulta que se quiere ordenar
## Se suele usar el nombre de la columna popr si se cambia la consulta
select codEmpleado, oficina, nombre, fecNacimiento, categoria, sueldo
from Empleados order by 3;

# Listar los empleados ordenados por categoria y nombre
select codEmpleado, oficina, nombre, fecNacimiento, categoria, sueldo
from Empleados order by categoria, nombre;

# Listar los empleados ordenados por oficina y nombre
select codEmpleado, oficina, nombre, fecNacimiento, categoria, sueldo
from Empleados order by oficina, categoria, nombre;

# limit limita el número de filas que se muestran
select codEmpleado, oficina, nombre, fecNacimiento, categoria, sueldo
from Empleados
order by categoria, nombre
limit 4;

# Listar nombre y suledo de los 10 empleados que más ganen
select codEmpleado, oficina, nombre, fecNacimiento, categoria, sueldo
from Empleados
order by sueldo desc
limit 10;

# Funciones de fecha
select nombre, fecNacimiento, year(fecContrato), month(fecContrato),
monthname(fecContrato), day(fecContrato), hour(now()), minute(now()), second(now())
from empleados;

# Listar el nombre del empleado, su fecha de nacimiento, edad, año del contrato y aós que lleva trabajando en la empresa
select nombre, fecNacimiento, year(curdate()) - year(fecNacimiento) as edad,
fecContrato, year(curdate()) - year(fecContrato) as años
from empleados;

# Listar la categoría de los empleados
select distinct categoria
from empleados;

# Consulta where

# Listar los empleados cuya categoría sea Representante
select nombre, sueldo, categoria
from empleados
where categoria = "Representante";

# Listar los empleados cuyo sueldo sea mayor de 3000
select nombre, sueldo, categoria
from empleados
where sueldo > 3000;

# Listar el nombre, sueldo, comision y suma de sueldo y comision
select nombre, sueldo, ifnull(comision, 0), sueldo + ifnull(comision, 0) as total
from empleados;

# Listar los empleados cuya categoría sea Representante y sueldo + comision > 5000
select nombre, categoria, sueldo, ifnull(comision, 0), sueldo + ifnull(comision, 0) as sb
from empleados
where categoria = 'Representante' and sueldo + ifnull(comision, 0) > 5000;

# Listar los empleados de las oficinas 11, 12, 13
select * from empleados
where oficina = 11 or oficina = 12 or oficina = 13;

# Listar los empleados con sueldo entre 2000 y 3000
select * from empleados
where sueldo >= 2000 && sueldo <= 3000;

select * from empleados
where sueldo between 2000 and 3000;

select nombre, oficina
from empleados
where oficina in(11, 12, 13);

# Listar las oficinas de Vigo, Eibar, Gijón y Bilbao
select * from oficinas
where ciudad in('Vigo', 'Eibar', 'Gijón', 'Bilbao');

# Listar los empleados que no tienen oficina
select nombre, oficina
from empleados
where oficina is null;

## % sustituye a cualquier numero de caracteres
## _ sustituye a un solo caracter

# Listar los empleados cuyo nombre empiece por G
select nombre, sueldo
from empleados
where nombre like 'G%';

# Listar los empleados cuyo nombre termine por o
select nombre, sueldo
from empleados
where nombre like '%o';

# Listar los empleados cuyo nombre tenga 'la'
select nombre, sueldo
from empleados
where nombre like '%la%';

# Listar los empleados cuyo nombre no tenga 'la'
select nombre, sueldo
from empleados
where nombre not like '%la%';

# Listar los empleados cuyo nombre va despues de la J
select nombre, sueldo
from empleados
where nombre > 'J';

# Listar las oficinas de Gijón
## No distingue letras con tilde de las sin tilde
select * from oficinas
where ciudad = 'Gij_on';
##where ciudad = 'Gijon';

# Listar los empleados cuyo nombre esté entre las lettras L y P
select nombre, fecContrato
from empleados
where nombre rlike '^[L-P]'
order by nombre;



