-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 19, 2026 at 01:51 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fitplanner`
--
CREATE DATABASE IF NOT EXISTS `fitplanner` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `fitplanner`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'Chest', 'Exercises targeting the chest muscles'),
(2, 'Back', 'Exercises targeting the back muscles'),
(3, 'Legs', 'Exercises targeting the leg muscles'),
(4, 'Shoulders', 'Exercises targeting the shoulder muscles'),
(5, 'Arms', 'Exercises targeting biceps and triceps'),
(6, 'Core', 'Exercises targeting the abdominal and core muscles'),
(7, 'Cardio', 'Cardiovascular and endurance exercises'),
(8, 'Full Body', 'Exercises targeting multiple muscle groups');

-- --------------------------------------------------------

--
-- Table structure for table `exercises`
--

DROP TABLE IF EXISTS `exercises`;
CREATE TABLE `exercises` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `difficulty` enum('Beginner','Intermediate','Advanced') DEFAULT NULL,
  `description` text DEFAULT NULL,
  `equipment` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exercises`
--

INSERT INTO `exercises` (`id`, `user_id`, `name`, `difficulty`, `description`, `equipment`, `created_at`, `category_id`) VALUES
(41, 6, 'Bench Press', 'Intermediate', 'Classic chest exercise using a barbell', 'Barbell', '2026-03-19 08:53:53', 1),
(42, 6, 'Push Up', 'Beginner', 'Bodyweight chest exercise', 'No equipment', '2026-03-19 08:53:53', 1),
(43, 6, 'Incline Dumbbell Press', 'Intermediate', 'Targets upper chest', 'Dumbbells', '2026-03-19 08:53:53', 1),
(44, 6, 'Cable Fly', 'Intermediate', 'Isolation exercise for chest', 'Cable Machine', '2026-03-19 08:53:53', 1),
(45, 6, 'Dips', 'Advanced', 'Bodyweight exercise targeting chest and triceps', 'Dip Bar', '2026-03-19 08:53:53', 1),
(46, 6, 'Pull Up', 'Advanced', 'Bodyweight back exercise', 'Pull Up Bar', '2026-03-19 08:53:53', 2),
(47, 6, 'Deadlift', 'Advanced', 'Full back compound movement', 'Barbell', '2026-03-19 08:53:53', 2),
(48, 6, 'Bent Over Row', 'Intermediate', 'Targets middle back', 'Barbell', '2026-03-19 08:53:53', 2),
(49, 6, 'Lat Pulldown', 'Beginner', 'Machine exercise for lats', 'Cable Machine', '2026-03-19 08:53:53', 2),
(50, 6, 'Seated Cable Row', 'Beginner', 'Targets middle and lower back', 'Cable Machine', '2026-03-19 08:53:53', 2),
(51, 6, 'Squat', 'Intermediate', 'Fundamental leg exercise', 'Barbell', '2026-03-19 08:53:53', 3),
(52, 6, 'Leg Press', 'Beginner', 'Machine based leg exercise', 'Leg Press Machine', '2026-03-19 08:53:53', 3),
(53, 6, 'Lunges', 'Beginner', 'Targets quads and glutes', 'Dumbbells', '2026-03-19 08:53:53', 3),
(54, 6, 'Romanian Deadlift', 'Intermediate', 'Targets hamstrings and glutes', 'Barbell', '2026-03-19 08:53:53', 3),
(55, 6, 'Calf Raises', 'Beginner', 'Isolation exercise for calves', 'No equipment', '2026-03-19 08:53:53', 3),
(56, 6, 'Overhead Press', 'Intermediate', 'Compound shoulder exercise', 'Barbell', '2026-03-19 08:53:53', 4),
(57, 6, 'Lateral Raise', 'Beginner', 'Targets side deltoids', 'Dumbbells', '2026-03-19 08:53:53', 4),
(58, 6, 'Front Raise', 'Beginner', 'Targets front deltoids', 'Dumbbells', '2026-03-19 08:53:53', 4),
(59, 6, 'Arnold Press', 'Intermediate', 'Full shoulder exercise', 'Dumbbells', '2026-03-19 08:53:53', 4),
(60, 6, 'Face Pull', 'Beginner', 'Targets rear deltoids', 'Cable Machine', '2026-03-19 08:53:53', 4),
(61, 6, 'Bicep Curl', 'Beginner', 'Classic bicep isolation exercise', 'Dumbbells', '2026-03-19 08:53:53', 5),
(62, 6, 'Tricep Pushdown', 'Beginner', 'Cable exercise for triceps', 'Cable Machine', '2026-03-19 08:53:53', 5),
(63, 6, 'Hammer Curl', 'Beginner', 'Targets biceps and forearms', 'Dumbbells', '2026-03-19 08:53:53', 5),
(64, 6, 'Skull Crushers', 'Intermediate', 'Barbell tricep exercise', 'Barbell', '2026-03-19 08:53:53', 5),
(65, 6, 'Concentration Curl', 'Intermediate', 'Isolation bicep exercise', 'Dumbbells', '2026-03-19 08:53:53', 5),
(66, 6, 'Plank', 'Beginner', 'Static core stability exercise', 'No equipment', '2026-03-19 08:53:53', 6),
(67, 6, 'Crunches', 'Beginner', 'Basic abdominal exercise', 'No equipment', '2026-03-19 08:53:53', 6),
(68, 6, 'Russian Twist', 'Intermediate', 'Rotational core exercise', 'No equipment', '2026-03-19 08:53:53', 6),
(69, 6, 'Leg Raises', 'Intermediate', 'Targets lower abs', 'No equipment', '2026-03-19 08:53:53', 6),
(70, 6, 'Ab Wheel Rollout', 'Advanced', 'Advanced core stability exercise', 'Ab Wheel', '2026-03-19 08:53:53', 6),
(71, 6, 'Running', 'Beginner', 'Basic cardio exercise', 'No equipment', '2026-03-19 08:53:53', 7),
(72, 6, 'Jump Rope', 'Beginner', 'High intensity cardio', 'Jump Rope', '2026-03-19 08:53:53', 7),
(73, 6, 'Burpees', 'Intermediate', 'Full body cardio exercise', 'No equipment', '2026-03-19 08:53:53', 7),
(74, 6, 'Cycling', 'Beginner', 'Low impact cardio', 'Bike', '2026-03-19 08:53:53', 7),
(75, 6, 'Box Jumps', 'Advanced', 'Explosive cardio exercise', 'Box', '2026-03-19 08:53:53', 7),
(76, 6, 'Kettlebell Swing', 'Intermediate', 'Full body explosive movement', 'Kettlebell', '2026-03-19 08:53:53', 8),
(77, 6, 'Thruster', 'Advanced', 'Squat to press combination', 'Barbell', '2026-03-19 08:53:53', 8),
(78, 6, 'Mountain Climbers', 'Beginner', 'Full body cardio movement', 'No equipment', '2026-03-19 08:53:53', 8),
(79, 6, 'Clean and Press', 'Advanced', 'Olympic full body movement', 'Barbell', '2026-03-19 08:53:53', 8),
(80, 6, 'Battle Ropes', 'Intermediate', 'Full body conditioning exercise', 'Battle Ropes', '2026-03-19 08:53:53', 8);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password`, `created_at`) VALUES
(6, 'hamma', 'hamma.yahia.31.05@gmail.com', '123', '2026-03-17 15:29:21'),
(7, 'youssef', 'youssef.yahia.31.05@gmail.com', '123', '2026-03-17 15:30:13'),
(8, 'mohamed', 'mohamed.yahia.31.05@gmail.com', '123', '2026-03-18 14:49:36'),
(10, '7amadi', 'adsda@gmail.com', '$2y$10$eBuAUYAqxTym2BdgmHcWW.002qc3k/hslUjbGN3lX6Q0o2vpP0sqO', '2026-03-19 08:56:37'),
(11, 'anan', 'adsddsda@gmail.com', '$2y$10$P2O2tV1WI68JvkUch2B4PuDwADGIZhpq2fKwjbPwxfZH1b7qFF2Zq', '2026-03-19 11:34:25');

-- --------------------------------------------------------

--
-- Table structure for table `workouts`
--

DROP TABLE IF EXISTS `workouts`;
CREATE TABLE `workouts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `goal` varchar(100) DEFAULT NULL,
  `generated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `saved` tinyint(1) DEFAULT 0,
  `name` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `workouts`
--

INSERT INTO `workouts` (`id`, `user_id`, `goal`, `generated_at`, `saved`, `name`) VALUES
(4, 6, 'Weight Loss', '2026-03-19 09:01:12', 0, NULL),
(5, 6, 'Muscle Gain', '2026-03-19 09:01:34', 0, NULL),
(6, 6, 'Muscle Gain', '2026-03-19 09:01:51', 0, NULL),
(7, 6, 'Muscle Gain', '2026-03-19 09:07:32', 0, NULL),
(8, 6, 'Muscle Gain', '2026-03-19 09:13:42', 0, NULL),
(9, 6, 'General Fitness', '2026-03-19 09:14:28', 0, NULL),
(10, 6, 'Muscle Gain', '2026-03-19 09:14:41', 0, NULL),
(11, 6, 'Muscle Gain', '2026-03-19 09:14:53', 0, NULL),
(12, 6, 'Weight Loss', '2026-03-19 09:14:59', 0, NULL),
(13, 6, 'Weight Loss', '2026-03-19 09:15:14', 0, NULL),
(14, 6, 'Maintain Weight', '2026-03-19 09:18:48', 0, NULL),
(15, 6, 'Muscle Gain', '2026-03-19 09:28:09', 0, NULL),
(16, 6, 'Weight Loss', '2026-03-19 09:28:30', 0, NULL),
(17, 6, 'Maintain Weight', '2026-03-19 09:28:40', 0, NULL),
(18, 6, 'Weight Loss', '2026-03-19 09:33:52', 0, NULL),
(19, 6, 'Muscle Gain', '2026-03-19 09:34:10', 0, NULL),
(20, 6, 'Muscle Gain', '2026-03-19 09:34:24', 0, NULL),
(21, 6, 'Muscle Gain', '2026-03-19 09:39:42', 0, NULL),
(22, 6, 'Weight Loss', '2026-03-19 09:41:18', 0, NULL),
(23, 6, 'Weight Loss', '2026-03-19 09:45:01', 0, NULL),
(24, 6, 'Weight Loss', '2026-03-19 09:45:09', 0, NULL),
(25, 6, 'Weight Loss', '2026-03-19 09:48:32', 0, NULL),
(26, 6, 'Weight Loss', '2026-03-19 09:48:41', 0, NULL),
(27, 6, 'Muscle Gain', '2026-03-19 09:57:19', 0, NULL),
(28, 6, 'Muscle Gain', '2026-03-19 09:57:30', 0, NULL),
(29, 6, 'Muscle Gain', '2026-03-19 10:02:08', 0, NULL),
(30, 6, 'Weight Loss', '2026-03-19 10:09:04', 0, NULL),
(31, 6, 'Muscle Gain', '2026-03-19 10:09:54', 0, NULL),
(32, 6, 'Weight Loss', '2026-03-19 10:20:01', 0, NULL),
(33, 6, 'Weight Loss', '2026-03-19 10:21:02', 0, NULL),
(34, 6, 'Muscle Gain', '2026-03-19 10:23:09', 0, NULL),
(35, 6, 'Weight Loss', '2026-03-19 10:23:23', 0, NULL),
(36, 6, 'Weight Loss', '2026-03-19 11:10:12', 0, NULL),
(37, 6, 'Muscle Gain', '2026-03-19 11:46:58', 0, NULL),
(38, 6, 'Weight Loss', '2026-03-19 11:47:41', 0, NULL),
(39, 6, 'Weight Loss', '2026-03-19 11:51:02', 0, NULL),
(40, 6, 'Weight Loss', '2026-03-19 11:53:58', 0, NULL),
(41, 6, 'Weight Loss', '2026-03-19 11:54:14', 0, NULL),
(42, 6, 'Weight Loss', '2026-03-19 11:54:27', 0, NULL),
(43, 6, 'Weight Loss', '2026-03-19 11:56:26', 0, NULL),
(44, 6, 'Weight Loss', '2026-03-19 11:58:40', 0, NULL),
(45, 6, 'Weight Loss', '2026-03-19 11:59:46', 0, NULL),
(46, 10, 'Weight Loss', '2026-03-19 12:02:45', 1, 'ds'),
(47, 10, 'Weight Loss', '2026-03-19 12:04:25', 0, NULL),
(48, 10, 'Weight Loss', '2026-03-19 12:11:49', 1, 'dsd'),
(49, 10, 'Weight Loss', '2026-03-19 12:16:27', 0, NULL),
(50, 10, 'Muscle Gain', '2026-03-19 12:26:52', 1, 'saasadada'),
(51, 10, 'Muscle Gain', '2026-03-19 12:27:09', 0, NULL),
(52, 11, 'Weight Loss', '2026-03-19 12:28:06', 1, 'dsada'),
(53, 10, 'Weight Loss', '2026-03-19 12:47:05', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `workout_exercises`
--

DROP TABLE IF EXISTS `workout_exercises`;
CREATE TABLE `workout_exercises` (
  `id` int(11) NOT NULL,
  `workout_id` int(11) NOT NULL,
  `exercise_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `workout_exercises`
