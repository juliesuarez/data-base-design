-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: talenthub_db
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `clubs`
--

DROP TABLE IF EXISTS `clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clubs` (
  `user_id` int NOT NULL,
  `club_name` varchar(200) NOT NULL,
  `country` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `clubs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `customusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubs`
--

LOCK TABLES `clubs` WRITE;
/*!40000 ALTER TABLE `clubs` DISABLE KEYS */;
INSERT INTO `clubs` VALUES (8,'KCCA FC','Uganda','Kampala Capital City Authority Football Club, a top-tier club in the Uganda Premier League.'),(9,'Simba SC','Tanzania','One of the most successful football clubs in Tanzania, based in Dar es Salaam.'),(10,'Gor Mahia F.C.','Kenya','A historic and successful football club based in Nairobi, Kenya.');
/*!40000 ALTER TABLE `clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clubshortlists`
--

DROP TABLE IF EXISTS `clubshortlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clubshortlists` (
  `club_id` int NOT NULL,
  `player_id` int NOT NULL,
  `date_added` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`club_id`,`player_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `clubshortlists_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `clubshortlists_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubshortlists`
--

LOCK TABLES `clubshortlists` WRITE;
/*!40000 ALTER TABLE `clubshortlists` DISABLE KEYS */;
INSERT INTO `clubshortlists` VALUES (8,1,NULL),(8,7,NULL),(9,3,NULL),(9,6,NULL),(10,2,NULL);
/*!40000 ALTER TABLE `clubshortlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customusers`
--

DROP TABLE IF EXISTS `customusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customusers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL DEFAULT '0',
  `is_staff` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `date_joined` datetime(6) DEFAULT NULL,
  `user_type` enum('player','club') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customusers`
--

LOCK TABLES `customusers` WRITE;
/*!40000 ALTER TABLE `customusers` DISABLE KEYS */;
INSERT INTO `customusers` VALUES (1,'123',NULL,'jokello','John','Okello','j.okello@gmail.com',0,0,1,NULL,'player'),(2,'1234',NULL,'domondi','David','Omondi','d.omondi@gmail.com',0,0,1,NULL,'player'),(3,'12345',NULL,'ajuma','Aisha','Juma','a.juma@egmail.com',0,0,1,NULL,'player'),(4,'12346',NULL,'pwasswa','Peter','Wasswa','p.wasswa@gmail.com',0,0,1,NULL,'player'),(5,'1234567',NULL,'mwanjiku','Mary','Wanjiku','m.wanjiku@gmail.com',0,0,1,NULL,'player'),(6,'123',NULL,'hmwakinyo','Hassan','Mwakinyo','h.mwakinyo@gmail.com',0,0,1,NULL,'player'),(7,'123',NULL,'snabirye','Sandra','Nabirye','s.nabirye@gmail.com',0,0,1,NULL,'player'),(8,'123',NULL,'kccafc','KCCA','FC','scout@kcca.co.ug',0,0,1,NULL,'club'),(9,'123',NULL,'simbasc','Simba','SC','scout@simbasc.co.tz',0,0,1,NULL,'club'),(10,'123',NULL,'gormahia','Gor','Mahia','scout@gormahia.co.ke',0,0,1,NULL,'club');
/*!40000 ALTER TABLE `customusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `user_id` int NOT NULL,
  `country` varchar(100) NOT NULL,
  `position` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `bio` text,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `players_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `customusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'Uganda','Striker','2004-05-15','A fast and clinical striker with a powerful shot.'),(2,'Kenya','Midfielder','2003-09-22','Creative attacking midfielder with excellent vision and passing.'),(3,'Tanzania','Defender','2004-01-30','A strong central defender, dominant in the air.'),(4,'Uganda','Goalkeeper','2002-11-10','Agile goalkeeper with great reflexes and distribution skills.'),(5,'Kenya','Winger','2005-03-25','Speedy winger who loves to take on defenders.'),(6,'Tanzania','Midfielder','2003-07-18','Box-to-box midfielder with a high work rate.'),(7,'Uganda','Defender','2004-08-05','Versatile defender who can play as a full-back or center-back.');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `club_id` int NOT NULL,
  `tier` varchar(10) NOT NULL DEFAULT 'free',
  `start_date` datetime(6) DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `club_id` (`club_id`),
  CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` VALUES (1,8,'pro',NULL,'2026-09-01 00:00:00.000000',1),(2,9,'pro',NULL,'2026-09-01 00:00:00.000000',1),(3,10,'free',NULL,NULL,1);
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `video_file` varchar(100) NOT NULL,
  `uploaded_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` VALUES (9,1,'John Okello - Best Goals 2025','videos/jokello_goals.mp4',NULL),(10,1,'John Okello - Dribbling Skills','videos/jokello_skills.mp4',NULL),(11,2,'David Omondi - Passing Compilation','videos/domondi_passing.mp4',NULL),(12,3,'Aisha Juma - Defensive Masterclass','videos/ajuma_defense.mp4',NULL),(13,4,'Peter Wasswa - Top Saves','videos/pwasswa_saves.mp4',NULL),(14,5,'Mary Wanjiku - Speed and Crosses','videos/mwanjiku_wingplay.mp4',NULL),(15,6,'Hassan Mwakinyo - Midfield Dominance','videos/hmwakinyo_midfield.mp4',NULL),(16,7,'Sandra Nabirye - Tackling Highlights','videos/snabirye_tackles.mp4',NULL),(17,1,'John Okello - Best Goals 2025','videos/jokello_goals.mp4',NULL),(18,1,'John Okello - Dribbling Skills','videos/jokello_skills.mp4',NULL),(19,2,'David Omondi - Passing Compilation','videos/domondi_passing.mp4',NULL),(20,3,'Aisha Juma - Defensive Masterclass','videos/ajuma_defense.mp4',NULL),(21,4,'Peter Wasswa - Top Saves','videos/pwasswa_saves.mp4',NULL),(22,5,'Mary Wanjiku - Speed and Crosses','videos/mwanjiku_wingplay.mp4',NULL),(23,6,'Hassan Mwakinyo - Midfield Dominance','videos/hmwakinyo_midfield.mp4',NULL),(24,7,'Sandra Nabirye - Tackling Highlights','videos/snabirye_tackles.mp4',NULL);
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videotags`
--

DROP TABLE IF EXISTS `videotags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videotags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `video_id` int NOT NULL,
  `tag` varchar(100) NOT NULL,
  `start_time` double DEFAULT NULL,
  `end_time` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `videotags_ibfk_1` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videotags`
--

LOCK TABLES `videotags` WRITE;
/*!40000 ALTER TABLE `videotags` DISABLE KEYS */;
/*!40000 ALTER TABLE `videotags` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-04 23:43:36
