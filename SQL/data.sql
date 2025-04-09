--tipos de instrumento
INSERT INTO tipos_instrumentos (nombre) VALUES
('Guitarra'), ('Bajo'), ('Piano'), 
('Batería'), ('Violín'), ('Saxofón'),
('Trompeta'), ('Flauta'), ('Teclado'),
('Arpa');

--sucursales
INSERT INTO sucursales (nombre, direccion, telefono, ciudad) VALUES
('Music Central', 'Av. Principal 123', '555-1001', 'Ciudad de México'),
('Harmony Store', 'Calle Melodía 456', '555-2002', 'Guadalajara'),
('Sound Waves', 'Boulevard Armonía 789', '555-3003', 'Monterrey');

--tecnicos
INSERT INTO tecnicos (nombre, sucursal, telefono) VALUES
('Juan Pérez', 1, '555-1010'),
('María García', 1, '555-1011'),
('Carlos López', 2, '555-2020'),
('Ana Martínez', 3, '555-3030');

--instrumentos
INSERT INTO instrumentos (nombre, descripcion, precio, marca, modelo, tipo) VALUES
-- Guitarras
('Guitarra Acústica Fender', 'Guitarra acústica de concierto', 8999.99, 'Fender', 'FA-135CE', 1),
('Guitarra Eléctrica Stratocaster', 'Clásica Stratocaster color sunburst', 12999.99, 'Fender', 'Stratocaster', 1),
('Guitarra Clásica Yamaha', 'Guitarra clásica nylon para estudiantes', 4599.99, 'Yamaha', 'C40', 1),

-- Bajos
('Bajo Eléctrico Ibanez', 'Bajo de 4 cuerdas activo', 10999.99, 'Ibanez', 'SR300', 2),
('Bajo Precision Fender', 'Bajo Precision clásico', 14999.99, 'Fender', 'Precision Bass', 2),

-- Pianos
('Piano Digital Yamaha', 'Piano digital con teclado ponderado', 21999.99, 'Yamaha', 'P-45', 3),
('Piano Vertical Kawai', 'Piano acústico vertical', 45999.99, 'Kawai', 'K-15', 3),

-- Baterías
('Batería Acústica Pearl', 'Batería completa 5 piezas', 18999.99, 'Pearl', 'Export', 4),
('Batería Electrónica Roland', 'Batería electrónica profesional', 25999.99, 'Roland', 'TD-17KVX', 4),

-- Instrumentos de cuerda
('Violín Stentor', 'Violín estudiante 4/4', 5999.99, 'Stentor', 'Student II', 5),

-- Vientos
('Saxofón Alto Yamaha', 'Saxofón alto en Mi♭', 24999.99, 'Yamaha', 'YAS-280', 6),
('Trompeta Bach', 'Trompeta en Si♭ profesional', 18999.99, 'Bach', 'TR300', 7),
('Flauta Travesera Yamaha', 'Flauta traversa plata esterlina', 15999.99, 'Yamaha', 'YFL-222', 8),

-- Teclados
('Teclado Arranger Yamaha', 'Teclado arranger profesional', 17999.99, 'Yamaha', 'PSR-SX600', 9),

-- Otros
('Arpa Clásica', 'Arpa de 36 cuerdas', 45999.99, 'Lyon & Healy', 'Prelude', 10);

--accesorios
INSERT INTO accesorios (nombre, descripcion, precio, tienda_id, tipo_instrumento_id) VALUES
('Cuerdas para Guitarra', 'Juego de cuerdas 0.10', 299.99, 1, 1),
('Afinador Cromático', 'Afinador digital para todos los instrumentos', 499.99, 1, NULL),
('Soporte para Guitarra', 'Soporte plegable de seguridad', 399.99, 2, 1),
('Baqueta para Batería', 'Baquetas modelo 5A', 199.99, 1, 4),
('Estuche Rígido para Bajo', 'Estuche ABS para bajo eléctrico', 1299.99, 3, 2),
('Pedal de Efectos', 'Pedal multiefectos para guitarra/bajo', 2499.99, 2, 1),
('Atril para Partituras', 'Atril metálico ajustable', 349.99, 1, NULL),
('Limpia Vientos', 'Kit de limpieza para instrumentos de viento', 249.99, 3, 6),
('Aceite para Pianos', 'Aceite especial para mecanismos de piano', 599.99, 2, 3),
('Correa para Guitarra', 'Correa acolchada de 10cm de ancho', 449.99, 1, 1);

