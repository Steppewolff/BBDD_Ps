-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: psdb_json
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `hospital`
--

DROP TABLE IF EXISTS `hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital` (
  `hospital_id` int NOT NULL AUTO_INCREMENT,
  `hospital_name` varchar(255) DEFAULT NULL,
  `hospital_code` varchar(255) DEFAULT NULL,
  `hospital_comments` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `geo_latitude` double DEFAULT NULL,
  `geo_longitude` double DEFAULT NULL,
  PRIMARY KEY (`hospital_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital`
--

LOCK TABLES `hospital` WRITE;
/*!40000 ALTER TABLE `hospital` DISABLE KEYS */;
INSERT INTO `hospital` VALUES (1,'C.H. Ciudad de Jaén',NULL,NULL,'España','Andalucía','Jaén',37.7755,-3.793),(2,'Corporació Sanitària Parc Taulí',NULL,NULL,'España','Cataluña','Sabadell',41.5569,2.1105),(3,'Hospital 12 Octubre',NULL,NULL,'España','Madrid','Madrid',40.3756,-3.6963),(4,'Hospital A Coruña',NULL,NULL,'España','Galicia','A Coruña',43.3443,-8.3891),(5,'Hospital Álava',NULL,NULL,'España','País Vasco','Vitoria',42.8358,-2.6786),(6,'Hospital Bellvitge',NULL,NULL,'España','Cataluña','Barcelona',41.3447,2.1072),(7,'Hospital Cabueñes',NULL,NULL,'España','Asturias','Gijón',43.5249,-5.6065),(8,'Hospital Clínico Lozano Blesa',NULL,NULL,'España','Aragón','Zaragoza',41.6433,-0.9034),(9,'Hospital Clinic',NULL,NULL,'España','Cataluña','Barcelona',41.3882,2.1505),(10,'Hospital de Burgos',NULL,NULL,'España','Castilla y León','Burgos',41.6692,-3.6912),(11,'Hospital de Castellón',NULL,NULL,'España','Comunidad Valenciana','Castellón',40.0026,-0.0417),(12,'Hospital de Guadalajara',NULL,NULL,'España','Castilla La Mancha','Guadalajara',41.1348,-2.9863),(13,'Hospital de Jerez',NULL,NULL,'España','Andalucía','Jerez',36.6992,-6.1489),(14,'Hospital de La Fé',NULL,NULL,'España','Comunidad Valenciana','Valencia',39.4437,-0.3761),(15,'Hospital de Pontevedra',NULL,NULL,'España','Galicia','Pontevedra',42.0065,-8.7317),(16,'Hospital de Salamanca',NULL,NULL,'España','Castilla y León','Salamanca',-31.7746,-70.9719),(17,'Hospital de Jerez',NULL,NULL,'España','Andalucía','Jerez',36.6992,-6.1489),(18,'Hospital Doctor Negrín',NULL,NULL,'España','Canarias','Las Palmas de Gran Canaria',28.121,-15.4447),(19,'Hospital General de Valencia',NULL,NULL,'España','Comunidad Valenciana','Valencia',39.4683,-0.4064),(20,'Hospital Germans Trias i Pujol',NULL,NULL,'España','Cataluña','Barcelona',41.4812,2.2377),(21,'Hospital Getafe',NULL,NULL,'España','Madrid','Getafe',40.3127,-3.7426),(22,'Hospital La Princesa',NULL,NULL,'España','Madrid','Madrid',40.434,-3.6758),(23,'Hospital Manacor',NULL,NULL,'España','Baleares','Manacor',39.5461,3.33),(24,'Hospital Marqués de Valdecilla',NULL,NULL,'España','Cantabria','Santander',43.4559,-3.8295),(25,'Hospital Miguel Servet',NULL,NULL,'España','Aragón','Zaragoza',41.6354,-0.9009),(26,'Hospital Mutua de Terrasa',NULL,NULL,'España','Cataluña','Terrasa',41.5568,2.0531),(27,'Hospital Puerta del Mar',NULL,NULL,'España','Andalucía','Cádiz',36.5085,-6.2783),(28,'Hospital Ramón y Cajal',NULL,NULL,'España','Madrid','Madrid',40.4882,-3.6973),(29,'Hospital Reina Sofía',NULL,NULL,'España','Madrid','Madrid',42.0408,-1.6253),(30,'Hospital Royo Villanova',NULL,NULL,'España','Aragón','Zaragoza',41.6921,-0.861),(31,'Hospital Santa Creu i Sant Pau',NULL,NULL,'España','Cataluña','Barcelona',41.414,2.1755),(32,'Hospital Santiago de Compostela',NULL,NULL,'España','Galicia','Santiago de Compostela',42.8683,-8.5674),(33,'Hospital Son Llàtzer',NULL,NULL,'España','Baleares','Palma',39.575,2.7011),(34,'Hospital Vall d´Hebron',NULL,NULL,'España','Cataluña','Barcelona',41.427,2.1401),(35,'Hospital Virgen Arrixaca',NULL,NULL,'España','Murcia','Murcia',37.9322,-1.1625),(36,'Hospital Virgen de la Macarena',NULL,NULL,'España','Andalucía','Sevilla',37.4068,-5.9868),(37,'Hospital Virgen de la Victoria','',NULL,'España','Andalucía','Málaga',37.1942,-3.6267),(38,'Hospital Virgen del Rocío',NULL,NULL,'España','Andalucía','Sevilla',37.363,-5.9789),(39,'Hospital Can Misses',NULL,NULL,'España','Baleares','Ibiza',38.9158,1.4176),(40,'Hospital Son Espases',NULL,NULL,'España','Baleares','Palma',39.6052,2.6465),(41,'Hospital del Mar',NULL,NULL,'España','Cataluña','Barcelona',41.3836,2.194),(42,'Hospital Verge de la Cinta',NULL,NULL,'España','Cataluña','Tortosa',40.8111,0.5247),(43,'Hospital Santos Reyes',NULL,NULL,'España','Castilla y León','Aranda de Duero',41.6696,-3.6916),(44,'Hospital de Ciudad Real',NULL,NULL,'España','Castilla La Mancha','Ciudad real',38.97,-3.9315),(45,'Hospital de Badajoz',NULL,NULL,'España','Extremadura','Badajoz',38.8845,-7.0014),(46,'Hospital Arquitecto Marcide',NULL,NULL,'España','Galicia','Ferrol',43.5104,-8.216),(47,'Hospital Lucus Augusti',NULL,NULL,'España','Galicia','Lugo',43.0207,-7.5338),(48,'Hospital de Ourense',NULL,NULL,'España','Galicia','Orense',43.3047,-8.5031),(49,'Hospital San Pedro','','','España','La Rioja','Logroño',42.4532,-2.4246),(50,'Hospital Gregorio Marañón',NULL,NULL,'España','Madrid','Madrid',40.4182,-3.6691),(51,'Hospital Puerta de Hierro',NULL,NULL,'España','Madrid','Madrid',40.4503,-3.8737),(52,'Clínica de Navarra',NULL,NULL,'España','Navarra','Pamplona',42.8058,-1.6643);
/*!40000 ALTER TABLE `hospital` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-03 10:09:29
