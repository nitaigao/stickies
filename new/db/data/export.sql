/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "columns" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "wall_id" int(11) DEFAULT NULL,
  "title" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO "columns" VALUES (1,2,'Ideas'),(2,2,'Features'),(3,2,'In Progress'),(4,2,'Inventory'),(5,2,'Done'),(6,3,'Ideas'),(7,3,'Backlog'),(8,3,'In Progress'),(9,3,'Inventory'),(10,3,'Live'),(11,4,'Ideas'),(12,4,'Backlog'),(13,4,'In Progress'),(14,4,'Inventory'),(15,4,'Live'),(16,6,'Backlog'),(17,6,'In Progress'),(18,6,'Done'),(19,7,'Backlog'),(20,7,'In Progress'),(21,7,'Done'),(22,8,'Backlog'),(23,8,'Done'),(24,9,'Ideas'),(25,9,'Backlog'),(26,9,'In Progress'),(27,9,'Inventory'),(28,9,'Live'),(29,9,'Live'),(30,10,'Ideas'),(31,10,'Backlog'),(32,10,'In-Progress'),(33,10,'Inventory'),(34,10,'Completed'),(35,11,'Maybe?'),(36,11,'In Progress'),(37,11,'Done'),(38,12,'Ideas'),(39,12,'Backlog'),(40,12,'In Progress'),(41,12,'Done'),(42,12,'Live'),(43,13,'Backlog'),(44,13,'Ready'),(45,13,'In progress'),(46,14,'Ideas'),(47,14,'Backlog'),(48,14,'In Progress'),(49,14,'Inventory'),(50,14,'Live');
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "schema_info" (
  "version" int(11) NOT NULL DEFAULT '0'
);
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO "schema_info" VALUES (1);
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "stories" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "column_id" int(11) DEFAULT NULL,
  "title" varchar(255) DEFAULT NULL,
  "index" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO "stories" VALUES (1,1,'As a User\r\nI want to have an AJAX New Story experience\r\nSo That I dont have to leave the Wall page','1'),(2,4,'As a User I want to be able to delete a project','0'),(3,1,'As a User\r\nI want a good design\r\nSo that I may enjoy the experience better','3'),(4,5,'As a User \r\nI Want a Common Style Throughout StoryHub\r\nSo That I can have  a good user experience','1'),(5,5,'As a Wall owner\r\nI want my walls to be private\r\nSo That I may keep my information Safe','2'),(6,5,'As a Wall Owner\r\nI want to be able to assign people to my private walls\r\nSo That they may contribute to them','3'),(7,6,'Retro Mode / FX Mode','1'),(8,6,'AI Difficulty','2'),(9,7,'Correct Stuttering due to UI Overlay','1'),(10,10,'Basic 2 Player Game','1'),(11,10,'AI Player','2'),(12,10,'Single Player / Multiplayer Menu','3'),(13,10,'Sounds','4'),(14,10,'Work out ball stuttering','5'),(15,10,'Bitmap Fonts','6'),(16,10,'App store description','7'),(17,10,'Decent name','8'),(18,10,'Submit to the App Store','9'),(19,10,'Polish','10'),(20,10,'Fix touch events','11'),(21,15,'Closest on Map','1'),(22,15,'List view sorted by closest','2'),(23,15,'Initial GPS Position','3'),(24,15,'Splash Screen','4'),(25,15,'Performance Tuning','5'),(26,15,'Fix Leaks','6'),(27,15,'Perform Annotation Select *after* list view flip is complete','7'),(28,15,'Get contracts sorted','8'),(29,15,'Distribute App','9'),(30,15,'Create app description','10'),(31,16,'Pay Personal Tax','1'),(32,16,'Sell the Car','0'),(33,16,'Pay off Alienware','3'),(34,16,'Pay of Virgin Card','4'),(35,16,'Organise regular payment of Cahoot','5'),(36,16,'Put car on autotrader','6'),(37,16,'Learn cartoon drawing','7'),(38,16,'Learn game design','8'),(39,16,'Book Rubys wedding holiday','9'),(40,17,'Fixup car','1'),(41,17,'Pay in recent cheques','2'),(42,18,'Inform Accountants about company Closure','0'),(43,18,'Pay Corporation Tax','2'),(44,18,'Issue p45 for uSwitch','3'),(45,18,'Final Dividend to move','4'),(46,18,'Open Joint Bank Account','5'),(47,18,'Buy Car Stuff','6'),(48,18,'Landlord Reference','7'),(49,18,'Pay in latest cheque','8'),(50,18,'Complete contracts for uSwitch','9'),(51,18,'Get National Insurance Number','10'),(52,18,'Rent a VPS.net server','11'),(53,18,'Organise a van rental','12'),(54,18,'Buy The Art of Game Design Book','13'),(55,18,'Buy The Art of Game Design Lens Cards','14'),(56,18,'Request Holiday from work','15'),(57,18,'Inform Hamptons of new bank acount number','16'),(58,18,'Send spreadsheet  to SJD','17'),(59,18,'Pay VAT','18'),(60,18,'Pay Companies House Fine','19'),(61,18,'Send P11D to SJD','20'),(62,18,'Book Malaysia Holiday with work','21'),(63,18,'Call Virgin about cable modem','22'),(64,18,'Pay PAYE','23'),(65,19,'Buy a TV stand','1'),(66,19,'Buy a rug','2'),(67,19,'Buy saucepans','3'),(68,19,'Buy glasses','4'),(69,19,'Buy a desk','5'),(70,20,'Sort out bikes','1'),(71,21,'Get internet sorted','1'),(72,21,'Buy Cutlery','2'),(73,23,'my ticket!','1'),(74,24,'StoryHub','1'),(75,25,'Blog','1'),(76,25,'Homepage','2'),(77,25,'Portfolio','3'),(78,25,'CV','4'),(79,25,'Social Networking Links','5'),(80,27,'Placeholder homepage','1'),(81,30,'Linked In, logo and description','1'),(82,30,'Facebook, logo and description','2'),(83,30,'Twitter, logo and description','3'),(84,35,'A little test','1'),(85,38,'Come up with a theme','1'),(86,38,'Demo minor gameplay and get feedback','2'),(87,40,'Abstract prototype with Balloons to demonstrate minor gameplay','1'),(88,40,'Abstract prototype with Balls to demonstrate minor gameplay','2'),(89,43,'To be orsum\r\n','1'),(90,44,'asdfasdfasf','1'),(91,47,'Column View - Display Column 1 Stories','1'),(92,47,'Admin - Add Extra Columns','2'),(93,47,'Columns - Navigate between Columns','3'),(94,48,'Add Screen - Save title and description to database','1'),(95,49,'Add Screen - Description edit page','1');
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "users" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "open_id" varchar(255) DEFAULT NULL,
  "nickname" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO "users" VALUES (1,'http://nkostelnik.myopenid.com/','Nick');
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "users_walls" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "user_id" int(11) DEFAULT NULL,
  "wall_id" int(11) DEFAULT NULL,
  PRIMARY KEY ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO "users_walls" VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14);
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "walls" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "name" varchar(255) DEFAULT NULL,
  "wall_type" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO "walls" VALUES (2,'Story Hub',NULL),(3,'PaddleFX',NULL),(4,'Coffee Map',NULL),(6,'Life',NULL),(7,'Flat',NULL),(9,'Website',NULL),(10,'Community',NULL),(12,'New Game',NULL),(14,'Mobile Wall',NULL);