--clientes
INSERT INTO clientes (nombre, email) VALUES
('Roberto Sánchez', 'roberto.sanchez@email.com'),
('Laura Méndez', 'laura.mendez@email.com'),
('Javier Domínguez', 'javier.dominguez@email.com'),
('Sofía Castro', 'sofia.castro@email.com'),
('Miguel Ángel Reyes', 'miguel.reyes@email.com'),
('Ana Patricia López', 'ana.lopez@email.com'),
('Carlos Eduardo Fuentes', 'carlos.fuentes@email.com'),
('María Fernanda Gómez', 'maria.gomez@email.com'),
('José Luis Martínez', 'jose.martinez@email.com'),
('Lucía Hernández', 'lucia.hernandez@email.com');

--telefonos
INSERT INTO telefonos (telefono, cliente_id) VALUES
('4555-1111', 1), 
('4555-1112', 1),
('4555-2222', 2), 
('4555-3333', 3), 
('4555-3334', 3),
('4555-4444', 4),
('4555-5555', 5), 
('4555-5556', 5),
('4555-6666', 6),
('4555-7777', 7),
('4555-8888', 8), 
('4555-8889', 8),
('4555-9999', 9),
('4555-0000', 10), 
('4555-0001', 10);

--direcciones
INSERT INTO direcciones (cliente_id, casa, calle, ciudad, activa) VALUES
(1, '12', 'Av. de los Compositores', 'Ciudad de México', TRUE),
(2, '45', 'Calle Armonía', 'Guadalajara', TRUE),
(3, '78', 'Boulevard de las Artes', 'Monterrey', TRUE),
(4, '33', 'Calle Melodía', 'Puebla', TRUE),
(5, '21', 'Av. Ritmo', 'Ciudad de México', TRUE),
(6, '56', 'Calle Sinfonía', 'Guadalajara', TRUE),
(7, '89', 'Boulevard Acordes', 'Monterrey', TRUE),
(8, '44', 'Av. Musical', 'Toluca', TRUE),
(9, '17', 'Calle Notas', 'Querétaro', TRUE),
(10, '92', 'Boulevard Sonata', 'Ciudad de México', TRUE),
(1, '5', 'Calle Secundaria', 'Toluca', FALSE); -- Dirección inactiva


--carritos
INSERT INTO carritos (cliente_id, estado) VALUES
(1, 'completado'), (2, 'completado'), 
(3, 'completado'), (4, 'completado'),
(5, 'completado'), (6, 'completado'),
(7, 'completado'), (8, 'completado'),
(9, 'completado'), (10, 'completado'),
(1, 'completado'), (2, 'completado'),
(3, 'completado'), (4, 'completado'),
(5, 'completado'), (6, 'completado'),
(7, 'completado'), (8, 'completado'),
(9, 'completado'), (10, 'completado'),
(1, 'completado'), (2, 'completado'),
(3, 'completado'), (4, 'completado'),
(5, 'completado'), (6, 'completado'),
(7, 'completado'), (8, 'completado'),
(9, 'completado'), (10, 'completado');

--detalle_carrito
INSERT INTO detalles_carritos (carrito_id, instrumento_id, accesorio_id, cantidad, subtotal) VALUES
-- Carrito 1 (Guitarra + accesorios)
(1, 1, NULL, 1, 8999.99),  -- Guitarra Acústica Fender
(1, NULL, 1, 2, 599.98),    -- 2 juegos de cuerdas
(1, NULL, 3, 1, 399.99),    -- Soporte para guitarra

-- Carrito 2 (Bajo eléctrico + estuche)
(2, 4, NULL, 1, 10999.99),  -- Bajo Eléctrico Ibanez
(2, NULL, 5, 1, 1299.99),   -- Estuche rígido para bajo

-- Carrito 3 (Piano digital + atril)
(3, 6, NULL, 1, 21999.99),  -- Piano Digital Yamaha
(3, NULL, 7, 1, 349.99),    -- Atril para partituras

-- Carrito 4 (Violín + accesorios)
(4, 10, NULL, 1, 5999.99),  -- Violín Stentor
(4, NULL, 2, 1, 499.99),    -- Afinador cromático

-- Carrito 5 (Batería acústica + baquetas)
(5, 8, NULL, 1, 18999.99),  -- Batería Acústica Pearl
(5, NULL, 4, 3, 599.97),    -- 3 pares de baquetas

-- Carrito 6 (Saxofón + limpiador)
(6, 11, NULL, 1, 24999.99), -- Saxofón Alto Yamaha
(6, NULL, 8, 1, 249.99),    -- Kit de limpieza

-- Carrito 7 (Guitarra eléctrica + pedal)
(7, 2, NULL, 1, 12999.99),  -- Guitarra Eléctrica Stratocaster
(7, NULL, 6, 1, 2499.99),   -- Pedal de efectos

-- Carrito 8 (Teclado + aceite mantenimiento)
(8, 14, NULL, 1, 17999.99), -- Teclado Arranger Yamaha
(8, NULL, 9, 1, 599.99),    -- Aceite para teclados

