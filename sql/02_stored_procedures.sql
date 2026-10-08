DELIMITER //

-- SP 1: Autenticación de Usuarios (Login)
CREATE PROCEDURE sp_validar_usuario(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT u.id_usuario, u.nombre, u.username, r.nombre_rol
    FROM usuario u
    INNER JOIN rol r ON u.id_rol = r.id_rol
    WHERE u.username = p_username AND u.password_hash = p_password;
END //

-- SP 2: Listar Mesas Disponibles
CREATE PROCEDURE sp_listar_mesas()
BEGIN
    SELECT id_mesa, numero_mesa, capacidad, estado 
    FROM mesa 
    ORDER BY numero_mesa ASC;
END //

-- SP 3: Listar Menú de Platillos Disponibles
CREATE PROCEDURE sp_listar_platillos()
BEGIN
    SELECT p.id_platillo, p.nombre, p.precio, c.nombre AS categoria, p.disponible
    FROM platillo p
    INNER JOIN categoria c ON p.id_categoria = c.id_categoria
    WHERE p.disponible = TRUE
    ORDER BY c.nombre, p.nombre;
END //

-- SP 4: Crear Comanda / Pedido (Mesero)
CREATE PROCEDURE sp_crear_pedido(
    IN p_id_mesa INT,
    IN p_id_mesero INT,
    OUT p_id_pedido INT
)
BEGIN
    INSERT INTO pedido (id_mesa, id_mesero, estado) 
    VALUES (p_id_mesa, p_id_mesero, 'PENDIENTE');
    
    SET p_id_pedido = LAST_INSERT_ID();
    
    UPDATE mesa SET estado = 'OCUPADA' WHERE id_mesa = p_id_mesa;
END //

-- SP 5: Agregar Detalle de Platillo a la Comanda
CREATE PROCEDURE sp_agregar_detalle_pedido(
    IN p_id_pedido INT,
    IN p_id_platillo INT,
    IN p_cantidad INT,
    IN p_observacion VARCHAR(150)
)
BEGIN
    DECLARE v_precio DECIMAL(10, 2);
    
    SELECT precio INTO v_precio FROM platillo WHERE id_platillo = p_id_platillo;
    
    INSERT INTO detalle_pedido (id_pedido, id_platillo, cantidad, subtotal, observacion)
    VALUES (p_id_pedido, p_id_platillo, p_cantidad, (v_precio * p_cantidad), p_observacion);
END //

-- SP 6: Monitor de Cocina (Listar pedidos pendientes por tiempo)
CREATE PROCEDURE sp_listar_comandas_cocina()
BEGIN
    SELECT p.id_pedido, m.numero_mesa, p.fecha_hora, p.estado,
           dp.cantidad, pl.nombre AS platillo, dp.observacion
    FROM pedido p
    INNER JOIN mesa m ON p.id_mesa = m.id_mesa
    INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
    INNER JOIN platillo pl ON dp.id_platillo = pl.id_platillo
    WHERE p.estado IN ('PENDIENTE', 'EN_PREPARACION')
    ORDER BY p.fecha_hora ASC;
END //

-- SP 7: Cambiar Estado de Pedido (Cocina -> Mesero)
CREATE PROCEDURE sp_actualizar_estado_pedido(
    IN p_id_pedido INT,
    IN p_nuevo_estado VARCHAR(20)
)
BEGIN
    UPDATE pedido SET estado = p_nuevo_estado WHERE id_pedido = p_id_pedido;
END //

-- SP 8: Cierre de Mesa, Cálculo de Totales y Facturación (Cajero)
CREATE PROCEDURE sp_cerrar_mesa_facturar(
    IN p_id_pedido INT,
    IN p_propina DECIMAL(10, 2),
    IN p_id_cajero INT
)
BEGIN
    DECLARE v_subtotal DECIMAL(10, 2);
    DECLARE v_impuesto DECIMAL(10, 2);
    DECLARE v_total DECIMAL(10, 2);
    DECLARE v_id_mesa INT;

    -- Subtotal acumulado de los platillos
    SELECT IFNULL(SUM(subtotal), 0) INTO v_subtotal 
    FROM detalle_pedido 
    WHERE id_pedido = p_id_pedido;

    -- Cálculo de IVA 12%
    SET v_impuesto = v_subtotal * 0.12;
    SET v_total = v_subtotal + v_impuesto + p_propina;

    SELECT id_mesa INTO v_id_mesa FROM pedido WHERE id_pedido = p_id_pedido;

    -- Generar Factura
    INSERT INTO factura (id_pedido, subtotal, impuesto, propina, total, id_cajero)
    VALUES (p_id_pedido, v_subtotal, v_impuesto, p_propina, v_total, p_id_cajero);

    -- Actualizar estados
    UPDATE pedido SET estado = 'PAGADO' WHERE id_pedido = p_id_pedido;
    UPDATE mesa SET estado = 'LIBRE' WHERE id_mesa = v_id_mesa;
END //

DELIMITER ;