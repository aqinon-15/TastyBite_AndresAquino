USE libreriadb_in4cm;
-- 1. TABLA ROL
CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(30) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 2. TABLA USUARIO
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    id_rol INT NOT NULL,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) 
        REFERENCES rol(id_rol) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 3. TABLA MESA
CREATE TABLE mesa (
    id_mesa INT AUTO_INCREMENT PRIMARY KEY,
    numero_mesa INT NOT NULL UNIQUE,
    capacidad INT NOT NULL DEFAULT 4,
    estado ENUM('LIBRE', 'OCUPADA', 'RESERVADA') DEFAULT 'LIBRE'
) ENGINE=InnoDB;

-- 4. TABLA CATEGORIA
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(150)
) ENGINE=InnoDB;

-- 5. TABLA PLATILLO
CREATE TABLE platillo (
    id_platillo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    id_categoria INT NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_platillo_categoria FOREIGN KEY (id_categoria) 
        REFERENCES categoria(id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6. TABLA PEDIDO
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_mesa INT NOT NULL,
    id_mesero INT NOT NULL,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('PENDIENTE', 'EN_PREPARACION', 'LISTO', 'PAGADO', 'CANCELADO') DEFAULT 'PENDIENTE',
    CONSTRAINT fk_pedido_mesa FOREIGN KEY (id_mesa) 
        REFERENCES mesa(id_mesa) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_pedido_mesero FOREIGN KEY (id_mesero) 
        REFERENCES usuario(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7. TABLA DETALLE_PEDIDO
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_platillo INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    subtotal DECIMAL(10, 2) NOT NULL,
    observacion VARCHAR(150),
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (id_pedido) 
        REFERENCES pedido(id_pedido) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detalle_platillo FOREIGN KEY (id_platillo) 
        REFERENCES platillo(id_platillo) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 8. TABLA FACTURA
CREATE TABLE factura (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL UNIQUE,
    subtotal DECIMAL(10, 2) NOT NULL,
    impuesto DECIMAL(10, 2) NOT NULL,
    propina DECIMAL(10, 2) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    fecha_emision DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_cajero INT NOT NULL,
    CONSTRAINT fk_factura_pedido FOREIGN KEY (id_pedido) 
        REFERENCES pedido(id_pedido) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_factura_cajero FOREIGN KEY (id_cajero) 
        REFERENCES usuario(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ÍNDICES PARA OPTIMIZACIÓN DE CONSULTAS
CREATE INDEX idx_pedido_estado ON pedido(estado);
CREATE INDEX idx_pedido_fecha ON pedido(fecha_hora);
CREATE INDEX idx_platillo_categoria ON platillo(id_categoria);