-- Carrito 9 (Flauta + accesorios)
(9, 13, NULL, 1, 15999.99), -- Flauta Travesera Yamaha
(9, NULL, 8, 1, 249.99),    -- Kit de limpieza

-- Carrito 10 (Trompeta + mantenimiento)
(10, 12, NULL, 1, 18999.99), -- Trompeta Bach
(10, NULL, 8, 1, 249.99),    -- Kit de limpieza

-- Carrito 11 (Guitarra clásica + cuerdas)
(11, 3, NULL, 1, 4599.99),   -- Guitarra Clásica Yamaha
(11, NULL, 1, 3, 899.97),    -- 3 juegos de cuerdas

-- Carrito 12 (Bajo Precision + correa)
(12, 5, NULL, 1, 14999.99),  -- Bajo Precision Fender
(12, NULL, 10, 1, 449.99),   -- Correa acolchada

-- Carrito 13 (Piano vertical)
(13, 7, NULL, 1, 45999.99),  -- Piano Vertical Kawai

-- Carrito 14 (Batería electrónica)
(14, 9, NULL, 1, 25999.99),  -- Batería Electrónica Roland

-- Carrito 15 (Arpa)
(15, 15, NULL, 1, 45999.99), -- Arpa Clásica

-- Carrito 16 (Guitarra + bajo combo)
(16, 1, NULL, 1, 8999.99),   -- Guitarra Acústica
(16, 4, NULL, 1, 10999.99),  -- Bajo Eléctrico
(16, NULL, 2, 1, 499.99),    -- Afinador

-- Carrito 17 (Saxofón + trompeta)
(17, 11, NULL, 1, 24999.99), -- Saxofón
(17, 12, NULL, 1, 18999.99), -- Trompeta

-- Carrito 18 (Múltiples accesorios)
(18, NULL, 2, 2, 999.98),    -- 2 afinadores
(18, NULL, 7, 3, 1049.97),   -- 3 atriles
(18, NULL, 10, 2, 899.98),   -- 2 correas

-- Carrito 19 (Batería + guitarra)
(19, 8, NULL, 1, 18999.99),  -- Batería
(19, 2, NULL, 1, 12999.99),  -- Guitarra eléctrica

-- Carrito 20 (Kit completo para principiantes)
(20, 3, NULL, 1, 4599.99),   -- Guitarra clásica
(20, NULL, 1, 2, 599.98),    -- Cuerdas
(20, NULL, 2, 1, 499.99),    -- Afinador
(20, NULL, 7, 1, 349.99),    -- Atril

-- Carritos 21-30 (combinaciones variadas)
(21, 5, NULL, 1, 14999.99),  -- Bajo Precision
(21, NULL, 6, 1, 2499.99),   -- Pedal

(22, 6, NULL, 1, 21999.99),  -- Piano digital
(22, NULL, 9, 1, 599.99),    -- Aceite

(23, 10, NULL, 1, 5999.99),  -- Violín
(23, NULL, 2, 1, 499.99),    -- Afinador

(24, 11, NULL, 1, 24999.99), -- Saxofón
(24, NULL, 8, 2, 499.98),    -- 2 kits limpieza

(25, 12, NULL, 1, 18999.99), -- Trompeta
(25, NULL, 8, 1, 249.99),    -- Kit limpieza

(26, 13, NULL, 1, 15999.99), -- Flauta
(26, NULL, 8, 1, 249.99),    -- Kit limpieza

(27, 14, NULL, 1, 17999.99), -- Teclado
(27, NULL, 7, 1, 349.99),    -- Atril

(28, 15, NULL, 1, 45999.99), -- Arpa

(29, 8, NULL, 1, 18999.99),  -- Batería acústica
(29, NULL, 4, 2, 399.98),    -- 2 pares baquetas

(30, 2, NULL, 1, 12999.99),  -- Guitarra eléctrica
(30, NULL, 6, 1, 2499.99),   -- Pedal
(30, NULL, 10, 1, 449.99);   -- Correa

--pedidos

