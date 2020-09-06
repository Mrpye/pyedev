/*
SQLyog Community v12.09 (64 bit)
MySQL - 10.4.13-MariaDB : Database - dashboard
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dashboard` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `dashboard`;

/*Table structure for table `config` */

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `config` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `enc` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `config` */

insert  into `config`(`id`,`name`,`config`,`enc`) values (4,'metric_url','http://172.16.10.98:8090',0),(5,'Authorization','Bearer eyJraWQiOiIxOGU5MGE0MC0wNWE3LTRkM2YtOGE3Mi0zMDAwNDkxYWYzNDMiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJBcHBEeW5hbWljcyIsImF1ZCI6IkFwcERfQVBJcyIsImp0aSI6ImVCZmE0UEVVb25nT2ZMMU9rQ2FxTnciLCJzdWIiOiJEeW5hbWljRGFzaGJvYXJkZXIiLCJpZFR5cGUiOiJBUElfQ0xJRU5UIiwiaWQiOiIzZjE5ZjFlOC04NTMyLTRjYzktODBiMy05MWE0Y2JlMjJmMGQiLCJhY2N0SWQiOiIxOGU5MGE0MC0wNWE3LTRkM2YtOGE3Mi0zMDAwNDkxYWYzNDMiLCJ0bnRJZCI6IjE4ZTkwYTQwLTA1YTctNGQzZi04YTcyLTMwMDA0OTFhZjM0MyIsImFjY3ROYW1lIjoiY3VzdG9tZXIxIiwidGVuYW50TmFtZSI6IiIsImZtbVRudElkIjpudWxsLCJhY2N0UGVybSI6W10sImlhdCI6MTU5NDE0MDk2NCwibmJmIjoxNTk0MTQwODQ0LCJleHAiOjE2MjU2NzY5NjQsInRva2VuVHlwZSI6IkFDQ0VTUyJ9.1p3VFnUgrhzLYNtu641YwJI8vq5AH_-KvDId91_JbyA',0),(6,'metric_duration','&time-range-type=BEFORE_NOW&duration-in-mins=5&output=JSON',0),(7,'import_location','',0),(8,'import_sheet','Sheet2',0),(9,'import_range','A1:Q117',0),(10,'import_table_name','hardware',0),(12,'ship_config','{\r\n\"ship_name\":\"USS Monterey \",\r\n\"hull\":\"CG\",\r\n\"hull_no\":\"61\"\r\n}',0),(13,'last_data_collect','07/14/2020 08:38:57 am',0),(14,'last_event','07/14/2020 09:26:10 am',0),(15,'time_zone','America/New_York',0),(16,'enable_dump','0',0),(17,'autoscroll','8000',0),(18,'simulate_tenants','1',0),(19,'simulate_awx','1',0),(20,'awx_host','mgmt-ans02',0),(21,'awx_authorization','Bearer YtSLxsR5PgsxvmVfwuZazTJetTTyDE',0),(22,'awx_job_id','7',0);

/*Table structure for table `dashboard` */

DROP TABLE IF EXISTS `dashboard`;

CREATE TABLE `dashboard` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `row` int(11) DEFAULT 1,
  `widget` varchar(30) DEFAULT NULL,
  `width` int(11) DEFAULT 2,
  `sql` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4;

/*Data for the table `dashboard` */

insert  into `dashboard`(`id`,`name`,`row`,`widget`,`width`,`sql`) values (20,'Hardware',1,'fan_data',2,'SELECT * FROM data_metric_data WHERE  metricName LIKE \"%|%|{{ip}}|%|%|speedInPercent\" ORDER BY metricName'),(22,'CSR1',1,NULL,2,'SELECT `Cabinet Name`,Cabinet FROM data_hardware WHERE location=\"SHIP\" AND `Space`=\"CSR1\" GROUP BY `Cabinet Name`,Cabinet;\r\nSELECT * FROM data_hardware WHERE location=\"SHIP\" AND `Space`=\"CSR1\" and Cabinet=? ORDER BY row desc;'),(23,'Hardware',1,'power',2,'SELECT * FROM data_metric_data WHERE metricName LIKE \"%|%|{{ip}}|%|%|volt\" ORDER BY metricName'),(24,'Hardware',1,'fan_data',2,'SELECT * FROM data_metric_data WHERE metricName LIKE \"%|%|{{ip}}|%|%|maxSpeed\" ORDER BY metricName'),(25,'Hardware',1,'status',2,'SELECT * FROM data_metric_data WHERE metricName LIKE \"%|%|{{ip}}|%|%|operSt\" ORDER BY metricName'),(26,'Hardware',1,'online',2,'SELECT * FROM data_metric_data WHERE metricName LIKE \"%|%|{{ip}}|online\" ORDER BY metricName'),(27,'Hardware',1,'online',2,'SELECT * FROM data_metric_data WHERE metricName LIKE \"%|%|{{ip}}|%|%|online\" ORDER BY metricName'),(28,'Hardware',1,'lineinputvoltage',2,'SELECT * FROM data_metric_data WHERE metricName LIKE \"%|%|{{ip}}|%|lineinputvoltage\" ORDER BY metricName'),(29,'Hardware',1,'lastpoweroutputwatts',2,'SELECT * FROM data_metric_data WHERE metricName LIKE \"%|%|{{ip}}|%|lastpoweroutputwatts\" ORDER BY metricName'),(30,'Hardware',1,'readingvolts',2,'SELECT * FROM data_metric_data WHERE metricName LIKE \"%|%|{{ip}}|%|readingvolts\" ORDER BY metricName'),(31,'Hardware',1,'readingcelsius',2,'SELECT * FROM data_metric_data WHERE metricName LIKE \"%|%|{{ip}}|%|readingcelsius\" ORDER BY metricName'),(32,'Hardware',1,'reading',2,'SELECT * FROM data_metric_data WHERE metricName LIKE \"%|%|{{ip}}|%|reading\" ORDER BY metricName');

/*Table structure for table `dashboard_list` */

DROP TABLE IF EXISTS `dashboard_list`;

CREATE TABLE `dashboard_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `dashboard_list` */

insert  into `dashboard_list`(`id`,`name`,`url`) values (1,'ship','/widget/ship'),(2,'CC1','/dashboard/dynamic_rack/CSR1');

/*Table structure for table `data_dump` */

DROP TABLE IF EXISTS `data_dump`;

CREATE TABLE `data_dump` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4;

/*Data for the table `data_dump` */

/*Table structure for table `data_hardware` */

DROP TABLE IF EXISTS `data_hardware`;

CREATE TABLE `data_hardware` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `Address` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Address2` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Hostname` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent` tinyint(1) DEFAULT 0,
  `child` tinyint(1) DEFAULT 0,
  `cable_managment` tinyint(1) DEFAULT NULL,
  `New Name` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Type` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Location` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Cabinet Name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Cabinet` bigint(20) DEFAULT NULL,
  `Space` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Keg` bigint(20) DEFAULT NULL,
  `Row` bigint(20) DEFAULT NULL,
  `U` bigint(20) DEFAULT NULL,
  `Function` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `data_hardware` */

