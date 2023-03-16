CREATE SCHEMA almacen;
USE almacen;

#----------------Creación de tablas----------------

CREATE TABLE Proveedor (
id_proveedor INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR(30),
contacto VARCHAR(50),
cantidadProducto INTEGER
);

CREATE TABLE TipoProducto (
id_tipoProducto INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombreCategoria VARCHAR (50)
);

CREATE TABLE Producto (
id_producto INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombreProducto VARCHAR(50),
precioCompra DOUBLE,
precioVenta DOUBLE,
id_proveedor INTEGER,
id_tipoProducto INTEGER,
nombreCategoria VARCHAR(50),
FOREIGN KEY ( id_proveedor ) REFERENCES Proveedor( id_proveedor ),
FOREIGN KEY(id_tipoProducto) REFERENCES TipoProducto(id_tipoProducto)
);

ALTER TABLE Producto ADD nombreCategoria VARCHAR(50);

CREATE TABLE Inventario (
id_inventario INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
stockMaximo INTEGER,
stockMinimo INTEGER,
cantidadVendidos INTEGER,
id_producto INTEGER,
FOREIGN KEY (id_producto) REFERENCES Producto (id_producto)
);

CREATE TABLE Boleta (
id_boleta INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
numeroBoleta INTEGER,
fecha DATE,
totalVenta DOUBLE,
id_producto INTEGER,
FOREIGN KEY (id_producto) REFERENCES Producto (id_producto)
);

CREATE TABLE Informe (
id_informe INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
fecha DATE,
totalProductosVendidos INTEGER,
ganancias DOUBLE,
id_inventario INTEGER,
id_boleta INTEGER,
FOREIGN KEY (id_inventario) REFERENCES Inventario (id_inventario),
FOREIGN KEY (id_boleta) REFERENCES Boleta (id_boleta)
);

#----------------Población de tablas----------------

INSERT INTO Proveedor (id_proveedor)
VALUES (1), (2);

INSERT INTO TipoProducto (nombreCategoria)
VALUES ("Comida"), ("Aseo"), ("Primera necesidad"), ("Juguetes");

INSERT INTO Producto (nombreProducto, precioCompra, precioVenta, id_proveedor, id_tipoProducto, nombreCategoria)
VALUES
("Pan", 1000, 1500, 1, 1, ""),
("Quix", 2000, 3200, 2, 2, ""),
("Jabón", 800, 1200, 1, 3, ""),
("Hotwheels", 5000, 7000, 2, 4, ""),
("Fideos", 1000, 1600, 1, 3, "");

#----------------Update----------------

UPDATE Producto
SET nombreCategoria = "Comida"
WHERE id_tipoProducto = 1;

UPDATE Producto
SET nombreCategoria = "Aseo"
WHERE id_tipoProducto = 2;

UPDATE Producto
SET nombreCategoria = "Primera necesidad"
WHERE id_tipoProducto = 3;

UPDATE Producto
SET nombreCategoria = "Juguetes"
WHERE id_tipoProducto = 4;

#----------------Consultas básicas----------------
SELECT DISTINCT * FROM TipoProducto;
SELECT DISTINCT * FROM Producto;

#----------------Consulta con Join----------------

SELECT DISTINCT Producto.nombreProducto, Producto.id_proveedor
FROM Producto RIGHT JOIN Proveedor ON Producto.id_proveedor = 1;

SELECT DISTINCT Producto.nombreProducto, Producto.id_tipoProducto, Producto.nombreCategoria
FROM Producto JOIN TipoProducto ON Producto.id_tipoProducto = TipoProducto.id_tipoProducto
WHERE TipoProducto.nombreCategoria LIKE 'Primera necesidad';