--

INSERT INTO `workout_exercises` (`id`, `workout_id`, `exercise_id`) VALUES
(1, 4, 80),
(2, 4, 72),
(3, 4, 75),
(4, 4, 68),
(5, 4, 74),
(6, 4, 76),
(7, 5, 44),
(8, 5, 60),
(9, 5, 56),
(10, 5, 55),
(11, 5, 47),
(12, 5, 50),
(13, 6, 62),
(14, 6, 49),
(15, 6, 47),
(16, 6, 41),
(17, 6, 42),
(18, 6, 57),
(19, 7, 42),
(20, 7, 57),
(21, 7, 65),
(22, 7, 43),
(23, 7, 60),
(24, 7, 53),
(25, 8, 42),
(26, 8, 49),
(27, 8, 53),
(28, 8, 57),
(29, 8, 62),
(30, 9, 75),
(31, 9, 70),
(32, 9, 45),
(33, 10, 42),
(34, 10, 49),
(35, 10, 53),
(36, 10, 60),
(37, 10, 62),
(38, 11, 42),
(39, 11, 50),
(40, 11, 55),
(41, 11, 58),
(42, 11, 63),
(43, 12, 75),
(44, 12, 70),
(45, 12, 77),
(46, 13, 71),
(47, 13, 67),
(48, 13, 78),
(49, 14, 75),
(50, 14, 70),
(51, 14, 45),
(52, 15, 41),
(53, 15, 48),
(54, 15, 54),
(55, 15, 56),
(56, 15, 64),
(57, 16, 74),
(58, 16, 67),
(59, 16, 78),
(60, 17, 73),
(61, 17, 68),
(62, 17, 43),
(63, 17, 51),
(64, 18, 74),
(65, 18, 66),
(66, 18, 78),
(67, 19, 45),
(68, 19, 47),
(69, 20, 44),
(70, 20, 48),
(71, 20, 51),
(72, 20, 59),
(73, 20, 64),
(74, 21, 45),
(75, 21, 46),
(76, 22, 72),
(77, 22, 66),
(78, 22, 78),
(79, 23, 71),
(80, 23, 66),
(81, 23, 78),
(82, 24, 72),
(83, 24, 67),
(84, 24, 78),
(85, 25, 71),
(86, 25, 67),
(87, 25, 78),
(88, 26, 71),
(89, 26, 66),
(90, 26, 78),
(91, 27, 42),
(92, 27, 49),
(93, 27, 53),
(94, 27, 60),
(95, 27, 63),
(96, 28, 45),
(97, 28, 46),
(98, 29, 44),
(99, 29, 48),
(100, 29, 51),
(101, 29, 56),
(102, 29, 64),
(103, 30, 71),
(104, 30, 67),
(105, 30, 78),
(106, 31, 44),
(107, 31, 48),
(108, 31, 54),
(109, 31, 56),
(110, 31, 64),
(111, 32, 72),
(112, 32, 67),
(113, 32, 78),
(114, 33, 72),
(115, 33, 67),
(116, 33, 78),
(117, 34, 43),
(118, 34, 48),
(119, 34, 54),
(120, 34, 59),
(121, 34, 65),
(122, 35, 73),
(123, 35, 69),
(124, 35, 76),
(125, 36, 74),
(126, 36, 66),
(127, 36, 78),
(128, 37, 44),
(129, 37, 48),
(130, 37, 54),
(131, 37, 56),
(132, 37, 65),
(133, 38, 71),
(134, 38, 67),
(135, 38, 78),
(136, 39, 71),
(137, 39, 67),
(138, 39, 78),
(139, 40, 71),
(140, 40, 67),
(141, 40, 78),
(142, 41, 71),
(143, 41, 67),
(144, 41, 78),
(145, 42, 72),
(146, 42, 67),
(147, 42, 78),
(148, 43, 74),
(149, 43, 67),
(150, 43, 78),
(151, 44, 74),
(152, 44, 66),
(153, 44, 78),
(154, 45, 74),
(155, 45, 66),
(156, 45, 78),
(157, 46, 72),
(158, 46, 67),
(159, 46, 78),
(160, 47, 71),
(161, 47, 67),
(162, 47, 78),
(163, 48, 74),
(164, 48, 66),
(165, 48, 78),
(166, 49, 72),
(167, 49, 67),
(168, 49, 78),
(169, 50, 43),
(170, 50, 48),
(171, 50, 51),
(172, 50, 56),
(173, 50, 65),
(174, 51, 44),
(175, 51, 48),
(176, 51, 54),
(177, 51, 56),
(178, 51, 65),
(179, 52, 72),
(180, 52, 67),
(181, 52, 78),
(182, 53, 72),
(183, 53, 66),
(184, 53, 78);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exercises`
--
ALTER TABLE `exercises`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `workouts`
--
ALTER TABLE `workouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `workout_exercises`
--
ALTER TABLE `workout_exercises`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workout_id` (`workout_id`),
  ADD KEY `exercise_id` (`exercise_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `exercises`
--
ALTER TABLE `exercises`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `workouts`
--
ALTER TABLE `workouts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `workout_exercises`
--
ALTER TABLE `workout_exercises`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=185;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exercises`
--
ALTER TABLE `exercises`
  ADD CONSTRAINT `exercises_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exercises_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `workouts`
--
ALTER TABLE `workouts`
  ADD CONSTRAINT `workouts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `workout_exercises`
--
ALTER TABLE `workout_exercises`
  ADD CONSTRAINT `workout_exercises_ibfk_1` FOREIGN KEY (`workout_id`) REFERENCES `workouts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `workout_exercises_ibfk_2` FOREIGN KEY (`exercise_id`) REFERENCES `exercises` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
