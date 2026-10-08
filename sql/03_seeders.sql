
-- 1. Insertar Roles
INSERT INTO rol (nombre_rol) VALUES 
('MESERO'), 
('COCINERO'), 
('CAJERO'), 
('ADMIN');

-- 2. Insertar Usuarios
INSERT INTO usuario (nombre, username, password_hash, id_rol) VALUES
('Carlos Gómez', 'mesero1', '12345', 1),
('Ana Martínez', 'cocina1', '12345', 2),
('Mario López', 'cajero1', '12345', 3),
('Andrés Aquino', 'admin', 'admin123', 4),
('Luis Fernández', 'mesero2', '12345', 1);

-- 3. Insertar Mesas
INSERT INTO mesa (numero_mesa, capacidad, estado) VALUES 
(1, 4, 'LIBRE'), 
(2, 2, 'LIBRE'), 
(3, 6, 'LIBRE'), 
(4, 4, 'LIBRE'), 
(5, 8, 'LIBRE'),
(6, 2, 'LIBRE');

-- 4. Insertar Categorías
INSERT INTO categoria (nombre, descripcion) VALUES 
('Entradas', 'Aperitivos para comenzar'), 
('Platos Fuertes', 'Especialidades principales de la casa'), 
('Bebidas', 'Bebidas frías, calientes y refrescos'), 
('Postres', 'Postres artesanales y repostería'), 
('Snacks', 'Piqueos rápidos y complementos');

-- 5. Insertar Platillos / Menú
INSERT INTO platillo (nombre, precio, id_categoria, disponible) VALUES
('Hamburguesa Doble Queso', 45.00, 2, TRUE),
('Pizza Personal Pepperoni', 35.00, 2, TRUE),
('Papas Fritas Medianas', 18.00, 5, TRUE),
('Gaseosa 500ml', 10.00, 3, TRUE),
('Pastel de Chocolate Slicing', 25.00, 4, TRUE),
('Nachos con Queso y Guacamole', 28.00, 1, TRUE),
('Limonada Natural', 12.00, 3, TRUE);