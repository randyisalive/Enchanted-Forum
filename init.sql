CREATE DATABASE `forum` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
CREATE TABLE `comments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `body` varchar(500) DEFAULT NULL,
  `FK_post_id` int(11) DEFAULT NULL,
  `FK_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`FK_user_id`),
  KEY `FK_post_id` (`FK_post_id`),
  CONSTRAINT `FK_post_id` FOREIGN KEY (`FK_post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`FK_post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`FK_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(21) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) DEFAULT NULL,
  `body` varchar(1000) DEFAULT NULL,
  `likes` int(255) DEFAULT NULL,
  `comments` int(255) DEFAULT NULL,
  `FK_user_Id` int(11) DEFAULT NULL,
  `FK_image_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_id` (`FK_user_Id`),
  KEY `FK_image_id` (`FK_image_id`),
  CONSTRAINT `FK_image_id` FOREIGN KEY (`FK_image_id`) REFERENCES `images` (`id`),
  CONSTRAINT `FK_user_id` FOREIGN KEY (`FK_user_Id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) DEFAULT NULL,
  `user_password` varchar(1000) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

