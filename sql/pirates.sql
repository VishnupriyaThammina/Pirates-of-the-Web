-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pirate_app
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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'test','hi\n','2025-04-19 05:48:13'),(2,'pirate123','hi\n','2025-04-19 06:27:58'),(5,'test','hi\n','2025-04-19 07:49:35');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maps`
--

DROP TABLE IF EXISTS `maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maps` (
  `map_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `victim_city` varchar(255) NOT NULL,
  `place` varchar(255) NOT NULL,
  `jewel_stolen` tinyint(1) NOT NULL,
  `houses_demolished` int NOT NULL,
  `loot_satisfied` enum('yes','no') NOT NULL,
  PRIMARY KEY (`map_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `maps_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maps`
--

LOCK TABLES `maps` WRITE;
/*!40000 ALTER TABLE `maps` DISABLE KEYS */;
INSERT INTO `maps` VALUES (1,1,'Port Royal','Governor\'s Mansion',1,3,'yes'),(2,2,'Havana','Merchant District',1,5,'yes'),(3,3,'Nassau','Harbor Fort',0,2,'no'),(4,4,'Kingston','Royal Treasury',1,1,'yes'),(5,1,'Tortuga','Tavern Square',0,0,'no'),(6,2,'Santo Domingo','Colonial Palace',1,7,'yes'),(7,3,'Cartagena','Spanish Garrison',1,4,'yes'),(8,4,'Portobelo','Customs House',1,2,'yes'),(9,1,'St. Augustine','Fort San Marcos',0,1,'no'),(10,2,'Charleston','Shipyard',1,3,'yes'),(11,3,'New Orleans','French Quarter',1,5,'yes'),(12,4,'Tampa Bay','Coastal Watchtower',0,2,'no'),(13,1,'Veracruz','Silver Exchange',1,4,'yes'),(14,2,'Panama City','Gold Transport Route',1,0,'yes'),(15,3,'Maracaibo','Governor\'s Residence',1,6,'yes'),(16,4,'Barbados','Plantation Estate',0,3,'no'),(17,1,'Antigua','Naval Dockyard',1,2,'yes'),(18,2,'Martinique','Sugar Warehouse',1,4,'yes'),(19,3,'Curaçao','Dutch Trading Post',0,1,'no'),(20,4,'Providencia','Pirate Haven',1,0,'yes'),(21,1,'Bermuda','Royal Naval Base',0,3,'no'),(22,2,'Santiago de Cuba','Fortress del Morro',1,5,'yes'),(23,3,'Campeche','Spanish Arsenal',1,7,'yes'),(24,4,'Belize City','Logging Camp',0,2,'no'),(25,1,'Galveston','Smuggler\'s Cove',1,1,'yes'),(26,2,'Key West','Customs Office',1,3,'yes'),(27,3,'St. Thomas','Merchant Warehouse',0,4,'no'),(28,4,'Trinidad','Colonial Governor\'s Estate',1,6,'yes'),(29,1,'Grenada','Spice Storage',1,2,'yes'),(30,2,'St. Kitts','Sugar Mill',0,1,'no'),(31,3,'Roatán','Settlement Village',1,5,'yes'),(32,4,'Bahamas','Treasure Fleet Anchorage',1,0,'yes'),(33,1,'St. Lucia','British Fort',0,3,'no'),(34,2,'Dominica','French Outpost',1,4,'yes'),(35,3,'Guadeloupe','Rum Distillery',1,2,'yes'),(36,4,'San Juan','El Morro Castle',0,5,'no'),(37,1,'St. Vincent','Coastal Village',1,3,'yes'),(38,2,'Jamaica','Spanish Town Treasury',1,6,'yes'),(39,3,'Pensacola','Naval Shipyard',0,2,'no'),(40,4,'Mobile','French Fortress',1,4,'yes');
/*!40000 ALTER TABLE `maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oceans`
--

DROP TABLE IF EXISTS `oceans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oceans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` text NOT NULL,
  `treasure` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oceans`
--

LOCK TABLES `oceans` WRITE;
/*!40000 ALTER TABLE `oceans` DISABLE KEYS */;
INSERT INTO `oceans` VALUES (1,'Atlantic Ocean','Between the Americas and Europe/Africa','Hidden Pirate Treasure in the Caribbean'),(2,'Pacific Ocean','Between the Americas and Asia','Ancient Pirate Gold in the Philippines'),(3,'Indian Ocean','Between Africa, Asia, and Australia','Pirate Ships sunk during the 17th century'),(4,'Southern Ocean','Surrounding Antarctica','Lost Pirate maps from ancient voyages'),(5,'Arctic Ocean','Surrounding the Arctic region','Ice-covered treasure of the north'),(6,'Mediterranean Sea','Between Europe, Africa, and Asia','Ancient Roman gold coins from sunken merchant vessels'),(7,'Caribbean Sea','Southeast of North America','Blackbeard\'s lost treasure chests'),(8,'South China Sea','Southeast Asia','Ming Dynasty artifacts from pirate raids'),(9,'Arabian Sea','Between India and Arabian Peninsula','Ottoman Empire jewels from captured merchant ships'),(10,'Coral Sea','Northeast of Australia','Captain Cook\'s secret stash of Pacific valuables'),(11,'Red Sea','Between Africa and Arabian Peninsula','Egyptian pharaoh\'s gold transported by ancient pirates'),(12,'Bering Sea','Between Alaska and Russia','Russian imperial treasures lost during colonial expeditions'),(13,'Norwegian Sea','Northwest of Norway','Viking plunder hidden in underwater caves'),(14,'Black Sea','Between Europe and Asia','Byzantine Empire treasures from trade routes'),(15,'Barents Sea','North of Norway and Russia','Lost expedition gold from early polar explorers'),(16,'North Sea','Between Great Britain and Europe','Spanish Armada remnants with royal jewels'),(17,'Baltic Sea','Northern Europe','Hanseatic League merchant treasures from pirate attacks'),(18,'Sea of Japan','Between Japan and Korean Peninsula','Samurai lord treasures captured by Wokou pirates'),(19,'Yellow Sea','Between China and Korean Peninsula','Qing Dynasty imperial gifts lost at sea'),(20,'Tasman Sea','Between Australia and New Zealand','Dutch East India Company gold from wrecked ships'),(21,'Bay of Bengal','East of India','Portuguese colonial treasures from raided galleons'),(22,'Gulf of Mexico','Southeast of North America','Spanish conquistador plunder hidden by pirates'),(23,'Sargasso Sea','North Atlantic Ocean','Bermuda Triangle treasures from mysteriously vanished ships'),(24,'Aegean Sea','Between Greece and Turkey','Ancient Greek statues taken by sea marauders'),(25,'Celtic Sea','Southwest of Great Britain','Celtic ritual objects stolen by northern raiders'),(26,'Adriatic Sea','Between Italy and Balkan Peninsula','Venetian merchant wealth from ambushed trade ships'),(27,'Tyrrhenian Sea','West of Italy','Etruscan artifacts from coastal raids'),(28,'Ionian Sea','Between Italy and Greece','Roman senator\'s gold hidden from imperial taxation'),(29,'Alboran Sea','Between Spain and Morocco','Moorish treasures captured during naval battles'),(30,'Gulf of Aden','Between Yemen and Somalia','Modern pirate hideouts with ransom collections'),(31,'Andaman Sea','Southeast of Bay of Bengal','British colonial treasures lost during monsoons'),(32,'Gulf of Thailand','Southeast Asia','Siamese royal jewelry hidden from colonial powers'),(33,'Beaufort Sea','North of Alaska and Canada','Frozen expedition treasures from early Arctic explorers'),(34,'Scotia Sea','Between South America and Antarctica','Lost whaling ship bounties from the 19th century'),(35,'Weddell Sea','East of Antarctic Peninsula','Shackleton\'s secret cache of expedition valuables'),(36,'Sea of Okhotsk','West of Kamchatka Peninsula','Siberian gold transports wrecked in winter storms'),(37,'Persian Gulf','Between Iran and Arabian Peninsula','Pearl merchant treasures from ancient pirate raids'),(38,'Caspian Sea','Between Europe and Asia','Silk Road caravan treasures recovered from shipwrecks'),(39,'Arafura Sea','Between Australia and New Guinea','Dutch East Indies spice trade wealth hidden by pirates'),(40,'Banda Sea','Central Indonesia','Portuguese colonial treasures from contested spice islands');
/*!40000 ALTER TABLE `oceans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pirates`
--

DROP TABLE IF EXISTS `pirates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pirates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ship` varchar(255) NOT NULL,
  `dob` date DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `bounty` decimal(10,2) DEFAULT NULL,
  `known_for` text,
  `last_seen` varchar(255) DEFAULT NULL,
  `capture_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pirates`
--

LOCK TABLES `pirates` WRITE;
/*!40000 ALTER TABLE `pirates` DISABLE KEYS */;
INSERT INTO `pirates` VALUES (1,'Edward Teach','Queen Anne\'s Revenge','1680-01-17','English','Blackbeard',100000.00,'Blockade of Charleston harbor; fierce appearance with lit fuses in his beard','Ocracoke Island, North Carolina','Killed in battle'),(2,'Anne Bonny','Revenge','1697-03-08','Irish','Red Anne',50000.00,'Female pirate who disguised herself as a man; fierce fighter','Port Royal, Jamaica','Escaped execution'),(3,'John Rackham','William','1682-12-21','English','Calico Jack',45000.00,'Design of Jolly Roger flag; relationship with Anne Bonny','Port Royal, Jamaica','Executed'),(4,'Mary Read','William','1690-04-15','English','Mark Read',40000.00,'Female pirate who disguised herself as a man','Port Royal, Jamaica','Died in prison'),(5,'William Kidd','Adventure Galley','1645-01-22','Scottish','Captain Kidd',75000.00,'Privateer turned pirate; buried treasure','Boston, Massachusetts','Executed'),(6,'Bartholomew Roberts','Royal Fortune','1682-05-17','Welsh','Black Bart',80000.00,'Most successful pirate of the Golden Age; captured over 400 ships','Cape Lopez, Gabon','Killed in battle'),(7,'Francis Drake','Golden Hind','1540-02-01','English','El Draque',90000.00,'Circumnavigation of the globe; raids on Spanish colonies','Portobelo, Panama','Died of disease'),(8,'Henry Morgan','Satisfaction','1635-01-24','Welsh','Sir Henry',70000.00,'Raids on Spanish colonies; later became Lieutenant Governor of Jamaica','Port Royal, Jamaica','Died of natural causes'),(9,'Grace O\'Malley','Black Oak','1530-03-10','Irish','Granuaile',30000.00,'Meeting with Queen Elizabeth I; controlled the western coast of Ireland','Rockfleet Castle, Ireland','Died of natural causes'),(10,'Ching Shih','Red Flag Fleet','1775-08-28','Chinese','Madame Ching',120000.00,'Command of over 300 ships and 20,000-40,000 pirates','Canton, China','Retired'),(11,'Jean Lafitte','Pride','1780-03-22','French','The Corsair',55000.00,'Help during the Battle of New Orleans; operated in the Gulf of Mexico','Gulf of Mexico','Disappeared'),(12,'Stede Bonnet','Revenge','1688-07-29','Barbadian','The Gentleman Pirate',35000.00,'Former wealthy plantation owner turned pirate','Charles Town, South Carolina','Executed'),(13,'Charles Vane','Ranger','1680-04-19','English','The Terror',48000.00,'Refusal to accept the King\'s Pardon; particularly brutal methods','Bay Islands, Honduras','Executed'),(14,'Samuel Bellamy','Whydah Gally','1689-02-23','English','Black Sam',52000.00,'Wealthiest pirate of all time; democratic captain','Cape Cod, Massachusetts','Died in shipwreck'),(15,'Edward Low','Rose Pink','1690-08-11','English','Ned Low',60000.00,'Extreme cruelty and torture of captives','Azores','Unknown'),(16,'Henry Every','Fancy','1659-08-20','English','Long Ben',85000.00,'Perpetrator of the most profitable pirate raid in history','Nassau, Bahamas','Disappeared'),(17,'Thomas Tew','Amity','1649-06-30','English','The Rhode Island Pirate',42000.00,'Red Sea Men founder; single voyage piracy','Arabian Sea','Killed in battle'),(18,'Edward England','Pearl','1685-10-07','Irish','The Merciful Pirate',38000.00,'Known for sparing captives against crew wishes','Madagascar','Marooned'),(19,'Howell Davis','Buck','1690-07-16','Welsh','The Trickster',39000.00,'Master of disguise and deception','Príncipe Island','Killed in ambush'),(20,'George Lowther','Happy Delivery','1690-09-04','English','The Gentleman Captain',36000.00,'Treaty with Edward Low; known for fairness to crew','Barbados','Marooned'),(21,'Benjamin Hornigold','Ranger','1680-01-08','English','The Mentor',45000.00,'Taught many famous pirates including Blackbeard','Nassau, Bahamas','Died in hurricane'),(22,'Christopher Moody','Rising Sun','1694-03-23','English','The Executioner',32000.00,'Unique Jolly Roger flag; ruthless tactics','West Indies','Executed'),(23,'John Phillips','Revenge','1685-12-14','English','The Articulate',28000.00,'Strict code of conduct on his ship','Newfoundland','Killed in battle'),(24,'William Fly','Fame\'s Revenge','1699-09-28','English','The Rebel',25000.00,'Mutinied and took control of his ship','Boston, Massachusetts','Executed'),(25,'Olivier Levasseur','La Buse','1688-11-11','French','The Buzzard',65000.00,'Cryptogram allegedly leading to unrecovered treasure','Réunion Island','Executed'),(26,'Richard Worley','New York Revenge','1686-10-09','English','Short Reign',22000.00,'Brief but intense career as a pirate','Charleston, South Carolina','Killed in battle'),(27,'Emanuel Wynn','Black Joke','1670-05-21','French','The Flag Maker',30000.00,'First recorded use of the Jolly Roger flag','Caribbean Sea','Unknown'),(28,'Zheng Yi','Dragon Lady','1765-02-12','Chinese','The Dragon',90000.00,'Founder of the Red Flag Fleet','South China Sea','Died at sea'),(29,'Charlotte de Berry','Athena','1731-03-18','English','The Avenging Wife',35000.00,'Led a mutiny after her husband\'s death','Caribbean Sea','Unknown'),(30,'Rachel Wall','Margaretta','1760-05-29','American','The Storm Wrecker',20000.00,'First American female pirate','Boston, Massachusetts','Executed'),(31,'Jacquotte Delahaye','Red Revenge','1630-11-07','Haitian','Back from the Dead Red',42000.00,'Faked her own death to escape authorities','Tortuga','Unknown'),(32,'Sayyida al-Hurra','Moroccan Menace','1485-08-16','Moroccan','The Hakima',55000.00,'Allied with Barbarossa brothers; controlled Mediterranean','Tétouan, Morocco','Deposed'),(33,'Christina Anna Skytte','Nordic Blade','1643-09-27','Swedish','The Ice Queen',28000.00,'Operated in Baltic Sea; noble background','Stockholm, Sweden','Acquitted'),(34,'Maria Cobham','Scourge','1700-06-14','English','The Scholar',32000.00,'Well-educated pirate known for strategic planning','Caribbean Sea','Disappeared'),(35,'Maria Lindsey','Dark Horse','1705-11-24','English','The Viper',33000.00,'Operated with her husband Eric Cobham','Newfoundland','Retired'),(36,'Margaret Jordan','Emerald Wave','1715-01-30','Irish','Green Death',30000.00,'Specialized in coastal raids','Irish Sea','Escaped'),(37,'Eric Cobham','Sudden Death','1700-04-19','English','The Canadian',45000.00,'Terrorized Gulf of St. Lawrence with wife','Quebec, Canada','Retired'),(38,'John Fenn','Adventurer','1675-08-27','English','The Quartermaster',28000.00,'Rose from quartermaster to captain','Caribbean Sea','Executed'),(39,'Thomas White','Blessing','1698-10-05','English','The Priest',22000.00,'Former clergyman turned pirate','West Indies','Hanged'),(40,'Hendrick Quintor','Dutch Revenge','1660-03-11','Dutch','The Navigator',34000.00,'Extraordinary naval knowledge','Dutch East Indies','Died at sea'),(41,'Christopher Condent','Flying Dragon','1690-07-19','English','Billy One-Hand',48000.00,'Operations in Madagascar; later settled in France','Saint-Malo, France','Retired'),(42,'John Ward','Gift','1553-01-28','English','Jack Ward',60000.00,'Conversion to Islam; base in Tunis','Tunis, Tunisia','Died of plague'),(43,'Samuel Hall','Little David','1697-02-18','English','Captain Fly',29000.00,'Operated in New England waters','Caribbean Sea','Executed'),(44,'William Lewis','Morning Star','1688-05-25','English','The Negotiator',35000.00,'Tactic of negotiating surrender without bloodshed','Bahamas','Killed by crew'),(45,'Bartholomew Sharp','Trinity','1650-04-19','English','The Cartographer',52000.00,'Captured valuable Spanish navigation charts','England','Acquitted'),(46,'Alexander Selkirk','Cinque Ports','1676-12-10','Scottish','The Castaway',10000.00,'Inspiration for Robinson Crusoe; marooned for 4 years','Juan Fernández Islands','Died of disease'),(47,'John Bowen','Speaker','1670-08-22','English','The Gentleman Captain',55000.00,'Operations in the Indian Ocean','Mauritius','Died of illness'),(48,'George Booth','Dragon','1668-09-15','English','The Firebrand',38000.00,'Burning of captured ships after looting','Madagascar','Killed in mutiny'),(49,'Nicholas Brown','Intrepid','1684-01-23','English','The Ghost',42000.00,'Ability to disappear and reappear in different regions','Caribbean Sea','Disappeared'),(50,'James Plantain','Destroyer','1690-04-01','English','The King of Ranter Bay',47000.00,'Established own kingdom in Madagascar','Madagascar','Unknown'),(51,'Benito de Soto','Black Joke','1800-04-22','Galician','The Terminator',68000.00,'One of the last brutal Atlantic pirates','Gibraltar','Executed'),(52,'Charles Harris','Fancy II','1792-11-11','American','The Republican',45000.00,'Active during early American Republic','Gulf of Mexico','Hanged'),(53,'Pedro Gilbert','Mexican','1800-07-19','Spanish','The Last Pirate',57000.00,'Last major pirate executed in Boston','Boston, Massachusetts','Executed'),(54,'Albert W. Hicks','A.W. Hicks','1820-03-12','American','The Last Pirate of New York',50000.00,'Last person executed for piracy in New York','New York','Executed'),(55,'Klaus Störtebeker','Crimson Fish','1360-01-28','German','The Invincible',75000.00,'Led the Victual Brothers; legendary drinking ability','Hamburg, Germany','Executed'),(56,'Montbars','Exterminator','1645-07-24','French','The Exterminator',63000.00,'Hatred of Spanish; extreme violence','Hispaniola','Unknown'),(57,'François l\'Olonnais','Bloody Cutlass','1635-06-28','French','The Flayer',78000.00,'Exceptional cruelty; cut out a prisoner\'s heart','Gulf of Honduras','Killed by natives'),(58,'Michel de Grammont','Neptune\'s Will','1650-09-03','French','The Nobleman',62000.00,'French nobleman turned pirate','Caribbean Sea','Lost at sea'),(59,'Lawrence Prince','Phoenix','1630-04-14','Dutch','The Resilient',51000.00,'Participated in raids on Panama','Jamaica','Retired'),(60,'Roche Braziliano','Brazilian Demon','1630-12-10','Dutch','The Torturer',68000.00,'Roasting captives on spits when drunk','Jamaica','Disappeared'),(61,'Jean-David Nau','Silent Death','1635-05-20','French','L\'Olonnais',79000.00,'Beheaded Spanish prisoners; extreme torture','Honduras','Killed by natives'),(62,'Henry Avery','Fancy','1659-08-23','English','The Arch Pirate',100000.00,'Capture of the Ganj-i-Sawai; enormous wealth','Bahamas','Disappeared'),(63,'Thomas Howard','Defiance','1695-07-30','English','The Planner',40000.00,'Elaborate strategic planning for raids','Madagascar','Retired'),(64,'John Halsey','Charles','1670-01-09','English','The Gentleman',38000.00,'Fair treatment of captives; code of honor','Madagascar','Died of fever'),(65,'Edward Jordan','Revenge IV','1700-11-14','English','The Butcher',42000.00,'Excessive violence; cannibalism rumors','Bahamas','Executed'),(66,'George Booth','Expedition','1690-11-23','English','The Exploder',35000.00,'Use of explosives in attacks','Caribbean Sea','Killed in battle'),(67,'Philip Roche','Rover','1693-05-18','Irish','The Cunning',36000.00,'Pretended to be victim of pirates','Scotland','Executed'),(68,'Nathaniel North','Defiance II','1675-10-01','English','The Conqueror',45000.00,'Seizing small islands as temporary bases','Madagascar','Killed by natives'),(69,'Richard Sawkins','Brave Revenge','1650-06-15','English','The Pious Pirate',32000.00,'No piracy on Sundays; religious observance','Panama','Killed in battle'),(70,'Walter Kennedy','Rover II','1695-03-14','English','The Betrayer',28000.00,'Betrayed Bartholomew Roberts','London','Executed'),(71,'Jane de Belleville','Vengeance','1300-11-23','French','The Black Widow',40000.00,'Avenged husband\'s execution by King Philip VI','English Channel','Retired');
/*!40000 ALTER TABLE `pirates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `ssn` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,1,'pirate123@ocean.com','233-456-7121','098-18-7893'),(2,2,'captain456@ocean.com','987-654-3210','987-65-4321'),(3,3,'test@ocean.com','233-456-7890','987-65-4321');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `ssn` varchar(11) DEFAULT NULL,
  `jwt_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'pirate123','password123','pirate123@ocean.com','233-456-7121','098-18-7893',NULL,'2025-04-18 17:17:33'),(2,'captain456','captain456','captain456@ocean.com','987-654-3210','987-65-4321',NULL,'2025-04-18 17:17:33'),(3,'admin','admin123','admin@ocean.com','958-456-7890','123-45-6789',NULL,'2025-04-19 05:46:43'),(4,'test','test','test@ocean.com','233-456-7121','098-18-6789',NULL,'2025-04-19 05:46:43');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-19 17:13:26
