-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: questionario_bem_estar
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `componente_questionario`
--

DROP TABLE IF EXISTS `componente_questionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `componente_questionario` (
  `id_questionario` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `descricao` text,
  PRIMARY KEY (`id_questionario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `componente_questionario`
--

LOCK TABLES `componente_questionario` WRITE;
/*!40000 ALTER TABLE `componente_questionario` DISABLE KEYS */;
INSERT INTO `componente_questionario` VALUES (1,'Alimentação','Hábitos alimentares e qualidade da alimentação.'),(2,'Atividade Física','Prática de exercícios e atividades físicas.'),(3,'Comportamento Preventivo','Cuidados preventivos com a saúde.'),(4,'Relacionamentos','Relacionamentos interpessoais e participação social.'),(5,'Controle do Estresse','Hábitos relacionados ao controle do estresse.');
/*!40000 ALTER TABLE `componente_questionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcoes_resposta`
--

DROP TABLE IF EXISTS `opcoes_resposta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opcoes_resposta` (
  `id_opcao` int NOT NULL AUTO_INCREMENT,
  `texto_opcao` varchar(200) NOT NULL,
  `id_pergunta` int NOT NULL,
  PRIMARY KEY (`id_opcao`),
  UNIQUE KEY `uq_opcao_pergunta` (`id_opcao`,`id_pergunta`),
  KEY `id_pergunta` (`id_pergunta`),
  CONSTRAINT `opcoes_resposta_ibfk_1` FOREIGN KEY (`id_pergunta`) REFERENCES `perguntas` (`id_pergunta`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcoes_resposta`
--

LOCK TABLES `opcoes_resposta` WRITE;
/*!40000 ALTER TABLE `opcoes_resposta` DISABLE KEYS */;
INSERT INTO `opcoes_resposta` VALUES (1,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',1),(2,'[2] Quase sempre verdadeiro no seu comportamento',1),(3,'[1] Às vezes corresponde ao seu comportamento',1),(4,'[0] Absolutamente não faz parte do seu estilo de vida',1),(5,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',2),(6,'[2] Quase sempre verdadeiro no seu comportamento',2),(7,'[1] Às vezes corresponde ao seu comportamento',2),(8,'[0] Absolutamente não faz parte do seu estilo de vida',2),(9,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',3),(10,'[2] Quase sempre verdadeiro no seu comportamento',3),(11,'[1] Às vezes corresponde ao seu comportamento',3),(12,'[0] Absolutamente não faz parte do seu estilo de vida',3),(13,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',4),(14,'[2] Quase sempre verdadeiro no seu comportamento',4),(15,'[1] Às vezes corresponde ao seu comportamento',4),(16,'[0] Absolutamente não faz parte do seu estilo de vida',4),(17,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',5),(18,'[2] Quase sempre verdadeiro no seu comportamento',5),(19,'[1] Às vezes corresponde ao seu comportamento',5),(20,'[0] Absolutamente não faz parte do seu estilo de vida',5),(21,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',6),(22,'[2] Quase sempre verdadeiro no seu comportamento',6),(23,'[1] Às vezes corresponde ao seu comportamento',6),(24,'[0] Absolutamente não faz parte do seu estilo de vida',6),(25,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',7),(26,'[2] Quase sempre verdadeiro no seu comportamento',7),(27,'[1] Às vezes corresponde ao seu comportamento',7),(28,'[0] Absolutamente não faz parte do seu estilo de vida',7),(29,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',8),(30,'[2] Quase sempre verdadeiro no seu comportamento',8),(31,'[1] Às vezes corresponde ao seu comportamento',8),(32,'[0] Absolutamente não faz parte do seu estilo de vida',8),(33,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',9),(34,'[2] Quase sempre verdadeiro no seu comportamento',9),(35,'[1] Às vezes corresponde ao seu comportamento',9),(36,'[0] Absolutamente não faz parte do seu estilo de vida',9),(37,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',10),(38,'[2] Quase sempre verdadeiro no seu comportamento',10),(39,'[1] Às vezes corresponde ao seu comportamento',10),(40,'[0] Absolutamente não faz parte do seu estilo de vida',10),(41,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',11),(42,'[2] Quase sempre verdadeiro no seu comportamento',11),(43,'[1] Às vezes corresponde ao seu comportamento',11),(44,'[0] Absolutamente não faz parte do seu estilo de vida',11),(45,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',12),(46,'[2] Quase sempre verdadeiro no seu comportamento',12),(47,'[1] Às vezes corresponde ao seu comportamento',12),(48,'[0] Absolutamente não faz parte do seu estilo de vida',12),(49,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',13),(50,'[2] Quase sempre verdadeiro no seu comportamento',13),(51,'[1] Às vezes corresponde ao seu comportamento',13),(52,'[0] Absolutamente não faz parte do seu estilo de vida',13),(53,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',14),(54,'[2] Quase sempre verdadeiro no seu comportamento',14),(55,'[1] Às vezes corresponde ao seu comportamento',14),(56,'[0] Absolutamente não faz parte do seu estilo de vida',14),(57,'[3] A afirmação é sempre verdadeira no seu dia a dia; faz parte do seu estilo de vida',15),(58,'[2] Quase sempre verdadeiro no seu comportamento',15),(59,'[1] Às vezes corresponde ao seu comportamento',15),(60,'[0] Absolutamente não faz parte do seu estilo de vida',15);
/*!40000 ALTER TABLE `opcoes_resposta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perguntas`
--

DROP TABLE IF EXISTS `perguntas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perguntas` (
  `id_pergunta` int NOT NULL AUTO_INCREMENT,
  `texto_pergunta` text NOT NULL,
  `id_questionario` int NOT NULL,
  PRIMARY KEY (`id_pergunta`),
  KEY `id_questionario` (`id_questionario`),
  CONSTRAINT `perguntas_ibfk_1` FOREIGN KEY (`id_questionario`) REFERENCES `componente_questionario` (`id_questionario`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perguntas`
--

LOCK TABLES `perguntas` WRITE;
/*!40000 ALTER TABLE `perguntas` DISABLE KEYS */;
INSERT INTO `perguntas` VALUES (1,'Sua alimentação diária inclui pelo menos 5 porções de frutas e hortaliças?',1),(2,'Você evita ingerir alimentos gordurosos (carnes gordas, frituras) e doces?',1),(3,'Você faz 4 a 5 refeições variadas ao dia, incluindo um bom café da manhã?',1),(4,'Seu lazer inclui a prática de atividades físicas (exercícios, esportes ou dança)?',2),(5,'Ao menos duas vezes por semana você realiza exercícios que envolvam força e alongamento muscular?',2),(6,'Você caminha ou pedala como meio de deslocamento e, preferencialmente, usa as escadas ao invés do elevador?',2),(7,'Você conhece sua pressão arterial, seus níveis de colesterol e procura controlá-los?',3),(8,'Você se abstém de fumar e ingere álcool com moderação (ou não bebe)?',3),(9,'Você respeita as normas de trânsito (como pedestre, ciclista ou motorista); usa sempre o cinto de segurança e, se dirige, nunca ingere álcool?',3),(10,'Você procura cultivar amigos e está satisfeito com seus relacionamentos?',4),(11,'Seu lazer inclui encontros com amigos, atividades em grupo, participação em associações ou entidades sociais?',4),(12,'Você procura ser ativo em sua comunidade, sentindo-se útil no seu ambiente social?',4),(13,'Você reserva tempo (ao menos 5 minutos) todos os dias para relaxar?',5),(14,'Você mantém uma discussão sem alterar-se, mesmo quando contrariado?',5),(15,'Você equilibra o tempo dedicado ao trabalho com o tempo dedicado ao lazer?',5);
/*!40000 ALTER TABLE `perguntas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resposta_escolhida`
--

DROP TABLE IF EXISTS `resposta_escolhida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resposta_escolhida` (
  `id_resposta` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_pergunta` int NOT NULL,
  `id_opcao` int NOT NULL,
  PRIMARY KEY (`id_resposta`),
  UNIQUE KEY `id_usuario` (`id_usuario`,`id_pergunta`),
  KEY `id_pergunta` (`id_pergunta`),
  KEY `fk_resposta_opcao_pergunta` (`id_opcao`,`id_pergunta`),
  CONSTRAINT `fk_resposta_opcao_pergunta` FOREIGN KEY (`id_opcao`, `id_pergunta`) REFERENCES `opcoes_resposta` (`id_opcao`, `id_pergunta`),
  CONSTRAINT `resposta_escolhida_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `resposta_escolhida_ibfk_2` FOREIGN KEY (`id_pergunta`) REFERENCES `perguntas` (`id_pergunta`),
  CONSTRAINT `resposta_escolhida_ibfk_3` FOREIGN KEY (`id_opcao`) REFERENCES `opcoes_resposta` (`id_opcao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resposta_escolhida`
--

LOCK TABLES `resposta_escolhida` WRITE;
/*!40000 ALTER TABLE `resposta_escolhida` DISABLE KEYS */;
/*!40000 ALTER TABLE `resposta_escolhida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome_completo` varchar(150) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-11 22:18:30
