-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-04-2021 a las 01:46:31
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tejido`
--
CREATE DATABASE IF NOT EXISTS `tejido` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tejido`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Borrar_token` (IN `T_token` VARCHAR(900))  NO SQL
DELETE FROM login WHERE token = T_token$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_comentarios_por_ID_PUBLICACION` (IN `Id_id_publicacion` INT(11))  NO SQL
SELECT usuarios.nombre_usuario, usuarios.apellido, comentarios.comentario, comentarios.Fecha FROM usuarios, comentarios WHERE usuarios.id_usuario = comentarios.id_usuario AND comentarios.id_publicaciones=Id_id_publicacion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_correo_contrasenia_tabla_login` (IN `C_correo` VARCHAR(150), IN `C_contrasenia` VARCHAR(40))  NO SQL
SELECT login.id_usuario FROM login WHERE login.correo = C_correo AND login.contrasenia=C_contrasenia$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Consultar_estado_publicacion` (IN `_id_publicacion` INT(11))  SELECT publicaciones.estado, publicaciones.id_publicaciones, publicaciones.texto, publicaciones.imagen, publicaciones.Fecha, publicaciones.tipo, usuarios.nombre_usuario, usuarios.apellido FROM publicaciones, usuarios WHERE usuarios.id_usuario = publicaciones.id_usuario AND publicaciones.id_publicaciones= _id_publicacion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Consultar_publiacion_por_IDPUBLICACION` (IN `ID_id_publiacion` INT)  SELECT publicaciones.estado,publicaciones.texto, publicaciones.imagen, publicaciones.Fecha, publicaciones.tipo, usuarios.nombre_usuario, usuarios.apellido FROM publicaciones, usuarios WHERE usuarios.id_usuario = publicaciones.id_usuario AND publicaciones.id_publicaciones= ID_id_publiacion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Consultar_publiacion_por_ID_USUARIO` (IN `ID_id_usuario` INT(11))  SELECT publicaciones.estado,publicaciones.texto, publicaciones.imagen, publicaciones.Fecha, publicaciones.tipo, usuarios.nombre_usuario, usuarios.apellido FROM publicaciones, usuarios WHERE usuarios.id_usuario = publicaciones.id_usuario AND publicaciones.id_usuario= ID_id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_reaccciones_por_ID_PUBLIACION` (IN `ID_id_publiacion` INT)  NO SQL
SELECT usuarios.id_usuario, usuarios.nombre_usuario, usuarios.apellido, reacciones.reaccion, reacciones.id_publicaciones FROM usuarios, reacciones WHERE usuarios.id_usuario = reacciones.id_usuario AND reacciones.id_publicaciones=ID_id_publiacion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_reaccion_por_ID_USUARIO` (IN `Id_id_usuario` INT(11))  NO SQL
SELECT usuarios.id_usuario, usuarios.nombre_usuario, usuarios.apellido, reacciones.reaccion, reacciones.id_publicaciones FROM usuarios, reacciones WHERE usuarios.id_usuario = reacciones.id_usuario AND reacciones.id_usuario=Id_id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Consultar_todos_tabla_departamentos` ()  NO SQL
SELECT * FROM departamentos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Consultar_todos_tabla_login` ()  NO SQL
SELECT * FROM login$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Consultar_todos_tabla_municipios` ()  NO SQL
SELECT * FROM municipios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Consultar_todos_tabla_usuarios` ()  NO SQL
SELECT * FROM usuarios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_departamento_por_ID_DEPARTAMENTO` (IN `Id_id_departamento` INT)  NO SQL
SELECT departamentos.id_departamento, departamentos.nombre_dep FROM departamentos WHERE departamentos.id_departamento= Id_id_departamento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_login_por_ID_LOGIN` (IN `Id_id_login` INT)  SELECT login.id_login, login.id_usuario, login.correo, login.contrasenia, login.estado FROM login WHERE login.id_login=Id_id_login$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_municipios_por_Id_municipio` (IN `_id_municipio` INT(11))  NO SQL
SELECT municipios.id_municipios,municipios.id_departamento, municipios.nombre_mun FROM municipios WHERE municipios.id_municipios = _id_municipio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Consulta_usuario_por_ID_USUARIO` (IN `ID_id_usuario` INT(11))  NO SQL
SELECT  usuarios.id_usuario,usuarios.nombre_usuario, usuarios.apellido, usuarios.sexo, usuarios.Fecha_nacimiento, usuarios.id_municipios, usuarios.tipo, usuarios.estado, usuarios.foto_perfil FROM usuarios WHERE usuarios.id_usuario = ID_id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_comentario` (IN `id_publicacionesfk` INT(11), IN `id_usuariofk` INT(11), IN `comentario` TEXT, IN `fecha` TIMESTAMP)  INSERT INTO comentarios(`id_publicaciones`,`id_usuario`,`comentario`,`Fecha`) VALUES ( id_publicacionesfk ,id_usuariofk, comentario, fecha)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_publicacion` (IN `id_usuariofk` INT(11), IN `texto` VARCHAR(900), IN `imagen` BLOB, IN `fecha` TIMESTAMP, IN `tipo` ENUM('P','V'), IN `estado` ENUM('A','I'))  INSERT INTO publicaciones(`id_usuario`,`texto`,`imagen`,`Fecha`,`tipo`,`estado`) VALUES ( id_usuariofk, texto, imagen, fecha, tipo, estado)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_reaccion` (IN `id_publicacionesfk` INT(11), IN `id_usuariofk` INT(11), IN `reaccion` ENUM('L','D'))  INSERT INTO reacciones(`id_publicaciones`,`id_usuario`,`reaccion`) VALUES ( id_publicacionesfk ,id_usuariofk, reaccion)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Crear_token` (IN `T_token` VARCHAR(900))  NO SQL
INSERT INTO login (token) VALUES  (T_token)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Crear_usuario_y_login` (IN `nombre` VARCHAR(100), IN `apellido` VARCHAR(100), IN `sexo` ENUM('M','F','O'), IN `fecha_nacimiento` TIMESTAMP, IN `id_municipios` INT(11), IN `tipo` ENUM('A','U'), IN `usuario_estado` ENUM('A','I'), IN `foto_perfil` BLOB, IN `correo` VARCHAR(150), IN `contrasenia` VARCHAR(150), IN `login_estado` ENUM('A','I','R'))  NO SQL
BEGIN
INSERT INTO usuarios(`nombre_usuario`,`apellido`,`sexo`,`Fecha_nacimiento`,`id_municipios`,`tipo`,`estado`,`foto_perfil`) VALUES ( nombre, apellido, sexo, fecha_nacimiento, id_municipios, tipo, usuario_estado, foto_perfil); INSERT INTO login(`id_usuario`,`correo`,`contrasenia`,`estado`) VALUES ((select LAST_INSERT_ID()), correo, contrasenia, login_estado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Modificar_publicacion` (IN `T_texto` VARCHAR(900), IN `I_imagen` BLOB, IN `F_fecha` TIMESTAMP, IN `T_tipo` ENUM('P','V'), IN `E_estado` ENUM('A','I'), IN `Id_id_publicaciones` INT(11))  UPDATE publicaciones SET texto=T_texto, imagen=I_imagen, Fecha=F_fecha, tipo= T_tipo, estado=E_estado WHERE id_publicaciones=Id_id_publicaciones$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Modificar_reaccion` (IN `R_reaccion` ENUM('L','D'), IN `Id_id_reaccciones` INT(11))  UPDATE reacciones SET reaccion=R_reaccion WHERE id_reacciones=Id_id_reaccciones$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Modificar_tabla_comentario` (IN `co_comentario` TEXT, IN `F_fecha` TIMESTAMP, IN `Id_id_comentario` INT(11))  UPDATE comentarios SET comentario=co_comentario, Fecha=F_fecha WHERE id_comentarios=Id_id_comentario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_tabla_login` (IN `co_correo` VARCHAR(150), IN `contra_contrasenia` VARCHAR(40), IN `esta_estado` ENUM('A','I','R'), IN `id_id_login` INT(11))  UPDATE login SET correo=co_correo, contrasenia=contra_contrasenia, estado=esta_estado WHERE id_login=id_id_login$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Modificar_tabla_usuarios` (IN `N_usuario` VARCHAR(100), IN `A_apellido` VARCHAR(100), IN `S_sexo` ENUM('M','F','O'), IN `F_nacimiento` TIMESTAMP, IN `Id_id_municipios` INT(11), IN `T_tipo` ENUM('A','U'), IN `E_estado` ENUM('A','I'), IN `F_perfil` BLOB, IN `Id_id_usuario` INT(11))  UPDATE usuarios SET nombre_usuario=N_usuario, apellido=A_apellido, sexo=S_sexo, Fecha_nacimiento= F_nacimiento, id_municipios=Id_id_municipios, tipo=T_tipo, estado=E_estado, foto_perfil=F_perfil WHERE id_usuario=Id_id_usuario$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id_comentarios` int(11) NOT NULL,
  `id_publicaciones` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `comentario` text NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(1, 1, 1, 'Hola mundo', '2021-04-11 22:27:06');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(2, 2, 2, 'Hola mundo 2', '2021-04-11 22:27:06');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(13, 23, 36, 'Gracias', '2021-04-16 14:39:00');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(14, 24, 37, 'Muy lindo', '2021-04-16 14:39:00');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(15, 25, 38, 'Prueba cambio de comentario', '2021-04-17 05:00:00');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(16, 26, 39, 'Me gusta mucho', '2021-04-16 14:39:00');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(17, 27, 40, 'Bien', '2021-04-16 14:39:00');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(18, 28, 41, 'Interesante', '2021-04-16 14:39:00');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(19, 29, 42, 'Precio', '2021-04-16 14:39:00');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(20, 30, 46, 'Gran aporte', '2021-04-16 14:39:00');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(21, 31, 47, 'Bueno', '2021-04-16 14:39:00');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(22, 32, 48, 'Buen articulo', '2021-04-16 14:39:00');
INSERT INTO `comentarios` (`id_comentarios`, `id_publicaciones`, `id_usuario`, `comentario`, `Fecha`) VALUES(23, 1, 1, 'prueba de comentarios', '2021-04-16 05:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `id_departamento` int(11) NOT NULL,
  `nombre_dep` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(1, 'AMAZONAS');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(2, 'ANTIOQUIA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(3, 'ARAUCA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(4, 'ARCHIPIELAGO DE SAN ANDRES');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(5, 'ATLANTICO');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(6, 'BOGOTA DC');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(7, 'BOLIVAR');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(8, 'BOYACA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(9, 'CALDAS');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(10, 'CAQUETA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(11, 'CASANARE');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(12, 'CAUCA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(13, 'CESAR');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(14, 'CHOCO');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(15, 'CORDOBA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(16, 'CUNDINAMARCA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(17, 'GUAINIA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(18, 'GUAVIARE');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(19, 'HUILA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(20, 'LA GUAJIRA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(21, 'MAGDALENA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(22, 'META');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(23, 'NARINO');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(24, 'NORTE DE SANTANDER');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(25, 'PUTUMAYO');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(26, 'QUINDIO');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(27, 'RISARALDA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(28, 'SANTANDER');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(29, 'SUCRE');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(30, 'TOLIMA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(31, 'VALLE DEL CAUCA');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(32, 'VAUPES');
INSERT INTO `departamentos` (`id_departamento`, `nombre_dep`) VALUES(33, 'VICHADA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `id_login` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `contrasenia` varchar(40) NOT NULL,
  `estado` enum('A','I','R') DEFAULT NULL COMMENT 'A = ACTIVO, I = INACTIVO, R = RETIRADO',
  `token` varchar(900) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(1, 1, 'jhon@uniminuto.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(2, 2, 'paola@uniminuto.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(3, 36, 'Miriam1234@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'I', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(4, 37, 'Jaime@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(5, 38, 'Karen@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(6, 39, 'Alison@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(7, 40, 'Laura@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(8, 41, 'Fabian@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(9, 42, 'Nelson@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(10, 43, 'Cindy@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(11, 44, 'Johana@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(12, 45, 'Nelson2@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'I', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(13, 46, 'Dayana@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'I', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(14, 47, 'Vanessa@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(15, 48, 'Deisy@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(16, 49, 'Nicol@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(31, 50, 'brayan@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(41, 68, 'andres@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');
INSERT INTO `login` (`id_login`, `id_usuario`, `correo`, `contrasenia`, `estado`, `token`) VALUES(42, 69, 'Luisa@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 'A', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--

CREATE TABLE `municipios` (
  `id_municipios` int(11) NOT NULL,
  `id_departamento` int(11) DEFAULT NULL,
  `nombre_mun` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `municipios`
--

INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1, 1, 'El Encanto');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(2, 1, 'La Chorrera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(3, 1, 'La Pedrera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(4, 1, 'La Victoria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(5, 1, 'Leticia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(6, 1, 'Miriti');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(7, 1, 'Puerto Alegria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(8, 1, 'Puerto Arica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(9, 1, 'Puerto Narino');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(10, 1, 'Puerto Santander');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(11, 1, 'Tarapaca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(12, 2, 'Caceres');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(13, 2, 'Caucasia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(14, 2, 'El Bagre');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(15, 2, 'Nechi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(16, 2, 'Taraza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(17, 2, 'Zaragoza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(18, 2, 'Caracoli');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(19, 2, 'Maceo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(20, 2, 'Puerto Berrio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(21, 2, 'Puerto Nare');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(22, 2, 'Puerto Triunfo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(23, 2, 'Yondo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(24, 2, 'Amalfi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(25, 2, 'Anori');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(26, 2, 'Cisneros');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(27, 2, 'Remedios');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(28, 2, 'San Roque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(29, 2, 'Santo Domingo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(30, 2, 'Segovia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(31, 2, 'Vegachi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(32, 2, 'Yali');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(33, 2, 'Yolombo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(34, 2, 'Angostura');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(35, 2, 'Belmira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(36, 2, 'Briceno');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(37, 2, 'Campamento');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(38, 2, 'Carolina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(39, 2, 'Don Matias');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(40, 2, 'Entrerrios');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(41, 2, 'Gomez Plata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(42, 2, 'Guadalupe');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(43, 2, 'Ituango');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(44, 2, 'San Andres');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(45, 2, 'San Jose De La Montana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(46, 2, 'San Pedro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(47, 2, 'Santa Rosa De Osos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(48, 2, 'Toledo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(49, 2, 'Valdivia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(50, 2, 'Yarumal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(51, 2, 'Abriaqui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(52, 2, 'Anza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(53, 2, 'Armenia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(54, 2, 'Buritica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(55, 2, 'Canasgordas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(56, 2, 'Dabeiba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(57, 2, 'Ebejico');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(58, 2, 'Frontino');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(59, 2, 'Giraldo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(60, 2, 'Heliconia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(61, 2, 'Liborina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(62, 2, 'Olaya');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(63, 2, 'Peque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(64, 2, 'Sabanalarga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(65, 2, 'San Jeronimo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(66, 2, 'Santafe De Antioquia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(67, 2, 'Sopetran');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(68, 2, 'Uramita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(69, 2, 'Abejorral');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(70, 2, 'Alejandria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(71, 2, 'Argelia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(72, 2, 'Carmen De Viboral');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(73, 2, 'Cocorna');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(74, 2, 'Concepcion');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(75, 2, 'Granada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(76, 2, 'Guarne');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(77, 2, 'Guatape');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(78, 2, 'La Ceja');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(79, 2, 'La Union');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(80, 2, 'Marinilla');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(81, 2, 'Narino');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(82, 2, 'Penol');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(83, 2, 'Retiro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(84, 2, 'Rionegro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(85, 2, 'San Carlos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(86, 2, 'San Francisco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(87, 2, 'San Luis');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(88, 2, 'San Rafael');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(89, 2, 'San Vicente');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(90, 2, 'Santuario');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(91, 2, 'Sonson');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(92, 2, 'Amaga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(93, 2, 'Andes');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(94, 2, 'Angelopolis');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(95, 2, 'Betania');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(96, 2, 'Betulia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(97, 2, 'Caicedo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(98, 2, 'Caramanta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(99, 2, 'Ciudad Bolivar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(100, 2, 'Concordia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(101, 2, 'Fredonia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(102, 2, 'Hispania');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(103, 2, 'Jardin');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(104, 2, 'Jerico');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(105, 2, 'La Pintada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(106, 2, 'Montebello');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(107, 2, 'Pueblorrico');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(108, 2, 'Salgar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(109, 2, 'Santa Barbara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(110, 2, 'Tamesis');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(111, 2, 'Tarso');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(112, 2, 'Titiribi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(113, 2, 'Urrao');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(114, 2, 'Valparaiso');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(115, 2, 'Venecia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(116, 2, 'Apartado');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(117, 2, 'Arboletes');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(118, 2, 'Carepa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(119, 2, 'Chigorodo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(120, 2, 'Murindo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(121, 2, 'Mutata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(122, 2, 'Necocli');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(123, 2, 'San Juan De Uraba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(124, 2, 'San Pedro De Uraba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(125, 2, 'Turbo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(126, 2, 'Vigia Del Fuerte');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(127, 2, 'Barbosa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(128, 2, 'Bello');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(129, 2, 'Caldas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(130, 2, 'Copacabana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(131, 2, 'Envigado');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(132, 2, 'Girardota');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(133, 2, 'Itagui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(134, 2, 'La Estrella');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(135, 2, 'Medellin');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(136, 2, 'Sabaneta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(137, 3, 'Arauca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(138, 3, 'Arauquita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(139, 3, 'Cravo Norte');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(140, 3, 'Fortul');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(141, 3, 'Puerto Rondon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(142, 3, 'Saravena');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(143, 3, 'Tame');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(144, 4, 'Providencia Y Santa Catalina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(145, 4, 'San Andres');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(146, 5, 'Barranquilla');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(147, 5, 'Galapa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(148, 5, 'Malambo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(149, 5, 'Puerto Colombia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(150, 5, 'Soledad');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(151, 5, 'Campo De La Cruz');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(152, 5, 'Candelaria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(153, 5, 'Luruaco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(154, 5, 'Manati');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(155, 5, 'Repelon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(156, 5, 'Santa Lucia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(157, 5, 'Suan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(158, 5, 'Baranoa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(159, 5, 'Palmar De Varela');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(160, 5, 'Polonuevo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(161, 5, 'Ponedera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(162, 5, 'Sabanagrande');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(163, 5, 'Sabanalarga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(164, 5, 'Santo Tomas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(165, 5, 'Juan De Acosta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(166, 5, 'Piojo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(167, 5, 'Tubara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(168, 5, 'Usiacuri');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(169, 6, 'Bogota');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(170, 7, 'Cicuco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(171, 7, 'Hatillo De Loba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(172, 7, 'Margarita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(173, 7, 'Mompos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(174, 7, 'San Fernando');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(175, 7, 'Talaigua Nuevo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(176, 7, 'Arjona');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(177, 7, 'Arroyohondo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(178, 7, 'Calamar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(179, 7, 'Cartagena');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(180, 7, 'Clemencia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(181, 7, 'Mahates');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(182, 7, 'San Cristobal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(183, 7, 'San Estanislao');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(184, 7, 'Santa Catalina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(185, 7, 'Santa Rosa De Lima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(186, 7, 'Soplaviento');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(187, 7, 'Turbaco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(188, 7, 'Turbana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(189, 7, 'Villanueva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(190, 7, 'Altos Del Rosario');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(191, 7, 'Barranco De Loba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(192, 7, 'El Penon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(193, 7, 'Regidor');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(194, 7, 'Rio Viejo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(195, 7, 'San Martin De Loba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(196, 7, 'Arenal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(197, 7, 'Cantagallo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(198, 7, 'Morales');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(199, 7, 'San Pablo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(200, 7, 'Santa Rosa Del Sur');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(201, 7, 'Simiti');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(202, 7, 'Achi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(203, 7, 'Magangue');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(204, 7, 'Montecristo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(205, 7, 'Pinillos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(206, 7, 'San Jacinto Del Cauca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(207, 7, 'Tiquisio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(208, 7, 'Carmen De Bolivar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(209, 7, 'Cordoba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(210, 7, 'El Guamo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(211, 7, 'Maria La Baja');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(212, 7, 'San Jacinto');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(213, 7, 'San Juan Nepomuceno');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(214, 7, 'Zambrano');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(215, 8, 'Chiquiza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(216, 8, 'Chivata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(217, 8, 'Combita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(218, 8, 'Cucaita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(219, 8, 'Motavita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(220, 8, 'Oicata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(221, 8, 'Samaca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(222, 8, 'Siachoque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(223, 8, 'Sora');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(224, 8, 'Soraca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(225, 8, 'Sotaquira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(226, 8, 'Toca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(227, 8, 'Tunja');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(228, 8, 'Tuta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(229, 8, 'Ventaquemada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(230, 8, 'Chiscas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(231, 8, 'Cubara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(232, 8, 'El Cocuy');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(233, 8, 'El Espino');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(234, 8, 'Guacamayas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(235, 8, 'Güican');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(236, 8, 'Panqueba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(237, 8, 'Labranzagrande');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(238, 8, 'Pajarito');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(239, 8, 'Paya');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(240, 8, 'Pisba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(241, 8, 'Berbeo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(242, 8, 'Campohermoso');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(243, 8, 'Miraflores');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(244, 8, 'Paez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(245, 8, 'San Eduardo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(246, 8, 'Zetaquira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(247, 8, 'Boyaca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(248, 8, 'Cienega');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(249, 8, 'Jenesano');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(250, 8, 'Nuevo Colon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(251, 8, 'Ramiriqui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(252, 8, 'Rondon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(253, 8, 'Tibana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(254, 8, 'Turmeque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(255, 8, 'Umbita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(256, 8, 'Viracacha');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(257, 8, 'Chinavita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(258, 8, 'Garagoa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(259, 8, 'Macanal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(260, 8, 'Pachavita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(261, 8, 'San Luis De Gaceno');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(262, 8, 'Santa Maria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(263, 8, 'Boavita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(264, 8, 'Covarachia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(265, 8, 'La Uvita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(266, 8, 'San Mateo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(267, 8, 'Sativanorte');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(268, 8, 'Sativasur');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(269, 8, 'Soata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(270, 8, 'Susacon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(271, 8, 'Tipacoque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(272, 8, 'Briceno');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(273, 8, 'Buenavista');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(274, 8, 'Caldas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(275, 8, 'Chiquinquira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(276, 8, 'Coper');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(277, 8, 'La Victoria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(278, 8, 'Maripi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(279, 8, 'Muzo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(280, 8, 'Otanche');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(281, 8, 'Pauna');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(282, 8, 'Puerto Boyaca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(283, 8, 'Quipama');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(284, 8, 'Saboya');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(285, 8, 'San Miguel De Sema');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(286, 8, 'San Pablo Borbur');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(287, 8, 'Tunungua');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(288, 8, 'Almeida');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(289, 8, 'Chivor');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(290, 8, 'Guateque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(291, 8, 'Guayata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(292, 8, 'La Capilla');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(293, 8, 'Somondoco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(294, 8, 'Sutatenza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(295, 8, 'Tenza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(296, 8, 'Arcabuco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(297, 8, 'Chitaraque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(298, 8, 'Gachantiva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(299, 8, 'Moniquira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(300, 8, 'Raquira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(301, 8, 'Sachica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(302, 8, 'San Jose De Pare');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(303, 8, 'Santa Sofia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(304, 8, 'Santana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(305, 8, 'Sutamarchan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(306, 8, 'Tinjaca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(307, 8, 'Togüi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(308, 8, 'Villa De Leyva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(309, 8, 'Aquitania');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(310, 8, 'Cuitiva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(311, 8, 'Firavitoba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(312, 8, 'Gameza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(313, 8, 'Iza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(314, 8, 'Mongua');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(315, 8, 'Mongui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(316, 8, 'Nobsa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(317, 8, 'Pesca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(318, 8, 'Sogamoso');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(319, 8, 'Tibasosa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(320, 8, 'Topaga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(321, 8, 'Tota');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(322, 8, 'Belen');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(323, 8, 'Busbanza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(324, 8, 'Cerinza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(325, 8, 'Corrales');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(326, 8, 'Duitama');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(327, 8, 'Floresta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(328, 8, 'Paipa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(329, 8, 'San Rosa Viterbo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(330, 8, 'Tutaza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(331, 8, 'Beteitiva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(332, 8, 'Chita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(333, 8, 'Jerico');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(334, 8, 'Paz De Rio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(335, 8, 'Socha');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(336, 8, 'Socota');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(337, 8, 'Tasco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(338, 9, 'Filadelfia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(339, 9, 'La Merced');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(340, 9, 'Marmato');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(341, 9, 'Riosucio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(342, 9, 'Supia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(343, 9, 'Manzanares');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(344, 9, 'Marquetalia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(345, 9, 'Marulanda');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(346, 9, 'Pensilvania');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(347, 9, 'Anserma');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(348, 9, 'Belalcazar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(349, 9, 'Risaralda');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(350, 9, 'San Jose');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(351, 9, 'Viterbo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(352, 9, 'Chinchina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(353, 9, 'Manizales');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(354, 9, 'Neira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(355, 9, 'Palestina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(356, 9, 'Villamaria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(357, 9, 'Aguadas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(358, 9, 'Aranzazu');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(359, 9, 'Pacora');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(360, 9, 'Salamina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(361, 9, 'La Dorada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(362, 9, 'Norcasia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(363, 9, 'Samana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(364, 9, 'Victoria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(365, 10, 'Albania');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(366, 10, 'Belen De Los Andaquies');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(367, 10, 'Cartagena Del Chaira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(368, 10, 'Currillo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(369, 10, 'El Doncello');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(370, 10, 'El Paujil');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(371, 10, 'Florencia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(372, 10, 'La Montanita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(373, 10, 'Milan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(374, 10, 'Morelia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(375, 10, 'Puerto Rico');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(376, 10, 'San Jose Del Fragua');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(377, 10, 'San Vicente Del Caguan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(378, 10, 'Solano');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(379, 10, 'Solita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(380, 10, 'Valparaiso');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(381, 11, 'Aguazul');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(382, 11, 'Chameza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(383, 11, 'Hato Corozal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(384, 11, 'La Salina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(385, 11, 'Mani');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(386, 11, 'Monterrey');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(387, 11, 'Nunchia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(388, 11, 'Orocue');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(389, 11, 'Paz De Ariporo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(390, 11, 'Pore');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(391, 11, 'Recetor');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(392, 11, 'Sabanalarga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(393, 11, 'Sacama');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(394, 11, 'San Luis De Palenque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(395, 11, 'Tamara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(396, 11, 'Tauramena');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(397, 11, 'Trinidad');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(398, 11, 'Villanueva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(399, 11, 'Yopal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(400, 12, 'Cajibio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(401, 12, 'El Tambo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(402, 12, 'La Sierra');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(403, 12, 'Morales');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(404, 12, 'Piendamo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(405, 12, 'Popayan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(406, 12, 'Rosas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(407, 12, 'Sotara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(408, 12, 'Timbio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(409, 12, 'Buenos Aires');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(410, 12, 'Caloto');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(411, 12, 'Corinto');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(412, 12, 'Miranda');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(413, 12, 'Padilla');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(414, 12, 'Puerto Tejada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(415, 12, 'Santander De Quilichao');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(416, 12, 'Suarez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(417, 12, 'Villa Rica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(418, 12, 'Guapi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(419, 12, 'Lopez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(420, 12, 'Timbiqui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(421, 12, 'Caldono');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(422, 12, 'Inza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(423, 12, 'Jambalo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(424, 12, 'Paez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(425, 12, 'Purace');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(426, 12, 'Silvia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(427, 12, 'Toribio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(428, 12, 'Totoro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(429, 12, 'Almaguer');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(430, 12, 'Argelia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(431, 12, 'Balboa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(432, 12, 'Bolivar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(433, 12, 'Florencia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(434, 12, 'La Vega');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(435, 12, 'Mercaderes');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(436, 12, 'Patia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(437, 12, 'Piamonte');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(438, 12, 'San Sebastian');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(439, 12, 'Santa Rosa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(440, 12, 'Sucre');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(441, 13, 'Becerril');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(442, 13, 'Chimichagua');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(443, 13, 'Chiriguana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(444, 13, 'Curumani');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(445, 13, 'La Jagua De Ibirico');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(446, 13, 'Pailitas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(447, 13, 'Tamalameque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(448, 13, 'Astrea');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(449, 13, 'Bosconia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(450, 13, 'El Copey');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(451, 13, 'El Paso');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(452, 13, 'Agustin Codazzi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(453, 13, 'La Paz');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(454, 13, 'Manaure');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(455, 13, 'Pueblo Bello');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(456, 13, 'San Diego');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(457, 13, 'Valledupar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(458, 13, 'Aguachica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(459, 13, 'Gamarra');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(460, 13, 'Gonzalez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(461, 13, 'La Gloria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(462, 13, 'Pelaya');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(463, 13, 'Rio De Oro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(464, 13, 'San Alberto');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(465, 13, 'San Martin');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(466, 14, 'Atrato');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(467, 14, 'Bagado');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(468, 14, 'Bojaya');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(469, 14, 'El Carmen De Atrato');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(470, 14, 'Lloro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(471, 14, 'Medio Atrato');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(472, 14, 'Quibdo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(473, 14, 'Rio Quito');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(474, 14, 'Acandi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(475, 14, 'Belen De Bajira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(476, 14, 'Carmen Del Darien');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(477, 14, 'Riosucio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(478, 14, 'Unguia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(479, 14, 'Bahia Solano');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(480, 14, 'Jurado');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(481, 14, 'Nuqui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(482, 14, 'Alto Baudo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(483, 14, 'Bajo Baudo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(484, 14, 'El Litoral Del San Juan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(485, 14, 'Medio Baudo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(486, 14, 'Canton De San Pablo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(487, 14, 'Certegui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(488, 14, 'Condoto');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(489, 14, 'Itsmina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(490, 14, 'Medio San Juan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(491, 14, 'Novita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(492, 14, 'Rio Frio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(493, 14, 'San Jose Del Palmar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(494, 14, 'Sipi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(495, 14, 'Tado');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(496, 14, 'Union Panamericana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(497, 15, 'Tierralta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(498, 15, 'Valencia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(499, 15, 'Chima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(500, 15, 'Cotorra');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(501, 15, 'Lorica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(502, 15, 'Momil');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(503, 15, 'Purisima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(504, 15, 'Monteria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(505, 15, 'Canalete');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(506, 15, 'Los Cordobas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(507, 15, 'Monitos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(508, 15, 'Puerto Escondido');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(509, 15, 'San Antero');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(510, 15, 'San Bernardo Del Viento');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(511, 15, 'Chinu');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(512, 15, 'Sahagun');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(513, 15, 'San Andres Sotavento');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(514, 15, 'Ayapel');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(515, 15, 'Buenavista');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(516, 15, 'La Apartada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(517, 15, 'Montelibano');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(518, 15, 'Planeta Rica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(519, 15, 'Pueblo Nuevo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(520, 15, 'Puerto Libertador');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(521, 15, 'Cerete');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(522, 15, 'Cienaga De Oro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(523, 15, 'San Carlos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(524, 15, 'San Pelayo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(525, 16, 'Choconta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(526, 16, 'Macheta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(527, 16, 'Manta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(528, 16, 'Sesquile');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(529, 16, 'Suesca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(530, 16, 'Tibirita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(531, 16, 'Villapinzon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(532, 16, 'Agua De Dios');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(533, 16, 'Girardot');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(534, 16, 'Guataqui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(535, 16, 'Jerusalen');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(536, 16, 'Narino');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(537, 16, 'Nilo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(538, 16, 'Ricaurte');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(539, 16, 'Tocaima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(540, 16, 'Caparrapi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(541, 16, 'Guaduas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(542, 16, 'Puerto Salgar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(543, 16, 'Alban');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(544, 16, 'La Pena');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(545, 16, 'La Vega');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(546, 16, 'Nimaima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(547, 16, 'Nocaima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(548, 16, 'Quebradanegra');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(549, 16, 'San Francisco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(550, 16, 'Sasaima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(551, 16, 'Supata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(552, 16, 'utica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(553, 16, 'Vergara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(554, 16, 'Villeta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(555, 16, 'Gachala');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(556, 16, 'Gacheta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(557, 16, 'Gama');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(558, 16, 'Guasca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(559, 16, 'Guatavita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(560, 16, 'Junin');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(561, 16, 'La Calera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(562, 16, 'Ubala');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(563, 16, 'Beltran');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(564, 16, 'Bituima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(565, 16, 'Chaguani');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(566, 16, 'Guayabal De Siquima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(567, 16, 'Puli');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(568, 16, 'San Juan De Rio Seco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(569, 16, 'Viani');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(570, 16, 'Medina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(571, 16, 'Paratebueno');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(572, 16, 'Caqueza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(573, 16, 'Chipaque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(574, 16, 'Choachi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(575, 16, 'Fomeque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(576, 16, 'Fosca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(577, 16, 'Guayabetal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(578, 16, 'Gutierrez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(579, 16, 'Quetame');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(580, 16, 'Ubaque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(581, 16, 'Une');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(582, 16, 'El Penon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(583, 16, 'La Palma');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(584, 16, 'Pacho');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(585, 16, 'Paime');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(586, 16, 'San Cayetano');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(587, 16, 'Topaipi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(588, 16, 'Villagomez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(589, 16, 'Yacopi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(590, 16, 'Cajica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(591, 16, 'Chia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(592, 16, 'Cogua');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(593, 16, 'Gachancipa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(594, 16, 'Nemocon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(595, 16, 'Sopo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(596, 16, 'Tabio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(597, 16, 'Tocancipa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(598, 16, 'Zipaquira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(599, 16, 'Bojaca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(600, 16, 'Cota');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(601, 16, 'El Rosal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(602, 16, 'Facatativa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(603, 16, 'Funza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(604, 16, 'Madrid');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(605, 16, 'Mosquera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(606, 16, 'Subachoque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(607, 16, 'Tenjo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(608, 16, 'Zipacon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(609, 16, 'Sibate');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(610, 16, 'Soacha');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(611, 16, 'Arbelaez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(612, 16, 'Cabrera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(613, 16, 'Fusagasuga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(614, 16, 'Granada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(615, 16, 'Pandi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(616, 16, 'Pasca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(617, 16, 'San Bernardo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(618, 16, 'Silvania');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(619, 16, 'Tibacuy');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(620, 16, 'Venecia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(621, 16, 'Anapoima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(622, 16, 'Anolaima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(623, 16, 'Apulo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(624, 16, 'Cachipay');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(625, 16, 'El Colegio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(626, 16, 'La Mesa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(627, 16, 'Quipile');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(628, 16, 'San Antonio De Tequendama');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(629, 16, 'Tena');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(630, 16, 'Viota');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(631, 16, 'Carmen De Carupa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(632, 16, 'Cucunuba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(633, 16, 'Fuquene');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(634, 16, 'Guacheta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(635, 16, 'Lenguazaque');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(636, 16, 'Simijaca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(637, 16, 'Susa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(638, 16, 'Sutatausa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(639, 16, 'Tausa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(640, 16, 'Ubate');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(641, 17, 'Barranco Mina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(642, 17, 'Cacahual');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(643, 17, 'Inirida');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(644, 17, 'La Guadalupe');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(645, 17, 'Mapiripan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(646, 17, 'Morichal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(647, 17, 'Pana Pana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(648, 17, 'Puerto Colombia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(649, 17, 'San Felipe');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(650, 18, 'Calamar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(651, 18, 'El Retorno');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(652, 18, 'Miraflores');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(653, 18, 'San Jose Del Guaviare');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(654, 19, 'Agrado');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(655, 19, 'Altamira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(656, 19, 'Garzon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(657, 19, 'Gigante');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(658, 19, 'Guadalupe');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(659, 19, 'Pital');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(660, 19, 'Suaza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(661, 19, 'Tarqui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(662, 19, 'Aipe');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(663, 19, 'Algeciras');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(664, 19, 'Baraya');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(665, 19, 'Campoalegre');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(666, 19, 'Colombia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(667, 19, 'Hobo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(668, 19, 'Iquira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(669, 19, 'Neiva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(670, 19, 'Palermo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(671, 19, 'Rivera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(672, 19, 'Santa Maria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(673, 19, 'Tello');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(674, 19, 'Teruel');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(675, 19, 'Villavieja');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(676, 19, 'Yaguara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(677, 19, 'La Argentina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(678, 19, 'La Plata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(679, 19, 'Nataga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(680, 19, 'Paicol');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(681, 19, 'Tesalia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(682, 19, 'Acevedo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(683, 19, 'Elias');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(684, 19, 'Isnos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(685, 19, 'Oporapa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(686, 19, 'Palestina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(687, 19, 'Pitalito');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(688, 19, 'Saladoblanco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(689, 19, 'San Agustin');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(690, 19, 'Timana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(691, 20, 'Albania');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(692, 20, 'Dibulla');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(693, 20, 'Maicao');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(694, 20, 'Manaure');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(695, 20, 'Riohacha');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(696, 20, 'Uribia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(697, 20, 'Barrancas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(698, 20, 'Distraccion');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(699, 20, 'El Molino');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(700, 20, 'Fonseca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(701, 20, 'Hatonuevo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(702, 20, 'La Jagua Del Pilar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(703, 20, 'San Juan Del Cesar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(704, 20, 'Urumita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(705, 20, 'Villanueva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(706, 21, 'Ariguani');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(707, 21, 'Chibolo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(708, 21, 'Nueva Granada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(709, 21, 'Plato');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(710, 21, 'Sabanas De San Angel');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(711, 21, 'Tenerife');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(712, 21, 'Algarrobo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(713, 21, 'Aracataca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(714, 21, 'Cienaga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(715, 21, 'El Reten');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(716, 21, 'Fundacion');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(717, 21, 'Pueblo Viejo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(718, 21, 'Zona Bananera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(719, 21, 'Cerro San Antonio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(720, 21, 'Concordia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(721, 21, 'El Pinon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(722, 21, 'Pedraza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(723, 21, 'Pivijay');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(724, 21, 'Remolino');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(725, 21, 'Salamina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(726, 21, 'Sitionuevo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(727, 21, 'Zapayan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(728, 21, 'Santa Marta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(729, 21, 'El Banco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(730, 21, 'Guamal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(731, 21, 'Pijino Del Carmen');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(732, 21, 'San Sebastian De Buenavista');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(733, 21, 'San Zenon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(734, 21, 'Santa Ana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(735, 21, 'Santa Barbara De Pinto');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(736, 22, 'El Castillo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(737, 22, 'El Dorado');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(738, 22, 'Fuente De Oro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(739, 22, 'Granada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(740, 22, 'La Macarena');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(741, 22, 'La Uribe');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(742, 22, 'Lejanias');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(743, 22, 'Mapiripan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(744, 22, 'Mesetas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(745, 22, 'Puerto Concordia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(746, 22, 'Puerto Lleras');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(747, 22, 'Puerto Rico');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(748, 22, 'San Juan De Arama');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(749, 22, 'Vista Hermosa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(750, 22, 'Villavicencio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(751, 22, 'Acacias');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(752, 22, 'Barranca De Upia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(753, 22, 'Castilla La Nueva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(754, 22, 'Cumaral');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(755, 22, 'El Calvario');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(756, 22, 'Guamal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(757, 22, 'Restrepo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(758, 22, 'San Carlos Guaroa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(759, 22, 'San Juanito');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(760, 22, 'San Luis De Cubarral');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(761, 22, 'San Martin');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(762, 22, 'Cabuyaro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(763, 22, 'Puerto Gaitan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(764, 22, 'Puerto Lopez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(765, 23, 'Chachagui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(766, 23, 'Consaca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(767, 23, 'El Penol');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(768, 23, 'El Tambo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(769, 23, 'La Florida');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(770, 23, 'Narino');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(771, 23, 'Pasto');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(772, 23, 'Sandona');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(773, 23, 'Tangua');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(774, 23, 'Yacuanquer');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(775, 23, 'Ancuya');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(776, 23, 'Guaitarilla');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(777, 23, 'La Llanada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(778, 23, 'Linares');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(779, 23, 'Los Andes');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(780, 23, 'Mallama');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(781, 23, 'Ospina');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(782, 23, 'Providencia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(783, 23, 'Ricaurte');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(784, 23, 'Samaniego');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(785, 23, 'Santa Cruz');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(786, 23, 'Sapuyes');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(787, 23, 'Tuquerres');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(788, 23, 'Barbacoas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(789, 23, 'El Charco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(790, 23, 'Francisco Pizarro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(791, 23, 'La Tola');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(792, 23, 'Magui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(793, 23, 'Mosquera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(794, 23, 'Olaya Herrera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(795, 23, 'Roberto Payan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(796, 23, 'Santa Barbara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(797, 23, 'Tumaco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(798, 23, 'Alban');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(799, 23, 'Arboleda');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(800, 23, 'Belen');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(801, 23, 'Buesaco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(802, 23, 'Colon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(803, 23, 'Cumbitara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(804, 23, 'El Rosario');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(805, 23, 'El Tablon De Gomez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(806, 23, 'La Cruz');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(807, 23, 'La Union');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(808, 23, 'Leiva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(809, 23, 'Policarpa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(810, 23, 'San Bernardo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(811, 23, 'San Lorenzo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(812, 23, 'San Pablo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(813, 23, 'San Pedro De Cartago');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(814, 23, 'Taminango');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(815, 23, 'Aldana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(816, 23, 'Contadero');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(817, 23, 'Cordoba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(818, 23, 'Cuaspud');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(819, 23, 'Cumbal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(820, 23, 'Funes');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(821, 23, 'Guachucal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(822, 23, 'Gualmatan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(823, 23, 'Iles');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(824, 23, 'Imues');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(825, 23, 'Ipiales');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(826, 23, 'Potosi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(827, 23, 'Puerres');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(828, 23, 'Pupiales');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(829, 24, 'Arboledas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(830, 24, 'Cucutilla');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(831, 24, 'Gramalote');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(832, 24, 'Lourdes');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(833, 24, 'Salazar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(834, 24, 'Santiago');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(835, 24, 'Villa Caro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(836, 24, 'Bucarasica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(837, 24, 'El Tarra');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(838, 24, 'Sardinata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(839, 24, 'Tibu');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(840, 24, 'Abrego');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(841, 24, 'Cachira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(842, 24, 'Convencion');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(843, 24, 'El Carmen');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(844, 24, 'Hacari');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(845, 24, 'La Esperanza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(846, 24, 'La Playa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(847, 24, 'Ocana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(848, 24, 'San Calixto');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(849, 24, 'Teorama');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(850, 24, 'Cucuta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(851, 24, 'El Zulia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(852, 24, 'Los Patios');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(853, 24, 'Puerto Santander');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(854, 24, 'San Cayetano');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(855, 24, 'Villa Del Rosario');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(856, 24, 'Cacota');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(857, 24, 'Chitaga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(858, 24, 'Mutiscua');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(859, 24, 'Pamplona');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(860, 24, 'Pamplonita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(861, 24, 'Silos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(862, 24, 'Bochalema');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(863, 24, 'Chinacota');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(864, 24, 'Durania');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(865, 24, 'Herran');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(866, 24, 'Labateca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(867, 24, 'Ragonvalia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(868, 24, 'Toledo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(869, 25, 'Colon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(870, 25, 'Mocoa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(871, 25, 'Orito');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(872, 25, 'Puerto Asis');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(873, 25, 'Puerto Caicedo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(874, 25, 'Puerto Guzman');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(875, 25, 'Puerto Leguizamo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(876, 25, 'San Francisco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(877, 25, 'San Miguel');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(878, 25, 'Santiago');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(879, 25, 'Sibundoy');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(880, 25, 'Valle Del Guamuez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(881, 25, 'Villa Garzon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(882, 26, 'Armenia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(883, 26, 'Buenavista');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(884, 26, 'Calarca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(885, 26, 'Cordoba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(886, 26, 'Genova');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(887, 26, 'Pijao');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(888, 26, 'Filandia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(889, 26, 'Salento');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(890, 26, 'Circasia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(891, 26, 'La Tebaida');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(892, 26, 'Montengro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(893, 26, 'Quimbaya');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(894, 27, 'Dosquebradas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(895, 27, 'La Virginia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(896, 27, 'Marsella');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(897, 27, 'Pereira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(898, 27, 'Santa Rosa De Cabal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(899, 27, 'Apia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(900, 27, 'Balboa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(901, 27, 'Belen De Umbria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(902, 27, 'Guatica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(903, 27, 'La Celia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(904, 27, 'Quinchia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(905, 27, 'Santuario');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(906, 27, 'Mistrato');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(907, 27, 'Pueblo Rico');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(908, 28, 'Chima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(909, 28, 'Confines');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(910, 28, 'Contratacion');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(911, 28, 'El Guacamayo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(912, 28, 'Galan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(913, 28, 'Gambita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(914, 28, 'Guadalupe');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(915, 28, 'Guapota');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(916, 28, 'Hato');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(917, 28, 'Oiba');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(918, 28, 'Palmar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(919, 28, 'Palmas Del Socorro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(920, 28, 'Santa Helena Del Opon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(921, 28, 'Simacota');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(922, 28, 'Socorro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(923, 28, 'Suaita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(924, 28, 'Capitanejo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(925, 28, 'Carcasi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(926, 28, 'Cepita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(927, 28, 'Cerrito');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(928, 28, 'Concepcion');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(929, 28, 'Enciso');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(930, 28, 'Guaca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(931, 28, 'Macaravita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(932, 28, 'Malaga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(933, 28, 'Molagavita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(934, 28, 'San Andres');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(935, 28, 'San Jose De Miranda');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(936, 28, 'San Miguel');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(937, 28, 'Aratoca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(938, 28, 'Barichara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(939, 28, 'Cabrera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(940, 28, 'Charala');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(941, 28, 'Coromoro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(942, 28, 'Curiti');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(943, 28, 'Encino');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(944, 28, 'Jordan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(945, 28, 'Mogotes');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(946, 28, 'Ocamonte');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(947, 28, 'Onzaga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(948, 28, 'Paramo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(949, 28, 'Pinchote');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(950, 28, 'San Gil');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(951, 28, 'San Joaquin');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(952, 28, 'Valle De San Jose');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(953, 28, 'Villanueva');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(954, 28, 'Barrancabermeja');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(955, 28, 'Betulia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(956, 28, 'El Carmen De Chucuri');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(957, 28, 'Puerto Wilches');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(958, 28, 'Sabana De Torres');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(959, 28, 'San Vicente De Chucuri');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(960, 28, 'Zapatoca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(961, 28, 'Bucaramanga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(962, 28, 'California');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(963, 28, 'Charta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(964, 28, 'El Playon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(965, 28, 'Floridablanca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(966, 28, 'Giron');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(967, 28, 'Lebrija');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(968, 28, 'Los Santos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(969, 28, 'Matanza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(970, 28, 'Piedecuesta');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(971, 28, 'Rionegro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(972, 28, 'Santa Barbara');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(973, 28, 'Surata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(974, 28, 'Tona');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(975, 28, 'Vetas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(976, 28, 'Aguada');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(977, 28, 'Albania');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(978, 28, 'Barbosa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(979, 28, 'Bolivar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(980, 28, 'Chipata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(981, 28, 'Cimitarra');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(982, 28, 'El Penon');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(983, 28, 'Florian');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(984, 28, 'Guavata');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(985, 28, 'Guepsa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(986, 28, 'Jesus Maria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(987, 28, 'La Belleza');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(988, 28, 'La Paz');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(989, 28, 'Landazuri');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(990, 28, 'Puente Nacional');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(991, 28, 'Puerto Parra');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(992, 28, 'San Benito');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(993, 28, 'Sucre');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(994, 28, 'Velez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(995, 29, 'Guaranda');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(996, 29, 'Majagual');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(997, 29, 'Sucre');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(998, 29, 'Chalan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(999, 29, 'Coloso');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1000, 29, 'Morroa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1001, 29, 'Ovejas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1002, 29, 'Sincelejo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1003, 29, 'Covenas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1004, 29, 'Palmito');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1005, 29, 'San Onofre');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1006, 29, 'Santiago De Tolu');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1007, 29, 'Tolu Viejo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1008, 29, 'Buenavista');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1009, 29, 'Corozal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1010, 29, 'El Roble');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1011, 29, 'Galeras');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1012, 29, 'Los Palmitos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1013, 29, 'Sampues');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1014, 29, 'San Juan Betulia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1015, 29, 'San Pedro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1016, 29, 'Since');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1017, 29, 'Caimito');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1018, 29, 'La Union');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1019, 29, 'San Benito Abad');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1020, 29, 'San Marcos');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1021, 30, 'Ambalema');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1022, 30, 'Armero');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1023, 30, 'Falan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1024, 30, 'Fresno');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1025, 30, 'Honda');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1026, 30, 'Mariquita');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1027, 30, 'Palocabildo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1028, 30, 'Carmen De Apicala');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1029, 30, 'Cunday');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1030, 30, 'Icononzo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1031, 30, 'Melgar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1032, 30, 'Villarrica');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1033, 30, 'Ataco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1034, 30, 'Chaparral');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1035, 30, 'Coyaima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1036, 30, 'Natagaima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1037, 30, 'Ortega');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1038, 30, 'Planadas');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1039, 30, 'Rioblanco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1040, 30, 'Roncesvalles');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1041, 30, 'San Antonio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1042, 30, 'Alvarado');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1043, 30, 'Anzoategui');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1044, 30, 'Cajamarca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1045, 30, 'Coello');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1046, 30, 'Espinal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1047, 30, 'Flandes');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1048, 30, 'Ibague');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1049, 30, 'Piedras');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1050, 30, 'Rovira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1051, 30, 'San Luis');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1052, 30, 'Valle De San Juan');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1053, 30, 'Alpujarra');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1054, 30, 'Dolores');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1055, 30, 'Guamo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1056, 30, 'Prado');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1057, 30, 'Purificacion');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1058, 30, 'Saldana');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1059, 30, 'Suarez');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1060, 30, 'Casabianca');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1061, 30, 'Herveo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1062, 30, 'Lerida');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1063, 30, 'Libano');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1064, 30, 'Murillo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1065, 30, 'Santa Isabel');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1066, 30, 'Venadillo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1067, 30, 'Villahermosa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1068, 31, 'Andalucia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1069, 31, 'Buga');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1070, 31, 'Bugalagrande');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1071, 31, 'Calima');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1072, 31, 'El Cerrito');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1073, 31, 'Ginebra');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1074, 31, 'Guacari');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1075, 31, 'Restrepo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1076, 31, 'Riofrio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1077, 31, 'San Pedro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1078, 31, 'Trujillo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1079, 31, 'Tulua');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1080, 31, 'Yotoco');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1081, 31, 'Alcala');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1082, 31, 'Ansermanuevo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1083, 31, 'Argelia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1084, 31, 'Bolivar');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1085, 31, 'Cartago');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1086, 31, 'El aguila');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1087, 31, 'El Cairo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1088, 31, 'El Dovio');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1089, 31, 'La Union');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1090, 31, 'La Victoria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1091, 31, 'Obando');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1092, 31, 'Roldanillo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1093, 31, 'Toro');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1094, 31, 'Ulloa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1095, 31, 'Versalles');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1096, 31, 'Zarzal');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1097, 31, 'Buenaventura');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1098, 31, 'Caicedonia');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1099, 31, 'Sevilla');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1100, 31, 'Cali');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1101, 31, 'Candelaria');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1102, 31, 'Dagua');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1103, 31, 'Florida');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1104, 31, 'Jamundi');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1105, 31, 'La Cumbre');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1106, 31, 'Palmira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1107, 31, 'Pradera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1108, 31, 'Vijes');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1109, 31, 'Yumbo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1110, 32, 'Caruru');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1111, 32, 'Mitu');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1112, 32, 'Pacoa');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1113, 32, 'Papunahua');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1114, 32, 'Taraira');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1115, 32, 'Yavarate');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1116, 33, 'Cumaribo');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1117, 33, 'La Primavera');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1118, 33, 'Puerto Carreno');
INSERT INTO `municipios` (`id_municipios`, `id_departamento`, `nombre_mun`) VALUES(1119, 33, 'Santa Rosalia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicaciones`
--

