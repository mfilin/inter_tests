-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.7.33 - MySQL Community Server (GPL)
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица inter.t_aptek
DROP TABLE IF EXISTS `t_aptek`;
CREATE TABLE IF NOT EXISTS `t_aptek` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rf_city` int(11) DEFAULT NULL,
  `name` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  `adress` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_city` (`rf_city`),
  CONSTRAINT `FK_city` FOREIGN KEY (`rf_city`) REFERENCES `t_city` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Дамп данных таблицы inter.t_aptek: ~5 rows (приблизительно)
/*!40000 ALTER TABLE `t_aptek` DISABLE KEYS */;
INSERT INTO `t_aptek` (`id`, `rf_city`, `name`, `adress`) VALUES
	(1, 1, 'Аптека N1', NULL),
	(2, 1, 'Аптека N2', NULL),
	(3, 2, 'Медуница', NULL),
	(4, 2, 'Волгофарм', NULL),
	(5, 3, 'Доктор Столетов', NULL);
/*!40000 ALTER TABLE `t_aptek` ENABLE KEYS */;

-- Дамп структуры для таблица inter.t_black_list
DROP TABLE IF EXISTS `t_black_list`;
CREATE TABLE IF NOT EXISTS `t_black_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rf_city` int(11) DEFAULT NULL,
  `rf_good` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_city2` (`rf_city`),
  KEY `FK_good2` (`rf_good`),
  CONSTRAINT `FK_city2` FOREIGN KEY (`rf_city`) REFERENCES `t_city` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_good2` FOREIGN KEY (`rf_good`) REFERENCES `t_goods` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Дамп данных таблицы inter.t_black_list: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `t_black_list` DISABLE KEYS */;
INSERT INTO `t_black_list` (`id`, `rf_city`, `rf_good`) VALUES
	(1, 1, 5);
/*!40000 ALTER TABLE `t_black_list` ENABLE KEYS */;

-- Дамп структуры для таблица inter.t_city
DROP TABLE IF EXISTS `t_city`;
CREATE TABLE IF NOT EXISTS `t_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rf_region` int(11) DEFAULT NULL,
  `name` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_region` (`rf_region`),
  CONSTRAINT `FK_region` FOREIGN KEY (`rf_region`) REFERENCES `t_regions` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Дамп данных таблицы inter.t_city: ~3 rows (приблизительно)
/*!40000 ALTER TABLE `t_city` DISABLE KEYS */;
INSERT INTO `t_city` (`id`, `rf_region`, `name`) VALUES
	(1, 1, 'Москва'),
	(2, 2, 'Волгоград'),
	(3, 2, 'Ростов-на-Дону');
/*!40000 ALTER TABLE `t_city` ENABLE KEYS */;

-- Дамп структуры для таблица inter.t_curces
DROP TABLE IF EXISTS `t_curces`;
CREATE TABLE IF NOT EXISTS `t_curces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cdate` int(11) NOT NULL DEFAULT '0',
  `cval` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Дамп данных таблицы inter.t_curces: ~4 rows (приблизительно)
/*!40000 ALTER TABLE `t_curces` DISABLE KEYS */;
INSERT INTO `t_curces` (`id`, `cdate`, `cval`) VALUES
	(5, 1630443600, 73.8757),
	(6, 1631221200, 73.129),
	(7, 1631307600, 72.76),
	(8, 1630789200, 72.8545);
/*!40000 ALTER TABLE `t_curces` ENABLE KEYS */;

-- Дамп структуры для таблица inter.t_goods
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE IF NOT EXISTS `t_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  `mn_name` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Дамп данных таблицы inter.t_goods: ~5 rows (приблизительно)
/*!40000 ALTER TABLE `t_goods` DISABLE KEYS */;
INSERT INTO `t_goods` (`id`, `name`, `mn_name`) VALUES
	(1, 'Анальгин', NULL),
	(2, 'Лоперамид', NULL),
	(3, 'Панкреатин', NULL),
	(4, 'Нитроглицерин', NULL),
	(5, 'Пирацетам', NULL);
/*!40000 ALTER TABLE `t_goods` ENABLE KEYS */;

-- Дамп структуры для таблица inter.t_goods_wh
DROP TABLE IF EXISTS `t_goods_wh`;
CREATE TABLE IF NOT EXISTS `t_goods_wh` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rf_aptek` int(11) DEFAULT NULL,
  `rf_good` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` float DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_aptek` (`rf_aptek`),
  KEY `FK_good` (`rf_good`),
  CONSTRAINT `FK_aptek` FOREIGN KEY (`rf_aptek`) REFERENCES `t_aptek` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_good` FOREIGN KEY (`rf_good`) REFERENCES `t_goods` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Дамп данных таблицы inter.t_goods_wh: ~7 rows (приблизительно)
/*!40000 ALTER TABLE `t_goods_wh` DISABLE KEYS */;
INSERT INTO `t_goods_wh` (`id`, `rf_aptek`, `rf_good`, `quantity`, `price`) VALUES
	(1, 1, 1, 10, 50),
	(2, 1, 2, 1, 250),
	(3, 1, 1, 11, 50),
	(4, 1, 3, 100, 70),
	(5, 1, 4, 6, 120),
	(6, 4, 1, 1, 35),
	(7, 4, 3, 5, 65),
	(8, 1, 5, 3, 100);
/*!40000 ALTER TABLE `t_goods_wh` ENABLE KEYS */;

-- Дамп структуры для таблица inter.t_regions
DROP TABLE IF EXISTS `t_regions`;
CREATE TABLE IF NOT EXISTS `t_regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Дамп данных таблицы inter.t_regions: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `t_regions` DISABLE KEYS */;
INSERT INTO `t_regions` (`id`, `name`) VALUES
	(1, 'Центральный'),
	(2, 'Южный');
/*!40000 ALTER TABLE `t_regions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
