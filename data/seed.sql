-- Insertar datos TP2

-- 1. Tabla Persona (30 personas)
INSERT INTO persona (dni, nombre, apellido, telefono, email, domicilioActual) VALUES
(10, 'Nicolas', 'Pinera', '12345678', 'nico@gmail.com', 'Calle Falsa 123'),
(11, 'Juan', 'Battigane', '23456789', 'juanb@gmail.com', 'Avenida Siempreviva 742'),
(12, 'Maria', 'Gomez', '34567890', 'maria.g@hotmail.com', 'Rivadavia 100'),
(13, 'Carlos', 'Perez', '45678901', 'cperez@gmail.com', 'San Martin 500'),
(14, 'Ana', 'Lopez', '56789012', 'alopez@yahoo.com', 'Belgrano 250'),
(15, 'Luis', 'Rodriguez', '67890123', 'lrodriguez@gmail.com', '9 de Julio 10'),
(16, 'Elena', 'Sanchez', '78901234', 'esanchez@gmail.com', 'Colon 300'),
(17, 'Jorge', 'Martinez', '89012345', 'jmartinez@gmail.com', 'Cordoba 450'),
(18, 'Lucia', 'Diaz', '90123456', 'ldiaz@outlook.com', 'Santa Fe 600'),
(19, 'Pedro', 'Garcia', '01234567', 'pgarcia@gmail.com', 'Entre Rios 75'),
(20, 'Sofia', 'Fernandez', '11223344', 'sfernandez@gmail.com', 'Mendoza 880'),
(21, 'Diego', 'Gonzalez', '22334455', 'dgonzalez@gmail.com', 'Salta 12'),
(22, 'Laura', 'Vazquez', '33445566', 'lvazquez@gmail.com', 'Tucuman 150'),
(23, 'Martin', 'Romero', '44556677', 'mromero@gmail.com', 'La Rioja 200'),
(24, 'Paula', 'Alvarez', '55667788', 'palvarez@gmail.com', 'Jujuy 350'),
(25, 'Andres', 'Torres', '66778899', 'atorres@gmail.com', 'Chaco 400'),
(26, 'Rosa', 'Ruiz', '77889900', 'rruiz@gmail.com', 'Misiones 550'),
(27, 'Felipe', 'Suarez', '88990011', 'fsuarez@gmail.com', 'Corrientes 700'),
(28, 'Clara', 'Blanco', '99001122', 'cblanco@gmail.com', 'Neuquen 850'),
(29, 'Hugo', 'Castillo', '10101010', 'hcastillo@gmail.com', 'Chubut 900'),
(30, 'Marta', 'Ortega', '20202020', 'mortega@gmail.com', 'La Pampa 110'),
(31, 'Gabriel', 'Morales', '30303030', 'gmorales@gmail.com', 'Rio Negro 220'),
(32, 'Julia', 'Pereyra', '40404040', 'jpereyra@gmail.com', 'Santa Cruz 330'),
(33, 'Tomas', 'Gimenez', '50505050', 'tgimenez@gmail.com', 'Tierra del Fuego 440'),
(34, 'Victoria', 'Castro', '60606060', 'vcastro@gmail.com', 'San Luis 550'),
(35, 'Julian', 'Sosa', '70707070', 'jsosa@gmail.com', 'Catamarca 660'),
(36, 'Camila', 'Silva', '80808080', 'csilva@gmail.com', 'Santiago 770'),
(37, 'Santiago', 'Rojas', '90909090', 'srojas@gmail.com', 'Formosa 880'),
(38, 'Daniela', 'Medina', '11112222', 'dmedina@gmail.com', 'San Juan 990'),
(39, 'Oscar', 'Bustos', '33334444', 'obustos@gmail.com', 'Rosario 123');

-- 2. Tabla Sorteo
INSERT INTO sorteo (fechaInicio, fechaFin) VALUES
('2026-01-01 00:00:00', '2026-06-30 23:59:59'),
('2026-07-01 00:00:00', '2026-12-31 23:59:59'),
('2025-01-01 00:00:00', '2025-12-31 23:59:59');

-- 3. Tabla Grupo
INSERT INTO grupo (nombreGrupo, umbralRifaVendida) VALUES
('Grupo Alpha', 100),
('Grupo Beta', 150),
('Grupo Gamma', 80),
('Grupo Delta', 200);

