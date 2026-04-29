-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-03-2026 a las 19:13:36
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30
-- CORREGIDO: Unidades de medida ampliadas y RFC como clave primaria en proveedores

CREATE DATABASE IF NOT EXISTS dulceria_lupitabd;
USE dulceria_lupitabd;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dulceria_lupitabd`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_medida`
--

CREATE TABLE `unidad_medida` (
  `ID_unidad` int(11) NOT NULL,
  `Unidad_medida` varchar(50) NOT NULL,
  `Tipo_unidad` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `unidad_medida`
-- Incluye: Unidades, Peso y Volumen/Capacidad
--

INSERT INTO `unidad_medida` (`ID_unidad`, `Unidad_medida`, `Tipo_unidad`) VALUES
-- Unidades (Piezas/Cantidad)
(1, 'Pieza', 'Unidad'),
(2, 'Docena', 'Unidad'),
(3, 'Par', 'Unidad'),
(4, 'Caja', 'Unidad'),
(5, 'Unidades', 'Unidad'),
-- Peso (Masa)
(6, 'Kilogramo (kg)', 'Peso'),
(7, 'Gramo (g)', 'Peso'),
(8, 'Miligramo (mg)', 'Peso'),
(9, 'Tonelada', 'Peso'),
(10, 'Libra', 'Peso'),
(11, 'Onza', 'Peso'),
-- Volumen/Capacidad
(12, 'Litro (l)', 'Volumen'),
(13, 'Mililitro (ml)', 'Volumen'),
(14, 'Centímetro cúbico', 'Volumen'),
(15, 'Galón', 'Volumen'),
(16, 'Onza líquida', 'Volumen');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `ID_categoria` int(11) NOT NULL,
  `Nombre_categoria` varchar(100) NOT NULL,
  `Descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`ID_categoria`, `Nombre_categoria`, `Descripcion`) VALUES
(1, 'higiene', 'Productos para el cuidado personal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
-- MODIFICADO: RFC como clave primaria en lugar de ID_proveedor
--

CREATE TABLE `proveedores` (
  `RFC` varchar(13) NOT NULL,
  `Nombre` varchar(150) NOT NULL,
  `Contacto` varchar(100) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Direccion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`RFC`, `Nombre`, `Contacto`, `Telefono`, `Direccion`) VALUES
('DOV123456ABC', 'Dove', 'San Nic', '12345', 'San Nic');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID_usuario` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Rol` varchar(100) NOT NULL,
  `Correo` varchar(150) NOT NULL,
  `contraseña_hash` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID_usuario`, `Nombre`, `Rol`, `Correo`, `contraseña_hash`) VALUES
