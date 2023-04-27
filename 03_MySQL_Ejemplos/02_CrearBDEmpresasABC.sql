DROP DATABASE IF EXISTS 02_bdEmpresasABC;
CREATE database IF NOT EXISTS 02_bdEmpresasABC;
USE 02_bdEmpresasABC;
/*COMMENT 'Crear tabla Oficinas'*/
CREATE TABLE IF NOT EXISTS Oficinas (
codOficina CHAR(3) PRIMARY KEY,
ciudad VARCHAR(30) NOT NULL,
region ENUM('Galicia','Asturias', 'Cantabria', 'Euzkadi', 
'Navarra'),
objetivo DOUBLE,
ventas DOUBLE) ENGINE = InnoDB;

/*COMMENT 'Crear tabla Empleados'*/
CREATE TABLE IF NOT EXISTS Empleados (
codEmpleado CHAR(5) PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
fecNacimiento DATE NOT NULL,
oficina CHAR(3),
categoria VARCHAR(40) NOT NULL,
fecContrato DATE NOT NULL,
codJefe CHAR(5),
sueldo decimal NOT NULL,
comision DOUBLE,
retencionesIRPF DOUBLE NOT NULL,
retencionesSS DOUBLE NOT NULL,
objetivo decimal,
CONSTRAINT FKEmpleOfic FOREIGN KEY (oficina) REFERENCES Oficinas (codOficina),
CONSTRAINT FKjefe FOREIGN KEY (codJefe) REFERENCES Empleados (codEmpleado)
)ENGINE = InnoDB;


/*COMMENT 'Crear tabla Directores*/
CREATE TABLE IF NOT EXISTS Directores(
idDirector INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
codDirector CHAR(5)  ,
codOficina CHAR(3),
FOREIGN KEY (codDirector) REFERENCES Empleados (CodEmpleado),
FOREIGN KEY (codOficina) REFERENCES Oficinas (CodOficina))ENGINE = InnoDB;


/*COMMENT 'Crear tabla Clientes'*/
CREATE TABLE IF NOT EXISTS  Clientes
(codCliente CHAR(5) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
codRepresentante CHAR(5) NOT NULL,
limiteCredito DOUBLE ,
CONSTRAINT FKRepEmpleados FOREIGN KEY (codRepresentante) REFERENCES Empleados (CodEmpleado))ENGINE = InnoDB;


/*COMMENT 'Crear tabla Productos'*/
CREATE TABLE IF NOT EXISTS Productos (
idFabricante CHAR(5),
idProducto CHAR(20),
descripcion VARCHAR(50) NOT NULL,
precioCompra DOUBLE NOT NULL,
existencias INTEGER NOT NULL,
PRIMARY KEY (IdFabricante, IdProducto))ENGINE = InnoDB;


/*COMMENT 'Crear tabla Pedidos'*/
CREATE TABLE IF NOT EXISTS Pedidos
(codPedido INT AUTO_INCREMENT PRIMARY KEY,
fechaPedido DATE NOT NULL,
codCliente CHAR(5) NOT NULL,
codRepresentante CHAR(5) NOT NULL,
CONSTRAINT FKPedClientes FOREIGN KEY (codCliente) REFERENCES Clientes (codCliente),
CONSTRAINT FKPedEmpleados FOREIGN KEY (codRepresentante) REFERENCES Empleados (codEmpleado))ENGINE = InnoDB;


/*COMMENT 'Crear tabla LineasPedido'*/
CREATE TABLE IF NOT EXISTS LineasPedido
(codPedido INT,
numLinea INT,
fabricante CHAR(5) NOT NULL,
producto CHAR(20) NOT NULL,
cantidad SMALLINT UNSIGNED NOT NULL,
precioVenta FLOAT NOT NULL,
CONSTRAINT PKLineasPedido PRIMARY KEY (codPedido, numLinea),
CONSTRAINT FKLinPedPed FOREIGN KEY (codPedido) REFERENCES Pedidos (codPedido),
CONSTRAINT FKLinPedPro FOREIGN KEY (fabricante, producto) REFERENCES Productos (idFabricante, idProducto)
)ENGINE = InnoDB;


