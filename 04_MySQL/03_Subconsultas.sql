## Subconsulta
select e.nombre, e.fecNacimiento, e.oficina, (select region from oficinas where codOficina = e.oficina) region
from empleados e;
## join
select e.*, o.region
from empleados e left join oficinas o on e.oficina = o.codOficina;