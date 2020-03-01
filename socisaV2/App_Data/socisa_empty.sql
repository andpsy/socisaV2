CREATE DATABASE  IF NOT EXISTS `socisa` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `socisa`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: socisa
-- ------------------------------------------------------
-- Server version	5.7.10-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(250) NOT NULL,
  `SUMMARY` text,
  `IMG` varchar(250) DEFAULT NULL,
  `ACTION` varchar(250) NOT NULL,
  `OBJECT_NAME` varchar(100) DEFAULT NULL,
  `TYPE` varchar(100) DEFAULT NULL,
  `ORDER` int(10) unsigned DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `PARENT_ID` int(10) unsigned DEFAULT NULL,
  `DIV_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `actions_log`
--

DROP TABLE IF EXISTS `actions_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions_log` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AUTHENTICATED_USER` varchar(250) DEFAULT NULL,
  `AUTHENTICATED_USER_ID` int(10) unsigned DEFAULT NULL,
  `REDIS_CLIENT_ID` varchar(250) DEFAULT NULL,
  `MESSAGE_ID` varchar(250) DEFAULT NULL,
  `CORRELATION_ID` varchar(250) DEFAULT NULL,
  `COMMAND_PREDICATE` varchar(250) DEFAULT NULL,
  `COMMAND_OBJECT_REPOSITORY` varchar(250) DEFAULT NULL,
  `COMMAND_ARGUMENTS` text,
  `DATA` datetime DEFAULT NULL,
  `STATUS` tinyint(1) DEFAULT NULL,
  `MESSAGE` text,
  `RESULT` text,
  `INSERTED_ID` int(10) unsigned DEFAULT NULL,
  `ERRORS` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `asigurati`
--

DROP TABLE IF EXISTS `asigurati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asigurati` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(250) NOT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Index_2` (`DENUMIRE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=303 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auto`
--

DROP TABLE IF EXISTS `auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auto` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NR_AUTO` varchar(45) NOT NULL,
  `SERIE_SASIU` varchar(50) DEFAULT NULL,
  `MARCA` varchar(45) DEFAULT NULL,
  `MODEL` varchar(45) DEFAULT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Index_2` (`NR_AUTO`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compensari`
--

DROP TABLE IF EXISTS `compensari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compensari` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_DOSAR_RCA` int(10) unsigned NOT NULL,
  `ID_DOSAR_CASCO` int(10) unsigned NOT NULL,
  `SUMA` double NOT NULL,
  `DATA` datetime NOT NULL,
  `PAS` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_COMPENSARI_1` (`ID_DOSAR_RCA`),
  KEY `FK_COMPENSARI_2` (`ID_DOSAR_CASCO`),
  CONSTRAINT `FK_COMPENSARI_1` FOREIGN KEY (`ID_DOSAR_RCA`) REFERENCES `dosare` (`ID`),
  CONSTRAINT `FK_COMPENSARI_2` FOREIGN KEY (`ID_DOSAR_CASCO`) REFERENCES `dosare` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `complete`
--

DROP TABLE IF EXISTS `complete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complete` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(250) NOT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`DENUMIRE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contracte`
--

DROP TABLE IF EXISTS `contracte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contracte` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NR_CONTRACT` varchar(45) NOT NULL,
  `DATA_CONTRACT` datetime DEFAULT NULL,
  `OBSERVATII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`NR_CONTRACT`,`DATA_CONTRACT`),
  KEY `Index_2` (`NR_CONTRACT`),
  KEY `Index_3` (`DATA_CONTRACT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contracte_plati_contracte`
--

DROP TABLE IF EXISTS `contracte_plati_contracte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contracte_plati_contracte` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CONTRACT` int(10) unsigned NOT NULL,
  `ID_PLATA_CONTRACT` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_CONTRACT`,`ID_PLATA_CONTRACT`),
  KEY `FK_CONTRACTE_PLATI_CONTRACTE_1` (`ID_CONTRACT`),
  KEY `FK_CONTRACTE_PLATI_CONTRACTE_2` (`ID_PLATA_CONTRACT`),
  CONSTRAINT `FK_CONTRACTE_PLATI_CONTRACTE_1` FOREIGN KEY (`ID_CONTRACT`) REFERENCES `contracte` (`ID`),
  CONSTRAINT `FK_CONTRACTE_PLATI_CONTRACTE_2` FOREIGN KEY (`ID_PLATA_CONTRACT`) REFERENCES `plati_contracte` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documente_scanate`
--

DROP TABLE IF EXISTS `documente_scanate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documente_scanate` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE_FISIER` varchar(250) NOT NULL,
  `EXTENSIE_FISIER` varchar(5) NOT NULL,
  `DATA_INCARCARE` datetime DEFAULT NULL,
  `DIMENSIUNE_FISIER` int(10) unsigned DEFAULT NULL,
  `ID_TIP_DOCUMENT` int(10) unsigned NOT NULL,
  `ID_DOSAR` int(10) unsigned NOT NULL,
  `DETALII` text,
  `VIZA_CASCO` tinyint(1) DEFAULT '0',
  `FILE_CONTENT` longblob,
  `SMALL_ICON` blob,
  `MEDIUM_ICON` blob,
  `CALE_FISIER` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Index_2` (`DENUMIRE_FISIER`),
  KEY `FK_documente_scanate_2` (`ID_DOSAR`),
  KEY `Index_5` (`ID_TIP_DOCUMENT`,`ID_DOSAR`) USING BTREE,
  KEY `Index_6` (`CALE_FISIER`),
  KEY `Index_7` (`VIZA_CASCO`),
  KEY `Index_8` (`ID_TIP_DOCUMENT`),
  CONSTRAINT `FK_documente_scanate_1` FOREIGN KEY (`ID_TIP_DOCUMENT`) REFERENCES `tip_document` (`ID`),
  CONSTRAINT `FK_documente_scanate_2` FOREIGN KEY (`ID_DOSAR`) REFERENCES `dosare` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dosare`
--

DROP TABLE IF EXISTS `dosare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dosare` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NR_SCA` varchar(100) DEFAULT NULL,
  `DATA_SCA` datetime DEFAULT NULL,
  `ID_ASIGURAT_CASCO` int(10) unsigned DEFAULT NULL,
  `NR_POLITA_CASCO` varchar(100) DEFAULT NULL,
  `ID_AUTO_CASCO` int(10) unsigned DEFAULT NULL,
  `ID_SOCIETATE_CASCO` int(10) unsigned DEFAULT NULL,
  `NR_POLITA_RCA` varchar(100) DEFAULT NULL,
  `ID_AUTO_RCA` int(10) unsigned DEFAULT NULL,
  `VALOARE_DAUNA` double DEFAULT NULL,
  `VALOARE_REGRES` double DEFAULT NULL,
  `ID_INTERVENIENT` int(10) unsigned DEFAULT NULL,
  `NR_DOSAR_CASCO` varchar(100) DEFAULT NULL,
  `VMD` double DEFAULT NULL,
  `OBSERVATII` text,
  `ID_SOCIETATE_RCA` int(10) unsigned DEFAULT NULL,
  `DATA_EVENIMENT` datetime DEFAULT NULL,
  `REZERVA_DAUNA` double DEFAULT NULL,
  `DATA_INTRARE_RCA` datetime DEFAULT NULL,
  `DATA_IESIRE_CASCO` datetime DEFAULT NULL,
  `NR_INTRARE_RCA` varchar(100) DEFAULT NULL,
  `NR_IESIRE_CASCO` varchar(100) DEFAULT NULL,
  `ID_ASIGURAT_RCA` int(10) unsigned DEFAULT NULL,
  `ID_TIP_DOSAR` int(10) unsigned DEFAULT NULL,
  `SUMA_IBNR` double DEFAULT NULL,
  `DATA_AVIZARE` datetime DEFAULT NULL,
  `DATA_NOTIFICARE` datetime DEFAULT NULL,
  `DATA_ULTIMEI_MODIFICARI` datetime DEFAULT NULL,
  `AVIZAT` tinyint(1) DEFAULT '0',
  `CAZ` varchar(100) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `DATA_CREARE` datetime DEFAULT NULL,
  `LOC_ACCIDENT` text,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_7` (`NR_DOSAR_CASCO`) USING BTREE,
  KEY `FK_dosare_3` (`ID_INTERVENIENT`),
  KEY `FK_dosare_2` (`ID_SOCIETATE_CASCO`) USING BTREE,
  KEY `FK_dosare_4` (`ID_SOCIETATE_RCA`),
  KEY `FK_dosare_5` (`ID_AUTO_CASCO`),
  KEY `FK_dosare_6` (`ID_AUTO_RCA`),
  KEY `FK_dosare_1` (`ID_ASIGURAT_CASCO`) USING BTREE,
  KEY `FK_dosare_7` (`ID_ASIGURAT_RCA`),
  KEY `FK_dosare_8` (`ID_TIP_DOSAR`),
  CONSTRAINT `FK_dosare_2` FOREIGN KEY (`ID_SOCIETATE_CASCO`) REFERENCES `societati_asigurare` (`ID`),
  CONSTRAINT `FK_dosare_3` FOREIGN KEY (`ID_INTERVENIENT`) REFERENCES `intervenienti` (`ID`),
  CONSTRAINT `FK_dosare_4` FOREIGN KEY (`ID_SOCIETATE_RCA`) REFERENCES `societati_asigurare` (`ID`),
  CONSTRAINT `FK_dosare_5` FOREIGN KEY (`ID_AUTO_CASCO`) REFERENCES `auto` (`ID`),
  CONSTRAINT `FK_dosare_6` FOREIGN KEY (`ID_AUTO_RCA`) REFERENCES `auto` (`ID`),
  CONSTRAINT `FK_dosare_7` FOREIGN KEY (`ID_ASIGURAT_RCA`) REFERENCES `asigurati` (`ID`),
  CONSTRAINT `FK_dosare_8` FOREIGN KEY (`ID_TIP_DOSAR`) REFERENCES `tip_dosare` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=467 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dosare_plati`
--

DROP TABLE IF EXISTS `dosare_plati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dosare_plati` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_DOSAR` int(10) unsigned NOT NULL,
  `ID_PLATA` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_DOSAR`,`ID_PLATA`),
  KEY `FK_DOSARE_PLATI_1` (`ID_DOSAR`),
  KEY `FK_DOSARE_PLATI_2` (`ID_PLATA`),
  CONSTRAINT `FK_DOSARE_PLATI_1` FOREIGN KEY (`ID_DOSAR`) REFERENCES `dosare` (`ID`),
  CONSTRAINT `FK_DOSARE_PLATI_2` FOREIGN KEY (`ID_PLATA`) REFERENCES `plati` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dosare_plati_contracte`
--

DROP TABLE IF EXISTS `dosare_plati_contracte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dosare_plati_contracte` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_DOSAR` int(10) unsigned NOT NULL,
  `ID_PLATA_CONTRACT` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_DOSAR`,`ID_PLATA_CONTRACT`),
  KEY `FK_DOSARE_PLATI_CONTRACTE_1` (`ID_DOSAR`),
  KEY `FK_DOSARE_PLATI_CONTRACTE_2` (`ID_PLATA_CONTRACT`),
  CONSTRAINT `FK_DOSARE_PLATI_CONTRACTE_1` FOREIGN KEY (`ID_DOSAR`) REFERENCES `dosare` (`ID`),
  CONSTRAINT `FK_DOSARE_PLATI_CONTRACTE_2` FOREIGN KEY (`ID_PLATA_CONTRACT`) REFERENCES `plati_contracte` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=38 PACK_KEYS=0 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dosare_portal`
--

DROP TABLE IF EXISTS `dosare_portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dosare_portal` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NR_DOSAR` varchar(100) NOT NULL,
  `DATA` datetime NOT NULL,
  `DATA_SEDINTA` datetime NOT NULL,
  `ID_DOSAR` int(10) unsigned NOT NULL,
  `NR_SCA` int(10) unsigned DEFAULT NULL,
  `DATA_SCA` datetime DEFAULT NULL,
  `INSTANTA` varchar(100) DEFAULT NULL,
  `ORA` varchar(45) DEFAULT NULL,
  `COMPLET` varchar(100) DEFAULT NULL,
  `MONITORIZARE` tinyint(1) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Index_2` (`NR_DOSAR`),
  KEY `Index_3` (`DATA`),
  KEY `Index_4` (`DATA_SEDINTA`),
  KEY `Index_5` (`ID_DOSAR`) USING BTREE,
  CONSTRAINT `FK_dosare_portal_1` FOREIGN KEY (`ID_DOSAR`) REFERENCES `dosare` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dosare_procese`
--

DROP TABLE IF EXISTS `dosare_procese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dosare_procese` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_DOSAR` int(10) unsigned NOT NULL,
  `ID_PROCES` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_DOSAR`,`ID_PROCES`),
  KEY `FK_DOSARE_PROCESE_1` (`ID_DOSAR`),
  KEY `FK_DOSARE_PROCESE_2` (`ID_PROCES`),
  CONSTRAINT `FK_DOSARE_PROCESE_1` FOREIGN KEY (`ID_DOSAR`) REFERENCES `dosare` (`ID`),
  CONSTRAINT `FK_DOSARE_PROCESE_2` FOREIGN KEY (`ID_PROCES`) REFERENCES `procese` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dosare_stadii`
--

DROP TABLE IF EXISTS `dosare_stadii`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dosare_stadii` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_DOSAR` int(10) unsigned NOT NULL,
  `ID_STADIU` int(10) unsigned DEFAULT NULL,
  `TERMEN` datetime DEFAULT NULL,
  `OBSERVATII` text,
  `DATA` datetime DEFAULT NULL,
  `SCADENTA` datetime DEFAULT NULL,
  `ORA` varchar(5) DEFAULT NULL,
  `TERMEN_ADMINISTRATIV` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_7` (`ID_DOSAR`,`ID_STADIU`,`DATA`),
  KEY `FK_DOSARE_CONCILIERI_1` (`ID_DOSAR`),
  KEY `FK_DOSARE_CONCILIERI_2` (`ID_STADIU`) USING BTREE,
  KEY `Index_4` (`DATA`),
  KEY `Index_5` (`TERMEN`),
  KEY `Index_6` (`ID_DOSAR`,`DATA`),
  CONSTRAINT `FK_DOSARE_CONCILIERI_1` FOREIGN KEY (`ID_DOSAR`) REFERENCES `dosare` (`ID`),
  CONSTRAINT `FK_DOSARE_CONCILIERI_2` FOREIGN KEY (`ID_STADIU`) REFERENCES `stadii` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dosare_stadii_sentinte`
--

DROP TABLE IF EXISTS `dosare_stadii_sentinte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dosare_stadii_sentinte` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_DOSAR_STADIU` int(10) unsigned NOT NULL,
  `ID_SENTINTA` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_DOSAR_STADIU`,`ID_SENTINTA`),
  KEY `FK_dosare_stadii_sentinte_1` (`ID_DOSAR_STADIU`),
  KEY `FK_dosare_stadii_sentinte_2` (`ID_SENTINTA`),
  CONSTRAINT `FK_dosare_stadii_sentinte_1` FOREIGN KEY (`ID_DOSAR_STADIU`) REFERENCES `dosare_stadii` (`ID`),
  CONSTRAINT `FK_dosare_stadii_sentinte_2` FOREIGN KEY (`ID_SENTINTA`) REFERENCES `sentinte` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drepturi`
--

DROP TABLE IF EXISTS `drepturi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drepturi` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(250) NOT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`DENUMIRE`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_notifications`
--

DROP TABLE IF EXISTS `email_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_notifications` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MESSAGE_ID` varchar(100) NOT NULL,
  `MESSAGE_TEXT` text NOT NULL,
  `SEND` tinyint(1) DEFAULT NULL,
  `SEND_TIMESTAMP` datetime DEFAULT NULL,
  `DELIVERY` tinyint(1) DEFAULT NULL,
  `DELIVERY_TIMESTAMP` datetime DEFAULT NULL,
  `REJECT` tinyint(1) DEFAULT NULL,
  `REJECT_TIMESTAMP` datetime DEFAULT NULL,
  `BOUNCE` tinyint(1) DEFAULT NULL,
  `BOUNCE_TIMESTAMP` datetime DEFAULT NULL,
  `OPEN` tinyint(1) DEFAULT NULL,
  `OPEN_TIMESTAMP` datetime DEFAULT NULL,
  `CLICK` tinyint(1) DEFAULT NULL,
  `CLICK_TIMESTAMP` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `COMPLAINT` tinyint(1) DEFAULT NULL,
  `COMPLAINT_TIMESTAMP` datetime DEFAULT NULL,
  `ID_DOSAR` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`MESSAGE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `import_documente_scanate_log`
--

DROP TABLE IF EXISTS `import_documente_scanate_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_documente_scanate_log` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DATA_IMPORT` datetime NOT NULL,
  `STATUS` tinyint(1) DEFAULT NULL,
  `MESSAGE` text,
  `INSERTED_ID` int(10) unsigned DEFAULT NULL,
  `ERRORS` text,
  `deleted` tinyint(1) DEFAULT NULL,
  `IMPORT_TYPE` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `import_log`
--

DROP TABLE IF EXISTS `import_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_log` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DATA_IMPORT` datetime NOT NULL,
  `STATUS` tinyint(1) DEFAULT NULL,
  `MESSAGE` text,
  `INSERTED_ID` int(10) unsigned DEFAULT NULL,
  `ERRORS` text,
  `deleted` tinyint(1) DEFAULT NULL,
  `IMPORT_TYPE` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=476 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instante`
--

DROP TABLE IF EXISTS `instante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instante` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(250) NOT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`DENUMIRE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intervenienti`
--

DROP TABLE IF EXISTS `intervenienti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intervenienti` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(250) NOT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Index_2` (`DENUMIRE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DATA` datetime NOT NULL,
  `ACTIUNE` varchar(50) NOT NULL,
  `TABELA` varchar(50) NOT NULL,
  `DETALII_BEFORE` text NOT NULL,
  `ID_UTILIZATOR` int(10) unsigned NOT NULL,
  `DETALII_AFTER` text NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_log_1` (`ID_UTILIZATOR`),
  CONSTRAINT `FK_log_1` FOREIGN KEY (`ID_UTILIZATOR`) REFERENCES `utilizatori` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2409 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mesaje`
--

DROP TABLE IF EXISTS `mesaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mesaje` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_SENDER` int(10) unsigned NOT NULL,
  `SUBIECT` varchar(250) DEFAULT NULL,
  `BODY` text,
  `DATA` datetime NOT NULL,
  `ID_DOSAR` int(10) unsigned DEFAULT NULL,
  `IMPORTANTA` int(10) unsigned DEFAULT NULL,
  `ID_TIP_MESAJ` int(10) unsigned DEFAULT NULL COMMENT 'VALOARE DIN NOMENCLATOR: SOLICITARE DOCUMENTE, DIMINUARE SUMA, EPIRARE ETC.',
  `deleted` tinyint(1) DEFAULT NULL,
  `REPLY_TO` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_mesaje_1` (`ID_DOSAR`),
  KEY `Index_3` (`SUBIECT`),
  KEY `Index_5` (`DATA`),
  KEY `FK_mesaje_2` (`ID_SENDER`),
  KEY `FK_mesaje_4` (`ID_TIP_MESAJ`),
  FULLTEXT KEY `Index_4` (`BODY`),
  CONSTRAINT `FK_mesaje_1` FOREIGN KEY (`ID_DOSAR`) REFERENCES `dosare` (`ID`),
  CONSTRAINT `FK_mesaje_2` FOREIGN KEY (`ID_SENDER`) REFERENCES `utilizatori` (`ID`),
  CONSTRAINT `FK_mesaje_4` FOREIGN KEY (`ID_TIP_MESAJ`) REFERENCES `tip_mesaje` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mesaje_utilizatori`
--

DROP TABLE IF EXISTS `mesaje_utilizatori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mesaje_utilizatori` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_MESAJ` int(10) unsigned NOT NULL,
  `ID_UTILIZATOR` int(10) unsigned NOT NULL,
  `DATA_CITIRE` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_MESAJ`,`ID_UTILIZATOR`),
  KEY `FK_mesaje_utilizatori_2` (`ID_UTILIZATOR`),
  CONSTRAINT `FK_mesaje_utilizatori_1` FOREIGN KEY (`ID_MESAJ`) REFERENCES `mesaje` (`ID`),
  CONSTRAINT `FK_mesaje_utilizatori_2` FOREIGN KEY (`ID_UTILIZATOR`) REFERENCES `utilizatori` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pending_documente_scanate_imports`
--

DROP TABLE IF EXISTS `pending_documente_scanate_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pending_documente_scanate_imports` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE_FISIER` varchar(250) NOT NULL,
  `EXTENSIE_FISIER` varchar(5) NOT NULL,
  `DATA_INCARCARE` datetime DEFAULT NULL,
  `DIMENSIUNE_FISIER` int(10) unsigned DEFAULT NULL,
  `ID_TIP_DOCUMENT` int(10) unsigned NOT NULL,
  `ID_DOSAR` int(10) unsigned NOT NULL,
  `DETALII` text,
  `VIZA_CASCO` tinyint(1) DEFAULT '0',
  `FILE_CONTENT` longblob,
  `SMALL_ICON` blob,
  `MEDIUM_ICON` blob,
  `CALE_FISIER` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Index_2` (`DENUMIRE_FISIER`),
  KEY `FK_documente_scanate_2` (`ID_DOSAR`),
  KEY `Index_5` (`ID_TIP_DOCUMENT`,`ID_DOSAR`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pending_import_errors`
--

DROP TABLE IF EXISTS `pending_import_errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pending_import_errors` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NR_SCA` varchar(100) DEFAULT NULL,
  `DATA_SCA` datetime DEFAULT NULL,
  `ID_ASIGURAT_CASCO` int(10) unsigned DEFAULT NULL,
  `NR_POLITA_CASCO` varchar(100) DEFAULT NULL,
  `ID_AUTO_CASCO` int(10) unsigned DEFAULT NULL,
  `ID_SOCIETATE_CASCO` int(10) unsigned DEFAULT NULL,
  `NR_POLITA_RCA` varchar(100) DEFAULT NULL,
  `ID_AUTO_RCA` int(10) unsigned DEFAULT NULL,
  `VALOARE_DAUNA` double DEFAULT NULL,
  `VALOARE_REGRES` double DEFAULT NULL,
  `ID_INTERVENIENT` int(10) unsigned DEFAULT NULL,
  `NR_DOSAR_CASCO` varchar(100) DEFAULT NULL,
  `VMD` double DEFAULT NULL,
  `OBSERVATII` text,
  `ID_SOCIETATE_RCA` int(10) unsigned DEFAULT NULL,
  `DATA_EVENIMENT` datetime DEFAULT NULL,
  `REZERVA_DAUNA` double DEFAULT NULL,
  `DATA_INTRARE_RCA` datetime DEFAULT NULL,
  `DATA_IESIRE_CASCO` datetime DEFAULT NULL,
  `NR_INTRARE_RCA` varchar(100) DEFAULT NULL,
  `NR_IESIRE_CASCO` varchar(100) DEFAULT NULL,
  `ID_ASIGURAT_RCA` int(10) unsigned DEFAULT NULL,
  `ID_TIP_DOSAR` int(10) unsigned DEFAULT NULL,
  `SUMA_IBNR` double DEFAULT NULL,
  `DATA_AVIZARE` datetime DEFAULT NULL,
  `DATA_NOTIFICARE` datetime DEFAULT NULL,
  `DATA_ULTIMEI_MODIFICARI` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `DATA_CREARE` datetime DEFAULT NULL,
  `AVIZAT` tinyint(1) DEFAULT NULL,
  `CAZ` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plati`
--

DROP TABLE IF EXISTS `plati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plati` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NR_DOCUMENT` varchar(50) DEFAULT NULL,
  `DATA_DOCUMENT` datetime DEFAULT NULL,
  `SUMA` double NOT NULL,
  `OBSERVATII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`NR_DOCUMENT`,`DATA_DOCUMENT`),
  KEY `Index_2` (`NR_DOCUMENT`),
  KEY `Index_3` (`DATA_DOCUMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plati_contracte`
--

DROP TABLE IF EXISTS `plati_contracte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plati_contracte` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NR_DOCUMENT` varchar(45) DEFAULT NULL,
  `DATA_DOCUMENT` datetime DEFAULT NULL,
  `SUMA` double NOT NULL,
  `OBSERVATII` text,
  `INCASAT_PE_AMIABIL` tinyint(1) DEFAULT NULL,
  `INCASAT_CONTRACT` tinyint(1) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`NR_DOCUMENT`,`DATA_DOCUMENT`),
  KEY `Index_2` (`NR_DOCUMENT`),
  KEY `Index_3` (`DATA_DOCUMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plati_taxa_timbru`
--

DROP TABLE IF EXISTS `plati_taxa_timbru`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plati_taxa_timbru` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NR_DOCUMENT` varchar(45) NOT NULL,
  `DATA_DOCUMENT` datetime DEFAULT NULL,
  `SUMA` double NOT NULL,
  `OBSERVATII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`NR_DOCUMENT`,`DATA_DOCUMENT`),
  KEY `Index_2` (`NR_DOCUMENT`),
  KEY `Index_3` (`DATA_DOCUMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procese`
--

DROP TABLE IF EXISTS `procese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procese` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NR_INTERN` int(10) unsigned DEFAULT NULL,
  `NR_DOSAR_INSTANTA` varchar(100) DEFAULT NULL,
  `DATA_DEPUNERE` datetime DEFAULT NULL,
  `OBSERVATII` text,
  `SUMA_SOLICITATA` double DEFAULT NULL,
  `PENALITATI` double DEFAULT NULL,
  `TAXA_TIMBRU` double DEFAULT NULL,
  `TIMBRU_JUDICIAR` double DEFAULT NULL,
  `ONORARIU_EXPERT` double DEFAULT NULL,
  `ONORARIU_AVOCAT` double DEFAULT NULL,
  `ID_INSTANTA` int(10) unsigned DEFAULT NULL,
  `ID_COMPLET` int(10) unsigned DEFAULT NULL,
  `ID_CONTRACT` int(10) unsigned DEFAULT NULL,
  `STADIU` varchar(250) DEFAULT NULL,
  `CHELTUIELI_MICA_PUBLICITATE` double DEFAULT NULL,
  `ONORARIU_CURATOR` double DEFAULT NULL,
  `ALTE_CHELTUIELI_JUDECATA` double DEFAULT NULL,
  `TAXA_TIMBRU_REEXAMINARE` double DEFAULT NULL,
  `NR_DOSAR_EXECUTARE` varchar(100) DEFAULT NULL,
  `DATA_EXECUTARE` datetime DEFAULT NULL,
  `ONORARIU_AVOCAT_EXECUTARE` double DEFAULT NULL,
  `CHELTUIELI_EXECUTARE` double DEFAULT NULL,
  `DESPAGUBIRE_ACORDATA` double DEFAULT NULL,
  `CHELTUIELI_JUDECATA_ACORDATE` double DEFAULT NULL,
  `MONITORIZARE` tinyint(1) DEFAULT NULL,
  `ID_TIP_PROCES` int(10) unsigned DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_7` (`NR_DOSAR_INSTANTA`) USING BTREE,
  UNIQUE KEY `Index_6` (`NR_INTERN`) USING BTREE,
  KEY `FK_procese_2` (`ID_INSTANTA`),
  KEY `FK_procese_3` (`ID_COMPLET`),
  KEY `FK_procese_4` (`ID_CONTRACT`),
  KEY `FK_procese_5` (`ID_TIP_PROCES`),
  CONSTRAINT `FK_procese_2` FOREIGN KEY (`ID_INSTANTA`) REFERENCES `instante` (`ID`),
  CONSTRAINT `FK_procese_3` FOREIGN KEY (`ID_COMPLET`) REFERENCES `complete` (`ID`),
  CONSTRAINT `FK_procese_4` FOREIGN KEY (`ID_CONTRACT`) REFERENCES `contracte` (`ID`),
  CONSTRAINT `FK_procese_5` FOREIGN KEY (`ID_TIP_PROCES`) REFERENCES `tip_procese` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procese_plati_taxa_timbru`
--

DROP TABLE IF EXISTS `procese_plati_taxa_timbru`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procese_plati_taxa_timbru` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PROCES` int(10) unsigned NOT NULL,
  `ID_PLATA_TAXA_TIMBRU` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_PROCES`,`ID_PLATA_TAXA_TIMBRU`),
  KEY `FK_procese_plati_taxa_timbru_2` (`ID_PLATA_TAXA_TIMBRU`),
  CONSTRAINT `FK_procese_plati_taxa_timbru_1` FOREIGN KEY (`ID_PROCES`) REFERENCES `procese` (`ID`),
  CONSTRAINT `FK_procese_plati_taxa_timbru_2` FOREIGN KEY (`ID_PLATA_TAXA_TIMBRU`) REFERENCES `plati_taxa_timbru` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sentinte`
--

DROP TABLE IF EXISTS `sentinte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sentinte` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NR_SENTINTA` varchar(45) NOT NULL,
  `DATA_SENTINTA` datetime NOT NULL,
  `DATA_COMUNICARE` datetime DEFAULT NULL,
  `SOLUTIE` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`NR_SENTINTA`,`DATA_SENTINTA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `setari`
--

DROP TABLE IF EXISTS `setari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setari` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NUME` varchar(100) NOT NULL,
  `VALOARE` varchar(100) NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`NUME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `societati_asigurare`
--

DROP TABLE IF EXISTS `societati_asigurare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `societati_asigurare` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(250) DEFAULT NULL,
  `DETALII` text,
  `CUI` varchar(45) DEFAULT NULL,
  `NR_REG_COM` varchar(45) DEFAULT NULL,
  `ADRESA` text,
  `BANCA` varchar(250) DEFAULT NULL,
  `IBAN` varchar(24) DEFAULT NULL,
  `SOLD` double DEFAULT NULL,
  `DATA_ULTIMEI_PLATI` datetime DEFAULT NULL,
  `TELEFON` varchar(100) DEFAULT NULL,
  `REPREZENTANT_FISCAL` varchar(250) DEFAULT NULL,
  `DENUMIRE_SCURTA` varchar(100) NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `EMAIL_NOTIFICARI` varchar(100) DEFAULT NULL,
  `ID_TEMPLATE_NOTIFICARI` int(10) unsigned DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`DENUMIRE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stadii`
--

DROP TABLE IF EXISTS `stadii`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stadii` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(250) NOT NULL,
  `DETALII` text,
  `ICON_PATH` varchar(250) DEFAULT NULL,
  `PAS` int(10) unsigned DEFAULT NULL,
  `STADIU_INSTANTA` tinyint(1) DEFAULT NULL,
  `STADIU_CU_TERMEN` tinyint(1) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`DENUMIRE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stadii_scadente`
--

DROP TABLE IF EXISTS `stadii_scadente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stadii_scadente` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_STADIU` int(10) unsigned NOT NULL,
  `ID_SETARE` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_stadii_scadente_1` (`ID_STADIU`),
  KEY `FK_stadii_scadente_2` (`ID_SETARE`),
  CONSTRAINT `FK_stadii_scadente_1` FOREIGN KEY (`ID_STADIU`) REFERENCES `stadii` (`ID`),
  CONSTRAINT `FK_stadii_scadente_2` FOREIGN KEY (`ID_SETARE`) REFERENCES `setari` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stadii_setari`
--

DROP TABLE IF EXISTS `stadii_setari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stadii_setari` (
  `ID_SETARE` int(10) unsigned DEFAULT NULL,
  `ID_STADIU` int(10) unsigned DEFAULT NULL,
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `WARNING` varchar(250) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_SETARE`,`ID_STADIU`),
  KEY `FK_stadii_setari_1` (`ID_STADIU`),
  CONSTRAINT `FK_stadii_setari_1` FOREIGN KEY (`ID_STADIU`) REFERENCES `stadii` (`ID`),
  CONSTRAINT `FK_stadii_setari_2` FOREIGN KEY (`ID_SETARE`) REFERENCES `setari` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templates` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE_FISIER` varchar(100) NOT NULL,
  `EXTENSIE_FISIER` varchar(10) NOT NULL,
  `FILE_CONTENT` longblob,
  `DIMENSIUNE_FISIER` int(10) unsigned NOT NULL,
  `DETALII` text NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tip_caz`
--

DROP TABLE IF EXISTS `tip_caz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tip_caz` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(100) NOT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tip_document`
--

DROP TABLE IF EXISTS `tip_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tip_document` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(250) CHARACTER SET utf8 NOT NULL,
  `DETALII` text CHARACTER SET utf8,
  `QINFO` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `MANDATORY` tinyint(1) DEFAULT '0',
  `DISPLAY_ORDER` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`DENUMIRE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_romanian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tip_dosare`
--

DROP TABLE IF EXISTS `tip_dosare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tip_dosare` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(100) NOT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`DENUMIRE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tip_mesaje`
--

DROP TABLE IF EXISTS `tip_mesaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tip_mesaje` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(100) NOT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`DENUMIRE`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tip_procese`
--

DROP TABLE IF EXISTS `tip_procese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tip_procese` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(100) NOT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`DENUMIRE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tip_utilizatori`
--

DROP TABLE IF EXISTS `tip_utilizatori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tip_utilizatori` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DENUMIRE` varchar(250) NOT NULL,
  `DETALII` text,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`DENUMIRE`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utilizatori`
--

DROP TABLE IF EXISTS `utilizatori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilizatori` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(45) DEFAULT NULL,
  `NUME_COMPLET` varchar(250) DEFAULT NULL,
  `DETALII` text,
  `IS_ONLINE` tinyint(1) DEFAULT NULL,
  `EMAIL` varchar(150) DEFAULT NULL,
  `IP` varchar(15) DEFAULT NULL,
  `MAC` varchar(100) DEFAULT NULL,
  `ID_TIP_UTILIZATOR` int(10) unsigned NOT NULL,
  `LAST_REFRESH` datetime DEFAULT NULL,
  `DEPARTAMENT` varchar(100) DEFAULT NULL,
  `ID_SOCIETATE` int(10) unsigned DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `LAST_LOGIN` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`USER_NAME`),
  KEY `FK_utilizatori_1` (`ID_SOCIETATE`),
  KEY `FK_utilizatori_2` (`ID_TIP_UTILIZATOR`),
  CONSTRAINT `FK_utilizatori_1` FOREIGN KEY (`ID_SOCIETATE`) REFERENCES `societati_asigurare` (`ID`),
  CONSTRAINT `FK_utilizatori_2` FOREIGN KEY (`ID_TIP_UTILIZATOR`) REFERENCES `tip_utilizatori` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utilizatori_actions`
--

DROP TABLE IF EXISTS `utilizatori_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilizatori_actions` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_UTILIZATOR` int(10) unsigned NOT NULL,
  `ID_ACTION` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_UTILIZATOR`,`ID_ACTION`),
  KEY `FK_utilizatori_actions_2` (`ID_ACTION`),
  CONSTRAINT `FK_utilizatori_actions_1` FOREIGN KEY (`ID_UTILIZATOR`) REFERENCES `utilizatori` (`ID`),
  CONSTRAINT `FK_utilizatori_actions_2` FOREIGN KEY (`ID_ACTION`) REFERENCES `actions` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utilizatori_dosare`
--

DROP TABLE IF EXISTS `utilizatori_dosare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilizatori_dosare` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_UTILIZATOR` int(10) unsigned NOT NULL,
  `ID_DOSAR` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_UTILIZATOR`,`ID_DOSAR`),
  KEY `FK_UTILIZATORI_DOSARE_1` (`ID_UTILIZATOR`),
  KEY `FK_UTILIZATORI_DOSARE_2` (`ID_DOSAR`),
  CONSTRAINT `FK_UTILIZATORI_DOSARE_1` FOREIGN KEY (`ID_UTILIZATOR`) REFERENCES `utilizatori` (`ID`),
  CONSTRAINT `FK_UTILIZATORI_DOSARE_2` FOREIGN KEY (`ID_DOSAR`) REFERENCES `dosare` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utilizatori_drepturi`
--

DROP TABLE IF EXISTS `utilizatori_drepturi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilizatori_drepturi` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_UTILIZATOR` int(10) unsigned NOT NULL,
  `ID_DREPT` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_UTILIZATOR`,`ID_DREPT`),
  KEY `FK_UTILIZATORI_DREPTURI_1` (`ID_UTILIZATOR`),
  KEY `FK_UTILIZATORI_DREPTURI_2` (`ID_DREPT`),
  CONSTRAINT `FK_UTILIZATORI_DREPTURI_1` FOREIGN KEY (`ID_UTILIZATOR`) REFERENCES `utilizatori` (`ID`),
  CONSTRAINT `FK_UTILIZATORI_DREPTURI_2` FOREIGN KEY (`ID_DREPT`) REFERENCES `drepturi` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utilizatori_setari`
--

DROP TABLE IF EXISTS `utilizatori_setari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilizatori_setari` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_UTILIZATOR` int(10) unsigned NOT NULL,
  `ID_SETARE` int(10) unsigned NOT NULL,
  `VALOARE` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_UTILIZATOR`,`ID_SETARE`),
  KEY `FK_utilizatori_setari_1` (`ID_UTILIZATOR`),
  KEY `FK_utilizatori_setari_2` (`ID_SETARE`),
  CONSTRAINT `FK_utilizatori_setari_1` FOREIGN KEY (`ID_UTILIZATOR`) REFERENCES `utilizatori` (`ID`),
  CONSTRAINT `FK_utilizatori_setari_2` FOREIGN KEY (`ID_SETARE`) REFERENCES `setari` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2048 PACK_KEYS=0 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utilizatori_societati`
--

DROP TABLE IF EXISTS `utilizatori_societati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilizatori_societati` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_UTILIZATOR` int(10) unsigned NOT NULL,
  `ID_SOCIETATE` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_UTILIZATOR`,`ID_SOCIETATE`),
  KEY `FK_utilizatori_societati_2` (`ID_SOCIETATE`),
  CONSTRAINT `FK_utilizatori_societati_1` FOREIGN KEY (`ID_UTILIZATOR`) REFERENCES `utilizatori` (`ID`),
  CONSTRAINT `FK_utilizatori_societati_2` FOREIGN KEY (`ID_SOCIETATE`) REFERENCES `societati_asigurare` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utilizatori_societati_administrate`
--

DROP TABLE IF EXISTS `utilizatori_societati_administrate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilizatori_societati_administrate` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_UTILIZATOR` int(10) unsigned NOT NULL,
  `ID_SOCIETATE` int(10) unsigned NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_4` (`ID_UTILIZATOR`,`ID_SOCIETATE`),
  KEY `FK_utilizatori_societati_administrate_2` (`ID_SOCIETATE`),
  CONSTRAINT `FK_utilizatori_societati_administrate_1` FOREIGN KEY (`ID_UTILIZATOR`) REFERENCES `utilizatori` (`ID`),
  CONSTRAINT `FK_utilizatori_societati_administrate_2` FOREIGN KEY (`ID_SOCIETATE`) REFERENCES `societati_asigurare` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vactions`
--

DROP TABLE IF EXISTS `vactions`;
/*!50001 DROP VIEW IF EXISTS `vactions`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vactions` AS SELECT 
 1 AS `ID`,
 1 AS `NAME`,
 1 AS `SUMMARY`,
 1 AS `IMG`,
 1 AS `ACTION`,
 1 AS `OBJECT_NAME`,
 1 AS `TYPE`,
 1 AS `ORDER`,
 1 AS `PARENT_ID`,
 1 AS `DIV_ID`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vactions_log`
--

DROP TABLE IF EXISTS `vactions_log`;
/*!50001 DROP VIEW IF EXISTS `vactions_log`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vactions_log` AS SELECT 
 1 AS `ID`,
 1 AS `AUTHENTICATED_USER`,
 1 AS `AUTHENTICATED_USER_ID`,
 1 AS `REDIS_CLIENT_ID`,
 1 AS `MESSAGE_ID`,
 1 AS `CORRELATION_ID`,
 1 AS `COMMAND_PREDICATE`,
 1 AS `COMMAND_OBJECT_REPOSITORY`,
 1 AS `COMMAND_ARGUMENTS`,
 1 AS `DATA`,
 1 AS `STATUS`,
 1 AS `MESSAGE`,
 1 AS `RESULT`,
 1 AS `INSERTED_ID`,
 1 AS `ERRORS`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vasigurati`
--

DROP TABLE IF EXISTS `vasigurati`;
/*!50001 DROP VIEW IF EXISTS `vasigurati`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vasigurati` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vauto`
--

DROP TABLE IF EXISTS `vauto`;
/*!50001 DROP VIEW IF EXISTS `vauto`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vauto` AS SELECT 
 1 AS `ID`,
 1 AS `NR_AUTO`,
 1 AS `SERIE_SASIU`,
 1 AS `MARCA`,
 1 AS `MODEL`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vcompensari`
--

DROP TABLE IF EXISTS `vcompensari`;
/*!50001 DROP VIEW IF EXISTS `vcompensari`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vcompensari` AS SELECT 
 1 AS `ID`,
 1 AS `ID_DOSAR_RCA`,
 1 AS `ID_DOSAR_CASCO`,
 1 AS `SUMA`,
 1 AS `DATA`,
 1 AS `PAS`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vcomplete`
--

DROP TABLE IF EXISTS `vcomplete`;
/*!50001 DROP VIEW IF EXISTS `vcomplete`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vcomplete` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vcontracte`
--

DROP TABLE IF EXISTS `vcontracte`;
/*!50001 DROP VIEW IF EXISTS `vcontracte`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vcontracte` AS SELECT 
 1 AS `ID`,
 1 AS `NR_CONTRACT`,
 1 AS `DATA_CONTRACT`,
 1 AS `OBSERVATII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vcontracte_plati_contracte`
--

DROP TABLE IF EXISTS `vcontracte_plati_contracte`;
/*!50001 DROP VIEW IF EXISTS `vcontracte_plati_contracte`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vcontracte_plati_contracte` AS SELECT 
 1 AS `ID`,
 1 AS `ID_CONTRACT`,
 1 AS `ID_PLATA_CONTRACT`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vdocumente_scanate`
--

DROP TABLE IF EXISTS `vdocumente_scanate`;
/*!50001 DROP VIEW IF EXISTS `vdocumente_scanate`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vdocumente_scanate` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE_FISIER`,
 1 AS `EXTENSIE_FISIER`,
 1 AS `DATA_INCARCARE`,
 1 AS `DIMENSIUNE_FISIER`,
 1 AS `ID_TIP_DOCUMENT`,
 1 AS `ID_DOSAR`,
 1 AS `DETALII`,
 1 AS `VIZA_CASCO`,
 1 AS `FILE_CONTENT`,
 1 AS `SMALL_ICON`,
 1 AS `MEDIUM_ICON`,
 1 AS `CALE_FISIER`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vdocumente_scanate_simple`
--

DROP TABLE IF EXISTS `vdocumente_scanate_simple`;
/*!50001 DROP VIEW IF EXISTS `vdocumente_scanate_simple`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vdocumente_scanate_simple` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE_FISIER`,
 1 AS `EXTENSIE_FISIER`,
 1 AS `DATA_INCARCARE`,
 1 AS `DIMENSIUNE_FISIER`,
 1 AS `ID_TIP_DOCUMENT`,
 1 AS `ID_DOSAR`,
 1 AS `DETALII`,
 1 AS `VIZA_CASCO`,
 1 AS `CALE_FISIER`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vdosare`
--

DROP TABLE IF EXISTS `vdosare`;
/*!50001 DROP VIEW IF EXISTS `vdosare`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vdosare` AS SELECT 
 1 AS `ID`,
 1 AS `NR_SCA`,
 1 AS `DATA_SCA`,
 1 AS `ID_ASIGURAT_CASCO`,
 1 AS `NR_POLITA_CASCO`,
 1 AS `ID_AUTO_CASCO`,
 1 AS `ID_SOCIETATE_CASCO`,
 1 AS `NR_POLITA_RCA`,
 1 AS `ID_AUTO_RCA`,
 1 AS `VALOARE_DAUNA`,
 1 AS `VALOARE_REGRES`,
 1 AS `ID_INTERVENIENT`,
 1 AS `NR_DOSAR_CASCO`,
 1 AS `VMD`,
 1 AS `OBSERVATII`,
 1 AS `ID_SOCIETATE_RCA`,
 1 AS `DATA_EVENIMENT`,
 1 AS `REZERVA_DAUNA`,
 1 AS `DATA_INTRARE_RCA`,
 1 AS `DATA_IESIRE_CASCO`,
 1 AS `NR_INTRARE_RCA`,
 1 AS `NR_IESIRE_CASCO`,
 1 AS `ID_ASIGURAT_RCA`,
 1 AS `ID_TIP_DOSAR`,
 1 AS `SUMA_IBNR`,
 1 AS `DATA_AVIZARE`,
 1 AS `DATA_NOTIFICARE`,
 1 AS `DATA_ULTIMEI_MODIFICARI`,
 1 AS `AVIZAT`,
 1 AS `CAZ`,
 1 AS `LOC_ACCIDENT`,
 1 AS `deleted`,
 1 AS `DATA_CREARE`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vdosare_plati`
--

DROP TABLE IF EXISTS `vdosare_plati`;
/*!50001 DROP VIEW IF EXISTS `vdosare_plati`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vdosare_plati` AS SELECT 
 1 AS `ID`,
 1 AS `ID_DOSAR`,
 1 AS `ID_PLATA`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vdosare_plati_contracte`
--

DROP TABLE IF EXISTS `vdosare_plati_contracte`;
/*!50001 DROP VIEW IF EXISTS `vdosare_plati_contracte`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vdosare_plati_contracte` AS SELECT 
 1 AS `ID`,
 1 AS `ID_DOSAR`,
 1 AS `ID_PLATA_CONTRACT`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vdosare_portal`
--

DROP TABLE IF EXISTS `vdosare_portal`;
/*!50001 DROP VIEW IF EXISTS `vdosare_portal`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vdosare_portal` AS SELECT 
 1 AS `ID`,
 1 AS `NR_DOSAR`,
 1 AS `DATA`,
 1 AS `DATA_SEDINTA`,
 1 AS `ID_DOSAR`,
 1 AS `NR_SCA`,
 1 AS `DATA_SCA`,
 1 AS `INSTANTA`,
 1 AS `ORA`,
 1 AS `COMPLET`,
 1 AS `MONITORIZARE`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vdosare_procese`
--

DROP TABLE IF EXISTS `vdosare_procese`;
/*!50001 DROP VIEW IF EXISTS `vdosare_procese`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vdosare_procese` AS SELECT 
 1 AS `ID`,
 1 AS `ID_DOSAR`,
 1 AS `ID_PROCES`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vdosare_stadii`
--

DROP TABLE IF EXISTS `vdosare_stadii`;
/*!50001 DROP VIEW IF EXISTS `vdosare_stadii`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vdosare_stadii` AS SELECT 
 1 AS `ID`,
 1 AS `ID_DOSAR`,
 1 AS `ID_STADIU`,
 1 AS `TERMEN`,
 1 AS `OBSERVATII`,
 1 AS `DATA`,
 1 AS `SCADENTA`,
 1 AS `ORA`,
 1 AS `TERMEN_ADMINISTRATIV`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vdosare_stadii_sentinte`
--

DROP TABLE IF EXISTS `vdosare_stadii_sentinte`;
/*!50001 DROP VIEW IF EXISTS `vdosare_stadii_sentinte`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vdosare_stadii_sentinte` AS SELECT 
 1 AS `ID`,
 1 AS `ID_DOSAR_STADIU`,
 1 AS `ID_SENTINTA`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vdrepturi`
--

DROP TABLE IF EXISTS `vdrepturi`;
/*!50001 DROP VIEW IF EXISTS `vdrepturi`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vdrepturi` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vemail_notifications`
--

DROP TABLE IF EXISTS `vemail_notifications`;
/*!50001 DROP VIEW IF EXISTS `vemail_notifications`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vemail_notifications` AS SELECT 
 1 AS `ID`,
 1 AS `ID_DOSAR`,
 1 AS `MESSAGE_ID`,
 1 AS `MESSAGE_TEXT`,
 1 AS `SEND`,
 1 AS `SEND_TIMESTAMP`,
 1 AS `DELIVERY`,
 1 AS `DELIVERY_TIMESTAMP`,
 1 AS `REJECT`,
 1 AS `REJECT_TIMESTAMP`,
 1 AS `BOUNCE`,
 1 AS `BOUNCE_TIMESTAMP`,
 1 AS `OPEN`,
 1 AS `OPEN_TIMESTAMP`,
 1 AS `CLICK`,
 1 AS `CLICK_TIMESTAMP`,
 1 AS `COMPLAINT`,
 1 AS `COMPLAINT_TIMESTAMP`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vimport_log`
--

DROP TABLE IF EXISTS `vimport_log`;
/*!50001 DROP VIEW IF EXISTS `vimport_log`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vimport_log` AS SELECT 
 1 AS `ID`,
 1 AS `DATA_IMPORT`,
 1 AS `STATUS`,
 1 AS `MESSAGE`,
 1 AS `INSERTED_ID`,
 1 AS `ERRORS`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vinstante`
--

DROP TABLE IF EXISTS `vinstante`;
/*!50001 DROP VIEW IF EXISTS `vinstante`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vinstante` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vintervenienti`
--

DROP TABLE IF EXISTS `vintervenienti`;
/*!50001 DROP VIEW IF EXISTS `vintervenienti`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vintervenienti` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vlog`
--

DROP TABLE IF EXISTS `vlog`;
/*!50001 DROP VIEW IF EXISTS `vlog`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vlog` AS SELECT 
 1 AS `ID`,
 1 AS `DATA`,
 1 AS `ACTIUNE`,
 1 AS `TABELA`,
 1 AS `DETALII_BEFORE`,
 1 AS `ID_UTILIZATOR`,
 1 AS `DETALII_AFTER`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vmesaje`
--

DROP TABLE IF EXISTS `vmesaje`;
/*!50001 DROP VIEW IF EXISTS `vmesaje`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vmesaje` AS SELECT 
 1 AS `ID`,
 1 AS `ID_SENDER`,
 1 AS `SUBIECT`,
 1 AS `BODY`,
 1 AS `DATA`,
 1 AS `ID_DOSAR`,
 1 AS `IMPORTANTA`,
 1 AS `ID_TIP_MESAJ`,
 1 AS `deleted`,
 1 AS `REPLY_TO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vmesaje_utilizatori`
--

DROP TABLE IF EXISTS `vmesaje_utilizatori`;
/*!50001 DROP VIEW IF EXISTS `vmesaje_utilizatori`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vmesaje_utilizatori` AS SELECT 
 1 AS `ID`,
 1 AS `ID_MESAJ`,
 1 AS `ID_UTILIZATOR`,
 1 AS `DATA_CITIRE`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vpending_documente_scanate_imports`
--

DROP TABLE IF EXISTS `vpending_documente_scanate_imports`;
/*!50001 DROP VIEW IF EXISTS `vpending_documente_scanate_imports`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vpending_documente_scanate_imports` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE_FISIER`,
 1 AS `EXTENSIE_FISIER`,
 1 AS `DATA_INCARCARE`,
 1 AS `DIMENSIUNE_FISIER`,
 1 AS `ID_TIP_DOCUMENT`,
 1 AS `ID_DOSAR`,
 1 AS `DETALII`,
 1 AS `VIZA_CASCO`,
 1 AS `FILE_CONTENT`,
 1 AS `SMALL_ICON`,
 1 AS `MEDIUM_ICON`,
 1 AS `CALE_FISIER`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vpending_documente_scanate_imports_simple`
--

DROP TABLE IF EXISTS `vpending_documente_scanate_imports_simple`;
/*!50001 DROP VIEW IF EXISTS `vpending_documente_scanate_imports_simple`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vpending_documente_scanate_imports_simple` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE_FISIER`,
 1 AS `EXTENSIE_FISIER`,
 1 AS `DATA_INCARCARE`,
 1 AS `DIMENSIUNE_FISIER`,
 1 AS `ID_TIP_DOCUMENT`,
 1 AS `ID_DOSAR`,
 1 AS `DETALII`,
 1 AS `VIZA_CASCO`,
 1 AS `CALE_FISIER`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vpending_import_errors`
--

DROP TABLE IF EXISTS `vpending_import_errors`;
/*!50001 DROP VIEW IF EXISTS `vpending_import_errors`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vpending_import_errors` AS SELECT 
 1 AS `ID`,
 1 AS `NR_SCA`,
 1 AS `DATA_SCA`,
 1 AS `ID_ASIGURAT_CASCO`,
 1 AS `NR_POLITA_CASCO`,
 1 AS `ID_AUTO_CASCO`,
 1 AS `ID_SOCIETATE_CASCO`,
 1 AS `NR_POLITA_RCA`,
 1 AS `ID_AUTO_RCA`,
 1 AS `VALOARE_DAUNA`,
 1 AS `VALOARE_REGRES`,
 1 AS `ID_INTERVENIENT`,
 1 AS `NR_DOSAR_CASCO`,
 1 AS `VMD`,
 1 AS `OBSERVATII`,
 1 AS `ID_SOCIETATE_RCA`,
 1 AS `DATA_EVENIMENT`,
 1 AS `REZERVA_DAUNA`,
 1 AS `DATA_INTRARE_RCA`,
 1 AS `DATA_IESIRE_CASCO`,
 1 AS `NR_INTRARE_RCA`,
 1 AS `NR_IESIRE_CASCO`,
 1 AS `ID_ASIGURAT_RCA`,
 1 AS `ID_TIP_DOSAR`,
 1 AS `SUMA_IBNR`,
 1 AS `DATA_AVIZARE`,
 1 AS `DATA_NOTIFICARE`,
 1 AS `DATA_ULTIMEI_MODIFICARI`,
 1 AS `deleted`,
 1 AS `AVIZAT`,
 1 AS `CAZ`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vplati`
--

DROP TABLE IF EXISTS `vplati`;
/*!50001 DROP VIEW IF EXISTS `vplati`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vplati` AS SELECT 
 1 AS `ID`,
 1 AS `NR_DOCUMENT`,
 1 AS `DATA_DOCUMENT`,
 1 AS `SUMA`,
 1 AS `OBSERVATII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vplati_contracte`
--

DROP TABLE IF EXISTS `vplati_contracte`;
/*!50001 DROP VIEW IF EXISTS `vplati_contracte`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vplati_contracte` AS SELECT 
 1 AS `ID`,
 1 AS `NR_DOCUMENT`,
 1 AS `DATA_DOCUMENT`,
 1 AS `SUMA`,
 1 AS `OBSERVATII`,
 1 AS `INCASAT_PE_AMIABIL`,
 1 AS `INCASAT_CONTRACT`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vplati_taxa_timbru`
--

DROP TABLE IF EXISTS `vplati_taxa_timbru`;
/*!50001 DROP VIEW IF EXISTS `vplati_taxa_timbru`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vplati_taxa_timbru` AS SELECT 
 1 AS `ID`,
 1 AS `NR_DOCUMENT`,
 1 AS `DATA_DOCUMENT`,
 1 AS `SUMA`,
 1 AS `OBSERVATII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vprocese`
--

DROP TABLE IF EXISTS `vprocese`;
/*!50001 DROP VIEW IF EXISTS `vprocese`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vprocese` AS SELECT 
 1 AS `ID`,
 1 AS `NR_INTERN`,
 1 AS `NR_DOSAR_INSTANTA`,
 1 AS `DATA_DEPUNERE`,
 1 AS `OBSERVATII`,
 1 AS `SUMA_SOLICITATA`,
 1 AS `PENALITATI`,
 1 AS `TAXA_TIMBRU`,
 1 AS `TIMBRU_JUDICIAR`,
 1 AS `ONORARIU_EXPERT`,
 1 AS `ONORARIU_AVOCAT`,
 1 AS `ID_INSTANTA`,
 1 AS `ID_COMPLET`,
 1 AS `ID_CONTRACT`,
 1 AS `STADIU`,
 1 AS `CHELTUIELI_MICA_PUBLICITATE`,
 1 AS `ONORARIU_CURATOR`,
 1 AS `ALTE_CHELTUIELI_JUDECATA`,
 1 AS `TAXA_TIMBRU_REEXAMINARE`,
 1 AS `NR_DOSAR_EXECUTARE`,
 1 AS `DATA_EXECUTARE`,
 1 AS `ONORARIU_AVOCAT_EXECUTARE`,
 1 AS `CHELTUIELI_EXECUTARE`,
 1 AS `DESPAGUBIRE_ACORDATA`,
 1 AS `CHELTUIELI_JUDECATA_ACORDATE`,
 1 AS `MONITORIZARE`,
 1 AS `ID_TIP_PROCES`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vprocese_plati_taxa_timbru`
--

DROP TABLE IF EXISTS `vprocese_plati_taxa_timbru`;
/*!50001 DROP VIEW IF EXISTS `vprocese_plati_taxa_timbru`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vprocese_plati_taxa_timbru` AS SELECT 
 1 AS `ID`,
 1 AS `ID_PROCES`,
 1 AS `ID_PLATA_TAXA_TIMBRU`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vsentinte`
--

DROP TABLE IF EXISTS `vsentinte`;
/*!50001 DROP VIEW IF EXISTS `vsentinte`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vsentinte` AS SELECT 
 1 AS `ID`,
 1 AS `NR_SENTINTA`,
 1 AS `DATA_SENTINTA`,
 1 AS `DATA_COMUNICARE`,
 1 AS `SOLUTIE`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vsetari`
--

DROP TABLE IF EXISTS `vsetari`;
/*!50001 DROP VIEW IF EXISTS `vsetari`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vsetari` AS SELECT 
 1 AS `ID`,
 1 AS `NUME`,
 1 AS `VALOARE`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vsocietati_asigurare`
--

DROP TABLE IF EXISTS `vsocietati_asigurare`;
/*!50001 DROP VIEW IF EXISTS `vsocietati_asigurare`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vsocietati_asigurare` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `CUI`,
 1 AS `NR_REG_COM`,
 1 AS `ADRESA`,
 1 AS `BANCA`,
 1 AS `IBAN`,
 1 AS `SOLD`,
 1 AS `DATA_ULTIMEI_PLATI`,
 1 AS `TELEFON`,
 1 AS `REPREZENTANT_FISCAL`,
 1 AS `DENUMIRE_SCURTA`,
 1 AS `EMAIL_NOTIFICARI`,
 1 AS `ID_TEMPLATE_NOTIFICARI`,
 1 AS `EMAIL`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vstadii`
--

DROP TABLE IF EXISTS `vstadii`;
/*!50001 DROP VIEW IF EXISTS `vstadii`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vstadii` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `ICON_PATH`,
 1 AS `PAS`,
 1 AS `STADIU_INSTANTA`,
 1 AS `STADIU_CU_TERMEN`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vstadii_scadente`
--

DROP TABLE IF EXISTS `vstadii_scadente`;
/*!50001 DROP VIEW IF EXISTS `vstadii_scadente`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vstadii_scadente` AS SELECT 
 1 AS `ID`,
 1 AS `ID_STADIU`,
 1 AS `ID_SETARE`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vstadii_setari`
--

DROP TABLE IF EXISTS `vstadii_setari`;
/*!50001 DROP VIEW IF EXISTS `vstadii_setari`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vstadii_setari` AS SELECT 
 1 AS `ID_SETARE`,
 1 AS `ID_STADIU`,
 1 AS `ID`,
 1 AS `WARNING`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vtemplates`
--

DROP TABLE IF EXISTS `vtemplates`;
/*!50001 DROP VIEW IF EXISTS `vtemplates`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vtemplates` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE_FISIER`,
 1 AS `EXTENSIE_FISIER`,
 1 AS `FILE_CONTENT`,
 1 AS `DIMENSIUNE_FISIER`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vtip_caz`
--

DROP TABLE IF EXISTS `vtip_caz`;
/*!50001 DROP VIEW IF EXISTS `vtip_caz`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vtip_caz` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vtip_document`
--

DROP TABLE IF EXISTS `vtip_document`;
/*!50001 DROP VIEW IF EXISTS `vtip_document`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vtip_document` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `QINFO`,
 1 AS `MANDATORY`,
 1 AS `DISPLAY_ORDER`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vtip_dosare`
--

DROP TABLE IF EXISTS `vtip_dosare`;
/*!50001 DROP VIEW IF EXISTS `vtip_dosare`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vtip_dosare` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vtip_mesaje`
--

DROP TABLE IF EXISTS `vtip_mesaje`;
/*!50001 DROP VIEW IF EXISTS `vtip_mesaje`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vtip_mesaje` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vtip_procese`
--

DROP TABLE IF EXISTS `vtip_procese`;
/*!50001 DROP VIEW IF EXISTS `vtip_procese`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vtip_procese` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vtip_utilizatori`
--

DROP TABLE IF EXISTS `vtip_utilizatori`;
/*!50001 DROP VIEW IF EXISTS `vtip_utilizatori`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vtip_utilizatori` AS SELECT 
 1 AS `ID`,
 1 AS `DENUMIRE`,
 1 AS `DETALII`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vutilizatori`
--

DROP TABLE IF EXISTS `vutilizatori`;
/*!50001 DROP VIEW IF EXISTS `vutilizatori`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vutilizatori` AS SELECT 
 1 AS `ID`,
 1 AS `USER_NAME`,
 1 AS `PASSWORD`,
 1 AS `NUME_COMPLET`,
 1 AS `DETALII`,
 1 AS `IS_ONLINE`,
 1 AS `EMAIL`,
 1 AS `IP`,
 1 AS `MAC`,
 1 AS `ID_TIP_UTILIZATOR`,
 1 AS `LAST_REFRESH`,
 1 AS `DEPARTAMENT`,
 1 AS `ID_SOCIETATE`,
 1 AS `deleted`,
 1 AS `LAST_LOGIN`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vutilizatori_actions`
--

DROP TABLE IF EXISTS `vutilizatori_actions`;
/*!50001 DROP VIEW IF EXISTS `vutilizatori_actions`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vutilizatori_actions` AS SELECT 
 1 AS `ID`,
 1 AS `ID_UTILIZATOR`,
 1 AS `ID_ACTION`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vutilizatori_dosare`
--

DROP TABLE IF EXISTS `vutilizatori_dosare`;
/*!50001 DROP VIEW IF EXISTS `vutilizatori_dosare`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vutilizatori_dosare` AS SELECT 
 1 AS `ID`,
 1 AS `ID_UTILIZATOR`,
 1 AS `ID_DOSAR`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vutilizatori_drepturi`
--

DROP TABLE IF EXISTS `vutilizatori_drepturi`;
/*!50001 DROP VIEW IF EXISTS `vutilizatori_drepturi`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vutilizatori_drepturi` AS SELECT 
 1 AS `ID`,
 1 AS `ID_UTILIZATOR`,
 1 AS `ID_DREPT`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vutilizatori_setari`
--

DROP TABLE IF EXISTS `vutilizatori_setari`;
/*!50001 DROP VIEW IF EXISTS `vutilizatori_setari`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vutilizatori_setari` AS SELECT 
 1 AS `ID`,
 1 AS `ID_UTILIZATOR`,
 1 AS `ID_SETARE`,
 1 AS `VALOARE`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vutilizatori_societati`
--

DROP TABLE IF EXISTS `vutilizatori_societati`;
/*!50001 DROP VIEW IF EXISTS `vutilizatori_societati`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vutilizatori_societati` AS SELECT 
 1 AS `ID`,
 1 AS `ID_UTILIZATOR`,
 1 AS `ID_SOCIETATE`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vutilizatori_societati_administrate`
--

DROP TABLE IF EXISTS `vutilizatori_societati_administrate`;
/*!50001 DROP VIEW IF EXISTS `vutilizatori_societati_administrate`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vutilizatori_societati_administrate` AS SELECT 
 1 AS `ID`,
 1 AS `ID_UTILIZATOR`,
 1 AS `ID_SOCIETATE`,
 1 AS `deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'socisa'
--
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONSsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONSsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM ACTIONS;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONSsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONSsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        DELETE FROM ACTIONS WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONSsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONSsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

)
BEGIN

        SELECT * FROM vACTIONS WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONSsp_GetByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONSsp_GetByName`(

        _AUTHENTICATED_USER_ID INT,

        _NAME VARCHAR(100)

)
BEGIN

        SELECT * FROM vACTIONS WHERE NAME = _NAME;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONSsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONSsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _NAME VARCHAR(250),

        _SUMMARY TEXT,

        _IMG VARCHAR(250),

        _ACTION VARCHAR(250),

        _OBJECT_NAME VARCHAR(100),

        _TYPE VARCHAR(100),

        _ORDER INT,

        _PARENT_ID INT,

        _DIV_ID VARCHAR(100),

        OUT _ID INT

)
BEGIN

        INSERT INTO ACTIONS SET

                NAME = _NAME,

                SUMMARY = _SUMMARY,

                IMG = _IMG,

                `ACTION` = _ACTION,

                OBJECT_NAME = _OBJECT_NAME,

                TYPE = _TYPE,

                `ORDER` = _ORDER,

                PARENT_ID = _PARENT_ID,

                DIV_ID = _DIV_ID;

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONSsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONSsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);

        

        SET @_DEFAULT_FILTER = '1=1';



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' ACTIONS.NAME ';

        END IF;



        SET @_QUERY = 'SELECT ACTIONS.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vACTIONS ACTIONS '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY; 

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONSsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONSsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE ACTIONS SET deleted=true WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONSsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONSsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _NAME VARCHAR(250),

        _SUMMARY TEXT,

        _IMG VARCHAR(250),

        _ACTION VARCHAR(250),

        _OBJECT_NAME VARCHAR(100),

        _TYPE VARCHAR(100),

        _ORDER INT,

        _PARENT_ID INT,

        _DIV_ID VARCHAR(100)

)
BEGIN

        UPDATE ACTIONS SET

                NAME = _NAME,

                SUMMARY = _SUMMARY,

                IMG = _IMG,

                ACTION = _ACTION,

                OBJECT_NAME = _OBJECT_NAME,

                TYPE = _TYPE,

                `ORDER` = _ORDER,

                PARENT_ID = _PARENT_ID,

                DIV_ID = _DIV_ID

                WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONS_LOGsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONS_LOGsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM actions_log;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONS_LOGsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONS_LOGsp_insert`(

        _AUTHENTICATED_USER VARCHAR(250),

        _AUTHENTICATED_USER_ID INT,

        _REDIS_CLIENT_ID VARCHAR(250),

        _MESSAGE_ID VARCHAR(250),

        _CORRELATION_ID VARCHAR(250),

        _COMMAND_PREDICATE VARCHAR(250),

        _COMMAND_OBJECT_REPOSITORY VARCHAR(250),

        _COMMAND_ARGUMENTS TEXT,

        _DATA DATETIME,

        _STATUS BOOL,

        _MESSAGE TEXT,

        _RESULT TEXT,

        _INSERTED_ID INT,

        _ERRORS TEXT,

        OUT _ID INT

)
BEGIN

        INSERT INTO ACTIONS_LOG SET

        AUTHENTICATED_USER = _AUTHENTICATED_USER,

        AUTHENTICATED_USER_ID = _AUTHENTICATED_USER_ID,

        REDIS_CLIENT_ID = _REDIS_CLIENT_ID,

        MESSAGE_ID = _MESSAGE_ID,

        CORRELATION_ID = _CORRELATION_ID,

        COMMAND_PREDICATE = _COMMAND_PREDICATE,

        COMMAND_OBJECT_REPOSITORY = _COMMAND_OBJECT_REPOSITORY,

        COMMAND_ARGUMENTS = _COMMAND_ARGUMENTS,

        `DATA` = _DATA,

        `STATUS` = _STATUS,

        MESSAGE = _MESSAGE,

        RESULT = _RESULT,

        INSERTED_ID = _INSERTED_ID,

        `ERRORS` = _ERRORS;





        SET _ID = LAST_INSERT_ID();        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ACTIONS_LOGsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTIONS_LOGsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE actions_log SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ASIGURATIsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ASIGURATIsp_Combo`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ID, DENUMIRE FROM vASIGURATI ORDER BY DENUMIRE ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ASIGURATIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ASIGURATIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM asigurati;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ASIGURATIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ASIGURATIsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM ASIGURATI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ASIGURATIsp_GetByDenumire` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ASIGURATIsp_GetByDenumire`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE VARCHAR(250)

)
BEGIN

        SELECT * FROM vASIGURATI WHERE DENUMIRE = _DENUMIRE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ASIGURATIsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ASIGURATIsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT * FROM vASIGURATI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ASIGURATIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ASIGURATIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _denumire VARCHAR(250),

        _detalii VARCHAR(2000),

        OUT _ID INT

    )
BEGIN

        IF _denumire IS NULL THEN

                SET _ID = NULL;

        ELSE

                SET _ID = (SELECT ID FROM ASIGURATI WHERE DENUMIRE = _DENUMIRE LIMIT 1);

                IF _ID IS NULL THEN

                        BEGIN

                        INSERT INTO ASIGURATI (DENUMIRE, DETALII)

                        VALUES (_denumire, _detalii);

                        END;

                        
                        SET _ID = LAST_INSERT_ID();

                END IF;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ASIGURATIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ASIGURATIsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);

        

        SET @_DEFAULT_FILTER = '1=1';



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' ASIGURATI.DENUMIRE ';

        END IF;



        SET @_QUERY = 'SELECT ASIGURATI.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vASIGURATI ASIGURATI '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY; 

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ASIGURATIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ASIGURATIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE asigurati SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ASIGURATIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ASIGURATIsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _denumire VARCHAR(100),

        _detalii VARCHAR(2000)

    )
BEGIN

        UPDATE ASIGURATI

        SET DENUMIRE = _denumire,

                DETALII = _detalii

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AUTOsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AUTOsp_Combo`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

	SELECT ID, NR_AUTO FROM vAUTO ORDER BY NR_AUTO;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AUTOsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AUTOsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM auto;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AUTOsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AUTOsp_delete`(

        _AUTHENTICATED_USER_ID INT,

	_ID INT

    )
BEGIN

	DELETE FROM AUTO WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AUTOsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AUTOsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

)
BEGIN

	SELECT * FROM vAUTO WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AUTOsp_GetByNrAuto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AUTOsp_GetByNrAuto`(

        _AUTHENTICATED_USER_ID INT,

        _NR_AUTO VARCHAR(100))
BEGIN

        SELECT * FROM vAUTO WHERE NR_AUTO = _NR_AUTO;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AUTOsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AUTOsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _NR_AUTO VARCHAR(45),

        _SERIE_SASIU VARCHAR(50),

        _MARCA VARCHAR(45),

        _MODEL VARCHAR(45),

        _DETALII TEXT,

        OUT _ID INT

    )
BEGIN

        IF _NR_AUTO IS NULL THEN

                SET _ID = NULL;

        ELSE

                SET _ID = (SELECT ID FROM AUTO WHERE NR_AUTO = _NR_AUTO AND (SERIE_SASIU = _SERIE_SASIU OR _SERIE_SASIU IS NULL) LIMIT 1);



                IF _ID IS NULL THEN

                        BEGIN

                        INSERT INTO AUTO (NR_AUTO, SERIE_SASIU, MARCA, MODEL, DETALII)

                        VALUES (_NR_AUTO, _SERIE_SASIU, _MARCA, _MODEL, _DETALII);

                        SET _ID = LAST_INSERT_ID();

                        END;

                END IF;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AUTOsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AUTOsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);

        

        SET @_DEFAULT_FILTER = '1=1';



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' AUTO.NR_AUTO ';

        END IF;



        SET @_QUERY = 'SELECT AUTO.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vAUTO AUTO '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY; 

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AUTOsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AUTOsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE auto SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AUTOsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AUTOsp_update`(

        _AUTHENTICATED_USER_ID INT,

	_ID INT,

        _NR_AUTO VARCHAR(10),

        _SERIE_SASIU VARCHAR(50),

        _MARCA VARCHAR(45),

        _MODEL VARCHAR(45),

        _DETALII TEXT

    )
BEGIN

        UPDATE AUTO SET

        	NR_AUTO = _NR_AUTO, 

        	SERIE_SASIU = _SERIE_SASIU, 

        	MARCA= _MARCA, 

        	MODEL= _MODEL, 

        	DETALII = _DETALII

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CHILDRENsp_Get` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CHILDRENsp_Get`(

        _AUTHENTICATED_USER_ID INT,

        _PRIMARY_KEY_VALUE INT,

        _EXTERNAL_ID VARCHAR(100),

        _EXTERNAL_TABLE VARCHAR(100),

        _CHILDREN_ID_FIELD VARCHAR(100),

        _CHILDREN_ID_VALUE VARCHAR(100)

)
BEGIN

        DECLARE _QUERY VARCHAR(8000);

        SET @_QUERY = CONCAT('SELECT COUNT(*) FROM v', _EXTERNAL_TABLE, ' WHERE `', _EXTERNAL_ID, '` = ''', _PRIMARY_KEY_VALUE, ''' AND `', _CHILDREN_ID_FIELD, '` = ''', _CHILDREN_ID_VALUE, ''' ');

        PREPARE stmt1 FROM @_QUERY;

        EXECUTE stmt1;

        DEALLOCATE PREPARE stmt1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CHILDRENSsp_Get` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CHILDRENSsp_Get`(

        _AUTHENTICATED_USER_ID INT,

        _PRIMARY_KEY_VALUE INT,

        _EXTERNAL_ID VARCHAR(100),

        _EXTERNAL_TABLE VARCHAR(100)

)
BEGIN

        DECLARE _QUERY VARCHAR(8000);

        SET @_QUERY = CONCAT('SELECT COUNT(*) FROM v', _EXTERNAL_TABLE, ' WHERE `', _EXTERNAL_ID, '` = ''', _PRIMARY_KEY_VALUE, ''' ');

        PREPARE stmt1 FROM @_QUERY;

        EXECUTE stmt1;

        DEALLOCATE PREPARE stmt1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPENSARIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPENSARIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM compensari;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPENSARIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPENSARIsp_delete`(

        _AUTHENTICATED_USER_ID INT,

	_ID INT

    )
BEGIN

        DELETE FROM COMPENSARI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPENSARIsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPENSARIsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        SELECT * FROM vCOMPENSARI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPENSARIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPENSARIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR_RCA INT,

        _ID_DOSAR_CASCO INT,

        _SUMA DOUBLE,

        _DATA DATETIME,

        _PAS INT,

        OUT _ID INT

    )
BEGIN

        INSERT INTO COMPENSARI SET

        ID_DOSAR_RCA = _ID_DOSAR_RCA,

        ID_DOSAR_CASCO = _ID_DOSAR_CASCO,

        SUMA = _SUMA,

        DATA = _DATA,

        PAS = _PAS;



        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPENSARIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPENSARIsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vCOMPENSARI;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPENSARIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPENSARIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE compensari SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPENSARIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPENSARIsp_update`(

        _AUTHENTICATED_USER_ID INT,

	_ID INT,

        _ID_DOSAR_RCA INT,

        _ID_DOSAR_CASCO INT,

        _SUMA DOUBLE,

        _DATA DATETIME,

        _PAS INT

    )
BEGIN

        UPDATE COMPENSARI SET

        ID_DOSAR_RCA = _ID_DOSAR_RCA,

        ID_DOSAR_CASCO = _ID_DOSAR_CASCO,

        SUMA = _SUMA,

        DATA = _DATA,

        PAS = _PAS

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPLETEsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPLETEsp_Combo`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ID, DENUMIRE FROM vCOMPLETE ORDER BY DENUMIRE ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPLETEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPLETEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM complete;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPLETEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPLETEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM COMPLETE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPLETEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPLETEsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT * FROM vCOMPLETE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPLETEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPLETEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _denumire VARCHAR(250),

        _detalii VARCHAR(2000),

        OUT _ID INT

    )
BEGIN

        IF _denumire IS NULL THEN

                SET _ID = NULL;

        ELSE

                SET _ID = (SELECT ID FROM COMPLETE WHERE DENUMIRE = _denumire LIMIT 1);

                IF _ID IS NULL THEN

                        INSERT INTO COMPLETE (DENUMIRE, DETALII)

                        VALUES (_denumire, _detalii);

                        SET _ID = LAST_INSERT_ID();

                END IF;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPLETEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPLETEsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(8000),

        _LIMIT VARCHAR(1000)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);

        

        SET @_DEFAULT_FILTER = '1=1';



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' COMPLETE.DENUMIRE ';

        END IF;



        SET @_QUERY = 'SELECT COMPLETE.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vCOMPLETE COMPLETE '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY; 

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPLETEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPLETEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE complete SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMPLETEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMPLETEsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _denumire VARCHAR(100),

        _detalii VARCHAR(2000)

    )
BEGIN

        UPDATE COMPLETE

        SET DENUMIRE = _denumire,

                DETALII = _detalii

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_Combo`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ID, CONCAT(IF(NR_CONTRACT IS NULL, '', NR_CONTRACT), ' / ', IF(DATA_CONTRACT IS NULL, '', DATE_FORMAT(DATA_CONTRACT, '%d.%c.%Y'))) CONTRACT FROM vCONTRACTE ORDER BY NR_CONTRACT ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM contracte;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM CONTRACTE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT * FROM vCONTRACTE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_GetColumns` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_GetColumns`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SHOW COLUMNS FROM CONTRACTE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_GetIdRegres` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_GetIdRegres`(

        _AUTHENTICATED_USER_ID INT,

        _ID_CONTRACT INT

    )
BEGIN

        SELECT ID_DOSAR FROM vDOSARE_CONTRACTE WHERE ID_CONTRACT = _ID_CONTRACT LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _NR_CONTRACT VARCHAR(45),

        _DATA_CONTRACT DATETIME,

        _OBSERVATII TEXT,

        OUT _ID INT

    )
BEGIN

        
        IF _NR_CONTRACT IS NULL THEN

                SET _ID = NULL;

        ELSE

                INSERT INTO CONTRACTE

                SET NR_CONTRACT = _NR_CONTRACT,

                DATA_CONTRACT = _DATA_CONTRACT,

                OBSERVATII = _OBSERVATII;



                SET _ID = LAST_INSERT_ID();

        END IF;

        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_IsAssigned` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_IsAssigned`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_CONTRACT INT

    )
BEGIN

        SELECT COUNT(*) FROM vDOSARE_CONTRACTE WHERE ID_DOSAR = _ID_DOSAR AND ID_CONTRACT = _ID_CONTRACT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);

        

        SET @_DEFAULT_FILTER = '1=1';



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' CONTRACTE.NR_CONTRACT ';

        END IF;



        SET @_QUERY = 'SELECT CONTRACTE.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vCONTRACTE CONTRACTE '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY; 

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE contracte SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTEsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _NR_CONTRACT VARCHAR(45),

        _DATA_CONTRACT DATETIME,

        _OBSERVATII TEXT

    )
BEGIN

        UPDATE CONTRACTE

        SET NR_CONTRACT = _NR_CONTRACT,

        DATA_CONTRACT = _DATA_CONTRACT,

        OBSERVATII = _OBSERVATII

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTE_PLATI_CONTRACTEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTE_PLATI_CONTRACTEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM contracte_plati_contracte;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTE_PLATI_CONTRACTEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTE_PLATI_CONTRACTEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DECLARE _ID_CONTRACT INT;

        SET _ID_CONTRACT = (SELECT ID_CONTRACT FROM CONTRACTE_PLATI_CONTRACTE WHERE ID = _ID);

        DELETE FROM CONTRACTE_PLATI_CONTRACTE

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTE_PLATI_CONTRACTEsp_DeleteByIds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTE_PLATI_CONTRACTEsp_DeleteByIds`(

        _AUTHENTICATED_USER_ID INT,

        _ID_CONTRACT INT,

        _ID_PLATA_CONTRACT INT

    )
BEGIN

        DELETE FROM CONTRACTE_PLATI_CONTRACTE

        WHERE ID_CONTRACT = _ID_CONTRACT AND ID_PLATA_CONTRACT = _ID_PLATA_CONTRACT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTE_PLATI_CONTRACTEsp_GetByIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTE_PLATI_CONTRACTEsp_GetByIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_CONTRACT INT)
BEGIN

        SELECT * FROM vCONTRACTE_PLATI_CONTRACTE WHERE ID_CONTRACT = _ID_CONTRACT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTE_PLATI_CONTRACTEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTE_PLATI_CONTRACTEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_CONTRACT INT,

        _ID_PLATA_CONTRACT INT,

        OUT _ID INT

    )
BEGIN

        INSERT INTO CONTRACTE_PLATI_CONTRACTE

        SET ID_CONTRACT = _ID_CONTRACT,

        ID_PLATA_CONTRACT = _ID_PLATA_CONTRACT;



        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONTRACTE_PLATI_CONTRACTEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTRACTE_PLATI_CONTRACTEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE contracte_plati_contracte SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DASHBOARDsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DASHBOARDsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _ID_SOCIETATE INT,

        _EXPIRATION_DAYS INT

)
BEGIN

        DECLARE

                -- pt. Admin si Super --

                DOSARE_TOTAL, DOSARE_CASCO_TOTAL, DOSARE_RCA_TOTAL,

                DOSARE_NEASIGNATE, DOSARE_CASCO_NEASIGNATE, DOSARE_RCA_NEASIGNATE,

                DOSARE_NEASIGNATE_FROM_LAST_LOGIN, DOSARE_NEASIGNATE_CASCO_FROM_LAST_LOGIN, DOSARE_NEASIGNATE_RCA_FROM_LAST_LOGIN,

                -- pt. All --

                DOSARE_FROM_LAST_LOGIN, DOSARE_CASCO_FROM_LAST_LOGIN, DOSARE_RCA_FROM_LAST_LOGIN,

                DOSARE_NEOPERATE, DOSARE_CASCO_NEOPERATE, DOSARE_RCA_NEOPERATE,

                MESAJE_NOI, MESAJE_NOI_DOSAR_NOU, MESAJE_NOI_DOCUMENT_NOU INT;



        DECLARE _LAST_LOGIN, _EXPIRATION_DATE DATETIME;



        DECLARE _ADMIN_TYPE_ID, _SUPER_TYPE_ID, _REGULAR_TYPE_ID INT;



        SET _ADMIN_TYPE_ID = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator');

        SET _SUPER_TYPE_ID = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super');

        SET _REGULAR_TYPE_ID = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Regular');





        SET _LAST_LOGIN = (SELECT LAST_LOGIN FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID);

        IF _EXPIRATION_DAYS IS NULL THEN

                SET _EXPIRATION_DAYS = 15;

        END IF;



        SET _EXPIRATION_DATE = DATE_ADD(CURDATE(), INTERVAL _EXPIRATION_DAYS * -1 DAY);



        SET DOSARE_TOTAL = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) AND (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE OR D.ID_SOCIETATE_RCA = _ID_SOCIETATE))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) AND

                                (

                                        D.ID_SOCIETATE_CASCO = _ID_SOCIETATE OR

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE )

                                )

                           )



                        OR (

                                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID) AND

                                (

                                        (

                                                D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND

                                                        D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                                        )

                                        OR

                                        (

                                                D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND

                                                        (D.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID) AND D.AVIZAT = TRUE )

                                        )

                                )

                           )



                      ));



        SET DOSARE_CASCO_TOTAL = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) AND (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) AND

                                (

                                        D.ID_SOCIETATE_CASCO = _ID_SOCIETATE

                                )

                           )



                        OR (

                                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID) AND

                                (

                                        (

                                                D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND

                                                        D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                                        )

                                )

                           )



                      ));



        SET DOSARE_RCA_TOTAL = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) AND (D.ID_SOCIETATE_RCA = _ID_SOCIETATE))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) AND

                                (

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE )

                                )

                           )



                        OR (

                                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID) AND

                                (

                                        (

                                                D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND

                                                        (D.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID) AND D.AVIZAT = TRUE )

                                        )

                                )

                           )



                      ));



        -- doar pt. Admin si Super --



        SET DOSARE_NEASIGNATE = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) AND ((D.ID_SOCIETATE_CASCO = _ID_SOCIETATE) OR (D.ID_SOCIETATE_RCA = _ID_SOCIETATE)))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) AND

                                (

                                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE) OR

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE )

                                )

                           )



                      ) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE) -- AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)

                );



        SET DOSARE_CASCO_NEASIGNATE = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) AND ((D.ID_SOCIETATE_CASCO = _ID_SOCIETATE) ))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) AND

                                (

                                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE)

                                )

                           )



                      ) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE) -- AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)

                );



        SET DOSARE_RCA_NEASIGNATE = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) AND ((D.ID_SOCIETATE_RCA = _ID_SOCIETATE)))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) AND

                                (

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE )

                                )

                           )



                      ) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE) -- AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)

                );



        SET DOSARE_NEASIGNATE_FROM_LAST_LOGIN = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) AND ((D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)) OR (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL))))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) AND

                                (

                                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)) OR

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND D.AVIZAT = TRUE )

                                )

                           )

                        /* -- NU E CAZUL PT. 'Regular' --

                        OR (

                                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID) AND

                                (

                                        (

                                                D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND

                                                        D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                                        )

                                        OR

                                        (

                                                D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND

                                                        (D.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID) AND D.AVIZAT = TRUE )

                                        )

                                )

                           )

                        */

                      ) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE) -- AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)

                );



        SET DOSARE_NEASIGNATE_CASCO_FROM_LAST_LOGIN = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) AND (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) AND

                                (

                                        D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)

                                )

                           )

                        /* -- NU E CAZUL PT. 'Regular' --

                        OR (

                                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID) AND

                                (

                                        (

                                                D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND

                                                        D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                                        )

                                )

                           )

                        */

                      ) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE) -- AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)

                );





        SET DOSARE_NEASIGNATE_RCA_FROM_LAST_LOGIN = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) AND (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) AND

                                (

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND D.AVIZAT = TRUE )

                                )

                           )

                        /* -- NU E CAZUL PT. 'Regular' --

                        OR (

                                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID) AND

                                (

                                        (

                                                D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND

                                                        (D.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID) AND D.AVIZAT = TRUE )

                                        )

                                )

                           )

                        */

                      ) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE) -- AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)

                );





        -- pt. All --



        SET DOSARE_FROM_LAST_LOGIN = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) OR

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) OR

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID) AND (D.ID IN (SELECT ID_DOSAR FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)))

                        )

                        AND

                        (

                                 (D.DATA_ULTIMEI_MODIFICARI IS NOT NULL AND D.DATA_ULTIMEI_MODIFICARI <= _EXPIRATION_DATE AND D.DATA_ULTIMEI_MODIFICARI >= _LAST_LOGIN) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NOT NULL AND D.DATA_CREARE <= _EXPIRATION_DATE AND D.DATA_CREARE >= _LAST_LOGIN) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NULL)

                        ) AND

                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE OR (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE))

                ));



        SET DOSARE_CASCO_FROM_LAST_LOGIN = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) OR

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) OR

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID) AND (D.ID IN (SELECT ID_DOSAR FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)))

                        )

                        AND

                        (

                                 (D.DATA_ULTIMEI_MODIFICARI IS NOT NULL AND D.DATA_ULTIMEI_MODIFICARI <= _EXPIRATION_DATE AND D.DATA_ULTIMEI_MODIFICARI >= _LAST_LOGIN) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NOT NULL AND D.DATA_CREARE <= _EXPIRATION_DATE AND D.DATA_CREARE >= _LAST_LOGIN) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NULL)

                        ) AND

                        D.ID_SOCIETATE_CASCO = _ID_SOCIETATE

                ));





        SET DOSARE_RCA_FROM_LAST_LOGIN = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) OR

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) OR

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID) AND (D.ID IN (SELECT ID_DOSAR FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)))

                        )

                        AND

                        (

                                 (D.DATA_ULTIMEI_MODIFICARI IS NOT NULL AND D.DATA_ULTIMEI_MODIFICARI <= _EXPIRATION_DATE AND D.DATA_ULTIMEI_MODIFICARI >= _LAST_LOGIN) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NOT NULL AND D.DATA_CREARE <= _EXPIRATION_DATE AND D.DATA_CREARE >= _LAST_LOGIN) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NULL)

                        ) AND

                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE)

                ));





        SET DOSARE_NEOPERATE = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) OR

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) OR

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID)  AND (D.ID IN (SELECT ID_DOSAR FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)))

                        )

                        AND

                        (

                                 (D.DATA_ULTIMEI_MODIFICARI IS NOT NULL AND D.DATA_ULTIMEI_MODIFICARI <= _EXPIRATION_DATE) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NOT NULL AND D.DATA_CREARE <= _EXPIRATION_DATE) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NULL)

                        ) AND

                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE OR (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE))

                ));



        SET DOSARE_CASCO_NEOPERATE = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) OR

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) OR

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID)  AND (D.ID IN (SELECT ID_DOSAR FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)))

                        )

                        AND

                        (

                                 (D.DATA_ULTIMEI_MODIFICARI IS NOT NULL AND D.DATA_ULTIMEI_MODIFICARI <= _EXPIRATION_DATE) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NOT NULL AND D.DATA_CREARE <= _EXPIRATION_DATE) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NULL)

                        ) AND

                        D.ID_SOCIETATE_CASCO = _ID_SOCIETATE

                ));





        SET DOSARE_RCA_NEOPERATE = (SELECT COUNT(*)  FROM vDOSARE D

                WHERE (

                        (

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _ADMIN_TYPE_ID) OR

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _SUPER_TYPE_ID) OR

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = _REGULAR_TYPE_ID) AND (D.ID IN (SELECT ID_DOSAR FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)))

                        )

                        AND

                        (

                                 (D.DATA_ULTIMEI_MODIFICARI IS NOT NULL AND D.DATA_ULTIMEI_MODIFICARI <= _EXPIRATION_DATE) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NOT NULL AND D.DATA_CREARE <= _EXPIRATION_DATE) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NULL)

                        ) AND

                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE)

                ));



        SET MESAJE_NOI = (SELECT COUNT(*)  FROM vMESAJE WHERE

                (ID IN (SELECT ID_MESAJ FROM vMESAJE_UTILIZATORI WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                        OR (ID IN (SELECT REPLY_TO FROM vMESAJE) AND ID_SENDER = _AUTHENTICATED_USER_ID)) AND

                (DATA >= _LAST_LOGIN OR _LAST_LOGIN IS NULL));





        SET MESAJE_NOI_DOSAR_NOU = (SELECT COUNT(*)  FROM vMESAJE WHERE

                (ID IN (SELECT ID_MESAJ FROM vMESAJE_UTILIZATORI WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                        OR (ID IN (SELECT REPLY_TO FROM vMESAJE) AND ID_SENDER = _AUTHENTICATED_USER_ID)) AND

                (DATA >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND

                (ID_TIP_MESAJ = (SELECT ID FROM TIP_MESAJE WHERE UPPER(DENUMIRE) = 'DOSAR NOU')));



        SET MESAJE_NOI_DOCUMENT_NOU = (SELECT COUNT(*)  FROM vMESAJE WHERE

                (ID IN (SELECT ID_MESAJ FROM vMESAJE_UTILIZATORI WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                        OR (ID IN (SELECT REPLY_TO FROM vMESAJE) AND ID_SENDER = _AUTHENTICATED_USER_ID)) AND

                (DATA >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND

                (ID_TIP_MESAJ = (SELECT ID FROM TIP_MESAJE WHERE UPPER(DENUMIRE) = 'DOCUMENT NOU')));



                                                                                                                                                                                                               

        SELECT DOSARE_TOTAL, DOSARE_CASCO_TOTAL, DOSARE_RCA_TOTAL,

                DOSARE_NEASIGNATE, DOSARE_CASCO_NEASIGNATE, DOSARE_RCA_NEASIGNATE,

                DOSARE_NEASIGNATE_FROM_LAST_LOGIN, DOSARE_NEASIGNATE_CASCO_FROM_LAST_LOGIN, DOSARE_NEASIGNATE_RCA_FROM_LAST_LOGIN,

                DOSARE_FROM_LAST_LOGIN, DOSARE_CASCO_FROM_LAST_LOGIN, DOSARE_RCA_FROM_LAST_LOGIN,

                DOSARE_NEOPERATE, DOSARE_CASCO_NEOPERATE, DOSARE_RCA_NEOPERATE,

                MESAJE_NOI, MESAJE_NOI_DOSAR_NOU, MESAJE_NOI_DOCUMENT_NOU;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_Avizare` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_Avizare`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _AVIZAT BOOL

)
BEGIN

        UPDATE DOCUMENTE_SCANATE SET VIZA_CASCO = _AVIZAT WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM documente_scanate;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_Delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_Delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        
        DELETE FROM DOCUMENTE_SCANATE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_GetByFileName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_GetByFileName`(

        _AUTHENTICATED_USER_ID INT,

        _FILE_NAME varchar(250))
BEGIN

        SELECT * FROM vDOCUMENTE_SCANATE WHERE DENUMIRE_FISIER = _FILE_NAME;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        SELECT * FROM vDOCUMENTE_SCANATE_SIMPLE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_GetByIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_GetByIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT)
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);

        DECLARE _QUERY VARCHAR(8000);

        

        SET @_DEFAULT_FILTER = CONCAT('(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID_UTILIZATOR FROM vUTILIZATORI_DREPTURI WHERE ID_DREPT IN (SELECT ID FROM vDREPTURI WHERE UPPER(DENUMIRE)=''VIZUALIZARE'')) OR ', _AUTHENTICATED_USER_ID, ' IN (SELECT ID_UTILIZATOR FROM vUTILIZATORI_DREPTURI WHERE ID_DREPT IN (SELECT ID FROM vDREPTURI WHERE UPPER(DENUMIRE)=''ADMINISTRARE''))) AND ');



        

        SET @_DEFAULT_FILTER = CONCAT('(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR IN (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE)=''ADMINISTRATOR'' OR UPPER(DENUMIRE)=''EMAIL'')) OR '); -- GUEST PT. LINK DIN EMAIL NOTIFICARI



        

        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER, '(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM UTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM TIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE ''%SUPER%'')) AND

                (D.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI_SOCIETATI WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, ') OR (DS.VIZA_CASCO = TRUE AND D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI_SOCIETATI WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, '))) ) OR ');





        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER, '(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE ''%REGULAR%'' )) AND

                ((D.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI_SOCIETATI WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, ') AND D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, ')) OR

                ((D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI_SOCIETATI WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, ') AND DS.VIZA_CASCO = TRUE) AND D.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, ')) )) )');





        SET @_QUERY = CONCAT('SELECT DS.* FROM vDOCUMENTE_SCANATE_SIMPLE DS INNER JOIN vDOSARE D ON DS.ID_DOSAR=D.ID WHERE DS.ID_DOSAR = ', _ID_DOSAR, ' AND (', @_DEFAULT_FILTER, ')');



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_import_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_import_log`(

        _AUTHENTICATED_USER_ID INT,

        _STATUS BOOL,

        _MESSAGE TEXT,

        _INSERTED_ID INT,

        _ERRORS TEXT,

        _DATA_IMPORT DATETIME,

        _IMPORT_TYPE INT,

        OUT _ID INT

)
BEGIN

        INSERT INTO IMPORT_DOCUMENTE_SCANATE_LOG SET

                `STATUS` = _STATUS,

                MESSAGE = _MESSAGE,

                INSERTED_ID = _INSERTED_ID,

                `ERRORS` = _ERRORS,

                IMPORT_TYPE = _IMPORT_TYPE,                

                DATA_IMPORT = _DATA_IMPORT;

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE_FISIER VARCHAR(250),

        _EXTENSIE_FISIER VARCHAR(5),

        _DATA_INCARCARE DATETIME,

        _DIMENSIUNE_FISIER INT,

        _ID_TIP_DOCUMENT INT,

        _ID_DOSAR INT,

        _VIZA_CASCO BOOLEAN,

        _DETALII TEXT,

        _FILE_CONTENT LONGBLOB,

        _SMALL_ICON BLOB,

        _MEDIUM_ICON BLOB,

        _CALE_FISIER VARCHAR(255),

        OUT _ID INT

)
BEGIN

        INSERT INTO DOCUMENTE_SCANATE

        SET

        DENUMIRE_FISIER = _DENUMIRE_FISIER,

        EXTENSIE_FISIER=_EXTENSIE_FISIER,

        DATA_INCARCARE = _DATA_INCARCARE,

        DIMENSIUNE_FISIER = _DIMENSIUNE_FISIER,

        ID_TIP_DOCUMENT = _ID_TIP_DOCUMENT,

        ID_DOSAR = _ID_DOSAR,

        VIZA_CASCO = _VIZA_CASCO,

        DETALII = _DETALII,

        FILE_CONTENT = _FILE_CONTENT,

        SMALL_ICON = _SMALL_ICON,

        MEDIUM_ICON = _MEDIUM_ICON,

        CALE_FISIER = _CALE_FISIER;

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);

        

        SET @_DEFAULT_FILTER = '1=1';



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' DOCUMENTE_SCANATE.DENUMIRE_FISIER ';

        END IF;



        SET @_QUERY = 'SELECT DOCUMENTE_SCANATE.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vDOCUMENTE_SCANATE_SIMPLE DOCUMENTE_SCANATE '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY; 

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE documente_scanate SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOCUMENTE_SCANATEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOCUMENTE_SCANATEsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _DENUMIRE_FISIER VARCHAR(250),

        _EXTENSIE_FISIER VARCHAR(5),

        _DATA_INCARCARE DATETIME,

        _DIMENSIUNE_FISIER INT,

        _ID_TIP_DOCUMENT INT,

        _ID_DOSAR INT,

        _VIZA_CASCO BOOLEAN,

        _DETALII TEXT,

        _FILE_CONTENT LONGBLOB,

        _SMALL_ICON BLOB,

        _MEDIUM_ICON BLOB,

        _CALE_FISIER VARCHAR(255)

)
BEGIN

        UPDATE DOCUMENTE_SCANATE

        SET

        DENUMIRE_FISIER = _DENUMIRE_FISIER,

        EXTENSIE_FISIER=_EXTENSIE_FISIER,

        DATA_INCARCARE = _DATA_INCARCARE,

        DIMENSIUNE_FISIER = _DIMENSIUNE_FISIER,

        ID_TIP_DOCUMENT = _ID_TIP_DOCUMENT,

        ID_DOSAR = _ID_DOSAR,

        VIZA_CASCO = _VIZA_CASCO,

        DETALII = _DETALII,

        FILE_CONTENT = _FILE_CONTENT,

        SMALL_ICON = _SMALL_ICON,

        MEDIUM_ICON = _MEDIUM_ICON,

        CALE_FISIER = _CALE_FISIER        

        WHERE ID=_ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_Avizare` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_Avizare`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _AVIZAT BOOL

)
BEGIN

        UPDATE DOSARE SET AVIZAT = _AVIZAT, DATA_AVIZARE = NOW() WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        DECLARE _ID_SOCIETATE INT;

        SET _ID_SOCIETATE =  (SELECT ID_SOCIETATE FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID);

        

        SELECT COUNT(*) FROM vDOSARE D

                WHERE (

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator'))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super')) AND

                                (

                                        D.ID_SOCIETATE_CASCO = _ID_SOCIETATE OR

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE )

                                )

                           )

                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Email')) AND

                                (

                                        D.ID_SOCIETATE_CASCO = _ID_SOCIETATE OR

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE )

                                )

                           )



                        OR (

                                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Regular')) AND

                                (

                                        (

                                                D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND

                                                        D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                                        )

                                        OR

                                        (

                                                D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND

                                                        (D.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID) AND D.AVIZAT = TRUE )

                                        )

                                ) -- AND D.ID IN (SELECT ID_DOSAR FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                           )



                      );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_CountFiltered` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_CountFiltered`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(8000),

        _LIMIT VARCHAR(1000)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);

        DECLARE _QUERY VARCHAR(8000);



        SET @_DEFAULT_FILTER = CONCAT('(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID_UTILIZATOR FROM vUTILIZATORI_DREPTURI WHERE ID_DREPT IN (SELECT ID FROM vDREPTURI WHERE UPPER(DENUMIRE)=''VIZUALIZARE'')) OR ', _AUTHENTICATED_USER_ID, ' IN (SELECT ID_UTILIZATOR FROM vUTILIZATORI_DREPTURI WHERE ID_DREPT IN (SELECT ID FROM vDREPTURI WHERE UPPER(DENUMIRE)=''ADMINISTRARE''))) AND ');



        

        SET @_DEFAULT_FILTER = CONCAT('(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE)=''ADMINISTRATOR'')) OR ');



        

        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER, '(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE ''%SUPER%'')) AND

                (DOSARE.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') OR (DOSARE.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') AND DOSARE.AVIZAT = TRUE)) ) OR ');





        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER, '(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE ''%EMAIL%'')) AND

                (DOSARE.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') OR (DOSARE.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') AND DOSARE.AVIZAT = TRUE)) ) OR ');





        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER,

                '(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE ''%REGULAR%'')) AND

                        (

                                (DOSARE.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') AND DOSARE.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, ')) OR

                                (DOSARE.AVIZAT = TRUE AND DOSARE.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') AND DOSARE.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, '))

                        )');

                        -- AND DOSARE.ID IN (SELECT ID_DOSAR FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, ')

        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER,

                ') )');



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' DOSARE.DATA_AVIZARE DESC ';

        END IF;

        

        SET @_QUERY = 'SELECT COUNT(*) CNT ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vDOSARE DOSARE ',

                

                

                'LEFT JOIN vASIGURATI ASIGC ON DOSARE.ID_ASIGURAT_CASCO=ASIGC.ID ',

                'LEFT JOIN vASIGURATI ASIGR ON DOSARE.ID_ASIGURAT_RCA=ASIGR.ID ',

                'LEFT JOIN vAUTO AC ON DOSARE.ID_AUTO_CASCO=AC.ID ',

                'LEFT JOIN vAUTO AR ON DOSARE.ID_AUTO_RCA=AR.ID ',

                'LEFT JOIN vSOCIETATI_ASIGURARE SC ON DOSARE.ID_SOCIETATE_CASCO=SC.ID ',

                'LEFT JOIN vSOCIETATI_ASIGURARE SR ON DOSARE.ID_SOCIETATE_RCA=SR.ID ',

                'LEFT JOIN vINTERVENIENTI I ON DOSARE.ID_INTERVENIENT=I.ID ',

                'LEFT JOIN vTIP_DOSARE TD ON DOSARE.ID_TIP_DOSAR=TD.ID '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        CASE WHEN _SORT = 'ASIGURAT_CASCO' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ASIGC.DENUMIRE');

                        WHEN _SORT = 'ASIGURAT_RCA' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ASIGR.DENUMIRE');

                        WHEN _SORT = 'ASIGURATOR_CASCO' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY SC.DENUMIRE');

                        WHEN _SORT = 'ASIGURATOR_RCA' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY SR.DENUMIRE');

                        WHEN _SORT = 'INTERVENIENT' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY I.DENUMIRE');

                        WHEN _SORT = 'NR_AUTO_CASCO' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY AC.NR_AUTO');

                        WHEN _SORT = 'NR_AUTO_RCA' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY AR.NR_AUTO');

                        WHEN _SORT = 'TIP_DOSAR' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY TD.DENUMIRE');

                        ELSE

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                        END CASE;

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY; 

        END CASE;

        /*

        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;

        */

        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

         

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_CountFromLastLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_CountFromLastLogin`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM vDOSARE D

                WHERE (

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator'))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super')) AND

                                D.ID_SOCIETATE_CASCO = (SELECT ID_SOCIETATE FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Email')) AND

                                D.ID_SOCIETATE_CASCO = (SELECT ID_SOCIETATE FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID))





                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Regular')) AND

                                D.ID_SOCIETATE_CASCO = (SELECT ID_SOCIETATE FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID) AND

                                        D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID))



                      )

                      AND (D.DATA_CREARE >= (SELECT LAST_LOGIN FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID) OR (SELECT LAST_LOGIN FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID) IS NULL);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM DOSARE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_DocumenteTipuri` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_DocumenteTipuri`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT

)
BEGIN

        SELECT TD.ID, TD.DENUMIRE, COUNT(*) CNT FROM VDOSARE D

                INNER JOIN VDOCUMENTE_SCANATE_SIMPLE DS ON D.ID=DS.ID_DOSAR

                INNER JOIN VTIP_DOCUMENT TD ON DS.ID_TIP_DOCUMENT=TD.ID

                WHERE D.ID=_ID_DOSAR AND DS.VIZA_CASCO=TRUE

                GROUP BY TD.DENUMIRE

                ORDER BY TD.DISPLAY_ORDER;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetAllFromLastLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetAllFromLastLogin`(

       _AUTHENTICATED_USER_ID INT,

        _ID_SOCIETATE INT

)
BEGIN

        DECLARE _LAST_LOGIN DATETIME;

        SET _LAST_LOGIN = (SELECT LAST_LOGIN FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID);



        SELECT *  FROM vDOSARE D

                WHERE ((

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator')) AND ((D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)) OR (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL))))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super')) AND

                                (

                                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)) OR

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND D.AVIZAT = TRUE )

                                )

                           )



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Email')) AND

                                (

                                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)) OR

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND D.AVIZAT = TRUE )

                                )

                           )





                        OR (

                                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Regular')) AND

                                (

                                        (

                                                D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND

                                                        D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                                        )

                                        OR

                                        (

                                                D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND

                                                        (D.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID AND D.AVIZAT = TRUE )

                                        )

                                )

                           )



                      ))) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE); -- AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetAllNeasignate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetAllNeasignate`(

       _AUTHENTICATED_USER_ID INT,

        _ID_SOCIETATE INT,

        _EXPIRATION_DAYS INT

)
BEGIN

        -- DECLARE _LAST_LOGIN DATETIME;

        -- SET _LAST_LOGIN = (SELECT LAST_LOGIN FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID);



        DECLARE _EXPIRATION_DATE DATETIME;



        IF _EXPIRATION_DAYS IS NULL THEN

                SET _EXPIRATION_DAYS = 15;

        END IF;



        SET _EXPIRATION_DATE = DATE_ADD(CURDATE(), INTERVAL _EXPIRATION_DAYS * -1 DAY);



        SELECT *  FROM vDOSARE D

                WHERE ((

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator')) AND ((D.ID_SOCIETATE_CASCO = _ID_SOCIETATE) OR (D.ID_SOCIETATE_RCA = _ID_SOCIETATE)))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super')) AND

                                (

                                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE) OR

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE )

                                )

                           )

                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Email')) AND

                                (

                                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE) OR

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE )

                                )

                           )



                      )) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetAllNeoperate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetAllNeoperate`(

       _AUTHENTICATED_USER_ID INT,

        _ID_SOCIETATE INT,

        _EXPIRATION_DAYS INT

)
BEGIN

        DECLARE _EXPIRATION_DATE DATETIME;

        

        IF _EXPIRATION_DAYS IS NULL THEN

                SET _EXPIRATION_DAYS = 15;

        END IF;



        SET _EXPIRATION_DATE = DATE_ADD(CURDATE(), INTERVAL _EXPIRATION_DAYS * -1 DAY);



        SELECT D.* FROM vDOSARE D

                WHERE (

                        (

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator')) OR

                        _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super')) OR

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Regular')) AND (D.ID IN (SELECT ID_DOSAR FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)))

                        )

                        AND

                        (

                                 (D.DATA_ULTIMEI_MODIFICARI IS NOT NULL AND D.DATA_ULTIMEI_MODIFICARI <= _EXPIRATION_DATE) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NOT NULL AND D.DATA_CREARE <= _EXPIRATION_DATE) OR

                                 (D.DATA_ULTIMEI_MODIFICARI IS NULL AND D.DATA_CREARE IS NULL)

                        ) AND

                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE OR (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE))

                );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT D.*,

                        ASIGC.DENUMIRE ASIGURAT_CASCO,

                        ASIGR.DENUMIRE ASIGURAT_RCA,

                        AC.NR_AUTO NR_AUTO_CASCO,

                        AR.NR_AUTO NR_AUTO_RCA,

                        SC.DENUMIRE ASIGURATOR_CASCO,

                        SR.DENUMIRE ASIGURATOR_RCA,

                        I.DENUMIRE INTERVENIENT,

                        TD.DENUMIRE TIP_DOSAR

                FROM vDOSARE D

                LEFT JOIN vASIGURATI ASIGC ON D.ID_ASIGURAT_CASCO=ASIGC.ID

                LEFT JOIN vASIGURATI ASIGR ON D.ID_ASIGURAT_RCA=ASIGR.ID

                LEFT JOIN vAUTO AC ON D.ID_AUTO_CASCO=AC.ID

                LEFT JOIN vAUTO AR ON D.ID_AUTO_RCA=AR.ID

                LEFT JOIN vSOCIETATI_ASIGURARE SC ON D.ID_SOCIETATE_CASCO=SC.ID

                LEFT JOIN vSOCIETATI_ASIGURARE SR ON D.ID_SOCIETATE_RCA=SR.ID

                LEFT JOIN vINTERVENIENTI I ON D.ID_INTERVENIENT=I.ID

                LEFT JOIN vTIP_DOSARE TD ON D.ID_TIP_DOSAR=TD.ID                        

        WHERE D.ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetByNrCasco` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetByNrCasco`(

        _AUTHENTICATED_USER_ID INT,

        _NR_CASCO VARCHAR(100)

    )
BEGIN

        SELECT * FROM vDOSARE WHERE NR_DOSAR_CASCO = _NR_CASCO LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetByNrDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetByNrDosar`(

        _AUTHENTICATED_USER_ID INT,

        _NR_DOSAR VARCHAR(100)

    )
BEGIN

        SELECT R.ID FROM vDOSARE R INNER JOIN vDOSARE_PROCESE RD ON R.ID=RD.ID_DOSAR INNER JOIN vPROCESE D ON RD.ID_PROCES=D.ID WHERE D.NR_DOSAR_INSTANTA = _NR_DOSAR LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetCascoFromLastLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetCascoFromLastLogin`(

       _AUTHENTICATED_USER_ID INT,

       _ID_SOCIETATE INT

)
BEGIN

        DECLARE _LAST_LOGIN DATETIME;

        SET _LAST_LOGIN = (SELECT LAST_LOGIN FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID);



        SELECT *  FROM vDOSARE D

                WHERE ((

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator')) AND (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super')) AND

                                (

                                        D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)

                                )

                           )

                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Email')) AND

                                (

                                        D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)

                                )

                           )



                        OR (

                                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Regular')) AND

                                (

                                        (

                                                D.ID_SOCIETATE_CASCO = _ID_SOCIETATE AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND

                                                        D.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                                        )

                                )

                           )



                      )) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE); -- AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetCascoNeasignate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetCascoNeasignate`(

       _AUTHENTICATED_USER_ID INT,

        _ID_SOCIETATE INT

)
BEGIN

        DECLARE _LAST_LOGIN DATETIME;

        SET _LAST_LOGIN = (SELECT LAST_LOGIN FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID);



        SELECT *  FROM vDOSARE D

                WHERE ((

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator')) AND ((D.ID_SOCIETATE_CASCO = _ID_SOCIETATE) ))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super')) AND

                                (

                                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE)

                                )

                           )

                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Email')) AND

                                (

                                        (D.ID_SOCIETATE_CASCO = _ID_SOCIETATE)

                                )

                           )



                      )) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetColumns` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetColumns`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SHOW COLUMNS FROM DOSARE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetDataUltimeiModificari` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetDataUltimeiModificari`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT)
BEGIN

        SELECT DATA_ULTIMEI_MODIFICARI FROM vDOSARE WHERE ID = _ID_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetImportDates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetImportDates`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT DISTINCT DATA_IMPORT FROM vIMPORT_LOG ORDER BY DATA_IMPORT DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetInvolvedParties` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetInvolvedParties`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT)
BEGIN

        SELECT ID FROM vUTILIZATORI WHERE ID_SOCIETATE IN (SELECT ID_SOCIETATE_CASCO FROM vDOSARE WHERE ID = _ID_DOSAR) OR ID_SOCIETATE IN (SELECT ID_SOCIETATE_RCA FROM vDOSARE WHERE ID = _ID_DOSAR)

        UNION

        

        SELECT ID_UTILIZATOR ID FROM vUTILIZATORI_DOSARE WHERE ID_DOSAR = _ID_DOSAR AND ID_UTILIZATOR NOT IN (SELECT ID FROM vUTILIZATORI WHERE ID_SOCIETATE IN (SELECT ID_SOCIETATE_CASCO FROM vDOSARE WHERE ID = _ID_DOSAR) OR ID_SOCIETATE IN (SELECT ID_SOCIETATE_RCA FROM vDOSARE WHERE ID = _ID_DOSAR))



        UNION

        SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM TIP_UTILIZATORI WHERE DENUMIRE = 'Administrator');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetRcaFromLastLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetRcaFromLastLogin`(

       _AUTHENTICATED_USER_ID INT,

       _ID_SOCIETATE INT

)
BEGIN

        DECLARE _LAST_LOGIN DATETIME;

        SET _LAST_LOGIN = (SELECT LAST_LOGIN FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID);



        SELECT *  FROM vDOSARE D

                WHERE ((

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator')) AND (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL)))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super')) AND

                                (

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND D.AVIZAT = TRUE )

                                )

                           )

                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Email')) AND

                                (

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND D.AVIZAT = TRUE )

                                )

                           )



                        OR (

                                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Regular')) AND

                                (

                                        (

                                                D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND (D.DATA_AVIZARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL) AND

                                                        (D.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID) AND D.AVIZAT = TRUE )

                                        )

                                )

                           )



                      )) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE); -- AND (D.DATA_CREARE >= _LAST_LOGIN OR _LAST_LOGIN IS NULL);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_GetRcaNeasignate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_GetRcaNeasignate`(

       _AUTHENTICATED_USER_ID INT,

        _ID_SOCIETATE INT

)
BEGIN

        DECLARE _LAST_LOGIN DATETIME;

        SET _LAST_LOGIN = (SELECT LAST_LOGIN FROM UTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID);



        SELECT *  FROM vDOSARE D

                WHERE ((

                        (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator')) AND ((D.ID_SOCIETATE_RCA = _ID_SOCIETATE)))



                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super')) AND

                                (

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE )

                                )

                           )

                        OR (_AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Email')) AND

                                (

                                        (D.ID_SOCIETATE_RCA = _ID_SOCIETATE AND D.AVIZAT = TRUE )

                                )

                           )

                      )) AND D.ID NOT IN (SELECT ID_DOSAR FROM UTILIZATORI_DOSARE);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_import` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_import`(

        _AUTHENTICATED_USER_ID INT,

        _NR_SCA VARCHAR(100),

        _DATA_SCA DATETIME,

        _ID_ASIGURAT_CASCO INT,

        _ASIGURAT_CASCO varchar(250),

        _NR_POLITA_CASCO VARCHAR(100),

        _ID_AUTO_CASCO INT,

        _NR_AUTO_CASCO VARCHAR(45),

        _ID_SOCIETATE_CASCO INT,

        _NR_POLITA_RCA VARCHAR(100),

        _ID_AUTO_RCA INT,

        _NR_AUTO_RCA VARCHAR(45),

        _VALOARE_DAUNA DOUBLE,

        _VALOARE_REGRES DOUBLE,

        _ID_INTERVENIENT INT,

        _INTERVENIENT VARCHAR(250),

        _NR_DOSAR_CASCO VARCHAR(100),

        _VMD DOUBLE,

        _OBSERVATII TEXT,

        _ID_SOCIETATE_RCA INT,

        _DATA_EVENIMENT DATETIME,

        _REZERVA_DAUNA DOUBLE,

        _DATA_INTRARE_RCA DATETIME,

        _DATA_IESIRE_CASCO DATETIME,

        _NR_INTRARE_RCA VARCHAR(100),

        _NR_IESIRE_CASCO VARCHAR(100),

        _ID_ASIGURAT_RCA INT,

        _ASIGURAT_RCA VARCHAR(250),

        _ID_TIP_DOSAR INT,

        _SUMA_IBNR DOUBLE,

        _DATA_AVIZARE DATETIME,

        _DATA_NOTIFICARE DATETIME,

        _DATA_CREARE DATETIME,

        _LOC_ACCIDENT TEXT,

        OUT _ID INT

    )
BEGIN



        INSERT INTO DOSARE SET

        NR_SCA =_NR_SCA,

        DATA_SCA = _DATA_SCA,

        ID_ASIGURAT_CASCO = _ID_ASIGURAT_CASCO,

        NR_POLITA_CASCO = _NR_POLITA_CASCO,

        ID_AUTO_CASCO = _ID_AUTO_CASCO,

        ID_SOCIETATE_CASCO = _ID_SOCIETATE_CASCO,

        NR_POLITA_RCA = _NR_POLITA_RCA,

        ID_AUTO_RCA = _ID_AUTO_RCA,

        VALOARE_DAUNA = _VALOARE_DAUNA,

        VALOARE_REGRES = _VALOARE_REGRES,

        ID_INTERVENIENT = _ID_INTERVENIENT,

        NR_DOSAR_CASCO = _NR_DOSAR_CASCO,

        VMD = _VMD,

        OBSERVATII = _OBSERVATII,

        ID_SOCIETATE_RCA = _ID_SOCIETATE_RCA,

        DATA_EVENIMENT = _DATA_EVENIMENT,

        REZERVA_DAUNA = _REZERVA_DAUNA,

        DATA_INTRARE_RCA = _DATA_INTRARE_RCA,

        DATA_IESIRE_CASCO = _DATA_IESIRE_CASCO,

        NR_INTRARE_RCA = _NR_INTRARE_RCA,

        NR_IESIRE_CASCO = _NR_IESIRE_CASCO,

        ID_ASIGURAT_RCA = _ID_ASIGURAT_RCA,

        ID_TIP_DOSAR = _ID_TIP_DOSAR,

        SUMA_IBNR = _SUMA_IBNR,

        DATA_AVIZARE = _DATA_AVIZARE,

        DATA_NOTIFICARE = _DATA_NOTIFICARE,

        DATA_CREARE = _DATA_CREARE,

        LOC_ACCIDENT = _LOC_ACCIDENT;



        

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_import_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_import_log`(

        _AUTHENTICATED_USER_ID INT,

        _STATUS BOOL,

        _MESSAGE TEXT,

        _INSERTED_ID INT,

        _ERRORS TEXT,

        _DATA_IMPORT DATETIME,

        _IMPORT_TYPE INT,

        OUT _ID INT

)
BEGIN

        INSERT INTO IMPORT_LOG SET

                `STATUS` = _STATUS,

                MESSAGE = _MESSAGE,

                INSERTED_ID = _INSERTED_ID,

                `ERRORS` = _ERRORS,

                IMPORT_TYPE = _IMPORT_TYPE,

                DATA_IMPORT = _DATA_IMPORT;

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _NR_SCA VARCHAR(100),

        _DATA_SCA DATETIME,

        _ID_ASIGURAT_CASCO INT,

        

        _NR_POLITA_CASCO VARCHAR(100),

        _ID_AUTO_CASCO INT,

        

        _ID_SOCIETATE_CASCO INT,

        _NR_POLITA_RCA VARCHAR(100),

        _ID_AUTO_RCA INT,

        

        _VALOARE_DAUNA DOUBLE,

        _VALOARE_REGRES DOUBLE,

        _ID_INTERVENIENT INT,

        

        _NR_DOSAR_CASCO VARCHAR(100),

        _VMD DOUBLE,

        _OBSERVATII TEXT,

        _ID_SOCIETATE_RCA INT,

        _DATA_EVENIMENT DATETIME,

        _REZERVA_DAUNA DOUBLE,

        _DATA_INTRARE_RCA DATETIME,

        _DATA_IESIRE_CASCO DATETIME,

        _NR_INTRARE_RCA VARCHAR(100),

        _NR_IESIRE_CASCO VARCHAR(100),

        _ID_ASIGURAT_RCA INT,

        

        _ID_TIP_DOSAR INT,

        _SUMA_IBNR DOUBLE,

        _DATA_AVIZARE DATETIME,

        _DATA_NOTIFICARE DATETIME,

        _AVIZAT BOOLEAN,

        _CAZ VARCHAR(100),

        _DATA_ULTIMEI_MODIFICARI DATETIME,

        _DATA_CREARE DATETIME,

        _LOC_ACCIDENT TEXT,

        OUT _ID INT

    )
BEGIN

        



        



        INSERT INTO DOSARE SET

        NR_SCA =_NR_SCA,

        DATA_SCA = _DATA_SCA,

        

        ID_ASIGURAT_CASCO = _ID_ASIGURAT_CASCO,

        NR_POLITA_CASCO = _NR_POLITA_CASCO,

        

        ID_AUTO_CASCO = _ID_AUTO_CASCO,

        ID_SOCIETATE_CASCO = _ID_SOCIETATE_CASCO,

        NR_POLITA_RCA = _NR_POLITA_RCA,

        

        ID_AUTO_RCA = _ID_AUTO_RCA,

        VALOARE_DAUNA = _VALOARE_DAUNA,

        VALOARE_REGRES = _VALOARE_REGRES,

        

        ID_INTERVENIENT = _ID_INTERVENIENT,

        NR_DOSAR_CASCO = _NR_DOSAR_CASCO,

        VMD = _VMD,

        OBSERVATII = _OBSERVATII,

        ID_SOCIETATE_RCA = _ID_SOCIETATE_RCA,

        DATA_EVENIMENT = _DATA_EVENIMENT,

        REZERVA_DAUNA = _REZERVA_DAUNA,

        DATA_INTRARE_RCA = _DATA_INTRARE_RCA,

        DATA_IESIRE_CASCO = _DATA_IESIRE_CASCO,

        NR_INTRARE_RCA = _NR_INTRARE_RCA,

        NR_IESIRE_CASCO = _NR_IESIRE_CASCO,

        

        ID_ASIGURAT_RCA = _ID_ASIGURAT_RCA,

        ID_TIP_DOSAR = _ID_TIP_DOSAR,

        SUMA_IBNR = _SUMA_IBNR,

        DATA_AVIZARE = _DATA_AVIZARE,

        DATA_NOTIFICARE = _DATA_NOTIFICARE,

        AVIZAT = IFNULL(_AVIZAT, FALSE),

        CAZ = _CAZ,

        LOC_ACCIDENT = _LOC_ACCIDENT,

        DATA_ULTIMEI_MODIFICARI = _DATA_ULTIMEI_MODIFICARI,

        DATA_CREARE = _DATA_CREARE;



        

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_IsAssigned` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_IsAssigned`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT

)
BEGIN

        DECLARE _IS_ASSIGNED BOOL;

        DECLARE _CNT INT;

        SET _IS_ASSIGNED = FALSE;

        SET _CNT = (SELECT COUNT(*) FROM UTILIZATORI_DOSARE WHERE ID_DOSAR = _ID_DOSAR);

        IF _CNT > 0 THEN

                SET _IS_ASSIGNED = TRUE;

        END IF;

        SELECT _IS_ASSIGNED;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_MovePendingToOk` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_MovePendingToOk`(

        _AUTHENTICATED_USER_ID INT,

        _PENDING_ID INT,

        OUT _ID INT

)
BEGIN

        DECLARE _MAX_ID, _CUR_ID, _LAST_INSERTED_DOCUMENT_ID INT;

        INSERT INTO DOSARE (NR_SCA,DATA_SCA,ID_ASIGURAT_CASCO,NR_POLITA_CASCO,ID_AUTO_CASCO,ID_SOCIETATE_CASCO,NR_POLITA_RCA,ID_AUTO_RCA,VALOARE_DAUNA,VALOARE_REGRES,ID_INTERVENIENT,NR_DOSAR_CASCO,VMD,OBSERVATII,ID_SOCIETATE_RCA,DATA_EVENIMENT,REZERVA_DAUNA,DATA_INTRARE_RCA,DATA_IESIRE_CASCO,NR_INTRARE_RCA,NR_IESIRE_CASCO,ID_ASIGURAT_RCA,ID_TIP_DOSAR,SUMA_IBNR,DATA_AVIZARE,DATA_NOTIFICARE,DATA_ULTIMEI_MODIFICARI,AVIZAT,CAZ,DATA_CREARE)

                SELECT NR_SCA,DATA_SCA,ID_ASIGURAT_CASCO,NR_POLITA_CASCO,ID_AUTO_CASCO,ID_SOCIETATE_CASCO,NR_POLITA_RCA,ID_AUTO_RCA,VALOARE_DAUNA,VALOARE_REGRES,ID_INTERVENIENT,NR_DOSAR_CASCO,VMD,OBSERVATII,ID_SOCIETATE_RCA,DATA_EVENIMENT,REZERVA_DAUNA,DATA_INTRARE_RCA,DATA_IESIRE_CASCO,NR_INTRARE_RCA,NR_IESIRE_CASCO,ID_ASIGURAT_RCA,ID_TIP_DOSAR,SUMA_IBNR,DATA_AVIZARE,DATA_NOTIFICARE,DATA_ULTIMEI_MODIFICARI,AVIZAT,CAZ,DATA_CREARE

                FROM PENDING_IMPORT_ERRORS WHERE ID = _PENDING_ID;

        SET _ID = LAST_INSERT_ID();

        -- UPDATE PENDING_IMPORT_ERRORS SET `deleted`=true WHERE ID = _PENDING_ID;

        UPDATE IMPORT_LOG SET `STATUS`=true, `MESSAGE`=null, `ERRORS`=null, INSERTED_ID = _ID WHERE INSERTED_ID = _PENDING_ID;



        SET _MAX_ID = (SELECT MAX(ID) FROM vPENDING_DOCUMENTE_SCANATE_IMPORTS WHERE ID_DOSAR = _PENDING_ID);

        WHILE _MAX_ID > 0 DO

                SET _CUR_ID = (SELECT ID FROM vPENDING_DOCUMENTE_SCANATE_IMPORTS WHERE ID = _MAX_ID AND ID_DOSAR = _PENDING_ID);

                IF _CUR_ID IS NOT NULL THEN

                        INSERT INTO `documente_scanate` (`DENUMIRE_FISIER`,`EXTENSIE_FISIER`,`DATA_INCARCARE`,`DIMENSIUNE_FISIER`,`ID_TIP_DOCUMENT`,`ID_DOSAR`,`DETALII`,`VIZA_CASCO`,`FILE_CONTENT`,`SMALL_ICON`,`MEDIUM_ICON`,`CALE_FISIER`)

                        SELECT `DENUMIRE_FISIER`,`EXTENSIE_FISIER`,`DATA_INCARCARE`,`DIMENSIUNE_FISIER`,`ID_TIP_DOCUMENT`,_ID,`DETALII`,`VIZA_CASCO`,`FILE_CONTENT`,`SMALL_ICON`,`MEDIUM_ICON`,`CALE_FISIER`

                                FROM vpending_documente_scanate_imports WHERE ID = _CUR_ID;

                        SET _LAST_INSERTED_DOCUMENT_ID = LAST_INSERT_ID();

                        -- UPDATE `pending_documente_scanate_imports` SET `deleted`=true WHERE ID = _CUR_ID;

                        UPDATE IMPORT_DOCUMENTE_SCANATE_LOG SET `STATUS` = true, `MESSAGE` = null, `ERRORS` = null, INSERTED_ID = _LAST_INSERTED_DOCUMENT_ID WHERE INSERTED_ID = _CUR_ID;

                END IF;

                SET _MAX_ID = _MAX_ID - 1;

        END WHILE;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(8000),

        _LIMIT VARCHAR(1000)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);

        DECLARE _QUERY VARCHAR(8000);



        SET @_DEFAULT_FILTER = CONCAT('(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID_UTILIZATOR FROM vUTILIZATORI_DREPTURI WHERE ID_DREPT IN (SELECT ID FROM vDREPTURI WHERE UPPER(DENUMIRE)=''VIZUALIZARE'')) OR ', _AUTHENTICATED_USER_ID, ' IN (SELECT ID_UTILIZATOR FROM vUTILIZATORI_DREPTURI WHERE ID_DREPT IN (SELECT ID FROM vDREPTURI WHERE UPPER(DENUMIRE)=''ADMINISTRARE''))) AND ');



        

        SET @_DEFAULT_FILTER = CONCAT('(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE)=''ADMINISTRATOR'')) OR ');



        

        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER, '(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE ''%SUPER%'')) AND

                (DOSARE.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') OR (DOSARE.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') AND DOSARE.AVIZAT = TRUE)) ) OR ');





        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER, '(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE ''%EMAIL%'')) AND

                (DOSARE.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') OR (DOSARE.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') AND DOSARE.AVIZAT = TRUE)) ) OR ');



        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER,

                '(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE ''%REGULAR%'')) AND

                        (

                                (DOSARE.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') AND DOSARE.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, ')) OR

                                (DOSARE.AVIZAT = TRUE AND DOSARE.ID_SOCIETATE_RCA IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') AND DOSARE.ID_SOCIETATE_CASCO IN (SELECT ID_SOCIETATE FROM vUTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, '))');

                                -- AND DOSARE.ID IN (SELECT ID_DOSAR FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR=', _AUTHENTICATED_USER_ID, ')

        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER,

                        ')



                ) )');



        /*

        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' DOSARE.DATA_AVIZARE DESC ';

        END IF;

        */



        SET @_QUERY = 'SELECT DOSARE.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vDOSARE DOSARE ',

                

                

                'LEFT JOIN vASIGURATI ASIGC ON DOSARE.ID_ASIGURAT_CASCO=ASIGC.ID ',

                'LEFT JOIN vASIGURATI ASIGR ON DOSARE.ID_ASIGURAT_RCA=ASIGR.ID ',

                'LEFT JOIN vAUTO AC ON DOSARE.ID_AUTO_CASCO=AC.ID ',

                'LEFT JOIN vAUTO AR ON DOSARE.ID_AUTO_RCA=AR.ID ',

                'LEFT JOIN vSOCIETATI_ASIGURARE SC ON DOSARE.ID_SOCIETATE_CASCO=SC.ID ',

                'LEFT JOIN vSOCIETATI_ASIGURARE SR ON DOSARE.ID_SOCIETATE_RCA=SR.ID ',

                'LEFT JOIN vINTERVENIENTI I ON DOSARE.ID_INTERVENIENT=I.ID ',

                'LEFT JOIN vTIP_DOSARE TD ON DOSARE.ID_TIP_DOSAR=TD.ID '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        CASE WHEN _SORT = 'ASIGURAT_CASCO' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ASIGC.DENUMIRE');

                        WHEN _SORT = 'ASIGURAT_RCA' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ASIGR.DENUMIRE');

                        WHEN _SORT = 'ASIGURATOR_CASCO' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY SC.DENUMIRE');

                        WHEN _SORT = 'ASIGURATOR_RCA' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY SR.DENUMIRE');

                        WHEN _SORT = 'INTERVENIENT' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY I.DENUMIRE');

                        WHEN _SORT = 'NR_AUTO_CASCO' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY AC.NR_AUTO');

                        WHEN _SORT = 'NR_AUTO_RCA' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY AR.NR_AUTO');

                        WHEN _SORT = 'TIP_DOSAR' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY TD.DENUMIRE');

                        ELSE

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                        END CASE;

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY; 

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

         

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_SetDataUltimeiModificari` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_SetDataUltimeiModificari`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _DATA_ULTIMEI_MODIFICARI DATETIME

)
BEGIN

        UPDATE DOSARE SET DATA_ULTIMEI_MODIFICARI = _DATA_ULTIMEI_MODIFICARI WHERE ID = _ID_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE dosare SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSAREsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSAREsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _NR_SCA VARCHAR(100),

        _DATA_SCA DATETIME,

        _ID_ASIGURAT_CASCO INT,

        

        _NR_POLITA_CASCO VARCHAR(100),

        _ID_AUTO_CASCO INT,

        

        _ID_SOCIETATE_CASCO INT,

        _NR_POLITA_RCA VARCHAR(100),

        _ID_AUTO_RCA INT,

        

        _VALOARE_DAUNA DOUBLE,

        _VALOARE_REGRES DOUBLE,

        _ID_INTERVENIENT INT,



        _NR_DOSAR_CASCO VARCHAR(100),

        _VMD DOUBLE,

        _OBSERVATII TEXT,

        _ID_SOCIETATE_RCA INT,

        _DATA_EVENIMENT DATETIME,

        _REZERVA_DAUNA DOUBLE,

        _DATA_INTRARE_RCA DATETIME,

        _DATA_IESIRE_CASCO DATETIME,

        _NR_INTRARE_RCA VARCHAR(100),

        _NR_IESIRE_CASCO VARCHAR(100),

        _ID_ASIGURAT_RCA INT,

        

        _ID_TIP_DOSAR INT,

        _SUMA_IBNR DOUBLE,

        _DATA_AVIZARE DATETIME,

        _DATA_NOTIFICARE DATETIME,

        _AVIZAT BOOLEAN,

        _CAZ VARCHAR(100),

        _DATA_ULTIMEI_MODIFICARI DATETIME,

        -- _DATA_CREARE DATETIME

        _LOC_ACCIDENT TEXT

    )
BEGIN

        



        



        UPDATE DOSARE SET

        NR_SCA =_NR_SCA,

        DATA_SCA = _DATA_SCA,

        

        ID_ASIGURAT_CASCO = _ID_ASIGURAT_CASCO,

        NR_POLITA_CASCO = _NR_POLITA_CASCO,

        

        ID_AUTO_CASCO = _ID_AUTO_CASCO,

        ID_SOCIETATE_CASCO = _ID_SOCIETATE_CASCO,

        NR_POLITA_RCA = _NR_POLITA_RCA,

        

        ID_AUTO_RCA = _ID_AUTO_RCA,

        VALOARE_DAUNA = _VALOARE_DAUNA,

        VALOARE_REGRES = _VALOARE_REGRES,

        

        ID_INTERVENIENT = _ID_INTERVENIENT,

        NR_DOSAR_CASCO = _NR_DOSAR_CASCO,

        VMD = _VMD,

        OBSERVATII = _OBSERVATII,

        ID_SOCIETATE_RCA = _ID_SOCIETATE_RCA,

        DATA_EVENIMENT = _DATA_EVENIMENT,

        REZERVA_DAUNA = _REZERVA_DAUNA,

        DATA_INTRARE_RCA = _DATA_INTRARE_RCA,

        DATA_IESIRE_CASCO = _DATA_IESIRE_CASCO,

        NR_INTRARE_RCA = _NR_INTRARE_RCA,

        NR_IESIRE_CASCO = _NR_IESIRE_CASCO,

        

        ID_ASIGURAT_RCA = _ID_ASIGURAT_RCA,

        ID_TIP_DOSAR = _ID_TIP_DOSAR,

        SUMA_IBNR = _SUMA_IBNR,

        DATA_AVIZARE = _DATA_AVIZARE,

        DATA_NOTIFICARE = _DATA_NOTIFICARE,

        AVIZAT = IFNULL(_AVIZAT, FALSE),

        CAZ = _CAZ,

        DATA_ULTIMEI_MODIFICARI = _DATA_ULTIMEI_MODIFICARI,

        -- DATA_CREARE = _DATA_CREARE

        LOC_ACCIDENT = _LOC_ACCIDENT

        WHERE ID = _ID;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_CONTRACTEsp_DeleteByIds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_CONTRACTEsp_DeleteByIds`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_CONTRACT INT

    )
BEGIN

        DELETE FROM DOSARE_CONTRACTE

        WHERE ID_DOSAR = _ID_DOSAR AND ID_CONTRACT = _ID_CONTRACT;

        CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_CONTRACTEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_CONTRACTEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_CONTRACT INT,

        OUT _ID INT

    )
BEGIN

        INSERT INTO DOSARE_CONTRACTE

        SET ID_DOSAR = _ID_DOSAR,

        ID_CONTRACT = _ID_CONTRACT;



        


        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM dosare_plati;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATIsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM DOSARE_PLATI

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATIsp_DeleteByIds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATIsp_DeleteByIds`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_PLATA INT

    )
BEGIN

        DELETE FROM DOSARE_PLATI

        WHERE ID_DOSAR = _ID_DOSAR AND ID_PLATA = _ID_PLATA;

        CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATIsp_GetByIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATIsp_GetByIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT)
BEGIN

        SELECT * FROM vDOSARE_PLATI WHERE ID_DOSAR = _ID_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_PLATA INT,

        OUT _ID INT

    )
BEGIN

        INSERT INTO DOSARE_PLATI

        SET ID_DOSAR = _ID_DOSAR,

        ID_PLATA = _ID_PLATA;



        SET _ID = LAST_INSERT_ID();

        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATIsp_IsImported` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATIsp_IsImported`(

        _AUTHENTICATED_USER_ID INT,

        _NR_AZT VARCHAR(250),

        _AUTO_AZT VARCHAR(250),

        _POLITA_AZT VARCHAR(250)

    )
BEGIN

        DECLARE _VAL VARCHAR(250);

        SET _VAL = (SELECT NR_AZT FROM vDOSARE WHERE NR_AZT = _NR_AZT);

        IF _VAL IS NULL THEN

                BEGIN

                SET _VAL = (SELECT NR_AZT FROM vDOSARE WHERE POLITA_AZT = _POLITA_AZT);

                IF _VAL IS NULL THEN

                        SET _VAL = (SELECT NR_AZT FROM vDOSARE WHERE AUTO_AZT = _AUTO_AZT);

                END IF;

                END;

        END IF;

        SELECT _VAL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATIsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

)
BEGIN

        SELECT * FROM vDOSARE_PLATI;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE dosare_plati SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATI_CONTRACTEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATI_CONTRACTEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM dosare_plati_contracte;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATI_CONTRACTEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATI_CONTRACTEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        DELETE FROM DOSARE_PLATI_CONTRACTE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATI_CONTRACTEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATI_CONTRACTEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_PLATA_CONTRACT INT,

        OUT _ID INT

)
BEGIN

        INSERT INTO DOSARE_PLATI_CONTRACTE SET

                ID_DOSAR = _ID_DOSAR, ID_PLATA_CONTRACT = _ID_PLATA_CONTRACT;



        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PLATI_CONTRACTEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PLATI_CONTRACTEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE dosare_plati_contracte SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PORTALsp_ChangeMonitorizare` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PORTALsp_ChangeMonitorizare`(

        _AUTHENTICATED_USER_ID INT,

        _NR_DOSAR VARCHAR(100),

        _MONITORIZARE BOOL

)
BEGIN

        UPDATE DOSARE_PORTAL SET MONITORIZARE=_MONITORIZARE WHERE NR_DOSAR=_NR_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PORTALsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PORTALsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM dosare_portal;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PORTALsp_CountDepasite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PORTALsp_CountDepasite`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(DISTINCT DP.NR_DOSAR) CNT FROM DOSARE_PORTAL DP

        INNER JOIN (SELECT MAX(ID) ID FROM DOSARE_PORTAL WHERE DATA_SEDINTA < CURDATE() GROUP BY NR_DOSAR ) DP1 ON DP.ID=DP1.ID        

        
        LEFT OUTER JOIN REGRESE_STADII RS ON DP.ID_REGRES=RS.ID_REGRES AND DP.DATA_SEDINTA=RS.DATA

        WHERE DP.DATA_SEDINTA < CURDATE() AND

                UPPER(COMPLET) NOT LIKE '%ADMINISTRATIV%' AND

                RS.DATA IS NULL AND

                TRIM(DP.NR_DOSAR) IN (SELECT DISTINCT NR_DOSAR FROM DOSARE) AND

                DP.MONITORIZARE=TRUE;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PORTALsp_ESincronizat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PORTALsp_ESincronizat`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) CNT FROM DOSARE_PORTAL WHERE DATA=CURDATE();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PORTALsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PORTALsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _DATA DATETIME,

        _NR_DOSAR VARCHAR(100),

        _DATA_SEDINTA DATETIME,

        _NR_SCA INT,

        _DATA_SCA DATETIME,

        _INSTANTA VARCHAR(100),

        _ORA VARCHAR(10),

        _COMPLET VARCHAR(100),

        OUT _ID INT

        )
BEGIN

        DECLARE _ID_REGRES INT;

        SET _ID = NULL;

        SET _ID_REGRES = (SELECT ID_REGRES FROM REGRESE_DOSARE RD INNER JOIN DOSARE D ON RD.ID_DOSAR=D.ID WHERE D.NR_DOSAR=_NR_DOSAR LIMIT 1);

        IF NOT EXISTS (SELECT ID FROM DOSARE_PORTAL WHERE DATA = _DATA AND NR_DOSAR = _NR_DOSAR AND ID_REGRES = _ID_REGRES AND DATA_SEDINTA=_DATA_SEDINTA) THEN

                BEGIN

                INSERT INTO DOSARE_PORTAL SET DATA=_DATA, NR_DOSAR=_NR_DOSAR, ID_REGRES=_ID_REGRES, DATA_SEDINTA=_DATA_SEDINTA,

                        NR_SCA=_NR_SCA, DATA_SCA=_DATA_SCA, INSTANTA=_INSTANTA, ORA=_ORA, COMPLET=_COMPLET, MONITORIZARE=TRUE;



                SET _ID = LAST_INSERT_ID();

                END;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PORTALsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PORTALsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _DATA DATETIME)
BEGIN

        SELECT * FROM vDOSARE_PORTAL WHERE DATA=_DATA;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PORTALsp_SelectDepasite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PORTALsp_SelectDepasite`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT DP.* FROM DOSARE_PORTAL DP

        INNER JOIN (SELECT MAX(ID) ID FROM DOSARE_PORTAL WHERE DATA_SEDINTA < CURDATE() GROUP BY NR_DOSAR ) DP1 ON DP.ID=DP1.ID

        
        LEFT OUTER JOIN REGRESE_STADII RS ON DP.ID_REGRES=RS.ID_REGRES AND DP.DATA_SEDINTA=RS.DATA

        WHERE DP.DATA_SEDINTA < CURDATE() AND RS.DATA IS NULL AND TRIM(DP.NR_DOSAR) IN (SELECT DISTINCT NR_DOSAR FROM DOSARE);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PORTALsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PORTALsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE dosare_portal SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM dosare_procese;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_CountDosare2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_CountDosare2`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _DATA DATETIME)
BEGIN

        IF _ID_UTILIZATOR IN (SELECT U.ID FROM UTILIZATORI U INNER JOIN UTILIZATORI_DREPTURI UD ON U.ID=UD.ID_UTILIZATOR INNER JOIN DREPTURI D ON UD.ID_DREPT=D.ID WHERE LOWER(D.DENUMIRE)='administrare') THEN

                BEGIN

                SELECT COUNT(*) CNT FROM PROCESE_PORTAL WHERE DATA=_DATA AND UPPER(COMPLET) NOT LIKE '%ADMINISTRATIV%';

                END;

        ELSE

                BEGIN

                SELECT COUNT(*) CNT FROM PROCESE_PORTAL DP

                INNER JOIN (SELECT UR.ID_DOSAR FROM UTILIZATORI_DOSARE UR WHERE ID_UTILIZATOR=_ID_UTILIZATOR) U1 ON DP.ID_DOSAR=U1.ID_DOSAR

                WHERE DP.DATA=_DATA AND UPPER(COMPLET) NOT LIKE '%ADMINISTRATIV%';

                END;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        DELETE FROM DOSARE_PROCESE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_DeleteByIds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_DeleteByIds`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_PROCES INT

    )
BEGIN

        DELETE FROM DOSARE_PROCESE

        WHERE ID_DOSAR = _ID_DOSAR AND ID_PROCES = _ID_PROCES;



        CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_GetByIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_GetByIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT)
BEGIN

        SELECT * FROM DOSARE_PROCESE WHERE ID_DOSAR = _ID_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_PROCES INT,

        OUT _ID INT

    )
BEGIN

        INSERT INTO DOSARE_PROCESE

        SET ID_DOSAR = _ID_DOSAR,

        ID_PROCES = _ID_PROCES;

        SET _ID = LAST_INSERT_ID();



        


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

)
BEGIN

        SELECT * FROM DOSARE_PROCESE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_SelectDosare` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_SelectDosare`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT)
BEGIN

        IF _ID_UTILIZATOR IN (SELECT U.ID FROM UTILIZATORI U INNER JOIN UTILIZATORI_DREPTURI UD ON U.ID=UD.ID_UTILIZATOR INNER JOIN DREPTURI D ON UD.ID_DREPT=D.ID WHERE LOWER(D.DENUMIRE)='administrare') THEN

                BEGIN

                select d.nr_dosar_instanta, r.nr_intern, r.data_sca, i.denumire instanta from procese d

                inner join instante i on d.id_instanta=i.id

                inner join dosare_procese rd on d.id=rd.id_proces

                inner join dosare r on rd.id_regres=r.id

                inner join dosare_stadii rs on r.id=rs.id_regres

                inner join (select id_regres, max(data) data from dosare_stadii group by id_regres) rs1 on rs.id_regres=rs1.id_regres and rs.data=rs1.data

                inner join stadii s on rs.id_stadiu=s.id

                where s.stadiu_instanta=1 and s.stadiu_cu_termen=1 AND D.MONITORIZARE=1;

                END;

        ELSE

                BEGIN

                select d.nr_dosar_instanta, r.nr_intern, r.data_sca, i.denumire instanta from procese d

                inner join instante i on d.id_instanta=i.id

                inner join dosare_procese rd on d.id=rd.id_proces

                inner join dosare r on rd.id_regres=r.id

                inner join dosare_stadii rs on r.id=rs.id_regres

                inner join (select id_regres, max(data) data from dosare_stadii group by id_regres) rs1 on rs.id_regres=rs1.id_regres and rs.data=rs1.data

                inner join stadii s on rs.id_stadiu=s.id

                INNER JOIN (SELECT UR.ID_DOSAR FROM UTILIZATORI_DOSARE UR WHERE ID_UTILIZATOR=_ID_UTILIZATOR) U1 ON R.ID=U1.ID_DOSAR

                where s.stadiu_instanta=1 and s.stadiu_cu_termen=1 AND D.MONITORIZARE=1;

                END;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_SelectDosare2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_SelectDosare2`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _DATA DATETIME)
BEGIN

        IF _ID_UTILIZATOR IN (SELECT U.ID FROM UTILIZATORI U INNER JOIN UTILIZATORI_DREPTURI UD ON U.ID=UD.ID_UTILIZATOR INNER JOIN DREPTURI D ON UD.ID_DREPT=D.ID WHERE LOWER(D.DENUMIRE)='administrare') THEN

                BEGIN

                SELECT * FROM PROCESE_PORTAL WHERE DATA=_DATA;

                END;

        ELSE

                BEGIN

                SELECT DP.* FROM PROCESE_PORTAL DP

                INNER JOIN (SELECT UR.ID_DOSAR FROM UTILIZATORI_DOSARE UR WHERE ID_UTILIZATOR=_ID_UTILIZATOR) U1 ON DP.ID_DOSAR=U1.ID_DOSAR

                WHERE DP.DATA=_DATA;

                END;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_SelectDosareAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_SelectDosareAll`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN



                select d.nr_dosar_instanta, r.nr_intern, r.data_sca, i.denumire instanta from procese d

                inner join instante i on d.id_instanta=i.id

                inner join dosare_procese rd on d.id=rd.id_proces

                inner join dosare r on rd.id_regres=r.id

                inner join dosare_stadii rs on r.id=rs.id_regres

                inner join (select id_regres, max(data) data from dosare_stadii group by id_regres) rs1 on rs.id_regres=rs1.id_regres and rs.data=rs1.data

                inner join stadii s on rs.id_stadiu=s.id

                where s.stadiu_instanta=1 and s.stadiu_cu_termen=1 AND D.MONITORIZARE=1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_PROCESEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_PROCESEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE dosare_procese SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM dosare_stadii;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM DOSARE_STADII WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_delete_from_portal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_delete_from_portal`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _ID_DOSAR INT,

        _ID_DOSAR_STADIU INT,

        _ID_SENTINTA INT,

        _ID_SOLUTIE INT

    )
BEGIN

        DELETE FROM DOSARE_STADII_SENTINTE WHERE ID_DOSAR_STADIU = _ID_DOSAR_STADIU AND ID_SENTINTA=_ID_SENTINTA;

        DELETE FROM SENTINTE WHERE ID=_ID_SENTINTA;

        DELETE FROM SOLUTII WHERE ID=_ID_SOLUTIE;

        DELETE FROM DOSARE_STADII WHERE ID=_ID_DOSAR_STADIU;

        UPDATE TEMP_TO_IMPORT SET ID_DOSAR_STADIU=NULL, ID_SENTINTA=NULL, ID_SOLUTIE=NULL WHERE ID=_ID;



        CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_delete_from_portal2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_delete_from_portal2`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _ID_DOSAR INT,

        _ID_DOSAR_STADIU INT,

        _ID_SENTINTA INT,

        _ID_SOLUTIE INT

    )
BEGIN

        UPDATE DOSARE_STADII SET TERMEN=NULL, SCADENTA=NULL WHERE ID=_ID_DOSAR_STADIU;

        UPDATE TEMP_TO_IMPORT SET ID_DOSAR_STADIU=NULL, ID_SENTINTA=NULL, ID_SOLUTIE=NULL WHERE ID=_ID;



        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_GetByIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_GetByIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT)
BEGIN

        SELECT * FROM DOSARE_STADII WHERE ID_DOSAR = _ID_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_STADIU INT,

        _DATA DATETIME,

        _SCADENTA DATETIME,

        _TERMEN DATETIME,

        _TERMEN_ADMINISTRATIV DATETIME,

        _OBSERVATII TEXT,

        _ORA VARCHAR(5),

        OUT _ID INT

    )
BEGIN

        INSERT INTO DOSARE_STADII

                SET ID_DOSAR = _ID_DOSAR,

                ID_STADIU = _ID_STADIU,

                DATA = _DATA,

                SCADENTA = _SCADENTA,

                TERMEN = _TERMEN,

                TERMEN_ADMINISTRATIV = _TERMEN_ADMINISTRATIV,

                OBSERVATII = _OBSERVATII,

                ORA = _ORA;

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_insert_from_portal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_insert_from_portal`(

        _AUTHENTICATED_USER_ID INT,        

        _ID_DOSAR INT,

        _ID_STADIU INT,

        _DATA DATETIME,

        _SCADENTA DATETIME,

        _TERMEN DATETIME,

        _TERMEN_ADMINISTRATIV DATETIME,

        _OBSERVATII TEXT,

        _ORA VARCHAR(5),

        _NR_SENTINTA VARCHAR(45),

        _DATA_SENTINTA DATETIME,

        _DATA_COMUNICARE DATETIME,

        _SOLUTIE TEXT

    )
BEGIN

        DECLARE _ID_DOSAR_STADIU INT;

        DECLARE _ID_SOLUTIE INT;

        DECLARE _ID_SENTINTA INT;



        IF _SOLUTIE IS NOT NULL THEN

                BEGIN

                INSERT INTO SOLUTII SET DENUMIRE = _SOLUTIE;

                SET _ID_SOLUTIE = LAST_INSERT_ID();

                END;

        END IF;



        INSERT INTO DOSARE_STADII

                SET ID_DOSAR = _ID_DOSAR,

                ID_STADIU = _ID_STADIU,

                DATA = _DATA,

                SCADENTA = _SCADENTA,

                TERMEN = _TERMEN,

                TERMEN_ADMINISTRATIV = _TERMEN_ADMINISTRATIV,

                OBSERVATII = _OBSERVATII,

                ORA = _ORA;

        SET _ID_DOSAR_STADIU = LAST_INSERT_ID();



        IF _NR_SENTINTA IS NOT NULL THEN

                BEGIN

                INSERT INTO SENTINTE SET

                        NR_SENTINTA = _NR_SENTINTA,

                        DATA_SENTINTA = _DATA_SENTINTA,

                        DATA_COMUNICARE = _DATA_COMUNICARE,

                        ID_SOLUTIE = _ID_SOLUTIE;

                SET _ID_SENTINTA = LAST_INSERT_ID();



                INSERT INTO DOSARE_STADII_SENTINTE SET

                       ID_DOSAR_STADIU = _ID_DOSAR_STADIU,

                       ID_SENTINTA = _ID_SENTINTA;



                END;

        END IF;

        CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);



        



        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

)
BEGIN

        SELECT * FROM DOSARE_STADII;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE dosare_stadii SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _ID_DOSAR INT,

        _ID_STADIU INT,

        _DATA DATETIME,

        _SCADENTA DATETIME,

        _TERMEN DATETIME,

        _TERMEN_ADMINISTRATIV DATETIME,

        _OBSERVATII TEXT,

        _ORA VARCHAR(5)

    )
BEGIN

        UPDATE DOSARE_STADII

                SET ID_DOSAR = _ID_DOSAR,

                ID_STADIU = _ID_STADIU,

                DATA = _DATA,

                SCADENTA = _SCADENTA,

                TERMEN = _TERMEN,

                TERMEN_ADMINISTRATIV = _TERMEN_ADMINISTRATIV,

                OBSERVATII = _OBSERVATII,

                ORA = _ORA

                WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADIIsp_update_from_portal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADIIsp_update_from_portal`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _ID_DOSAR INT,

        _ID_STADIU INT,

        _ID_ULTIMUL_STADIU_SCA INT,

        _DATA DATETIME,

        _SCADENTA DATETIME,

        _TERMEN DATETIME,

        _TERMEN_ADMINISTRATIV DATETIME,

        _OBSERVATII TEXT,

        _ORA VARCHAR(5),

        _NR_SENTINTA VARCHAR(45),

        _DATA_SENTINTA DATETIME,

        _DATA_COMUNICARE DATETIME,

        _SOLUTIE TEXT

    )
BEGIN

        UPDATE DOSARE_STADII SET TERMEN = _TERMEN, SCADENTA = _SCADENTA WHERE ID = _ID_ULTIMUL_STADIU_SCA;

        UPDATE TEMP_TO_IMPORT SET ID_DOSAR_STADIU=_ID_ULTIMUL_STADIU_SCA WHERE ID = _ID;



        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADII_SENTINTEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADII_SENTINTEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM dosare_stadii_sentinte;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADII_SENTINTEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADII_SENTINTEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        DELETE FROM DOSARE_STADII_SENTINTE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADII_SENTINTEsp_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADII_SENTINTEsp_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR_STADIU INT,

        _ID_SENTINTA INT

)
BEGIN

        DELETE FROM DOSARE_STADII_SENTINTE WHERE ID_DOSAR_STADIU = _ID_DOSAR_STADIU AND ID_SENTINTA = _ID_SENTINTA;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADII_SENTINTEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADII_SENTINTEsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        SELECT * FROM DOSARE_STADII_SENTINTE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADII_SENTINTEsp_GetByIdDosarStadiu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADII_SENTINTEsp_GetByIdDosarStadiu`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR_STADIU INT

)
BEGIN

        SELECT * FROM DOSARE_STADII_SENTINTE WHERE ID_DOSAR_STADIU = _ID_DOSAR_STADIU;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADII_SENTINTEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADII_SENTINTEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _id_dosar_stadiu INT,

        _id_sentinta INT,

        OUT _ID INT

)
BEGIN

        INSERT INTO DOSARE_STADII_SENTINTE SET ID_DOSAR_STADIU = _id_dosar_stadiu, ID_SENTINTA = _id_sentinta;

        SET _ID = LAST_INSERT_ID();



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADII_SENTINTEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADII_SENTINTEsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

)
BEGIN

        SELECT * FROM DOSARE_STADII_SENTINTE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADII_SENTINTEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADII_SENTINTEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE dosare_stadii_sentinte SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_STADII_SENTINTEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_STADII_SENTINTEsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _id_dosar_stadiu INT,

        _id_sentinta INT

)
BEGIN

        UPDATE DOSARE_STADII_SENTINTE SET ID_DOSAR_STADIU = _id_dosar_stadiu, ID_SENTINTA = _id_sentinta

        WHERE ID = _ID;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_UTILIZATORIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_UTILIZATORIsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM DOSARE_UTILIZATORI

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_UTILIZATORIsp_DeleteByIds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_UTILIZATORIsp_DeleteByIds`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_UTILIZATOR INT

    )
BEGIN

        DELETE FROM UTILIZATORI_DOSARE

        WHERE ID_DOSAR = _ID_DOSAR AND ID_UTILIZATOR = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_UTILIZATORIsp_GetByIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_UTILIZATORIsp_GetByIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT

    )
BEGIN

        SELECT U.*, R2.ID_DOSAR FROM

        (SELECT RU.* FROM vDOSARE R

                INNER JOIN vDOSARE_UTILIZATORI RU ON R.ID = RU.ID_DOSAR

                WHERE R.ID = _ID_DOSAR) R2

        RIGHT JOIN vUTILIZATORI U ON R2.ID_DOCUMENT = U.ID

        ORDER BY U.USER_NAME;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_UTILIZATORIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_UTILIZATORIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_UTILIZATOR INT,

        OUT _ID INT

    )
BEGIN

        DECLARE _EX INT;



        SET _EX = (SELECT COUNT(*) FROM UTILIZATORI_DOSARE WHERE ID_DOSAR = _ID_DOSAR AND ID_UTILIZATOR = _ID_UTILIZATOR);

        IF _EX IS NULL OR _EX = 0 THEN

                BEGIN

                INSERT INTO UTILIZATORI_DOSARE

                SET ID_DOSAR = _ID_DOSAR,

                ID_UTILIZATOR = _ID_UTILIZATOR;

                SET _ID = LAST_INSERT_ID();                

                END;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_UTILIZATORIsp_IsAssigned` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_UTILIZATORIsp_IsAssigned`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_UTILIZATOR INT

    )
BEGIN

        DECLARE _CNT INT;

        SET _CNT = (SELECT COUNT(*) CNT FROM vUTILIZATORI_DREPTURI UD INNER JOIN vDREPTURI DR ON UD.ID_DREPT = DR.ID WHERE LOWER(DR.DENUMIRE)='administrare' AND UD.ID_UTILIZATOR = _ID_UTILIZATOR);

        IF _CNT IS NULL OR _CNT <= 0 THEN

                SET _CNT = (SELECT COUNT(*) CNT FROM vUTILIZATORI_DOSARE WHERE ID_DOSAR = _ID_DOSAR AND ID_UTILIZATOR = _ID_UTILIZATOR);

        END IF;

        SELECT _CNT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DOSARE_UTILIZATORIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DOSARE_UTILIZATORIsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

)
BEGIN

        SELECT * FROM vDOSARE_UTILIZATORI;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DREPTURIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DREPTURIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM drepturi;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DREPTURIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DREPTURIsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM DREPTURI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DREPTURIsp_GetByDenumire` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DREPTURIsp_GetByDenumire`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE VARCHAR(100)

    )
BEGIN

        SELECT * FROM vDREPTURI WHERE DENUMIRE = _DENUMIRE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DREPTURIsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DREPTURIsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT * FROM vDREPTURI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DREPTURIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DREPTURIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _denumire VARCHAR(250),

        _detalii VARCHAR(2000),

        OUT _ID INT

    )
BEGIN

        INSERT INTO DREPTURI (DENUMIRE, DETALII)

        VALUES (_denumire, _detalii);

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DREPTURIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DREPTURIsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

)
BEGIN

        SELECT * FROM vDREPTURI WHERE UPPER(DENUMIRE)='ADMINISTRARE' AND _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE)='ADMINISTRATOR'))

        UNION

        SELECT * FROM vDREPTURI WHERE UPPER(DENUMIRE) <> 'ADMINISTRARE'

        ORDER BY DENUMIRE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DREPTURIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DREPTURIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE drepturi SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DREPTURIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DREPTURIsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _denumire VARCHAR(250),

        _detalii VARCHAR(2000)

    )
BEGIN

        UPDATE DREPTURI

        SET DENUMIRE = _denumire,

        DETALII = _detalii

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EMAIL_NOTIFICATIONSsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EMAIL_NOTIFICATIONSsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID VARCHAR(250))
BEGIN

        SELECT * FROM vEMAIL_NOTIFICATIONS WHERE _ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EMAIL_NOTIFICATIONSsp_GetByMessageId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EMAIL_NOTIFICATIONSsp_GetByMessageId`(

        _AUTHENTICATED_USER_ID INT,

        _MESSAGE_ID VARCHAR(250))
BEGIN

        SELECT * FROM vEMAIL_NOTIFICATIONS WHERE UPPER(MESSAGE_ID) = UPPER(_MESSAGE_ID);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EMAIL_NOTIFICATIONSsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EMAIL_NOTIFICATIONSsp_insert`(

        _authenticated_user_id int,

        _MESSAGE_ID VARCHAR(100),

        _MESSAGE_TEXT TEXT,

        _SEND BOOL,

        _SEND_TIMESTAMP DATETIME,

        _DELIVERY BOOL,

        _DELIVERY_TIMESTAMP DATETIME,

        _REJECT BOOL,

        _REJECT_TIMESTAMP DATETIME,

        _BOUNCE BOOL,

        _BOUNCE_TIMESTAMP DATETIME,

        _OPEN BOOL,

        _OPEN_TIMESTAMP DATETIME,

        _CLICK BOOL,

        _CLICK_TIMESTAMP DATETIME,

        _COMPLAINT BOOL,

        _COMPLAINT_TIMESTAMP DATETIME,

        _ID_DOSAR INT,

        OUT _ID INT

)
BEGIN

        INSERT INTO EMAIL_NOTIFICATIONS SET

        MESSAGE_ID = _MESSAGE_ID,

        MESSAGE_TEXT = _MESSAGE_TEXT,

        SEND = _SEND,

        SEND_TIMESTAMP = _SEND_TIMESTAMP,

        DELIVERY = _DELIVERY,

        DELIVERY_TIMESTAMP = _DELIVERY_TIMESTAMP,

        REJECT = _REJECT,

        REJECT_TIMESTAMP = _REJECT_TIMESTAMP,

        BOUNCE = _BOUNCE,

        BOUNCE_TIMESTAMP = _BOUNCE_TIMESTAMP,

        `OPEN` = _OPEN,

        OPEN_TIMESTAMP = _OPEN_TIMESTAMP,

        CLICK = _CLICK,

        CLICK_TIMESTAMP = _CLICK_TIMESTAMP,

        COMPLAINT = _COMPLAINT,

        COMPLAINT_TIMESTAMP = _COMPLAINT_TIMESTAMP,

        ID_DOSAR = _ID_DOSAR;



        SET _ID = LAST_INSERT_ID();



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EMAIL_NOTIFICATIONSsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EMAIL_NOTIFICATIONSsp_select`(

        _authenticated_user_id int

)
BEGIN

        SELECT * FROM EMAIL_NOTIFICATIONS;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EMAIL_NOTIFICATIONSsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EMAIL_NOTIFICATIONSsp_soft_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

)
BEGIN

        UPDATE EMAIL_NOTIFICATIONS SET deleted=TRUE WHERE ID=_ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EMAIL_NOTIFICATIONSsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EMAIL_NOTIFICATIONSsp_update`(

        _authenticated_user_id int,

        _ID INT,

        _MESSAGE_ID VARCHAR(100),

        _MESSAGE_TEXT TEXT,

        _SEND BOOL,

        _SEND_TIMESTAMP DATETIME,

        _DELIVERY BOOL,

        _DELIVERY_TIMESTAMP DATETIME,

        _REJECT BOOL,

        _REJECT_TIMESTAMP DATETIME,

        _BOUNCE BOOL,

        _BOUNCE_TIMESTAMP DATETIME,

        _OPEN BOOL,

        _OPEN_TIMESTAMP DATETIME,

        _CLICK BOOL,

        _CLICK_TIMESTAMP DATETIME,

        _COMPLAINT BOOL,

        _COMPLAINT_TIMESTAMP DATETIME,

        _ID_DOSAR INT

)
BEGIN

        UPDATE EMAIL_NOTIFICATIONS SET

        MESSAGE_ID = _MESSAGE_ID,

        MESSAGE_TEXT = _MESSAGE_TEXT,

        SEND = _SEND,

        SEND_TIMESTAMP = _SEND_TIMESTAMP,

        DELIVERY = _DELIVERY,

        DELIVERY_TIMESTAMP = _DELIVERY_TIMESTAMP,

        REJECT = _REJECT,

        REJECT_TIMESTAMP = _REJECT_TIMESTAMP,

        BOUNCE = _BOUNCE,

        BOUNCE_TIMESTAMP = _BOUNCE_TIMESTAMP,

        `OPEN` = _OPEN,

        OPEN_TIMESTAMP = _OPEN_TIMESTAMP,

        CLICK = _CLICK,

        CLICK_TIMESTAMP = _CLICK_TIMESTAMP,

        COMPLAINT = _COMPLAINT,

        COMPLAINT_TIMESTAMP = _COMPLAINT_TIMESTAMP,

        ID_DOSAR = _ID_DOSAR

        WHERE ID = _ID;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EMPTY_DB` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EMPTY_DB`()
BEGIN

DECLARE _MAX_ID INT;

DECLARE _ID INT;

SET foreign_key_checks = 0;



TRUNCATE actions_log;

TRUNCATE asigurati;

TRUNCATE auto;

TRUNCATE compensari;

TRUNCATE complete;

TRUNCATE contracte;

TRUNCATE contracte_plati_contracte;

TRUNCATE documente_scanate;

TRUNCATE dosare;

TRUNCATE dosare_plati;

TRUNCATE dosare_plati_contracte;

TRUNCATE dosare_portal;

TRUNCATE dosare_procese;

TRUNCATE dosare_stadii;

TRUNCATE dosare_stadii_sentinte;

TRUNCATE import_log;

TRUNCATE instante;

TRUNCATE intervenienti;

TRUNCATE log;

TRUNCATE mesaje;

TRUNCATE mesaje_utilizatori;

TRUNCATE pending_import_errors;

TRUNCATE pending_documente_scanate_imports;

TRUNCATE import_documente_scanate_log;

TRUNCATE plati;

TRUNCATE plati_contracte;

TRUNCATE plati_taxa_timbru;

TRUNCATE procese;

TRUNCATE procese_plati_taxa_timbru;

TRUNCATE sentinte;

TRUNCATE stadii_scadente;

TRUNCATE stadii_setari;

TRUNCATE tip_dosare; -- DOAR PRIMA DATA !!!



TRUNCATE utilizatori;

TRUNCATE utilizatori_actions;

TRUNCATE utilizatori_dosare;

TRUNCATE utilizatori_drepturi;

TRUNCATE utilizatori_setari;

TRUNCATE utilizatori_societati;

TRUNCATE utilizatori_societati_administrate;



UPDATE TIP_DOCUMENT SET DETALII=LOWER(DENUMIRE) WHERE DETALII IS NULL OR TRIM(DETALII)='';



INSERT INTO `utilizatori` (`ID`,`USER_NAME`,`PASSWORD`,`NUME_COMPLET`,`DETALII`,`IS_ONLINE`,`EMAIL`,`IP`,`MAC`,`ID_TIP_UTILIZATOR`,`LAST_REFRESH`,`DEPARTAMENT`,`ID_SOCIETATE`,`deleted`,`LAST_LOGIN`) VALUES

 (1,'admin','2feafffc12e536acaab70508bc85982b','ANDREI ION','',0,'andpsy@gmail.com','','',1,NULL,null,NULL,NULL,null),

 (2,'liviu.chiric','f9b0ca78164beacef77ea5dd7cd3169a','LIVIU CHIRIC','',0,'liviu@chiric.eu',NULL,NULL,1,NULL,NULL,NULL,NULL,null),

 (3,'oana.lututovici','f9b0ca78164beacef77ea5dd7cd3169a','OANA LUTUTOVICI','',0,'oana.lututovici@chiric.eu',NULL,NULL,1,NULL,NULL,NULL,NULL,null);



SET _MAX_ID = (SELECT MAX(ID) FROM vACTIONS);

WHILE _MAX_ID > 0 DO

  SET _ID = (SELECT ID FROM vACTIONS WHERE ID = _MAX_ID);

  IF _ID IS NOT NULL THEN

    INSERT INTO `utilizatori_actions` (`ID_UTILIZATOR`,`ID_ACTION`,`deleted`) VALUES

     (1,_ID,NULL),

     (2,_ID,NULL),

     (3,_ID,NULL);

  END IF;

  SET _MAX_ID = _MAX_ID - 1;

END WHILE;



SET _MAX_ID = (SELECT MAX(ID) FROM vDREPTURI);

WHILE _MAX_ID > 0 DO

  SET _ID = (SELECT ID FROM vDREPTURI WHERE ID = _MAX_ID);

  IF _ID IS NOT NULL THEN

    INSERT INTO `utilizatori_drepturi` (`ID_UTILIZATOR`,`ID_DREPT`,`deleted`) VALUES

     (1,_ID,NULL),

     (2,_ID,NULL),

     (3,_ID,NULL);

  END IF;

  SET _MAX_ID = _MAX_ID - 1;

END WHILE;







SET foreign_key_checks = 1;





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EXECUTARIsp_Import` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EXECUTARIsp_Import`(

        _NR_AZT VARCHAR(250),

        _NR_SCA VARCHAR(250),

        _DATA_SCA DATETIME,

        _NR_DOSAR_EXECUTARE VARCHAR(100),

        _DATA_EXECUTARE DATETIME,

        _ONORARIU_AVOCAT_EXECUTARE DOUBLE

    )
BEGIN

        DECLARE _ID_DOSAR INT;

        DECLARE _ID_PROCES INT;



        SET _ID_DOSAR = (SELECT ID FROM DOSARE WHERE NR_AZT = _NR_AZT LIMIT 1);

        IF _ID_DOSAR IS NULL THEN

                SET _ID_DOSAR = (SELECT ID FROM DOSARE WHERE NR_INTERN = _NR_SCA AND DATA_SCA = _DATA_SCA LIMIT 1);

        END IF;



        IF _ID_DOSAR IS NOT NULL THEN

                BEGIN

                INSERT INTO DOSARE_STADII SET ID_DOSAR=_ID_DOSAR, ID_STADIU=(SELECT ID FROM STADII WHERE UPPER(DENUMIRE)='EXECUTARE SILITA'), DATA=_DATA_EXECUTARE;

                SET _ID_PROCES = (SELECT ID_PROCES FROM DOSARE_PROCESE WHERE ID_DOSAR=_ID_DOSAR LIMIT 1);

                IF _ID_PROCES IS NOT NULL THEN

                        BEGIN

                        UPDATE PROCESE SET NR_DOSAR_EXECUTARE=_NR_DOSAR_EXECUTARE, DATA_EXECUTARE=_DATA_EXECUTARE, ONORARIU_AVOCAT_EXECUTARE=_ONORARIU_AVOCAT_EXECUTARE WHERE ID=_ID_PROCES;

                        END;

                END IF;

                END;

        END IF;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EXECUTARIsp_IsImported` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EXECUTARIsp_IsImported`(

        _NR_AZT VARCHAR(250), _DATA DATETIME

    )
BEGIN

        SELECT NR_AZT FROM DOSARE R INNER JOIN DOSARE_STADII RS ON R.ID=RS.ID_DOSAR INNER JOIN STADII S ON RS.ID_STADIU=S.ID

        WHERE R.NR_AZT=_NR_AZT AND DATE_FORMAT(RS.DATA, '%d.%m.%Y') = DATE_FORMAT(_DATA, '%d.%m.%Y') AND UPPER(S.DENUMIRE)='EXECUTARE SILITA';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FISAREGRESsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FISAREGRESsp_GetById`(
        _ID_DOSAR INT
    )
BEGIN
        SELECT R.NR_INTERN, R.NR_AZT, DATE_FORMAT(R.DATA_SCA, '%d.%m.%Y') DATA_SCA, IF(R.EXTRACONTRACT=TRUE, 'EXTRACONTRACT', 'NOU') EXTRACONTRACT,
        A.DENUMIRE ASIGURAT, R.POLITA_AZT, DATE_FORMAT(R.DATA_POLITA_AZT, '%d.%m.%Y') DATA_POLITA_AZT, R.AUTO_AZT, SA.DENUMIRE SOCIETATE, R.POLITA_RCA, R.AUTO_RCA,
        R.NR_REGRES, DATE_FORMAT(R.DATA_REGRES, '%d.%m.%Y') DATA_REGRES, INTERV.DENUMIRE INTERVENIENT,
        R.VALOARE_REGRES, R.VALOARE_DAUNA, R.VMD
        FROM DOSARE R LEFT JOIN ASIGURATI A ON R.ID_ASIGURAT = A.ID
        LEFT JOIN SOCIETATI_ASIGURARE SA ON R.ID_SOCIETATE = SA.ID
        LEFT JOIN INTERVENIENTI INTERV ON R.ID_INTERVENIENT = INTERV.ID
        WHERE R.ID = _ID_DOSAR;

        SELECT S.ICON_PATH, S.DENUMIRE, DATE_FORMAT(RS.DATA, '%d.%m.%Y') DATA, DATE_FORMAT(RS.SCADENTA, '%d.%m.%Y') SCADENTA, DATE_FORMAT(RS.TERMEN, '%d.%m.%Y') TERMEN, RS.OBSERVATII FROM DOSARE_STADII RS INNER JOIN STADII S ON RS.ID_STADIU = S.ID WHERE RS.ID_DOSAR = _ID_DOSAR;

        SELECT D.NR_DOSAR_INSTANTA, D.NR_INTERN NR_INTERN_DOSAR,
        DATE_FORMAT(D.DATA_DEPUNERE, '%d.%m.%Y') DATA_DEPUNERE, D.OBSERVATII, D.SUMA_SOLICITATA, D.PENALITATI,
        D.TAXA_TIMBRU, D.TIMBRU_JUDICIAR, D.ONORARIU_EXPERT, D.ONORARIU_AVOCAT, TD.DENUMIRE TIP_DOSAR, I.DENUMIRE INSTANTA, C.DENUMIRE COMPLET, CTR.NR_CONTRACT,
        DATE_FORMAT(CTR.DATA_CONTRACT, '%d.%m.%Y') DATA_CONTRACT, D.OBSERVATII OBSERVATII_DOSAR, D.STADIU
        FROM DOSARE_PROCESE RD INNER JOIN PROCESE D ON RD.ID_PROCES = D.ID
        LEFT JOIN TIP_PROCESE TD ON D.ID_TIP_DOSAR = TD.ID
        LEFT JOIN INSTANTE I ON D.ID_INSTANTA = I.ID
        LEFT JOIN COMPLETE C ON D.ID_COMPLET = C.ID
        LEFT JOIN CONTRACTE CTR ON D.ID_CONTRACT = CTR.ID
        WHERE RD.ID_DOSAR = _ID_DOSAR;

        SELECT
                IF(D.DATA_DEPUNERE IS NULL, '', IF(D.DATA_DEPUNERE > P.DATA_DOCUMENT, 'BEFORE', 'AFTER')) TIP_PLATA,
        P.NR_DOCUMENT, DATE_FORMAT(P.DATA_DOCUMENT, '%d.%m.%Y') DATA_DOCUMENT, P.SUMA, P.OBSERVATII OBSERVATII_PLATI
        FROM DOSARE_PLATI RP
        INNER JOIN PLATI P ON RP.ID_PLATA = P.ID
        INNER JOIN DOSARE R ON RP.ID_DOSAR = R.ID
        LEFT JOIN DOSARE_PROCESE RD ON R.ID = RD.ID_DOSAR
        LEFT JOIN PROCESE D ON RD.ID_PROCES = D.ID
        WHERE RP.ID_DOSAR = _ID_DOSAR;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IMPORT_FROM_SCA` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IMPORT_FROM_SCA`()
BEGIN

 DECLARE v_finished, cursorStadii_done, cursorProcese_done, cursorSentinte_done, cursorPlati_done, cursorPlatiContracte_done, cursorPlatiTaxaTimbru_done, cursorPlatiContracte2_done BOOL DEFAULT false;



 
 
DECLARE _ID_DOSAR INT;

DECLARE _NR_INTERN	int;

DECLARE _DATA_SCA	datetime;

DECLARE _ID_ASIGURAT	int;

DECLARE _POLITA_AZT	varchar(100);

DECLARE _DATA_POLITA_AZT	datetime;

DECLARE _AUTO_AZT	varchar(45);

DECLARE _ID_SOCIETATE	int;

DECLARE _POLITA_RCA	varchar(100);

DECLARE _AUTO_RCA	varchar(45);

DECLARE _VALOARE_DAUNA	double;

DECLARE _VALOARE_REGRES	double;

DECLARE _NR_REGRES	varchar(45);

DECLARE _DATA_REGRES	datetime;

DECLARE _ID_INTERVENIENT	int;

DECLARE _NR_AZT	varchar(100);

DECLARE _DOSAR_COMPLET	bool;

DECLARE _VMD	double;

DECLARE _ACCEPT_AZT	bool;

DECLARE _EXTRACONTRACT	bool;

DECLARE _OBSERVATII	text;

DECLARE _DIFERENTA	double;

DECLARE _PLATIT	double;

DECLARE _DEBIT_TOTAL	double;

DECLARE _PENALITATI	double;

DECLARE _ZILE_INTARZIERE	int;

DECLARE _ASIGURATOR_RCA varchar(250);

DECLARE _INTERVENIENT VARCHAR(250);

DECLARE _ASIGURAT_RCA VARCHAR(250);

DECLARE _ASIGURAT_CASCO VARCHAR(250);

DECLARE _TIP_DOSAR VARCHAR(250);




DECLARE _ID_REGRES_STADIU INT;

DECLARE _ID_REGRES INT;

DECLARE _ID_STADIU INT;

DECLARE _TERMEN DATETIME;

DECLARE _OBSERVATII_STADII TEXT;

DECLARE _DATA DATETIME;

DECLARE _SCADENTA DATETIME;

DECLARE _ORA VARCHAR(10);

DECLARE _TERMEN_ADMINISTRATIV BOOL;

DECLARE _ID2 INT;

DECLARE _STADIU VARCHAR(250);

DECLARE _DETALII_STADIU TEXT;

DECLARE _ICON_PATH VARCHAR(250);

DECLARE _PAS INT;

DECLARE _STADIU_INSTANTA BOOL;

DECLARE _STADIU_CU_TERMEN BOOL;




DECLARE _ID_REGRES_DOSAR INT;

DECLARE _ID_REGRES_P INT;

DECLARE _ID_DOSAR_P INT;

DECLARE _ID3 INT;

DECLARE _NR_INTERN_P INT;

DECLARE _NR_DOSAR_P VARCHAR(100);

DECLARE _DATA_DEPUNERE DATETIME;

DECLARE _OBSERVATII_P TEXT;

DECLARE _ID_TIP_DOSAR_P INT;

DECLARE _SUMA_SOLICITATA_P DOUBLE;

DECLARE _PENALITATI_P DOUBLE;

DECLARE _TAXA_TIMBRU DOUBLE;

DECLARE _TIMBRU_JUDICIAR DOUBLE;

DECLARE _ONORARIU_EXPERT DOUBLE;

DECLARE _ONORARIU_AVOCAT DOUBLE;

DECLARE _ID_INSTANTA INT;

DECLARE _ID_COMPLET INT;

DECLARE _ID_CONTRACT INT;

DECLARE _STADIU_P VARCHAR(100);

DECLARE _ZILE_PENALIZARI INT;

DECLARE _CHELTUIELI_MICA_PUBLICITATE DOUBLE;

DECLARE _ONORARIU_CURATOR DOUBLE;

DECLARE _ALTE_CHELTUIELI_JUDECATA DOUBLE;

DECLARE _TAXA_TIMBRU_REEXAMINARE DOUBLE;

DECLARE _NR_DOSAR_EXECUTARE VARCHAR(100);

DECLARE _DATA_EXECUTARE DATETIME;

DECLARE _ONORARIU_AVOCAT_EXECUTARE DOUBLE;

DECLARE _CHELTUIELI_EXECUTARE DOUBLE;

DECLARE _DESPAGUBIRE_ACORDATA DOUBLE;

DECLARE _CHELTUIELI_JUDECATA_ACORDATE DOUBLE;

DECLARE _MONITORIZARE BOOL;

DECLARE _INSTANTA VARCHAR(250);

DECLARE _COMPLET VARCHAR(250);




DECLARE _ID_REGRES_STADIU_SENTINTA INT;

DECLARE _ID_REGRES_STADIU_S INT;

DECLARE _ID21, _ID22 INT;

DECLARE _ID_SENTINTA INT;

DECLARE _NR_SENTINTA VARCHAR(250);

DECLARE _DATA_SENTINTA DATETIME;

DECLARE _DATA_COMUNICARE DATETIME;

DECLARE _ID_SOLUTIE INT;

DECLARE _DENUMIRE_SOLUTIE VARCHAR(250);

DECLARE _DETALII_SOLUTIE TEXT;     




DECLARE _ID_CONTRACT_CONTRACT INT;

DECLARE _NR_CONTRACT VARCHAR(100);

DECLARE _DATA_CONTRACT DATETIME;

DECLARE _OBSERVATII_CONTRACT TEXT;




DECLARE _ID_PLATA INT;

DECLARE _NR_DOCUMENT_PLATI VARCHAR(200);

DECLARE _DATA_DOCUMENT_PLATI DATETIME;

DECLARE _SUMA_PLATI DOUBLE;

DECLARE _OBSERVATII_PLATI TEXT;




DECLARE _ID_PLATA_CONTRACT INT;

DECLARE _NR_DOCUMENT_PC VARCHAR(200);

DECLARE _DATA_DOCUMENT_PC DATETIME;

DECLARE _SUMA_PC DOUBLE;

DECLARE _OBSERVATII_PC TEXT;

DECLARE _INCASAT_PE_AMIABIL BOOL;

DECLARE _INCASAT_CONTRACT BOOL;




DECLARE _ID_PLATA_TT INT;

DECLARE _NR_DOCUMENT_TT VARCHAR(200);

DECLARE _DATA_DOCUMENT_TT DATETIME;

DECLARE _SUMA_TT DOUBLE;

DECLARE _OBSERVATII_TT TEXT;





 DECLARE _CURSOR CURSOR FOR

 SELECT R.*,

         SA.DENUMIRE ASIGURATOR_RCA,

         I.DENUMIRE INTERVENIENT,

         
         ACASCO.DENUMIRE ASIGURAT_CASCO

         
         FROM `SCA`.`REGRESE` R

         LEFT JOIN `SCA`.`SOCIETATI_ASIGURARE` SA ON R.ID_SOCIETATE = SA.ID

         LEFT JOIN `SCA`.`INTERVENIENTI` I ON R.ID_INTERVENIENT = I.ID

         
         LEFT JOIN `SCA`.`ASIGURATI` ACASCO ON R.ID_ASIGURAT = ACASCO.ID

         
         WHERE R.ID NOT IN (SELECT ID_REGRES FROM `SCA`.`REGRESE_STADII` RS INNER JOIN `SCA`.`STADII` S ON RS.ID_STADIU=S.ID WHERE UPPER(S.DENUMIRE)='CLASAT')  
         AND R.NR_AZT NOT IN (SELECT NR_DOSAR_CASCO FROM DOSARE); 
         


 DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = true;



 OPEN _cursor;

 

 get_info: LOOP



 FETCH _cursor INTO

 _ID_DOSAR,

_NR_INTERN,

_DATA_SCA,

_ID_ASIGURAT,

_POLITA_AZT,

_DATA_POLITA_AZT,

_AUTO_AZT,

_ID_SOCIETATE,

_POLITA_RCA,

_AUTO_RCA,

_VALOARE_DAUNA,

_VALOARE_REGRES,

_NR_REGRES,

_DATA_REGRES,

_ID_INTERVENIENT,

_NR_AZT,

_DOSAR_COMPLET,

_VMD,

_ACCEPT_AZT,

_EXTRACONTRACT,

_OBSERVATII,

_DIFERENTA,

_PLATIT,

_DEBIT_TOTAL,

_PENALITATI,

_ZILE_INTARZIERE,

_ASIGURATOR_RCA,

_INTERVENIENT,


_ASIGURAT_CASCO


;



 IF v_finished THEN

 LEAVE get_info;

 END IF;



 


CALL SOCIETATI_ASIGURAREsp_insert(_ASIGURATOR_RCA, _ASIGURATOR_RCA, null, null, null, null, null, null, null, null, @_ID_ASIGURATOR_RCA);

CALL SOCIETATI_ASIGURAREsp_insert('ALLIANZ TIRIAC ASIGURARI S.A.', 'ALLIANZ', '021 201 9100', '6120740', 'J40/15882/1994', 'Str. Caderea Bastiliei, nr. 80-84, parter, sector 1, Bucuresti', 'Unicredit Bank', 'RO37BACX0000000030063132', null, null, @_ID_ASIGURATOR_CASCO);

CALL INTERVENIENTIsp_insert(_INTERVENIENT, null, @_ID_INTERVENIENT_NOU);


CALL ASIGURATIsp_insert(_ASIGURAT_CASCO, null, @_ID_ASIGURAT_CASCO_NOU);




CALL AUTOsp_insert(_AUTO_AZT, null, null, null, null, @_ID_AUTO_CASCO_NOU);

CALL AUTOsp_insert(_AUTO_RCA, null, null, null, null, @_ID_AUTO_RCA_NOU);



        

        

 



   CALL DOSAREsp_import(

        _NR_INTERN,

        _DATA_SCA,

        @_ID_ASIGURAT_CASCO_NOU,

        _ASIGURAT_CASCO,

        _POLITA_AZT,

        @_ID_AUTO_CASCO_NOU,

        _AUTO_AZT,

        @_ID_ASIGURATOR_CASCO,

        _POLITA_RCA,

        @_ID_AUTO_RCA_NOU,

        _AUTO_RCA,

        _VALOARE_DAUNA,

        _VALOARE_REGRES,

        @_ID_INTERVENIENT_NOU,

        _INTERVENIENT,

        _NR_AZT,

        _VMD,

        _OBSERVATII,

        @_ID_ASIGURATOR_RCA,

        _DATA_POLITA_AZT, 
        null,

        null,

        null,

        null,

        null,

        null,

        null,

        null,

        null,

        null,

        null,

        @_ID_DOSAR_NOU);



        BLOCK2: BEGIN

        DECLARE cursorStadii CURSOR FOR SELECT * FROM `sca`.`regrese_stadii` rs inner join `sca`.`stadii` s on rs.id_stadiu = s.id where rs.id_regres = _ID_DOSAR;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorStadii_done = TRUE;

        OPEN cursorStadii;

        get_stadii: LOOP

        FETCH FROM cursorStadii INTO _ID_REGRES_STADIU, _ID_REGRES, _ID_STADIU, _TERMEN, _OBSERVATII_STADII, _DATA, _SCADENTA, _ORA, _TERMEN_ADMINISTRATIV, _ID2, _STADIU, _DETALII_STADIU, _ICON_PATH, _PAS, _STADIU_INSTANTA, _STADIU_CU_TERMEN;



        IF cursorStadii_done THEN

                LEAVE get_stadii;

        END IF;



        
        CALL STADIIsp_insert(_STADIU, _DETALII_STADIU, _ICON_PATH, _PAS, _STADIU_INSTANTA, _STADIU_CU_TERMEN, @_ID_STADIU_NOU);

        IF @_ID_DOSAR_NOU IS NOT NULL AND @_ID_STADIU_NOU IS NOT NULL THEN

                CALL DOSARE_STADIIsp_insert(@_ID_DOSAR_NOU, @_ID_STADIU_NOU, _DATA, _SCADENTA, _TERMEN, _TERMEN_ADMINISTRATIV, _OBSERVATII_STADII, _ORA, null, null, null, null, @_ID_DOSAR_STADIU_NOU);

        END IF;

        

        
        
                BLOCK_21: BEGIN

                DECLARE cursorSentinte CURSOR FOR SELECT * FROM `sca`.`regrese_stadii_sentinte` rss inner join `sca`.`sentinte` s on rss.id_sentinta = s.id left join `sca`.`solutii` sol on s.id_solutie = sol.id WHERE rss.id_regres_stadiu = _ID_REGRES_STADIU;

                DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorSentinte_done = TRUE;

                OPEN cursorSentinte;

                get_sentinte: LOOP

                FETCH FROM cursorSentinte INTO _ID_REGRES_STADIU_SENTINTA, _ID_REGRES_STADIU_S, _ID_SENTINTA, _ID21, _NR_SENTINTA, _DATA_SENTINTA, _DATA_COMUNICARE, _ID_SOLUTIE, _ID22, _DENUMIRE_SOLUTIE, _DETALII_SOLUTIE;



                IF cursorSentinte_done THEN

                        LEAVE get_sentinte;

                END IF;



                
                CALL SOLUTIIsp_insert(_DENUMIRE_SOLUTIE, _DETALII_SOLUTIE, @_ID_SOLUTIE_NOU);

                CALL SENTINTEsp_insert(_NR_SENTINTA, _DATA_SENTINTA, _DATA_COMUNICARE, @_ID_SOLUTIE_NOU, @_ID_SENTINTA_NOU);

                IF @_ID_DOSAR_STADIU_NOU IS NOT NULL AND @_ID_SENTINTA_NOU IS NOT NULL THEN

                        CALL DOSARE_STADII_SENTINTEsp_insert(@_ID_DOSAR_STADIU_NOU, @_ID_SENTINTA_NOU, @_ID_DOSAR_STADIU_SENTINTA_NOU);

                END IF;



                END LOOP get_sentinte;

                CLOSE cursorSentinte;

                END BLOCK_21;



        END LOOP get_stadii;

        CLOSE cursorStadii;

        END BLOCK2;





        BLOCK3: BEGIN

        DECLARE cursorProcese CURSOR FOR SELECT rd.*, d.*, i.denumire `instanta`, c.denumire `complet` FROM `sca`.`regrese_dosare` rd

                inner join `sca`.`dosare` d on rd.id_dosar = d.id

                left join `sca`.`instante` i on d.id_instanta = i.id

                left join `sca`.`complete` c on d.id_complet = c.id

                where rd.id_regres = _ID_DOSAR;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorProcese_done = TRUE;

        OPEN cursorProcese;

        get_procese: LOOP

        FETCH FROM cursorProcese INTO _ID_REGRES_DOSAR, _ID_REGRES_P, _ID_DOSAR_P, _ID3, _NR_INTERN_P, _NR_DOSAR_P, _DATA_DEPUNERE, _OBSERVATII_P, _ID_TIP_DOSAR_P, _SUMA_SOLICITATA_P, _PENALITATI_P, _TAXA_TIMBRU, _TIMBRU_JUDICIAR, _ONORARIU_EXPERT, _ONORARIU_AVOCAT, _ID_INSTANTA, _ID_COMPLET, _ID_CONTRACT, _STADIU_P, _ZILE_PENALIZARI, _CHELTUIELI_MICA_PUBLICITATE, _ONORARIU_CURATOR, _ALTE_CHELTUIELI_JUDECATA, _TAXA_TIMBRU_REEXAMINARE, _NR_DOSAR_EXECUTARE, _DATA_EXECUTARE, _ONORARIU_AVOCAT_EXECUTARE, _CHELTUIELI_EXECUTARE, _DESPAGUBIRE_ACORDATA, _CHELTUIELI_JUDECATA_ACORDATE, _MONITORIZARE, _INSTANTA, _COMPLET;



            IF cursorProcese_done THEN

                    LEAVE get_procese;

            END IF;



        
        CALL INSTANTEsp_insert(_INSTANTA, null, @_ID_INSTANTA_NOU);

        CALL COMPLETEsp_insert(_COMPLET, null, @_ID_COMPLET_NOU);



        SELECT NR_CONTRACT, DATA_CONTRACT, OBSERVATII INTO _NR_CONTRACT, _DATA_CONTRACT, _OBSERVATII_CONTRACT FROM `sca`.`contracte` WHERE ID = _ID_CONTRACT LIMIT 1;

        CALL CONTRACTEsp_insert(_NR_CONTRACT, _DATA_CONTRACT, _OBSERVATII_CONTRACT, @_ID_CONTRACT_NOU);



        CALL PROCESEsp_import(

                null, 
                _NR_INTERN_P,

                _NR_DOSAR_P,

                _DATA_DEPUNERE,

                _OBSERVATII_P,

                _ID_TIP_DOSAR_P,

                @_ID_INSTANTA_NOU,

                @_ID_COMPLET_NOU,

                null, 
                null, 
                @_ID_CONTRACT_NOU,

                _SUMA_SOLICITATA_P,

                _PENALITATI_P,

                _TAXA_TIMBRU,

                null, 
                null, 
                _TIMBRU_JUDICIAR,

                _ONORARIU_EXPERT,

                _ONORARIU_AVOCAT,

                _CHELTUIELI_MICA_PUBLICITATE,

                _ONORARIU_CURATOR,

                _ALTE_CHELTUIELI_JUDECATA,

                _TAXA_TIMBRU_REEXAMINARE,

                _STADIU_P,

                null, 
                null, 
                null, 
                null, 
                _NR_DOSAR_EXECUTARE,

                _DATA_EXECUTARE,

                _ONORARIU_AVOCAT_EXECUTARE,

                _CHELTUIELI_EXECUTARE,

                _DESPAGUBIRE_ACORDATA,

                _CHELTUIELI_JUDECATA_ACORDATE,

                _MONITORIZARE,

                @_ID_PROCES_NOU);



        IF @_ID_DOSAR_NOU IS NOT NULL AND @_ID_PROCES_NOU IS NOT NULL THEN

                CALL DOSARE_PROCESEsp_insert(@_ID_DOSAR_NOU, @_ID_PROCES_NOU, @_ID_DOSAR_PROCES_NOU);

        END IF;



        
        BLOCK31: BEGIN

        DECLARE cursorPlatiContracte CURSOR FOR SELECT pc.* FROM `sca`.`contracte_plati_contracte` cpc

                inner join `sca`.`plati_contracte` pc on cpc.id_plata_contract = pc.id

                where cpc.id_contract = _ID_CONTRACT;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorPlatiContracte_done = TRUE;

        OPEN cursorPlatiContracte;

        get_plati_contracte: LOOP

        FETCH FROM cursorPlatiContracte INTO _ID_PLATA_CONTRACT, _NR_DOCUMENT_PC, _DATA_DOCUMENT_PC, _SUMA_PC, _OBSERVATII_PC, _INCASAT_PE_AMIABIL, _INCASAT_CONTRACT;



            IF cursorPlatiContracte_done THEN

                    LEAVE get_plati_contracte;

            END IF;



        


        CALL PLATI_CONTRACTEsp_insert(_NR_DOCUMENT_PC, _DATA_DOCUMENT_PC, _SUMA_PC, _OBSERVATII_PC, _INCASAT_PE_AMIABIL, _INCASAT_CONTRACT, @_ID_PLATA_CONTRACT_NOU);

        IF @_ID_PLATA_CONTRACT_NOU IS NOT NULL AND @_ID_CONTRACT_NOU IS NOT NULL THEN

                CALL CONTRACTE_PLATI_CONTRACTEsp_insert(@_ID_CONTRACT_NOU, @_ID_PLATA_CONTRACT_NOU, @_ID_CONTRACT_PLATA_CONTRACT_NOU);

        END IF;



        END LOOP get_plati_contracte;

        CLOSE cursorPlatiContracte;

        END BLOCK31;



        BLOCK32: BEGIN

        DECLARE cursorPlatiTaxaTimbru CURSOR FOR SELECT ptt.* FROM `sca`.`dosare_plati_taxa_timbru` dptt

                inner join `sca`.`plati_taxa_timbru` ptt on dptt.id_plata_taxa_timbru = ptt.id

                where dptt.id_dosar = _ID_DOSAR_P;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorPlatiTaxaTimbru_done = TRUE;

        OPEN cursorPlatiTaxaTimbru;

        get_plati_taxa_timbru: LOOP

        FETCH FROM cursorPlatiTaxaTimbru INTO _ID_PLATA_TT, _NR_DOCUMENT_TT, _DATA_DOCUMENT_TT, _SUMA_TT;



            IF cursorPlatiTaxaTimbru_done THEN

                    LEAVE get_plati_taxa_timbru;

            END IF;



        


        CALL PLATI_TAXA_TIMBRUsp_insert(_NR_DOCUMENT_TT, _DATA_DOCUMENT_TT, _SUMA_TT, null, @_ID_PLATA_TAXA_TIMBRU_NOU);

        IF @_ID_PLATA_TAXA_TIMBRU_NOU IS NOT NULL AND @_ID_PROCES_NOU IS NOT NULL THEN

                CALL PROCESE_PLATI_TAXA_TIMBRUsp_insert(@_ID_PROCES_NOU, @_ID_PLATA_TAXA_TIMBRU_NOU, @_ID_PROCES_PLATA_TAXA_TIMBRU_NOU);

        END IF;



        END LOOP get_plati_taxa_timbru;

        CLOSE cursorPlatiTaxaTimbru;

        END BLOCK32;



        END LOOP get_procese;

        CLOSE cursorProcese;

        END BLOCK3;





        BLOCK4: BEGIN

        DECLARE cursorPlati CURSOR FOR SELECT p.* FROM `sca`.`regrese_plati` rp

                inner join `sca`.`plati` p on rp.id_plata = p.id

                where rp.id_regres = _ID_DOSAR;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorPlati_done = TRUE;

        OPEN cursorPlati;

        get_plati: LOOP

        FETCH FROM cursorPlati INTO _ID_PLATA, _NR_DOCUMENT_PLATI, _DATA_DOCUMENT_PLATI, _SUMA_PLATI, _OBSERVATII_PLATI;



            IF cursorPlati_done THEN

                    LEAVE get_plati;

            END IF;



        


        CALL PLATIsp_import(_NR_DOCUMENT_PLATI, _DATA_DOCUMENT_PLATI, _SUMA_PLATI, _OBSERVATII_PLATI, @_ID_PLATA_NOU);

        IF @_ID_PLATA_NOU IS NOT NULL AND @_ID_DOSAR_NOU IS NOT NULL THEN

                CALL DOSARE_PLATIsp_insert(@_ID_DOSAR_NOU, @_ID_PLATA_NOU, @_ID_DOSAR_PLATA_NOU);

        END IF;



        END LOOP get_plati;

        CLOSE cursorPlati;

        END BLOCK4;







        
        BLOCK5: BEGIN

        DECLARE cursorPlatiContracte2 CURSOR FOR SELECT pc.* FROM `sca`.`regrese_plati_contracte` rpc

                inner join `sca`.`plati_contracte` pc on rpc.id_plata_contract = pc.id

                where rpc.id_regres = _ID_DOSAR;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursorPlatiContracte2_done = TRUE;

        OPEN cursorPlatiContracte2;

        get_plati_contracte2: LOOP

        FETCH FROM cursorPlatiContracte2 INTO _ID_PLATA_CONTRACT, _NR_DOCUMENT_PC, _DATA_DOCUMENT_PC, _SUMA_PC, _OBSERVATII_PC, _INCASAT_PE_AMIABIL, _INCASAT_CONTRACT;



            IF cursorPlatiContracte2_done THEN

                    LEAVE get_plati_contracte2;

            END IF;



        


        CALL PLATI_CONTRACTEsp_insert(_NR_DOCUMENT_PC, _DATA_DOCUMENT_PC, _SUMA_PC, _OBSERVATII_PC, _INCASAT_PE_AMIABIL, _INCASAT_CONTRACT, @_ID_PLATA_CONTRACT_NOU2);

        IF @_ID_PLATA_CONTRACT_NOU2 IS NOT NULL AND @_ID_DOSAR_NOU IS NOT NULL THEN

                CALL DOSARE_PLATI_CONTRACTEsp_insert(@_ID_DOSAR_NOU, @_ID_PLATA_CONTRACT_NOU2, @_DOSAR_PLATA_CONTRACT_NOU2);

        END IF;



        END LOOP get_plati_contracte2;

        CLOSE cursorPlatiContracte2;

        END BLOCK5;



 END LOOP get_info;

 

 CLOSE _cursor;

 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IMPORT_LOGsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IMPORT_LOGsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM import_log;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IMPORT_LOGsp_GetDosare` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IMPORT_LOGsp_GetDosare`(_DATA_IMPORT DATETIME)
BEGIN

        SELECT * FROM IMPORT_LOG WHERE DATA_IMPORT = _DATA_IMPORT OR _DATA_IMPORT IS NULL ORDER BY DATA_IMPORT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IMPORT_LOGsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IMPORT_LOGsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE import_log SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSTANTEsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSTANTEsp_Combo`()
BEGIN

        SELECT ID, DENUMIRE FROM vINSTANTE ORDER BY DENUMIRE ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSTANTEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSTANTEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM instante;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSTANTEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSTANTEsp_delete`(
        _ID INT
    )
BEGIN
        DELETE FROM INSTANTE WHERE ID = _ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSTANTEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSTANTEsp_GetById`(

        _ID INT

    )
BEGIN

        SELECT * FROM vINSTANTE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSTANTEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSTANTEsp_insert`(

        _denumire VARCHAR(250),

        _detalii VARCHAR(2000),

        OUT _ID INT

    )
BEGIN

        IF _denumire IS NULL THEN

                SET _ID = NULL;

        ELSE

                SET _ID = (SELECT ID FROM INSTANTE WHERE DENUMIRE = _denumire LIMIT 1);

                IF _ID IS NULL THEN

                        INSERT INTO INSTANTE (DENUMIRE, DETALII)

                        VALUES (_denumire, _detalii);

                        SET _ID = LAST_INSERT_ID();

                END IF;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSTANTEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSTANTEsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);

        

        SET @_DEFAULT_FILTER = '1=1';



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' INSTANTE.DENUMIRE ';

        END IF;



        SET @_QUERY = 'SELECT INSTANTE.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vINSTANTE INSTANTE '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSTANTEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSTANTEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE instante SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSTANTEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSTANTEsp_update`(
        _ID INT,
        _denumire VARCHAR(250),
        _detalii VARCHAR(2000)
    )
BEGIN
        UPDATE INSTANTE
        SET DENUMIRE = _denumire,
        DETALII = _detalii
        WHERE ID = _ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INTERVENIENTIsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INTERVENIENTIsp_Combo`()
BEGIN

        SELECT ID, DENUMIRE FROM vINTERVENIENTI ORDER BY DENUMIRE ASC;  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INTERVENIENTIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INTERVENIENTIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM intervenienti;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INTERVENIENTIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INTERVENIENTIsp_delete`(
        _ID INT
    )
BEGIN
        DELETE FROM INTERVENIENTI WHERE ID = _ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INTERVENIENTIsp_GetByDenumire` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INTERVENIENTIsp_GetByDenumire`(_DENUMIRE VARCHAR(250))
BEGIN

        SELECT * FROM vINTERVENIENTI WHERE DENUMIRE = _DENUMIRE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INTERVENIENTIsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INTERVENIENTIsp_GetById`(

        _ID INT

    )
BEGIN

        SELECT * FROM vINTERVENIENTI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INTERVENIENTIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INTERVENIENTIsp_insert`(

        _denumire VARCHAR(250),

        _detalii VARCHAR(2000),

        OUT _ID INT

    )
BEGIN

        IF _DENUMIRE IS NULL THEN

                SET _ID = NULL;

        ELSE

                SET _ID = (SELECT ID FROM INTERVENIENTI WHERE DENUMIRE = _DENUMIRE AND (DETALII = _DETALII OR _DETALII IS NULL) LIMIT 1);

        END IF;



        IF _ID IS NULL AND _DENUMIRE IS NOT NULL THEN

                BEGIN

                INSERT INTO INTERVENIENTI (DENUMIRE, DETALII)

                VALUES (_denumire, _detalii);

                SET _ID = LAST_INSERT_ID();

                END;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INTERVENIENTIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INTERVENIENTIsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);

        

        SET @_DEFAULT_FILTER = '1=1';



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' INTERVENIENTI.DENUMIRE ';

        END IF;



        SET @_QUERY = 'SELECT INTERVENIENTI.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vINTERVENIENTI INTERVENIENTI '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INTERVENIENTIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INTERVENIENTIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE intervenienti SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INTERVENIENTIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INTERVENIENTIsp_update`(
        _ID INT,
        _denumire VARCHAR(250),
        _detalii VARCHAR(2000)
    )
BEGIN
        UPDATE INTERVENIENTI
        SET DENUMIRE = _denumire,
        DETALII = _detalii
        WHERE ID = _ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LOGINsp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGINsp`(

        _username VARCHAR(250),

        _password VARCHAR(250),

        _ip VARCHAR(250)

    )
BEGIN

        SELECT * FROM vUTILIZATORI

        WHERE USER_NAME = _username AND PASSWORD = _password AND (IP = _ip OR _ip IS NULL);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LOGsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM log;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LOGsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGsp_delete`(
        _DATA DATETIME
    )
BEGIN
        DELETE FROM LOG WHERE DATA <= _DATA;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LOGsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGsp_insert`(
        _DATA DATETIME,
        _ACTIUNE VARCHAR(50),
        _TABELA VARCHAR(50),
        _DETALII_BEFORE TEXT,
        _DETALII_AFTER TEXT,
        _ID_UTILIZATOR INT
    )
BEGIN
        INSERT INTO LOG
                SET DATA = _DATA,
                ACTIUNE = _ACTIUNE,
                TABELA = _TABELA,
                DETALII_BEFORE = _DETALII_BEFORE,
                DETALII_AFTER = _DETALII_AFTER,
                ID_UTILIZATOR = _ID_UTILIZATOR;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LOGsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE log SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_count`(

        _ID_RECEIVER INT,

	_SEARCH_STRING VARCHAR(250),

	_SORT_EXPRESION VARCHAR(250),

	_SORT_DIRECTION VARCHAR(4)

    )
BEGIN

        DECLARE _QUERY VARCHAR(8000);



        IF _SORT_EXPRESION IS NULL AND _SORT_DIRECTION IS NULL THEN

                 SET _SORT_EXPRESION = ' M.DATA DESC ';

        END IF;





        SET @_QUERY = CONCAT('SELECT COUNT(*) ');



            SET @_QUERY = CONCAT(@_QUERY,

                 'FROM vMESAJE M ',

		'INNER JOIN vUTILIZATORI U1 ON M.ID_SENDER=U1.ID ',

		'INNER JOIN vUTILIZATORI U2 ON M.ID_RECEIVER=U2.ID ',

		'LEFT JOIN vDOSARE D ON M.ID_DOSAR=D.ID ',

		'LEFT JOIN vTIP_MESAJE TD ON M.ID_TIP_MESAJ=TD.ID '

                );



        SET @_QUERY = CONCAT(@_QUERY, ' WHERE M.ID_RECEIVER=', _ID_RECEIVER, ' ');



        CASE WHEN _SEARCH_STRING IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' AND ',

                '(M.DATA = ''', _SEARCH_STRING, ''' OR M.SUBIECT LIKE ''%', _SEARCH_STRING, '%'' OR M.BODY LIKE ''%', _SEARCH_STRING, '%'' OR U1.USER_NAME LIKE ''%', _SEARCH_STRING, '%'' OR U2.USER_NAME LIKE ''%', _SEARCH_STRING, '%'') '

                );

        ELSE

                BEGIN

                	SET @_QUERY = @_QUERY;

                END;

        END CASE;



        CASE WHEN _SORT_EXPRESION IS NOT NULL THEN

                BEGIN

                        CASE WHEN _SORT_EXPRESION = 'TO' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY U1.USER_NAME');

                        WHEN _SORT_EXPRESION = 'FROM' THEN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY U2.USER_NAME');

                        ELSE

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT_EXPRESION);

                        END CASE;

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _SORT_DIRECTION IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _SORT_DIRECTION);

        ELSE

                SET @_QUERY = @_QUERY; 

        END CASE;

        SET @_QUERY = CONCAT(@_QUERY, ';');



          





          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_delete`(

	_ID INT

    )
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS TMP_ATTACHMENTS AS (SELECT ID_ATTACHMENT FROM MESAJE_ATTACHMENTS WHERE ID_MESAJ = _ID);

  	

	DELETE FROM MESAJE_ATTACHMENTS WHERE ID_MESAJ = _ID;

	DELETE FROM ATTACHMENTS WHERE ID IN (SELECT ID_ATTACHMENT FROM TMP_ATTACHMENTS);

	DELETE FROM MESAJE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_GetById`(

	_ID INT

)
BEGIN

	SELECT M.*, U1.USER_NAME `FROM`, U2.USER_NAME `TO`,

	

	'' NR_DOSAR, '' TIP_DOSAR

	FROM vMESAJE M

	INNER JOIN vUTILIZATORI U1 ON M.ID_SENDER=U1.ID

	INNER JOIN vUTILIZATORI U2 ON M.ID_RECEIVER=U2.ID

	

	

	WHERE M.ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_GetByIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_GetByIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT

        )
BEGIN

        SELECT * FROM vMESAJE WHERE

                (ID IN (SELECT ID_MESAJ FROM vMESAJE_UTILIZATORI WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                        OR (ID IN (SELECT REPLY_TO FROM vMESAJE) AND ID_SENDER = _AUTHENTICATED_USER_ID)) AND

                ID_DOSAR = _ID_DOSAR

                ORDER BY ID_DOSAR, DATA desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_GetByIdDosarNew` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_GetByIdDosarNew`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _LAST_REFRESH DATETIME

        )
BEGIN

        SELECT COUNT(*) FROM vMESAJE WHERE

                (ID IN (SELECT ID_MESAJ FROM vMESAJE_UTILIZATORI WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)

                        OR (ID IN (SELECT REPLY_TO FROM vMESAJE) AND ID_SENDER = _AUTHENTICATED_USER_ID)) AND

                (ID_DOSAR = _ID_DOSAR OR _ID_DOSAR IS NULL) AND

                DATA >= _LAST_REFRESH;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_GetByIdDosarSent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_GetByIdDosarSent`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT

        )
BEGIN

        SELECT * FROM vMESAJE WHERE

                ID_SENDER = _AUTHENTICATED_USER_ID AND

                ID_DOSAR = _ID_DOSAR

                ORDER BY ID_DOSAR, DATA desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_insert`(

	_ID_SENDER INT,

	_SUBIECT VARCHAR(250),

	_BODY TEXT,

	_DATA DATETIME,

	_ID_DOSAR INT,

	_IMPORTANTA BOOL,

	_ID_TIP_MESAJ INT,

        _REPLY_TO INT,

        OUT _ID INT

    )
BEGIN

	INSERT INTO MESAJE SET

	ID_SENDER = _ID_SENDER,

	SUBIECT = _SUBIECT,

	BODY = _BODY,

	DATA = _DATA,

	ID_DOSAR = _ID_DOSAR,

	IMPORTANTA = _IMPORTANTA,

	ID_TIP_MESAJ = _ID_TIP_MESAJ,

        REPLY_TO = _REPLY_TO;



        SET _ID = LAST_INSERT_ID();        	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);

        

        -- SET @_DEFAULT_FILTER = '1=1';

        SET @_DEFAULT_FILTER = 'ID IN (SELECT ID_MESAJ FROM MESAJE_UTILIZATORI WHERE ID_UTILIZATOR = _AUTHENTICATED_USER_ID)';



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' MESAJE.DATA ';

        END IF;



        SET @_QUERY = 'SELECT MESAJE.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vMESAJE MESAJE '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = CONCAT(@_QUERY, ' DESC');

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_selectSent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_selectSent`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);

        

        -- SET @_DEFAULT_FILTER = '1=1';

        SET @_DEFAULT_FILTER = 'ID_SENDER = _AUTHENTICATED_USER_ID';



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' MESAJE.DATA ';

        END IF;



        SET @_QUERY = 'SELECT MESAJE.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vMESAJE MESAJE '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = CONCAT(@_QUERY, ' DESC');

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE mesaje SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJEsp_update`(

	_ID INT,

	_ID_SENDER INT,

	_SUBIECT VARCHAR(250),

	_BODY TEXT,

	_DATA DATETIME,

	_ID_DOSAR INT,

	_IMPORTANTA BOOL,

	_ID_TIP_MESAJ INT,

        _REPLY_TO INT

    )
BEGIN

	UPDATE MESAJE SET

	ID_SENDER = _ID_SENDER,

	SUBIECT = _SUBIECT,

	BODY = _BODY,

	DATA = _DATA,

	ID_DOSAR = _ID_DOSAR,

	IMPORTANTA = _IMPORTANTA,

	ID_TIP_MESAJ = _ID_TIP_MESAJ,

        REPLY_TO = _REPLY_TO

	WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJE_UTILIZATORIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJE_UTILIZATORIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM mesaje_utilizatori;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJE_UTILIZATORIsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJE_UTILIZATORIsp_GetById`(_ID INT)
BEGIN

        SELECT * FROM VMESAJE_UTILIZATORI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJE_UTILIZATORIsp_GetByIdMesaj` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJE_UTILIZATORIsp_GetByIdMesaj`(_ID_MESAJ INT)
BEGIN

        SELECT * FROM VMESAJE_UTILIZATORI WHERE ID_MESAJ = _ID_MESAJ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJE_UTILIZATORIsp_GetByIdMesajIdUtilizator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJE_UTILIZATORIsp_GetByIdMesajIdUtilizator`(_ID_MESAJ INT, _ID_UTILIZATOR INT)
BEGIN

        SELECT * FROM VMESAJE_UTILIZATORI WHERE ID_MESAJ = _ID_MESAJ AND ID_UTILIZATOR = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJE_UTILIZATORIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJE_UTILIZATORIsp_insert`(

        _ID_MESAJ INT,

        _ID_UTILIZATOR INT,

        _DATA_CITIRE DATE,

        OUT _ID INT

)
BEGIN

        INSERT INTO MESAJE_UTILIZATORI SET

                ID_MESAJ = _ID_MESAJ,

                ID_UTILIZATOR = _ID_UTILIZATOR,

                DATA_CITIRE = _DATA_CITIRE;

        SET _ID = LAST_INSERT_ID();



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJE_UTILIZATORIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJE_UTILIZATORIsp_select`()
BEGIN

        SELECT * FROM VMESAJE_UTILIZATORI;  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJE_UTILIZATORIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJE_UTILIZATORIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE mesaje_utilizatori SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MESAJE_UTILIZATORIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MESAJE_UTILIZATORIsp_update`(

        _ID INT,

        _ID_MESAJ INT,

        _ID_UTILIZATOR INT,

        _DATA_CITIRE DATETIME

)
BEGIN

        UPDATE MESAJE_UTILIZATORI SET

                ID_MESAJ = _ID_MESAJ,

                ID_UTILIZATOR = _ID_UTILIZATOR,

                DATA_CITIRE = _DATA_CITIRE

                WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `NOMENCLATORsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `NOMENCLATORsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _TABELA VARCHAR(100),

        _ID INT

    )
BEGIN

        DECLARE _QUERY VARCHAR(8000);

        SET @_QUERY = CONCAT('SELECT DENUMIRE FROM v', _TABELA, ' WHERE ID = ', _ID);



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;       

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `NOMENCLATORsp_search` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `NOMENCLATORsp_search`(

        _AUTHENTICATED_USER_ID INT,

        _TABLE VARCHAR(50),

        _SEARCH_STRING VARCHAR(250)

    )
BEGIN

        DECLARE _T VARCHAR(4000);

        SET @_T = CONCAT('SELECT DENUMIRE FROM v', _TABLE, ' WHERE DENUMIRE LIKE ''', _SEARCH_STRING, '%''');

          PREPARE stmt1 FROM @_T;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;        



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `NOMENCLATORsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `NOMENCLATORsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _TABLE VARCHAR(50),

        _DENUMIRE VARCHAR(250)

    )
BEGIN

        

        DECLARE _ID INT;

        SET @max = NULL;

        SET @_T = CONCAT('SELECT ID FROM ', _TABLE, ' WHERE LOWER(DENUMIRE) = ''', LOWER(_DENUMIRE), ''' INTO @max');

        PREPARE stmt1 FROM @_T;

        EXECUTE stmt1;

        SET _ID = @max;

      

      



        DEALLOCATE PREPARE stmt1;

        IF _ID IS NOT NULL THEN

                SELECT _ID AS ID, TRUE AS EXIST;

        ELSE

                BEGIN

                CALL NOMENCLATORsp_updateHelper(_TABLE, _DENUMIRE);

                SELECT LAST_INSERT_ID() AS ID, FALSE AS EXIST;

                END;

        END IF;

        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `NOMENCLATORsp_updateHelper` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `NOMENCLATORsp_updateHelper`(

        _AUTHENTICATED_USER_ID INT,

        _TABLE VARCHAR(50),

        _DENUMIRE VARCHAR(250)

    )
BEGIN

        DECLARE _T2 VARCHAR(4000);

        SET @_T2 = CONCAT('INSERT INTO ', _TABLE, ' SET DENUMIRE = ''', _DENUMIRE, ''' ');

        PREPARE stmt2 FROM @_T2;

        EXECUTE stmt2;

        DEALLOCATE PREPARE stmt2;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ONORARIIsp_Import` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ONORARIIsp_Import`(

        _NR_AZT VARCHAR(250),

        _NR_SCA VARCHAR(250),

        _DATA_SCA DATETIME,

        _NR_DOCUMENT VARCHAR(100),

        _DATA_DOCUMENT DATETIME,

        _SUMA DOUBLE,

        _INCASARE_AMIABIL BOOLEAN,

        _INCASARE_INSTANTA BOOLEAN,

        _ONORARIU_AVOCAT DOUBLE,

        _NR_CONTRACT_ASISTENTA_JURIDICA VARCHAR(100),

        _DATA_CONTRACT_ASISTENTA_JURIDICA DATETIME

    )
BEGIN

        DECLARE _ID_DOSAR INT;

        DECLARE _ID_PROCES INT;

        DECLARE _ID_CONTRACT INT;



        SET _ID_DOSAR = (SELECT ID FROM DOSARE WHERE NR_AZT = _NR_AZT LIMIT 1);

        IF _ID_DOSAR IS NULL THEN

                SET _ID_DOSAR = (SELECT ID FROM DOSARE WHERE NR_INTERN = _NR_SCA AND DATA_SCA = _DATA_SCA LIMIT 1);

        END IF;



        IF _ID_DOSAR IS NOT NULL THEN

                BEGIN

                IF _INCASARE_AMIABIL IS NULL OR _INCASARE_AMIABIL = FALSE OR _INCASARE_AMIABIL = 0 THEN

                        BEGIN

                        SET _ID_PROCES = (SELECT ID_PROCES FROM DOSARE_PROCESE RD INNER JOIN DOSARE R ON RD.ID_DOSAR = R.ID WHERE R.ID = _ID_DOSAR);

                        SET _ID_CONTRACT = (SELECT ID_CONTRACT FROM PROCESE D WHERE ID = _ID_PROCES);

                        IF _ID_CONTRACT IS NOT NULL THEN

                                BEGIN

                                
                                IF _INCASARE_INSTANTA IS NULL THEN

                                        UPDATE PROCESE SET ONORARIU_AVOCAT = _ONORARIU_AVOCAT, ID_CONTRACT = _ID_CONTRACT WHERE ID = _ID_PROCES;

                                END IF;

                                INSERT INTO PLATI_CONTRACTE SET NR_DOCUMENT = _NR_DOCUMENT, DATA_DOCUMENT = _DATA_DOCUMENT, SUMA = _SUMA, INCASAT_PE_AMIABIL = _INCASARE_AMIABIL, INCASAT_CONTRACT = _INCASARE_INSTANTA;

                                INSERT INTO CONTRACTE_PLATI_CONTRACTE SET ID_CONTRACT = _ID_CONTRACT, ID_PLATA_CONTRACT = LAST_INSERT_ID();

                                END;

                        ELSE

                                BEGIN

                                IF _NR_CONTRACT_ASISTENTA_JURIDICA IS NOT NULL AND _DATA_CONTRACT_ASISTENTA_JURIDICA IS NOT NULL THEN

                                        BEGIN

                                        INSERT INTO CONTRACTE SET NR_CONTRACT = _NR_CONTRACT_ASISTENTA_JURIDICA, DATA_CONTRACT = _DATA_CONTRACT_ASISTENTA_JURIDICA;

                                        SET _ID_CONTRACT = LAST_INSERT_ID();

                                        END;

                                END IF;

                                


                                IF _INCASARE_INSTANTA IS NULL THEN

                                        UPDATE PROCESE SET ONORARIU_AVOCAT = _ONORARIU_AVOCAT, ID_CONTRACT = _ID_CONTRACT WHERE ID = _ID_PROCES;

                                END IF;

                                

                                INSERT INTO PLATI_CONTRACTE SET NR_DOCUMENT = _NR_DOCUMENT, DATA_DOCUMENT = _DATA_DOCUMENT, SUMA = _SUMA, INCASAT_PE_AMIABIL = _INCASARE_AMIABIL, INCASAT_CONTRACT = _INCASARE_INSTANTA;

                                INSERT INTO DOSARE_PLATI_CONTRACTE SET ID_DOSAR = _ID_DOSAR, ID_PLATA_CONTRACT = LAST_INSERT_ID();

                                END;

                        END IF;

                        END;

                ELSE

                        BEGIN

                                IF _ID_DOSAR IS NOT NULL AND _NR_CONTRACT_ASISTENTA_JURIDICA IS NOT NULL AND _DATA_CONTRACT_ASISTENTA_JURIDICA IS NOT NULL THEN

                                        BEGIN

                                        INSERT INTO CONTRACTE SET NR_CONTRACT = _NR_CONTRACT_ASISTENTA_JURIDICA, DATA_CONTRACT = _DATA_CONTRACT_ASISTENTA_JURIDICA;

                                        SET _ID_CONTRACT = LAST_INSERT_ID();

                                        END;

                                END IF;

                                
                                
                                INSERT INTO PLATI_CONTRACTE SET NR_DOCUMENT = _NR_DOCUMENT, DATA_DOCUMENT = _DATA_DOCUMENT, SUMA = _SUMA, INCASAT_PE_AMIABIL = _INCASARE_AMIABIL, INCASAT_CONTRACT = _INCASARE_INSTANTA;

                                INSERT INTO DOSARE_PLATI_CONTRACTE SET ID_DOSAR = _ID_DOSAR, ID_PLATA_CONTRACT = LAST_INSERT_ID();

                        END;

                END IF;

                END;

        END IF;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ONORARIIsp_IsImported` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ONORARIIsp_IsImported`(

        _NR_AZT VARCHAR(250), _NR_OP VARCHAR(100), _DATA_OP DATETIME, _SUMA DOUBLE, _INCASAT_PE_AMIABIL BOOLEAN, _INCASAT_PE_CONTRACT BOOLEAN

    )
BEGIN

        DECLARE _NR_AZT_RET VARCHAR(250);

        IF _INCASAT_PE_AMIABIL IS NULL AND _INCASAT_PE_CONTRACT IS NULL THEN

                BEGIN

                        SET _NR_AZT_RET = (SELECT NR_AZT FROM DOSARE R INNER JOIN DOSARE_PROCESE RD ON R.ID = RD.ID_DOSAR INNER JOIN PROCESE D ON RD.ID_PROCES = D.ID INNER JOIN CONTRACTE C ON D.ID_CONTRACT = C.ID INNER JOIN CONTRACTE_PLATI_CONTRACTE CPC ON C.ID = CPC.ID_CONTRACT INNER JOIN PLATI_CONTRACTE PC ON CPC.ID_PLATA_CONTRACT = PC.ID WHERE R.NR_AZT = _NR_AZT AND (PC.NR_DOCUMENT = _NR_OP OR _NR_OP IS NULL) AND (PC.DATA_DOCUMENT = _DATA_OP OR _DATA_OP IS NULL) AND PC.SUMA = _SUMA AND PC.INCASAT_PE_AMIABIL IS NULL AND PC.INCASAT_CONTRACT IS NULL LIMIT 1);

                        IF _NR_AZT_RET IS NULL THEN

                                BEGIN

                                        SET _NR_AZT_RET = (SELECT NR_AZT FROM DOSARE R INNER JOIN DOSARE_PLATI_CONTRACTE RPC ON R.ID = RPC.ID_DOSAR INNER JOIN PLATI_CONTRACTE PC ON RPC.ID_PLATA_CONTRACT = PC.ID WHERE R.NR_AZT = _NR_AZT AND (PC.NR_DOCUMENT = _NR_OP OR _NR_OP IS NULL) AND (PC.DATA_DOCUMENT = _DATA_OP OR _DATA_OP IS NULL) AND PC.SUMA = _SUMA AND PC.INCASAT_PE_AMIABIL IS NULL AND PC.INCASAT_CONTRACT IS NULL LIMIT 1);

                                END;

                        END IF;

                END;

        ELSEIF _INCASAT_PE_AMIABIL IS NULL AND _INCASAT_PE_CONTRACT IS NOT NULL THEN

                BEGIN

                        SET _NR_AZT_RET = (SELECT NR_AZT FROM DOSARE R INNER JOIN DOSARE_PROCESE RD ON R.ID = RD.ID_DOSAR INNER JOIN PROCESE D ON RD.ID_PROCES = D.ID INNER JOIN CONTRACTE C ON D.ID_CONTRACT = C.ID INNER JOIN CONTRACTE_PLATI_CONTRACTE CPC ON C.ID = CPC.ID_CONTRACT INNER JOIN PLATI_CONTRACTE PC ON CPC.ID_PLATA_CONTRACT = PC.ID WHERE R.NR_AZT = _NR_AZT AND (PC.NR_DOCUMENT = _NR_OP OR _NR_OP IS NULL) AND (PC.DATA_DOCUMENT = _DATA_OP OR _DATA_OP IS NULL) AND PC.SUMA = _SUMA AND PC.INCASAT_PE_AMIABIL IS NULL AND PC.INCASAT_CONTRACT IS NOT NULL LIMIT 1);

                        IF _NR_AZT_RET IS NULL THEN

                                BEGIN

                                        SET _NR_AZT_RET = (SELECT NR_AZT FROM DOSARE R INNER JOIN DOSARE_PLATI_CONTRACTE RPC ON R.ID = RPC.ID_DOSAR INNER JOIN PLATI_CONTRACTE PC ON RPC.ID_PLATA_CONTRACT = PC.ID WHERE R.NR_AZT = _NR_AZT AND (PC.NR_DOCUMENT = _NR_OP OR _NR_OP IS NULL) AND (PC.DATA_DOCUMENT = _DATA_OP OR _DATA_OP IS NULL) AND PC.SUMA = _SUMA AND PC.INCASAT_PE_AMIABIL IS NULL AND PC.INCASAT_CONTRACT IS NOT NULL LIMIT 1);

                                END;

                        END IF;

                END;

        ELSEIF _INCASAT_PE_AMIABIL IS NOT NULL THEN

                BEGIN

                        SET _NR_AZT_RET = (SELECT NR_AZT FROM DOSARE R INNER JOIN DOSARE_PLATI_CONTRACTE RPC ON R.ID = RPC.ID_DOSAR INNER JOIN PLATI_CONTRACTE PC ON RPC.ID_PLATA_CONTRACT = PC.ID WHERE R.NR_AZT = _NR_AZT AND (PC.NR_DOCUMENT = _NR_OP OR _NR_OP IS NULL) AND (PC.DATA_DOCUMENT = _DATA_OP OR _DATA_OP IS NULL) AND PC.SUMA = _SUMA  AND PC.INCASAT_PE_AMIABIL IS NOT NULL LIMIT 1);

                END;

        END IF;

        SELECT _NR_AZT_RET LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PENDING_DOCUMENTE_SCANATE_IMPORTSsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PENDING_DOCUMENTE_SCANATE_IMPORTSsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE_FISIER VARCHAR(250),

        _EXTENSIE_FISIER VARCHAR(5),

        _DATA_INCARCARE DATETIME,

        _DIMENSIUNE_FISIER INT,

        _ID_TIP_DOCUMENT INT,

        _ID_DOSAR INT,

        _VIZA_CASCO BOOLEAN,

        _DETALII TEXT,

        _FILE_CONTENT LONGBLOB,

        _SMALL_ICON BLOB,

        _MEDIUM_ICON BLOB,

        _CALE_FISIER VARCHAR(255),

        OUT _ID INT

)
BEGIN

        INSERT INTO PENDING_DOCUMENTE_SCANATE_IMPORTS

        SET

        DENUMIRE_FISIER = _DENUMIRE_FISIER,

        EXTENSIE_FISIER=_EXTENSIE_FISIER,

        DATA_INCARCARE = _DATA_INCARCARE,

        DIMENSIUNE_FISIER = _DIMENSIUNE_FISIER,

        ID_TIP_DOCUMENT = _ID_TIP_DOCUMENT,

        ID_DOSAR = _ID_DOSAR,

        VIZA_CASCO = _VIZA_CASCO,

        DETALII = _DETALII,

        FILE_CONTENT = _FILE_CONTENT,

        SMALL_ICON = _SMALL_ICON,

        MEDIUM_ICON = _MEDIUM_ICON,

        CALE_FISIER = _CALE_FISIER;

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PENDING_IMPORT_ERRORSsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PENDING_IMPORT_ERRORSsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM pending_import_errors;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PENDING_IMPORT_ERRORSsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PENDING_IMPORT_ERRORSsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

)
BEGIN

        DELETE FROM PENDING_IMPORT_ERRORS WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PENDING_IMPORT_ERRORSsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PENDING_IMPORT_ERRORSsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

)
BEGIN

        SELECT * FROM vPENDING_IMPORT_ERRORS WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PENDING_IMPORT_ERRORSsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PENDING_IMPORT_ERRORSsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _NR_SCA VARCHAR(100),

        _DATA_SCA DATETIME,

        _ID_ASIGURAT_CASCO INT,

        

        _NR_POLITA_CASCO VARCHAR(100),

        _ID_AUTO_CASCO INT,

        

        _ID_SOCIETATE_CASCO INT,

        _NR_POLITA_RCA VARCHAR(100),

        _ID_AUTO_RCA INT,

        

        _VALOARE_DAUNA DOUBLE,

        _VALOARE_REGRES DOUBLE,

        _ID_INTERVENIENT INT,

        

        _NR_DOSAR_CASCO VARCHAR(100),

        _VMD DOUBLE,

        _OBSERVATII TEXT,

        _ID_SOCIETATE_RCA INT,

        _DATA_EVENIMENT DATETIME,

        _REZERVA_DAUNA DOUBLE,

        _DATA_INTRARE_RCA DATETIME,

        _DATA_IESIRE_CASCO DATETIME,

        _NR_INTRARE_RCA VARCHAR(100),

        _NR_IESIRE_CASCO VARCHAR(100),

        _ID_ASIGURAT_RCA INT,

        

        _ID_TIP_DOSAR INT,

        _SUMA_IBNR DOUBLE,

        _DATA_AVIZARE DATETIME,

        _DATA_NOTIFICARE DATETIME,

        _DATA_CREARE DATETIME,

        OUT _ID INT

    )
BEGIN

        DECLARE _ID_ASIGURAT_CASCO_N, _ID_ASIGURAT_RCA_N, _ID_AUTO_RCA_N, _ID_AUTO_CASCO_N, _ID_INTERVENIENT_N INT;



        



        INSERT INTO PENDING_IMPORT_ERRORS SET

        NR_SCA =_NR_SCA,

        DATA_SCA = _DATA_SCA,

        

        ID_ASIGURAT_CASCO = _ID_ASIGURAT_CASCO,

        NR_POLITA_CASCO = _NR_POLITA_CASCO,

        

        ID_AUTO_CASCO = _ID_AUTO_CASCO,

        ID_SOCIETATE_CASCO = _ID_SOCIETATE_CASCO,

        NR_POLITA_RCA = _NR_POLITA_RCA,

        

        ID_AUTO_RCA = _ID_AUTO_RCA,

        VALOARE_DAUNA = _VALOARE_DAUNA,

        VALOARE_REGRES = _VALOARE_REGRES,

        

        ID_INTERVENIENT = _ID_INTERVENIENT,

        NR_DOSAR_CASCO = _NR_DOSAR_CASCO,

        VMD = _VMD,

        OBSERVATII = _OBSERVATII,

        ID_SOCIETATE_RCA = _ID_SOCIETATE_RCA,

        DATA_EVENIMENT = _DATA_EVENIMENT,

        REZERVA_DAUNA = _REZERVA_DAUNA,

        DATA_INTRARE_RCA = _DATA_INTRARE_RCA,

        DATA_IESIRE_CASCO = _DATA_IESIRE_CASCO,

        NR_INTRARE_RCA = _NR_INTRARE_RCA,

        NR_IESIRE_CASCO = _NR_IESIRE_CASCO,

        

        ID_ASIGURAT_RCA = _ID_ASIGURAT_RCA,

        ID_TIP_DOSAR = _ID_TIP_DOSAR,

        SUMA_IBNR = _SUMA_IBNR,

        DATA_AVIZARE = _DATA_AVIZARE,

        DATA_NOTIFICARE = _DATA_NOTIFICARE,

        DATA_CREARE = _DATA_CREARE;



        

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PENDING_IMPORT_ERRORSsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PENDING_IMPORT_ERRORSsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE pending_import_errors SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PENDING_IMPORT_ERRORSsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PENDING_IMPORT_ERRORSsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _NR_SCA VARCHAR(100),

        _DATA_SCA DATETIME,

        _ID_ASIGURAT_CASCO INT,

        

        _NR_POLITA_CASCO VARCHAR(100),

        _ID_AUTO_CASCO INT,

        

        _ID_SOCIETATE_CASCO INT,

        _NR_POLITA_RCA VARCHAR(100),

        _ID_AUTO_RCA INT,

        

        _VALOARE_DAUNA DOUBLE,

        _VALOARE_REGRES DOUBLE,

        _ID_INTERVENIENT INT,

        

        _NR_DOSAR_CASCO VARCHAR(100),

        _VMD DOUBLE,

        _OBSERVATII TEXT,

        _ID_SOCIETATE_RCA INT,

        _DATA_EVENIMENT DATETIME,

        _REZERVA_DAUNA DOUBLE,

        _DATA_INTRARE_RCA DATETIME,

        _DATA_IESIRE_CASCO DATETIME,

        _NR_INTRARE_RCA VARCHAR(100),

        _NR_IESIRE_CASCO VARCHAR(100),

        _ID_ASIGURAT_RCA INT,

        

        _ID_TIP_DOSAR INT,

        _SUMA_IBNR DOUBLE,

        _DATA_AVIZARE DATETIME,

        _DATA_NOTIFICARE DATETIME,

        _DATA_CREARE DATETIME

    )
BEGIN

        DECLARE _ID_ASIGURAT_CASCO_N, _ID_ASIGURAT_RCA_N, _ID_AUTO_RCA_N, _ID_AUTO_CASCO_N, _ID_INTERVENIENT_N INT;



        



        UPDATE PENDING_IMPORT_ERRORS SET

        NR_SCA =_NR_SCA,

        DATA_SCA = _DATA_SCA,

        

        ID_ASIGURAT_CASCO = _ID_ASIGURAT_CASCO,

        NR_POLITA_CASCO = _NR_POLITA_CASCO,

        

        ID_AUTO_CASCO = _ID_AUTO_CASCO,

        ID_SOCIETATE_CASCO = _ID_SOCIETATE_CASCO,

        NR_POLITA_RCA = _NR_POLITA_RCA,

        

        ID_AUTO_RCA = _ID_AUTO_RCA,

        VALOARE_DAUNA = _VALOARE_DAUNA,

        VALOARE_REGRES = _VALOARE_REGRES,

        

        ID_INTERVENIENT = _ID_INTERVENIENT,

        NR_DOSAR_CASCO = _NR_DOSAR_CASCO,

        VMD = _VMD,

        OBSERVATII = _OBSERVATII,

        ID_SOCIETATE_RCA = _ID_SOCIETATE_RCA,

        DATA_EVENIMENT = _DATA_EVENIMENT,

        REZERVA_DAUNA = _REZERVA_DAUNA,

        DATA_INTRARE_RCA = _DATA_INTRARE_RCA,

        DATA_IESIRE_CASCO = _DATA_IESIRE_CASCO,

        NR_INTRARE_RCA = _NR_INTRARE_RCA,

        NR_IESIRE_CASCO = _NR_IESIRE_CASCO,

        

        ID_ASIGURAT_RCA = _ID_ASIGURAT_RCA,

        ID_TIP_DOSAR = _ID_TIP_DOSAR,

        SUMA_IBNR = _SUMA_IBNR,

        DATA_AVIZARE = _DATA_AVIZARE,

        DATA_NOTIFICARE = _DATA_NOTIFICARE,

        DATA_CREARE = _DATA_CREARE

        WHERE ID = _ID;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM plati;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_delete`(
        _ID INT
    )
BEGIN
        DECLARE _ID_DOSAR INT;
        SET _ID_DOSAR = (SELECT ID_DOSAR FROM DOSARE_PLATI WHERE ID_PLATA = _ID);
        DELETE FROM PLATI WHERE ID = _ID;
        IF _ID_DOSAR IS NOT NULL THEN
                CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_GetById`(
        _ID INT
    )
BEGIN
        SELECT * FROM PLATI WHERE ID = _ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_GetByIdRegres` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_GetByIdRegres`(
        _ID_DOSAR INT
    )
BEGIN
        SELECT P.* FROM PLATI P
        INNER JOIN DOSARE_PLATI RP ON RP.ID_PLATA = P.ID
        WHERE RP.ID_DOSAR = _ID_DOSAR
        ORDER BY DATA_DOCUMENT ASC;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_GetColumns` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_GetColumns`()
BEGIN
        SHOW COLUMNS FROM PLATI;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_GetIdRegres` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_GetIdRegres`(
        _ID_PLATA INT
    )
BEGIN
        SELECT ID_DOSAR FROM DOSARE_PLATI WHERE ID_PLATA = _ID_PLATA LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_import` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_import`(

        _NR_DOCUMENT VARCHAR(50),

        _DATA_DOCUMENT DATETIME,

        _SUMA DOUBLE,

        _OBSERVATII TEXT,

        OUT _ID INT

    )
BEGIN

        
        IF _NR_DOCUMENT IS NULL OR _SUMA IS NULL THEN

                SET _ID = NULL;

        ELSE

                INSERT INTO PLATI

                SET NR_DOCUMENT = _NR_DOCUMENT,

                        DATA_DOCUMENT = _DATA_DOCUMENT,

                        SUMA = _SUMA,

                        OBSERVATII = _OBSERVATII;

                SET _ID = LAST_INSERT_ID();

        END IF;

        

                

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_insert`(

        _NR_DOCUMENT VARCHAR(50),

        _DATA_DOCUMENT DATETIME,

        _SUMA DOUBLE,

        _OBSERVATII TEXT,

        OUT _ID INT

    )
BEGIN

        
        INSERT INTO PLATI

                SET NR_DOCUMENT = _NR_DOCUMENT,

                        DATA_DOCUMENT = _DATA_DOCUMENT,

                        SUMA = _SUMA,

                        OBSERVATII = _OBSERVATII;



                SET _ID = LAST_INSERT_ID();



                

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_IsAssigned` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_IsAssigned`(
        _ID_DOSAR INT,
        _ID_PLATA INT
    )
BEGIN
        SELECT COUNT(*) FROM DOSARE_PLATI WHERE ID_DOSAR = _ID_DOSAR AND ID_PLATA = _ID_PLATA;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_IsImported` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_IsImported`(
        _NR_DOCUMENT VARCHAR(100),
        _DATA_DOCUMENT DATETIME,
        _SUMA DOUBLE
    )
BEGIN
        SELECT ID FROM PLATI WHERE NR_DOCUMENT = _NR_DOCUMENT AND DATA_DOCUMENT = _DATA_DOCUMENT AND SUMA = _SUMA;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_RegularImport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_RegularImport`(
        _NR_AZT VARCHAR(250),
        _VALOARE_DAUNA DOUBLE,
        _ONORARIU_AVOCAT DOUBLE,
        _TAXA_TIMBRU DOUBLE,
        _TIMBRU_JUDICIAR DOUBLE,
        _NR_DOCUMENT VARCHAR(250),
        _DATA_DOCUMENT DATETIME,
        _SUMA DOUBLE
    )
BEGIN
        DECLARE _ID_PLATA INT;
        DECLARE _ID_DOSAR INT;
        DECLARE _EX INT;
        DECLARE _STADIU VARCHAR(250);
        DECLARE _DEBIT_TOTAL DOUBLE;

        SELECT _ID_DOSAR = ID FROM DOSARE WHERE NR_AZT = _NR_AZT LIMIT 1;
        IF _ID_DOSAR IS NOT NULL THEN
                BEGIN
                SELECT _EX = COUNT(*) FROM PLATI WHERE
                        NR_DOCUMENT = _NR_DOCUMENT AND
                        DATA_DOCUMENT = _DATA_DOCUMENT AND
                        SUMA = _SUMA;

                IF _EX IS NULL OR _EX = 0 THEN
                        BEGIN
                        INSERT INTO PLATI
                        SET NR_DOCUMENT = _NR_DOCUMENT,
                        DATA_DOCUMENT = _DATA_DOCUMENT,
                        SUMA = _SUMA;
                        SET _ID_PLATA = LAST_INSERT_ID();

                        INSERT INTO DOSARE_PLATI
                        SET ID_DOSAR = _ID_DOSAR,
                        ID_PLATA = _ID_PLATA;

                        IF _VALOARE_DAUNA IS NOT NULL THEN
                                SET _DEBIT_TOTAL = _DEBIT_TOTAL + _VALOARE_DAUNA;
                        END IF;
                        IF _ONORARIU_AVOCAT IS NOT NULL THEN
                                SET _DEBIT_TOTAL = _DEBIT_TOTAL + _ONORARIU_AVOCAT;
                        END IF;
                        IF _TAXA_TIMBRU IS NOT NULL THEN
                                SET _DEBIT_TOTAL = _DEBIT_TOTAL + _TAXA_TIMBRU;
                        END IF;
                        IF _TIMBRU_JUDICIAR IS NOT NULL THEN
                                SET _DEBIT_TOTAL = _DEBIT_TOTAL + _TIMBRU_JUDICIAR;
                        END IF;

                        CASE WHEN _SUMA >= _DEBIT_TOTAL THEN
                                SET _STADIU = 'platit integral';
                        ELSE
                                SET _STADIU = 'platit partial';
                        END CASE;

                        INSERT INTO DOSARE_STADII
                        SET ID_DOSAR = _ID_DOSAR,
                        ID_STADIU = (SELECT ID FROM STADII WHERE LCASE(DENUMIRE) = _STADIU),
                        DATA = CURDATE(),
                        SCADENTA = CURDATE(),
                        TERMEN = CURDATE();
                        END;
                END IF;
                CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);
                END;
        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_RegularImport2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_RegularImport2`(
        _NR_AZT VARCHAR(250),
        _POLITA_AZT VARCHAR(250),
        _AUTO_AZT VARCHAR(250),
        _DOCUMENT_PLATA1 VARCHAR(250),
        _DATA_PLATA1 DATETIME,
        _SUMA_RECUPERATA1 DOUBLE,
        _DOCUMENT_PLATA2 VARCHAR(250),
        _DATA_PLATA2 DATETIME,
        _SUMA_RECUPERATA2 DOUBLE,
        _DOCUMENT_PLATA3 VARCHAR(250),
        _DATA_PLATA3 DATETIME,
        _SUMA_RECUPERATA3 DOUBLE
    )
BEGIN
        DECLARE _ID_PLATA INT;
        DECLARE _ID_DOSAR INT;
        DECLARE _EX INT;
        DECLARE _STADIU VARCHAR(250);
        DECLARE _VALOARE_DAUNA1 DOUBLE;
        DECLARE _VALOARE_DAUNA2 DOUBLE;
        DECLARE _DEBIT_TOTAL DOUBLE;
        DECLARE _SUMA DOUBLE;


        SET _ID_DOSAR = (SELECT ID FROM DOSARE WHERE NR_AZT = _NR_AZT LIMIT 1);
        IF _ID_DOSAR IS NULL THEN
                BEGIN
                SET _ID_DOSAR = (SELECT ID FROM DOSARE WHERE POLITA_AZT = _POLITA_AZT LIMIT 1);
                IF _ID_DOSAR IS NULL THEN
                        SET _ID_DOSAR = (SELECT ID FROM DOSARE WHERE AUTO_AZT = _AUTO_AZT LIMIT 1);
                END IF;
                END;
        END IF;

        SET _VALOARE_DAUNA1 = (SELECT IF(R.VALOARE_REGRES IS NULL OR R.VALOARE_REGRES=0, R.VALOARE_DAUNA, R.VALOARE_REGRES) FROM DOSARE R WHERE R.NR_AZT = _NR_AZT);

        SET _VALOARE_DAUNA2 = (SELECT (IF(D.SUMA_SOLICITATA IS NULL, 0, D.SUMA_SOLICITATA) + IF(D.PENALITATI IS NULL, 0, D.PENALITATI) + IF(D.TAXA_TIMBRU IS NULL, 0, D.TAXA_TIMBRU) + IF(D.TIMBRU_JUDICIAR IS NULL, 0, D.TIMBRU_JUDICIAR) + IF(D.ONORARIU_AVOCAT IS NULL, 0, D.ONORARIU_AVOCAT) + IF(D.ONORARIU_EXPERT IS NULL, 0, D.ONORARIU_EXPERT)) FROM PROCESE D INNER JOIN DOSARE_PROCESE RD ON D.ID = RD.ID_PROCES INNER JOIN DOSARE R ON RD.ID_DOSAR = R.ID WHERE R.NR_AZT = _NR_AZT);

        SET _DEBIT_TOTAL = IF(_VALOARE_DAUNA2 IS NULL OR _VALOARE_DAUNA2 <= 0, IF(_VALOARE_DAUNA1 IS NULL, 0, _VALOARE_DAUNA1), _VALOARE_DAUNA2);

        SET _SUMA = (SELECT SUM(P.SUMA) SUMA FROM PLATI P INNER JOIN DOSARE_PLATI RP ON P.ID = RP.ID_PLATA INNER JOIN DOSARE R ON RP.ID_DOSAR = R.ID  WHERE R.NR_AZT = _NR_AZT GROUP BY RP.ID_DOSAR);


                        CASE WHEN _SUMA >= _DEBIT_TOTAL THEN
                                SET _STADIU = 'platit integral';
                        ELSE
                                SET _STADIU = 'platit partial';
                        END CASE;

                        INSERT INTO DOSARE_STADII
                        SET ID_DOSAR = _ID_DOSAR,
                        ID_STADIU = (SELECT ID FROM STADII WHERE LCASE(DENUMIRE) = _STADIU),
                        DATA = CURDATE();
                        

        IF _ID_DOSAR IS NOT NULL THEN
                BEGIN

                SELECT _EX = COUNT(*) FROM PLATI WHERE
                        NR_DOCUMENT = _DOCUMENT_PLATA1 AND
                        DATA_DOCUMENT = _DATA_PLATA1 AND
                        SUMA = _SUMA_RECUPERATA1;

                IF (_EX IS NULL OR _EX = 0) AND _DOCUMENT_PLATA1 IS NOT NULL AND _DATA_PLATA1 IS NOT NULL AND _SUMA_RECUPERATA1 IS NOT NULL THEN
                        BEGIN
                        INSERT INTO PLATI
                        SET NR_DOCUMENT = _DOCUMENT_PLATA1,
                        DATA_DOCUMENT = _DATA_PLATA1,
                        SUMA = _SUMA_RECUPERATA1;
                        SET _ID_PLATA = LAST_INSERT_ID();

                        INSERT INTO DOSARE_PLATI
                        SET ID_DOSAR = _ID_DOSAR,
                        ID_PLATA = _ID_PLATA;
                        END;
                END IF;

                SELECT _EX = COUNT(*) FROM PLATI WHERE
                        NR_DOCUMENT = _DOCUMENT_PLATA2 AND
                        DATA_DOCUMENT = _DATA_PLATA2 AND
                        SUMA = _SUMA_RECUPERATA2;

                IF (_EX IS NULL OR _EX = 0) AND _DOCUMENT_PLATA2 IS NOT NULL AND _DATA_PLATA2 IS NOT NULL AND _SUMA_RECUPERATA2 IS NOT NULL THEN
                        BEGIN
                        INSERT INTO PLATI
                        SET NR_DOCUMENT = _DOCUMENT_PLATA2,
                        DATA_DOCUMENT = _DATA_PLATA2,
                        SUMA = _SUMA_RECUPERATA2;
                        SET _ID_PLATA = LAST_INSERT_ID();

                        INSERT INTO DOSARE_PLATI
                        SET ID_DOSAR = _ID_DOSAR,
                        ID_PLATA = _ID_PLATA;
                        END;
                END IF;

                SELECT _EX = COUNT(*) FROM PLATI WHERE
                        NR_DOCUMENT = _DOCUMENT_PLATA3 AND
                        DATA_DOCUMENT = _DATA_PLATA3 AND
                        SUMA = _SUMA_RECUPERATA3;

                IF (_EX IS NULL OR _EX = 0) AND _DOCUMENT_PLATA3 IS NOT NULL AND _DATA_PLATA3 IS NOT NULL AND _SUMA_RECUPERATA3 IS NOT NULL THEN
                        BEGIN
                        INSERT INTO PLATI
                        SET NR_DOCUMENT = _DOCUMENT_PLATA3,
                        DATA_DOCUMENT = _DATA_PLATA3,
                        SUMA = _SUMA_RECUPERATA3;
                        SET _ID_PLATA = LAST_INSERT_ID();

                        INSERT INTO DOSARE_PLATI
                        SET ID_DOSAR = _ID_DOSAR,
                        ID_PLATA = _ID_PLATA;
                        END;
                END IF;
                CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);

                END;
        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_RegularImport3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_RegularImport3`(

        _NR_AZT VARCHAR(250),

        _POLITA_AZT VARCHAR(250),

        _AUTO_AZT VARCHAR(250),

        _DOCUMENT_PLATA VARCHAR(250),

        _DATA_PLATA DATETIME,

        _SUMA_RECUPERATA DOUBLE

    )
BEGIN

        DECLARE _ID_PLATA INT;

        DECLARE _ID_DOSAR INT;

        DECLARE _EX INT;

        DECLARE _ID_PLATA_EXIST INT;





        SET _ID_DOSAR = (SELECT ID FROM DOSARE WHERE NR_AZT = _NR_AZT LIMIT 1);

        IF _ID_DOSAR IS NULL THEN

                BEGIN

                SET _ID_DOSAR = (SELECT ID FROM DOSARE WHERE POLITA_AZT = _POLITA_AZT LIMIT 1);

                IF _ID_DOSAR IS NULL THEN

                        SET _ID_DOSAR = (SELECT ID FROM DOSARE WHERE AUTO_AZT = _AUTO_AZT LIMIT 1);

                END IF;

                END;

        END IF;







        IF _ID_DOSAR IS NOT NULL THEN

                BEGIN



                SET _ID_PLATA_EXIST = (SELECT ID FROM PLATI WHERE

                        NR_DOCUMENT = _DOCUMENT_PLATA AND

                        DATA_DOCUMENT = _DATA_PLATA AND

                        SUMA = _SUMA_RECUPERATA);



                SELECT _EX = COUNT(*) FROM DOSARE_PLATI WHERE ID_DOSAR = _ID_DOSAR AND ID_PLATA = _ID_PLATA_EXIST;



                IF (_EX IS NULL OR _EX = 0) AND _DOCUMENT_PLATA IS NOT NULL AND _DATA_PLATA IS NOT NULL AND _SUMA_RECUPERATA IS NOT NULL THEN

                        BEGIN

                        INSERT INTO PLATI

                        SET NR_DOCUMENT = _DOCUMENT_PLATA,

                        DATA_DOCUMENT = _DATA_PLATA,

                        SUMA = _SUMA_RECUPERATA;

                        SET _ID_PLATA = LAST_INSERT_ID();



                        INSERT INTO DOSARE_PLATI

                        SET ID_DOSAR = _ID_DOSAR,

                        ID_PLATA = _ID_PLATA;

                        END;

                END IF;



                CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);



                END;

        END IF;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_select`(
        _ID_DOSAR INT,
        _SORT VARCHAR(100),
        _ORDER VARCHAR(5),
        _FILTER VARCHAR(8000)
    )
BEGIN

        DECLARE _QUERY VARCHAR(8000);
        DECLARE _CNT INT;
        DECLARE _SUB BOOLEAN;

        SET _SUB = FALSE;

        IF _ID_DOSAR IS NOT NULL THEN
                BEGIN
                SET _CNT = (SELECT COUNT(*) AS CNT FROM PLATI P INNER JOIN DOSARE_PLATI RP ON P.ID = RP.ID_PLATA WHERE RP.ID_DOSAR = _ID_DOSAR);
                IF _CNT IS NULL OR _CNT = 0 THEN
                        BEGIN
                        SET @_QUERY = 'SELECT -1 ID, NULL NR_DOCUMENT, NULL DATA_DOCUMENT, NULL SUMA, NULL OBSERVATII UNION SELECT ID, NR_DOCUMENT, DATA_DOCUMENT, SUMA, OBSERVATII FROM PLATI P WHERE ID NOT IN (SELECT ID_PLATA FROM DOSARE_PLATI);';
                        SET _SUB = TRUE;
                        END;
                END IF;
                END;
        END IF;

        IF _SUB = FALSE THEN
                BEGIN
                SET @_QUERY = CONCAT('SELECT P.* FROM PLATI P ');

                CASE WHEN _ID_DOSAR IS NOT NULL THEN
                        BEGIN
                                SET @_QUERY = CONCAT(@_QUERY, 'LEFT JOIN (SELECT * FROM DOSARE_PLATI WHERE ID_DOSAR=', _ID_DOSAR, ') RP ON P.ID = RP.ID_PLATA ');
                                SET @_QUERY = CONCAT(@_QUERY, ' INNER JOIN
                                        (SELECT ID FROM PLATI WHERE ID IN
                                                (SELECT ID_PLATA FROM DOSARE_PLATI WHERE ID_DOSAR=',_ID_DOSAR ,')
                                                OR ID NOT IN (SELECT ID_PLATA FROM DOSARE_PLATI WHERE ID_DOSAR != ', _ID_DOSAR,') )
                                        RP1 ON P.ID = RP1.ID ');
                        END;
                ELSE
                        SET @_QUERY = @_QUERY;
                END CASE;

                CASE WHEN _FILTER IS NOT NULL THEN
                        SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', _FILTER);
                ELSE
                        SET @_QUERY = @_QUERY;
                END CASE;


                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ');

                CASE WHEN _ID_DOSAR IS NOT NULL THEN
                        BEGIN
                                SET @_QUERY = CONCAT(@_QUERY, ' RP.ID_PLATA DESC ');
                        END;
                ELSE
                        SET @_QUERY = @_QUERY;
                END CASE;


                CASE WHEN _SORT IS NOT NULL THEN
                        BEGIN
                                CASE WHEN _ID_DOSAR IS NOT NULL THEN
                                        SET @_QUERY = CONCAT(@_QUERY, ',');
                                ELSE
                                        SET @_QUERY = @_QUERY;
                                END CASE;

                                SET @_QUERY = CONCAT(@_QUERY, ' ', _SORT);
                        END;
                ELSE
                        SET @_QUERY = @_QUERY;
                END CASE;

                CASE WHEN _ID_DOSAR IS NULL AND _SORT IS NULL THEN
                        SET @_QUERY = CONCAT(@_QUERY, ' ID ');
                ELSE
                        SET @_QUERY = @_QUERY;
                END CASE;


                CASE WHEN _ORDER IS NOT NULL THEN
                        SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);
                ELSE
                        SET @_QUERY = @_QUERY;
                END CASE;
                SET @_QUERY = CONCAT(@_QUERY, ';');
                END;
        END IF;


        PREPARE stmt1 FROM @_QUERY;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE plati SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATIsp_update`(
        _ID INT,
        _NR_DOCUMENT VARCHAR(50),
        _DATA_DOCUMENT DATETIME,
        _SUMA DOUBLE,
        _OBSERVATII TEXT
    )
BEGIN
        DECLARE _ID_DOSAR INT;
        SET _ID_DOSAR = (SELECT ID_DOSAR FROM DOSARE_PLATI WHERE ID_PLATA = _ID);
                        UPDATE PLATI
                        SET NR_DOCUMENT = _NR_DOCUMENT,
                        DATA_DOCUMENT = _DATA_DOCUMENT,
                        SUMA = _SUMA,
                        OBSERVATII = _OBSERVATII
                        WHERE ID = _ID;
        IF _ID_DOSAR IS NOT NULL THEN
                CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_CONTRACTEsp_ChainDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_CONTRACTEsp_ChainDelete`(
        _ID INT
    )
BEGIN
        DELETE FROM CONTRACTE_PLATI_CONTRACTE WHERE ID_PLATA_CONTRACT = _ID;
        DELETE FROM DOSARE_PLATI_CONTRACTE WHERE ID_PLATA_CONTRACT = _ID;
        DELETE FROM PLATI_CONTRACTE WHERE ID = _ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_CONTRACTEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_CONTRACTEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM plati_contracte;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_CONTRACTEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_CONTRACTEsp_delete`(
        _ID INT
    )
BEGIN
        DELETE FROM PLATI_CONTRACTE WHERE ID = _ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_CONTRACTEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_CONTRACTEsp_GetById`(
        _ID INT
    )
BEGIN
        SELECT * FROM PLATI_CONTRACTE WHERE ID = _ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_CONTRACTEsp_GetColumns` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_CONTRACTEsp_GetColumns`()
BEGIN
        SHOW COLUMNS FROM PLATI_CONTRACTE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_CONTRACTEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_CONTRACTEsp_insert`(

        

        _NR_DOCUMENT VARCHAR(50),

        _DATA_DOCUMENT DATETIME,

        _SUMA DOUBLE,

        _OBSERVATII TEXT,

        _INCASAT_PE_AMIABIL BOOL,

        _INCASAT_CONTRACT BOOLEAN,

        OUT _ID INT

    )
BEGIN

        


        

                INSERT INTO PLATI_CONTRACTE

                        SET NR_DOCUMENT = _NR_DOCUMENT,

                                DATA_DOCUMENT = _DATA_DOCUMENT,

                                SUMA = _SUMA,

                                OBSERVATII = _OBSERVATII,

                                INCASAT_PE_AMIABIL = _INCASAT_PE_AMIABIL,

                                INCASAT_CONTRACT = _INCASAT_CONTRACT;



                SET _ID = LAST_INSERT_ID();

                

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_CONTRACTEsp_IsAssigned` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_CONTRACTEsp_IsAssigned`(
        _ID_CONTRACT INT,
        _ID_PLATA_CONTRACT INT
    )
BEGIN
        SELECT COUNT(*) FROM CONTRACTE_PLATI_CONTRACTE WHERE ID_CONTRACT = _ID_CONTRACT AND ID_PLATA_CONTRACT = _ID_PLATA_CONTRACT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_CONTRACTEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_CONTRACTEsp_select`(

        _ID_CONTRACT INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(8000)

    )
BEGIN



        DECLARE _QUERY VARCHAR(8000);

        DECLARE _CNT INT;

        DECLARE _SUB BOOLEAN;



        SET _SUB = FALSE;



        IF _ID_CONTRACT IS NOT NULL THEN

                BEGIN

                SET _CNT = (SELECT COUNT(*) AS CNT FROM PLATI_CONTRACTE P INNER JOIN CONTRACTE_PLATI_CONTRACTE RP ON P.ID = RP.ID_PLATA WHERE RP.ID_CONTRACT = _ID_CONTRACT);

                IF _CNT IS NULL OR _CNT = 0 THEN

                        BEGIN

                        SET @_QUERY = 'SELECT -1 ID, NULL NR_DOCUMENT, NULL DATA_DOCUMENT, NULL SUMA, NULL OBSERVATII, NULL INCASAT_PE_AMIABIL, NULL INCASAT_CONTRACT UNION SELECT ID, NR_DOCUMENT, DATA_DOCUMENT, SUMA, OBSERVATII, INCASAT_PE_AMIABIL, INCASAT_CONTRACT FROM PLATI_CONTRACTE P WHERE ID NOT IN (SELECT ID_PLATA_CONTRACT FROM CONTRACTE_PLATI_CONTRACTE);';

                        SET _SUB = TRUE;

                        END;

                END IF;

                END;

        END IF;



        IF _SUB = FALSE THEN

                BEGIN

                SET @_QUERY = CONCAT('SELECT P.* FROM PLATI_CONTRACTE P ');



                CASE WHEN _ID_CONTRACT IS NOT NULL THEN

                        BEGIN

                                SET @_QUERY = CONCAT(@_QUERY, 'LEFT JOIN (SELECT * FROM CONTRACTE_PLATI_CONTRACTE WHERE ID_CONTRACT = ', _ID_CONTRACT, ') RP ON P.ID = RP.ID_PLATA_CONTRACT ');

                                SET @_QUERY = CONCAT(@_QUERY, ' INNER JOIN

                                        (SELECT ID FROM PLATI_CONTRACTE WHERE ID IN

                                                (SELECT ID_PLATA_CONTRACT FROM CONTRACTE_PLATI_CONTRACTE WHERE ID_CONTRACT = ',_ID_CONTRACT ,')

                                                OR ID NOT IN (SELECT ID_PLATA_CONTRACT FROM CONTRACTE_PLATI_CONTRACTE WHERE ID_CONTRACT != ', _ID_CONTRACT,') )

                                        RP1 ON P.ID = RP1.ID ');

                        END;

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;



                CASE WHEN _FILTER IS NOT NULL THEN

                        SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', _FILTER);

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;





                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ');



                CASE WHEN _ID_CONTRACT IS NOT NULL THEN

                        BEGIN

                                SET @_QUERY = CONCAT(@_QUERY, ' RP.ID_PLATA_CONTRACT DESC ');

                        END;

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;





                CASE WHEN _SORT IS NOT NULL THEN

                        BEGIN

                                CASE WHEN _ID_CONTRACT IS NOT NULL THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ',');

                                ELSE

                                        SET @_QUERY = @_QUERY;

                                END CASE;



                                SET @_QUERY = CONCAT(@_QUERY, ' ', _SORT);

                        END;

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;



                CASE WHEN _ID_CONTRACT IS NULL AND _SORT IS NULL THEN

                        SET @_QUERY = CONCAT(@_QUERY, ' ID ');

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;





                CASE WHEN _ORDER IS NOT NULL THEN

                        SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;

                SET @_QUERY = CONCAT(@_QUERY, ';');

                END;

        END IF;





        PREPARE stmt1 FROM @_QUERY;

        EXECUTE stmt1;

        DEALLOCATE PREPARE stmt1;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_CONTRACTEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_CONTRACTEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE plati_contracte SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_CONTRACTEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_CONTRACTEsp_update`(

        _ID_DOSAR INT,

        _ID INT,

        _NR_DOCUMENT VARCHAR(50),

        _DATA_DOCUMENT DATETIME,

        _SUMA DOUBLE,

        _OBSERVATII TEXT,

        _INCASAT_PE_AMIABIL BOOL,

        _INCASAT_CONTRACT BOOL

    )
BEGIN

        DECLARE _ID_DOSAR_OLD INT;

        DECLARE _ID_CONTRACT_OLD INT;

        DECLARE _ID_PLATA_CONTRACT INT;

        DECLARE _INCASAT_PE_AMIABIL_OLD BOOLEAN;

        SET _INCASAT_PE_AMIABIL_OLD = (SELECT INCASAT_PE_AMIABIL FROM PLATI_CONTRACTE WHERE ID = _ID);



        IF _INCASAT_PE_AMIABIL_OLD = TRUE THEN

                BEGIN

                SET _ID_DOSAR_OLD = (SELECT ID_DOSAR FROM DOSARE_PLATI_CONTRACTE WHERE ID_PLATA_CONTRACT = _ID);

                SET _ID_DOSAR_OLD = IFNULL(_ID_DOSAR_OLD, _ID_DOSAR);

                DELETE FROM DOSARE_PLATI_CONTRACTE WHERE ID_PLATA_CONTRACT = _ID;

                DELETE FROM PLATI_CONTRACTE WHERE ID = _ID;

                IF _INCASAT_PE_AMIABIL = TRUE THEN

                        BEGIN

                        INSERT INTO PLATI_CONTRACTE

                                SET NR_DOCUMENT = _NR_DOCUMENT,

                                DATA_DOCUMENT = _DATA_DOCUMENT,

                                SUMA = _SUMA,

                                OBSERVATII = _OBSERVATII,

                                INCASAT_PE_AMIABIL = _INCASAT_PE_AMIABIL,

                                INCASAT_CONTRACT = _INCASAT_CONTRACT;

                                SET _ID_PLATA_CONTRACT = LAST_INSERT_ID();

                                INSERT INTO DOSARE_PLATI_CONTRACTE SET ID_DOSAR = _ID_DOSAR_OLD, ID_PLATA_CONTRACT = _ID_PLATA_CONTRACT;

                        END;

                ELSE

                        BEGIN

                        SET _ID_CONTRACT_OLD = (SELECT ID_CONTRACT FROM PROCESE D INNER JOIN DOSARE_PROCESE RD ON D.ID = RD.ID_PROCES WHERE RD.ID_DOSAR = _ID_DOSAR_OLD);

                        INSERT INTO PLATI_CONTRACTE

                                SET NR_DOCUMENT = _NR_DOCUMENT,

                                DATA_DOCUMENT = _DATA_DOCUMENT,

                                SUMA = _SUMA,

                                OBSERVATII = _OBSERVATII,

                                INCASAT_PE_AMIABIL = _INCASAT_PE_AMIABIL,

                                INCASAT_CONTRACT = _INCASAT_CONTRACT;

                                SET _ID_PLATA_CONTRACT = LAST_INSERT_ID();

                                INSERT INTO CONTRACTE_PLATI_CONTRACTE SET ID_CONTRACT = _ID_CONTRACT_OLD, ID_PLATA_CONTRACT = _ID_PLATA_CONTRACT;

                        END;

                END IF;

                END;

        ELSE

                BEGIN

                SET _ID_CONTRACT_OLD = (SELECT ID_CONTRACT FROM CONTRACTE_PLATI_CONTRACTE WHERE ID_PLATA_CONTRACT = _ID);

                SET _ID_DOSAR_OLD = (SELECT ID_DOSAR FROM DOSARE_PROCESE RD INNER JOIN PROCESE D ON RD.ID_PROCES=D.ID WHERE D.ID_CONTRACT = _ID_CONTRACT_OLD);

                SET _ID_DOSAR_OLD = IFNULL(_ID_DOSAR_OLD, _ID_DOSAR);

                DELETE FROM CONTRACTE_PLATI_CONTRACTE WHERE ID_PLATA_CONTRACT = _ID;

                DELETE FROM DOSARE_PLATI_CONTRACTE WHERE  ID_PLATA_CONTRACT = _ID; 
                DELETE FROM PLATI_CONTRACTE WHERE ID = _ID;

                IF _INCASAT_PE_AMIABIL = TRUE THEN

                        BEGIN

                        INSERT INTO PLATI_CONTRACTE

                                SET NR_DOCUMENT = _NR_DOCUMENT,

                                DATA_DOCUMENT = _DATA_DOCUMENT,

                                SUMA = _SUMA,

                                OBSERVATII = _OBSERVATII,

                                INCASAT_PE_AMIABIL = _INCASAT_PE_AMIABIL,

                                INCASAT_CONTRACT = _INCASAT_CONTRACT;

                                SET _ID_PLATA_CONTRACT = LAST_INSERT_ID();

                                INSERT INTO DOSARE_PLATI_CONTRACTE SET ID_DOSAR = _ID_DOSAR_OLD, ID_PLATA_CONTRACT = _ID_PLATA_CONTRACT;

                        END;

                ELSE

                        BEGIN

                        IF _ID_CONTRACT_OLD IS NOT NULL THEN

                                INSERT INTO PLATI_CONTRACTE

                                        SET NR_DOCUMENT = _NR_DOCUMENT,

                                        DATA_DOCUMENT = _DATA_DOCUMENT,

                                        SUMA = _SUMA,

                                        OBSERVATII = _OBSERVATII,

                                        INCASAT_PE_AMIABIL = _INCASAT_PE_AMIABIL,

                                        INCASAT_CONTRACT = _INCASAT_CONTRACT;

                                        SET _ID_PLATA_CONTRACT = LAST_INSERT_ID();

                                        INSERT INTO CONTRACTE_PLATI_CONTRACTE SET ID_CONTRACT = _ID_CONTRACT_OLD, ID_PLATA_CONTRACT = _ID_PLATA_CONTRACT;

                        ELSE 
                                INSERT INTO PLATI_CONTRACTE

                                        SET NR_DOCUMENT = _NR_DOCUMENT,

                                        DATA_DOCUMENT = _DATA_DOCUMENT,

                                        SUMA = _SUMA,

                                        OBSERVATII = _OBSERVATII,

                                        INCASAT_PE_AMIABIL = _INCASAT_PE_AMIABIL,

                                        INCASAT_CONTRACT = _INCASAT_CONTRACT;

                                        SET _ID_PLATA_CONTRACT = LAST_INSERT_ID();

                                        INSERT INTO DOSARE_PLATI_CONTRACTE SET ID_DOSAR = _ID_DOSAR_OLD, ID_PLATA_CONTRACT = _ID_PLATA_CONTRACT;

                        END IF;

                        END;

                END IF;

                END;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_TAXA_TIMBRUsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_TAXA_TIMBRUsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM plati_taxa_timbru;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_TAXA_TIMBRUsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_TAXA_TIMBRUsp_delete`(_ID INT)
BEGIN

        DELETE FROM PLATI_TAXA_TIMBRU WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_TAXA_TIMBRUsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_TAXA_TIMBRUsp_insert`(

        

        _NR_DOCUMENT VARCHAR(50),

        _DATA_DOCUMENT DATETIME,

        _SUMA DOUBLE,

        _OBSERVATII TEXT,

        OUT _ID INT

    )
BEGIN

        
        INSERT INTO PLATI_TAXA_TIMBRU

                SET NR_DOCUMENT = _NR_DOCUMENT,

                        DATA_DOCUMENT = _DATA_DOCUMENT,

                        SUMA = _SUMA,

                        OBSERVATII = _OBSERVATII;



                SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PLATI_TAXA_TIMBRUsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PLATI_TAXA_TIMBRUsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE plati_taxa_timbru SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_add` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_add`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT

        -1	  ID,

        null	NR_INTERN,

        null	DATA_SCA,

        null	ID_ASIGURAT,

        null	POLITA_AZT,

        null	DATA_POLITA_AZT,

        null	AUTO_AZT,

        null	ID_SOCIETATE,

        null	POLITA_RCA,

        null	AUTO_RCA,

        null	VALOARE_DAUNA,

        null	VALOARE_REGRES,

        null	NR_REGRES,

        null	DATA_REGRES,

        null	ID_INTERVENIENT,

        null	NR_AZT,

        null	DOSAR_COMPLET,

        null	VMD,

        null	ACCEPT_AZT,

        null	EXTRACONTRACT,

        null	OBSERVATII,

        null	ZILE_INTARZIERE,

        null	PENALITATI,

        null	DEBIT_TOTAL,

        null	PLATIT,

        null	DIFERENTA;

        



        SELECT

        -1	  ID,

        null	ID_DOSAR,

        null	ID_STADIU,

        null	TERMEN,

        null	OBSERVATII,

        null	DATA,

        null	SCADENTA,

        null	ORA,

        null        DENUMIRE,

        null        DETALII,

        null        ICON_PATH,

        null        PAS;

        



        SELECT

        -1	  ID,

        null	NR_INTERN,

        null	NR_DOSAR_INSTANTA,

        null	DATA_DEPUNERE,

        null	OBSERVATII,

        null	ID_TIP_DOSAR,

        null	SUMA_SOLICITATA,

        null	PENALITATI,

        null	TAXA_TIMBRU,

        null	TIMBRU_JUDICIAR,

        null	ONORARIU_EXPERT,

        null	ONORARIU_AVOCAT,

        null	ID_INSTANTA,

        null	ID_COMPLET,

        null	ID_CONTRACT,

        null	STADIU,

        null	ZILE_PENALIZARI;

        



        SELECT

        -1	  ID,

        null	NR_DOCUMENT,

        null	DATA_DOCUMENT,

        null	SUMA,

        null	OBSERVATII;

        



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_ChainDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_ChainDelete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN              

        DROP TABLE IF EXISTS _TEMP2;

        CREATE TEMPORARY TABLE _TEMP2 (ID INT);

        INSERT INTO _TEMP2 (SELECT ID_PLATA_TAXA_TIMBRU FROM PROCESE_PLATI_TAXA_TIMBRU WHERE ID_PROCES = _ID);

        DELETE FROM PROCESE_PLATI_TAXA_TIMBRU WHERE ID_PROCES = _ID;

        DELETE FROM PLATI_TAXA_TIMBRU WHERE ID IN (SELECT ID FROM _TEMP2);



        DROP TABLE IF EXISTS _TEMP3;

        CREATE TEMPORARY TABLE _TEMP3 (ID INT);

        INSERT INTO _TEMP3 (SELECT ID_CONTRACT FROM PROCESE WHERE ID = _ID);



        DROP TABLE IF EXISTS _TEMP4;

        CREATE TEMPORARY TABLE _TEMP4 (ID INT);

        INSERT INTO _TEMP4 (SELECT ID_PLATA_CONTRACT FROM CONTRACTE_PLATI_CONTRACTE WHERE ID_CONTRACT IN (SELECT ID FROM _TEMP3));

        DELETE FROM CONTRACTE_PLATI_CONTRACTE WHERE ID_CONTRACT IN (SELECT ID FROM _TEMP3);

        DELETE FROM PLATI_CONTRACTE WHERE ID IN (SELECT ID FROM _TEMP4);



        DELETE FROM DOSARE_PROCESE WHERE ID_PROCES = _ID;

        DELETE FROM PROCESE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM procese;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DECLARE _ID_DOSAR INT;

        SET _ID_DOSAR = (SELECT ID_DOSAR FROM DOSARE_PROCESE WHERE ID_PROCES = _ID);

        DELETE FROM PROCESE WHERE ID = _ID;

        IF _ID_DOSAR IS NOT NULL THEN

                CALL DOSAREsp_UpdateCalculAll(_ID_DOSAR);

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_ExportExcel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_ExportExcel`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(8000)

    )
BEGIN           



        DECLARE _QUERY VARCHAR(8000);



        DROP TABLE IF EXISTS _TEMP4;

        CREATE TEMPORARY TABLE _TEMP4 (

        ID_PROCES INT,

        OP_TAXA_TIMBRU VARCHAR(1000),

        DATA_OP_TAXA_TIMBRU VARCHAR(1000),

        TAXA_TIMBRU VARCHAR(1000),

        TOTAL_TAXE_TIMBRU DOUBLE

        );        

        INSERT INTO _TEMP4 (SELECT DPTT.ID_PROCES,

                                GROUP_CONCAT(PTT.NR_DOCUMENT SEPARATOR ' / ') ,

                                GROUP_CONCAT(DATE_FORMAT(PTT.DATA_DOCUMENT, '%d.%m.%Y') SEPARATOR ' / ')  ,

                                GROUP_CONCAT(PTT.SUMA SEPARATOR ' / ') ,

                                SUM(PTT.SUMA)

                          FROM PROCESE_PLATI_TAXA_TIMBRU DPTT

                          INNER JOIN PLATI_TAXA_TIMBRU PTT ON DPTT.ID_PLATA_TAXA_TIMBRU = PTT.ID

                          GROUP BY DPTT.ID_PROCES

                        );

                                

                SET @_QUERY = CONCAT('SELECT

                                R.NR_AZT `Nr. AZT`,

                                R.NR_INTERN `Nr. SCA`,

                                DATE_FORMAT(R.DATA_SCA, ''%d.%m.%Y'') `Data SCA`,

                                R.NR_INTERN `Nr. intern`,

                                D.NR_DOSAR_INSTANTA `Nr. dosar`,

                                DATE_FORMAT(D.DATA_DEPUNERE, ''%d.%m.%Y'') `Data depunerii`,

                                D.OBSERVATII `Observatii`,

                                TD.DENUMIRE `Tip dosar`,

                                D.SUMA_SOLICITATA `Suma solicitata`,

                                D.PENALITATI `Penalitati`,

                                D.TAXA_TIMBRU `Taxa timbru`,

                                D.TIMBRU_JUDICIAR `Timbru judiciar`,

                                D.ONORARIU_EXPERT `Onorariu expert`,

                                D.ONORARIU_AVOCAT `Onorariu avocat`,



                                D.CHELTUIELI_MICA_PUBLICITATE `Cheltuieli cu mica publicitate`,

                                D.ONORARIU_CURATOR `Onorariu curator`,

                                D.ALTE_CHELTUIELI_JUDECATA `Alte cheltuieli de judecata`,

                                D.TAXA_TIMBRU_REEXAMINARE `Taxa de timbru reexaminare`,



                                D.NR_DOSAR_EXECUTARE `Numar dosar executare`,

                                D.DATA_EXECUTARE `Data executare`,

                                D.ONORARIU_AVOCAT_EXECUTARE `Onorariu avocat executare`,

                                D.CHELTUIELI_EXECUTARE `Cheltuieli executare`,

                                D.DESPAGUBIRE_ACORDATA `Despagubire acordata`,

                                D.CHELTUIELI_JUDECATA_ACORDATE `Cheltuieli de judecata acordate`,

                                

                                I.DENUMIRE `Instanta`,

                                C.DENUMIRE `Complet`,

                                CTR.NR_CONTRACT `Contract de asistenta juridica`,

                                D.STADIU `Stadiu dosar`,

                                INTER.DENUMIRE `Intervenient`,

                                IF(RS2.TERMEN IS NULL, ''---'', DATE_FORMAT(RS2.TERMEN, ''%d.%m.%Y'')) `Termen`,

                                IF(RS2.ORA IS NULL, ''---'', RS2.ORA) `Ora`,

                                PTT.OP_TAXA_TIMBRU `OP taxa timbru`

                         FROM PROCESE D ',

                        'LEFT JOIN TIP_PROCESE TD ON D.ID_TIP_DOSAR = TD.ID ',

                        'LEFT JOIN INSTANTE I ON D.ID_INSTANTA = I.ID ',

                        'LEFT JOIN COMPLETE C ON D.ID_COMPLET = C.ID ',

                        'LEFT JOIN CONTRACTE CTR ON D.ID_CONTRACT = CTR.ID ',

                        'LEFT JOIN DOSARE_PROCESE RD3 ON D.ID = RD3.ID_PROCES ',

                        'INNER JOIN DOSARE R ON RD3.ID_DOSAR = R.ID ',

                        'LEFT JOIN INTERVENIENTI INTER ON R.ID_INTERVENIENT = INTER.ID ',

                        'LEFT JOIN _TEMP4 PTT ON d.ID = PTT.ID_PROCES '

                        'LEFT JOIN

                                (SELECT RS3.ID_DOSAR, RS3.TERMEN, RS3.ORA FROM DOSARE_STADII RS3 INNER JOIN (SELECT ID_DOSAR, MAX(TERMEN) TERMEN FROM DOSARE_STADII WHERE ID_STADIU IN (SELECT ID FROM STADII WHERE LOWER(DENUMIRE) IN (''chemare in judecata'', ''fond'', ''pe rol'', ''judecat'', ''apel'', ''recurs'', ''sentinta finala'')) GROUP BY ID_DOSAR) RS4 ON RS3.ID_DOSAR=RS4.ID_DOSAR AND RS3.TERMEN=RS4.TERMEN) RS2 ON R.ID = RS2.ID_DOSAR '

                        );



                IF _FILTER IS NOT NULL THEN

                        SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', _FILTER);

                ELSE

                        SET @_QUERY = @_QUERY;

                END IF;



                CASE WHEN _SORT IS NOT NULL THEN

                        BEGIN

                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ');

                                

                                CASE WHEN _SORT = 'TIP_DOSAR' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' TD.DENUMIRE ');

                                WHEN _SORT = 'INSTANTE' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' I.DENUMIRE ');

                                WHEN _SORT = 'COMPLETE' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' C.DENUMIRE ');

                                WHEN _SORT = 'CONTRACTE' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' CTR.NR_CONTRACT ' );

                                ELSE

                                        SET @_QUERY = CONCAT(@_QUERY, ' ', _SORT);

                                END CASE;

                        END;

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;



                CASE WHEN _ORDER IS NOT NULL THEN

                        SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;

                SET @_QUERY = CONCAT(@_QUERY, ';');





          





          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;







END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT D.* FROM PROCESE D

        LEFT JOIN DOSARE_PROCESE RD ON D.ID = RD.ID_PROCES

        INNER JOIN DOSARE R ON RD.ID_DOSAR = R.ID

        WHERE D.ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_GetByIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_GetByIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT

    )
BEGIN

        SELECT D.* FROM PROCESE D

        INNER JOIN DOSARE_PROCESE RD ON RD.ID_PROCES = D.ID

        INNER JOIN DOSARE R ON RD.ID_DOSAR = R.ID

        WHERE RD.ID_DOSAR = _ID_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_GetColumns` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_GetColumns`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SHOW COLUMNS FROM PROCESE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_GetIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_GetIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_PROCES INT

    )
BEGIN

        SELECT ID_DOSAR FROM DOSARE_PROCESE WHERE ID_PROCES = _ID_PROCES LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_import` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_import`(

        _ID_DOSAR INT,

        _NR_INTERN INT,

        _NR_DOSAR VARCHAR(100),

        _DATA_DEPUNERE DATETIME,

        _OBSERVATII TEXT,

        _ID_TIP_DOSAR INT,

        _ID_INSTANTA INT,

        _ID_COMPLET INT,

        _TERMEN_CHEMARE_JUDECATA DATETIME,

        _ORA_CHEMARE_JUDECATA VARCHAR(5),

        _ID_CONTRACT INT,

        _SUMA_SOLICITATA DOUBLE,

        _PENALITATI DOUBLE,

        _TAXA_TIMBRU DOUBLE,

        _OP_TAXA_TIMBRU VARCHAR(10),

        _ID_PLATA_TAXA_TIMBRU INT,

        _TIMBRU_JUDICIAR DOUBLE,

        _ONORARIU_EXPERT DOUBLE,

        _ONORARIU_AVOCAT DOUBLE,

        _CHELTUIELI_MICA_PUBLICITATE DOUBLE,

        _ONORARIU_CURATOR DOUBLE,

        _ALTE_CHELTUIELI_JUDECATA DOUBLE,

        _TAXA_TIMBRU_REEXAMINARE DOUBLE,

        _STADIU VARCHAR(250),

        _ID_INTERVENIENT INT,

        _NR_CONTRACT VARCHAR(100),

        _DATA_CONTRACT DATETIME,

        _OBSERVATII_CONTRACT TEXT,

        _NR_DOSAR_EXECUTARE VARCHAR(100),

        _DATA_EXECUTARE DATETIME,

        _ONORARIU_AVOCAT_EXECUTARE DOUBLE,

        _CHELTUIELI_EXECUTARE DOUBLE,

        _DESPAGUBIRE_ACORDATA DOUBLE,

        _CHELTUIELI_JUDECATA_ACORDATE DOUBLE,

        _MONITORIZARE BOOL,

        OUT _ID INT

    )
BEGIN

        DECLARE _ID_PROCES INT;

        DECLARE _ID_PLATA_TAXA_TIMBRU2 INT;

        DECLARE _ID_CONTRACT INT;



        IF NOT EXISTS (SELECT ID FROM PROCESE WHERE

        (NR_INTERN =_NR_INTERN OR _NR_INTERN IS NULL) AND

        (NR_DOSAR_INSTANTA = _NR_DOSAR OR _NR_DOSAR IS NULL) AND

        (DATA_DEPUNERE = _DATA_DEPUNERE OR _DATA_DEPUNERE IS NULL) AND

        (OBSERVATII = _OBSERVATII OR _OBSERVATII IS NULL) AND

        (SUMA_SOLICITATA = _SUMA_SOLICITATA OR _SUMA_SOLICITATA IS NULL) AND

        (PENALITATI = _PENALITATI OR _PENALITATI IS NULL) AND

        (TAXA_TIMBRU = _TAXA_TIMBRU OR _TAXA_TIMBRU IS NULL) AND

        (TIMBRU_JUDICIAR = _TIMBRU_JUDICIAR OR _TIMBRU_JUDICIAR IS NULL) AND

        (ONORARIU_EXPERT = _ONORARIU_EXPERT OR _ONORARIU_EXPERT IS NULL) AND

        (ONORARIU_AVOCAT = _ONORARIU_AVOCAT OR _ONORARIU_AVOCAT IS NULL) AND

        (ID_INSTANTA = _ID_INSTANTA OR _ID_INSTANTA IS NULL) AND

        (ID_COMPLET = _ID_COMPLET OR _ID_COMPLET IS NULL) AND

        (ID_CONTRACT = _ID_CONTRACT OR _ID_CONTRACT IS NULL) AND

        (STADIU = _STADIU OR _STADIU  IS NULL) AND

        (CHELTUIELI_MICA_PUBLICITATE = _CHELTUIELI_MICA_PUBLICITATE OR _CHELTUIELI_MICA_PUBLICITATE IS NULL) AND

        (ONORARIU_CURATOR = _ONORARIU_CURATOR OR _ONORARIU_CURATOR IS NULL) AND

        (ALTE_CHELTUIELI_JUDECATA = _ALTE_CHELTUIELI_JUDECATA OR _ALTE_CHELTUIELI_JUDECATA IS NULL) AND

        (TAXA_TIMBRU_REEXAMINARE = _TAXA_TIMBRU_REEXAMINARE OR _TAXA_TIMBRU_REEXAMINARE IS NULL)) THEN

                BEGIN

                INSERT INTO PROCESE

                        SET NR_INTERN = _NR_INTERN,

                        NR_DOSAR_INSTANTA = _NR_DOSAR,

                        DATA_DEPUNERE = _DATA_DEPUNERE,

                        OBSERVATII = _OBSERVATII,

                        ID_INSTANTA = _ID_INSTANTA,

                        ID_COMPLET = _ID_COMPLET,

                        ID_CONTRACT = _ID_CONTRACT,

                        SUMA_SOLICITATA = _SUMA_SOLICITATA,

                        PENALITATI = _PENALITATI,

                        TAXA_TIMBRU = _TAXA_TIMBRU,

                        TIMBRU_JUDICIAR = _TIMBRU_JUDICIAR,

                        ONORARIU_EXPERT = _ONORARIU_EXPERT,

                        ONORARIU_AVOCAT = _ONORARIU_AVOCAT,

                        CHELTUIELI_MICA_PUBLICITATE = _CHELTUIELI_MICA_PUBLICITATE,

                        ONORARIU_CURATOR = _ONORARIU_CURATOR,

                        ALTE_CHELTUIELI_JUDECATA = _ALTE_CHELTUIELI_JUDECATA,

                        TAXA_TIMBRU_REEXAMINARE = _TAXA_TIMBRU_REEXAMINARE,

                        STADIU = _STADIU,





                        NR_DOSAR_EXECUTARE = _NR_DOSAR_EXECUTARE,

                        DATA_EXECUTARE = _DATA_EXECUTARE,

                        ONORARIU_AVOCAT_EXECUTARE = _ONORARIU_AVOCAT_EXECUTARE,

                        CHELTUIELI_EXECUTARE = _CHELTUIELI_EXECUTARE,

                        DESPAGUBIRE_ACORDATA = _DESPAGUBIRE_ACORDATA,

                        CHELTUIELI_JUDECATA_ACORDATE = _CHELTUIELI_JUDECATA_ACORDATE,



                        MONITORIZARE = _MONITORIZARE;





                SET _ID_PROCES = LAST_INSERT_ID();

                SET _ID = _ID_PROCES;



                

                END;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _NR_INTERN INT,

        _NR_DOSAR_INSTANTA VARCHAR(100),

        _DATA_DEPUNERE DATETIME,

        _OBSERVATII TEXT,

        _ID_INSTANTA INT,

        _ID_COMPLET INT,

        _ID_CONTRACT INT,

        _SUMA_SOLICITATA DOUBLE,

        _PENALITATI DOUBLE,

        _TAXA_TIMBRU DOUBLE,

        _TIMBRU_JUDICIAR DOUBLE,

        _ONORARIU_EXPERT DOUBLE,

        _ONORARIU_AVOCAT DOUBLE,

        _CHELTUIELI_MICA_PUBLICITATE DOUBLE,

        _ONORARIU_CURATOR DOUBLE,

        _ALTE_CHELTUIELI_JUDECATA DOUBLE,

        _TAXA_TIMBRU_REEXAMINARE DOUBLE,

        _STADIU VARCHAR(250),

        _NR_DOSAR_EXECUTARE VARCHAR(100),

        _DATA_EXECUTARE DATETIME,

        _ONORARIU_AVOCAT_EXECUTARE DOUBLE,

        _CHELTUIELI_EXECUTARE DOUBLE,

        _DESPAGUBIRE_ACORDATA DOUBLE,

        _CHELTUIELI_JUDECATA_ACORDATE DOUBLE,

        _MONITORIZARE BOOL,

        _ID_TIP_PROCES INT,

        OUT _ID INT

    )
BEGIN

                INSERT INTO PROCESE

                        SET

                        NR_INTERN = _NR_INTERN,

                        NR_DOSAR_INSTANTA = _NR_DOSAR_INSTANTA,

                        DATA_DEPUNERE = _DATA_DEPUNERE,

                        OBSERVATII = _OBSERVATII,

                        ID_INSTANTA = _ID_INSTANTA,

                        ID_COMPLET = _ID_COMPLET,

                        ID_CONTRACT = _ID_CONTRACT,

                        SUMA_SOLICITATA = _SUMA_SOLICITATA,

                        PENALITATI = _PENALITATI,

                        TAXA_TIMBRU = _TAXA_TIMBRU,

                        TIMBRU_JUDICIAR = _TIMBRU_JUDICIAR,

                        ONORARIU_EXPERT = _ONORARIU_EXPERT,

                        ONORARIU_AVOCAT = _ONORARIU_AVOCAT,

                        CHELTUIELI_MICA_PUBLICITATE = _CHELTUIELI_MICA_PUBLICITATE,

                        ONORARIU_CURATOR = _ONORARIU_CURATOR,

                        ALTE_CHELTUIELI_JUDECATA = _ALTE_CHELTUIELI_JUDECATA,

                        TAXA_TIMBRU_REEXAMINARE = _TAXA_TIMBRU_REEXAMINARE,

                        STADIU = _STADIU,

                        NR_DOSAR_EXECUTARE = _NR_DOSAR_EXECUTARE,

                        DATA_EXECUTARE = _DATA_EXECUTARE,

                        ONORARIU_AVOCAT_EXECUTARE = _ONORARIU_AVOCAT_EXECUTARE,

                        CHELTUIELI_EXECUTARE = _CHELTUIELI_EXECUTARE,

                        DESPAGUBIRE_ACORDATA = _DESPAGUBIRE_ACORDATA,

                        CHELTUIELI_JUDECATA_ACORDATE = _CHELTUIELI_JUDECATA_ACORDATE,

                        MONITORIZARE = _MONITORIZARE,

                        ID_TIP_PROCES = _ID_TIP_PROCES;



                SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_IsAssigned` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_IsAssigned`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_PROCES INT

    )
BEGIN

        SELECT COUNT(*) FROM DOSARE_PROCESE WHERE ID_DOSAR = _ID_DOSAR AND ID_PROCES = _ID_PROCES;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(8000)

    )
BEGIN



        DECLARE _QUERY VARCHAR(8000);



                SET @_QUERY = CONCAT('SELECT D.* FROM PROCESE D ',

                        'LEFT JOIN TIP_PROCESE TD ON D.ID_TIP_DOSAR = TD.ID ',

                        'LEFT JOIN INSTANTE I ON D.ID_INSTANTA = I.ID ',

                        'LEFT JOIN COMPLETE C ON D.ID_COMPLET = C.ID ',

                        'LEFT JOIN CONTRACTE CTR ON D.ID_CONTRACT = CTR.ID ',

                        'LEFT JOIN DOSARE_PROCESE RD3 ON D.ID = RD3.ID_PROCES ',

                        'LEFT JOIN DOSARE R ON RD3.ID_DOSAR = R.ID ',

                        'LEFT JOIN INTERVENIENTI IT ON R.ID_INTERVENIENT = IT.ID ',

                        'LEFT JOIN

                                (SELECT RS3.ID_DOSAR, RS3.TERMEN, RS3.ORA FROM DOSARE_STADII RS3 INNER JOIN (SELECT ID_DOSAR, MAX(TERMEN) TERMEN FROM DOSARE_STADII WHERE ID_STADIU IN (SELECT ID FROM STADII WHERE LOWER(DENUMIRE) IN (''chemare in judecata'', ''fond'', ''pe rol'', ''judecat'', ''apel'', ''recurs'', ''sentinta finala'')) GROUP BY ID_DOSAR) RS4 ON RS3.ID_DOSAR=RS4.ID_DOSAR AND RS3.TERMEN=RS4.TERMEN) RS2 ON R.ID = RS2.ID_DOSAR ',

                        'LEFT JOIN

                                (SELECT RS3.ID_DOSAR, RS3.TERMEN, RS3.ID FROM DOSARE_STADII RS3 INNER JOIN (SELECT ID_DOSAR, MAX(DATA) DATA FROM DOSARE_STADII WHERE ID_STADIU IN (SELECT ID FROM STADII WHERE LOWER(DENUMIRE) IN (''judecat'', ''sentinta finala'')) GROUP BY ID_DOSAR) RS4 ON RS3.ID_DOSAR=RS4.ID_DOSAR AND RS3.DATA=RS4.DATA) RS5 ON R.ID = RS5.ID_DOSAR ',

                        'LEFT JOIN DOSARE_STADII_SENTINTE RSS ON RS5.ID = RSS.ID_DOSAR_STADIU ',

                        'LEFT JOIN SENTINTE SEN ON RSS.ID_SENTINTA = SEN.ID '

                        );



                IF _FILTER IS NOT NULL THEN

                        SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', _FILTER);

                ELSE

                        SET @_QUERY = @_QUERY;

                END IF;



                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ');



                CASE WHEN _ID_DOSAR IS NOT NULL THEN

                        BEGIN

                                SET @_QUERY = CONCAT(@_QUERY, ' RD.ID_PROCES DESC ');

                        END;

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;





                CASE WHEN _SORT IS NOT NULL THEN

                        BEGIN

                                CASE WHEN _ID_DOSAR IS NOT NULL THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ',');

                                ELSE

                                        SET @_QUERY = @_QUERY;

                                END CASE;



                                CASE WHEN _SORT = 'TIP_PROCES' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' TD.DENUMIRE ');

                                WHEN _SORT = 'INSTANTE' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' I.DENUMIRE ');

                                WHEN _SORT = 'COMPLETE' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' C.DENUMIRE ');

                                WHEN _SORT = 'CONTRACTE' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' CTR.NR_CONTRACT ' );

                                WHEN _SORT = 'NR_AZT' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' R.NR_AZT ' );

                                WHEN _SORT = 'NR_SCA' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' R.NR_SCA ' );

                                WHEN _SORT = 'DATA_SCA' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' R.DATA_SCA ' );

                                WHEN _SORT = 'INTERVENIENT' THEN

                                        SET @_QUERY = CONCAT(@_QUERY, ' IT.DENUMIRE ' );

                                ELSE

                                        SET @_QUERY = CONCAT(@_QUERY, ' ', _SORT);

                                END CASE;

                        END;

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;



                CASE WHEN _ID_DOSAR IS NULL AND _SORT IS NULL THEN

                        SET @_QUERY = CONCAT(@_QUERY, ' ID ');

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;





                CASE WHEN _ORDER IS NOT NULL THEN

                        SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

                ELSE

                        SET @_QUERY = @_QUERY;

                END CASE;

                SET @_QUERY = CONCAT(@_QUERY, ';');



           





          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE procese SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESEsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _NR_INTERN INT,

        _NR_DOSAR_INSTANTA VARCHAR(100),

        _DATA_DEPUNERE DATETIME,

        _OBSERVATII TEXT,

        _ID_INSTANTA INT,

        _ID_COMPLET INT,

        _ID_CONTRACT INT,

        _SUMA_SOLICITATA DOUBLE,

        _PENALITATI DOUBLE,

        _TAXA_TIMBRU DOUBLE,

        _TIMBRU_JUDICIAR DOUBLE,

        _ONORARIU_EXPERT DOUBLE,

        _ONORARIU_AVOCAT DOUBLE,

        _CHELTUIELI_MICA_PUBLICITATE DOUBLE,

        _ONORARIU_CURATOR DOUBLE,

        _ALTE_CHELTUIELI_JUDECATA DOUBLE,

        _TAXA_TIMBRU_REEXAMINARE DOUBLE,

        _STADIU VARCHAR(250),

        _NR_DOSAR_EXECUTARE VARCHAR(100),

        _DATA_EXECUTARE DATETIME,

        _ONORARIU_AVOCAT_EXECUTARE DOUBLE,

        _CHELTUIELI_EXECUTARE DOUBLE,

        _DESPAGUBIRE_ACORDATA DOUBLE,

        _CHELTUIELI_JUDECATA_ACORDATE DOUBLE,

        _MONITORIZARE BOOL,

        _ID_TIP_PROCES INT

    )
BEGIN

                UPDATE PROCESE

                        SET

                        NR_INTERN = _NR_INTERN,

                        NR_DOSAR_INSTANTA = _NR_DOSAR_INSTANTA,

                        DATA_DEPUNERE = _DATA_DEPUNERE,

                        OBSERVATII = _OBSERVATII,

                        ID_INSTANTA = _ID_INSTANTA,

                        ID_COMPLET = _ID_COMPLET,

                        ID_CONTRACT = _ID_CONTRACT,

                        SUMA_SOLICITATA = _SUMA_SOLICITATA,

                        PENALITATI = _PENALITATI,

                        TAXA_TIMBRU = _TAXA_TIMBRU,

                        TIMBRU_JUDICIAR = _TIMBRU_JUDICIAR,

                        ONORARIU_EXPERT = _ONORARIU_EXPERT,

                        ONORARIU_AVOCAT = _ONORARIU_AVOCAT,

                        CHELTUIELI_MICA_PUBLICITATE = _CHELTUIELI_MICA_PUBLICITATE,

                        ONORARIU_CURATOR = _ONORARIU_CURATOR,

                        ALTE_CHELTUIELI_JUDECATA = _ALTE_CHELTUIELI_JUDECATA,

                        TAXA_TIMBRU_REEXAMINARE = _TAXA_TIMBRU_REEXAMINARE,

                        STADIU = _STADIU,

                        NR_DOSAR_EXECUTARE = _NR_DOSAR_EXECUTARE,

                        DATA_EXECUTARE = _DATA_EXECUTARE,

                        ONORARIU_AVOCAT_EXECUTARE = _ONORARIU_AVOCAT_EXECUTARE,

                        CHELTUIELI_EXECUTARE = _CHELTUIELI_EXECUTARE,

                        DESPAGUBIRE_ACORDATA = _DESPAGUBIRE_ACORDATA,

                        CHELTUIELI_JUDECATA_ACORDATE = _CHELTUIELI_JUDECATA_ACORDATE,

                        MONITORIZARE = _MONITORIZARE,

                        ID_TIP_PROCES = _ID_TIP_PROCES

                        WHERE ID = _ID;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PLATI_TAXA_TIMBRUsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PLATI_TAXA_TIMBRUsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM procese_plati_taxa_timbru;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PLATI_TAXA_TIMBRUsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PLATI_TAXA_TIMBRUsp_GetById`(_ID INT)
BEGIN

        SELECT * FROM PROCESE_PLATI_TAXA_TIMBRU WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PLATI_TAXA_TIMBRUsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PLATI_TAXA_TIMBRUsp_insert`(

        _ID_PROCES INT,

        _ID_PLATA_TAXA_TIMBRU INT,

        OUT _ID INT

)
BEGIN

        INSERT INTO PROCESE_PLATI_TAXA_TIMBRU SET

        ID_PROCES = _ID_PROCES, ID_PLATA_TAXA_TIMBRU= _ID_PLATA_TAXA_TIMBRU;



        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PLATI_TAXA_TIMBRUsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PLATI_TAXA_TIMBRUsp_select`()
BEGIN

        SELECT * FROM PROCESE_PLATI_TAXA_TIMBRU;  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PLATI_TAXA_TIMBRUsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PLATI_TAXA_TIMBRUsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE procese_plati_taxa_timbru SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PORTALsp_ChangeMonitorizare` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PORTALsp_ChangeMonitorizare`(

        _NR_DOSAR VARCHAR(100),

        _MONITORIZARE BOOL

)
BEGIN

        UPDATE PROCESE_PORTAL SET MONITORIZARE=_MONITORIZARE WHERE NR_DOSAR_INSTANTA=_NR_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PORTALsp_CountDepasite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PORTALsp_CountDepasite`()
BEGIN

        SELECT COUNT(DISTINCT DP.NR_DOSAR_INSTANTA) CNT FROM PROCESE_PORTAL DP

        INNER JOIN (SELECT MAX(ID) ID FROM PROCESE_PORTAL WHERE DATA_SEDINTA < CURDATE() GROUP BY NR_DOSAR_INSTANTA ) DP1 ON DP.ID=DP1.ID        

        
        LEFT OUTER JOIN DOSARE_STADII RS ON DP.ID_DOSAR=RS.ID_DOSAR AND DP.DATA_SEDINTA=RS.DATA

        WHERE DP.DATA_SEDINTA < CURDATE() AND

                UPPER(COMPLET) NOT LIKE '%ADMINISTRATIV%' AND

                RS.DATA IS NULL AND

                TRIM(DP.NR_DOSAR_INSTANTA) IN (SELECT DISTINCT NR_DOSAR_INSTANTA FROM PROCESE) AND

                DP.MONITORIZARE=TRUE;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PORTALsp_ESincronizat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PORTALsp_ESincronizat`()
BEGIN

        SELECT COUNT(*) CNT FROM PROCESE_PORTAL WHERE DATA=CURDATE();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PORTALsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PORTALsp_insert`(

        _DATA DATETIME,

        _NR_DOSAR VARCHAR(100),

        _DATA_SEDINTA DATETIME,

        _NR_SCA INT,

        _DATA_SCA DATETIME,

        _INSTANTA VARCHAR(100),

        _ORA VARCHAR(10),

        _COMPLET VARCHAR(100)

        )
BEGIN

        DECLARE _ID_DOSAR INT;

        SET _ID_DOSAR = (SELECT ID_DOSAR FROM DOSARE_PROCESE RD INNER JOIN PROCESE D ON RD.ID_PROCES=D.ID WHERE D.NR_DOSAR_INSTANTA=_NR_DOSAR LIMIT 1);

        IF NOT EXISTS (SELECT ID FROM PROCESE_PORTAL WHERE DATA = _DATA AND NR_DOSAR_INSTANTA = _NR_DOSAR AND ID_DOSAR = _ID_DOSAR AND DATA_SEDINTA=_DATA_SEDINTA) THEN

                BEGIN

                INSERT INTO PROCESE_PORTAL SET DATA=_DATA, NR_DOSAR_INSTANTA=_NR_DOSAR, ID_DOSAR=_ID_DOSAR, DATA_SEDINTA=_DATA_SEDINTA,

                        NR_SCA=_NR_SCA, DATA_SCA=_DATA_SCA, INSTANTA=_INSTANTA, ORA=_ORA, COMPLET=_COMPLET, MONITORIZARE=TRUE;

                END;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PORTALsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PORTALsp_select`(_DATA DATETIME)
BEGIN

        SELECT * FROM PROCESE_PORTAL WHERE DATA=_DATA;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROCESE_PORTALsp_SelectDepasite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROCESE_PORTALsp_SelectDepasite`()
BEGIN

        SELECT DP.* FROM PROCESE_PORTAL DP

        INNER JOIN (SELECT MAX(ID) ID FROM PROCESE_PORTAL WHERE DATA_SEDINTA < CURDATE() GROUP BY NR_DOSAR_INSTANTA ) DP1 ON DP.ID=DP1.ID

        
        LEFT OUTER JOIN DOSARE_STADII RS ON DP.ID_DOSAR=RS.ID_DOSAR AND DP.DATA_SEDINTA=RS.DATA

        WHERE DP.DATA_SEDINTA < CURDATE() AND RS.DATA IS NULL AND TRIM(DP.NR_DOSAR_INSTANTA) IN (SELECT DISTINCT NR_DOSAR_INSTANTA FROM PROCESE);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RAPORT1sp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RAPORT1sp_select`(
        _SORT VARCHAR(250),
        _ORDER VARCHAR(5),
        _FILTER VARCHAR(8000)
    )
BEGIN

        DECLARE _QUERY VARCHAR(8000);
        SET @_QUERY = CONCAT('SELECT * FROM DOSARE R ',
                'LEFT JOIN ASIGURATI A ON R.ID_ASIGURAT = A.ID ',
                'LEFT JOIN SOCIETATI_ASIGURARE S ON R.ID_SOCIETATE = S.ID ',
                'LEFT JOIN INTERVENIENTI I ON R.ID_INTERVENIENT = I.ID ',
                'LEFT JOIN DOSARE_STADII RS ON R.ID = RS.ID_DOSAR ',
                'LEFT JOIN STADII ST ON RS.ID_STADIU = ST.ID ',
                'LEFT JOIN DOSARE_PROCESE RD ON R.ID = RD.ID_DOSAR ',
                'LEFT JOIN PROCESE D ON RD.ID_PROCES = D.ID ',
                'LEFT JOIN DOSARE_PLATI RP ON R.ID = RP.ID_DOSAR ',
                'LEFT JOIN PLATI P ON RP.ID_PLATA = P.ID ',
                'LEFT JOIN COMPLETE C ON D.ID_COMPLET = C.ID ',
                'LEFT JOIN INSTANTE INS ON D.ID_INSTANTA = INS.ID ',
                'LEFT JOIN CONTRACTE CT ON D.ID_CONTRACT = CT.ID ',
                'LEFT JOIN TIP_PROCESE TD ON D.ID_TIP_DOSAR = TD.ID ',
                '');

        CASE WHEN _FILTER IS NOT NULL THEN
                SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', _FILTER);
        ELSE
                SET @_QUERY = @_QUERY;
        END CASE;

        CASE WHEN _SORT IS NOT NULL THEN
                BEGIN
                        CASE WHEN _SORT = 'ASIGURAT' THEN
                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY A.DENUMIRE');
                        WHEN _SORT = 'SOCIETATE_ASIGURARE' THEN
                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY S.DENUMIRE');
                        WHEN _SORT = 'INTERVENIENT' THEN
                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY I.DENUMIRE');
                        WHEN _SORT = 'SOCIETATE' THEN
                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY S.DENUMIRE');
                        ELSE
                                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);
                        END CASE;
                END;
        ELSE
                SET @_QUERY = @_QUERY;
        END CASE;

        CASE WHEN _ORDER IS NOT NULL THEN
                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);
        ELSE
                SET @_QUERY = @_QUERY;
        END CASE;
        SET @_QUERY = CONCAT(@_QUERY, ';');


          PREPARE stmt1 FROM @_QUERY;
          EXECUTE stmt1;
          DEALLOCATE PREPARE stmt1;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RAPORTsp_fara_termen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RAPORTsp_fara_termen`()
BEGIN

        DECLARE _DATA DATETIME;

        SET _DATA = DATE_SUB(DATE_SUB(DATE_SUB(CURDATE(), INTERVAL 3 YEAR), INTERVAL 2 MONTH), INTERVAL 1 DAY);



        SELECT R.NR_INTERN, DATE_FORMAT(R.DATA_SCA, '%d.%m.%Y') AS DATA_SCA, A.DENUMIRE ASIGURAT, R.POLITA_AZT, DATE_FORMAT(R.DATA_POLITA_AZT, '%d.%m.%Y') AS DATA_POLITA_AZT,

                R.AUTO_AZT, S.DENUMIRE SOCIETATE, R.POLITA_AZT, R.AUTO_RCA, R.VALOARE_DAUNA, R.VALOARE_REGRES, R.NR_REGRES, DATE_FORMAT(R.DATA_REGRES, '%d.%m.%Y') AS DATA_REGRES,

                I.DENUMIRE INTERVENIENT, R.NR_AZT, R.DOSAR_COMPLET, R.VMD, R.EXTRACONTRACT, R.OBSERVATII,

                D.NR_INTERN NR_SCA_PROCES, DATE_FORMAT(D.DATA_DEPUNERE, '%d.%m.%Y') AS DATA_DEPUNERE, D.OBSERVATII OBSERVATII_PROCES, TD.DENUMIRE TIP_DOSAR,

                D.SUMA_SOLICITATA, D.PENALITATI, D.TAXA_TIMBRU, D.TIMBRU_JUDICIAR, D.ONORARIU_EXPERT, D.ONORARIU_AVOCAT,

                D.CHELTUIELI_MICA_PUBLICITATE, D.ONORARIU_CURATOR, D.ALTE_CHELTUIELI_JUDECATA, D.TAXA_TIMBRU_REEXAMINARE,

                INS.DENUMIRE INSTANTA, C.DENUMIRE COMPLET,

                CT.NR_CONTRACT AS NR_CONTRACT_ASISTENTA_JURIDICA, DATE_FORMAT(CT.DATA_CONTRACT, '%d.%m.%Y') AS DATA_CONTRACT_ASISTENTA_JURIDICA, D.STADIU STADIU_PROCES,

                RS2.ULTIMUL_STADIU

                FROM DOSARE R

                INNER JOIN DOSARE_PROCESE RD ON R.ID = RD.ID_DOSAR

                INNER JOIN PROCESE D ON RD.ID_PROCES = D.ID

                LEFT JOIN (SELECT ID_DOSAR, MAX(DATA) ULTIMUL_STADIU FROM DOSARE_STADII RS WHERE ID_STADIU IN

                        (SELECT ID FROM STADII WHERE LOWER(DENUMIRE) IN ('chemare in judecata', 'fond', 'pe rol', 'judecat', 'apel', 'recurs', 'sentinta finala')) GROUP BY ID_DOSAR) RS2 ON R.ID = RS2.ID_DOSAR

                

                LEFT JOIN ASIGURATI A ON R.ID_ASIGURAT = A.ID

                LEFT JOIN SOCIETATI_ASIGURARE S ON R.ID_SOCIETATE = S.ID

                LEFT JOIN INTERVENIENTI I ON R.ID_INTERVENIENT = I.ID

                LEFT JOIN COMPLETE C ON D.ID_COMPLET = C.ID

                LEFT JOIN INSTANTE INS ON D.ID_INSTANTA = INS.ID

                LEFT JOIN CONTRACTE CT ON D.ID_CONTRACT = CT.ID

                LEFT JOIN TIP_PROCESE TD ON D.ID_TIP_DOSAR = TD.ID



                WHERE RS2.ULTIMUL_STADIU IS NULL AND (D.NR_DOSAR_INSTANTA IS NOT NULL) AND DOSAREfn_GetLastStatus(R.ID) NOT IN ('judecat', 'sentinta finala') 

                ORDER BY D.DATA_DEPUNERE ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RAPORTsp_prescrieri` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RAPORTsp_prescrieri`()
BEGIN

        DECLARE _DATA DATETIME;

        SET _DATA = DATE_SUB(DATE_SUB(DATE_SUB(CURDATE(), INTERVAL 3 YEAR), INTERVAL 2 MONTH), INTERVAL 1 DAY);



        SELECT R.NR_INTERN, DATE_FORMAT(R.DATA_SCA, '%d.%m.%Y') AS DATA_SCA, A.DENUMIRE ASIGURAT, R.POLITA_AZT, DATE_FORMAT(R.DATA_POLITA_AZT, '%d.%m.%Y') AS DATA_POLITA_AZT,

                R.AUTO_AZT, S.DENUMIRE SOCIETATE, R.POLITA_AZT, R.AUTO_RCA, R.VALOARE_DAUNA, R.VALOARE_REGRES, R.NR_REGRES, DATE_FORMAT(R.DATA_REGRES, '%d.%m.%Y') AS DATA_REGRES,

                I.DENUMIRE INTERVENIENT, R.NR_AZT, R.DOSAR_COMPLET, R.VMD, R.EXTRACONTRACT, R.OBSERVATII,

                D.NR_INTERN NR_SCA_PROCES, DATE_FORMAT(D.DATA_DEPUNERE, '%d.%m.%Y') AS DATA_DEPUNERE, D.OBSERVATII OBSERVATII_PROCES, TD.DENUMIRE TIP_DOSAR,

                D.SUMA_SOLICITATA, D.PENALITATI, D.TAXA_TIMBRU, D.TIMBRU_JUDICIAR, D.ONORARIU_EXPERT, D.ONORARIU_AVOCAT,

                D.CHELTUIELI_MICA_PUBLICITATE, D.ONORARIU_CURATOR, D.ALTE_CHELTUIELI_JUDECATA, D.TAXA_TIMBRU_REEXAMINARE,

                INS.DENUMIRE INSTANTA, C.DENUMIRE COMPLET,

                CT.NR_CONTRACT AS NR_CONTRACT_ASISTENTA_JURIDICA, DATE_FORMAT(CT.DATA_CONTRACT, '%d.%m.%Y') AS DATA_CONTRACT_ASISTENTA_JURIDICA, D.STADIU STADIU_PROCES,

                RS2.ULTIMUL_STADIU FROM DOSARE R



                LEFT JOIN DOSARE_PROCESE RD ON R.ID = RD.ID_DOSAR

                INNER JOIN PROCESE D ON RD.ID_PROCES = D.ID

                LEFT JOIN (SELECT ID_DOSAR, MAX(DATA) ULTIMUL_STADIU FROM DOSARE_STADII RS GROUP BY ID_DOSAR) RS2 ON R.ID = RS2.ID_DOSAR



                LEFT JOIN ASIGURATI A ON R.ID_ASIGURAT = A.ID

                LEFT JOIN SOCIETATI_ASIGURARE S ON R.ID_SOCIETATE = S.ID

                LEFT JOIN INTERVENIENTI I ON R.ID_INTERVENIENT = I.ID

                LEFT JOIN COMPLETE C ON D.ID_COMPLET = C.ID

                LEFT JOIN INSTANTE INS ON D.ID_INSTANTA = INS.ID

                LEFT JOIN CONTRACTE CT ON D.ID_CONTRACT = CT.ID

                LEFT JOIN TIP_PROCESE TD ON D.ID_TIP_DOSAR = TD.ID



                WHERE R.DATA_POLITA_AZT <= _DATA

                ORDER BY R.DATA_POLITA_AZT DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RAPORTsp_Prescrieri2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RAPORTsp_Prescrieri2`(

        _DATA_REFERINTA DATETIME,

        _FILTRU_DATA BOOLEAN,

        _FILTRU_TERMEN BOOLEAN,

        _FILTRU_DATA_POLITA_AZT BOOLEAN

    )
BEGIN

        DECLARE _DATA DATETIME;

        DECLARE _FILTRU VARCHAR(2000);



        

        

        SET _DATA = DATE_SUB(DATE_SUB(DATE_SUB(_DATA_REFERINTA, INTERVAL 3 YEAR), INTERVAL 2 MONTH), INTERVAL 1 DAY);



        SET @_QUERY = CONCAT('SELECT R.ID, R.NR_AZT `Nr. AZT`, R.NR_INTERN `Nr. SCA`, DATE_FORMAT(R.DATA_SCA, ''%d.%m.%Y'') AS `Data SCA`, A.DENUMIRE `Asigurat`, R.POLITA_AZT `Polita AZT`, ',

                'DATE_FORMAT(R.DATA_POLITA_AZT, ''%d.%m.%Y'') AS `Data polita azt`, R.AUTO_AZT `Auto AZT`, S.DENUMIRE `Asigurator RCA`, R.POLITA_AZT `Polita AZT`, ',

                'R.AUTO_RCA `Auto RCA`, R.VALOARE_DAUNA `Valoare dauna`, R.VALOARE_REGRES `Valoare regres`, R.NR_REGRES `Nr. regres`, DATE_FORMAT(R.DATA_REGRES, ''%d.%m.%Y'') AS `Data regres`, ',

                'I.DENUMIRE `Intervenient`, R.VMD `V.M.D.`, R.EXTRACONTRACT `Extracontract`, R.OBSERVATII `Observatii`, ',

                'D.NR_DOSAR_INSTANTA `Nr. dosar instanta`, DATE_FORMAT(D.DATA_DEPUNERE, ''%d.%m.%Y'') AS `Data depunere dosar instanta`, D.OBSERVATII `Observatii dosar instanta`, ',

                'TD.DENUMIRE `Tip dosar`, D.SUMA_SOLICITATA `Suma solicitata`, D.PENALITATI `Penalitati`, D.TAXA_TIMBRU `Taxa timbru`, D.TIMBRU_JUDICIAR `Timbru judiciar`, ',

                'D.ONORARIU_EXPERT `Onorariu expert`, D.ONORARIU_AVOCAT `Onorariu avocat`, ',

                'D.CHELTUIELI_MICA_PUBLICITATE `Cheltuieli mica publicitate`, D.ONORARIU_CURATOR `Onorariu curator`, D.ALTE_CHELTUIELI_JUDECATA `Alte cheltuieli judecata`, D.TAXA_TIMBRU_REEXAMINARE `Taxa timbru reexaminare`, ',

                'INS.DENUMIRE `Instanta`, C.DENUMIRE `Complet`, ',

                'CT.NR_CONTRACT AS `Nr. contract asistenta juridica`, DATE_FORMAT(CT.DATA_CONTRACT, ''%d.%m.%Y'') AS `Data contract asistenta juridica`, ',

                'DATE_FORMAT(RS2.DATA, ''%d.%m.%Y'') `Data ultimului stadiu (fara instanta)`, ',

                'DATE_FORMAT(RS3.DATA, ''%d.%m.%Y'') `Data ultimului stadiu (de instanta)` ',

                'FROM DOSARE R ');



        SET @_QUERY = CONCAT(@_QUERY, 'LEFT JOIN DOSARE_PROCESE RD ON R.ID = RD.ID_DOSAR ',

                'LEFT JOIN PROCESE D ON RD.ID_PROCES = D.ID ',

                'LEFT JOIN (SELECT ID_DOSAR, MAX(DATA) DATA FROM DOSARE_STADII RS GROUP BY ID_DOSAR) RS2 ON R.ID = RS2.ID_DOSAR ',

                'LEFT JOIN (SELECT ID_DOSAR, MAX(DATA) DATA FROM DOSARE_STADII RS WHERE ID_STADIU IN (SELECT ID FROM STADII WHERE UPPER(DENUMIRE) IN (''CHEMARE IN JUDECATA'', ''PE ROL'', ''FOND'', ''APEL'', ''RECURS'', ''RENUNTARE LA JUDECATA'', ''JUDECAT'')) GROUP BY ID_DOSAR) RS3 ON R.ID = RS3.ID_DOSAR ',



                'LEFT JOIN ASIGURATI A ON R.ID_ASIGURAT = A.ID ',

                'LEFT JOIN SOCIETATI_ASIGURARE S ON R.ID_SOCIETATE = S.ID ',

                'LEFT JOIN INTERVENIENTI I ON R.ID_INTERVENIENT = I.ID ',

                'LEFT JOIN COMPLETE C ON D.ID_COMPLET = C.ID ',

                'LEFT JOIN INSTANTE INS ON D.ID_INSTANTA = INS.ID ',

                'LEFT JOIN CONTRACTE CT ON D.ID_CONTRACT = CT.ID ',

                'LEFT JOIN TIP_PROCESE TD ON D.ID_TIP_DOSAR = TD.ID ');



                SET _FILTRU = '';



                IF _FILTRU_TERMEN = TRUE THEN

                        SET _FILTRU = CONCAT(' (RS3.DATA <= ''', _DATA, ''' OR RS3.DATA IS NULL) ');

                END IF;



                IF _FILTRU_DATA = TRUE THEN

                        SET _FILTRU = CONCAT(_FILTRU, IF(_FILTRU='','',' AND '), ' (RS2.DATA <= ''', _DATA, ''' OR RS2.DATA IS NULL) ');

                END IF;



                IF _FILTRU_DATA_POLITA_AZT = TRUE THEN

                        SET _FILTRU = CONCAT(_FILTRU, IF(_FILTRU='','',' AND '), ' (R.DATA_POLITA_AZT <= ''', _DATA, ''' OR R.DATA_POLITA_AZT IS NULL) ');

                END IF;



          IF _FILTRU <> '' THEN

                  SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', _FILTRU);

          END IF;



          SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY R.DATA_POLITA_AZT DESC;');



          



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RAPORT_03_25` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RAPORT_03_25`()
BEGIN

drop table if exists `tmp_reg`;

drop table if exists `tmp_us`; 

drop table if exists `tmp_conc`; 

drop table if exists `tmp_cj`; 

drop table if exists `tmp_trm`; 

drop table if exists `tmp_obs`; 

drop table if exists `tmp_tmin`; 

drop table if exists `tmp_sfin`; 

drop table if exists `tmp_plmt`;

drop table if exists `tmp_plm`; 

drop table if exists `tmp_plma`; 

drop table if exists `tmp_plati_inainte`; 

drop table if exists `tmp_plati_dupa`; 

drop table if exists `tmp_plati_total`; 

create table `tmp_reg` (id_regres int, id int) SELECT RS.* FROM DOSARE_STADII RS INNER JOIN (SELECT ID_DOSAR, MAX(ID) ID FROM DOSARE_STADII GROUP BY ID_DOSAR) RS2 ON RS.ID_DOSAR = RS2.ID_DOSAR AND RS.ID = RS2.ID; 

create index idx_id_regres on `tmp_reg` (id_regres); 

create table `tmp_us` (id_regres int, data datetime, pas int, denumire varchar(250)) SELECT ID_DOSAR, DATA, MAX(PAS) PAS, DENUMIRE FROM (SELECT X.*, S.PAS, S.DENUMIRE FROM (SELECT RS.*, RS2.ID_STADIU FROM (SELECT ID_DOSAR, MAX(DATA) DATA FROM DOSARE_STADII GROUP BY ID_DOSAR) RS INNER JOIN DOSARE_STADII RS2 ON RS.ID_DOSAR=RS2.ID_DOSAR AND RS.DATA=RS2.DATA) X INNER JOIN STADII S ON X.ID_STADIU=S.ID) ZZZ GROUP BY ID_DOSAR;

create index idx_id_regres on `tmp_us` (id_regres); 

create table `tmp_conc` (id_regres int, data datetime) SELECT ID_DOSAR, MAX(DATA) DATA FROM DOSARE_STADII RS WHERE ID_STADIU = (SELECT ID FROM STADII WHERE UPPER(DENUMIRE)='CONCILIERE') GROUP BY ID_DOSAR; 

create index idx_id_regres on `tmp_conc` (id_regres); 

create table `tmp_cj` (id_regres int, termen datetime) SELECT ID_DOSAR, MAX(TERMEN) TERMEN FROM DOSARE_STADII RS WHERE TERMEN IS NOT NULL AND ID_STADIU = (SELECT ID FROM STADII WHERE UPPER(DENUMIRE)='CHEMARE IN JUDECATA') GROUP BY ID_DOSAR; 

create index idx_id_regres on `tmp_cj` (id_regres); 

create table `tmp_trm` (id_regres int, termen datetime) SELECT ID_DOSAR, MAX(TERMEN) TERMEN FROM DOSARE_STADII RS WHERE ID_STADIU IN (SELECT ID FROM STADII WHERE STADIU_INSTANTA=TRUE) GROUP BY ID_DOSAR; 

create index idx_id_regres on `tmp_trm` (id_regres); 

create table `tmp_obs` (id_regres int, OBSERVATII_STADII text) SELECT RS.ID_DOSAR, GROUP_CONCAT( CONCAT(IF(ISNULL(DATE_FORMAT(RS.DATA, '%d.%m.%Y')),'',DATE_FORMAT(RS.DATA, '%d.%m.%Y')), ' - ', IF(ISNULL(S.DENUMIRE),'',S.DENUMIRE), ' - ', IF(ISNULL(RS.OBSERVATII),'',RS.OBSERVATII)) SEPARATOR ' ') OBSERVATII_STADII FROM DOSARE_STADII RS INNER JOIN STADII S ON RS.ID_STADIU = S.ID GROUP BY RS.ID_DOSAR; 

create index idx_id_regres on `tmp_obs` (id_regres); 

create table `tmp_tmin` (id_regres int, termen datetime) SELECT ID_DOSAR, MIN(TERMEN) TERMEN FROM DOSARE_STADII RS WHERE TERMEN IS NOT NULL AND ID_STADIU IN (SELECT ID FROM STADII WHERE STADIU_INSTANTA=TRUE) GROUP BY ID_DOSAR; 

create index idx_id_regres on `tmp_tmin` (id_regres); 

create table `tmp_sfin` (id_regres int, termen datetime, id int) SELECT ID_DOSAR, MAX(DATA) DATA, TERMEN, ID FROM DOSARE_STADII RS WHERE ID_STADIU IN (SELECT ID FROM STADII WHERE UPPER(DENUMIRE) IN ('SENTINTA FINALA')) GROUP BY ID_DOSAR; 

create index idx_id_regres on `tmp_sfin` (id_regres); 

create table `tmp_plmt` (ID_PROCES int, NR_OP text, DATA_INCASARE text, SUMA text, TOTAL_SUME double) SELECT DPTT.ID_PROCES, GROUP_CONCAT(PTT.NR_DOCUMENT SEPARATOR ' / ') NR_OP, GROUP_CONCAT(DATE_FORMAT(PTT.DATA_DOCUMENT, '%d.%m.%Y') SEPARATOR ' / ') DATA_INCASARE, GROUP_CONCAT(CONVERT(PTT.SUMA, CHAR) SEPARATOR ' / ') SUMA, SUM(PTT.SUMA) TOTAL_SUME FROM PROCESE_PLATI_TAXA_TIMBRU DPTT INNER JOIN PLATI_TAXA_TIMBRU PTT ON DPTT.ID_PLATA_TAXA_TIMBRU = PTT.ID GROUP BY DPTT.ID_PROCES; 

create index idx_id_dosar on `tmp_plmt` (id_proces); 

create table `tmp_plm` (id_regres int, DOCUMENTE_PLATI text, DATE_PLATI text, SUME_PLATI text) SELECT RP.ID_DOSAR, GROUP_CONCAT(P.NR_DOCUMENT) DOCUMENTE_PLATI, GROUP_CONCAT(DATE_FORMAT(P.DATA_DOCUMENT, '%d.%m.%Y')) DATE_PLATI, GROUP_CONCAT(IF(CONVERT(P.SUMA, CHAR(20)) IS NULL OR CONVERT(P.SUMA, CHAR(20)) = '', '0', CONVERT(P.SUMA, CHAR(20))) SEPARATOR '#') SUME_PLATI FROM DOSARE_PLATI RP INNER JOIN PLATI P ON RP.ID_PLATA = P.ID GROUP BY RP.ID_DOSAR; 

create index idx_id_regres on `tmp_plm` (id_regres); 

create table `tmp_plma` (id_regres int, DOCUMENTE_PLATI text, DATE_PLATI text, SUME_PLATI text) SELECT PLM.* FROM DOSARE R, (SELECT RP.ID_DOSAR, GROUP_CONCAT(P.NR_DOCUMENT) DOCUMENTE_PLATI, GROUP_CONCAT(DATE_FORMAT(P.DATA_DOCUMENT, '%d.%m.%Y')) DATE_PLATI, GROUP_CONCAT(IF(CONVERT(P.SUMA, CHAR(20)) IS NULL OR CONVERT(P.SUMA, CHAR(20)) = '', '0', CONVERT(P.SUMA, CHAR(20))) SEPARATOR '#') SUME_PLATI FROM DOSARE_PLATI RP INNER JOIN PLATI P ON RP.ID_PLATA = P.ID GROUP BY RP.ID_DOSAR) PLM WHERE R.ID = PLM.ID_DOSAR UNION SELECT R.ID ID_DOSAR, NULL, NULL, NULL FROM DOSARE R WHERE R.ID NOT IN (SELECT ID_DOSAR FROM DOSARE_PLATI); 

create index idx_id_regres on `tmp_plma` (id_regres); 

create table `tmp_plati_inainte` (id_regres int, suma double) SELECT PLM.* FROM DOSARE R, (SELECT RP.ID_DOSAR, SUM(IF(D.DATA_DEPUNERE > P.DATA_DOCUMENT OR P.DATA_DOCUMENT IS NULL OR D.DATA_DEPUNERE IS NULL, IF(P.SUMA IS NULL, 0, P.SUMA), 0)) SUMA FROM DOSARE R INNER JOIN DOSARE_PLATI RP ON R.ID=RP.ID_DOSAR LEFT JOIN DOSARE_PROCESE RD ON R.ID=RD.ID_DOSAR LEFT JOIN PROCESE D ON RD.ID_PROCES=D.ID INNER JOIN PLATI P ON RP.ID_PLATA = P.ID GROUP BY RP.ID_DOSAR) PLM WHERE R.ID = PLM.ID_DOSAR UNION SELECT R.ID ID_DOSAR, NULL FROM DOSARE R WHERE R.ID NOT IN (SELECT ID_DOSAR FROM DOSARE_PLATI); 

create index idx_id_regres on `tmp_plati_inainte` (id_regres); 

create table `tmp_plati_dupa` (id_regres int, suma double) SELECT PLM.* FROM DOSARE R, (SELECT RP.ID_DOSAR, SUM(IF(D.DATA_DEPUNERE <= P.DATA_DOCUMENT, IF(P.SUMA IS NULL, 0, P.SUMA), 0)) SUMA FROM DOSARE R INNER JOIN DOSARE_PLATI RP ON R.ID=RP.ID_DOSAR INNER JOIN DOSARE_PROCESE RD ON R.ID=RD.ID_DOSAR INNER JOIN PROCESE D ON RD.ID_PROCES=D.ID INNER JOIN PLATI P ON RP.ID_PLATA = P.ID GROUP BY RP.ID_DOSAR) PLM WHERE R.ID = PLM.ID_DOSAR UNION SELECT R.ID ID_DOSAR, NULL FROM DOSARE R WHERE R.ID NOT IN (SELECT ID_DOSAR FROM DOSARE_PLATI); 

create index idx_id_regres on `tmp_plati_dupa` (id_regres); 

create table `tmp_plati_total` (id_regres int, suma double) SELECT PLM.* FROM DOSARE R, (SELECT RP.ID_DOSAR, SUM(IF(P.SUMA IS NULL, 0, P.SUMA)) SUMA FROM DOSARE R INNER JOIN DOSARE_PLATI RP ON R.ID=RP.ID_DOSAR LEFT JOIN DOSARE_PROCESE RD ON R.ID=RD.ID_DOSAR LEFT JOIN PROCESE D ON RD.ID_PROCES=D.ID INNER JOIN PLATI P ON RP.ID_PLATA = P.ID GROUP BY RP.ID_DOSAR) PLM WHERE R.ID = PLM.ID_DOSAR UNION SELECT R.ID ID_DOSAR, NULL FROM DOSARE R WHERE R.ID NOT IN (SELECT ID_DOSAR FROM DOSARE_PLATI); 

create index idx_id_regres on `tmp_plati_total` (id_regres); 



SELECT 

	R.ID , 

	R.NR_AZT AS `Nr. AZT` , 

	R.NR_INTERN AS `Nr. SCA` , 

	DATE_FORMAT(R.DATA_SCA, '%d.%m.%Y') AS `Data SCA` , 

	IF(R.EXTRACONTRACT=TRUE, 'EXTRACONTRACT', 'NOU') AS `Extracontract` , 

	A.DENUMIRE AS `Asigurat` , 

	R.POLITA_AZT AS `Polita AZT` , 

	DATE_FORMAT(R.DATA_POLITA_AZT, '%d.%m.%Y') AS `Data polita azt` , 

	R.AUTO_AZT AS `Auto AZT` , 

	S.DENUMIRE AS `Asigurator RCA` , 

	R.POLITA_RCA AS `Polita RCA` , 

	R.AUTO_RCA AS `Auto RCA` , 

	R.VALOARE_DAUNA AS `Valoare dauna` , 

	R.VALOARE_REGRES AS `Valoare regres` , 

	R.NR_REGRES AS `Nr. regres` , 

	DATE_FORMAT(R.DATA_REGRES, '%d.%m.%Y') AS `Data regres` , 

	I.DENUMIRE AS `Intervenient` , 

	IF(R.DOSAR_COMPLET=TRUE, 'DA', 'NU') AS `Dosar complet` , 

	R.VMD AS `V.M.D.` , 

	DATE_FORMAT(RSC.DATA, '%d.%m.%Y') AS `Data Conciliere` , 

	D.NR_DOSAR_INSTANTA AS `Nr. dosar instanta` , 

	DATE_FORMAT(D.DATA_DEPUNERE, '%d.%m.%Y') AS `Data depunere dosar instanta`, 

	DATE_FORMAT(DCJ.TERMEN, '%d.%m.%Y') AS `Termen chemare in judecata` , 

	D.OBSERVATII AS `Observatii dosar instanta` , 

	TD.DENUMIRE AS `Tip dosar` , 

	C.DENUMIRE AS `Complet` ,

	INS.DENUMIRE AS `Instanta` , 

	CT.NR_CONTRACT AS `Nr. contract asistenta juridica` , 

	DATE_FORMAT(CT.DATA_CONTRACT, '%d.%m.%Y') AS `Data contract asistenta juridica` , 

	D.SUMA_SOLICITATA AS `Suma solicitata` , 

	D.PENALITATI AS `Penalitati` , 

	D.TAXA_TIMBRU AS `Taxa timbru` , 

	PLMTT.NR_OP AS `Nr. op taxa timbru` , 

	D.TIMBRU_JUDICIAR AS `Timbru judiciar` , 

	D.ONORARIU_EXPERT AS `Onorariu expert` , 

	D.ONORARIU_AVOCAT AS `Onorariu avocat` , 

	D.CHELTUIELI_MICA_PUBLICITATE AS `Cheltuieli mica publicitate` , 

	D.ONORARIU_CURATOR AS `Onorariu curator` , 

	D.ALTE_CHELTUIELI_JUDECATA AS `Alte cheltuieli judecata` , 

	D.TAXA_TIMBRU_REEXAMINARE AS `Taxa timbru reexaminare` , 

	D.NR_DOSAR_EXECUTARE AS `Nr. dosar executare` , 

	DATE_FORMAT(D.DATA_EXECUTARE, '%d.%m.%Y') AS `Data executare` , 

	D.ONORARIU_AVOCAT_EXECUTARE AS `Onorariu avocat executare` , 

	D.CHELTUIELI_EXECUTARE AS `Cheltuieli de executare` , 

	D.DESPAGUBIRE_ACORDATA AS `Despagubire acordata` , 

	D.CHELTUIELI_JUDECATA_ACORDATE AS `Cheltuieli de judecata acordate` , 

	IFNULL(PLATI_INAINTE.SUMA, 0) AS `Achitat inainte de depunere` , 

	IFNULL(PLATI_DUPA.SUMA, 0) AS `Achitat dupa depunere` , 

	IFNULL(PLATI_TOTAL.SUMA, 0) AS `Achitat TOTAL` , 

	IFNULL(D.SUMA_SOLICITATA, 0)-IFNULL(D.PENALITATI, 0) AS `Debit total solicitat` , 

	IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) AS `Cheltuieli de judecata` , 

	IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) AS `Cheltuieli de executare` , 

	IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) AS `Sume acordate de instanta` , 

	IF(LOWER(RSUT.DENUMIRE)='clasat' OR LOWER(RSUT.DENUMIRE)='restituire definitiva', 0, IF(D.ID IS NULL, IF(IFNULL(R.VALOARE_REGRES, R.VALOARE_DAUNA)-IFNULL(PLATI_INAINTE.SUMA, 0) < 0, 0, IFNULL(R.VALOARE_REGRES, R.VALOARE_DAUNA)-IFNULL(PLATI_INAINTE.SUMA, 0)), IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0) < 0, 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0)), IF(IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0) < 0, 0, IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0))))) AS `Total de recuperat` , 

	IF(LOWER(RSUT.DENUMIRE)='clasat' OR LOWER(RSUT.DENUMIRE)='restituire definitiva', 0, IF(D.ID IS NULL, IF(IFNULL(R.VALOARE_REGRES, R.VALOARE_DAUNA)-IFNULL(PLATI_INAINTE.SUMA, 0) < 0, 0, IFNULL(R.VALOARE_REGRES, R.VALOARE_DAUNA)-IFNULL(PLATI_INAINTE.SUMA, 0)), IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) - IFNULL(PLATI_TOTAL.SUMA, 0) < 0, 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) - IFNULL(PLATI_TOTAL.SUMA, 0)), IF(IFNULL(D.SUMA_SOLICITATA, 0) - IFNULL(PLATI_TOTAL.SUMA, 0) < 0, 0, IFNULL(D.SUMA_SOLICITATA, 0) - IFNULL(PLATI_TOTAL.SUMA, 0))))) AS `Despagubiri de recuperat` , 

	IF(LOWER(RSUT.DENUMIRE)='clasat' OR LOWER(RSUT.DENUMIRE)='restituire definitiva', 0, IF(IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0), IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0)) - IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) - IFNULL(PLATI_TOTAL.SUMA, 0), IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) - IFNULL(PLATI_TOTAL.SUMA, 0)) > IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(D.CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0), IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(D.CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0), IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0), IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0)) - IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) - IFNULL(PLATI_TOTAL.SUMA, 0), IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) - IFNULL(PLATI_TOTAL.SUMA, 0)))) AS `Cheltuieli de judecata de recuperat` , 

	IF(LOWER(RSUT.DENUMIRE)='clasat' OR LOWER(RSUT.DENUMIRE)='restituire definitiva', 0, IF(D.ID IS NULL, 0, IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0), IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0)) - (IF(LOWER(RSUT.DENUMIRE)='clasat' OR LOWER(RSUT.DENUMIRE)='restituire definitiva', 0, IF(IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0), IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0)) - IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) - IFNULL(PLATI_TOTAL.SUMA, 0), IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) - IFNULL(PLATI_TOTAL.SUMA, 0)) > IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(D.CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0), IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(D.CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0), IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0), IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) + IFNULL(D.TAXA_TIMBRU, 0) + IFNULL(D.TIMBRU_JUDICIAR, 0) + IFNULL(D.ONORARIU_EXPERT, 0) + IFNULL(D.ONORARIU_AVOCAT, 0) + IFNULL(CHELTUIELI_MICA_PUBLICITATE, 0) + IFNULL(D.ONORARIU_CURATOR, 0) + IFNULL(D.ALTE_CHELTUIELI_JUDECATA, 0) + IFNULL(D.TAXA_TIMBRU_REEXAMINARE, 0) + IFNULL(D.ONORARIU_AVOCAT_EXECUTARE, 0) + IFNULL(D.CHELTUIELI_EXECUTARE, 0) - IFNULL(PLATI_TOTAL.SUMA, 0)) - IF(IFNULL(D.DESPAGUBIRE_ACORDATA, 0) + IFNULL(D.CHELTUIELI_JUDECATA_ACORDATE, 0) > 0, IFNULL(D.DESPAGUBIRE_ACORDATA, 0) - IFNULL(PLATI_TOTAL.SUMA, 0), IFNULL(D.SUMA_SOLICITATA, 0) + IFNULL(D.PENALITATI, 0) - IFNULL(PLATI_TOTAL.SUMA, 0))))))) AS `Penalitati de recuperat` , 

	SEN.NR_SENTINTA AS `Sentinta` , 

	DATE_FORMAT(SEN.DATA_SENTINTA, '%d.%m.%Y') AS `Data sentinta` , 

	DATE_FORMAT(SEN.DATA_COMUNICARE, '%d.%m.%Y') AS `Data comunicare` , 

	SOL.DENUMIRE AS `Solutie` , 

	DATE_FORMAT(RSTM.TERMEN, '%d.%m.%Y') AS `Primul termen` , 

	DATE_FORMAT(RSTT.TERMEN, '%d.%m.%Y') AS `Termen` , 

	RSUT.DENUMIRE AS `Stadiu` , 

	DATE_FORMAT(RSUT.DATA, '%d.%m.%Y') AS `Data stadiu` , 

	OBSS.OBSERVATII_STADII AS `Observatii stadii`, 

	PLM.DOCUMENTE_PLATI, 

	PLM.DATE_PLATI, 

	PLM.SUME_PLATI 

	FROM DOSARE R 

	LEFT JOIN ASIGURATI A ON R.ID_ASIGURAT = A.ID 

	LEFT JOIN SOCIETATI_ASIGURARE S ON R.ID_SOCIETATE = S.ID 

	LEFT JOIN INTERVENIENTI I ON R.ID_INTERVENIENT = I.ID 

	INNER JOIN DOSARE_STADII RS ON R.ID = RS.ID_DOSAR 

	INNER JOIN STADII ST ON RS.ID_STADIU = ST.ID 

	left join `tmp_conc` RSC ON R.ID=RSC.ID_DOSAR 

	left join `tmp_cj` DCJ ON R.ID=DCJ.ID_DOSAR 

	LEFT JOIN DOSARE_PROCESE RD ON R.ID = RD.ID_DOSAR 

	LEFT JOIN PROCESE D ON RD.ID_PROCES = D.ID 

	LEFT JOIN COMPLETE C ON D.ID_COMPLET = C.ID 

	LEFT JOIN INSTANTE INS ON D.ID_INSTANTA = INS.ID 

	LEFT JOIN CONTRACTE CT ON D.ID_CONTRACT = CT.ID 

	LEFT JOIN TIP_PROCESE TD ON D.ID_TIP_DOSAR = TD.ID 

	left join `tmp_trm` RSTT ON R.ID=RSTT.ID_DOSAR 

	INNER JOIN `tmp_us` rsut on r.id = rsut.id_regres 

	inner join `tmp_obs` obss on obss.id_regres = r.id 

	left join `tmp_tmin` RSTM ON R.ID=RSTM.ID_DOSAR 

	left join `tmp_sfin` RS5 ON R.ID=RS5.ID_DOSAR 

	LEFT JOIN DOSARE_STADII_SENTINTE RSS ON RS5.ID = RSS.ID_DOSAR_STADIU 

	LEFT JOIN SENTINTE SEN ON RSS.ID_SENTINTA = SEN.ID 

	LEFT JOIN SOLUTII SOL ON SEN.ID_SOLUTIE = SOL.ID 

	left join `tmp_plmt` plmtt on d.id = plmtt.id_proces 

	left join `tmp_plati_inainte` PLATI_INAINTE ON R.ID=PLATI_INAINTE.ID_DOSAR 

	left join `tmp_plati_dupa` PLATI_DUPA ON R.ID=PLATI_DUPA.ID_DOSAR 

	left join `tmp_plati_total` PLATI_TOTAL ON R.ID=PLATI_TOTAL.ID_DOSAR 

	inner join `tmp_plma` plm on r.id=plm.id_regres 

	WHERE RS.ID_STADIU = 1; 

	

	drop table if exists `tmp_reg`; 

	drop table if exists `tmp_us`; 

	drop table if exists `tmp_conc`; 

	drop table if exists `tmp_cj`; 

	drop table if exists `tmp_trm`; 

	drop table if exists `tmp_obs`; 

	drop table if exists `tmp_tmin`; 

	drop table if exists `tmp_sfin`; 

	drop table if exists `tmp_plmt`; 

	drop table if exists `tmp_plm`; 

	drop table if exists `tmp_plma`; 

	drop table if exists `tmp_plati_inainte`; 

	drop table if exists `tmp_plati_dupa`;   

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `script_stergere_dubluri` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `script_stergere_dubluri`()
BEGIN

delete from plati where id in (
select max(id) from (
select p.id,p.nr_document,p.data_document,p.suma from plati p inner join (
select nr_document, data_document, suma, count(*) from plati group by nr_document, data_document, suma having count(*)>1) p2
on p.nr_document=p2.nr_document and p.data_document=p2.data_document and p.suma=p2.suma

) plm group by nr_document,data_document,suma
);



delete from CONTRACTE where id in (
select max(id) from (
select C.id,C.nr_contract,c.data_contract from contracte c inner join (
select nr_contract, data_contract, count(*) from contracte group by nr_contract, data_contract having count(*)>1) c2
on c.nr_contract=c2.nr_contract and c.data_contract=c2.data_contract

) plm group by nr_contract,data_contract
);

insert into tmp select max(id) id from (
select C.id,C.nr_contract,c.data_contract from contracte c inner join (
select nr_contract, data_contract, count(*) from contracte group by nr_contract, data_contract having count(*)>1) c2
on c.nr_contract=c2.nr_contract and c.data_contract=c2.data_contract

) plm group by nr_contract,data_contract;




UPDATE DOSARE_STADII RS
INNER JOIN (
  select DETALII_AFTER,
  SUBSTRING(DETALII_AFTER, LOCATE('_ID_DOSAR = ', DETALII_AFTER)+13,   LOCATE(', _ID_STADIU', DETALII_AFTER) - (LOCATE('_ID_DOSAR = ', DETALII_AFTER)+13)    ) ID_DOSAR,
  IF(CHAR_LENGTH(REPLACE(SUBSTRING(DETALII_AFTER, LOCATE('_DATA = ', DETALII_AFTER)+8 ),',',''))>10, NULL,  REPLACE(SUBSTRING(DETALII_AFTER, LOCATE('_DATA = ', DETALII_AFTER)+8 ),',','')) DATA
  from log where id_utilizator=6 and data>'2010-8-21' and data<'2010-8-22' and tabela='DOSARE_STADII' 
  ) LOG ON RS.ID_DOSAR=LOG.ID_DOSAR
SET RS.DATA = LOG.DATA
WHERE RS.ID_STADIU = 25 AND RS.DATA IS NULL AND LOG.DATA IS NOT NULL;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SENTINTEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SENTINTEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM sentinte;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SENTINTEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SENTINTEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        DELETE FROM SENTINTE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SENTINTEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SENTINTEsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

)
BEGIN

        SELECT * FROM vSENTINTE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SENTINTEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SENTINTEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _nr_sentinta VARCHAR(250),

        _data_sentinta DATETIME,

        _data_comunicare DATETIME,

        _solutie TEXT,

        OUT _ID INT

    )
BEGIN



        INSERT INTO SENTINTE (NR_SENTINTA, DATA_SENTINTA, DATA_COMUNICARE, SOLUTIE)

        VALUES (_nr_sentinta, _data_sentinta, _data_comunicare, _solutie);



        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SENTINTEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SENTINTEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE sentinte SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SENTINTEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SENTINTEsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _nr_sentinta VARCHAR(250),

        _data_sentinta DATETIME,

        _data_comunicare DATETIME,

        _solutie TEXT

    )
BEGIN



        UPDATE SENTINTE SET

                NR_SENTINTA = _nr_sentinta,

                DATA_SENTINTA = _data_sentinta,

                DATA_COMUNICARE = _data_comunicare,

                SOLUTIE = _solutie

                WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SETARIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SETARIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM setari;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SETARIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SETARIsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM SETARI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SETARIsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SETARIsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT * FROM vSETARI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SETARIsp_GetValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SETARIsp_GetValue`(

        _AUTHENTICATED_USER_ID INT,

        NUME_SETARE VARCHAR(250)

    )
BEGIN

        SELECT VALOARE FROM vSETARI WHERE UCASE(NUME) = UCASE(NUME_SETARE);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SETARIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SETARIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _nume VARCHAR(250),

        _valoare VARCHAR(250),

        OUT _ID INT

    )
BEGIN

        INSERT INTO SETARI (NUME, VALOARE)

        VALUES (_nume, _valoare);



        SET _ID = LAST_INSERT_ID();        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SETARIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SETARIsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vSETARI;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SETARIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SETARIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE setari SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SETARIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SETARIsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _nume VARCHAR(250),

        _valoare VARCHAR(250)

    )
BEGIN

        UPDATE SETARI

                SET NUME = _nume, VALOARE = _valoare

                WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SETARIsp_UpdateValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SETARIsp_UpdateValue`(

        _AUTHENTICATED_USER_ID INT,

        _NUME VARCHAR(100),

        _VALOARE VARCHAR(100))
BEGIN

        UPDATE SETARI SET VALOARE=_VALOARE WHERE NUME=_NUME;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURAREso_GetTemplateNotificari` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURAREso_GetTemplateNotificari`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

)
BEGIN

        SELECT FILE_CONTENT FROM TEMPLATES WHERE ID = (SELECT ID_TEMPLATE_NOTIFICARI FROM SOCIETATI_ASIGURARE WHERE ID = _ID);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURAREsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURAREsp_Combo`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ID, DENUMIRE_SCURTA FROM vSOCIETATI_ASIGURARE S WHERE _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE)='ADMINISTRATOR')) OR (

                _AUTHENTICATED_USER_ID NOT IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) = 'ADMINISTRATOR')) AND S.ID IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID)

        ) ORDER BY DENUMIRE ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURAREsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURAREsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM societati_asigurare;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURAREsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURAREsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM SOCIETATI_ASIGURARE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURAREsp_GetByDenumire` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURAREsp_GetByDenumire`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE VARCHAR(250),

        _DENUMIRE_SCURTA BOOL)
BEGIN

        IF _DENUMIRE_SCURTA = TRUE THEN

                SELECT * FROM vSOCIETATI_ASIGURARE WHERE DENUMIRE_SCURTA = _DENUMIRE;

        ELSE

                SELECT * FROM vSOCIETATI_ASIGURARE WHERE DENUMIRE = _DENUMIRE;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURAREsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURAREsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT * FROM vSOCIETATI_ASIGURARE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURAREsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURAREsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE VARCHAR(250),

        _DENUMIRE_SCURTA VARCHAR(100),

        _DETALII TEXT,

        _CUI VARCHAR(45),

        _NR_REG_COM VARCHAR(45),

        _ADRESA TEXT,

        _BANCA VARCHAR(250),

        _IBAN VARCHAR(24),

        _SOLD DOUBLE,

        _DATA_ULTIMEI_PLATI DATETIME,

        _EMAIL_NOTIFICARI VARCHAR(100),

        _ID_TEMPLATE_NOTIFICARI INT,

        _EMAIL VARCHAR(100),

        OUT _ID INT

    )
BEGIN

        IF _DENUMIRE IS NULL THEN

                SET _ID = NULL;

        ELSE

                SET _ID = (SELECT ID FROM SOCIETATI_ASIGURARE WHERE DENUMIRE = _DENUMIRE OR DENUMIRE_SCURTA = _DENUMIRE_SCURTA OR CUI = _CUI LIMIT 1);

                IF _ID IS NULL THEN

                        BEGIN

                	INSERT INTO SOCIETATI_ASIGURARE SET

                                DENUMIRE = _DENUMIRE,

                                DENUMIRE_SCURTA = _DENUMIRE_SCURTA,

                                DETALII = _DETALII,

                                CUI = _CUI,

                                NR_REG_COM = _NR_REG_COM,

                                ADRESA = _ADRESA,

                                BANCA = _BANCA,

                                IBAN = _IBAN,

                                SOLD = _SOLD,

                                DATA_ULTIMEI_PLATI = _DATA_ULTIMEI_PLATI,

                                EMAIL_NOTIFICARI = _EMAIL_NOTIFICARI,

                                ID_TEMPLATE_NOTIFICARI = _ID_TEMPLATE_NOTIFICARI,

                                EMAIL = _EMAIL;

                        SET _ID = LAST_INSERT_ID();

                        END;

                   END IF;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURAREsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURAREsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        /*

        SELECT S.* FROM vSOCIETATI_ASIGURARE S WHERE _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE)='ADMINISTRATOR')) OR (

                _AUTHENTICATED_USER_ID NOT IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) = 'ADMINISTRATOR')) AND S.ID IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID)

        ) ORDER BY S.DENUMIRE;

        */

        SELECT * FROM vSOCIETATI_ASIGURARE S ORDER BY S.DENUMIRE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURAREsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURAREsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE societati_asigurare SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURAREsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURAREsp_update`(

        _AUTHENTICATED_USER_ID INT,

	_ID INT,

        _DENUMIRE VARCHAR(250),

        _DENUMIRE_SCURTA VARCHAR(100),

        _DETALII TEXT,

        _CUI VARCHAR(45),

        _NR_REG_COM VARCHAR(45),

        _ADRESA TEXT,

        _BANCA VARCHAR(250),

        _IBAN VARCHAR(24),

        _SOLD DOUBLE,

        _DATA_ULTIMEI_PLATI DATETIME,

        _EMAIL_NOTIFICARI VARCHAR(100),

        _ID_TEMPLATE_NOTIFICARI INT,

        _EMAIL VARCHAR(100)

    )
BEGIN

	UPDATE SOCIETATI_ASIGURARE SET

        DENUMIRE = _DENUMIRE,

        DENUMIRE_SCURTA = _DENUMIRE_SCURTA,

        DETALII = _DETALII,

        CUI = _CUI,

        NR_REG_COM = _NR_REG_COM,

        ADRESA = _ADRESA,

        BANCA = _BANCA,

        IBAN = _IBAN,

        SOLD = _SOLD,

        DATA_ULTIMEI_PLATI = _DATA_ULTIMEI_PLATI,

        EMAIL_NOTIFICARI = _EMAIL_NOTIFICARI,

        ID_TEMPLATE_NOTIFICARI = _ID_TEMPLATE_NOTIFICARI,

        EMAIL = _EMAIL

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SOCIETATI_ASIGURARE_ADMINISTRATEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SOCIETATI_ASIGURARE_ADMINISTRATEsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vSOCIETATI_ASIGURARE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADIIsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADIIsp_Combo`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ID, DENUMIRE FROM vSTADII ORDER BY PAS;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADIIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADIIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM stadii;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADIIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADIIsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM STADII WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADIIsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADIIsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT * FROM vSTADII WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADIIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADIIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _denumire VARCHAR(250),

        _detalii VARCHAR(2000),

        _icon_path VARCHAR(250),

        _pas INT,

        _stadiu_instanta BOOLEAN,

        _stadiu_cu_termen BOOLEAN,

        OUT _ID INT

    )
BEGIN

        SET _ID = (SELECT ID FROM STADII WHERE TRIM(DENUMIRE) = TRIM(_denumire) LIMIT 1);

        IF _ID IS NULL THEN

                INSERT INTO STADII (DENUMIRE, DETALII, ICON_PATH, PAS, STADIU_INSTANTA, STADIU_CU_TERMEN)

                VALUES (_denumire, _detalii, _icon_path, _pas, _stadiu_instanta, _stadiu_cu_termen);

                SET _ID = LAST_INSERT_ID();

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADIIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADIIsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vSTADII ORDER BY PAS ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADIIsp_select_instanta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADIIsp_select_instanta`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ID, DENUMIRE FROM vSTADII WHERE STADIU_INSTANTA=1 AND STADIU_CU_TERMEN=1 ORDER BY PAS;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADIIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADIIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE stadii SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADIIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADIIsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _denumire VARCHAR(100),

        _detalii VARCHAR(2000),

        _icon_path VARCHAR(250),

        _pas INT,

        _stadiu_instanta BOOLEAN,

        _stadiu_cu_termen BOOLEAN

    )
BEGIN

        UPDATE STADII

        SET DENUMIRE = _denumire,

                DETALII = _detalii,

                ICON_PATH = _icon_path,

                PAS = _pas,

                STADIU_INSTANTA = _stadiu_instanta,

                STADIU_CU_TERMEN = _stadiu_cu_termen

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADII_SCADENTEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADII_SCADENTEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM stadii_scadente;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADII_SCADENTEsp_getByIdStadiu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADII_SCADENTEsp_getByIdStadiu`(

        _AUTHENTICATED_USER_ID INT,

        _ID_STADIU INT

    )
BEGIN

        SELECT ST.DENUMIRE STADIU, ST.DETALII, ST.ICON_PATH, ST.PAS, SE.NUME SETARE, SE.VALOARE, SS.* FROM STADII ST

        INNER JOIN STADII_SCADENTE SS ON ST.ID = SS.ID_STADIU

        INNER JOIN SETARI SE ON SS.ID_SETARE = SE.ID

        WHERE ID_STADIU = _ID_STADIU

        LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADII_SCADENTEsp_selectAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADII_SCADENTEsp_selectAll`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ST.DENUMIRE STADIU, ST.DETALII, ST.ICON_PATH, ST.PAS, SE.NUME SETARE, SE.VALOARE, SS.* FROM STADII ST

        INNER JOIN STADII_SCADENTE SS ON ST.ID = SS.ID_STADIU

        INNER JOIN SETARI SE ON SS.ID_SETARE = SE.ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADII_SCADENTEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADII_SCADENTEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE stadii_scadente SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADII_SETARIsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADII_SETARIsp_Combo`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT MAX(ID) ID, WARNING AS DENUMIRE FROM STADII_SETARI GROUP BY WARNING ORDER BY WARNING ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADII_SETARIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADII_SETARIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM stadii_setari;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADII_SETARIsp_getByIdStadiuDosarComplet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADII_SETARIsp_getByIdStadiuDosarComplet`(

        _AUTHENTICATED_USER_ID INT,

        _ID_STADIU INT,

        _DOSAR_COMPLET BOOLEAN

    )
BEGIN

        DECLARE _CNT INT;

        SET _CNT = (SELECT COUNT(*) FROM STADII_SETARI WHERE ID_STADIU = _ID_STADIU);



        CASE WHEN _CNT > 1 THEN

                BEGIN

                IF _ID_STADIU = 1 THEN

                       CASE WHEN _DOSAR_COMPLET = TRUE THEN

                                SELECT ST.DENUMIRE STADIU, ST.DETALII, ST.ICON_PATH, ST.PAS, SE.NUME SETARE, SE.VALOARE, SS.* FROM STADII ST

                                INNER JOIN STADII_SETARI SS ON ST.ID = SS.ID_STADIU

                                INNER JOIN SETARI SE ON SS.ID_SETARE = SE.ID

                                WHERE ID_STADIU = _ID_STADIU

                                AND UCASE(SE.NUME) = 'TERMEN TRIMITERE CERERE DESPAGUBIRE'

                                LIMIT 1;

                       ELSE

                                SELECT ST.DENUMIRE STADIU, ST.DETALII, ST.ICON_PATH, ST.PAS, SE.NUME SETARE, SE.VALOARE, SS.* FROM STADII ST

                                INNER JOIN STADII_SETARI SS ON ST.ID = SS.ID_STADIU

                                INNER JOIN SETARI SE ON SS.ID_SETARE = SE.ID

                                WHERE ID_STADIU = _ID_STADIU

                                AND UCASE(SE.NUME) = 'TERMEN SESIZARE PROCESE INCOMPLETE'

                                LIMIT 1;

                       END CASE;

                END IF;

                END;

        ELSE

                SELECT ST.DENUMIRE STADIU, ST.DETALII, ST.ICON_PATH, ST.PAS, SE.NUME SETARE, SE.VALOARE, SS.* FROM STADII ST

                INNER JOIN STADII_SETARI SS ON ST.ID = SS.ID_STADIU

                INNER JOIN SETARI SE ON SS.ID_SETARE = SE.ID

                WHERE ID_STADIU = _ID_STADIU

                LIMIT 1;

        END CASE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADII_SETARIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADII_SETARIsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ID, ID_STADIU, ID_SETARE, WARNING FROM STADII_SETARI ORDER BY ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADII_SETARIsp_selectAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADII_SETARIsp_selectAll`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ST.DENUMIRE STADIU, ST.DETALII, ST.ICON_PATH, ST.PAS, SE.NUME SETARE, SE.VALOARE, SS.* FROM STADII ST

        INNER JOIN STADII_SETARI SS ON ST.ID = SS.ID_STADIU

        INNER JOIN SETARI SE ON SS.ID_SETARE = SE.ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STADII_SETARIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STADII_SETARIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE stadii_setari SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TABLEsp_GetReferences` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TABLEsp_GetReferences`(

        _AUTHENTICATED_USER_ID INT,

        _PARENT_TABLE VARCHAR(100),

        _CHILD_TABLE VARCHAR(100)

)
BEGIN

        DECLARE _COUNT INT;



        SET @_COUNT = (SELECT COUNT(*)

        FROM

                `INFORMATION_SCHEMA`.`KEY_COLUMN_USAGE`  
        WHERE

                `TABLE_SCHEMA` = SCHEMA()                
                AND `TABLE_NAME` = _PARENT_TABLE

                AND `REFERENCED_TABLE_NAME` = _CHILD_TABLE);





        IF @_COUNT > 0 THEN

                SELECT

                        `TABLE_SCHEMA`,                          
                        `TABLE_NAME`,                            
                        `COLUMN_NAME`,                           
                        `REFERENCED_TABLE_SCHEMA`,               
                        `REFERENCED_TABLE_NAME`,                 
                        `REFERENCED_COLUMN_NAME`                 
                FROM

                        `INFORMATION_SCHEMA`.`KEY_COLUMN_USAGE`  
                WHERE

                        `TABLE_SCHEMA` = SCHEMA()                
                        AND `TABLE_NAME` = _PARENT_TABLE

                        AND `REFERENCED_TABLE_NAME` = _CHILD_TABLE;

         ELSE

                SELECT

                        `TABLE_SCHEMA`,                          
                        `TABLE_NAME`,                            
                        `COLUMN_NAME`,                           
                        `REFERENCED_TABLE_SCHEMA`,               
                        `REFERENCED_TABLE_NAME`,                 
                        `REFERENCED_COLUMN_NAME`                 
                FROM

                        `INFORMATION_SCHEMA`.`KEY_COLUMN_USAGE`  
                WHERE

                        `TABLE_SCHEMA` = SCHEMA()                
                        AND `REFERENCED_TABLE_NAME` IS NOT NULL 
                        AND `REFERENCED_TABLE_NAME` = _PARENT_TABLE

                        AND `TABLE_NAME` IN (

                                SELECT `TABLE_NAME` FROM `INFORMATION_SCHEMA`.`KEY_COLUMN_USAGE` WHERE

                                       `TABLE_SCHEMA` = SCHEMA()

                                       AND `REFERENCED_TABLE_NAME` = _CHILD_TABLE

                        );

         END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TEMPLATESsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TEMPLATESsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM templates;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TEMPLATESsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TEMPLATESsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

)
BEGIN

        SELECT * FROM TEMPLATES WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TEMPLATESsp_GetByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TEMPLATESsp_GetByName`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE_FISIER VARCHAR(100)

)
BEGIN

        SELECT * FROM TEMPLATES WHERE DENUMIRE_FISIER = _DENUMIRE_FISIER LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TEMPLATESsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TEMPLATESsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE_FISIER VARCHAR(100),

        _EXTENSIE_FISIER VARCHAR(10),

        _DIMENSIUNE_FISIER INT,

        _FILE_CONTENT LONGBLOB,

        _DETALII TEXT,

        OUT _ID INT

)
BEGIN

        INSERT INTO TEMPLATES SET

        DENUMIRE_FISIER = _DENUMIRE_FISIER,

        EXTENSIE_FISIER = _EXTENSIE_FISIER,

        DIMENSIUNE_FISIER = _DIMENSIUNE_FISIER,

        FILE_CONTENT = _FILE_CONTENT,

        DETALII = _DETALII;

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TEMPLATESsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TEMPLATESsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE templates SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TEMPLATESsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TEMPLATESsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _DENUMIRE_FISIER VARCHAR(100),

        _EXTENSIE_FISIER VARCHAR(10),

        _DIMENSIUNE_FISIER INT,

        _FILE_CONTENT LONGBLOB,

        _DETALII TEXT

)
BEGIN

        UPDATE TEMPLATES SET

        DENUMIRE_FISIER = _DENUMIRE_FISIER,

        EXTENSIE_FISIER = _EXTENSIE_FISIER,

        DIMENSIUNE_FISIER = _DIMENSIUNE_FISIER,

        FILE_CONTENT = _FILE_CONTENT,

        DETALII = _DETALII

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_CAZsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_CAZsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM tip_caz;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_CAZsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_CAZsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(4000),

        _LIMIT VARCHAR(100)

)
BEGIN

        DECLARE _QUERY VARCHAR(8000);



        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' TIP_CAZ.DENUMIRE ';

        END IF;



        SET @_QUERY = 'SELECT TIP_CAZ.* FROM vTIP_CAZ TIP_CAZ ';



        IF _FILTER IS NOT NULL THEN

             SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', _FILTER, ' ');

        END IF;



        IF _SORT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

        END IF;



        IF _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        END IF;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_CAZsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_CAZsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE tip_caz SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOCUMENTsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOCUMENTsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM tip_document;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOCUMENTsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOCUMENTsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM TIP_DOCUMENT WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOCUMENTsp_GetByDenumire` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOCUMENTsp_GetByDenumire`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE VARCHAR(250))
BEGIN

        SELECT ID FROM vTIP_DOCUMENT WHERE UPPER(DENUMIRE) = UPPER(_DENUMIRE);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOCUMENTsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOCUMENTsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        SELECT * FROM vTIP_DOCUMENT WHERE ID=_ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOCUMENTsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOCUMENTsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE VARCHAR(250),

        _DETALII TEXT,

        _QINFO VARCHAR(250),

        _MANDATORY BOOL,

        _DISPLAY_ORDER INT,

        OUT _ID INT

    )
BEGIN



        INSERT INTO TIP_DOCUMENT (DENUMIRE, DETALII, QINFO, MANDATORY, DISPLAY_ORDER)

        VALUES (_DENUMIRE, _DETALII, _QINFO, _MANDATORY, _DISPLAY_ORDER);



        SET _ID = LAST_INSERT_ID();        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOCUMENTsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOCUMENTsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vTIP_DOCUMENT ORDER BY DISPLAY_ORDER, ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOCUMENTsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOCUMENTsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE tip_document SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOCUMENTsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOCUMENTsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _DENUMIRE VARCHAR(250),

        _DETALII VARCHAR(2000),

        _MANDATORY BOOL,

        _QINFO VARCHAR(250),

        _DISPLAY_ORDER INT

    )
BEGIN

        UPDATE TIP_DOCUMENT

        SET DENUMIRE = _DENUMIRE,

                DETALII = _DETALII,

                QINFO = _QINFO,

                MANDATORY = _MANDATORY,

                DISPLAY_ORDER = _DISPLAY_ORDER

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOSAREsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOSAREsp_Combo`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ID, DENUMIRE FROM vTIP_DOSARE ORDER BY DENUMIRE ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOSAREsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOSAREsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM tip_dosare;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOSAREsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOSAREsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM TIP_DOSARE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOSAREsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOSAREsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT * FROM vTIP_DOSARE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOSAREsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOSAREsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _denumire VARCHAR(250),

        _detalii VARCHAR(2000),

        OUT _ID INT

    )
BEGIN

        SET _ID = (SELECT ID FROM TIP_DOSARE WHERE DENUMIRE = _DENUMIRE LIMIT 1);

        IF _ID IS NULL THEN

                BEGIN

                INSERT INTO TIP_DOSARE (DENUMIRE, DETALII)

                VALUES (_denumire, _detalii);

                END;

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOSAREsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOSAREsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vTIP_DOSARE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOSAREsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOSAREsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE tip_dosare SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_DOSAREsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_DOSAREsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _denumire VARCHAR(100),

        _detalii VARCHAR(2000)

    )
BEGIN

        UPDATE TIP_DOSARE

        SET DENUMIRE = _denumire,

                DETALII = _detalii

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_MESAJEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_MESAJEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM tip_mesaje;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_MESAJEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_MESAJEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        DELETE FROM TIP_MESAJE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_MESAJEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_MESAJEsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        SELECT * FROM vTIP_MESAJE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_MESAJEsp_GetIdByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_MESAJEsp_GetIdByName`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE VARCHAR(250))
BEGIN

        SELECT ID FROM vTIP_MESAJE WHERE UPPER(DENUMIRE) = UPPER(_DENUMIRE);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_MESAJEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_MESAJEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE VARCHAR(250),

        _DETALII TEXT,

        OUT _ID INT

)
BEGIN

        INSERT INTO TIP_MESAJE SET DENUMIRE = _DENUMIRE, DETALII = _DETALII;

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_MESAJEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_MESAJEsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vTIP_MESAJE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_MESAJEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_MESAJEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE tip_mesaje SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_MESAJEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_MESAJEsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _DENUMIRE VARCHAR(250),

        _DETALII TEXT

)
BEGIN

        UPDATE TIP_MESAJE SET DENUMIRE = _DENUMIRE, DETALII = _DETALII WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_PROCESEsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_PROCESEsp_Combo`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ID, DENUMIRE FROM vTIP_PROCESE ORDER BY DENUMIRE ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_PROCESEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_PROCESEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM tip_procese;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_PROCESEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_PROCESEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM TIP_PROCESE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_PROCESEsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_PROCESEsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT * FROM vTIP_PROCESE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_PROCESEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_PROCESEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _denumire VARCHAR(250),

        _detalii VARCHAR(2000),

        OUT _ID INT

    )
BEGIN

        SET _ID = (SELECT ID FROM TIP_PROCESE WHERE DENUMIRE = _denumire LIMIT 1);

        IF _ID IS NULL THEN

                INSERT INTO TIP_PROCESE (DENUMIRE, DETALII)

                VALUES (_denumire, _detalii);

                SET _ID = LAST_INSERT_ID();

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_PROCESEsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_PROCESEsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vTIP_PROCESE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_PROCESEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_PROCESEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE tip_procese SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_PROCESEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_PROCESEsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _denumire VARCHAR(100),

        _detalii VARCHAR(2000)

    )
BEGIN

        UPDATE TIP_PROCESE

        SET DENUMIRE = _denumire,

                DETALII = _detalii

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_UTILIZATORIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_UTILIZATORIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM tip_utilizatori;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_UTILIZATORIsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_UTILIZATORIsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        SELECT * FROM vTIP_UTILIZATORI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_UTILIZATORIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_UTILIZATORIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _DENUMIRE VARCHAR(250),

        _DETALII TEXT,

        OUT _ID INT

)
BEGIN

        SET _ID = (SELECT ID FROM TIP_UTILIZATORI WHERE DENUMIRE = _DENUMIRE LIMIT 1);

        IF _ID IS NULL THEN

                INSERT INTO TIP_UTILIZATORI SET

                        DENUMIRE = _DENUMIRE,

                        DETALII = _DETALII;

                SET _ID = LAST_INSERT_ID();

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_UTILIZATORIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_UTILIZATORIsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT TU.* FROM vTIP_UTILIZATORI TU WHERE _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE)='ADMINISTRATOR')) OR (

                _AUTHENTICATED_USER_ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE '%SUPER%')) AND UPPER(TU.DENUMIRE) LIKE '%REGULAR%'

        );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_UTILIZATORIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_UTILIZATORIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE tip_utilizatori SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TIP_UTILIZATORIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TIP_UTILIZATORIsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _DENUMIRE VARCHAR(250),

        _DETALII TEXT

)
BEGIN

        UPDATE TIP_UTILIZATORI SET

               DENUMIRE = _DENUMIRE,

               DETALII = _DETALII

               WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_Combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_Combo`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT ID, USER_NAME FROM vUTILIZATORI ORDER BY USER_NAME ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM utilizatori;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_CountUnreadMessages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_CountUnreadMessages`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT)
BEGIN

        SELECT TM.DENUMIRE, M.ID_TIP_MESAJ, COUNT(*) MESAJE_NOI FROM vMESAJE_UTILIZATORI MU

        INNER JOIN vMESAJE M ON MU.ID_MESAJ = M.ID

        INNER JOIN vUTILIZATORI U ON MU.ID_UTILIZATOR = U.ID

        INNER JOIN vTIP_MESAJE TM ON M.ID_TIP_MESAJ = TM.ID

        WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND (M.DATA >= U.LAST_REFRESH OR U.LAST_REFRESH IS NULL)

        GROUP BY M.ID_TIP_MESAJ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM UTILIZATORI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetActions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetActions`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT

    )
BEGIN

        SELECT A.* FROM vUTILIZATORI U

        INNER JOIN vUTILIZATORI_ACTIONS UD ON U.ID = UD.ID_UTILIZATOR

        INNER JOIN vACTIONS A ON UD.ID_ACTION = A.ID

        WHERE U.ID = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetByEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetByEmail`(

        _EMAIL VARCHAR(250)

)
BEGIN

        SELECT * FROM vUTILIZATORI WHERE EMAIL = _EMAIL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        SELECT * FROM vUTILIZATORI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetByIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetByIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_SENDER INT)
BEGIN

        SELECT * FROM vUTILIZATORI WHERE ID_SOCIETATE IN (SELECT ID_SOCIETATE_CASCO FROM vDOSARE WHERE ID = _ID_DOSAR) AND ID_UTILIZATOR != _ID_SENDER

        UNION

        SELECT * FROM vUTILIZATORI WHERE ID_SOCIETATE IN (SELECT ID_SOCIETATE_RCA FROM vDOSARE WHERE ID = _ID_DOSAR);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetByUserName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetByUserName`(

        _USER_NAME VARCHAR(250)

)
BEGIN

        SELECT * FROM vUTILIZATORI WHERE USER_NAME = _USER_NAME;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetLastRefresh` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetLastRefresh`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT)
BEGIN

        SELECT LAST_REFRESH FROM vUTILIZATORI WHERE ID = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetMessages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetMessages`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT M.* FROM vMESAJE M

                INNER JOIN vMESAJE_UTILIZATORI MU ON M.ID = MU.ID_MESAJ

                WHERE MU.ID_UTILIZATOR = _AUTHENTICATED_USER_ID;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetNewMessages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetNewMessages`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        DECLARE _LAST_LOGIN DATETIME;



        SET _LAST_LOGIN = (SELECT LAST_LOGIN FROM vUTILIZATORI WHERE ID = _AUTHENTICATED_USER_ID);



        SELECT M.* FROM vMESAJE M

                INNER JOIN vMESAJE_UTILIZATORI MU ON M.ID = MU.ID_MESAJ

                WHERE MU.ID_UTILIZATOR = _AUTHENTICATED_USER_ID AND

                        M.DATA >= _LAST_LOGIN;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetRights` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetRights`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT

    )
BEGIN

        SELECT D.* FROM vUTILIZATORI U

        INNER JOIN vUTILIZATORI_DREPTURI UD ON U.ID = UD.ID_UTILIZATOR

        INNER JOIN vDREPTURI D ON UD.ID_DREPT = D.ID

        WHERE U.ID = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetRightsById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetRightsById`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _DREPT VARCHAR(100)

    )
BEGIN

        SELECT D.ID FROM vUTILIZATORI U

        INNER JOIN vUTILIZATORI_DREPTURI UD ON U.ID = UD.ID_UTILIZATOR

        INNER JOIN vDREPTURI D ON UD.ID_DREPT = D.ID

        WHERE U.ID = _ID AND D.DENUMIRE = _DREPT

        LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetSentMessages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetSentMessages`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vMESAJE

                WHERE ID_SENDER = _AUTHENTICATED_USER_ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_GetSubordonati` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_GetSubordonati`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT

)
BEGIN

        SELECT U.* FROM vUTILIZATORI U

        WHERE (

                _ID_UTILIZATOR IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator')) OR

                (

                        _ID_UTILIZATOR IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Super')) AND

                                (

                                        U.ID IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR IN (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Regular')) AND

                                        U.ID_SOCIETATE IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID = _ID_UTILIZATOR)

                                )

                )

        ); -- AND U.ID <> _ID_UTILIZATOR; -- AND U.ID_TIP_UTILIZATOR NOT IN (SELECT ID FROM vTIP_UTILIZATORI WHERE DENUMIRE = 'Administrator');



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _USER_NAME VARCHAR(50),

        _PASSWORD VARCHAR(250),

        _NUME_COMPLET VARCHAR(250),

        _DETALII TEXT,

        _IS_ONLINE BOOL,

        _EMAIL VARCHAR(250),

        _IP VARCHAR(12),

        _MAC VARCHAR(100),

        _ID_TIP_UTILIZATOR INT,

        _DEPARTAMENT VARCHAR(100),

        _LAST_REFRESH DATETIME,

        _ID_SOCIETATE INT,

        _LAST_LOGIN DATETIME,

        OUT _ID INT

    )
BEGIN

        INSERT INTO UTILIZATORI

        SET USER_NAME = _USER_NAME,

        PASSWORD = _PASSWORD,

        NUME_COMPLET = _NUME_COMPLET,

        DETALII = _DETALII,

        IS_ONLINE = _IS_ONLINE,

        EMAIL = _EMAIL,

        IP = _IP,

        MAC = _MAC,

        ID_TIP_UTILIZATOR = _ID_TIP_UTILIZATOR,

        DEPARTAMENT = _DEPARTAMENT,

        LAST_REFRESH = _LAST_REFRESH,

        ID_SOCIETATE = _ID_SOCIETATE,

        LAST_LOGIN = _LAST_LOGIN;





        SET _ID = LAST_INSERT_ID();        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_IsAssigned` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_IsAssigned`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT,

        _ID_UTILIZATOR INT

    )
BEGIN

        SELECT COUNT(*) FROM vUTILIZATORI_DOSARE WHERE ID_DOSAR = _ID_DOSAR AND ID_UTILIZATOR = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_select`(

        _AUTHENTICATED_USER_ID INT,

        _SORT VARCHAR(100),

        _ORDER VARCHAR(5),

        _FILTER VARCHAR(8000),

        _LIMIT VARCHAR(1000)

    )
BEGIN

        DECLARE _DEFAULT_FILTER VARCHAR(2000);



        DECLARE _QUERY VARCHAR(8000);



        SET @_DEFAULT_FILTER = CONCAT('(', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE)=''ADMINISTRATOR'')) OR ');

        SET @_DEFAULT_FILTER = CONCAT(@_DEFAULT_FILTER, '( ', _AUTHENTICATED_USER_ID, ' IN (SELECT ID FROM vUTILIZATORI WHERE ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE ''%SUPER%''))

                AND (UTILIZATORI.ID_SOCIETATE IN (SELECT ID_SOCIETATE FROM vUTILIZATORI WHERE ID=', _AUTHENTICATED_USER_ID, ') AND UTILIZATORI.ID_TIP_UTILIZATOR = (SELECT ID FROM vTIP_UTILIZATORI WHERE UPPER(DENUMIRE) LIKE ''%REGULAR%'')) ))');







        IF _ORDER IS NULL AND _SORT IS NULL THEN

                 SET _SORT = ' UTILIZATORI.USER_NAME ';

        END IF;



        SET @_QUERY = 'SELECT UTILIZATORI.* ';



            SET @_QUERY = CONCAT(@_QUERY,

                'FROM vUTILIZATORI UTILIZATORI '

                );



        CASE WHEN _FILTER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' WHERE (', @_DEFAULT_FILTER, ') AND (', _FILTER, ') ');

        ELSE

                BEGIN

                 SET @_QUERY = CONCAT(@_QUERY, ' WHERE ', @_DEFAULT_FILTER, ' ');

                END;

        END CASE;



        CASE WHEN _SORT IS NOT NULL THEN

                BEGIN

                        SET @_QUERY = CONCAT(@_QUERY, ' ORDER BY ', _SORT);

                END;

        ELSE

                SET @_QUERY = @_QUERY;

        END CASE;



        CASE WHEN _ORDER IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, ' ', _ORDER);

        ELSE

                SET @_QUERY = @_QUERY; 

        END CASE;



        IF _LIMIT IS NOT NULL THEN

                SET @_QUERY = CONCAT(@_QUERY, _LIMIT, ';');

        END IF;



        



          PREPARE stmt1 FROM @_QUERY;

          EXECUTE stmt1;

          DEALLOCATE PREPARE stmt1;

          





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_SetLastRefresh` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_SetLastRefresh`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _LAST_REFRESH DATETIME)
BEGIN

        UPDATE UTILIZATORI SET LAST_REFRESH = _LAST_REFRESH WHERE ID = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_SetPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_SetPassword`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _PASSWORD VARCHAR(250)

)
BEGIN

        UPDATE UTILIZATORI SET PASSWORD = _PASSWORD WHERE ID = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE utilizatori SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORIsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _USER_NAME VARCHAR(50),

        _PASSWORD VARCHAR(250),

        _NUME_COMPLET VARCHAR(250),

        _DETALII TEXT,

        _IS_ONLINE BOOL,

        _EMAIL VARCHAR(250),

        _IP VARCHAR(12),

        _MAC VARCHAR(100),

        _ID_TIP_UTILIZATOR INT,

        _DEPARTAMENT VARCHAR(100),

        _LAST_REFRESH DATETIME,

        _ID_SOCIETATE INT,

        _LAST_LOGIN DATETIME

    )
BEGIN

        UPDATE UTILIZATORI

        SET USER_NAME = _USER_NAME,

        PASSWORD = _PASSWORD,

        NUME_COMPLET = _NUME_COMPLET,

        DETALII = _DETALII,

        IS_ONLINE = _IS_ONLINE,

        EMAIL = _EMAIL,

        IP = _IP,

        MAC = _MAC,

        ID_TIP_UTILIZATOR = _ID_TIP_UTILIZATOR,

        DEPARTAMENT = _DEPARTAMENT,

        LAST_REFRESH = _LAST_REFRESH,

        ID_SOCIETATE = _ID_SOCIETATE,

        LAST_LOGIN = _LAST_LOGIN

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_ACTIONSsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_ACTIONSsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM utilizatori_actions;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_ACTIONSsp_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_ACTIONSsp_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_ACTION INT)
BEGIN

        DELETE FROM UTILIZATORI_ACTIONS WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_ACTION = _ID_ACTION;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_ACTIONSsp_GetByIdUtilizator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_ACTIONSsp_GetByIdUtilizator`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT)
BEGIN

        SELECT UA.* FROM vUTILIZATORI_ACTIONS UA

        INNER JOIN vACTIONS A ON UA.ID_ACTION=A.ID

        WHERE UA.ID_UTILIZATOR = _ID_UTILIZATOR

        ORDER BY A.`ORDER`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_ACTIONSsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_ACTIONSsp_insert`(

        _AUTHENTICATED_USER_ID INT,

       _ID_UTILIZATOR INT,

       _ID_ACTION INT,

       OUT _ID INT

)
BEGIN

        INSERT INTO UTILIZATORI_ACTIONS SET

                ID_UTILIZATOR = _ID_UTILIZATOR,

                ID_ACTION = _ID_ACTION;



        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_ACTIONSsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_ACTIONSsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE utilizatori_actions SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_ACTIONSsp_soft_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_ACTIONSsp_soft_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_ACTION INT)
BEGIN

        UPDATE UTILIZATORI_ACTIONS SET deleted = true WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_ACTION = _ID_ACTION;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DOSAREsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DOSAREsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM utilizatori_dosare;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DOSAREsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DOSAREsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        DELETE FROM UTILIZATORI_DOSARE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DOSAREsp_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DOSAREsp_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_DOSAR INT)
BEGIN

        DELETE FROM UTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_DOSAR = _ID_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DOSAREsp_GetByIdDosar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DOSAREsp_GetByIdDosar`(

        _AUTHENTICATED_USER_ID INT,

        _ID_DOSAR INT)
BEGIN

        SELECT * FROM vUTILIZATORI_DOSARE WHERE ID_DOSAR = _ID_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DOSAREsp_GetByIdUtilizator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DOSAREsp_GetByIdUtilizator`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT)
BEGIN

        SELECT * FROM vUTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DOSAREsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DOSAREsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_DOSAR INT,

        OUT _ID INT

)
BEGIN

        SET _ID = (SELECT ID FROM UTILIZATORI_DOSARE WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_DOSAR = _ID_DOSAR LIMIT 1);

        IF _ID IS NULL THEN

                INSERT INTO UTILIZATORI_DOSARE SET

                        ID_UTILIZATOR = _ID_UTILIZATOR,

                        ID_DOSAR = _ID_DOSAR;

                SET _ID = LAST_INSERT_ID();

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DOSAREsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DOSAREsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE utilizatori_dosare SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DOSAREsp_soft_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DOSAREsp_soft_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_DOSAR INT)
BEGIN

        UPDATE UTILIZATORI_DOSARE SET deleted=true WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_DOSAR = _ID_DOSAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM utilizatori_drepturi;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT

    )
BEGIN

        DELETE FROM UTILIZATORI_DREPTURI WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_DREPT INT)
BEGIN

        DELETE FROM UTILIZATORI_DREPTURI WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_DREPT =_ID_DREPT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_DeleteByIds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_DeleteByIds`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_DREPT INT

    )
BEGIN

        DELETE FROM UTILIZATORI_DREPTURI

        WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_DREPT = _ID_DREPT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_GetAllByIdUtilizator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_GetAllByIdUtilizator`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT

    )
BEGIN

        SELECT D.ID, D.DENUMIRE, IF(UD.ID_UTILIZATOR IS NULL, FALSE, TRUE) ASIGNAT FROM vDREPTURI D

        LEFT JOIN (SELECT ID_UTILIZATOR, ID_DREPT FROM vUTILIZATORI_DREPTURI WHERE ID_UTILIZATOR = _ID_UTILIZATOR) UD ON D.ID = UD.ID_DREPT

        ORDER BY D.DENUMIRE ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_GetByIdUtilizator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_GetByIdUtilizator`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT)
BEGIN

        SELECT * FROM vUTILIZATORI_DREPTURI WHERE ID_UTILIZATOR = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_DREPT INT,

        OUT _ID INT

    )
BEGIN

        DECLARE _EX INT;

        IF NOT EXISTS (SELECT ID FROM UTILIZATORI_DREPTURI WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_DREPT = _ID_DREPT)  THEN

                INSERT INTO UTILIZATORI_DREPTURI

                SET ID_UTILIZATOR = _ID_UTILIZATOR,

                ID_DREPT = _ID_DREPT;



                SET _ID = LAST_INSERT_ID();

        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vUTILIZATORI_DREPTURI;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE utilizatori_drepturi SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_soft_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_soft_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_DREPT INT)
BEGIN

        UPDATE UTILIZATORI_DREPTURI SET deleted=true WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_DREPT =_ID_DREPT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_DREPTURIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_DREPTURIsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _ID_UTILIZATOR INT,

        _ID_DREPT INT

    )
BEGIN

        UPDATE UTILIZATORI_DREPTURI

        SET ID_UTILIZATOR = _ID_UTILIZATOR,

        ID_DREPT = _ID_DREPT

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SETARIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SETARIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM utilizatori_setari;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SETARIsp_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SETARIsp_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_SETARE INT

)
BEGIN

        DELETE FROM UTILIZATORI_SETARI WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_SETARE = _ID_SETARE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SETARIsp_GetByIdUtilizator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SETARIsp_GetByIdUtilizator`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT

    )
BEGIN

        SELECT * FROM vUTILIZATORI_SETARI WHERE ID_UTILIZATOR = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SETARIsp_GetValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SETARIsp_GetValue`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        NUME_SETARE VARCHAR(250)

    )
BEGIN

        DECLARE _VALOARE VARCHAR(100);

        SET _VALOARE = (

                SELECT US.VALOARE FROM vUTILIZATORI_SETARI US INNER JOIN vSETARI S ON US.ID_SETARE=S.ID WHERE US.ID_UTILIZATOR = _ID_UTILIZATOR AND UCASE(S.NUME) = UCASE(NUME_SETARE) LIMIT 1

            );

        IF _VALOARE IS NULL OR _VALOARE = '' THEN

                SET _VALOARE = (SELECT VALOARE FROM vSETARI WHERE UCASE(NUME) = UCASE(NUME_SETARE));

        END IF;

        SELECT _VALOARE AS VALOARE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SETARIsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SETARIsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_SETARE INT,

        _VALOARE VARCHAR(45),

        OUT _ID INT

    )
BEGIN

        INSERT INTO UTILIZATORI_SETARI

        SET ID_UTILIZATOR = _ID_UTILIZATOR,

        ID_SETARE = _ID_SETARE,

        VALOARE = _VALOARE;



        SET _ID = LAST_INSERT_ID();        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SETARIsp_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SETARIsp_select`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT * FROM vUTILIZATORI_SETARI;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SETARIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SETARIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE utilizatori_setari SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SETARIsp_soft_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SETARIsp_soft_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_SETARE INT

)
BEGIN

        UPDATE UTILIZATORI_SETARI SET deleted=true WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_SETARE = _ID_SETARE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SETARIsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SETARIsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _ID_UTILIZATOR INT,

        _ID_SETARE INT,

        _VALOARE VARCHAR(45)

    )
BEGIN

        UPDATE UTILIZATORI_SETARI

        SET ID_UTILIZATOR = _ID_UTILIZATOR,

        ID_SETARE = _ID_SETARE,

        VALOARE = _VALOARE

        WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SOCIETATIsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SOCIETATIsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM utilizatori_societati;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SOCIETATIsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SOCIETATIsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE utilizatori_societati SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_count`(

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        SELECT COUNT(*) FROM utilizatori_societati_administrate;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_delete`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT)
BEGIN

        DELETE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_SOCIETATE INT

)
BEGIN

        DELETE FROM UTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_SOCIETATE = _ID_SOCIETATE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_GetByIdUtilizator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_GetByIdUtilizator`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT)
BEGIN

        SELECT * FROM vUTILIZATORI_SOCIETATI_ADMINISTRATE WHERE ID_UTILIZATOR = _ID_UTILIZATOR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_insert`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_SOCIETATE INT,

        OUT _ID INT

)
BEGIN

        INSERT INTO UTILIZATORI_SOCIETATI_ADMINISTRATE SET

              ID_UTILIZATOR = _ID_UTILIZATOR,

              ID_SOCIETATE = _ID_SOCIETATE;

        SET _ID = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_soft_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_soft_delete`(

        _ID INT,

        _AUTHENTICATED_USER_ID INT

)
BEGIN

        UPDATE utilizatori_societati_administrate SET deleted=true WHERE ID = _ID;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_soft_deleteByFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_soft_deleteByFields`(

        _AUTHENTICATED_USER_ID INT,

        _ID_UTILIZATOR INT,

        _ID_SOCIETATE INT

)
BEGIN

        UPDATE UTILIZATORI_SOCIETATI_ADMINISTRATE SET deleted=true WHERE ID_UTILIZATOR = _ID_UTILIZATOR AND ID_SOCIETATE = _ID_SOCIETATE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UTILIZATORI_SOCIETATI_ADMINISTRATEsp_update`(

        _AUTHENTICATED_USER_ID INT,

        _ID INT,

        _ID_UTILIZATOR INT,

        _ID_SOCIETATE INT

)
BEGIN

        UPDATE UTILIZATORI_SOCIETATI_ADMINISTRATE SET

              ID_UTILIZATOR = _ID_UTILIZATOR,

              ID_SOCIETATE = _ID_SOCIETATE

              WHERE ID = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vactions`
--

/*!50001 DROP VIEW IF EXISTS `vactions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vactions` AS select `actions`.`ID` AS `ID`,`actions`.`NAME` AS `NAME`,`actions`.`SUMMARY` AS `SUMMARY`,`actions`.`IMG` AS `IMG`,`actions`.`ACTION` AS `ACTION`,`actions`.`OBJECT_NAME` AS `OBJECT_NAME`,`actions`.`TYPE` AS `TYPE`,`actions`.`ORDER` AS `ORDER`,`actions`.`PARENT_ID` AS `PARENT_ID`,`actions`.`DIV_ID` AS `DIV_ID`,`actions`.`deleted` AS `deleted` from `actions` where (isnull(`actions`.`deleted`) or (`actions`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vactions_log`
--

/*!50001 DROP VIEW IF EXISTS `vactions_log`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vactions_log` AS select `actions_log`.`ID` AS `ID`,`actions_log`.`AUTHENTICATED_USER` AS `AUTHENTICATED_USER`,`actions_log`.`AUTHENTICATED_USER_ID` AS `AUTHENTICATED_USER_ID`,`actions_log`.`REDIS_CLIENT_ID` AS `REDIS_CLIENT_ID`,`actions_log`.`MESSAGE_ID` AS `MESSAGE_ID`,`actions_log`.`CORRELATION_ID` AS `CORRELATION_ID`,`actions_log`.`COMMAND_PREDICATE` AS `COMMAND_PREDICATE`,`actions_log`.`COMMAND_OBJECT_REPOSITORY` AS `COMMAND_OBJECT_REPOSITORY`,`actions_log`.`COMMAND_ARGUMENTS` AS `COMMAND_ARGUMENTS`,`actions_log`.`DATA` AS `DATA`,`actions_log`.`STATUS` AS `STATUS`,`actions_log`.`MESSAGE` AS `MESSAGE`,`actions_log`.`RESULT` AS `RESULT`,`actions_log`.`INSERTED_ID` AS `INSERTED_ID`,`actions_log`.`ERRORS` AS `ERRORS`,`actions_log`.`deleted` AS `deleted` from `actions_log` where (isnull(`actions_log`.`deleted`) or (`actions_log`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vasigurati`
--

/*!50001 DROP VIEW IF EXISTS `vasigurati`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vasigurati` AS select `asigurati`.`ID` AS `ID`,`asigurati`.`DENUMIRE` AS `DENUMIRE`,`asigurati`.`DETALII` AS `DETALII`,`asigurati`.`deleted` AS `deleted` from `asigurati` where (isnull(`asigurati`.`deleted`) or (`asigurati`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vauto`
--

/*!50001 DROP VIEW IF EXISTS `vauto`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vauto` AS select `auto`.`ID` AS `ID`,`auto`.`NR_AUTO` AS `NR_AUTO`,`auto`.`SERIE_SASIU` AS `SERIE_SASIU`,`auto`.`MARCA` AS `MARCA`,`auto`.`MODEL` AS `MODEL`,`auto`.`DETALII` AS `DETALII`,`auto`.`deleted` AS `deleted` from `auto` where (isnull(`auto`.`deleted`) or (`auto`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vcompensari`
--

/*!50001 DROP VIEW IF EXISTS `vcompensari`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vcompensari` AS select `compensari`.`ID` AS `ID`,`compensari`.`ID_DOSAR_RCA` AS `ID_DOSAR_RCA`,`compensari`.`ID_DOSAR_CASCO` AS `ID_DOSAR_CASCO`,`compensari`.`SUMA` AS `SUMA`,`compensari`.`DATA` AS `DATA`,`compensari`.`PAS` AS `PAS`,`compensari`.`deleted` AS `deleted` from `compensari` where (isnull(`compensari`.`deleted`) or (`compensari`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vcomplete`
--

/*!50001 DROP VIEW IF EXISTS `vcomplete`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vcomplete` AS select `complete`.`ID` AS `ID`,`complete`.`DENUMIRE` AS `DENUMIRE`,`complete`.`DETALII` AS `DETALII`,`complete`.`deleted` AS `deleted` from `complete` where (isnull(`complete`.`deleted`) or (`complete`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vcontracte`
--

/*!50001 DROP VIEW IF EXISTS `vcontracte`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vcontracte` AS select `contracte`.`ID` AS `ID`,`contracte`.`NR_CONTRACT` AS `NR_CONTRACT`,`contracte`.`DATA_CONTRACT` AS `DATA_CONTRACT`,`contracte`.`OBSERVATII` AS `OBSERVATII`,`contracte`.`deleted` AS `deleted` from `contracte` where (isnull(`contracte`.`deleted`) or (`contracte`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vcontracte_plati_contracte`
--

/*!50001 DROP VIEW IF EXISTS `vcontracte_plati_contracte`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vcontracte_plati_contracte` AS select `contracte_plati_contracte`.`ID` AS `ID`,`contracte_plati_contracte`.`ID_CONTRACT` AS `ID_CONTRACT`,`contracte_plati_contracte`.`ID_PLATA_CONTRACT` AS `ID_PLATA_CONTRACT`,`contracte_plati_contracte`.`deleted` AS `deleted` from `contracte_plati_contracte` where (isnull(`contracte_plati_contracte`.`deleted`) or (`contracte_plati_contracte`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vdocumente_scanate`
--

/*!50001 DROP VIEW IF EXISTS `vdocumente_scanate`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vdocumente_scanate` AS select `documente_scanate`.`ID` AS `ID`,`documente_scanate`.`DENUMIRE_FISIER` AS `DENUMIRE_FISIER`,`documente_scanate`.`EXTENSIE_FISIER` AS `EXTENSIE_FISIER`,`documente_scanate`.`DATA_INCARCARE` AS `DATA_INCARCARE`,`documente_scanate`.`DIMENSIUNE_FISIER` AS `DIMENSIUNE_FISIER`,`documente_scanate`.`ID_TIP_DOCUMENT` AS `ID_TIP_DOCUMENT`,`documente_scanate`.`ID_DOSAR` AS `ID_DOSAR`,`documente_scanate`.`DETALII` AS `DETALII`,`documente_scanate`.`VIZA_CASCO` AS `VIZA_CASCO`,`documente_scanate`.`FILE_CONTENT` AS `FILE_CONTENT`,`documente_scanate`.`SMALL_ICON` AS `SMALL_ICON`,`documente_scanate`.`MEDIUM_ICON` AS `MEDIUM_ICON`,`documente_scanate`.`CALE_FISIER` AS `CALE_FISIER`,`documente_scanate`.`deleted` AS `deleted` from `documente_scanate` where (isnull(`documente_scanate`.`deleted`) or (`documente_scanate`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vdocumente_scanate_simple`
--

/*!50001 DROP VIEW IF EXISTS `vdocumente_scanate_simple`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vdocumente_scanate_simple` AS select `documente_scanate`.`ID` AS `ID`,`documente_scanate`.`DENUMIRE_FISIER` AS `DENUMIRE_FISIER`,`documente_scanate`.`EXTENSIE_FISIER` AS `EXTENSIE_FISIER`,`documente_scanate`.`DATA_INCARCARE` AS `DATA_INCARCARE`,`documente_scanate`.`DIMENSIUNE_FISIER` AS `DIMENSIUNE_FISIER`,`documente_scanate`.`ID_TIP_DOCUMENT` AS `ID_TIP_DOCUMENT`,`documente_scanate`.`ID_DOSAR` AS `ID_DOSAR`,`documente_scanate`.`DETALII` AS `DETALII`,`documente_scanate`.`VIZA_CASCO` AS `VIZA_CASCO`,`documente_scanate`.`CALE_FISIER` AS `CALE_FISIER`,`documente_scanate`.`deleted` AS `deleted` from `documente_scanate` where (isnull(`documente_scanate`.`deleted`) or (`documente_scanate`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vdosare`
--

/*!50001 DROP VIEW IF EXISTS `vdosare`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vdosare` AS select `dosare`.`ID` AS `ID`,`dosare`.`NR_SCA` AS `NR_SCA`,`dosare`.`DATA_SCA` AS `DATA_SCA`,`dosare`.`ID_ASIGURAT_CASCO` AS `ID_ASIGURAT_CASCO`,`dosare`.`NR_POLITA_CASCO` AS `NR_POLITA_CASCO`,`dosare`.`ID_AUTO_CASCO` AS `ID_AUTO_CASCO`,`dosare`.`ID_SOCIETATE_CASCO` AS `ID_SOCIETATE_CASCO`,`dosare`.`NR_POLITA_RCA` AS `NR_POLITA_RCA`,`dosare`.`ID_AUTO_RCA` AS `ID_AUTO_RCA`,`dosare`.`VALOARE_DAUNA` AS `VALOARE_DAUNA`,`dosare`.`VALOARE_REGRES` AS `VALOARE_REGRES`,`dosare`.`ID_INTERVENIENT` AS `ID_INTERVENIENT`,`dosare`.`NR_DOSAR_CASCO` AS `NR_DOSAR_CASCO`,`dosare`.`VMD` AS `VMD`,`dosare`.`OBSERVATII` AS `OBSERVATII`,`dosare`.`ID_SOCIETATE_RCA` AS `ID_SOCIETATE_RCA`,`dosare`.`DATA_EVENIMENT` AS `DATA_EVENIMENT`,`dosare`.`REZERVA_DAUNA` AS `REZERVA_DAUNA`,`dosare`.`DATA_INTRARE_RCA` AS `DATA_INTRARE_RCA`,`dosare`.`DATA_IESIRE_CASCO` AS `DATA_IESIRE_CASCO`,`dosare`.`NR_INTRARE_RCA` AS `NR_INTRARE_RCA`,`dosare`.`NR_IESIRE_CASCO` AS `NR_IESIRE_CASCO`,`dosare`.`ID_ASIGURAT_RCA` AS `ID_ASIGURAT_RCA`,`dosare`.`ID_TIP_DOSAR` AS `ID_TIP_DOSAR`,`dosare`.`SUMA_IBNR` AS `SUMA_IBNR`,`dosare`.`DATA_AVIZARE` AS `DATA_AVIZARE`,`dosare`.`DATA_NOTIFICARE` AS `DATA_NOTIFICARE`,`dosare`.`DATA_ULTIMEI_MODIFICARI` AS `DATA_ULTIMEI_MODIFICARI`,`dosare`.`AVIZAT` AS `AVIZAT`,`dosare`.`CAZ` AS `CAZ`,`dosare`.`LOC_ACCIDENT` AS `LOC_ACCIDENT`,`dosare`.`deleted` AS `deleted`,`dosare`.`DATA_CREARE` AS `DATA_CREARE` from `dosare` where (isnull(`dosare`.`deleted`) or (`dosare`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vdosare_plati`
--

/*!50001 DROP VIEW IF EXISTS `vdosare_plati`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vdosare_plati` AS select `dosare_plati`.`ID` AS `ID`,`dosare_plati`.`ID_DOSAR` AS `ID_DOSAR`,`dosare_plati`.`ID_PLATA` AS `ID_PLATA`,`dosare_plati`.`deleted` AS `deleted` from `dosare_plati` where (isnull(`dosare_plati`.`deleted`) or (`dosare_plati`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vdosare_plati_contracte`
--

/*!50001 DROP VIEW IF EXISTS `vdosare_plati_contracte`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vdosare_plati_contracte` AS select `dosare_plati_contracte`.`ID` AS `ID`,`dosare_plati_contracte`.`ID_DOSAR` AS `ID_DOSAR`,`dosare_plati_contracte`.`ID_PLATA_CONTRACT` AS `ID_PLATA_CONTRACT`,`dosare_plati_contracte`.`deleted` AS `deleted` from `dosare_plati_contracte` where (isnull(`dosare_plati_contracte`.`deleted`) or (`dosare_plati_contracte`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vdosare_portal`
--

/*!50001 DROP VIEW IF EXISTS `vdosare_portal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vdosare_portal` AS select `dosare_portal`.`ID` AS `ID`,`dosare_portal`.`NR_DOSAR` AS `NR_DOSAR`,`dosare_portal`.`DATA` AS `DATA`,`dosare_portal`.`DATA_SEDINTA` AS `DATA_SEDINTA`,`dosare_portal`.`ID_DOSAR` AS `ID_DOSAR`,`dosare_portal`.`NR_SCA` AS `NR_SCA`,`dosare_portal`.`DATA_SCA` AS `DATA_SCA`,`dosare_portal`.`INSTANTA` AS `INSTANTA`,`dosare_portal`.`ORA` AS `ORA`,`dosare_portal`.`COMPLET` AS `COMPLET`,`dosare_portal`.`MONITORIZARE` AS `MONITORIZARE`,`dosare_portal`.`deleted` AS `deleted` from `dosare_portal` where (isnull(`dosare_portal`.`deleted`) or (`dosare_portal`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vdosare_procese`
--

/*!50001 DROP VIEW IF EXISTS `vdosare_procese`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vdosare_procese` AS select `dosare_procese`.`ID` AS `ID`,`dosare_procese`.`ID_DOSAR` AS `ID_DOSAR`,`dosare_procese`.`ID_PROCES` AS `ID_PROCES`,`dosare_procese`.`deleted` AS `deleted` from `dosare_procese` where (isnull(`dosare_procese`.`deleted`) or (`dosare_procese`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vdosare_stadii`
--

/*!50001 DROP VIEW IF EXISTS `vdosare_stadii`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vdosare_stadii` AS select `dosare_stadii`.`ID` AS `ID`,`dosare_stadii`.`ID_DOSAR` AS `ID_DOSAR`,`dosare_stadii`.`ID_STADIU` AS `ID_STADIU`,`dosare_stadii`.`TERMEN` AS `TERMEN`,`dosare_stadii`.`OBSERVATII` AS `OBSERVATII`,`dosare_stadii`.`DATA` AS `DATA`,`dosare_stadii`.`SCADENTA` AS `SCADENTA`,`dosare_stadii`.`ORA` AS `ORA`,`dosare_stadii`.`TERMEN_ADMINISTRATIV` AS `TERMEN_ADMINISTRATIV`,`dosare_stadii`.`deleted` AS `deleted` from `dosare_stadii` where (isnull(`dosare_stadii`.`deleted`) or (`dosare_stadii`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vdosare_stadii_sentinte`
--

/*!50001 DROP VIEW IF EXISTS `vdosare_stadii_sentinte`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vdosare_stadii_sentinte` AS select `dosare_stadii_sentinte`.`ID` AS `ID`,`dosare_stadii_sentinte`.`ID_DOSAR_STADIU` AS `ID_DOSAR_STADIU`,`dosare_stadii_sentinte`.`ID_SENTINTA` AS `ID_SENTINTA`,`dosare_stadii_sentinte`.`deleted` AS `deleted` from `dosare_stadii_sentinte` where (isnull(`dosare_stadii_sentinte`.`deleted`) or (`dosare_stadii_sentinte`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vdrepturi`
--

/*!50001 DROP VIEW IF EXISTS `vdrepturi`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vdrepturi` AS select `drepturi`.`ID` AS `ID`,`drepturi`.`DENUMIRE` AS `DENUMIRE`,`drepturi`.`DETALII` AS `DETALII`,`drepturi`.`deleted` AS `deleted` from `drepturi` where (isnull(`drepturi`.`deleted`) or (`drepturi`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vemail_notifications`
--

/*!50001 DROP VIEW IF EXISTS `vemail_notifications`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vemail_notifications` AS select `email_notifications`.`ID` AS `ID`,`email_notifications`.`ID_DOSAR` AS `ID_DOSAR`,`email_notifications`.`MESSAGE_ID` AS `MESSAGE_ID`,`email_notifications`.`MESSAGE_TEXT` AS `MESSAGE_TEXT`,`email_notifications`.`SEND` AS `SEND`,`email_notifications`.`SEND_TIMESTAMP` AS `SEND_TIMESTAMP`,`email_notifications`.`DELIVERY` AS `DELIVERY`,`email_notifications`.`DELIVERY_TIMESTAMP` AS `DELIVERY_TIMESTAMP`,`email_notifications`.`REJECT` AS `REJECT`,`email_notifications`.`REJECT_TIMESTAMP` AS `REJECT_TIMESTAMP`,`email_notifications`.`BOUNCE` AS `BOUNCE`,`email_notifications`.`BOUNCE_TIMESTAMP` AS `BOUNCE_TIMESTAMP`,`email_notifications`.`OPEN` AS `OPEN`,`email_notifications`.`OPEN_TIMESTAMP` AS `OPEN_TIMESTAMP`,`email_notifications`.`CLICK` AS `CLICK`,`email_notifications`.`CLICK_TIMESTAMP` AS `CLICK_TIMESTAMP`,`email_notifications`.`COMPLAINT` AS `COMPLAINT`,`email_notifications`.`COMPLAINT_TIMESTAMP` AS `COMPLAINT_TIMESTAMP`,`email_notifications`.`deleted` AS `deleted` from `email_notifications` where (isnull(`email_notifications`.`deleted`) or (`email_notifications`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vimport_log`
--

/*!50001 DROP VIEW IF EXISTS `vimport_log`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vimport_log` AS select `import_log`.`ID` AS `ID`,`import_log`.`DATA_IMPORT` AS `DATA_IMPORT`,`import_log`.`STATUS` AS `STATUS`,`import_log`.`MESSAGE` AS `MESSAGE`,`import_log`.`INSERTED_ID` AS `INSERTED_ID`,`import_log`.`ERRORS` AS `ERRORS`,`import_log`.`deleted` AS `deleted` from `import_log` where (isnull(`import_log`.`deleted`) or (`import_log`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vinstante`
--

/*!50001 DROP VIEW IF EXISTS `vinstante`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vinstante` AS select `instante`.`ID` AS `ID`,`instante`.`DENUMIRE` AS `DENUMIRE`,`instante`.`DETALII` AS `DETALII`,`instante`.`deleted` AS `deleted` from `instante` where (isnull(`instante`.`deleted`) or (`instante`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vintervenienti`
--

/*!50001 DROP VIEW IF EXISTS `vintervenienti`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vintervenienti` AS select `intervenienti`.`ID` AS `ID`,`intervenienti`.`DENUMIRE` AS `DENUMIRE`,`intervenienti`.`DETALII` AS `DETALII`,`intervenienti`.`deleted` AS `deleted` from `intervenienti` where (isnull(`intervenienti`.`deleted`) or (`intervenienti`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vlog`
--

/*!50001 DROP VIEW IF EXISTS `vlog`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vlog` AS select `log`.`ID` AS `ID`,`log`.`DATA` AS `DATA`,`log`.`ACTIUNE` AS `ACTIUNE`,`log`.`TABELA` AS `TABELA`,`log`.`DETALII_BEFORE` AS `DETALII_BEFORE`,`log`.`ID_UTILIZATOR` AS `ID_UTILIZATOR`,`log`.`DETALII_AFTER` AS `DETALII_AFTER`,`log`.`deleted` AS `deleted` from `log` where (isnull(`log`.`deleted`) or (`log`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vmesaje`
--

/*!50001 DROP VIEW IF EXISTS `vmesaje`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vmesaje` AS select `mesaje`.`ID` AS `ID`,`mesaje`.`ID_SENDER` AS `ID_SENDER`,`mesaje`.`SUBIECT` AS `SUBIECT`,`mesaje`.`BODY` AS `BODY`,`mesaje`.`DATA` AS `DATA`,`mesaje`.`ID_DOSAR` AS `ID_DOSAR`,`mesaje`.`IMPORTANTA` AS `IMPORTANTA`,`mesaje`.`ID_TIP_MESAJ` AS `ID_TIP_MESAJ`,`mesaje`.`deleted` AS `deleted`,`mesaje`.`REPLY_TO` AS `REPLY_TO` from `mesaje` where (isnull(`mesaje`.`deleted`) or (`mesaje`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vmesaje_utilizatori`
--

/*!50001 DROP VIEW IF EXISTS `vmesaje_utilizatori`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vmesaje_utilizatori` AS select `mesaje_utilizatori`.`ID` AS `ID`,`mesaje_utilizatori`.`ID_MESAJ` AS `ID_MESAJ`,`mesaje_utilizatori`.`ID_UTILIZATOR` AS `ID_UTILIZATOR`,`mesaje_utilizatori`.`DATA_CITIRE` AS `DATA_CITIRE`,`mesaje_utilizatori`.`deleted` AS `deleted` from `mesaje_utilizatori` where (isnull(`mesaje_utilizatori`.`deleted`) or (`mesaje_utilizatori`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vpending_documente_scanate_imports`
--

/*!50001 DROP VIEW IF EXISTS `vpending_documente_scanate_imports`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vpending_documente_scanate_imports` AS select `pending_documente_scanate_imports`.`ID` AS `ID`,`pending_documente_scanate_imports`.`DENUMIRE_FISIER` AS `DENUMIRE_FISIER`,`pending_documente_scanate_imports`.`EXTENSIE_FISIER` AS `EXTENSIE_FISIER`,`pending_documente_scanate_imports`.`DATA_INCARCARE` AS `DATA_INCARCARE`,`pending_documente_scanate_imports`.`DIMENSIUNE_FISIER` AS `DIMENSIUNE_FISIER`,`pending_documente_scanate_imports`.`ID_TIP_DOCUMENT` AS `ID_TIP_DOCUMENT`,`pending_documente_scanate_imports`.`ID_DOSAR` AS `ID_DOSAR`,`pending_documente_scanate_imports`.`DETALII` AS `DETALII`,`pending_documente_scanate_imports`.`VIZA_CASCO` AS `VIZA_CASCO`,`pending_documente_scanate_imports`.`FILE_CONTENT` AS `FILE_CONTENT`,`pending_documente_scanate_imports`.`SMALL_ICON` AS `SMALL_ICON`,`pending_documente_scanate_imports`.`MEDIUM_ICON` AS `MEDIUM_ICON`,`pending_documente_scanate_imports`.`CALE_FISIER` AS `CALE_FISIER` from `pending_documente_scanate_imports` where (isnull(`pending_documente_scanate_imports`.`deleted`) or (`pending_documente_scanate_imports`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vpending_documente_scanate_imports_simple`
--

/*!50001 DROP VIEW IF EXISTS `vpending_documente_scanate_imports_simple`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vpending_documente_scanate_imports_simple` AS select `pending_documente_scanate_imports`.`ID` AS `ID`,`pending_documente_scanate_imports`.`DENUMIRE_FISIER` AS `DENUMIRE_FISIER`,`pending_documente_scanate_imports`.`EXTENSIE_FISIER` AS `EXTENSIE_FISIER`,`pending_documente_scanate_imports`.`DATA_INCARCARE` AS `DATA_INCARCARE`,`pending_documente_scanate_imports`.`DIMENSIUNE_FISIER` AS `DIMENSIUNE_FISIER`,`pending_documente_scanate_imports`.`ID_TIP_DOCUMENT` AS `ID_TIP_DOCUMENT`,`pending_documente_scanate_imports`.`ID_DOSAR` AS `ID_DOSAR`,`pending_documente_scanate_imports`.`DETALII` AS `DETALII`,`pending_documente_scanate_imports`.`VIZA_CASCO` AS `VIZA_CASCO`,`pending_documente_scanate_imports`.`CALE_FISIER` AS `CALE_FISIER` from `pending_documente_scanate_imports` where (isnull(`pending_documente_scanate_imports`.`deleted`) or (`pending_documente_scanate_imports`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vpending_import_errors`
--

/*!50001 DROP VIEW IF EXISTS `vpending_import_errors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vpending_import_errors` AS select `pending_import_errors`.`ID` AS `ID`,`pending_import_errors`.`NR_SCA` AS `NR_SCA`,`pending_import_errors`.`DATA_SCA` AS `DATA_SCA`,`pending_import_errors`.`ID_ASIGURAT_CASCO` AS `ID_ASIGURAT_CASCO`,`pending_import_errors`.`NR_POLITA_CASCO` AS `NR_POLITA_CASCO`,`pending_import_errors`.`ID_AUTO_CASCO` AS `ID_AUTO_CASCO`,`pending_import_errors`.`ID_SOCIETATE_CASCO` AS `ID_SOCIETATE_CASCO`,`pending_import_errors`.`NR_POLITA_RCA` AS `NR_POLITA_RCA`,`pending_import_errors`.`ID_AUTO_RCA` AS `ID_AUTO_RCA`,`pending_import_errors`.`VALOARE_DAUNA` AS `VALOARE_DAUNA`,`pending_import_errors`.`VALOARE_REGRES` AS `VALOARE_REGRES`,`pending_import_errors`.`ID_INTERVENIENT` AS `ID_INTERVENIENT`,`pending_import_errors`.`NR_DOSAR_CASCO` AS `NR_DOSAR_CASCO`,`pending_import_errors`.`VMD` AS `VMD`,`pending_import_errors`.`OBSERVATII` AS `OBSERVATII`,`pending_import_errors`.`ID_SOCIETATE_RCA` AS `ID_SOCIETATE_RCA`,`pending_import_errors`.`DATA_EVENIMENT` AS `DATA_EVENIMENT`,`pending_import_errors`.`REZERVA_DAUNA` AS `REZERVA_DAUNA`,`pending_import_errors`.`DATA_INTRARE_RCA` AS `DATA_INTRARE_RCA`,`pending_import_errors`.`DATA_IESIRE_CASCO` AS `DATA_IESIRE_CASCO`,`pending_import_errors`.`NR_INTRARE_RCA` AS `NR_INTRARE_RCA`,`pending_import_errors`.`NR_IESIRE_CASCO` AS `NR_IESIRE_CASCO`,`pending_import_errors`.`ID_ASIGURAT_RCA` AS `ID_ASIGURAT_RCA`,`pending_import_errors`.`ID_TIP_DOSAR` AS `ID_TIP_DOSAR`,`pending_import_errors`.`SUMA_IBNR` AS `SUMA_IBNR`,`pending_import_errors`.`DATA_AVIZARE` AS `DATA_AVIZARE`,`pending_import_errors`.`DATA_NOTIFICARE` AS `DATA_NOTIFICARE`,`pending_import_errors`.`DATA_ULTIMEI_MODIFICARI` AS `DATA_ULTIMEI_MODIFICARI`,`pending_import_errors`.`deleted` AS `deleted`,`pending_import_errors`.`AVIZAT` AS `AVIZAT`,`pending_import_errors`.`CAZ` AS `CAZ` from `pending_import_errors` where (isnull(`pending_import_errors`.`deleted`) or (`pending_import_errors`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vplati`
--

/*!50001 DROP VIEW IF EXISTS `vplati`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vplati` AS select `plati`.`ID` AS `ID`,`plati`.`NR_DOCUMENT` AS `NR_DOCUMENT`,`plati`.`DATA_DOCUMENT` AS `DATA_DOCUMENT`,`plati`.`SUMA` AS `SUMA`,`plati`.`OBSERVATII` AS `OBSERVATII`,`plati`.`deleted` AS `deleted` from `plati` where (isnull(`plati`.`deleted`) or (`plati`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vplati_contracte`
--

/*!50001 DROP VIEW IF EXISTS `vplati_contracte`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vplati_contracte` AS select `plati_contracte`.`ID` AS `ID`,`plati_contracte`.`NR_DOCUMENT` AS `NR_DOCUMENT`,`plati_contracte`.`DATA_DOCUMENT` AS `DATA_DOCUMENT`,`plati_contracte`.`SUMA` AS `SUMA`,`plati_contracte`.`OBSERVATII` AS `OBSERVATII`,`plati_contracte`.`INCASAT_PE_AMIABIL` AS `INCASAT_PE_AMIABIL`,`plati_contracte`.`INCASAT_CONTRACT` AS `INCASAT_CONTRACT`,`plati_contracte`.`deleted` AS `deleted` from `plati_contracte` where (isnull(`plati_contracte`.`deleted`) or (`plati_contracte`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vplati_taxa_timbru`
--

/*!50001 DROP VIEW IF EXISTS `vplati_taxa_timbru`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vplati_taxa_timbru` AS select `plati_taxa_timbru`.`ID` AS `ID`,`plati_taxa_timbru`.`NR_DOCUMENT` AS `NR_DOCUMENT`,`plati_taxa_timbru`.`DATA_DOCUMENT` AS `DATA_DOCUMENT`,`plati_taxa_timbru`.`SUMA` AS `SUMA`,`plati_taxa_timbru`.`OBSERVATII` AS `OBSERVATII`,`plati_taxa_timbru`.`deleted` AS `deleted` from `plati_taxa_timbru` where (isnull(`plati_taxa_timbru`.`deleted`) or (`plati_taxa_timbru`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vprocese`
--

/*!50001 DROP VIEW IF EXISTS `vprocese`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vprocese` AS select `procese`.`ID` AS `ID`,`procese`.`NR_INTERN` AS `NR_INTERN`,`procese`.`NR_DOSAR_INSTANTA` AS `NR_DOSAR_INSTANTA`,`procese`.`DATA_DEPUNERE` AS `DATA_DEPUNERE`,`procese`.`OBSERVATII` AS `OBSERVATII`,`procese`.`SUMA_SOLICITATA` AS `SUMA_SOLICITATA`,`procese`.`PENALITATI` AS `PENALITATI`,`procese`.`TAXA_TIMBRU` AS `TAXA_TIMBRU`,`procese`.`TIMBRU_JUDICIAR` AS `TIMBRU_JUDICIAR`,`procese`.`ONORARIU_EXPERT` AS `ONORARIU_EXPERT`,`procese`.`ONORARIU_AVOCAT` AS `ONORARIU_AVOCAT`,`procese`.`ID_INSTANTA` AS `ID_INSTANTA`,`procese`.`ID_COMPLET` AS `ID_COMPLET`,`procese`.`ID_CONTRACT` AS `ID_CONTRACT`,`procese`.`STADIU` AS `STADIU`,`procese`.`CHELTUIELI_MICA_PUBLICITATE` AS `CHELTUIELI_MICA_PUBLICITATE`,`procese`.`ONORARIU_CURATOR` AS `ONORARIU_CURATOR`,`procese`.`ALTE_CHELTUIELI_JUDECATA` AS `ALTE_CHELTUIELI_JUDECATA`,`procese`.`TAXA_TIMBRU_REEXAMINARE` AS `TAXA_TIMBRU_REEXAMINARE`,`procese`.`NR_DOSAR_EXECUTARE` AS `NR_DOSAR_EXECUTARE`,`procese`.`DATA_EXECUTARE` AS `DATA_EXECUTARE`,`procese`.`ONORARIU_AVOCAT_EXECUTARE` AS `ONORARIU_AVOCAT_EXECUTARE`,`procese`.`CHELTUIELI_EXECUTARE` AS `CHELTUIELI_EXECUTARE`,`procese`.`DESPAGUBIRE_ACORDATA` AS `DESPAGUBIRE_ACORDATA`,`procese`.`CHELTUIELI_JUDECATA_ACORDATE` AS `CHELTUIELI_JUDECATA_ACORDATE`,`procese`.`MONITORIZARE` AS `MONITORIZARE`,`procese`.`ID_TIP_PROCES` AS `ID_TIP_PROCES`,`procese`.`deleted` AS `deleted` from `procese` where (isnull(`procese`.`deleted`) or (`procese`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vprocese_plati_taxa_timbru`
--

/*!50001 DROP VIEW IF EXISTS `vprocese_plati_taxa_timbru`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vprocese_plati_taxa_timbru` AS select `procese_plati_taxa_timbru`.`ID` AS `ID`,`procese_plati_taxa_timbru`.`ID_PROCES` AS `ID_PROCES`,`procese_plati_taxa_timbru`.`ID_PLATA_TAXA_TIMBRU` AS `ID_PLATA_TAXA_TIMBRU`,`procese_plati_taxa_timbru`.`deleted` AS `deleted` from `procese_plati_taxa_timbru` where (isnull(`procese_plati_taxa_timbru`.`deleted`) or (`procese_plati_taxa_timbru`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vsentinte`
--

/*!50001 DROP VIEW IF EXISTS `vsentinte`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vsentinte` AS select `sentinte`.`ID` AS `ID`,`sentinte`.`NR_SENTINTA` AS `NR_SENTINTA`,`sentinte`.`DATA_SENTINTA` AS `DATA_SENTINTA`,`sentinte`.`DATA_COMUNICARE` AS `DATA_COMUNICARE`,`sentinte`.`SOLUTIE` AS `SOLUTIE`,`sentinte`.`deleted` AS `deleted` from `sentinte` where (isnull(`sentinte`.`deleted`) or (`sentinte`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vsetari`
--

/*!50001 DROP VIEW IF EXISTS `vsetari`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vsetari` AS select `setari`.`ID` AS `ID`,`setari`.`NUME` AS `NUME`,`setari`.`VALOARE` AS `VALOARE`,`setari`.`deleted` AS `deleted` from `setari` where (isnull(`setari`.`deleted`) or (`setari`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vsocietati_asigurare`
--

/*!50001 DROP VIEW IF EXISTS `vsocietati_asigurare`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vsocietati_asigurare` AS select `societati_asigurare`.`ID` AS `ID`,`societati_asigurare`.`DENUMIRE` AS `DENUMIRE`,`societati_asigurare`.`DETALII` AS `DETALII`,`societati_asigurare`.`CUI` AS `CUI`,`societati_asigurare`.`NR_REG_COM` AS `NR_REG_COM`,`societati_asigurare`.`ADRESA` AS `ADRESA`,`societati_asigurare`.`BANCA` AS `BANCA`,`societati_asigurare`.`IBAN` AS `IBAN`,`societati_asigurare`.`SOLD` AS `SOLD`,`societati_asigurare`.`DATA_ULTIMEI_PLATI` AS `DATA_ULTIMEI_PLATI`,`societati_asigurare`.`TELEFON` AS `TELEFON`,`societati_asigurare`.`REPREZENTANT_FISCAL` AS `REPREZENTANT_FISCAL`,`societati_asigurare`.`DENUMIRE_SCURTA` AS `DENUMIRE_SCURTA`,`societati_asigurare`.`EMAIL_NOTIFICARI` AS `EMAIL_NOTIFICARI`,`societati_asigurare`.`ID_TEMPLATE_NOTIFICARI` AS `ID_TEMPLATE_NOTIFICARI`,`societati_asigurare`.`EMAIL` AS `EMAIL`,`societati_asigurare`.`deleted` AS `deleted` from `societati_asigurare` where (isnull(`societati_asigurare`.`deleted`) or (`societati_asigurare`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vstadii`
--

/*!50001 DROP VIEW IF EXISTS `vstadii`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vstadii` AS select `stadii`.`ID` AS `ID`,`stadii`.`DENUMIRE` AS `DENUMIRE`,`stadii`.`DETALII` AS `DETALII`,`stadii`.`ICON_PATH` AS `ICON_PATH`,`stadii`.`PAS` AS `PAS`,`stadii`.`STADIU_INSTANTA` AS `STADIU_INSTANTA`,`stadii`.`STADIU_CU_TERMEN` AS `STADIU_CU_TERMEN`,`stadii`.`deleted` AS `deleted` from `stadii` where (isnull(`stadii`.`deleted`) or (`stadii`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vstadii_scadente`
--

/*!50001 DROP VIEW IF EXISTS `vstadii_scadente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vstadii_scadente` AS select `stadii_scadente`.`ID` AS `ID`,`stadii_scadente`.`ID_STADIU` AS `ID_STADIU`,`stadii_scadente`.`ID_SETARE` AS `ID_SETARE`,`stadii_scadente`.`deleted` AS `deleted` from `stadii_scadente` where (isnull(`stadii_scadente`.`deleted`) or (`stadii_scadente`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vstadii_setari`
--

/*!50001 DROP VIEW IF EXISTS `vstadii_setari`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vstadii_setari` AS select `stadii_setari`.`ID_SETARE` AS `ID_SETARE`,`stadii_setari`.`ID_STADIU` AS `ID_STADIU`,`stadii_setari`.`ID` AS `ID`,`stadii_setari`.`WARNING` AS `WARNING`,`stadii_setari`.`deleted` AS `deleted` from `stadii_setari` where (isnull(`stadii_setari`.`deleted`) or (`stadii_setari`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vtemplates`
--

/*!50001 DROP VIEW IF EXISTS `vtemplates`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vtemplates` AS select `templates`.`ID` AS `ID`,`templates`.`DENUMIRE_FISIER` AS `DENUMIRE_FISIER`,`templates`.`EXTENSIE_FISIER` AS `EXTENSIE_FISIER`,`templates`.`FILE_CONTENT` AS `FILE_CONTENT`,`templates`.`DIMENSIUNE_FISIER` AS `DIMENSIUNE_FISIER`,`templates`.`DETALII` AS `DETALII`,`templates`.`deleted` AS `deleted` from `templates` where (isnull(`templates`.`deleted`) or (`templates`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vtip_caz`
--

/*!50001 DROP VIEW IF EXISTS `vtip_caz`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vtip_caz` AS select `tip_caz`.`ID` AS `ID`,`tip_caz`.`DENUMIRE` AS `DENUMIRE`,`tip_caz`.`DETALII` AS `DETALII`,`tip_caz`.`deleted` AS `deleted` from `tip_caz` where (isnull(`tip_caz`.`deleted`) or (`tip_caz`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vtip_document`
--

/*!50001 DROP VIEW IF EXISTS `vtip_document`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vtip_document` AS select `tip_document`.`ID` AS `ID`,`tip_document`.`DENUMIRE` AS `DENUMIRE`,`tip_document`.`DETALII` AS `DETALII`,`tip_document`.`QINFO` AS `QINFO`,`tip_document`.`MANDATORY` AS `MANDATORY`,`tip_document`.`DISPLAY_ORDER` AS `DISPLAY_ORDER`,`tip_document`.`deleted` AS `deleted` from `tip_document` where (isnull(`tip_document`.`deleted`) or (`tip_document`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vtip_dosare`
--

/*!50001 DROP VIEW IF EXISTS `vtip_dosare`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vtip_dosare` AS select `tip_dosare`.`ID` AS `ID`,`tip_dosare`.`DENUMIRE` AS `DENUMIRE`,`tip_dosare`.`DETALII` AS `DETALII`,`tip_dosare`.`deleted` AS `deleted` from `tip_dosare` where (isnull(`tip_dosare`.`deleted`) or (`tip_dosare`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vtip_mesaje`
--

/*!50001 DROP VIEW IF EXISTS `vtip_mesaje`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vtip_mesaje` AS select `tip_mesaje`.`ID` AS `ID`,`tip_mesaje`.`DENUMIRE` AS `DENUMIRE`,`tip_mesaje`.`DETALII` AS `DETALII`,`tip_mesaje`.`deleted` AS `deleted` from `tip_mesaje` where (isnull(`tip_mesaje`.`deleted`) or (`tip_mesaje`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vtip_procese`
--

/*!50001 DROP VIEW IF EXISTS `vtip_procese`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vtip_procese` AS select `tip_procese`.`ID` AS `ID`,`tip_procese`.`DENUMIRE` AS `DENUMIRE`,`tip_procese`.`DETALII` AS `DETALII`,`tip_procese`.`deleted` AS `deleted` from `tip_procese` where (isnull(`tip_procese`.`deleted`) or (`tip_procese`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vtip_utilizatori`
--

/*!50001 DROP VIEW IF EXISTS `vtip_utilizatori`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vtip_utilizatori` AS select `tip_utilizatori`.`ID` AS `ID`,`tip_utilizatori`.`DENUMIRE` AS `DENUMIRE`,`tip_utilizatori`.`DETALII` AS `DETALII`,`tip_utilizatori`.`deleted` AS `deleted` from `tip_utilizatori` where (isnull(`tip_utilizatori`.`deleted`) or (`tip_utilizatori`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vutilizatori`
--

/*!50001 DROP VIEW IF EXISTS `vutilizatori`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vutilizatori` AS select `utilizatori`.`ID` AS `ID`,`utilizatori`.`USER_NAME` AS `USER_NAME`,`utilizatori`.`PASSWORD` AS `PASSWORD`,`utilizatori`.`NUME_COMPLET` AS `NUME_COMPLET`,`utilizatori`.`DETALII` AS `DETALII`,`utilizatori`.`IS_ONLINE` AS `IS_ONLINE`,`utilizatori`.`EMAIL` AS `EMAIL`,`utilizatori`.`IP` AS `IP`,`utilizatori`.`MAC` AS `MAC`,`utilizatori`.`ID_TIP_UTILIZATOR` AS `ID_TIP_UTILIZATOR`,`utilizatori`.`LAST_REFRESH` AS `LAST_REFRESH`,`utilizatori`.`DEPARTAMENT` AS `DEPARTAMENT`,`utilizatori`.`ID_SOCIETATE` AS `ID_SOCIETATE`,`utilizatori`.`deleted` AS `deleted`,`utilizatori`.`LAST_LOGIN` AS `LAST_LOGIN` from `utilizatori` where (isnull(`utilizatori`.`deleted`) or (`utilizatori`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vutilizatori_actions`
--

/*!50001 DROP VIEW IF EXISTS `vutilizatori_actions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vutilizatori_actions` AS select `utilizatori_actions`.`ID` AS `ID`,`utilizatori_actions`.`ID_UTILIZATOR` AS `ID_UTILIZATOR`,`utilizatori_actions`.`ID_ACTION` AS `ID_ACTION`,`utilizatori_actions`.`deleted` AS `deleted` from `utilizatori_actions` where (isnull(`utilizatori_actions`.`deleted`) or (`utilizatori_actions`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vutilizatori_dosare`
--

/*!50001 DROP VIEW IF EXISTS `vutilizatori_dosare`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vutilizatori_dosare` AS select `utilizatori_dosare`.`ID` AS `ID`,`utilizatori_dosare`.`ID_UTILIZATOR` AS `ID_UTILIZATOR`,`utilizatori_dosare`.`ID_DOSAR` AS `ID_DOSAR`,`utilizatori_dosare`.`deleted` AS `deleted` from `utilizatori_dosare` where (isnull(`utilizatori_dosare`.`deleted`) or (`utilizatori_dosare`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vutilizatori_drepturi`
--

/*!50001 DROP VIEW IF EXISTS `vutilizatori_drepturi`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vutilizatori_drepturi` AS select `utilizatori_drepturi`.`ID` AS `ID`,`utilizatori_drepturi`.`ID_UTILIZATOR` AS `ID_UTILIZATOR`,`utilizatori_drepturi`.`ID_DREPT` AS `ID_DREPT`,`utilizatori_drepturi`.`deleted` AS `deleted` from `utilizatori_drepturi` where (isnull(`utilizatori_drepturi`.`deleted`) or (`utilizatori_drepturi`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vutilizatori_setari`
--

/*!50001 DROP VIEW IF EXISTS `vutilizatori_setari`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vutilizatori_setari` AS select `utilizatori_setari`.`ID` AS `ID`,`utilizatori_setari`.`ID_UTILIZATOR` AS `ID_UTILIZATOR`,`utilizatori_setari`.`ID_SETARE` AS `ID_SETARE`,`utilizatori_setari`.`VALOARE` AS `VALOARE`,`utilizatori_setari`.`deleted` AS `deleted` from `utilizatori_setari` where (isnull(`utilizatori_setari`.`deleted`) or (`utilizatori_setari`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vutilizatori_societati`
--

/*!50001 DROP VIEW IF EXISTS `vutilizatori_societati`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vutilizatori_societati` AS select `utilizatori_societati`.`ID` AS `ID`,`utilizatori_societati`.`ID_UTILIZATOR` AS `ID_UTILIZATOR`,`utilizatori_societati`.`ID_SOCIETATE` AS `ID_SOCIETATE`,`utilizatori_societati`.`deleted` AS `deleted` from `utilizatori_societati` where (isnull(`utilizatori_societati`.`deleted`) or (`utilizatori_societati`.`deleted` <> TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vutilizatori_societati_administrate`
--

/*!50001 DROP VIEW IF EXISTS `vutilizatori_societati_administrate`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vutilizatori_societati_administrate` AS select `utilizatori_societati_administrate`.`ID` AS `ID`,`utilizatori_societati_administrate`.`ID_UTILIZATOR` AS `ID_UTILIZATOR`,`utilizatori_societati_administrate`.`ID_SOCIETATE` AS `ID_SOCIETATE`,`utilizatori_societati_administrate`.`deleted` AS `deleted` from `utilizatori_societati_administrate` where (isnull(`utilizatori_societati_administrate`.`deleted`) or (`utilizatori_societati_administrate`.`deleted` <> TRUE)) */;
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

-- Dump completed on 2017-10-19 17:30:05
