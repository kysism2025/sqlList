-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: exam_stduent
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
-- Table structure for table `hakgwa`
--

DROP TABLE IF EXISTS `hakgwa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hakgwa` (
  `hcode` char(1) DEFAULT NULL,
  `hname` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hakgwa`
--

LOCK TABLES `hakgwa` WRITE;
/*!40000 ALTER TABLE `hakgwa` DISABLE KEYS */;
INSERT INTO `hakgwa` VALUES ('1','경영학과'),('2','컴퓨터공학과'),('3','수학과'),('4','영문학과'),('5','DB보안과');
/*!40000 ALTER TABLE `hakgwa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `hakbun` varchar(8) NOT NULL,
  `sname` varchar(20) DEFAULT NULL,
  `hcode` char(1) DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `jumin` char(14) DEFAULT NULL,
  `dongari` varchar(20) DEFAULT NULL,
  `janghak` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`hakbun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('19910393','김찬중','1','010-1234-1111','780112-1234567','영화',NULL),('19910394','이호천','2','010-1234-1112','790112-2234567','영화','수상'),('19910395','김도향','3','010-1234-1113','800112-1234567',NULL,NULL),('20000394','홍길동','4','010-1234-1114','800712-2234567','탁구','수상'),('20001093','김갑돌','4','010-1234-1115','780113-1234567','영화',NULL),('20041093','김갑순','2','010-1234-1116','000112-3234567','테니스',NULL);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sungjuk`
--

DROP TABLE IF EXISTS `sungjuk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sungjuk` (
  `hakbun` varchar(8) DEFAULT NULL,
  `kor` int DEFAULT NULL,
  `mat` int DEFAULT NULL,
  `eng` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sungjuk`
--

LOCK TABLES `sungjuk` WRITE;
/*!40000 ALTER TABLE `sungjuk` DISABLE KEYS */;
INSERT INTO `sungjuk` VALUES ('19910393',80,90,100),('19910394',70,55,80),('19910395',98,90,90),('20000394',70,90,100),('20001093',99,78,100),('20001094',NULL,NULL,NULL);
/*!40000 ALTER TABLE `sungjuk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sungjuk2`
--

DROP TABLE IF EXISTS `sungjuk2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sungjuk2` (
  `hakbun` varchar(8) NOT NULL,
  `sname` varchar(20) DEFAULT NULL,
  `kor` int DEFAULT NULL,
  `mat` int DEFAULT NULL,
  `eng` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sungjuk2`
--

LOCK TABLES `sungjuk2` WRITE;
/*!40000 ALTER TABLE `sungjuk2` DISABLE KEYS */;
INSERT INTO `sungjuk2` VALUES ('19910393','김찬중',80,90,100),('19910394','이호천',70,55,80),('19910395','김도향',98,90,90),('20000394','홍길동',70,90,100),('20001093','김갑돌',99,78,100);
/*!40000 ALTER TABLE `sungjuk2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'exam_stduent'
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
