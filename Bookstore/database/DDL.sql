-- -- 
-- Matt Catellier and Eusebius Ballentine
-- Project step 2 DRAFT
-- 
--MariaDB dump 10.19  Distrib 10.5.22-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_catellim
-- ------------------------------------------------------
-- Server version	10.6.15-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Books`
--
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Books` (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(145) NOT NULL,
  `title` varchar(145) NOT NULL,
  `genre` varchar(145) NOT NULL,
  `num_in_stock` int(11) NOT NULL DEFAULT 0,
  `price` decimal(19,2) NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `title_UNIQUE` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Books`
--

LOCK TABLES `Books` WRITE;
/*!40000 ALTER TABLE `Books` DISABLE KEYS */;
INSERT INTO `Books` VALUES (1,'Michael J. Sullian','Theft of Swords','Fantasy',4,18.99),(2,'Branden Sanderson','The Way of Kings','Fantasy',5,24.99),(3,'Charlotte Brontë','Jane Eyre','Romance',6,14.99),(4,'J.R.R. Tolkien','The Hobbit','Fantasy',3,23.99),(5,'G. Polya','How To Solve It','Mathematics',6,17.99);
/*!40000 ALTER TABLE `Books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(145) NOT NULL,
  `address` varchar(145) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
INSERT INTO `Customers` VALUES (1,'Sally','McRae','smcrae@hello.com','1234 st Bend, OR. 30092'),(2,'Bo','Chan\'g','bochang@hello.com','545 Ave Portland,  OR.  40092'),(3,'Bob','Smith','ssmith@hello.com','4321 st Hood River, OR.  50092'),(4,'Miguel','Cabrera','mc@hello.com','2024 st Corona, CA.  92882'),(5,'Willy','Thomas','willtom@hello.com','2349 aster ave. Someville, PA 17773');
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderDetails`
--

DROP TABLE IF EXISTS `OrderDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OrderDetails` (
  `order_details_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `book_quantity` int(11) NOT NULL,
  `unit_price` decimal(19,2) NOT NULL,
  `line_total` decimal(19,2) NOT NULL,
  `shipped` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_details_id`),
  KEY `fk_Books_has_Orders_Orders1_idx` (`order_id`),
  KEY `fk_Books_has_Orders_Books1_idx` (`book_id`),
  CONSTRAINT `fk_Order_Details_Books1` FOREIGN KEY (`book_id`) REFERENCES `Books` (`book_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Details_Orders1` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderDetails`
--

LOCK TABLES `OrderDetails` WRITE;
/*!40000 ALTER TABLE `OrderDetails` DISABLE KEYS */;
INSERT INTO `OrderDetails` VALUES (1,1,1,1,18.99,18.99,0),(2,4,2,2,23.99,47.98,1),(3,2,3,1,24.99,24.99,0),(4,1,3,1,18.99,18.99,1),(5,3,3,1,14.99,14.99,1);
/*!40000 ALTER TABLE `OrderDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `total_due` decimal(19,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_Orders_Customers_idx` (`customer_id`),
  KEY `fk_Orders_Payments1_idx` (`payment_id`),
  CONSTRAINT `fk_Orders_Customers` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Payments1` FOREIGN KEY (`payment_id`) REFERENCES `Payments` (`payment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` VALUES (1,4,1,'2008-04-09 00:00:00',0.00),(2,3,2,'2008-04-09 00:00:00',0.00),(3,5,3,'2008-04-10 00:00:00',0.00),(4,5,4,'2008-04-10 00:00:00',0.00);
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payments`
--

DROP TABLE IF EXISTS `Payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `Customers_customer_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `credit_card` varchar(145) NOT NULL,
  `exp_date` varchar(45) NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_Payments_Customers1_idx` (`Customers_customer_id`),
  CONSTRAINT `fk_Payments_Customers1` FOREIGN KEY (`Customers_customer_id`) REFERENCES `Customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payments`
--

LOCK TABLES `Payments` WRITE;
/*!40000 ALTER TABLE `Payments` DISABLE KEYS */;
INSERT INTO `Payments` VALUES (1,4,'2008-04-08 00:00:00','1234567890122345','9/2029'),(2,3,'2008-04-09 00:00:00','4284652697294202','9/2029'),(3,5,'2008-04-10 00:00:00','5241331426663057','8/2027'),(4,5,'2008-04-11 00:00:00','4556204748319454','11/2023');
/*!40000 ALTER TABLE `Payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-26 15:51:38

SET FOREIGN_KEY_CHECKS=1;
COMMIT;

