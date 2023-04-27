drop database if exists 00_ejemplo;
 create database if not exists 00_ejemplo;
 use 00_Ejemplo;
 
 # CREACIÓN DE TABLAS
 create table if not exists Alumnos(
 dni char(9),
 nombre varchar(50),
 fecNacimiento date,
 curso enum('1º DAM', '2º DAM'),
 nota int
 );
 
 # RESTRICCIONES
 create table if not exists Modulos1 (
 codigo int primary key,
 nombre varchar(30) unique not null,
 numHoras integer not null default 200,
 nbProfesor varchar(50) not null
 );
 
 /* obligatorio cuando el campo clave está formado por dos columnas */
 create table if not exists Coches1(
 matricula varchar(15),
 marca varchar(20) not null,
 modelo varchar(20),
 precio int not null,
 
 primary key(matricula),
 unique(marca)
 );
 
 create table if not exists Columnas(
 clave1 int,
 clave2 int,
 nombre varchar(20),
 
 primary key(clave1, clave2)
 );
 
 create table if not exists Fabricante(
 nbFabricante varchar(50) primary key,
 direccion varchar(30) not null,
 telefono int not null
 );
 
 ## CLAVE AJENA
 create table if not exists MueblesCocina1(
 codigo int primary key,
 linea varchar(20) not null,
 color enum('blanco', 'biege', 'azul'),
 alto int not null,
 largo int not null,
 ancho int not null,
 material varchar(20) not null,
 altura int not null,
 nbFabricante varchar(50) not null references Fabricante(nbFabricante)
 );
 
 /* obligatorio cuando hay más de una clave ajena */
  create table if not exists MueblesCocina2(
 codigo int primary key,
 linea varchar(20) not null,
 color enum('blanco', 'biege', 'azul'),
 alto int not null,
 largo int not null,
 ancho int not null,
 material varchar(20) not null,
 altura int not null,
 nbFabricante varchar(50) not null,
 
 foreign key (nbFabricante) references Fabricante(nbFabricante)
 );
 
 ## NOMBRAR LAS RESTRICCIONES
 create table if not exists Coches2(
 matricula varchar(15),
 marca varchar(20) not null,
 modelo varchar(20),
 precio int not null,
 
 constraint nbPK primary key(matricula), #nombre de la restricción
 constraint nuUK unique(marca)
 );
 
 ## CLAVE AUTOINCREMENTABLE
 create table if not exists Modulos2 (
 codigo int auto_increment primary key,
 nb char(5)
 );

## INDICES
create index nbIndice on Alumnos (nombre);
create unique index nbUK on Alumnos (curso);

# ALTERAR TABLAS
## añadir columnas
alter table Alumnos add column direccion varchar(50);
alter table Alumnos add column ape1 varchar(20);
alter table Alumnos add ape2 varchar(20) not null; #(por defecto)
alter table Alumnos add email varchar(50) first; #principio
alter table Alumnos add telefono int not null after direccion; # despues de

## añadir indices
alter table Alumnos add index (email); #sin nombre
alter table Alumnos add index indApe (ape1, ape2); #ordena en el orden de las columnas

## añadir clave primaria
alter table Alumnos add primary key (dni);

## eliminar
alter table Alumnos drop telefono;
alter table Alumnos drop primary key;
alter table Alumnos drop index indApe;

/*
alter table nbTabla alter...
alter table nbTabla change...
alter table nbTabla modify...
*/

## añadir valor por defecto a una columna
alter table Alumnos alter nota set default 5;

## eliminar el valor por defecto de una columna
alter table Alumnos alter nota drop default;

## cambiar el tipo de dato de una columna
alter table Alumnos change nombre nombre char(20) not null first; ### nombre antiguo / nombre nuevo + tipo de dato
alter table Alumnos modify nombre char(30) unique after ape2;

## cambiar el nombre de una tabla
alter table Alumnos rename personas;

## eliminar
drop table if exists Modulos2;
drop index nbUk on Personas;