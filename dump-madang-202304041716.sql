-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: madang
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
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `bookid` int NOT NULL,
  `bookname` varchar(40) DEFAULT NULL,
  `publisher` varchar(40) DEFAULT NULL,
  `price` int DEFAULT NULL,
  PRIMARY KEY (`bookid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'축구의 역사','굿스포츠',7000),(2,'축구아는 여자','나무수',13000),(3,'축구의 이해','대한미디어',22000),(4,'골프 바이블','대한미디어',35000),(5,'피겨 교본','굿스포츠',8000),(6,'역도 단계별기술','굿스포츠',6000),(7,'야구의 추억','이상미디어',20000),(8,'야구를 부탁해','이상미디어',13000),(9,'올림픽 이야기','삼성당',7500),(10,'Olympic Champions','Pearson',13000),(11,'스포츠 의학','Pearson',90000),(21,'Zen Golf','Pearson',12000),(22,'Soccer Skills','Human Kinetics',15000);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `custid` int NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`custid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'박지성','영국 맨체스타','000-5000-0001'),(2,'김연아','대한민국 서울','000-6000-0001'),(3,'장미란','대한민국 강원도','000-7000-0001'),(4,'추신수','미국 클리블랜드','000-8000-0001'),(5,'박세리','대한민국 대전',NULL),(6,'박지성','독일 맨체스타','000-5000-2222'),(8,'hong','kkk@gmail.com','2002'),(9,'hong','seoul','111-222-3333'),(11,'park','seoul','222-3333-4444'),(12,'ggg','seoul2','000-222-333'),(50,'aa','bb@gmail','111-222-333'),(55,'cc','cc@gmail','8398-3838'),(77,'udj','dj@gmail','123-324-333'),(99,'김기동','대한민국','02-1111-2222');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `highorders`
--

DROP TABLE IF EXISTS `highorders`;
/*!50001 DROP VIEW IF EXISTS `highorders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `highorders` AS SELECT 
 1 AS `bookid`,
 1 AS `bookname`,
 1 AS `name`,
 1 AS `publisher`,
 1 AS `saleprice`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `imported_book`
--

DROP TABLE IF EXISTS `imported_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imported_book` (
  `bookid` int DEFAULT NULL,
  `bookname` varchar(40) DEFAULT NULL,
  `publisher` varchar(40) DEFAULT NULL,
  `price` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imported_book`
--

LOCK TABLES `imported_book` WRITE;
/*!40000 ALTER TABLE `imported_book` DISABLE KEYS */;
INSERT INTO `imported_book` VALUES (21,'Zen Golf','Pearson',12000),(22,'Soccer Skills','Human Kinetics',15000);
/*!40000 ALTER TABLE `imported_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mybook`
--

DROP TABLE IF EXISTS `mybook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mybook` (
  `bookid` int DEFAULT NULL,
  `price` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mybook`
--

LOCK TABLES `mybook` WRITE;
/*!40000 ALTER TABLE `mybook` DISABLE KEYS */;
INSERT INTO `mybook` VALUES (1,10000),(2,20000),(3,NULL);
/*!40000 ALTER TABLE `mybook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderid` int NOT NULL,
  `custid` int DEFAULT NULL,
  `bookid` int DEFAULT NULL,
  `saleprice` int DEFAULT NULL,
  `orderdate` date DEFAULT NULL,
  `bname` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,6000,'2014-07-01','축구의 역사'),(2,1,3,21000,'2014-07-03','축구의 이해'),(3,2,5,8000,'2014-07-03','피겨 교본'),(4,3,6,6000,'2014-07-04','역도 단계별기술'),(5,4,7,20000,'2014-07-05','야구의 추억'),(6,1,2,12000,'2014-07-07','축구아는 여자'),(7,4,8,13000,'2014-07-07','야구를 부탁해'),(8,3,10,12000,'2014-07-08','Olympic Champions'),(9,2,10,7000,'2014-07-09','Olympic Champions'),(10,3,8,13000,'2014-07-10','야구를 부탁해');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vm_order_info`
--

DROP TABLE IF EXISTS `vm_order_info`;
/*!50001 DROP VIEW IF EXISTS `vm_order_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vm_order_info` AS SELECT 
 1 AS `orderid`,
 1 AS `bookid`,
 1 AS `bookname`,
 1 AS `custid`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_book`
--

DROP TABLE IF EXISTS `vw_book`;
/*!50001 DROP VIEW IF EXISTS `vw_book`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_book` AS SELECT 
 1 AS `bookid`,
 1 AS `bookname`,
 1 AS `publisher`,
 1 AS `price`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'madang'
--

--
-- Final view structure for view `highorders`
--

/*!50001 DROP VIEW IF EXISTS `highorders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `highorders` AS select `b`.`bookid` AS `bookid`,`b`.`bookname` AS `bookname`,`c`.`name` AS `name`,`b`.`publisher` AS `publisher`,`o`.`saleprice` AS `saleprice` from ((`orders` `o` join `book` `b` on((`o`.`bookid` = `b`.`bookid`))) join `customer` `c` on((`o`.`custid` = `c`.`custid`))) where (`o`.`saleprice` > 20000) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vm_order_info`
--

/*!50001 DROP VIEW IF EXISTS `vm_order_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vm_order_info` AS select `o`.`orderid` AS `orderid`,`b`.`bookid` AS `bookid`,`b`.`bookname` AS `bookname`,`c`.`custid` AS `custid`,`c`.`name` AS `name` from ((`orders` `o` join `book` `b` on((`o`.`bookid` = `b`.`bookid`))) join `customer` `c` on((`c`.`custid` = `o`.`custid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_book`
--

/*!50001 DROP VIEW IF EXISTS `vw_book`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_book` AS select `book`.`bookid` AS `bookid`,`book`.`bookname` AS `bookname`,`book`.`publisher` AS `publisher`,`book`.`price` AS `price` from `book` where (`book`.`bookname` like '축구%') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-04 17:16:27
