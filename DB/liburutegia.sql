-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-05-2022 a las 18:02:24
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `liburutegia`
--
CREATE DATABASE IF NOT EXISTS `liburutegia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `liburutegia`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `erabiltzailea`
--

DROP TABLE IF EXISTS `erabiltzailea`;
CREATE TABLE `erabiltzailea` (
  `idErabiltzailea` int(11) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Pasahitza` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `erabiltzailea`
--

INSERT INTO `erabiltzailea` (`idErabiltzailea`, `Email`, `Pasahitza`) VALUES
(1, 'pablo@pablo.com', '1234'),
(2, 'pepe@pepe.com', '1234'),
(9, 'pablo@gmail.com', '1234'),
(12, 'pablo@uni.eus', '1234'),
(13, 'joseba@uni.eus', '1234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eskaera`
--

DROP TABLE IF EXISTS `eskaera`;
CREATE TABLE `eskaera` (
  `idEskaera` int(11) NOT NULL,
  `EskaeraData` date DEFAULT NULL,
  `ItzultzeData` date DEFAULT NULL,
  `idErabiltzailea` int(11) NOT NULL,
  `izena` varchar(45) DEFAULT NULL,
  `abizena` varchar(45) DEFAULT NULL,
  `helbidea` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `eskaera`
--

INSERT INTO `eskaera` (`idEskaera`, `EskaeraData`, `ItzultzeData`, `idErabiltzailea`, `izena`, `abizena`, `helbidea`) VALUES
(1, '2022-05-02', '2022-05-17', 1, 'Pablo', 'Lopez', '1234 kalea'),
(2, '2022-05-02', '2022-05-17', 1, 'Pablo', 'Lopez', '1234 kalea'),
(3, '2022-05-02', '2022-05-17', 1, 'Pablo', 'Lopez', '1234 kalea'),
(4, '2022-05-02', '2022-05-17', 1, 'Pablo', 'Lopez', '1234 kalea'),
(5, '2022-05-02', '2022-05-17', 1, 'Monkey D.', 'Luffy', '1234 kalea 2'),
(6, '2022-05-02', '2022-05-17', 1, 'pepe', '1234', 'pepepepe'),
(7, '2022-05-02', '2022-05-17', 1, 'pepe', '1234', 'pepepepe'),
(8, '2022-05-02', '2022-05-17', 1, 'Aitor', 'Tilla', 'Taberna 12'),
(9, '2022-05-02', '2022-05-17', 1, 'Keko', 'Ñete', 'Pepito kalea'),
(10, '2022-05-02', '2022-05-17', 1, 'Joseba', 'Jartangas', 'keko kalea 21'),
(11, '2022-05-02', '2022-05-17', 1, 'pepe', 'koko', 'pepe kalea'),
(12, '2022-05-02', '2022-05-17', 1, 'koka', 'kola', 'light'),
(13, '2022-05-03', '2022-05-18', 1, '5', '555', 'kalea'),
(14, '2022-05-03', '2022-05-18', 1, 'nuevo', 'nuevo', 'pepepepepe'),
(15, '2022-05-03', '2022-05-18', 2, 'Ronnie', 'Coleman', 'LightWeight Baby 9'),
(16, '2022-05-03', '2022-05-18', 2, 'Ronnie', 'Coleman', 'Lightweight baby 9'),
(17, '2022-05-03', '2022-05-18', 2, 'pepe', 'coleman', 'keaokfkladlk 3'),
(18, '2022-05-03', '2022-05-18', 2, 'Ronnie ', 'Coleman', 'Yeah Buddy kalea, Lightweight 43'),
(19, '2022-05-03', '2022-05-18', 1, 'Ronnie', 'Coleman', 'kalea kalea'),
(20, '2022-05-03', '2022-05-18', 13, 'Joseba', 'Hernandez', 'Nire kalea 123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eskaeralerroa`
--

DROP TABLE IF EXISTS `eskaeralerroa`;
CREATE TABLE `eskaeralerroa` (
  `idEskaeralerroa` int(11) NOT NULL,
  `idEskaera` int(11) NOT NULL,
  `idLiburua` int(11) NOT NULL,
  `itzulita` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `eskaeralerroa`
--

INSERT INTO `eskaeralerroa` (`idEskaeralerroa`, `idEskaera`, `idLiburua`, `itzulita`) VALUES
(2, 2, 1, 1),
(3, 4, 16, 1),
(4, 4, 2, 0),
(5, 5, 2, 1),
(6, 5, 18, 0),
(7, 6, 2, 0),
(8, 7, 2, 1),
(9, 8, 1, 0),
(10, 9, 2, 0),
(11, 10, 2, 1),
(12, 10, 15, 0),
(13, 11, 2, 0),
(14, 12, 2, 0),
(15, 12, 15, 0),
(16, 13, 28, 1),
(17, 13, 26, 1),
(18, 14, 20, 1),
(19, 18, 20, 0),
(20, 19, 20, 0),
(21, 19, 26, 0),
(22, 19, 28, 0),
(23, 20, 28, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `idazlea`
--

DROP TABLE IF EXISTS `idazlea`;
CREATE TABLE `idazlea` (
  `idIdazlea` int(11) NOT NULL,
  `Izena` varchar(100) DEFAULT NULL,
  `Biografia` text DEFAULT NULL,
  `Irudia` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `idazlea`
--

INSERT INTO `idazlea` (`idIdazlea`, `Izena`, `Biografia`, `Irudia`) VALUES
(1, 'Eiichiro Oda', 'Eiichiro Oda (尾田 栄一郎 Oda Eiichirō) es un mangaka japonés conocido por su serie de manga One Piece (1997-presente), la cual ha vendido más de 500 millones de copias en todo el mundo y ha conseguido un récord Guinness al ser el manga más vendido de todos los tiempos.', 'https://static.listadomanga.com/185130414b55779dfcc7e02560fe2145.jpg'),
(2, 'J.R.R. Tolkien', 'John Ronald Reuel Tolkien (Bloemfontein, hoy Sudáfrica; 3 de enero de 1892-Bournemouth, Dorset; 2 de septiembre de 1973), a menudo citado como J. R. R. Tolkien o JRRT, fue un escritor, poeta, filólogo, lingüista y profesor universitario británico, conocido principalmente por ser el autor de las novelas clásicas de fantasía heroica El hobbit, El Silmarillion y El Señor de los Anillos.', 'https://upload.wikimedia.org/wikipedia/commons/6/66/J._R._R._Tolkien%2C_1940s.jpg'),
(3, 'Gege Akutami', 'Gege Akutami (芥見下々 Akutami Gege) nació el 26 de febrero de 1992 en Prefectura de Iwate, Japón. Artista de manga japonés, recibió reconocimiento por crear Jujutsu Kaisen y su precuela Tokyo Metropolitan Curse Technical School.', 'https://static.wikia.nocookie.net/jujutsu-kaisen/images/b/bb/Akutami_Gege.png/revision/latest/scale-to-width-down/180?cb=20200224044104&path-prefix=es'),
(4, 'Gabriel García Márquez', 'Gabriel José García Márquez (Aracataca, 6 de marzo de 1927–Ciudad de México, 17 de abril de 2014) fue un escritor y periodista colombiano. Reconocido principalmente por sus novelas y cuentos, también escribió narrativa de no ficción, discursos, reportajes, críticas cinematográficas y memorias. Fue conocido como Gabo, y familiarmente y por sus amigos como Gabito. En 1982 recibió el Premio Nobel de Literatura «por sus novelas e historias cortas, en las que lo fantástico y lo real se combinan en un mundo ricamente compuesto de imaginación, lo que refleja la vida y los conflictos de un continente».', 'https://upload.wikimedia.org/wikipedia/commons/0/0f/Gabriel_Garcia_Marquez.jpg'),
(5, 'Miguel de Cervantes', 'Miguel de Cervantes Saavedra (Alcalá de Henares, 29 de septiembre de 1547-Madrid, 22 de abril de 1616) fue un novelista, poeta, dramaturgo y soldado español. Es ampliamente considerado una de las máximas figuras de la literatura española. Fue el autor de El ingenioso hidalgo don Quijote de la Mancha, novela conocida habitualmente como El Quijote, que lo llevó a ser mundialmente conocido y a la cual muchos críticos han descrito como la primera novela moderna, así como una de las mejores obras de la literatura universal, cuya cantidad de ediciones y traducciones solo es superada por la Biblia. A Cervantes se le ha dado el apelativo de «Príncipe de los Ingenios».', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Cervantes_J%C3%A1uregui.jpg/800px-Cervantes_J%C3%A1uregui.jpg'),
(6, 'Tatsuki Fujimoto', 'Tatsuki Fujimoto (藤本タツキ Fujimoto Tatsuki?) es un mangaka japonés conocido principalmente por ser el creador de las series Fire Punch y Chainsaw Man. Tatsuki Fujimoto nació en Akita, Japón, el 10 de octubre de 1993. Comenzó a dibujar a una edad temprana. No tenía escuelas preparatorias disponibles cerca de su casa, por lo que asistió a clases de pintura a las que asistían sus abuelos y practicaban pintura al óleo. Se graduó en pintura occidental de la Universidad de Arte y Diseño de Tohoku en Yamagata, Yamagata en 2014.', 'https://static.wikia.nocookie.net/chainsaw-man/images/6/68/FujimotoAvatar.png/revision/latest/scale-to-width-down/200?cb=20190917171027&path-prefix=es');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `liburua`
--

DROP TABLE IF EXISTS `liburua`;
CREATE TABLE `liburua` (
  `idLiburua` int(11) NOT NULL,
  `ISBN` varchar(45) DEFAULT NULL,
  `Izenburua` varchar(100) DEFAULT NULL,
  `Sinopsia` text DEFAULT NULL,
  `OrriKopurua` int(11) DEFAULT NULL,
  `Generoa` varchar(45) DEFAULT NULL,
  `Urtea` int(11) DEFAULT NULL,
  `Irudia` varchar(200) DEFAULT NULL,
  `idIdazlea` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `liburua`
--

INSERT INTO `liburua` (`idLiburua`, `ISBN`, `Izenburua`, `Sinopsia`, `OrriKopurua`, `Generoa`, `Urtea`, `Irudia`, `idIdazlea`) VALUES
(1, '9788468471525', 'One Piece 001', 'El manga de la serie más pirata de la tele. Sigue las aventuras de Monkey D. Luffy, un chico muy especial y elástico, que sueña con ser el rey de los piratas y encontrar una gran tesoro: el One Piece. Para ello, se hace a la mar en un bote con el que buscará la tripulación que le pueda ayudar en su misión. El manga de la serie más pirata de la tele. Sigue las aventuras de Monkey D. Luffy, un chico muy especial y elástico, que sueña con ser el rey de los piratas y encontrar una gran tesoro: el One Piece. Para ello, se hace a la mar en un bote con el que buscará la tripulación que le pueda ayudar en su misión. El manga de la serie más pirata de la tele. Sigue las aventuras de Monkey D. Luffy, un chico muy especial y elástico, que sueña con ser el rey de los piratas y encontrar una gran tesoro: el One Piece. Para ello, se hace a la mar en un bote con el que buscará la tripulación que le pueda ayudar en su misión. El manga de la serie más pirata de la tele. Sigue las aventuras de Monkey D. Luffy, un chico muy especial y elástico, que sueña con ser el rey de los piratas y encontrar una gran tesoro: el One Piece. Para ello, se hace a la mar en un bote con el que buscará la tripulación que le pueda ayudar en su misión. ', 208, 'Manga', 2004, 'https://images-na.ssl-images-amazon.com/images/I/91XwYkbfN-L.jpg', 1),
(2, '9788468471532', 'One Piece 002', 'Monkey D. Luffy ha reclutado al primer miembro de su tripulación:Rolonoa Zoro, el espadachín de las tres espadas. Juntos quieren apoderarse del mapa de la Gran Ruta Marina, pero para eso deberán pelear contraBuggy y sus hombres. Luffy, decidido a convertirse en el rey de los piratas, se alía conNami, una joven ladrona de tesoros.', 208, 'Manga', 2004, 'https://images-na.ssl-images-amazon.com/images/I/91bt1dawajL.jpg', 1),
(15, '9788467940657', 'Jujutsu Kaisen 01', 'LLEGA JUJUTSU KAISEN, EL SHÔNEN QUE ESTÁ CAUSANDO FUROR EN JAPÓN! Yûji Itadori es un estudiante con unas habilidades físicas excepcionales. Todos los días, como rutina, va al hospital a visitar a su abuelo enfermo y decide apuntarse al club de ocultismo del instituto para no dar un palo al agua... Sin embargo, un buen día el sello del talismán que se hallaba escondido en su instituto se rompe, y comienzan a aparecer unos monstruos. Ante este giro de los acontecimientos, Itadori decide adentrarse en el instituto para salvar a sus compañeros. ¿Qué le deparará el destino? ', 192, 'Manga', 2020, 'https://images-na.ssl-images-amazon.com/images/I/81uUEDB4INL.jpg', 3),
(16, '9788467940657', 'Jujutsu Kaisen 04', '¡JUNPEI SE ENFRENTARÁ A ITADORI EN UNA BATALLA DE HECHICEROS! Itadori, que va tras la pista de un caso de asesinato relacionado con maldiciones, conoce a Junpei, un chico que se encontraba en la escena del crimen y con quien hace buenas migas. Sin embargo, Junpei siente una gran admiración por Mahito, un espíritu maldito que, a su vez, es el criminal que ha perpetrado los crímenes, y su plan es enfrentar a Junpei contra Itadori... ', 200, 'Manga', 2020, 'https://images-na.ssl-images-amazon.com/images/I/81Gn6F8ihkL.jpg', 3),
(17, '9788445000656', 'El Hobbit', 'Smaug parecía profundamente dormido cuando Bilbo espió una vez más desde la entrada. ¡Pero fingía estar dormido! ¡Estaba vigilando la entrada del túnel!... Sacado de su cómodo agujero-hobbit por Gandalf y una banda de enanos, Bilbo se encuentra de pronto en medio de una conspiración que pretende apoderarse del tesoro de Smaug el Magnífico, un enorme y muy peligroso dragón...', 288, 'Fantasia', 1937, 'https://images-na.ssl-images-amazon.com/images/I/81VxEj--PkL.jpg', 2),
(18, '9788445000656', 'El Señor de los Anillos I. La Comunidad del Anillo', 'En la adormecida e idílica Comarca, un joven hobbit recibe un encargo: custodiar el Anillo Único y emprender el viaje para su destrucción en la Grieta del Destino. Acompañado por magos, hombres, elfos y enanos, atravesará la Tierra Media y se internará en las sombras de Mordor, perseguido siempre por las huestes de Sauron, el Señor Oscuro, dispuesto a recuperar su creación para establecer el dominio definitivo del Mal.', 576, 'Fantasia', 1954, 'https://images-na.ssl-images-amazon.com/images/I/816QLZKwmIL.jpg', 2),
(19, '9788497592437', 'Crónica de una muerte anunciada', 'Acaso sea Crónica de una muerte anunciada la obra más «realista» de Gabriel García Márquez, pues se basa en un hecho histórico acontecido en la tierra natal del escritor. Cuando empieza la novela, ya se sabe que los hermanos Vicario van a matar a Santiago Nasar -de hecho, ya le han matado- para vengar el honor ultrajado de su hermana Ángela, pero el relato termina precisamente en el momento en que Santiago Nasar muere.', 144, 'Poliziakoa', 1981, 'https://images-na.ssl-images-amazon.com/images/I/91Dax7AnPpL.jpg', 4),
(20, '9788467941159', 'Chainsaw Man 01', '¡El nuevo y esperadísimo trabajo del autor de Fire PUNCH ! denji es un chico sin un duro que se deja la piel trabajando como Devil Hunter junto a su perro demoníaco pochita para resarcir una deuda astronómica, pero entonces... ¡¡Una sangrienta traición da un giro radical a su miserable vida!!', 192, 'Manga', 2018, 'https://images-na.ssl-images-amazon.com/images/I/81zijlool9L.jpg', 6),
(21, '9788420412146', 'Don Quijote de la Mancha', 'El ingenioso hidalgo don Quijote de la Mancha narra las aventuras de Alonso Quijano, un hidalgo pobre que de tanto leer novelas de caballería acaba enloqueciendo y creyendo ser un caballero andante, nombrándose a sí mismo como don Quijote de la Mancha. Sus intenciones son ayudar a los pobres y desfavorecidos, y lograr el amor de la supuesta Dulcinea del Toboso, que es en realidad es una campesina llamada Aldonza Lorenzo. Decide nombrar a Sancho Panza, un empleado suyo, su escudero. Juntos viven muchas aventuras y tras ser vencido por el Caballero de la Blanca Luna se retira a su hogar, donde, tras adquirir de nuevo la cordura, fallece.', 1376, 'Abentura', 1605, 'https://images-na.ssl-images-amazon.com/images/I/61xPqIiIjcL.jpg', 5),
(22, '9788467928228', 'FIRE PUNCH 1', 'EN UN MUNDO HELADO, LAS LLAMAS SON UNO DE LOS BIENES MÁS PRECIADOS… “La bruja del hielo” es la culpable de que todo haya quedado cubierto completamente por la nieve, la locura y el hambre mientras que la población mundial, congelada, suspira por unas llamas. En este mundo, Agni y su hermana pequeña, Luna, son dos muchachos que han sido bendecidos con la capacidad de la regeneración. ¡¿Qué atroz futuro les espera a estos dos hermanos sin familia alguna?!', 208, 'Manga', 2016, 'https://images-na.ssl-images-amazon.com/images/I/615jcKan8RL.jpg', 6),
(23, '9788467951424', 'Look Back', '¡EL ÚLTIMO TRABAJO DEL AUTOR DE CHAINSAW MAN! Fujino cree firmemente en su propio talento; Kyomoto no sale nunca de su habitación. La imparable pasión por dibujar mangane a estas dos chicas que viven en un pueblo apartado. Por mucho que pasen los días y meses, hay algo que siempre las hapoyado... De un pincel inigualable nace una historia autoconclusiva que rebosa juventud.', 192, 'Manga', 2021, 'https://images-na.ssl-images-amazon.com/images/I/31Nx+xUH+CL.jpg', 6),
(24, '9788411121033', 'One Piece 100', 'Todos los protagonistas están en la azotea. Luffy y los demás se enfrentan a Kaido y a Big Mom. ¿¡Tienen alguna posibilidad ante esta alianza todopoderosa!? ¿¡Qué será lo que el futuro depare a esta confrontación tan extrema!? ¡¡Onigashima vibra con los enfrentamientos!! ¡¡Aquí tenéis una historia de piratas que buscan el gran tesoro, el One Piece!!', 192, 'Manga', 2022, 'https://images-na.ssl-images-amazon.com/images/I/91kCTwllObL.jpg', 1),
(25, '9788467947717', 'Jujutsu Kaisen 14', 'SUKUNA SIEMBRA EL CAOS EN EL CENTRO DE SHIBUYA Mientras Sukuna, que tras haber obtenido la libertad de forma temporal se está comportando de un modo violento y cruel, ocasionando enormes daños en el barrio de Shibuya, Fushiguro recibe una herida mortal por un ataque sorpresa de un hechicero maldito y decide usar su último recurso. ¡Sukuna se ha dado cuenta de que Fushiguro ha empezado un \'ritual de exorcismo\' y...!', 192, 'Manga', 2021, 'https://images-na.ssl-images-amazon.com/images/I/718zmO+90bL.jpg', 3),
(26, '9788497592208', 'Cien años de soledad', 'Entre la boda de José Arcadio Buendía con Amelia Iguarán hasta la maldición de Aureliano Babilonia transcurre todo un siglo. Cien años de soledad para una estirpe única, fantástica, capaz de fundar una ciudad tan especial como Macondo y de engendrar niños con cola de cerdo. En medio, una larga docena de personajes dejarán su impronta a las generaciones venideras, que tendrán que lidiar con un mundo tan complejo como sencillo.', 496, 'Eleberria', 1967, 'https://images-na.ssl-images-amazon.com/images/I/A1KbLZ3jhvS.jpg', 4),
(27, '9781544952956', 'Novelas ejemplares', '\"Novelas Ejemplares\", con un índice dinámico y detallado. Son una serie de doce novelas cortas que Miguel de Cervantes escribió entre 1590 y 1612, y que publicaría en 1613 en una colección editada en Madrid por Juan de la Cuesta. Novelas contenidas en la obra: La gitanilla El amante liberal Rinconete y Cortadillo La española inglesa El licenciado Vidriera La fuerza de la sangre El celoso extremeño La ilustre fregona Las dos doncellas.', 474, 'Eleberria', 1613, 'https://images-na.ssl-images-amazon.com/images/I/519GZ8yfp1L.jpg', 5),
(28, '9788467946451', 'Chainsaw Man 06', '¡SALEN A LA LUZ LAS VERDADERAS INTENCIONES REZE! Reze le pide a Denji que huyan juntos, ante lo que su corazón inocente da un vuelco Sin embargo, ¡lo que en principio parece un momento repleto de dulzura un giro de ciento ochenta grados y se convierte en una tormenta de explosiones! Se avecina una cruenta y bombástica batalla en la que se verán envueltos el amor y la lujuria, los humanos y los demonios... ¿Qué descubrirán Denji y Reze?\r\n', 192, 'Manga', 2020, 'https://images-na.ssl-images-amazon.com/images/I/81piwqQ9B5S.jpg', 6);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `erabiltzailea`
--
ALTER TABLE `erabiltzailea`
  ADD PRIMARY KEY (`idErabiltzailea`),
  ADD UNIQUE KEY `email` (`Email`);

--
-- Indices de la tabla `eskaera`
--
ALTER TABLE `eskaera`
  ADD PRIMARY KEY (`idEskaera`),
  ADD KEY `idErabiltzailea` (`idErabiltzailea`);

--
-- Indices de la tabla `eskaeralerroa`
--
ALTER TABLE `eskaeralerroa`
  ADD PRIMARY KEY (`idEskaeralerroa`),
  ADD KEY `idEskaera` (`idEskaera`),
  ADD KEY `idLiburua` (`idLiburua`);

--
-- Indices de la tabla `idazlea`
--
ALTER TABLE `idazlea`
  ADD PRIMARY KEY (`idIdazlea`);

--
-- Indices de la tabla `liburua`
--
ALTER TABLE `liburua`
  ADD PRIMARY KEY (`idLiburua`),
  ADD KEY `idIdazlea` (`idIdazlea`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `erabiltzailea`
--
ALTER TABLE `erabiltzailea`
  MODIFY `idErabiltzailea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `eskaera`
--
ALTER TABLE `eskaera`
  MODIFY `idEskaera` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `eskaeralerroa`
--
ALTER TABLE `eskaeralerroa`
  MODIFY `idEskaeralerroa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `idazlea`
--
ALTER TABLE `idazlea`
  MODIFY `idIdazlea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `liburua`
--
ALTER TABLE `liburua`
  MODIFY `idLiburua` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `eskaera`
--
ALTER TABLE `eskaera`
  ADD CONSTRAINT `eskaera_ibfk_1` FOREIGN KEY (`idErabiltzailea`) REFERENCES `erabiltzailea` (`idErabiltzailea`);

--
-- Filtros para la tabla `eskaeralerroa`
--
ALTER TABLE `eskaeralerroa`
  ADD CONSTRAINT `eskaeralerroa_ibfk_1` FOREIGN KEY (`idEskaera`) REFERENCES `eskaera` (`idEskaera`),
  ADD CONSTRAINT `eskaeralerroa_ibfk_2` FOREIGN KEY (`idLiburua`) REFERENCES `liburua` (`idLiburua`);

--
-- Filtros para la tabla `liburua`
--
ALTER TABLE `liburua`
  ADD CONSTRAINT `liburua_ibfk_1` FOREIGN KEY (`idIdazlea`) REFERENCES `idazlea` (`ididazlea`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
