# 01. Obtén los nombres de los clientes que han hecho pedidos después del 1/1/98.
select distinct(cu.ContactName)
from customers cu join orders o using(customerid)
where o.OrderDate between '1998-01-01 00:00:00' and curdate();

/* 02. Obtén los nombres de los productos y de las compañías que los suministran.
Los productos sin suministradores asignados y los suministradores sin
productos asignados no se incluyen en el conjunto de resultados. */
select pr.ProductName, su.CompanyName
from products pr join suppliers su using(supplierid);

/* 03. Realiza una consulta que permita presentar el número de la factura y el código
del cliente al cual ésta pertenece. */
select o.OrderID, cu.CustomerID
from customers cu join orders o using(customerid);

/* 04. Realiza una consulta que muestre el listado de productos en el cual se incluya
el precio del producto, la diferencia entre el precio del producto y el precio
promedio de todos los productos.
El listado debe incluir las siguientes columnas: nombre del producto, precio
unitario, precio promedio de todos los productos, deferencia entre el precio
promedio y el precio del producto. */
select ProductName, UnitPrice, (select round(avg(unitprice), 2) from products) Total_Avg,
	round(abs((UnitPrice - (select avg(unitprice) from products))), 2) Difference
from products
group by ProductID;


/* 05. Realiza una consulta que muestre un listado de productos en el cual se incluya
el porcentaje que el producto representa para todo el inventario.
El listado debe incluir las siguientes columnas: nombre del producto, monto del
producto, monto total del inventario, porcentaje que representa el producto para
el inventario. */
select p.ProductName, p.UnitsInStock, (select sum(pr.UnitsInStock) AllStock
	from products pr) TotalStock, (p.UnitsInStock / (select sum(pr.UnitsInStock) AllStock
	from products pr) * 100) as '%'
from products p;

/* 06. Realiza una consulta que muestre un listado donde se incluya los clientes que
han comprado productos de todas las categorías. Las columnas deberán ser:
código del cliente y nombre del cliente. */
select cu.CustomerID, cu.ContactName, count(distinct pr.CategoryID) CategoriasCopradas
from customers cu join orders o using(customerid)
join orderdetails od using(orderid) join products pr using(productid)
group by cu.CustomerID
having count(distinct pr.CategoryID) = (select count(*) from categories);

/* 07. Realiza una consulta que muestre el listado de aquellos productos cuyo
promedio de unidades en pedidos sea mayor de 2. */
select pr.ProductID, pr.ProductName, avg(od.Quantity) MediaProducto
from products pr join orderdetails od using(productid) join orders o using(orderid)
group by pr.ProductID
having avg(od.Quantity) > 2;

# 08. Muestra el importe total que ha gastado cada cliente.
select cu.CustomerID, cu.CompanyName, round(sum(od.Quantity * od.UnitPrice), 2) Cantidad
from orders o join orderdetails od using(orderId) join customers cu using(customerId)
group by cu.CustomerID;

/* 09. Realiza una consulta que muestre un listado de las Facturas de Cada Cliente.
El listado debe tener las siguientes columnas: Nombre del Cliente, País del
Cliente, No. de Factura, Fecha de Factura ordenado por Nombre del Cliente de
forma ascendente y luego por la fecha de la factura de forma descendente. */
select cu.CompanyName, cu.Country, o.OrderID, o.OrderDate
from customers cu join orders o using(customerId)
order by 1 asc, 4 desc;

/* 10. Realiza una consulta que muestre un listado de los empleados que le han
vendido a cada cliente. El listado debe tener las siguientes columnas: Nombre
del Cliente, Nombre completo del Empleado ordenado por Nombre del Cliente
de forma ascendente y luego por el Nombre completo del empleado de forma
ascendente. */
select cu.CompanyName, concat(em.firstName, " ", em.lastName) Employee
from customers cu join orders o using(customerId) join employees em using(employeeId)
order by 1 asc, 2 asc; 

