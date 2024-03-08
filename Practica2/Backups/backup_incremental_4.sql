-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: BD2PRACTICA2
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` int NOT NULL,
  `checksum` varchar(36) DEFAULT NULL,
  `created_at` bigint DEFAULT NULL,
  `locale` varchar(10) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `native_name` varchar(255) DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'e0963ddc-1e01-32e2-a959-d5ccda50410c',1664803639,'ar','Arabic','العربية',1664803639),(2,'ddcc7457-8939-17a3-9826-ef92d0d72371',1664803639,'zh-CN','Chinese (Simplified)','简体中文',1664803639),(3,'e7a793e9-d117-bc98-a000-67e444c0893d',1664803639,'zh-TW','Chinese (Traditional)','繁體中文',1664803639),(4,'58621751-aa00-f068-dbaf-2369d2e5a015',1664803639,'cs-CZ','Czech','čeština',1664803639),(5,'613fc1f9-9c07-474a-1ad5-7a26b44cc7ea',1664803639,'da-DK','Danish','Dansk',1664803639),(6,'a22e453a-e539-b794-5d44-368fbe6e3770',1664803639,'nl-NL','Dutch','Nederlands',1664803639),(7,'e2f64b8d-425f-28a3-3552-217aa1a955eb',1664803639,'en-US','English','English (US)',1664803639),(8,'9239bea3-9b7a-e4d2-016e-43440fbf8866',1664803639,'en-GB','English (UK)','English (UK)',1664803639),(9,'62657819-b6f2-2beb-786e-78455af2de8f',1664803639,'es-ES','Spanish (Spain)','Español (España)',1664803639),(10,'a94bcdc1-6434-c7b2-d9ce-14976388609c',1664803639,'es-MX','Spanish (Mexico)','Español (Mexico)',1664803639),(11,'863a2d01-e473-e98b-159c-4049d2216012',1664803639,'fi-FI','Finnish','Suomi',1664803639),(12,'6a477f36-9248-eae8-6626-5932d6384dbe',1664803639,'fr-FR','French','Français',1664803639),(13,'4102be99-eedf-5c3f-863c-d118637f7bf1',1664803639,'he-IL','Hebrew','עברית',1664803639),(14,'362d33d4-4896-3e8d-b703-cc030c2c7f73',1664803639,'hu-HU','Hungarian','Magyar',1664803639),(15,'52074797-ab02-c337-a805-a3e9969fc0eb',1664803639,'it-IT','Italian','Italiano',1664803639),(16,'6e46a214-1fc9-e097-bf2b-b5d3f1187a48',1664803639,'ja-JP','Japanese','日本語',1664803639),(17,'9ba648bf-f5fa-fa3c-3c6a-2fc7e1510cd6',1664803639,'ko-KR','Korean','한국어',1664803639),(18,'68196f0b-fdc4-c8cc-ded7-439904183360',1664803639,'nb-NO','Norwegian','Norsk',1664803639),(19,'19ec0e97-56cc-dc50-54fa-e2dd3989ba11',1664803639,'pl-PL','Polish','Polski',1664803639),(20,'0ba51fb0-09a1-8603-583d-0c0f635854c4',1664803639,'pt-PT','Portuguese (Portugal)','Português (Portugal)',1664803639),(21,'c62e5a15-99dc-0cd8-de04-fe6021ca78f8',1664803639,'pt-BR','Portuguese (Brazil)','Português (Brasil)',1664803639),(22,'a9cb4d56-9180-df0b-cd5f-ad8c9b820b64',1664803639,'ru-RU','Russian','Русский',1664803639),(23,'37988d2f-f5e5-663c-8cc5-5c27f463effe',1664803639,'sv-SE','Swedish','Svenska',1664803639),(24,'3fa287a0-7ee0-f965-2282-93931077359c',1664803640,'tr-TR','Turkish','Türkçe',1664803640),(25,'ec633fe7-383e-7831-7335-136cd446f771',1664803640,'th-TH','Thai','ไทย',1664803640),(26,'b576a1df-38ab-7aa5-60b4-090c09be22e0',1664803640,'vi-VN','Vietnamese','Tiếng Việt',1664803640),(27,'32a45eaa-c632-69d8-2318-c85812d0aae8',1666085793,'de-DE','German','Deutsch',1666085793),(28,'598ca48d-ed49-704d-6501-ac1ea2358075',1666085871,'uk-UA','Ukrainian','українська',1666085871);
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-07 22:47:46
