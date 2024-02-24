-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: bd2practica2
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `id` int NOT NULL,
  `checksum` varchar(36) DEFAULT NULL,
  `created_at` bigint DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (2,'ef2ff68a-f7bd-d2d0-76cb-c830bd6e3191',1297555200,'Point-and-click','point-and-click',1323302400,'https://www.igdb.com/genres/point-and-click'),(4,'2ccc6572-bdde-6ed4-8843-25447ea40782',1297555200,'Fighting','fighting',1323216000,'https://www.igdb.com/genres/fighting'),(5,'bb15fd3f-0f46-e5f3-2b40-d046cf9bd2ef',1297555200,'Shooter','shooter',1323216000,'https://www.igdb.com/genres/shooter'),(7,'22d44a0d-89c7-580f-eef2-e06f178fdd47',1297555200,'Music','music',1323216000,'https://www.igdb.com/genres/music'),(8,'697fc5a4-b96f-a803-288a-498bd5dd1de1',1297555200,'Platform','platform',1323216000,'https://www.igdb.com/genres/platform'),(9,'616de9c3-8a00-0232-9df9-00014cfac51b',1297555200,'Puzzle','puzzle',1323216000,'https://www.igdb.com/genres/puzzle'),(10,'73c2653f-54d8-c1bd-d523-dd57fb753194',1297555200,'Racing','racing',1323216000,'https://www.igdb.com/genres/racing'),(11,'aaa36cbc-2258-8653-a461-1358df8ce445',1297555200,'Real Time Strategy (RTS)','real-time-strategy-rts',1323216000,'https://www.igdb.com/genres/real-time-strategy-rts'),(12,'42dea3b2-7fe2-e734-91cd-f80ce62a14c3',1297555200,'Role-playing (RPG)','role-playing-rpg',1323216000,'https://www.igdb.com/genres/role-playing-rpg'),(13,'9779772a-f08f-9e8e-bd26-70c9eecc34e8',1297555200,'Simulator','simulator',1323216000,'https://www.igdb.com/genres/simulator'),(14,'e598c458-3e21-7a14-50a5-ea53733ab22f',1297555200,'Sport','sport',1323216000,'https://www.igdb.com/genres/sport'),(15,'d7863f95-0f2c-0f2d-c1e9-29d06eaf3396',1297555200,'Strategy','strategy',1323216000,'https://www.igdb.com/genres/strategy'),(16,'af5d3ecd-2ebd-358b-70df-e9204b9761be',1297641600,'Turn-based strategy (TBS)','turn-based-strategy-tbs',1323216000,'https://www.igdb.com/genres/turn-based-strategy-tbs'),(24,'6132b15f-289e-60ea-5957-7c78b97053a2',1300924800,'Tactical','tactical',1323216000,'https://www.igdb.com/genres/tactical'),(25,'4bd95a5d-8fa1-1aee-4ea9-224b4b1312f7',1301616000,'Hack and slash/Beat \'em up','hack-and-slash-beat-em-up',1323216000,'https://www.igdb.com/genres/hack-and-slash-beat-em-up'),(26,'256a99dd-dd06-bc0c-d53b-dc3098da4d49',1301961600,'Quiz/Trivia','quiz-trivia',1323216000,'https://www.igdb.com/genres/quiz-trivia'),(30,'b5657d72-ee36-0851-58df-e8d2413283f8',1320192000,'Pinball','pinball',1323216000,'https://www.igdb.com/genres/pinball'),(31,'a6d85192-8d11-bad3-cc5c-dd89e2f94a47',1323561600,'Adventure','adventure',1323561600,'https://www.igdb.com/genres/adventure'),(32,'2522259f-2454-ec02-5dc0-84373e0508ed',1341360000,'Indie','indie',1341360000,'https://www.igdb.com/genres/indie'),(33,'388cec36-d099-f4a1-31c3-f938fae9067b',1380931200,'Arcade','arcade',1380931200,'https://www.igdb.com/genres/arcade'),(34,'137fe5c7-e4bc-1c30-4c7c-54596b47448f',1571788800,'Visual Novel','visual-novel',1571788800,'https://www.igdb.com/genres/visual-novel'),(35,'137bcfbe-be08-0b36-b66e-1bfef14ca49a',1588809600,'Card & Board Game','card-and-board-game',1588809600,'https://www.igdb.com/genres/card-and-board-game'),(36,'0f17b3a1-6d97-4c02-0997-850adf4dc624',1588809600,'MOBA','moba',1588809600,'https://www.igdb.com/genres/moba');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-23 22:47:46