-- 4. Tabla Afiliado (Las primeras 15 personas son afiliados)
INSERT INTO afiliado (dni, domicilioProcedencia, fechaIngreso, anioCursando, estadoCivil, cantRifas) VALUES
(10, 'Cordoba', '2024-03-10 08:00:00', 2024, 'SOLTERO', 10),
(11, 'Buenos Aires', '2023-02-15 09:00:00', 2023, 'SOLTERO', 15),
(12, 'Santa Fe', '2022-05-20 10:30:00', 2022, 'CASADO', 12),
(13, 'Mendoza', '2021-08-12 11:00:00', 2021, 'DIVORSIADO', 8),
(14, 'San Luis', '2024-01-05 14:00:00', 2024, 'SOLTERO', 20),
(15, 'La Pampa', '2023-11-22 15:30:00', 2023, 'CASADO', 5),
(16, 'Neuquen', '2022-09-18 16:45:00', 2022, 'SOLTERO', 30),
(17, 'Chubut', '2021-04-30 08:15:00', 2021, 'SOLTERO', 10),
(18, 'Rio Negro', '2024-02-14 09:20:00', 2024, 'CASADO', 25),
(19, 'Tierra del Fuego', '2023-06-01 12:00:00', 2023, 'DIVORSIADO', 18),
(20, 'Santa Cruz', '2022-12-25 10:00:00', 2022, 'SOLTERO', 14),
(21, 'Jujuy', '2021-07-07 13:00:00', 2021, 'CASADO', 22),
(22, 'Salta', '2024-05-01 17:00:00', 2024, 'SOLTERO', 12),
(23, 'Tucuman', '2023-10-10 11:30:00', 2023, 'DIVORSIADO', 9),
(24, 'Catamarca', '2022-01-20 09:45:00', 2022, 'SOLTERO', 16);

-- 5. Tabla Comprador (Las siguientes 15 personas son compradores)
INSERT INTO comprador (dni) VALUES
(25), (26), (27), (28), (29), (30), (31), (32), (33), (34), (35), (36), (37), (38), (39);

-- 6. Tabla Rifa (Algunas rifas asociadas a afiliados y sorteos)
INSERT INTO rifa (serieRifa, nroAfiliado, codSorteo) VALUES
('A-001', 1, 1), ('A-002', 1, 1), ('A-003', 1, 1),
('B-001', 2, 1), ('B-002', 2, 1),
('C-001', 3, 2), ('C-002', 3, 2),
('D-001', 4, 2),
('E-001', 5, 3), ('E-002', 5, 3),
('F-001', 6, 1), ('F-002', 6, 1),
('G-001', 7, 2),
('H-001', 8, 3),
('I-001', 9, 1), ('I-002', 9, 1),
('J-001', 10, 2),
('K-001', 11, 3),
('L-001', 12, 1),
('M-001', 13, 2),
('N-001', 14, 3),
('O-001', 15, 1);

-- 7. Tabla Historial Grupo
INSERT INTO historialGrupo (nroAfiliado, idGrupo, anio) VALUES
(1, 1, 2024), (2, 1, 2024), (3, 1, 2024),
(4, 2, 2024), (5, 2, 2024), (6, 2, 2024),
(7, 3, 2024), (8, 3, 2024), (9, 3, 2024),
(10, 4, 2024), (11, 4, 2024), (12, 4, 2024),
(13, 1, 2023), (14, 2, 2023), (15, 3, 2023);

-- 8. Tabla Historial Venta
INSERT INTO historialVenta (idHistorialGrupo, cantidadRifaVendida) VALUES
(1, 50), (2, 45), (3, 60),
(4, 30), (5, 25), (6, 40),
(7, 20), (8, 15), (9, 22),
(10, 80), (11, 75), (12, 90),
(13, 100), (14, 110), (15, 70);

-- 9. Tabla Info Cuotas
INSERT INTO infoCuotas (cantidadCuotas, montoTotal, idComprador, numeroRifa) VALUES
(3, 3000.00, 1, 1),
(6, 6000.00, 2, 4),
(1, 1000.00, 3, 6),
(12, 12000.00, 4, 8),
(2, 2000.00, 5, 9),
(4, 4000.00, 6, 11),
(1, 1500.00, 7, 13),
(5, 5000.00, 8, 14),
(3, 3000.00, 9, 15),
(6, 6000.00, 10, 17);

-- 10. Tabla Cuotas (couta)
INSERT INTO couta (idInfoCuotas, monto, fechaPago, pagada, formaPago) VALUES
(1, 1000.00, '2026-04-01 10:00:00', TRUE, 'efectivo'),
(1, 1000.00, '2026-05-01 11:00:00', TRUE, 'transferencia'),
(1, 1000.00, '2026-06-01 09:30:00', FALSE, 'efectivo'),
(2, 1000.00, '2026-04-15 15:00:00', TRUE, 'transferencia'),
(2, 1000.00, '2026-05-15 14:00:00', FALSE, 'transferencia'),
(3, 1000.00, '2026-03-20 12:00:00', TRUE, 'efectivo'),
(4, 1000.00, '2026-01-10 10:00:00', TRUE, 'transferencia'),
(4, 1000.00, '2026-02-10 10:00:00', TRUE, 'transferencia'),
(5, 1000.00, '2026-05-05 16:00:00', TRUE, 'efectivo'),
(6, 1000.00, '2026-04-22 08:00:00', TRUE, 'transferencia');

-- 11. Tabla Historial Compra
INSERT INTO historialCompra (numeroRifa, idComprador, fechaCompra) VALUES
(1, 1, '2026-03-15 10:00:00'),
(4, 2, '2026-03-20 15:30:00'),
(6, 3, '2026-03-25 09:00:00'),
(8, 4, '2026-04-01 11:45:00'),
(9, 5, '2026-04-05 14:20:00'),
(11, 6, '2026-04-10 16:10:00'),
(13, 7, '2026-04-15 08:50:00'),
(14, 8, '2026-04-20 12:30:00'),
(15, 9, '2026-04-25 10:15:00'),
(17, 10, '2026-05-01 13:40:00');
