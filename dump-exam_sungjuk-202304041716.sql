-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: exam_sungjuk
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `sungjuk`
--

DROP TABLE IF EXISTS `sungjuk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sungjuk` (
  `hakbun` varchar(4) DEFAULT NULL,
  `id` varchar(20) DEFAULT NULL,
  `sname` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `kor` int DEFAULT NULL,
  `eng` int DEFAULT NULL,
  `mat` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sungjuk`
--

LOCK TABLES `sungjuk` WRITE;
/*!40000 ALTER TABLE `sungjuk` DISABLE KEYS */;
INSERT INTO `sungjuk` VALUES ('1','a1','홍길동','kkk@k.com',80,70,90),('2','b1','이선생','iii@i.com',76,38,89),('3','c1','양선생','ooo@o.com',90,70,80),('5','e1','주선생','w@w.com',80,100,100);
/*!40000 ALTER TABLE `sungjuk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sungjuk_result`
--

DROP TABLE IF EXISTS `sungjuk_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sungjuk_result` (
  `hakbun` varchar(4) DEFAULT NULL,
  `id` varchar(20) DEFAULT NULL,
  `sname` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `kor` int DEFAULT NULL,
  `eng` int DEFAULT NULL,
  `mat` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sungjuk_result`
--

LOCK TABLES `sungjuk_result` WRITE;
/*!40000 ALTER TABLE `sungjuk_result` DISABLE KEYS */;
INSERT INTO `sungjuk_result` VALUES ('1','a1','홍길동','kkk@k.com',80,70,90),('3','c1','양선생','ooo@o.com',90,70,80),('5','e1','주선생',NULL,100,100,100);
/*!40000 ALTER TABLE `sungjuk_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'exam_sungjuk'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-04 17:16:26