CREATE TABLE `publicaciones` (
  `id_publicaciones` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `texto` varchar(900) NOT NULL,
  `imagen` blob DEFAULT NULL,
  `Fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tipo` enum('P','V') DEFAULT NULL COMMENT 'P = publicacion, V = venta',
  `estado` enum('A','I') DEFAULT NULL COMMENT 'A = ACTIVO, I = INACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `publicaciones`
--

INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(1, 1, 'Comentario', NULL, '2021-04-20 13:07:49', 'V', 'A');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(2, 2, 'Comentario 2', NULL, '2021-04-20 13:07:49', 'P', 'A');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(23, 36, 'Publicacion prueba 1233', NULL, '2021-04-20 13:07:49', 'V', 'I');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(24, 37, 'Publicacion prueba VENTA 26654', NULL, '2021-04-20 13:07:49', 'P', 'I');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(25, 38, 'Esta es una nueva publicacion', '', '2021-04-20 13:07:49', 'P', 'A');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(26, 39, 'Publicacionessssss', NULL, '2021-04-20 13:07:49', 'V', 'A');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(27, 40, 'holaaaaaaa', NULL, '2021-04-20 13:07:49', 'V', 'A');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(28, 41, 'wowww', NULL, '2021-04-20 13:07:50', 'P', 'A');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(29, 42, 'Articulo en venta', NULL, '2021-04-20 13:07:50', 'V', 'I');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(30, 43, 'Publicaciones 123455254444', NULL, '2021-04-20 13:07:50', 'P', 'I');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(31, 44, 'Graciassss', NULL, '2021-04-20 13:07:50', 'P', 'A');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(32, 46, 'Articulo 1236544', NULL, '2021-04-20 13:07:50', 'V', 'I');
INSERT INTO `publicaciones` (`id_publicaciones`, `id_usuario`, `texto`, `imagen`, `Fecha`, `tipo`, `estado`) VALUES(33, 1, 'Prueba procedimientos almacenados', '', '2021-04-20 13:07:50', 'V', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reacciones`
--

CREATE TABLE `reacciones` (
  `id_reacciones` int(11) NOT NULL,
  `id_publicaciones` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `reaccion` enum('L','D') DEFAULT NULL COMMENT 'L = LIKE , D = DISLIKE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `reacciones`
--

INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(1, 1, 1, 'L');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(2, 2, 2, 'D');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(13, 23, 36, 'L');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(14, 24, 37, 'L');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(15, 25, 38, 'D');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(16, 26, 39, 'L');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(17, 27, 40, 'L');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(18, 28, 43, 'D');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(19, 29, 45, 'L');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(20, 30, 47, 'L');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(21, 31, 48, 'D');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(23, 2, 40, 'L');
INSERT INTO `reacciones` (`id_reacciones`, `id_publicaciones`, `id_usuario`, `reaccion`) VALUES(24, 29, 1, 'D');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `sexo` enum('M','F','O') DEFAULT NULL COMMENT 'M = masculino, F = femenino, O = otro',
  `Fecha_nacimiento` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_municipios` int(11) DEFAULT NULL,
  `tipo` enum('A','U') DEFAULT NULL COMMENT 'A= ADMINISTRADOR, U = USUARIO',
  `estado` enum('A','I') DEFAULT NULL COMMENT 'A= ACTIVO, I = INACTIVO',
  `foto_perfil` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(1, 'Jhon', 'Estupiñan', 'M', '2021-04-24 16:11:56', 6, 'A', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(2, 'Paola Andrea', 'Espejo Moya', 'F', '2021-04-24 16:11:56', 7, 'U', 'A', '');
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(36, 'Miriam', 'Suarez', 'F', '2021-04-24 16:11:56', 150, 'U', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(37, 'Jaime', 'Mesa', 'M', '2021-04-24 16:11:56', 190, 'U', 'I', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(38, 'Karen ', 'Fontal', 'F', '2021-04-24 16:11:56', 200, 'U', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(39, 'Alison', 'Gonzales', 'F', '2021-04-24 16:11:56', 250, 'U', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(40, 'Laura', 'Gonzales', 'F', '2021-04-24 16:11:56', 270, 'U', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(41, 'Fabian', 'Martinez', 'M', '2021-04-24 16:11:56', 60, 'U', 'I', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(42, 'Nelson', 'Torres', 'M', '2021-04-24 16:11:56', 270, 'U', 'I', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(43, 'Cindy', 'Socha', 'F', '2021-04-24 16:11:57', 270, 'U', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(44, 'Johana', 'Ruiz', 'F', '2021-04-24 16:11:57', 40, 'U', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(45, 'Nelson', 'Mendez', 'F', '2021-04-24 16:11:57', 290, 'U', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(46, 'Dayana', 'Rincon', 'F', '2021-04-24 16:11:57', 270, 'U', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(47, 'Vanessa', 'Figueroa', 'F', '2021-04-24 16:11:57', 10, 'U', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(48, 'Deisy', 'Suarez', 'F', '2021-04-24 16:11:57', 230, 'U', 'I', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(49, 'Nicol', 'Rodriguez', 'F', '2021-04-24 16:12:32', 270, 'U', 'A', NULL);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(50, 'Baryan', 'Suarez', 'M', '2021-04-24 16:12:32', 7, 'U', 'A', '');
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(51, 'James', 'Gomez', 'M', '2021-04-24 16:12:32', 40, 'U', 'A', 0x4e554c4c);
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(52, 'Dairo', 'Moreno', 'M', '2021-04-24 16:12:32', 50, 'U', 'I', '');
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(53, 'Erika', 'Puentes', 'F', '2021-04-24 16:12:32', 8, 'U', 'A', '');
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(54, 'Jhonatan', 'Gomez', 'M', '2021-04-24 16:12:32', 2, 'U', 'I', '');
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(68, 'Andres', 'Espejo', 'M', '2021-04-24 16:12:32', 7, 'U', 'I', '');
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido`, `sexo`, `Fecha_nacimiento`, `id_municipios`, `tipo`, `estado`, `foto_perfil`) VALUES(69, 'Luisa', 'Rivera', 'M', '1989-03-21 05:00:00', 40, 'U', 'A', '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id_comentarios`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_publicaciones` (`id_publicaciones`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id_departamento`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id_login`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD PRIMARY KEY (`id_municipios`),
  ADD KEY `id_departamento` (`id_departamento`);

--
-- Indices de la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD PRIMARY KEY (`id_publicaciones`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `reacciones`
--
ALTER TABLE `reacciones`
  ADD PRIMARY KEY (`id_reacciones`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_publicaciones` (`id_publicaciones`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_municipios` (`id_municipios`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id_comentarios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id_departamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `id_login` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `municipios`
--
ALTER TABLE `municipios`
  MODIFY `id_municipios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1120;

--
-- AUTO_INCREMENT de la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  MODIFY `id_publicaciones` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `reacciones`
--
ALTER TABLE `reacciones`
  MODIFY `id_reacciones` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_publicaciones`) REFERENCES `publicaciones` (`id_publicaciones`);

--
-- Filtros para la tabla `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `login_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`);

--
-- Filtros para la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD CONSTRAINT `publicaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `reacciones`
--
ALTER TABLE `reacciones`
  ADD CONSTRAINT `reacciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `reacciones_ibfk_2` FOREIGN KEY (`id_publicaciones`) REFERENCES `publicaciones` (`id_publicaciones`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_municipios`) REFERENCES `municipios` (`id_municipios`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