insert  into `data_hardware`(`uid`,`Address`,`Address2`,`Hostname`,`parent`,`child`,`cable_managment`,`New Name`,`Type`,`Location`,`Cabinet Name`,`Cabinet`,`Space`,`Keg`,`Row`,`U`,`Function`,`Description`) values (1,'172.20.1.40',NULL,'Row6 Storage-1',0,0,0,'SHIPCSR101000101Row6 Storage-1','MGMT','SHIP','Rack1',1,'CSR1',0,1,1,NULL,NULL),(2,'172.20.1.22',NULL,'ESXi-T4-02',0,0,0,'SHIPCSR101000302ESXi-T4-02','MGMT','SHIP','Rack1',1,'CSR1',0,3,2,'CESX',NULL),(3,'172.20.1.23',NULL,'ESXi-P40-01',0,0,0,'SHIPCSR101000502ESXi-P40-01','MGMT','SHIP','Rack1',1,'CSR1',0,5,2,NULL,NULL),(4,'172.20.1.21',NULL,'ESXi-T4-01',0,0,0,'SHIPCSR101000702ESXi-T4-01','MGMT','SHIP','Rack1',1,'CSR1',0,7,2,'CESX',NULL),(5,'172.20.1.41',NULL,'Row6 Storage-5',0,0,0,'SHIPCSR101000801Row6 Storage-5','MGMT','SHIP','Rack1',1,'CSR1',0,8,1,NULL,NULL),(6,'172.20.1.50',NULL,'FPC-01',0,0,0,'SHIPCSR101001002FPC-01','MGMT','SHIP','Rack1',1,'CSR1',0,10,2,NULL,NULL),(7,'172.20.1.20',NULL,'HX-01',0,0,0,'SHIPCSR101001202HX-01','MGMT','SHIP','Rack1',1,'CSR1',0,12,2,NULL,NULL),(8,'N/A (Cable Management)',NULL,'APC - AR8428',0,0,1,'SHIPCSR101001402APC - AR8428','MGMT','SHIP','Rack1',1,'CSR1',0,14,2,NULL,NULL),(9,'172.20.1.254','172.20.1.252','OOB-RTR-01/OOB-SW-01',0,0,0,'SHIPCSR101001602OOB-RTR-01/OOB-SW-01','MGMT','SHIP','Rack1',1,'CSR1',0,16,2,NULL,NULL),(10,'172.20.1.7','172.20.1.8','APIC-01',1,0,0,'SHIPCSR101001802APIC-01','MGMT','SHIP','Rack1',1,'CSR1',0,18,2,'NWAA','Network/ACI/APIC'),(11,'172.20.1.12',NULL,'VIM-EXP-03',0,0,0,'SHIPCSR101001901VIM-EXP-03','MGMT','SHIP','Rack1',1,'CSR1',0,19,1,NULL,NULL),(12,'172.20.1.13',NULL,'VIM-EXP-02',0,0,0,'SHIPCSR101002001VIM-EXP-02','MGMT','SHIP','Rack1',1,'CSR1',0,20,1,NULL,NULL),(13,'172.20.1.14',NULL,'VIM-EXP-01',0,0,0,'SHIPCSR101002101VIM-EXP-01','MGMT','SHIP','Rack1',1,'CSR1',0,21,1,NULL,NULL),(14,'172.20.1.15',NULL,'VIM-MGT-01',0,0,0,'SHIPCSR101002302VIM-MGT-01','MGMT','SHIP','Rack1',1,'CSR1',0,23,2,NULL,NULL),(15,'N/A (Cable Management)',NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR101002401APC  - AR8108BLK','MGMT','SHIP','Rack1',1,'CSR1',0,24,1,NULL,NULL),(16,'N/A (Cable Management)',NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR101002501APC  - AR8108BLK','MGMT','SHIP','Rack1',1,'CSR1',0,25,1,NULL,NULL),(17,'N/A (Cable Management)',NULL,'APC - AR8428',0,0,1,'SHIPCSR101002702APC - AR8428','MGMT','SHIP','Rack1',1,'CSR1',0,27,2,NULL,NULL),(18,'172.20.1.2',NULL,'Broker-301',0,0,0,'SHIPCSR101002801Broker-301','MGMT','SHIP','Rack1',1,'CSR1',0,28,1,NULL,NULL),(19,'N/A (Cable Management)',NULL,'APC - AR8428',0,0,1,'SHIPCSR101003002APC - AR8428','MGMT','SHIP','Rack1',1,'CSR1',0,30,2,NULL,NULL),(20,'172.20.1.4',NULL,'Leaf-202',0,1,0,'SHIPCSR101003101Leaf-202','MGMT','SHIP','Rack1',1,'CSR1',0,31,1,'NWAL','Network/ACI/Leaf'),(21,'N/A (Cable Management)',NULL,'APC - AR8428',0,0,1,'SHIPCSR101003302APC - AR8428','MGMT','SHIP','Rack1',1,'CSR1',0,33,2,NULL,NULL),(22,'172.20.1.3',NULL,'Leaf-201',0,1,0,'SHIPCSR101003401Leaf-201','MGMT','SHIP','Rack1',1,'CSR1',0,34,1,'NWAL','Network/ACI/Leaf'),(23,'N/A',NULL,'APC - AR8428',0,0,0,'SHIPCSR101003602APC - AR8428','MGMT','SHIP','Rack1',1,'CSR1',0,36,2,NULL,NULL),(24,'172.20.1.1',NULL,'Spine-01',0,1,0,'SHIPCSR101003701Spine-01','MGMT','SHIP','Rack1',1,'CSR1',0,37,1,'NWAS','Network ACI Spine'),(25,'N/A (Cable Management)',NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR101003801APC  - AR8108BLK','MGMT','SHIP','Rack1',1,'CSR1',0,38,1,NULL,NULL),(26,'172.20.1.6',NULL,'Time-01',0,0,0,'SHIPCSR101003901Time-01','MGMT','SHIP','Rack1',1,'CSR1',0,39,1,NULL,NULL),(27,'N/A (Cable Management)',NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR101004001APC  - AR8108BLK','MGMT','SHIP','Rack1',1,'CSR1',0,40,1,NULL,NULL),(28,'N/A (Cable Management)',NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR101004101APC  - AR8108BLK','MGMT','SHIP','Rack1',1,'CSR1',0,41,1,NULL,NULL),(29,'N/A (Cable Management)',NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR101004201APC  - AR8108BLK','MGMT','SHIP','Rack1',1,'CSR1',0,42,1,NULL,NULL),(30,'172.20.2.41',NULL,'Row6 Storage-2',0,0,0,'SHIPCSR102000101Row6 Storage-2','MGMT','SHIP','Rack2',2,'CSR1',0,1,1,NULL,NULL),(31,'172.20.2.26',NULL,'ESXi-T4-07',0,0,0,'SHIPCSR102000302ESXi-T4-07','MGMT','SHIP','Rack2',2,'CSR1',0,3,2,NULL,NULL),(32,'172.20.2.25',NULL,'ESXi-P40-02',0,0,0,'SHIPCSR102000502ESXi-P40-02','MGMT','SHIP','Rack2',2,'CSR1',0,5,2,NULL,NULL),(33,'172.20.2.24',NULL,'ESXi-T4-06',0,0,0,'SHIPCSR102000702ESXi-T4-06','MGMT','SHIP','Rack2',2,'CSR1',0,7,2,NULL,NULL),(34,'172.20.2.23',NULL,'ESXi-T4-05',0,0,0,'SHIPCSR102000902ESXi-T4-05','MGMT','SHIP','Rack2',2,'CSR1',0,9,2,NULL,NULL),(35,'172.20.2.22',NULL,'ESXi-T4-04',0,0,0,'SHIPCSR102001102ESXi-T4-04','MGMT','SHIP','Rack2',2,'CSR1',0,11,2,NULL,NULL),(36,'172.20.2.21',NULL,'ESXi-T4-03',0,0,0,'SHIPCSR102001302ESXi-T4-03','MGMT','SHIP','Rack2',2,'CSR1',0,13,2,NULL,NULL),(37,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR102001502APC - AR8428','MGMT','SHIP','Rack2',2,'CSR1',0,15,2,NULL,NULL),(38,'172.20.2.254','172.20.2.252','OOB-RTR-02/OOB-SW-02',0,0,0,'SHIPCSR102001702OOB-RTR-02/OOB-SW-02','MGMT','SHIP','Rack2',2,'CSR1',0,17,2,NULL,NULL),(39,'172.20.2.20',NULL,'HX-02',0,0,0,'SHIPCSR102001902HX-02','MGMT','SHIP','Rack2',2,'CSR1',0,19,2,NULL,NULL),(40,'172.20.2.14',NULL,'VIM-EXP-06',0,0,0,'SHIPCSR102002001VIM-EXP-06','MGMT','SHIP','Rack2',2,'CSR1',0,20,1,NULL,NULL),(41,'172.20.2.13',NULL,'VIM-EXP-05',0,0,0,'SHIPCSR102002101VIM-EXP-05','MGMT','SHIP','Rack2',2,'CSR1',0,21,1,NULL,NULL),(42,'172.20.2.12',NULL,'VIM-EXP-04',0,0,0,'SHIPCSR102002201VIM-EXP-04','MGMT','SHIP','Rack2',2,'CSR1',0,22,1,NULL,NULL),(43,'172.20.2.11',NULL,'VIM-MPOD-02',0,0,0,'SHIPCSR102002402VIM-MPOD-02','MGMT','SHIP','Rack2',2,'CSR1',0,24,2,NULL,NULL),(44,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR102002501APC  - AR8108BLK','MGMT','SHIP','Rack2',2,'CSR1',0,25,1,NULL,NULL),(45,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR102002702APC - AR8428','MGMT','SHIP','Rack2',2,'CSR1',0,27,2,NULL,NULL),(46,'172.20.2.9',NULL,'FW-01',0,0,0,'SHIPCSR102002801FW-01','MGMT','SHIP','Rack2',2,'CSR1',0,28,1,NULL,NULL),(47,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR102003002APC - AR8428','MGMT','SHIP','Rack2',2,'CSR1',0,30,2,NULL,NULL),(48,'172.20.2.3',NULL,'Leaf-204',0,0,0,'SHIPCSR102003101Leaf-204','MGMT','SHIP','Rack2',2,'CSR1',0,31,1,NULL,NULL),(49,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR102003302APC - AR8428','MGMT','SHIP','Rack2',2,'CSR1',0,33,2,NULL,NULL),(50,'172.20.2.4',NULL,'Leaf-203',0,0,0,'SHIPCSR102003401Leaf-203','MGMT','SHIP','Rack2',2,'CSR1',0,34,1,NULL,NULL),(51,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR102003602APC  - AR8108BLK','MGMT','SHIP','Rack2',2,'CSR1',0,36,2,NULL,NULL),(52,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR102003701APC  - AR8108BLK','MGMT','SHIP','Rack2',2,'CSR1',0,37,1,NULL,NULL),(53,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR102003801APC  - AR8108BLK','MGMT','SHIP','Rack2',2,'CSR1',0,38,1,NULL,NULL),(54,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR102003901APC  - AR8108BLK','MGMT','SHIP','Rack2',2,'CSR1',0,39,1,NULL,NULL),(55,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR102004001APC  - AR8108BLK','MGMT','SHIP','Rack2',2,'CSR1',0,40,1,NULL,NULL),(56,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR102004101APC  - AR8108BLK','MGMT','SHIP','Rack2',2,'CSR1',0,41,1,NULL,NULL),(57,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR102004201APC  - AR8108BLK','MGMT','SHIP','Rack2',2,'CSR1',0,42,1,NULL,NULL),(58,'172.20.2.41',NULL,'Row6 Storage-3',0,0,0,'SHIPCSR103000101Row6 Storage-3','MGMT','SHIP','Rack3',3,'CSR1',0,1,1,NULL,NULL),(59,'172.20.3.25',NULL,'ESXi-T4-11',0,0,0,'SHIPCSR103000302ESXi-T4-11','MGMT','SHIP','Rack3',3,'CSR1',0,3,2,NULL,NULL),(60,'172.20.3.24',NULL,'ESXi-P40-03',0,0,0,'SHIPCSR103000502ESXi-P40-03','MGMT','SHIP','Rack3',3,'CSR1',0,5,2,NULL,NULL),(61,'172.20.3.23',NULL,'ESXi-T4-10',0,0,0,'SHIPCSR103000702ESXi-T4-10','MGMT','SHIP','Rack3',3,'CSR1',0,7,2,NULL,NULL),(62,'172.20.3.22',NULL,'ESXi-T4-09',0,0,0,'SHIPCSR103000902ESXi-T4-09','MGMT','SHIP','Rack3',3,'CSR1',0,9,2,NULL,NULL),(63,'172.20.3.21',NULL,'ESXi-T4-08',0,0,0,'SHIPCSR103001102ESXi-T4-08','MGMT','SHIP','Rack3',3,'CSR1',0,11,2,NULL,NULL),(64,'172.20.3.20',NULL,'HX-03',0,0,0,'SHIPCSR103001302HX-03','MGMT','SHIP','Rack3',3,'CSR1',0,13,2,NULL,NULL),(65,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR103001502APC - AR8428','MGMT','SHIP','Rack3',3,'CSR1',0,15,2,NULL,NULL),(66,'172.20.3.254','172.20.3.252','OOB-RTR-03/OOB-SW-03',0,0,0,'SHIPCSR103001702OOB-RTR-03/OOB-SW-03','MGMT','SHIP','Rack3',3,'CSR1',0,17,2,NULL,NULL),(67,'172.20.3.7','172.20.3.8','APIC-02',0,0,0,'SHIPCSR103001902APIC-02','MGMT','SHIP','Rack3',3,'CSR1',0,19,2,NULL,NULL),(68,'172.20.3.14',NULL,'VIM-EXP-09',0,0,0,'SHIPCSR103002001VIM-EXP-09','MGMT','SHIP','Rack3',3,'CSR1',0,20,1,NULL,NULL),(69,'172.20.3.13',NULL,'VIM-EXP-08',0,0,0,'SHIPCSR103002101VIM-EXP-08','MGMT','SHIP','Rack3',3,'CSR1',0,21,1,NULL,NULL),(70,'172.20.3.12',NULL,'VIM-EXP-07',0,0,0,'SHIPCSR103002201VIM-EXP-07','MGMT','SHIP','Rack3',3,'CSR1',0,22,1,NULL,NULL),(71,'172.20.3.11',NULL,'VIM-MPOD-03',0,0,0,'SHIPCSR103002402VIM-MPOD-03','MGMT','SHIP','Rack3',3,'CSR1',0,24,2,NULL,NULL),(72,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR103002501APC  - AR8108BLK','MGMT','SHIP','Rack3',3,'CSR1',0,25,1,NULL,NULL),(73,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR103002702APC - AR8428','MGMT','SHIP','Rack3',3,'CSR1',0,27,2,NULL,NULL),(74,'172.20.3.9',NULL,'FW-02',0,0,0,'SHIPCSR103002801FW-02','MGMT','SHIP','Rack3',3,'CSR1',0,28,1,NULL,NULL),(75,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR103003002APC - AR8428','MGMT','SHIP','Rack3',3,'CSR1',0,30,2,NULL,NULL),(76,'172.20.3.3',NULL,'Leaf-206',0,0,0,'SHIPCSR103003101Leaf-206','MGMT','SHIP','Rack3',3,'CSR1',0,31,1,NULL,NULL),(77,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR103003302APC - AR8428','MGMT','SHIP','Rack3',3,'CSR1',0,33,2,NULL,NULL),(78,'172.20.3.4',NULL,'Leaf-205',0,0,0,'SHIPCSR103003401Leaf-205','MGMT','SHIP','Rack3',3,'CSR1',0,34,1,NULL,NULL),(79,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR103003501APC  - AR8108BLK','MGMT','SHIP','Rack3',3,'CSR1',0,35,1,NULL,NULL),(80,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR103003601APC  - AR8108BLK','MGMT','SHIP','Rack3',3,'CSR1',0,36,1,NULL,NULL),(81,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR103003701APC  - AR8108BLK','MGMT','SHIP','Rack3',3,'CSR1',0,37,1,NULL,NULL),(82,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR103003801APC  - AR8108BLK','MGMT','SHIP','Rack3',3,'CSR1',0,38,1,NULL,NULL),(83,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR103003901APC  - AR8108BLK','MGMT','SHIP','Rack3',3,'CSR1',0,39,1,NULL,NULL),(84,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR103004001APC  - AR8108BLK','MGMT','SHIP','Rack3',3,'CSR1',0,40,1,NULL,NULL),(85,'172.20.3.4',NULL,'APC  - AR8108BLK',0,0,0,'SHIPCSR103004101APC  - AR8108BLK','MGMT','SHIP','Rack3',3,'CSR1',0,41,1,NULL,NULL),(86,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR103004201APC  - AR8108BLK','MGMT','SHIP','Rack3',3,'CSR1',0,42,1,NULL,NULL),(87,'172.20.3.41',NULL,'Row6 Storage-4',0,0,0,'SHIPCSR104000101Row6 Storage-4','MGMT','SHIP','Rack4',4,'CSR1',0,1,1,NULL,NULL),(88,'172.20.4.23',NULL,'ESXi-T4-12',0,0,0,'SHIPCSR104000302ESXi-T4-12','MGMT','SHIP','Rack4',4,'CSR1',0,3,2,NULL,NULL),(89,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR104000401APC  - AR8108BLK','MGMT','SHIP','Rack4',4,'CSR1',0,4,1,NULL,NULL),(90,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR104000501APC  - AR8108BLK','MGMT','SHIP','Rack4',4,'CSR1',0,5,1,NULL,NULL),(91,'172.20.4.22',NULL,'ESXi-P40-04',0,0,0,'SHIPCSR104000702ESXi-P40-04','MGMT','SHIP','Rack4',4,'CSR1',0,7,2,NULL,NULL),(92,'172.20.4.41',NULL,'Row6 Storage-6',0,0,0,'SHIPCSR104000801Row6 Storage-6','MGMT','SHIP','Rack4',4,'CSR1',0,8,1,NULL,NULL),(93,'172.20.4.51',NULL,'FPC-02',0,0,0,'SHIPCSR104001002FPC-02','MGMT','SHIP','Rack4',4,'CSR1',0,10,2,NULL,NULL),(94,'172.20.4.21',NULL,'CLOCK-01',0,0,0,'SHIPCSR104001202CLOCK-01','MGMT','SHIP','Rack4',4,'CSR1',0,12,2,NULL,NULL),(95,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR104001402APC - AR8428','MGMT','SHIP','Rack4',4,'CSR1',0,14,2,NULL,NULL),(96,'172.20.4.252','172.20.4.252','OOB-RTR-04/OOB-SW-04',0,0,0,'SHIPCSR104001602OOB-RTR-04/OOB-SW-04','MGMT','SHIP','Rack4',4,'CSR1',0,16,2,NULL,NULL),(97,'172.20.4.8',NULL,'APIC-03',0,0,0,'SHIPCSR104001802APIC-03','MGMT','SHIP','Rack4',4,'CSR1',0,18,2,NULL,NULL),(98,'172.20.4.14',NULL,'VIM-EXP-12',0,0,0,'SHIPCSR104001901VIM-EXP-12','MGMT','SHIP','Rack4',4,'CSR1',0,19,1,NULL,NULL),(99,'172.20.4.13',NULL,'VIM-EXP-11',0,0,0,'SHIPCSR104002001VIM-EXP-11','MGMT','SHIP','Rack4',4,'CSR1',0,20,1,NULL,NULL),(100,'172.20.4.12',NULL,'VIM-EXP-10',0,0,0,'SHIPCSR104002101VIM-EXP-10','MGMT','SHIP','Rack4',4,'CSR1',0,21,1,NULL,NULL),(101,'172.20.4.11',NULL,'VIM-MPOD-04',0,0,0,'SHIPCSR104002302VIM-MPOD-04','MGMT','SHIP','Rack4',4,'CSR1',0,23,2,NULL,NULL),(102,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR104002401APC  - AR8108BLK','MGMT','SHIP','Rack4',4,'CSR1',0,24,1,NULL,NULL),(103,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR104002501APC  - AR8108BLK','MGMT','SHIP','Rack4',4,'CSR1',0,25,1,NULL,NULL),(104,'NA',NULL,'KVM',0,0,1,'SHIPCSR104002702KVM','MGMT','SHIP','Rack4',4,'CSR1',0,27,2,NULL,NULL),(105,'172.20.4.1',NULL,'Broker-302',0,0,0,'SHIPCSR104002801Broker-302','MGMT','SHIP','Rack4',4,'CSR1',0,28,1,NULL,NULL),(106,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR104003002APC - AR8428','MGMT','SHIP','Rack4',4,'CSR1',0,30,2,NULL,NULL),(107,'172.20.4.3',NULL,'Leaf-208',0,0,0,'SHIPCSR104003101Leaf-208','MGMT','SHIP','Rack4',4,'CSR1',0,31,1,NULL,NULL),(108,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR104003302APC - AR8428','MGMT','SHIP','Rack4',4,'CSR1',0,33,2,NULL,NULL),(109,'172.20.4.4',NULL,'Leaf-207',0,0,0,'SHIPCSR104003401Leaf-207','MGMT','SHIP','Rack4',4,'CSR1',0,34,1,NULL,NULL),(110,NULL,NULL,'APC - AR8428',0,0,1,'SHIPCSR104003602APC - AR8428','MGMT','SHIP','Rack4',4,'CSR1',0,36,2,NULL,NULL),(111,'172.20.1.1',NULL,'Spine-102',0,0,0,'SHIPCSR104003701Spine-102','MGMT','SHIP','Rack4',4,'CSR1',0,37,1,NULL,NULL),(112,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR104003801APC  - AR8108BLK','MGMT','SHIP','Rack4',4,'CSR1',0,38,1,NULL,NULL),(113,'172.20.4.6',NULL,'Time-02',0,0,0,'SHIPCSR104003901Time-02','MGMT','SHIP','Rack4',4,'CSR1',0,39,1,NULL,NULL),(114,'172.20.4.170',NULL,'VIM-MASTER',0,0,0,'SHIPCSR104004102VIM-MASTER','MGMT','SHIP','Rack4',4,'CSR1',0,41,2,NULL,NULL),(115,NULL,NULL,'APC  - AR8108BLK',0,0,1,'SHIPCSR104004201APC  - AR8108BLK','MGMT','SHIP','Rack4',4,'CSR1',0,42,1,NULL,NULL),(116,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `data_metric_data` */

DROP TABLE IF EXISTS `data_metric_data`;

CREATE TABLE `data_metric_data` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `metricId` bigint(20) DEFAULT NULL,
  `metricName` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `metricPath` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `frequency` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `metricValues` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=432 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `data_metric_data` */

/*Table structure for table `event_system` */

DROP TABLE IF EXISTS `event_system`;

CREATE TABLE `event_system` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `ship` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `rack` varchar(50) DEFAULT NULL,
  `script` varchar(50) DEFAULT NULL,
  `hardware` varchar(50) DEFAULT NULL,
  `item_group` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `state` int(8) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `deep_link` tinytext DEFAULT NULL,
  `display_name` varchar(500) DEFAULT NULL,
  `metric` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

/*Data for the table `event_system` */

/*Table structure for table `forms` */

DROP TABLE IF EXISTS `forms`;

CREATE TABLE `forms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `add` text DEFAULT NULL,
  `edit` text DEFAULT NULL,
  `view` text DEFAULT NULL,
  `table` varchar(50) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

/*Data for the table `forms` */

insert  into `forms`(`id`,`name`,`add`,`edit`,`view`,`table`,`icon`) values (1,'widgets','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"sql\":{\r\n         \"Title\":\"Sql\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":4\r\n      },\r\n      \"config\":{\r\n         \"Title\":\"Config\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      },\r\n      \"widget\":{\r\n         \"Title\":\"Widget\",\r\n         \"type\":\"select\",\r\n         \"edit\":false,\r\n         \"options\":[\r\n            \"traffic\",\r\n            \"ship\"\r\n         ]\r\n      }\r\n   }\r\n}','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"sql\":{\r\n         \"Title\":\"Sql\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":4\r\n      },\r\n      \"config\":{\r\n         \"Title\":\"Config\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      },\r\n      \"widget\":{\r\n         \"Title\":\"Widget\",\r\n         \"type\":\"select\",\r\n         \"edit\":false,\r\n         \"options\":[\r\n            \"traffic\",\r\n            \"ship\"\r\n         ]\r\n      }\r\n   }\r\n}','   {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n    \r\n      \"widget\":{\r\n         \"Title\":\"Widget\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','widget_config',' fas fa-database'),(3,'forms','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":true\r\n      },\r\n      \"add\":{\r\n         \"Title\":\"add\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      },\r\n      \"edit\":{\r\n         \"Title\":\"edit\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      },\r\n      \"view\":{\r\n         \"Title\":\"view\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      },\r\n      \"icon\":{\r\n         \"Title\":\"icons\",\r\n         \"type\":\"select\",\r\n         \"edit\":false,\r\n         \"options\":[\r\n            \"fas fa-th\",\r\n            \"fas fa-database\"\r\n         ]\r\n      },\r\n      \"table\":{\r\n         \"Title\":\"Table\",\r\n         \"type\":\"text\",\r\n         \"edit\":\"select\",\r\n         \"options\":[\r\n            \"config\",\r\n            \"dashboard\",\r\n            \"dashboard_list\",\r\n            \"data_dump\",\r\n            \"data_hardware\",\r\n            \"data_metric_data\",\r\n            \"event_system\",\r\n            \"forms\",\r\n            \"log\",\r\n            \"scheme\",\r\n            \"target_rest_api\",\r\n            \"user\",\r\n            \"widget_config\"\r\n         ]\r\n      }\r\n   }\r\n}','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":true\r\n      },\r\n      \"add\":{\r\n         \"Title\":\"add\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      },\r\n      \"edit\":{\r\n         \"Title\":\"edit\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      },\r\n      \"view\":{\r\n         \"Title\":\"view\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      },\r\n      \"icon\":{\r\n         \"Title\":\"icons\",\r\n         \"type\":\"select\",\r\n         \"edit\":false,\r\n         \"options\":[\r\n            \"fas fa-th\",\r\n            \"fas fa-database\"\r\n         ]\r\n      },\r\n      \"table\":{\r\n         \"Title\":\"Table\",\r\n         \"type\":\"text\",\r\n         \"edit\":\"select\",\r\n         \"options\":[\r\n            \"config\",\r\n            \"dashboard\",\r\n            \"dashboard_list\",\r\n            \"data_dump\",\r\n            \"data_hardware\",\r\n            \"data_metric_data\",\r\n            \"event_system\",\r\n            \"forms\",\r\n            \"log\",\r\n            \"scheme\",\r\n            \"target_rest_api\",\r\n            \"user\",\r\n            \"widget_config\"\r\n         ]\r\n      }\r\n   }\r\n}','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":true\r\n      },\r\n      \"table\":{\r\n         \"Title\":\"Table\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','forms',' fas fa-database'),(4,'config',' {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":true\r\n      },\r\n      \"config\":{\r\n         \"Title\":\"config\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n		 \"rows\": 8\r\n      }\r\n   }\r\n}',' {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":true\r\n      },\r\n      \"config\":{\r\n         \"Title\":\"config\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n		 \"rows\": 8\r\n      }\r\n   }\r\n}','   {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":true\r\n      }\r\n      \r\n   }\r\n}','config','fas fa-database'),(9,'dashboard','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"widget\":{\r\n         \"Title\":\"widget\",\r\n         \"type\":\"widget_list\",\r\n         \"edit\":false\r\n      },\r\n      \"row\":{\r\n         \"Title\":\"Row\",\r\n         \"type\":\"text\",\r\n         \"edit\":false,\r\n         \"mask\":\"\'mask\':\'9\'\"\r\n      },\r\n      \"width\":{\r\n         \"Title\":\"width\",\r\n         \"type\":\"text\",\r\n         \"edit\":false,\r\n         \"mask\":\"\'mask\':\'9\'\"\r\n      },\r\n      \"sql\":{\r\n         \"Title\":\"sql\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      }\r\n   }\r\n}','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"widget\":{\r\n         \"Title\":\"widget\",\r\n         \"type\":\"widget_list\",\r\n         \"edit\":false\r\n      },\r\n      \"row\":{\r\n         \"Title\":\"Row\",\r\n         \"type\":\"text\",\r\n         \"edit\":false,\r\n         \"mask\":\"\'mask\':\'9\'\"\r\n      },\r\n      \"width\":{\r\n         \"Title\":\"width\",\r\n         \"type\":\"text\",\r\n         \"edit\":false,\r\n         \"mask\":\"\'mask\':\'9\'\"\r\n      },\r\n      \"sql\":{\r\n         \"Title\":\"sql\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      }\r\n   }\r\n}','   {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"widget\":{\r\n         \"Title\":\"widget\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','dashboard','fas fa-database'),(10,'dashboard_list','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"url\":{\r\n         \"Title\":\"Url\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"url\":{\r\n         \"Title\":\"Url\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"name\":{\r\n         \"Title\":\"Name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"url\":{\r\n         \"Title\":\"Url\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','dashboard_list',''),(11,'data_dump','   {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"data\":{\r\n         \"Title\":\"Data\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','   {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"data\":{\r\n         \"Title\":\"Data\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','   {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"data\":{\r\n         \"Title\":\"Data\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','data_dump',''),(12,'scheme',' {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"scheme\":{\r\n         \"Title\":\"Scheme\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n		   \"rows\": 8\r\n      },\r\n      \"is_metric\":{\r\n         \"Title\":\"Is Metric\",\r\n         \"type\":\"bool\",\r\n         \"edit\":true\r\n      }\r\n   }\r\n}',' {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"scheme\":{\r\n         \"Title\":\"Scheme\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n		   \"rows\": 8\r\n      },\r\n      \"is_metric\":{\r\n         \"Title\":\"Is Metric\",\r\n         \"type\":\"bool\",\r\n         \"edit\":true\r\n      }\r\n   }\r\n}',' {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"scheme\":{\r\n         \"Title\":\"Scheme\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false\r\n      },\r\n      \"is_metric\":{\r\n         \"Title\":\"Is Metric\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      }\r\n   }\r\n}','scheme',''),(13,'target_rest_api','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"name\":{\r\n         \"Title\":\"name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"url\":{\r\n         \"Title\":\"Url\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"method\":{\r\n         \"Title\":\"Method\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"body\":{\r\n         \"Title\":\"Body\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false\r\n      },\r\n      \"scheme\":{\r\n         \"Title\":\"Scheme\",\r\n         \"type\":\"scheme_list\",\r\n         \"edit\":false\r\n      },\r\n      \"limit\":{\r\n         \"Title\":\"Limit\",\r\n         \"type\":\"text\",\r\n         \"edit\":false,\r\n         \"mask\":\"\'mask\':\'99999\'\"\r\n      },\r\n      \"transform\":{\r\n         \"Title\":\"Transform\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      },\r\n      \"clear\":{\r\n         \"Title\":\"Clear\",\r\n         \"type\":\"bool\",\r\n         \"edit\":false\r\n      },\r\n      \"is_metric\":{\r\n         \"Title\":\"is_metric\",\r\n         \"type\":\"bool\",\r\n         \"edit\":false\r\n      },\r\n      \"enabled\":{\r\n         \"Title\":\"enabled\",\r\n         \"type\":\"bool\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"name\":{\r\n         \"Title\":\"name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"url\":{\r\n         \"Title\":\"Url\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"method\":{\r\n         \"Title\":\"Method\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"body\":{\r\n         \"Title\":\"Body\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false\r\n      },\r\n      \"scheme\":{\r\n         \"Title\":\"Scheme\",\r\n         \"type\":\"scheme_list\",\r\n         \"edit\":false\r\n      },\r\n      \"limit\":{\r\n         \"Title\":\"Limit\",\r\n         \"type\":\"text\",\r\n         \"edit\":false,\r\n         \"mask\":\"\'mask\':\'99999\'\"\r\n      },\r\n      \"transform\":{\r\n         \"Title\":\"Transform\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false,\r\n         \"rows\":8\r\n      },\r\n      \"clear\":{\r\n         \"Title\":\"Clear\",\r\n         \"type\":\"bool\",\r\n         \"edit\":false\r\n      },\r\n      \"is_metric\":{\r\n         \"Title\":\"is_metric\",\r\n         \"type\":\"bool\",\r\n         \"edit\":false\r\n      },\r\n      \"enabled\":{\r\n         \"Title\":\"enabled\",\r\n         \"type\":\"bool\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','  {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"id\":{\r\n         \"Title\":\"Id\",\r\n         \"type\":\"int\",\r\n         \"edit\":true\r\n      },\r\n      \"name\":{\r\n         \"Title\":\"name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"url\":{\r\n         \"Title\":\"Url\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"method\":{\r\n         \"Title\":\"Method\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"body\":{\r\n         \"Title\":\"Body\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false\r\n      },\r\n      \"scheme\":{\r\n         \"Title\":\"Scheme\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"clear\":{\r\n         \"Title\":\"Clear\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"limit\":{\r\n         \"Title\":\"Limit\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"transform\":{\r\n         \"Title\":\"Transform\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false\r\n      },\r\n      \"is_metric\":{\r\n         \"Title\":\"is_metric\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"enabled\":{\r\n         \"Title\":\"enabled\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','target_rest_api',''),(15,'event_system','  {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"ship\":{\r\n         \"ship\":\"ship\",\r\n         \"type\":\"text\",\r\n         \"edit\":true\r\n      },\r\n      \"location\":{\r\n         \"Title\":\"location\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"rack\":{\r\n         \"Title\":\"rack\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"script\":{\r\n         \"Title\":\"script\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"hardware\":{\r\n         \"Title\":\"hardware\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"item_group\":{\r\n         \"Title\":\"item_group\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"item\":{\r\n         \"Title\":\"item\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n	  \"metric\":{\r\n         \"Title\":\"metric\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"state\":{\r\n         \"Title\":\"state\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"message\":{\r\n         \"Title\":\"message\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false\r\n      },\r\n      \"deep_link\":{\r\n         \"Title\":\"deep_link\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"display_name\":{\r\n         \"Title\":\"display_name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"name\":{\r\n         \"Title\":\"name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','  {\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"ship\":{\r\n         \"ship\":\"ship\",\r\n         \"type\":\"text\",\r\n         \"edit\":true\r\n      },\r\n      \"location\":{\r\n         \"Title\":\"location\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"rack\":{\r\n         \"Title\":\"rack\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"script\":{\r\n         \"Title\":\"script\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"hardware\":{\r\n         \"Title\":\"hardware\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"item_group\":{\r\n         \"Title\":\"item_group\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"item\":{\r\n         \"Title\":\"item\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n	  \"metric\":{\r\n         \"Title\":\"metric\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"state\":{\r\n         \"Title\":\"state\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"message\":{\r\n         \"Title\":\"message\",\r\n         \"type\":\"textarea\",\r\n         \"edit\":false\r\n      },\r\n      \"deep_link\":{\r\n         \"Title\":\"deep_link\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"display_name\":{\r\n         \"Title\":\"display_name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"name\":{\r\n         \"Title\":\"name\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      }\r\n   }\r\n}','{\r\n   \"key\":\"id\",\r\n   \"fields_scheme\":{\r\n      \"ship\":{\r\n         \"ship\":\"ship\",\r\n         \"type\":\"text\",\r\n         \"edit\":true\r\n      },\r\n      \"location\":{\r\n         \"Title\":\"location\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"script\":{\r\n         \"Title\":\"script\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"hardware\":{\r\n         \"Title\":\"hardware\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"item_group\":{\r\n         \"Title\":\"item_group\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      },\r\n      \"item\":{\r\n         \"Title\":\"item\",\r\n         \"type\":\"text\",\r\n         \"edit\":false\r\n      }\r\n\r\n   }\r\n}','event_system','');

/*Table structure for table `log` */

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `message` text DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `log` */

/*Table structure for table `scheme` */

DROP TABLE IF EXISTS `scheme`;

CREATE TABLE `scheme` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `scheme` text DEFAULT NULL,
  `is_metric` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `scheme` */

insert  into `scheme`(`id`,`name`,`scheme`,`is_metric`) values (5,'metric_data','{\r\n   \"eventType\":\"metric_data\",\r\n   \"schema\":{\r\n      \"metricId\":\"INT8\",\r\n      \"metricName\":\"VARCHAR512\",\r\n      \"metricPath\":\"VARCHAR512\",\r\n      \"frequency\":\"VARCHAR128\",\r\n      \"metricValues\":\"TEXT\"\r\n   }\r\n}',1),(6,'hardware','{\r\n   \"eventType\":\"hardware\",\r\n   \"schema\":{\r\n      \"Address\":\"VARCHAR128\",\r\n      \"Address2\":\"VARCHAR128\",\r\n      \"Hostname\":\"VARCHAR512\",\r\n      \"parent\":\"INT1\",\r\n      \"child\":\"INT1\",\r\n\"cable_managment\":\"INT1\",\r\n      \"New Name\":\"VARCHAR512\",\r\n      \"Type\":\"VARCHAR128\",\r\n      \"Location\":\"VARCHAR128\",\r\n      \"Cabinet Name\":\"VARCHAR128\",\r\n      \"Cabinet\":\"INT8\",\r\n      \"Space\":\"VARCHAR128\",\r\n      \"Keg\":\"INT8\",\r\n      \"Row\":\"INT8\",\r\n      \"U\":\"INT8\",\r\n      \"Function\":\"VARCHAR128\",\r\n      \"Description\":\"TEXT\"\r\n   }\r\n}',1);

/*Table structure for table `target_rest_api` */

DROP TABLE IF EXISTS `target_rest_api`;

CREATE TABLE `target_rest_api` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(500) DEFAULT NULL,
  `method` varchar(10) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `scheme` varchar(50) DEFAULT NULL,
  `clear` tinyint(1) DEFAULT NULL,
  `limit` int(11) DEFAULT NULL,
  `transform` text DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `is_metric` tinyint(1) DEFAULT 0,
  `enabled` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4;

/*Data for the table `target_rest_api` */

insert  into `target_rest_api`(`id`,`url`,`method`,`body`,`scheme`,`clear`,`limit`,`transform`,`name`,`is_metric`,`enabled`) values (24,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|NX|*|*|*|speedInPercent','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',1,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1),(26,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|NX|*|*|*|speedInRpm','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',0,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1),(28,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|NX|*|*|*|volt','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',0,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1),(29,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|ACI|*|*|*|maxSpeed','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',0,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1),(30,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|*||*|*|*|operSt','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',0,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1),(32,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|*|*|online','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',0,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1),(35,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|*|*|*|reading','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',0,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1),(36,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|*|*|*|readingcelsius','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',0,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1),(37,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|*|*|*|readingvolts','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',0,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1),(38,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|*|*|*|lastpoweroutputwatts','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',0,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1),(39,'Application Infrastructure Performance|Root\\|CG61\\|CSR1|Individual Nodes|Rack1|Custom Metrics|*|*|*|lineinputvoltage','GET','Server & Infrastructure Monitoring/metric-data?metric-path=','metric_data',0,0,'{\r\n\"metricId\":\"metricId\",\r\n\"metricName\":\"metricName\",\r\n\"metricPath\":\"metricPath\",\r\n\"frequency\":\"frequency\",\r\n\"metricValues\":\"metricValues\"\r\n}','metric_data',1,1);

/*Table structure for table `terminals` */

DROP TABLE IF EXISTS `terminals`;

CREATE TABLE `terminals` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `ip` varchar(15) DEFAULT '192.168.111.111',
  `x` int(8) DEFAULT 0,
  `y` int(8) DEFAULT 0,
  `angle` int(2) DEFAULT 0,
  `style` varchar(20) DEFAULT 'key-style-0',
  `new_style` varchar(20) DEFAULT NULL,
  `tenant` varchar(30) DEFAULT NULL,
  `new_tenant` varchar(30) DEFAULT NULL,
  `type` int(1) DEFAULT 1,
  `state` int(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

/*Data for the table `terminals` */

insert  into `terminals`(`id`,`name`,`description`,`ip`,`x`,`y`,`angle`,`style`,`new_style`,`tenant`,`new_tenant`,`type`,`state`) values (1,'EWS','EWS','192.168.111.111',10,2,270,'',NULL,'',NULL,1,NULL),(2,'EWCO','EWCO','192.168.111.111',10,10,270,'',NULL,'',NULL,2,0),(4,'IDS','IDS','192.168.111.111',10,17,270,'',NULL,'',NULL,1,0),(5,'TIC','TIC','192.168.111.111',10,25,270,'',NULL,'',NULL,1,0),(6,'RSC','RSC','192.168.111.111',10,33,270,'',NULL,'',NULL,1,0),(7,'CSC','CSC','192.168.111.111',30,10,0,'',NULL,'','',1,0),(8,'CO/TAO','CO/TAO','192.168.111.111',40,10,0,'',NULL,'','',1,0),(9,'CO/TAO','CO/TAO','192.168.111.111',50,10,0,'key-style-3','','common','',1,0),(10,'OSDA','OSDA','192.168.111.111',60,10,0,'key-style-3','','common','',1,0),(11,'TWS.4','TWS.4','192.168.111.111',68,5,0,'','','','',2,0),(12,'TWS.3','TWS.3','192.168.111.111',75,5,0,'',NULL,'',NULL,2,0),(13,'OSDA','OSDA','192.168.111.111',85,2,90,'',NULL,'',NULL,2,0),(14,'TWS.2','TWS.2','192.168.111.111',85,10,90,'',NULL,'',NULL,2,0),(15,'TWS.1','TWS.1','192.168.111.111',85,18,90,'',NULL,'',NULL,2,0),(16,'GECO','GECO','192.168.111.111',85,25,90,'',NULL,'',NULL,1,0),(17,'GFCS','GFCS)','192.168.111.111',85,34,90,'',NULL,'',NULL,1,0),(18,'AWS','AWS','192.168.111.111',38,25,90,'key-style-2','','mgmt','',1,0),(19,'SWS','SWS','192.168.111.111',55,20,270,'',NULL,'',NULL,1,0),(20,'ASUWC','ASUWC','192.168.111.111',55,30,270,'',NULL,'',NULL,1,0),(21,'MSS','MSS','192.168.111.111',20,40,180,'',NULL,'',NULL,1,0),(22,'PWS','PWS','192.168.111.111',33,40,180,'',NULL,'',NULL,2,0),(23,'AAWC','AAWC','192.168.111.111',41,40,180,'',NULL,'',NULL,1,0),(24,'AIC','AIC','192.168.111.111',49,40,180,'',NULL,'',NULL,1,0),(25,'ASTAC','ASTAC','192.168.111.111',57,40,180,'',NULL,'',NULL,1,0),(26,'ASWC','ASWC','192.168.111.111',65,40,180,'',NULL,'',NULL,1,0),(27,'ATS/FCO','ATS/FCO','192.168.111.111',73,40,180,'',NULL,'',NULL,1,0);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `level` int(8) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`level`) values (1,'admin','19c82f0f782b955128cacbee0db146b2',0),(2,'manage','19c82f0f782b955128cacbee0db146b2',1),(3,'api','19c82f0f782b955128cacbee0db146b2',3),(4,'aci','19c82f0f782b955128cacbee0db146b2',2);

/*Table structure for table `widget_config` */

DROP TABLE IF EXISTS `widget_config`;

CREATE TABLE `widget_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `sql` text DEFAULT NULL,
  `config` text DEFAULT NULL,
  `widget` varchar(30) DEFAULT NULL,
  `test` enum('a','b','c') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

/*Data for the table `widget_config` */

insert  into `widget_config`(`id`,`name`,`sql`,`config`,`widget`,`test`) values (22,'fan_data',' ',' {\r\n   \r\n   \"values\":{\r\n      \"val\":\"value\",\r\n      \"min\":\"min\",\r\n      \"max\":\"max\"\r\n   },\r\n   \"icon\":\"fa fa-thermometer-full\"\r\n}','traffic',NULL),(24,'power',NULL,'{\r\n   \r\n   \"values\":{\r\n      \"val\":\"value\",\r\n      \"min\":\"min\",\r\n      \"max\":\"max\"\r\n   },\r\n   \"icon\":\"fas fa-battery-full\"\r\n}','traffic',NULL),(25,'ship',NULL,NULL,'ship',NULL),(27,'status',NULL,'{\r\n   \r\n   \"values\":{\r\n      \"val\":\"value\",\r\n      \"min\":\"min\",\r\n      \"max\":\"max\"\r\n   },\r\n   \"icon\":\"fa fa-power-off\"\r\n}','traffic',NULL),(28,'online',NULL,'{\r\n   \r\n   \"values\":{\r\n      \"val\":\"value\",\r\n      \"min\":\"min\",\r\n      \"max\":\"max\"\r\n   },\r\n   \"icon\":\"fa fa-power-off\"\r\n}','traffic',NULL),(29,'lineinputvoltage',NULL,'{\r\n   \r\n   \"values\":{\r\n      \"val\":\"value\",\r\n      \"min\":\"min\",\r\n      \"max\":\"max\"\r\n   },\r\n   \"icon\":\"fas fa-battery-full\"\r\n}','traffic',NULL),(30,'lastpoweroutputwatts',NULL,'{\r\n   \r\n   \"values\":{\r\n      \"val\":\"value\",\r\n      \"min\":\"min\",\r\n      \"max\":\"max\"\r\n   },\r\n   \"icon\":\"fas fa-battery-full\"\r\n}','traffic',NULL),(31,'readingvolts',NULL,'{\r\n   \r\n   \"values\":{\r\n      \"val\":\"value\",\r\n      \"min\":\"min\",\r\n      \"max\":\"max\"\r\n   },\r\n   \"icon\":\"fas fa-battery-full\"\r\n}','traffic',NULL),(32,'readingcelsius',NULL,'{\r\n   \r\n   \"values\":{\r\n      \"val\":\"value\",\r\n      \"min\":\"min\",\r\n      \"max\":\"max\"\r\n   },\r\n   \"icon\":\"fa fa-thermometer-full\"\r\n}','traffic',NULL),(33,'reading',NULL,'{\r\n   \r\n   \"values\":{\r\n      \"val\":\"value\",\r\n      \"min\":\"min\",\r\n      \"max\":\"max\"\r\n   },\r\n   \"icon\":\"fa fa-thermometer-full\"\r\n}','traffic',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