INSERT INTO pedidos (direccion_id, cliente_id, fecha_pedido, carrito_id, estado) VALUES
(1, 1, '2024-01-15 10:30:00', 1, 'entregado'),
(2, 2, '2024-01-16 11:45:00', 2, 'entregado'),
(3, 3, '2024-01-17 14:20:00', 3, 'entregado'),
(4, 4, '2024-01-18 16:10:00', 4, 'entregado'),
(5, 5, '2024-01-19 09:15:00', 5, 'entregado'),
(6, 6, '2024-01-20 13:25:00', 6, 'entregado'),
(7, 7, '2024-01-21 15:30:00', 7, 'entregado'),
(8, 8, '2024-01-22 12:40:00', 8, 'entregado'),
(9, 9, '2024-01-23 17:50:00', 9, 'entregado'),
(10, 10, '2024-01-24 10:20:00', 10, 'entregado'),
(1, 1, '2024-02-01 11:30:00', 11, 'entregado'),
(2, 2, '2024-02-02 14:45:00', 12, 'entregado'),
(3, 3, '2024-02-03 16:20:00', 13, 'entregado'),
(4, 4, '2024-02-04 09:10:00', 14, 'entregado'),
(5, 5, '2024-02-05 13:15:00', 15, 'entregado'),
(6, 6, '2024-02-06 15:25:00', 16, 'entregado'),
(7, 7, '2024-02-07 12:30:00', 17, 'entregado'),
(8, 8, '2024-02-08 17:40:00', 18, 'entregado'),
(9, 9, '2024-02-09 10:50:00', 19, 'entregado'),
(10, 10, '2024-02-10 14:20:00', 20, 'entregado'),
(1, 1, '2024-02-15 11:30:00', 21, 'procesando'),
(2, 2, '2024-02-16 14:45:00', 22, 'procesando'),
(3, 3, '2024-02-17 16:20:00', 23, 'enviado'),
(4, 4, '2024-02-18 09:10:00', 24, 'enviado'),
(5, 5, '2024-02-19 13:15:00', 25, 'cancelado'),
(6, 6, '2024-02-20 15:25:00', 26, 'entregado'),
(7, 7, '2024-02-21 12:30:00', 27, 'entregado'),
(8, 8, '2024-02-22 17:40:00', 28, 'entregado'),
(9, 9, '2024-02-23 10:50:00', 29, 'entregado'),
(10, 10, '2024-02-24 14:20:00', 30, 'entregado');

--mantenimientos
INSERT INTO mantenimientos (cliente_id, instrumento_id, tecnico_id, fecha_entrada, fecha_salida, descripcion, sucursal_id, costo) VALUES
(1, 1, 1, '2024-01-10 09:00:00', '2024-01-12 16:00:00', 'Cambio de cuerdas y ajuste de trastes', 1, 499.99),
(2, 4, 2, '2024-01-11 10:30:00', '2024-01-13 15:00:00', 'Ajuste de trasteo y electrónica', 1, 799.99),
(3, 6, 3, '2024-01-12 11:00:00', '2024-01-15 14:00:00', 'Afinación y regulación de teclas', 2, 1299.99),
(4, 10, 4, '2024-01-13 14:00:00', '2024-01-16 17:00:00', 'Ajuste de puente y cuerdas', 3, 599.99),
(5, 2, 1, '2024-01-15 10:00:00', '2024-01-17 16:00:00', 'Limpieza y ajuste de pastillas', 1, 699.99),
(6, 8, 2, '2024-01-16 11:30:00', '2024-01-18 15:30:00', 'Ajuste de parches y hardware', 1, 899.99),
(7, 11, 3, '2024-01-17 13:00:00', '2024-01-19 14:30:00', 'Limpieza y ajuste de mecanismos', 2, 1099.99),
(8, 12, 4, '2024-01-18 15:00:00', '2024-01-20 16:00:00', 'Limpieza y engrasado de pistones', 3, 799.99),
(9, 14, 1, '2024-01-19 09:30:00', '2024-01-21 17:00:00', 'Calibración de teclado y sonido', 1, 1199.99),
(10, 15, 2, '2024-01-20 10:00:00', '2024-01-22 15:00:00', 'Afinación y ajuste de cuerdas', 1, 1599.99),
(1, 3, 3, '2024-02-01 11:00:00', '2024-02-03 14:00:00', 'Cambio de cuerdas de nylon', 2, 399.99),
(2, 5, 4, '2024-02-02 14:30:00', '2024-02-04 16:30:00', 'Ajuste de trasteo y electrónica', 3, 899.99),
(3, 7, 1, '2024-02-03 16:00:00', '2024-02-05 17:00:00', 'Afinación profesional', 1, 1499.99),
(4, 9, 2, '2024-02-04 09:00:00', '2024-02-06 15:00:00', 'Calibración de sensores', 1, 999.99),
(5, 13, 3, '2024-02-05 13:00:00', '2024-02-07 14:00:00', 'Limpieza y ajuste de llaves', 2, 899.99),
(6, 1, 4, '2024-02-06 15:30:00', NULL, 'Reparación de tapa rota', 3, 1799.99),
(7, 4, 1, '2024-02-07 12:00:00', NULL, 'Cambio de pastillas', 1, 1299.99),
(8, 6, 2, '2024-02-08 17:00:00', '2024-02-10 16:00:00', 'Regulación de acción', 1, 999.99),
(9, 8, 3, '2024-02-09 10:30:00', '2024-02-11 14:30:00', 'Cambio de parches', 2, 699.99),
(10, 10, 4, '2024-02-10 14:00:00', '2024-02-12 17:00:00', 'Ajuste de alma y puente', 3, 599.99);