/* 11. Realiza una consulta que muestre un listado de los clientes y el número de
facturas de cada cliente. El listado debe tener las siguientes columnas: Código
Cliente, Nombre Cliente, total de facturas del Cliente. */
select cu.CustomerID, cu.CompanyName, count(o.OrderID) Facturas
from customers cu join orders o using(customerId)
group by cu.CustomerID;

/* 12. Realiza una consulta que muestre un listado de los clientes y el monto total que
nos han comprado de los 5 clientes que más han comprado. El listado debe
tener las siguientes columnas: Código del Cliente, Nombre Cliente, Monto Total
gastado y ordenado por el Monto Total de forma descendente. */
select cu.CustomerID, cu.CompanyName, round(((od.Quantity * od.UnitPrice * od.Discount) + o.Freight), 2) TotalGastado
from customers cu join orders o using(customerId) join orderdetails od using(orderId)
group by cu.CustomerID
order by 3 desc limit 5;

/* 13. Realiza una consulta que muestre un listado de las ventas que se han hecho
por categoría. El listado debe tener las siguientes columnas: Nombre Categoría,
Monto Total y ordenado por el Monto Total de Forma ascendente. */
select ca.CategoryName, round(((od.Quantity * od.UnitPrice * od.Discount) + o.Freight), 2) TotalGastado
from orders o join orderdetails od using(orderId) join products pr using(productid)
join categories ca using(categoryId)
group by o.OrderID
order by 2 asc;

# 14. Selecciona los datos de los productos con el nombre de la categoría a la que pertenece.
select pr.*, ca.CategoryName
from products pr join categories ca using(categoryId);

# 15. Haz un listado que muestre el importe total de cada pedido.
select o.OrderID, round(((od.Quantity * od.UnitPrice * od.Discount) + o.Freight), 2) TotalPedido
from orders o join orderdetails od using(orderId)
group by o.OrderID;

# 16. Haz un listado que muestre el stock de cada producto y el número de unidades vendidas.
select pr.ProductID, pr.UnitsInStock, sum(od.Quantity) Sold
from products pr join orderdetails od using(productId)
group by pr.ProductID;

# 17. Modifica el listado anterior para poder filtrar las ventas por mes y año.
select pr.ProductID, pr.UnitsInStock, sum(od.Quantity) Sold, o.OrderDate
from products pr join orderdetails od using(productId) join orders o using(orderId)
group by pr.ProductID
order by  year(o.orderDate), month(o.orderDate);

# 18. Muestra un listado con las ventas totales que ha tenido cada cliente en cada año.
select cu.CustomerID, cu.CompanyName, year(o.orderDate) Anho, count(o.OrderID) Compras
from customers cu join orders o using(customerId)
group by cu.CustomerID, year(o.orderDate);

# 19. Muestra un listado con las ventas totales de cada vendedor por año.
select em.EmployeeID, concat(em.firstname, " ", em.lastname) Employee, year(o.OrderDate) Anho, count(o.OrderID) Ventas
from employees em join orders o using(employeeId)
group by em.EmployeeID, year(o.orderDate);

/* 20. Muestra un listado con las ventas totales por vendedor y cliente en un año
determinado. */
select cu.CustomerID, cu.CompanyName, em.EmployeeID, concat(em.firstname, " ", em.lastname) Employee,
year(o.orderdate) Anho, count(*) Interacciones
from customers cu join orders o using(customerId) join employees em using(employeeId)
group by cu.CustomerID, em.EmployeeID, year(o.orderdate);

/* 21. Muestra un resumen de las ventas totales por cliente y categoría de productos
en un año determinado. */
select cu.CustomerID, cu.CompanyName, year(o.orderdate) Anho, count(*) Compras, ca.CategoryName
from customers cu join orders o using(customerid)
join orderdetails od using(orderid) join products pr using(productid)
join categories ca using(categoryid)
group by cu.CustomerID, year(o.orderdate), ca.CategoryID;