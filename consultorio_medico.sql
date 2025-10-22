-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-07-2025 a las 06:19:42
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `consultorio_medico`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `CitNumero` int(11) NOT NULL,
  `CitFecha` date NOT NULL,
  `CitHora` varchar(10) NOT NULL,
  `CitPaciente` int(10) NOT NULL,
  `CitMedico` int(10) NOT NULL,
  `CitConsultorio` int(3) NOT NULL,
  `CitEstado` enum('Asignada','Cumplida') NOT NULL DEFAULT 'Asignada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultorios`
--

CREATE TABLE `consultorios` (
  `ConNumero` int(3) NOT NULL,
  `ConNombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `consultorios`
--

INSERT INTO `consultorios` (`ConNumero`, `ConNombre`) VALUES
(22, 'rayos x');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `MedIdentificacion` int(10) NOT NULL,
  `MedNombres` varchar(50) NOT NULL,
  `MedApellidos` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medicos`
--

INSERT INTO `medicos` (`MedIdentificacion`, `MedNombres`, `MedApellidos`) VALUES
(106639550, 'Carlos Felipe', 'Martinez Diaz'),
(106772856, 'pablo andres', 'ramires sanchez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `PacIdentificacion` int(10) NOT NULL,
  `PacNombres` varchar(50) NOT NULL,
  `PacApellidos` varchar(50) NOT NULL,
  `PacFechaNacimiento` date NOT NULL,
  `PacSexo` enum('M','F') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`PacIdentificacion`, `PacNombres`, `PacApellidos`, `PacFechaNacimiento`, `PacSexo`) VALUES
(1009876543, 'Alejandra Sofia', 'Martinez Diaz', '2007-02-27', 'F'),
(1012345678, 'Mateo Alejandro', 'Rodriguez Peña', '2003-01-19', 'M'),
(1023456789, 'Camila Alejandra', 'Gomez Herrera', '1999-11-15', 'F'),
(1055678901, 'Jorge Manuel', 'Santana Blanco', '2007-02-27', 'M'),
(1062984561, 'Laura Daniela', 'Ramirez Cruz', '2001-06-08', 'F'),
(1076543210, 'Andres Felipe', 'Morales Castro', '1997-12-05', 'M'),
(1081122334, 'Sebastian Andres', 'Lopez Sanchez', '2000-07-03', 'M'),
(1098765432, 'Mariana Isabel', 'Fernandez Ruiz', '1998-09-21', 'F');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamientos`
--

CREATE TABLE `tratamientos` (
  `TraNumero` int(11) NOT NULL,
  `TraFechaAsignado` date NOT NULL,
  `Descripcion` text NOT NULL,
  `TraFechaInicio` varchar(10) DEFAULT NULL,
  `TraObservaciones` text NOT NULL,
  `TraTemporal` varchar(2) DEFAULT NULL,
  `TraPaciente` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`CitNumero`),
  ADD KEY `CitPaciente` (`CitPaciente`),
  ADD KEY `CitMedico` (`CitMedico`),
  ADD KEY `CitConsultorio` (`CitConsultorio`);

--
-- Indices de la tabla `consultorios`
--
ALTER TABLE `consultorios`
  ADD PRIMARY KEY (`ConNumero`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`MedIdentificacion`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`PacIdentificacion`);

--
-- Indices de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD PRIMARY KEY (`TraNumero`),
  ADD KEY `TraPaciente` (`TraPaciente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `CitNumero` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`CitPaciente`) REFERENCES `pacientes` (`PacIdentificacion`),
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`CitMedico`) REFERENCES `medicos` (`MedIdentificacion`),
  ADD CONSTRAINT `citas_ibfk_3` FOREIGN KEY (`CitConsultorio`) REFERENCES `consultorios` (`ConNumero`);

--
-- Filtros para la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD CONSTRAINT `tratamientos_ibfk_1` FOREIGN KEY (`TraPaciente`) REFERENCES `pacientes` (`PacIdentificacion`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
