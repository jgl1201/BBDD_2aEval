create database if not exists 03_EjemploProductoCartesiano;
use 03_EjemploProductocartesiano;

create table if not exists cursos(
codCurso int primary key,
nombre varchar(20)
);

create table if not exists alumnos(
dni char(9) primary key,
nombre varchar(30),
codCurso int not null,

foreign key(codCurso) references cursos(codCurso)
);

insert into cursos(codCurso, nombre) values
(1, 'P_DAM') , (2, 'S_DAM') , (3, '2_ASI');

insert into alumnos(dni, nombre, codCurso) values
('123A', 'Pedro',3) , ('456B', 'Ana',2),
('789C', 'Juan',1), ('147D', 'Pepe',3),
('258E', 'María',2), ('369F', 'Juanita de Arco',1);