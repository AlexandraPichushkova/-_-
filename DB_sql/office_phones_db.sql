-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: office_phones
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `bill_id` int NOT NULL,
  `b_date` date DEFAULT NULL,
  `b_month` int DEFAULT NULL,
  `b_year` int DEFAULT NULL,
  `summ` float DEFAULT NULL,
  PRIMARY KEY (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (1004,'2006-03-20',9,2005,2348),(2651,'2020-12-01',3,2020,13000),(2908,'2024-02-15',1,2024,45690),(8643,'2007-05-19',3,2007,27400);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_lines`
--

DROP TABLE IF EXISTS `bill_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_lines` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `summ` float NOT NULL,
  `bill_id` int NOT NULL,
  `worker_phone` int NOT NULL,
  PRIMARY KEY (`line_id`),
  KEY `bill_id_idx` (`bill_id`),
  KEY `workers_phone_idx` (`worker_phone`),
  CONSTRAINT `bill_id` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`),
  CONSTRAINT `worker_phone` FOREIGN KEY (`worker_phone`) REFERENCES `occ` (`phone_numb`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_lines`
--

LOCK TABLES `bill_lines` WRITE;
/*!40000 ALTER TABLE `bill_lines` DISABLE KEYS */;
INSERT INTO `bill_lines` VALUES (7,100,2651,687901),(8,18900,2651,123456),(9,234000,2651,234567),(10,7000,8643,345678),(11,21750,1004,123456),(12,12340,2908,687901),(13,23000,1004,123456);
/*!40000 ALTER TABLE `bill_lines` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bill_lines_AFTER_INSERT` AFTER INSERT ON `bill_lines` FOR EACH ROW BEGIN
DECLARE M, Y integer;
DECLARE w_limit float;
SELECT b_month, b_year INTO M, Y
  FROM bill
    WHERE bill_id = new.bill_id;
SELECT occ_limit INTO w_limit
  FROM occ
  WHERE phone_numb = new.worker_phone;
IF new.summ > w_limit THEN
  INSERT INTO limit_exceed VALUES(NULL, new.summ-w_limit, M, Y, NULL, new.worker_phone);
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `exced_maxers`
--

DROP TABLE IF EXISTS `exced_maxers`;
/*!50001 DROP VIEW IF EXISTS `exced_maxers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `exced_maxers` AS SELECT 
 1 AS `phone`,
 1 AS `ex_kol`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `exceed_maxer`
--

DROP TABLE IF EXISTS `exceed_maxer`;
/*!50001 DROP VIEW IF EXISTS `exceed_maxer`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `exceed_maxer` AS SELECT 
 1 AS `phone`,
 1 AS `ex_kol`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `exceed_maxers`
--

DROP TABLE IF EXISTS `exceed_maxers`;
/*!50001 DROP VIEW IF EXISTS `exceed_maxers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `exceed_maxers` AS SELECT 
 1 AS `ex_phone`,
 1 AS `kol`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `exceeed_maxers`
--

DROP TABLE IF EXISTS `exceeed_maxers`;
/*!50001 DROP VIEW IF EXISTS `exceeed_maxers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `exceeed_maxers` AS SELECT 
 1 AS `phone`,
 1 AS `ex_kol`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `limit_exceed`
--

DROP TABLE IF EXISTS `limit_exceed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `limit_exceed` (
  `exceed_id` int NOT NULL AUTO_INCREMENT,
  `summ` float DEFAULT NULL,
  `ex_month` int DEFAULT NULL,
  `ex_year` int DEFAULT NULL,
  `ex_date` date DEFAULT NULL,
  `ex_phone` int NOT NULL,
  PRIMARY KEY (`exceed_id`),
  KEY `exceed_phone_idx` (`ex_phone`),
  CONSTRAINT `ex_phone` FOREIGN KEY (`ex_phone`) REFERENCES `occ` (`phone_numb`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `limit_exceed`
--

LOCK TABLES `limit_exceed` WRITE;
/*!40000 ALTER TABLE `limit_exceed` DISABLE KEYS */;
INSERT INTO `limit_exceed` VALUES (1,1000,3,2020,'2020-11-03',123456),(2,500,3,2020,'2021-01-02',345678),(3,23,1,2021,'2021-01-30',456789),(4,256,4,2023,'2023-08-12',234567),(5,300,3,2020,'2020-04-01',454567),(6,10000,4,2020,'2020-05-30',345678),(7,2987,5,2020,'2020-07-11',123456),(11,9901,3,2020,NULL,687901),(22,229975,3,2020,NULL,234567),(23,1000,3,2007,NULL,345678),(24,15400,3,2020,NULL,123456),(25,229975,3,2020,NULL,234567),(26,1000,3,2007,NULL,345678),(27,15400,3,2020,NULL,123456),(28,229975,3,2020,NULL,234567),(29,15400,3,2020,NULL,123456),(30,229975,3,2020,NULL,234567),(31,18250,9,2005,NULL,123456),(32,2339,1,2024,NULL,687901),(33,15400,3,2020,NULL,123456),(36,15400,3,2020,NULL,123456),(37,229975,3,2020,NULL,234567);
/*!40000 ALTER TABLE `limit_exceed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occ`
--

DROP TABLE IF EXISTS `occ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `occ` (
  `phone_numb` int DEFAULT NULL,
  `occ_limit` float DEFAULT NULL,
  `occ_id` int NOT NULL,
  PRIMARY KEY (`occ_id`),
  KEY `phone_numb_idx` (`phone_numb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occ`
--

LOCK TABLES `occ` WRITE;
/*!40000 ALTER TABLE `occ` DISABLE KEYS */;
INSERT INTO `occ` VALUES (687901,10001,2),(90345,2300,5),(123456,3500,6),(234567,4025,7),(345678,6000,8),(456789,5500,9),(454567,8900,10);
/*!40000 ALTER TABLE `occ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `pay_id` int NOT NULL,
  `pay_date` date DEFAULT NULL,
  PRIMARY KEY (`pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (234,'2019-12-03'),(235,'2021-06-22'),(236,'2024-03-14'),(237,'2021-08-16'),(240,'2007-03-20');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_lines`
--

DROP TABLE IF EXISTS `payment_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_lines` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `p_summ` float DEFAULT NULL,
  `p_month` int DEFAULT NULL,
  `p_year` int DEFAULT NULL,
  `pay_id` int NOT NULL,
  `pay_phone` int NOT NULL,
  PRIMARY KEY (`line_id`),
  KEY `pay_id_idx` (`pay_id`),
  KEY `pay_phone_idx` (`pay_phone`),
  CONSTRAINT `pay_id` FOREIGN KEY (`pay_id`) REFERENCES `payment` (`pay_id`),
  CONSTRAINT `pay_phone` FOREIGN KEY (`pay_phone`) REFERENCES `occ` (`phone_numb`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_lines`
--

LOCK TABLES `payment_lines` WRITE;
/*!40000 ALTER TABLE `payment_lines` DISABLE KEYS */;
INSERT INTO `payment_lines` VALUES (5,50,6,2018,234,123456),(6,2035,5,2023,235,456789),(7,485,8,2017,236,234567),(8,200,9,2019,237,345678),(9,1010,3,2007,240,345678);
/*!40000 ALTER TABLE `payment_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `worker`
--

DROP TABLE IF EXISTS `worker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worker` (
  `worker_id` int NOT NULL AUTO_INCREMENT,
  `surname` varchar(45) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `post` varchar(45) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `phone_numb` int DEFAULT NULL,
  PRIMARY KEY (`worker_id`),
  KEY `phone_numb_idx` (`phone_numb`),
  CONSTRAINT `w_phone` FOREIGN KEY (`phone_numb`) REFERENCES `occ` (`phone_numb`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worker`
--

LOCK TABLES `worker` WRITE;
/*!40000 ALTER TABLE `worker` DISABLE KEYS */;
INSERT INTO `worker` VALUES (1,'Potter','Londom','1998-02-10','manager','2010-05-13',25,123456),(2,'Malfoy','Miami','1997-04-01','director','2011-09-18',49,234567),(3,'Weasly','Moscow','2005-12-23','assistant','2018-07-22',34,456789),(4,'Granger','London','2000-04-12','accountant','2020-11-27',17,345678),(5,'Lovegood','Paris','1999-11-01','president','2024-01-20',13,NULL),(6,'Dumbledore','London','1950-02-03','headmaster','2005-06-19',2,687901),(7,'Mcgonaggal','Moscow','1960-09-18','manager','2024-03-14',49,454567);
/*!40000 ALTER TABLE `worker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'office_phones'
--

--
-- Dumping routines for database 'office_phones'
--
/*!50003 DROP PROCEDURE IF EXISTS `count_exceed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_exceed`(bill_num integer)
BEGIN
DECLARE M, Y integer;
DECLARE done integer DEFAULT 0;
DECLARE phone integer;
DECLARE w_sum, w_limit float;
DECLARE C1 CURSOR FOR SELECT worker_phone, summ, occ_limit
  FROM bill_lines JOIN occ ON bill_lines.worker_phone = occ.phone_numb
    WHERE bill_id = bill_num;
DECLARE EXIT HANDLER FOR SQLSTATE '02000'
  SET done = 1;
SELECT b_month, b_year INTO M, Y
  FROM bill WHERE bill_id = bill_num;
OPEN C1;
WHILE done = 0 DO
  FETCH C1 INTO phone, w_sum, w_limit;
    IF w_sum > w_limit THEN
    INSERT INTO limit_exceed VALUES(NULL, w_sum-w_limit, M, Y, NULL, phone);
  END IF;
END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `exced_maxers`
--

/*!50001 DROP VIEW IF EXISTS `exced_maxers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `exced_maxers` (`phone`,`ex_kol`) AS select `limit_exceed`.`ex_phone` AS `ex_phone`,count(0) AS `COUNT(*)` from `limit_exceed` where (`limit_exceed`.`ex_year` = 2020) group by `limit_exceed`.`ex_phone` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `exceed_maxer`
--

/*!50001 DROP VIEW IF EXISTS `exceed_maxer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `exceed_maxer` (`phone`,`ex_kol`) AS select `limit_exceed`.`ex_phone` AS `ex_phone`,count(0) AS `COUNT(*)` from `limit_exceed` where (`limit_exceed`.`ex_year` = 2020) group by `limit_exceed`.`ex_phone` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `exceed_maxers`
--

/*!50001 DROP VIEW IF EXISTS `exceed_maxers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `exceed_maxers` AS select `limit_exceed`.`ex_phone` AS `ex_phone`,count(0) AS `kol` from `limit_exceed` where (`limit_exceed`.`ex_year` = 2020) group by `limit_exceed`.`ex_phone` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `exceeed_maxers`
--

/*!50001 DROP VIEW IF EXISTS `exceeed_maxers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `exceeed_maxers` (`phone`,`ex_kol`) AS select `limit_exceed`.`ex_phone` AS `ex_phone`,count(0) AS `COUNT(*)` from `limit_exceed` where (`limit_exceed`.`ex_year` = 2020) group by `limit_exceed`.`ex_phone` */;
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

-- Dump completed on 2024-10-15 22:10:53