(1, 'Juan Perez', 'Administrativo', 'juan@perez.com', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `ID_sucursal` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Contacto` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`ID_sucursal`, `Nombre`, `Contacto`) VALUES
(1, 'Dulceria 1', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `ID_producto` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `ID_categoria` int(11) NOT NULL,
  `ID_unidad` int(11) NOT NULL,
  `Stock_anual` int(11) NOT NULL,
  `Stock_minimo` int(11) NOT NULL,
  `Precio_unitario` decimal(10,2) NOT NULL,
  `Fecha_caducidad` date NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`ID_producto`, `Nombre`, `Descripcion`, `ID_categoria`, `ID_unidad`, `Stock_anual`, `Precio_unitario`) VALUES
(1, 'Jabón Liquido', 'Jabón para manos de la marca dove', 1, 1, 5, 25.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ajustes_inventario`
--

CREATE TABLE `ajustes_inventario` (
  `ID_ajuste` int(11) NOT NULL,
  `ID_producto` int(11) NOT NULL,
  `Cantidad_ajustada` int(11) NOT NULL,
  `Motivo` varchar(200) NOT NULL,
  `Fecha_ajuste` date NOT NULL,
  `ID_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alertas_stock`
--

CREATE TABLE `alertas_stock` (
  `ID_alerta` int(11) NOT NULL,
  `ID_producto` int(11) NOT NULL,
  `Stock_minimo` int(11) NOT NULL,
  `Stock_maximo` int(11) NOT NULL,
  `Estado_alerta` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Disparadores `alertas_stock`
--
DELIMITER $$
CREATE TRIGGER `trg_validar_stock_min_max` BEFORE INSERT ON `alertas_stock` FOR EACH ROW BEGIN
    IF NEW.Stock_maximo <= NEW.Stock_minimo THEN
        SET NEW.ID_producto = NULL;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradas`
-- MODIFICADO: RFC_proveedor en lugar de ID_proveedor
--

CREATE TABLE `entradas` (
  `ID_entrada` int(11) NOT NULL,
  `Fecha_entrada` date NOT NULL,
  `ID_producto` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Costo_unitario` decimal(10,2) NOT NULL,
  `RFC_proveedor` varchar(13) NOT NULL,
  `ID_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `entradas`
--

INSERT INTO `entradas` (`ID_entrada`, `Fecha_entrada`, `ID_producto`, `Cantidad`, `Costo_unitario`, `RFC_proveedor`, `ID_usuario`) VALUES
(1, '2026-01-23', 1, 5, 20.00, 'DOV123456ABC', 1);

--
-- Disparadores `entradas`
--
DELIMITER $$
CREATE TRIGGER `trg_entrada_actualiza_productos` AFTER INSERT ON `entradas` FOR EACH ROW BEGIN
    IF NEW.cantidad > 0 THEN
        UPDATE productos
        SET stock_anual = stock_anual + NEW.cantidad
        WHERE id_producto = NEW.id_producto;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_inicial`
--

CREATE TABLE `inventario_inicial` (
  `ID_producto` int(11) NOT NULL,
  `Cantidad_inicial` int(11) NOT NULL,
  `Fecha_registro` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE `movimientos` (
  `ID_movimiento` int(11) NOT NULL,
  `ID_producto` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Fecha_movimiento` date NOT NULL,
  `Referencia` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salidas`
--

CREATE TABLE `salidas` (
  `ID_salida` int(11) NOT NULL,
  `Fecha_salida` date NOT NULL,
  `ID_producto` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `ID_sucursal` int(11) NOT NULL,
  `ID_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `salidas`
--

INSERT INTO `salidas` (`ID_salida`, `Fecha_salida`, `ID_producto`, `Cantidad`, `ID_sucursal`, `ID_usuario`) VALUES
(1, '2026-01-25', 1, 8, 1, 1),
(2, '2026-02-25', 1, 100, 1, 1),
(3, '2026-02-25', 1, 100, 1, 1),
(4, '2026-02-25', 1, 100, 1, 1),
(5, '2026-02-18', 1, 3, 1, 1),
(6, '2026-02-18', 1, 3, 1, 1),
(7, '2026-02-18', 1, 10, 1, 1);

--
-- Disparadores `salidas`
--
DELIMITER $$
CREATE TRIGGER `trg_salida_validar_stock` BEFORE INSERT ON `salidas` FOR EACH ROW BEGIN
    DECLARE stock_actual INT;

    SELECT stock_anual INTO stock_actual
    FROM productos
    WHERE id_producto = NEW.id_producto;
    IF NEW.cantidad <= 0 THEN
        SET NEW.id_producto = NULL;
    ELSEIF stock_actual < NEW.cantidad THEN
        SET NEW.id_producto = NULL;
    ELSE
        UPDATE productos 
        SET stock_anual = stock_anual - NEW.cantidad
        WHERE id_producto = NEW.id_producto;
    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ajustes_inventario`
--
ALTER TABLE `ajustes_inventario`
  ADD PRIMARY KEY (`ID_ajuste`),
  ADD KEY `ID_producto` (`ID_producto`),
  ADD KEY `ID_usuario` (`ID_usuario`);

--
-- Indices de la tabla `alertas_stock`
--
ALTER TABLE `alertas_stock`
  ADD PRIMARY KEY (`ID_alerta`),
  ADD KEY `ID_producto` (`ID_producto`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`ID_categoria`);

--
-- Indices de la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD PRIMARY KEY (`ID_entrada`),
  ADD KEY `ID_producto` (`ID_producto`),
  ADD KEY `RFC_proveedor` (`RFC_proveedor`),
  ADD KEY `ID_usuario` (`ID_usuario`);

--
-- Indices de la tabla `inventario_inicial`
--
ALTER TABLE `inventario_inicial`
  ADD KEY `ID_producto` (`ID_producto`);

--
-- Indices de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD PRIMARY KEY (`ID_movimiento`),
  ADD KEY `ID_producto` (`ID_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`ID_producto`),
  ADD KEY `ID_categoria` (`ID_categoria`),
  ADD KEY `ID_unidad` (`ID_unidad`);

--
-- Indices de la tabla `proveedores`
-- MODIFICADO: RFC como clave primaria
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`RFC`);

--
-- Indices de la tabla `salidas`
--
ALTER TABLE `salidas`
  ADD PRIMARY KEY (`ID_salida`),
  ADD KEY `ID_producto` (`ID_producto`),
  ADD KEY `ID_sucursal` (`ID_sucursal`),
  ADD KEY `ID_usuario` (`ID_usuario`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`ID_sucursal`);

--
-- Indices de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  ADD PRIMARY KEY (`ID_unidad`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID_usuario`),
  ADD UNIQUE KEY `contraseña_hash` (`contraseña_hash`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ajustes_inventario`
--
ALTER TABLE `ajustes_inventario`
  MODIFY `ID_ajuste` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `alertas_stock`
--
ALTER TABLE `alertas_stock`
  MODIFY `ID_alerta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `ID_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `entradas`
--
ALTER TABLE `entradas`
  MODIFY `ID_entrada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  MODIFY `ID_movimiento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `ID_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `salidas`
--
ALTER TABLE `salidas`
  MODIFY `ID_salida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `ID_sucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  MODIFY `ID_unidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ajustes_inventario`
--
ALTER TABLE `ajustes_inventario`
  ADD CONSTRAINT `ajustes_inventario_ibfk_1` FOREIGN KEY (`ID_producto`) REFERENCES `productos` (`ID_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `ajustes_inventario_ibfk_2` FOREIGN KEY (`ID_usuario`) REFERENCES `usuarios` (`ID_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `alertas_stock`
--
ALTER TABLE `alertas_stock`
  ADD CONSTRAINT `alertas_stock_ibfk_1` FOREIGN KEY (`ID_producto`) REFERENCES `productos` (`ID_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `entradas`
-- MODIFICADO: RFC_proveedor referencia a proveedores(RFC)
--
ALTER TABLE `entradas`
  ADD CONSTRAINT `entradas_ibfk_1` FOREIGN KEY (`ID_producto`) REFERENCES `productos` (`ID_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `entradas_ibfk_2` FOREIGN KEY (`RFC_proveedor`) REFERENCES `proveedores` (`RFC`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `entradas_ibfk_3` FOREIGN KEY (`ID_usuario`) REFERENCES `usuarios` (`ID_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `inventario_inicial`
--
ALTER TABLE `inventario_inicial`
  ADD CONSTRAINT `inventario_inicial_ibfk_1` FOREIGN KEY (`ID_producto`) REFERENCES `productos` (`ID_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD CONSTRAINT `movimientos_ibfk_1` FOREIGN KEY (`ID_producto`) REFERENCES `productos` (`ID_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`ID_categoria`) REFERENCES `categorias` (`ID_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`ID_unidad`) REFERENCES `unidad_medida` (`ID_unidad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `salidas`
--
ALTER TABLE `salidas`
  ADD CONSTRAINT `salidas_ibfk_1` FOREIGN KEY (`ID_producto`) REFERENCES `productos` (`ID_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `salidas_ibfk_2` FOREIGN KEY (`ID_sucursal`) REFERENCES `sucursal` (`ID_sucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `salidas_ibfk_3` FOREIGN KEY (`ID_usuario`) REFERENCES `usuarios` (`ID_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- --------------------------------------------------------
-- PROCEDIMIENTOS ALMACENADOS
-- --------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE productos_proximos_a_caducar (
    IN dias_anticipacion INT
)
BEGIN
    SELECT 
        ID_producto,
        Nombre,
        Stock_anual,
        Fecha_caducidad,
        DATEDIFF(Fecha_caducidad, CURDATE()) AS Dias_restantes
    FROM productos
    WHERE Fecha_caducidad IS NOT NULL
      AND Fecha_caducidad <= DATE_ADD(CURDATE(), INTERVAL dias_anticipacion DAY)
      AND Fecha_caducidad >= CURDATE()
    ORDER BY Fecha_caducidad ASC;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE productos_bajo_stock (
    IN stock_minimo INT
)
BEGIN
    SELECT 
        ID_producto,
        Nombre,
        Stock_anual,
        Precio_unitario
    FROM productos
    WHERE Stock_anual <= stock_minimo
    ORDER BY Stock_anual ASC;
END$$

DELIMITER ;
