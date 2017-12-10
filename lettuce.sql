-- MySQL dump 10.13  Distrib 5.7.17, for osx10.12 (x86_64)
--
-- Host: localhost    Database: lettuce
-- ------------------------------------------------------
-- Server version	5.7.19

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `username` varchar(255) NOT NULL,
  `password` text NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `logins` int(11) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('BotRoccoli','$2y$10$.A934BKakp.M8vIADrG5uuSHKptMdwxVAp37qwY9a7bq5NSpKTdb6','BotRoccoli',2),('peter','$2y$10$JzFEQp9e/C/BSpJyO5/OMe4TxYqtUSje.M3plA5FtIxUlTztpvCBu','Peter Linder',6),('ricky','$2y$10$N8x7wwhEwKCDO4xOfF0oouxLirKLrWVBKmeoMv.jSopp/Vit2Gy3C','Ricky Wang',0),('vinay','$2y$10$xVNGQQXvlR6zAKdvOHIMeONgCjya.Dt2sVD5b2d1.o1TV2xQzphnW','Vinay Balan',1),('zach','$2y$10$R8pBueV4Ul12gxJUqU1WmeIM5m2bkMWPlQvK23qwhuWrxYGXbTKji','Zach Rossi',10);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat` (
  `ID` int(11) NOT NULL,
  `members` text NOT NULL,
  `latest` text,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` VALUES (0,'zach!#, vinay!#, peter!#','1512866912','Friends!'),(1,'zach!#, peter!#, momman!#','1512885652','Best Friends!'),(2,'ricky!#, zach!#, vinay!#, peter!#','1512875856','All Friends'),(3,'ricky!#, peter!#','1512875843','Peter and Ricky'),(4,'vinay!#, peter!#','1512875567','VinP'),(5,'vinay!#, ricky!#, peter!#, zach!#','1512879076','Without Zach :('),(6,'BotRoccoli!#, peter!#','1512883661','BotRoccoli'),(7,'BotRoccoli!#, zach!#, zach!#, BotRoccoli!#','1512883452','Botty'),(8,'zach!#, BotRoccoli!#, peter!#','1512883812','Bot and Friends'),(9,'zach!#, peter!#','1512883897','Super Secret chat'),(10,'Vinay!#, zach!#','1512883911','YIP'),(11,'zach!#, peter!#','1512883933','Soccer chat'),(12,'BotRoccoli!#, zach!#','1512883928','sham wow'),(13,'BotRoccoli!#, zach!#','1512883931','sham wow');
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `chat_id` int(11) NOT NULL,
  `message` text,
  `timestamp` text,
  `user` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (0,'Hi friends','1512854622','peter'),(0,'I also say hi to friends','1512854722','zach'),(1,'Hi 1 friend','1512854656','peter'),(1,'Hi to you too friend','1512854756','zach'),(1,'Hi again','1512861367','peter'),(1,'Sup','1512861407','peter'),(0,'All of my friends!','1512861443','peter'),(0,'Wait what?','1512861472','vinay'),(0,'it is Wednesday my dudes ','1512862152','zach'),(1,'Zach','1512863419','peter'),(1,'yes','1512863430','zach'),(1,'Yes what, sir?','1512863438','peter'),(1,'wan som funk?','1512863444','zach'),(0,'Yay!','1512863461','peter'),(0,'Yo Vinay','1512864061','peter'),(0,'Why aren\'t you typing tho?','1512864069','peter'),(0,'litty','1512864490','zach'),(0,'oh','1512864693','peter'),(0,'hey','1512865310','peter'),(0,'wait','1512865314','peter'),(0,'ye','1512866527','zach'),(0,'get em','1512866579','zach'),(0,'hi','1512866581','peter'),(0,'there','1512866583','peter'),(0,'git em','1512866584','zach'),(0,'stop','1512866912','peter'),(2,'Created chat','1512874838','peter'),(3,'Created chat','1512875093','peter'),(4,'Created chat','1512875530','peter'),(4,'Hi Vinay','1512875567','peter'),(5,'Created chat','1512875647','peter'),(3,'Hi Ricky','1512875843','peter'),(2,'Hi everyone!','1512875856','peter'),(5,'It\'s too bad Zach\'s not in this chat','1512875872','peter'),(1,'No, I do not want some funk','1512875943','peter'),(5,'Zach\'s in this chat now!','1512877932','peter'),(5,'Added Zach Rossi to the chat','1512878195','peter'),(5,'Yay!','1512878200','peter'),(5,'http://apple.com','1512879076','peter'),(6,'Created chat','1512881583','peter'),(6,'how are you?','1512881648','peter'),(6,'how are you?','1512881762','peter'),(6,'how are you?','1512881825','peter'),(6,'how are you?','1512881901','peter'),(6,'hello','1512881930','peter'),(6,'how are you?','1512882014','peter'),(6,'hello','1512882081','peter'),(6,'how are you?','1512882125','peter'),(6,'hello','1512882225','peter'),(6,'how are you?','1512882351','peter'),(6,'how are you?','1512882369','peter'),(6,'hello','1512882410','peter'),(6,'hey','1512882450','peter'),(6,'','1512882450','BotRoccoli'),(6,'how are you?','1512882463','peter'),(6,'','1512882463','BotRoccoli'),(6,'hey','1512882553','peter'),(6,'Hello I am BotRoccoli\n','1512882553','BotRoccoli'),(7,'Created chat','1512882604','zach'),(7,'hi','1512882608','zach'),(7,'hello','1512882614','zach'),(7,'Hello I am BotRoccoli\n','1512882614','BotRoccoli'),(7,'!date','1512882618','zach'),(7,'12-10-17\n','1512882618','BotRoccoli'),(7,'!tell me about a whale','1512882632','zach'),(7,'Here\'s what I could find:\nWhales are a widely distributed and diverse group of fully aquatic placental marine mammals. They are an informal grouping within the infraorder Cetacea, usually excluding dolphins and porpoises. Whales, dolphins and porpoises belong to the order Cetartiodactyla with even-toed ungulates and their closest living relatives are the hippopotamuses, having diverged about 40 million years ago. The two parvorders of whales, baleen whales (Mysticeti) and toothed whales (Odontoceti), are thought to have split apart around 34 million years ago. The whales comprise eight extant families: Balaenopteridae (the rorquals), Balaenidae (right whales), Cetotheriidae (the pygmy right whale), Eschrichtiidae (the grey whale), Monodontidae (belugas and narwhals), Physeteridae (the sperm whale), Kogiidae (the dwarf and pygmy sperm whale), and Ziphiidae (the beaked whales).\n','1512882634','BotRoccoli'),(7,'!tell me more','1512882653','zach'),(7,'To find more click on this link\nhttps://en.wikipedia.org/wiki/whale\n','1512882653','BotRoccoli'),(7,'!roll 23','1512882699','zach'),(7,'5\n','1512882699','BotRoccoli'),(7,'Added Zach Rossi to the chat','1512882744','zach'),(7,'Added BotRoccoli to the chat','1512882774','zach'),(7,'!roll 4','1512882791','zach'),(7,'2\n','1512882791','BotRoccoli'),(7,'!tell me about shrek','1512882819','zach'),(7,'Here\'s what I could find:\nShrek is a 2001 American computer-animated fantasy film loosely based on William Steig\'s 1990 fairy tale picture book of the same name and directed by Andrew Adamson and Vicky Jenson in their directorial debut. It stars the voices of Mike Myers, Eddie Murphy, Cameron Diaz, and John Lithgow, and somewhat serves as a parody of other films adapted from numerous fairy tales, mainly animated Disney films.\n','1512882820','BotRoccoli'),(7,'!tell me about gay','1512883067','zach'),(7,'!tell me about peter','1512883082','zach'),(7,'Here\'s what I could find:\nPeter may refer to:\n','1512883083','BotRoccoli'),(7,'!tell me about a pickle','1512883105','zach'),(7,'Here\'s what I could find:\nPickle may refer to:\n','1512883107','BotRoccoli'),(7,'Pickle is your tiny dick','1512883123','BotRoccoli'),(7,'how are you?','1512883174','zach'),(7,'Sorry I can not anwser that question as robots like me do not have feelings.\n','1512883174','BotRoccoli'),(7,'But I hate you','1512883179','BotRoccoli'),(7,'!tell me about a homosexual','1512883298','BotRoccoli'),(7,'Sorry I could not find information on that.\n','1512883299','BotRoccoli'),(7,'!tell me about a zygote','1512883334','zach'),(7,'!tell me about a zebra','1512883365','zach'),(7,'Here\'s what I could find:\nZebras ( ZEB-rÉ™ or  ZEE-brÉ™) are several species of African equids (horse family) united by their distinctive black and white striped coats. Their stripes come in different patterns, unique to each individual. They are generally social animals that live in small harems to large herds. Unlike their closest relatives, horses and donkeys, zebras have never been truly domesticated.\n','1512883366','BotRoccoli'),(7,'!tell me about 50 shades of gray','1512883396','zach'),(7,'Sorry I could not find information on that.\n','1512883396','BotRoccoli'),(7,'hey','1512883452','zach'),(7,'Hello I am BotRoccoli\n','1512883453','BotRoccoli'),(6,'tell me about dracula','1512883661','peter'),(1,'ye','1512883716','zach'),(1,'Ye!','1512883724','peter'),(1,'Can I get a yip in the chat?','1512883742','zach'),(1,'yip','1512883749','zach'),(1,'yip','1512883757','peter'),(1,'Added  to the chat','1512883766','zach'),(8,'Created chat','1512883772','peter'),(8,'To learn how to use BotRoccoli, type \"!help\"','1512883772','BotRoccoli'),(8,'Now we\'re all together!','1512883783','peter'),(8,'!roll 3','1512883802','zach'),(8,'2\n','1512883802','BotRoccoli'),(8,'!help','1512883811','zach'),(8,'\nhi\ntell a joke\nwho are you?\nroll a die\nhow are you?\ntell me about [insert topic] and tell me more (after you ask about a topic)\nroll [number of sides of die]\n','1512883811','BotRoccoli'),(8,'how are you?','1512883812','peter'),(8,'Sorry I can not anwser that question as robots like me do not have feelings.\n','1512883812','BotRoccoli'),(9,'Created chat','1512883857','peter'),(9,'Psst','1512883862','peter'),(9,'I have a secret','1512883865','peter'),(9,'Do you see this?','1512883873','peter'),(9,'ZACH!','1512883876','peter'),(9,'autobots','1512883897','zach'),(10,'Created chat','1512883911','zach'),(11,'Created chat','1512883917','peter'),(11,'Yo, soccer','1512883922','peter'),(11,'Am I right?','1512883926','peter'),(12,'Created chat','1512883928','zach'),(12,'To learn how to use BotRoccoli, type \"!help\"','1512883928','BotRoccoli'),(13,'Created chat','1512883931','zach'),(13,'To learn how to use BotRoccoli, type \"!help\"','1512883931','BotRoccoli'),(11,'Pretty dope stuff','1512883933','peter'),(1,'Long chat right','1512885605','peter'),(1,'Hey!','1512885614','peter'),(1,'Yea','1512885652','peter');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-10  2:20:26
