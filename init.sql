-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2022 at 05:09 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `flask_forum`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(10) NOT NULL,
  `body` varchar(500) DEFAULT NULL,
  `FK_post_id` int(11) DEFAULT NULL,
  `FK_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `name` varchar(21) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `introduction`
--

CREATE TABLE `introduction` (
  `title` varchar(255) NOT NULL,
  `body` varchar(255) DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `id` int(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `introduction`
--

INSERT INTO `introduction` (`title`, `body`, `users_id`, `id`) VALUES
('intro 1', 'intro1', 1, 1),
('test1', 'test1', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(30) DEFAULT NULL,
  `body` varchar(1000) DEFAULT NULL,
  `likes` int(255) DEFAULT NULL,
  `comments` int(255) DEFAULT NULL,
  `username` varchar(16) NOT NULL,
  `users_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `body`, `likes`, `comments`, `username`, `users_id`) VALUES
(8, 'Anime & Manga\n', 'sadasda', NULL, NULL, 'admin2', 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  `user_password` varchar(1000) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `user_password`, `age`, `email`) VALUES
(1, 'admin', 'admin', 20, 'admin@gmail.com'),
(2, 'admin2', 'admin2', 20, 'admin@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `introduction`
--
ALTER TABLE `introduction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`users_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `FK_users_id` (`users_id`) USING BTREE,
  ADD KEY `username` (`username`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `username` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `introduction`
--
ALTER TABLE `introduction`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `introduction`
--
ALTER TABLE `introduction`
  ADD CONSTRAINT `introduction_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`username`) REFERENCES `users` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;
