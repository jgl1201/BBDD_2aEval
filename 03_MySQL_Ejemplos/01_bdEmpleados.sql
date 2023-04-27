drop database if exists 01_bdEmpleados;
create database if not exists 01_bdEmpleados;
use 01_bdEmpleados;

create table if not exists centros (
ceCodigo int auto_increment primary key,
ceNombre varchar(30) not null,
ceDireccion varchar(100) not null
);

create table if not exists empleados (
emCodigo int unsigned auto_increment primary key,
emCodigoDepartamento int unsigned not null,
emExTelefono smallint,
emFechaNacimiento date not null,
emFechaIngreso date not null,
emSalario double not null,
emComision double not null,
emNumHijos smallint default 0,
emNombre varchar(20) not null
);

create table if not exists departamentos (
deCodigo int unsigned auto_increment primary key,
deCodigoCentro int not null,
deTipoDirector enum('P', 'F'),
dePresupuesto double not null,
deDepartamento int unsigned,
deNombre varchar(30) not null,
deDirector int unsigned,

foreign key (deCodigoCentro) references centros(ceCodigo),
foreign key (deDirector) references empleados(emCodigo)
);

alter table empleados add foreign key (emCodigoDepartamento)
references departamentos (deCodigo);

alter table departamentos add constraint FKDepar # el constraind da un nombre a la restriccion
foreign key (deDepartamento) references departamentos(deCodigo);

insert into centros(ceCodigo, ceNombre, ceDireccion) values
(null, "primero", "Vigo"); # null pone el valor por defecto

insert into centros(ceCodigo, ceNombre, ceDireccion) values
(null, "segundo", "Cangas"),
(null, "tercero", "Moaña"),
(100, "cuarto", "Porriño"), # 100 da el valor deseado y continua desde ahí
(null, "quinto", "Caldas de Reyes");

insert into centros(ceNombre, ceDireccion, ceCodigo) values # orden de las columnas
("sexto", "Santiago", null);

insert into centros values # si no se mete el nombre de las columnas coge el orden en el que están
(null, "septimo", "Coruña");

insert into departamentos (deCodigoCentro, deTipodirector,
dePresupuesto,deDepartamento, deNombre, deDirector) values
(100, 'P', 50000, null, "Contabilidad", null); # clave primaria se genera sola

# Insertar un departamento en un centro que no existe para que se produzca el error de Foreign Key
/*
insert into departamentos (deCodigoCentro, deTipodirector,
dePresupuesto,deDepartamento, deNombre, deDirector) values
(10999, 'P', 60000, 1, 'RRHH', null);
*/
# Cambiar el codigo del centro por uno que exista
insert into departamentos (deCodigoCentro, deTipodirector,
dePresupuesto,deDepartamento, deNombre, deDirector) values
(1, 'P', 60000, 1, 'RRHH', null);

# Eliminar el centro con codigo 105
delete from centros where ceCodigo = 105;

# Eliminar el centro con codigo 101
# Se va a producir un error de Foreign Key o integridad referencial
/*
delete from centros where ceCodigo = 101;
*/
# Solucion: eliminar primero los departamentos del centro 101 y luego eliminar el centro
set sql_safe_updates = 0;
insert into empleados (emCodigoDepartamento, emExTelefono, emFechaNacimiento,
emFechaIngreso, emSalario, emComision, emNumHijos, emNombre) values
(5, 123,"1978-11-05", "2020-02-15", 2500, 350.50, 2, "Maria");

update empleados set emNombre = "Maria del Carmen"
where emCodigo = 1;


# incrementar el sueldo de los empleados en un 5% y la comision en un 3%
update empleados set emSalario = emSalario * 1.05,
emComision = emComision * 1.03;

# Ejemplo on delete cascade y on update cascade
## on delete cascade sirve para eliminar un alumno y todas sus notas
## on update cascade sirve para actualizar un alumno y todas sus notas
create table if not exists alumnos (
dni int primary key,
nombre varchar(20)
);

create table if not exists notas (
id int auto_increment primary key,
dni int not null,
nota int,

foreign key (dni) references alumnos(dni)
on delete cascade on update cascade
);

insert into alumnos (dni, nombre) values
(12, 'Ana'),
(13, 'Bea'),
(14, 'Isabel'),
(15, 'Jorge');

insert into notas (dni, nota) values /* no hay que poner id xq es auto incremental */
(12, 5),
(12, 6),
(12, 7),
(14, 5),
(14, 9);

# eliminar el alumno con codigo 13, que no tiene notas
delete from alumnos where dni = 13;

# eliminar el alumno con codigo 14, que si tiene notas
delete from alumnos where dni = 14;

update alumnos set dni = 25 where dni = 12;