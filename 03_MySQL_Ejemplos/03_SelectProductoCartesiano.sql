select * 
from cursos, alumnos
where cursos.codCurso = alumnos.codCurso
order by cursos.codCurso;


# COMPOSICIÓN
## inner la asume por defecto, se puede poner solo join
## si las columnas se llaman igual se puede usar using
select *
from cursos
inner join alumnos on
alumnos.codCurso = curso.codCurso;

select *
from cursos
join alumnos on
alumnos.codCurso = curso.codCurso;

select *
from cursos
inner join alumnos using(codCurso);

## Listar los alumnos matriculados en cada curso indicando su nombre
select alumnos.nombre, cursos.nombre
from cursos join alumnos using (codCurso);