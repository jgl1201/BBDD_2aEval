# 1- Realizar una consulta que me muestre toda las columnas de la tabla de productos
select * from products;

# 2- Realizar una consulta que me muestre el código, el nombre y el precio del producto
select ProductID, ProductName, UnitPrice
from products;

/* 3- Realizar una consulta que me muestre el código, nombre y la categoría de los
productos que estén entre 18.00 y 20.00 */
select pr.ProductID, pr.ProductName, ca.CategoryName
from products pr join categories ca using(CategoryId)
where pr.UnitPrice between 18.00 and 20.00;

# 4- Realiza una consulta que permita presentar la fecha actual mediante una función
select curdate();

/* 5- Realiza una consulta que permita presentar los apellidos de los empleados en
minúscula */
select lower(lastname) from employees;

/* 6- Realiza una consulta que permita presentar los apellidos de los empleados en
mayúscula */
select upper(lastname) from employees;

/* 7- Realiza una consulta que permita presentar las tres primeras letras del nombre de
los empleados */
select substr(firstname, 1, 3) from employees;

/* 8- Realiza una consulta que permita presentar el nombre y apellido, y un correo
electrónico de los empleados, éste deberá tener los siguientes datos:
a. La primera letra del nombre, seguida del apellido
b. El correo deberá presentarse en minúscula */
select FirstName, LastName, lower(concat(substr(firstname, 1, 1), lastname, '@northwind.com')) Mail
from employees;

/* 9- Realiza una consulta que permita presentar el nombre y apellidos de los
empleados que tengan más de 40 años */
-- FORMA NO EXACTA
select FirstName, LastName, (year(curdate()) - year(birthdate)) Age
from employees
where (year(curdate()) - year(birthdate)) > 40;
-- FORMA EXACTA
select FirstName, LastName, round((datediff(curdate(), birthdate) / 365), 0) Age
from employees
where (datediff(curdate(), birthdate) / 365) > 40;
select FirstName, LastName, timestampdiff(year, birthdate, curdate()) Age
from employees
where (timestampdiff(year, birthdate, curdate())) > 40;

# 10- Realiza una consulta que permita presentar el número de fax que tiene cada país
-- Mostrarm el numero de faxes y los faxes que tienen los clientes de cada pais
select country, count(distinct fax), group_concat(fax)
from customers
group by country;

/* 11- Realiza una consulta que permita presentar el máximo, mínimo y el promedio de
años que llevan en la empresa los empleados */
select max(Tabla.Antiguedad), min(Tabla.Antiguedad), avg(Tabla.Antiguedad) from (
	select (timestampdiff(year, hiredate, curdate())) Antiguedad
    from employees) Tabla;

/* 12- Realiza una consulta que permita presentar un listado de países que no tienen
faxes con su respectiva cantidad */
select country, fax, count(*)
from customers cu
group by country
having count(*) = (select count(*) from customers c
				where c.fax = '' and c.Country = cu.Country group by country);
-- Suiza es el único pais en el que ninguno de los clientes tiene fax

/* 13- Realiza una consulta que permita presentar el nombre del cliente, el fax y el país
al que pertenece */
select ContactName, fax, country
from customers
order by 3;

/* 14- Realiza una consulta que muestre la mayor edad, la menor edad y la edad
promedio de los empleados. Recuerde que para eso tiene que buscar la diferencia
entre la fecha actual y la fecha de nacimiento.
a. Para obtener la fecha actual utilice la función curdate().
b. Para obtener la diferencia en años utilice la función datediff. */
select (timestampdiff(year, birthdate, curdate())) Age
from employees;
select max(Age) Older, min(Age) Younger, round(avg(Age), 2) AverageAge
from (select (timestampdiff(year, birthdate, curdate())) Age
	from employees) Ages;

/* 15- Realiza una consulta que muestre la cantidad de facturas que se han registrado
por cada año (order day) */
select count(*) Amount, year(orderdate) Year
from orders
group by year(orderdate);

/* 16- Realiza una consulta que me permita mostrar el número de la factura y el valor
por concepto de envío */
-- freight son los portes, el concepto de envio
select orderId, freight from orders;

/* 17- Realiza una consulta que me permita mostrar el número de la factura y el valor
por concepto de envío pero de aquellos que superen a los 10. */
select orderId, freight from orders where Freight > 10;

/* 18- Realiza una consulta que muestre el código de la categoría, el total de productos
que tiene la categoría únicamente para las categorías que tengan más de 10
productos. Para esto utilice la cláusula having */
select pr.CategoryID, count(*) Amount, ca.CategoryName
from products pr join categories ca using(CategoryId)
group by pr.CategoryID
having count(*) > 10;

/* 19- Realizar una consulta que permita presentar el nombre del producto y con su
respetiva categoría */
select pr.ProductName, ca.CategoryName
from products pr join categories ca using(categoryid);

/* 20- Realizar una búsqueda de los nombres de compañías con las cuales se ha tenido
ventas, ordenar por el código del vendedor */ 
select cu.companyname, o.EmployeeID, concat(em.firstname, " ", em.lastname) EmployeeName
from orders o join customers cu using(customerid) join employees em using(employeeid)
order by 2, 1;

/* 21- Realiza una consulta que muestre el listado de las facturas de cada cliente.
a. El listado debe tener las siguientes columnas: nombre del cliente, país
del cliente, nº De factura, fecha de factura, ordenado por nombre del
cliente en forma ascendente y luego por la fecha de la factura de forma
descendente una búsqueda de los nombres de compañías con las cuales
se ha tenido ventas, ordenar por el código del vendedor */
select cu.ContactName, cu.Country, o.OrderID, o.OrderDate
from orders o join customers cu using(customerid)
order by 1 asc, 4 desc;

/* 22- Realiza una consulta que muestre un listado de los clientes y el monto total que
nos han comprado de los 5 clientes que más han gastado. El listado debe tener
las siguientes columnas: código del cliente, nombre del contacto, monto total.
Ordenado por el monto total de forma descendente */
select cu.CustomerID, cu.CompanyName, sum(od.Quantity * od.UnitPrice) Cantidad
from orders o join orderdetails od using(orderId) join customers cu using(customerId)
group by cu.CustomerID
order by 3 desc limit 5;

/* 23- Realiza una consulta que muestre un listado de los empleados de la empresa en
los diferentes territorios. El listado debe tener las siguientes columnas: nombre
del empleado ,id de la región y descripción del territorio ordenado por el nombre
completo del empleado de forma ascendente */
select concat(em.firstname, " ", em.lastname) Name, te.RegionID, te.TerritoryDescription
from employees em join employeeterritories et using(employeeid) join territories te using(territoryid)
order by 1 asc;