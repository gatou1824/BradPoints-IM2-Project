-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 23, 2025 at 03:51 PM
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
-- Database: `bradpoints`
--

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `user_id`, `message`, `created_at`, `order_id`, `rating`) VALUES
(1, 2, 'nigger', '2025-07-09 08:52:03', NULL, 5),
(2, 2, 'hellaur\n', '2025-07-09 09:49:41', NULL, 1),
(3, 2, 'hellaurrrr', '2025-07-09 09:51:27', NULL, 3),
(4, 2, 'another feedback', '2025-07-09 09:53:05', NULL, 4),
(5, 4, 'i love lencel <3', '2025-07-09 15:14:01', NULL, 4),
(6, 4, 'i love lencel <3', '2025-07-09 15:14:01', NULL, 4),
(7, 4, 'NIGGER', '2025-07-14 07:08:17', NULL, 2),
(8, 4, 'NIGGER', '2025-07-14 07:08:17', NULL, 1),
(9, 4, 'hellaur', '2025-07-14 07:13:12', NULL, NULL),
(10, 4, 'hellaur', '2025-07-14 07:13:12', NULL, 3),
(11, 4, 'hiii', '2025-07-14 07:14:36', NULL, 5),
(12, 4, 'ermmm', '2025-07-14 07:15:05', NULL, NULL),
(13, 4, 'omkey\n', '2025-07-14 07:39:32', NULL, NULL),
(14, 4, 'hellaur', '2025-07-14 07:48:46', 45, NULL),
(15, 4, 'hella?', '2025-07-14 08:11:23', 39, NULL),
(16, 4, 'haiii', '2025-07-14 08:15:03', 40, NULL),
(17, 4, 'nauuurr', '2025-07-14 08:15:47', 40, NULL),
(18, 4, 'test2', '2025-07-14 08:44:30', 41, NULL),
(19, 4, 'Good', '2025-07-14 10:01:10', 45, NULL),
(20, 4, 'ablajslfdkja', '2025-07-14 10:35:47', 49, NULL),
(21, 4, 'hellaur', '2025-07-14 10:41:02', 50, NULL),
(22, 4, 'ingot', '2025-07-14 10:49:50', 51, NULL),
(23, 4, 'hellaur\n', '2025-07-14 11:01:57', 52, NULL),
(24, 4, 'brehhh', '2025-07-14 11:07:56', 53, NULL),
(25, 4, 'errmm\n', '2025-07-15 06:09:04', 55, NULL),
(26, 4, 'ermm', '2025-07-15 06:10:36', 56, NULL),
(27, 4, 'hellaur', '2025-07-15 06:12:27', 57, NULL),
(28, 4, 'so clean  so good', '2025-07-15 15:50:56', 25, NULL),
(29, 2, 'so clean  so good', '2025-07-15 15:51:56', 25, NULL),
(30, 2, 'so clean  so good', '2025-07-15 15:53:46', 25, NULL),
(31, 4, 'ermmm', '2025-07-16 11:12:06', 61, NULL),
(32, 4, 'good', '2025-07-16 11:12:21', 62, NULL),
(33, 4, 'hellaurrr', '2025-07-17 05:24:42', 102, NULL),
(34, 2, 'super good an', '2025-07-19 16:24:18', 58, NULL),
(35, 2, 'haii', '2025-07-19 16:28:50', 43, NULL),
(36, 2, '5 stars', '2025-07-19 16:33:45', 38, NULL),
(37, 2, '5 stars', '2025-07-19 16:36:26', 25, 5),
(38, 2, 'ts so ahh bruv', '2025-07-19 16:44:47', 24, 2),
(39, 2, 'I love et\n', '2025-07-21 03:00:10', 108, 5),
(40, 2, 'ang sarap talaga mapapawow ka nalang', '2025-07-21 06:56:52', 109, 5),
(41, 10, 'ang sarap mapapwow ka nalang', '2025-07-21 09:25:33', 113, 5);

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `points` int(11) DEFAULT 0,
  `is_available` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`id`, `name`, `price`, `points`, `is_available`, `created_at`, `is_deleted`) VALUES
(1, 'Chicken Rice', 120.00, 10, 0, '2025-07-03 09:33:28', 0),
(2, 'Beef Rice', 150.00, 12, 1, '2025-07-03 09:33:28', 0),
(3, 'Steamed Rice', 100.00, 8, 1, '2025-07-03 09:33:28', 0),
(4, 'Batchoy', 40.00, 2, 1, '2025-07-03 09:33:28', 0),
(5, 'Spring Rolls', 90.00, 7, 1, '2025-07-03 09:33:28', 0),
(6, 'Empress Rolls', 80.00, 6, 1, '2025-07-03 09:33:28', 0),
(7, 'Bacon Rolls', 130.00, 11, 1, '2025-07-03 09:33:28', 0),
(8, 'Pizza Rolls', 25.00, 1, 1, '2025-07-03 09:33:28', 0),
(9, 'Ngohiong', 60.00, 5, 1, '2025-07-03 09:33:28', 0),
(10, 'Sweet and Sour Pork', 100.00, 5, 1, '2025-07-03 09:33:28', 0),
(11, 'Siopao', 0.00, 0, 1, '2025-07-20 12:24:49', 0),
(12, 'Steamed Chicken', 0.00, 0, 1, '2025-07-20 12:24:49', 0),
(13, 'Crab Pincers', 0.00, 0, 1, '2025-07-20 12:24:49', 0),
(14, 'Shrimp Balls', 0.00, 0, 1, '2025-07-20 12:24:49', 0),
(15, 'Chicken Feet', 0.00, 0, 1, '2025-07-20 12:24:49', 0),
(16, 'Fried Wontons', 0.00, 0, 1, '2025-07-20 12:24:49', 0),
(17, 'Siomai', 0.00, 0, 1, '2025-07-20 12:24:49', 0);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `created_at`, `is_read`) VALUES
(1, NULL, 'A new reward \"Free Chiceken Rice\" has been added!', '2025-07-21 14:05:50', 0),
(2, NULL, 'A reward \"undefined\" has been deleted!', '2025-07-21 14:19:06', 0),
(3, NULL, 'A new reward \"Free Chiceken Rice\" has been added!', '2025-07-21 14:20:04', 0),
(4, NULL, 'A new reward \"Free Chiceken Rice\" has been added!', '2025-07-21 14:33:36', 0),
(5, NULL, 'A reward \"Free Chiceken Rice\" has been deleted!', '2025-07-21 14:33:42', 0),
(6, NULL, 'A reward \"Free Ngohionghionghiong\" has been updated!', '2025-07-21 14:36:42', 0),
(7, NULL, 'A new reward \"Free Chicken Rice\" has been added!', '2025-07-21 15:00:38', 0),
(8, NULL, 'A new reward \"something\" has been added!', '2025-07-21 15:03:45', 0),
(9, NULL, 'A reward \"something\" has been deleted!', '2025-07-21 15:05:31', 0),
(10, NULL, 'A new reward \"something\" has been added!', '2025-07-21 17:27:38', 0),
(11, NULL, 'A reward \"Free Empress Rolls\" has been updated!', '2025-07-21 17:27:56', 0),
(12, NULL, 'A food \"Chicken Rice\" has been updated!', '2025-07-23 12:48:02', 0),
(13, NULL, 'A food \"Chicken Rice\" has been updated!', '2025-07-23 12:48:07', 0),
(14, NULL, 'A food \"Chicken Rice\" has been updated!', '2025-07-23 12:48:13', 0),
(15, NULL, 'A food \"Chicken Rice\" has been updated!', '2025-07-23 12:49:07', 0);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `status` enum('pending','confirmed','completed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `feedback_dismissed` tinyint(1) DEFAULT 0,
  `feedback_given` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `staff_id`, `customer_id`, `status`, `created_at`, `feedback_dismissed`, `feedback_given`) VALUES
(1, 1, 2, 'pending', '2025-07-03 11:27:04', 1, 0),
(2, 1, 2, 'pending', '2025-07-03 11:27:39', 1, 0),
(3, 1, 2, 'pending', '2025-07-03 11:37:08', 1, 0),
(4, 1, 2, 'pending', '2025-07-03 11:37:55', 1, 0),
(5, 1, 2, 'pending', '2025-07-08 09:03:21', 1, 0),
(6, 1, 2, 'pending', '2025-07-08 09:20:59', 1, 0),
(7, 1, 2, 'pending', '2025-07-08 09:21:32', 1, 0),
(8, 1, 2, 'pending', '2025-07-08 09:24:36', 1, 0),
(9, 1, 2, 'pending', '2025-07-08 09:25:25', 1, 0),
(10, 1, 2, 'pending', '2025-07-08 09:26:33', 1, 0),
(11, 1, 2, 'pending', '2025-07-08 09:36:45', 1, 0),
(12, 1, 2, 'pending', '2025-07-08 09:54:29', 1, 0),
(13, 1, 2, 'pending', '2025-07-08 11:06:44', 1, 0),
(14, 1, 2, 'pending', '2025-07-08 11:10:56', 1, 0),
(15, 1, 2, 'pending', '2025-07-08 11:11:07', 1, 0),
(16, 1, 2, 'pending', '2025-07-08 11:13:58', 1, 0),
(17, 1, 2, 'pending', '2025-07-08 11:14:13', 1, 0),
(18, 1, 2, 'pending', '2025-07-08 11:16:00', 1, 0),
(19, 1, 2, 'pending', '2025-07-08 11:18:04', 1, 0),
(20, 1, 2, 'pending', '2025-07-09 04:46:47', 1, 0),
(21, 1, 2, 'pending', '2025-07-09 06:31:26', 1, 0),
(22, 1, 2, 'pending', '2025-07-09 09:32:19', 1, 0),
(23, 1, 2, 'pending', '2025-07-09 09:46:53', 1, 0),
(24, 1, 2, 'pending', '2025-07-09 09:54:52', 0, 1),
(25, 1, 2, 'pending', '2025-07-09 10:44:51', 0, 1),
(26, 1, 2, 'pending', '2025-07-09 10:48:39', 1, 0),
(27, 1, 3, 'pending', '2025-07-09 10:53:19', 0, 0),
(28, 1, 3, 'pending', '2025-07-09 11:05:40', 0, 0),
(33, 1, 2, 'pending', '2025-07-09 15:00:15', 1, 0),
(34, 1, 3, 'pending', '2025-07-09 15:06:23', 0, 0),
(35, 1, 4, 'pending', '2025-07-09 15:12:28', 1, 0),
(36, 1, 4, 'pending', '2025-07-09 15:16:03', 1, 0),
(37, 1, 2, 'pending', '2025-07-10 04:27:45', 1, 0),
(38, 1, 2, 'pending', '2025-07-10 04:44:02', 0, 1),
(39, 1, 4, 'pending', '2025-07-10 04:46:07', 1, 0),
(40, 1, 4, 'pending', '2025-07-10 04:50:40', 0, 1),
(41, 1, 4, 'pending', '2025-07-10 04:51:06', 0, 1),
(42, 1, 4, 'pending', '2025-07-10 04:51:35', 1, 0),
(43, 1, 2, 'pending', '2025-07-10 05:36:10', 0, 1),
(44, 1, 4, 'pending', '2025-07-13 09:31:22', 1, 0),
(45, 1, 4, 'pending', '2025-07-14 06:52:41', 0, 1),
(46, 1, 3, 'pending', '2025-07-14 08:50:04', 0, 0),
(47, 1, 3, 'pending', '2025-07-14 08:54:41', 0, 0),
(48, 1, 9, 'pending', '2025-07-14 10:00:28', 0, 0),
(49, 1, 4, 'pending', '2025-07-14 10:34:06', 0, 1),
(50, 1, 4, 'pending', '2025-07-14 10:35:06', 0, 1),
(51, 1, 4, 'pending', '2025-07-14 10:49:36', 0, 1),
(52, 1, 4, 'pending', '2025-07-14 11:01:46', 0, 1),
(53, 1, 4, 'pending', '2025-07-14 11:02:13', 0, 1),
(54, 1, 4, 'pending', '2025-07-14 11:46:25', 1, 0),
(55, 1, 4, 'pending', '2025-07-14 12:01:41', 0, 1),
(56, 1, 4, 'pending', '2025-07-14 12:08:04', 0, 1),
(57, 1, 4, 'pending', '2025-07-14 12:11:32', 0, 1),
(58, 1, 2, 'pending', '2025-07-15 08:09:03', 0, 1),
(59, 1, 2, 'pending', '2025-07-15 08:41:37', 1, 0),
(60, 1, 9, 'pending', '2025-07-15 13:51:13', 0, 0),
(61, 1, 4, 'pending', '2025-07-15 14:02:46', 0, 1),
(62, 1, 4, 'pending', '2025-07-16 01:55:12', 0, 1),
(63, 1, 4, 'pending', '2025-07-16 02:11:23', 1, 0),
(64, 1, 4, 'pending', '2025-07-16 02:12:18', 1, 0),
(65, 1, 4, 'pending', '2025-07-16 02:14:12', 0, 0),
(66, 1, 4, 'pending', '2025-07-16 02:14:44', 0, 0),
(67, 1, 4, 'pending', '2025-07-16 02:17:46', 0, 0),
(68, 1, 4, 'pending', '2025-07-16 02:26:52', 0, 0),
(69, 1, 4, 'pending', '2025-07-16 06:44:31', 0, 0),
(70, 1, 4, 'pending', '2025-07-16 06:53:01', 0, 0),
(71, 1, 4, 'pending', '2025-07-16 07:09:07', 0, 0),
(72, 1, 4, 'pending', '2025-07-16 07:15:22', 0, 0),
(73, 1, 4, 'pending', '2025-07-16 07:19:56', 0, 0),
(74, 1, 4, 'pending', '2025-07-16 07:22:29', 0, 0),
(75, 1, 4, 'pending', '2025-07-16 07:25:08', 0, 0),
(76, 1, 4, 'pending', '2025-07-16 07:27:08', 0, 0),
(77, 1, 4, 'pending', '2025-07-16 07:54:05', 0, 0),
(78, 1, 4, 'pending', '2025-07-16 07:58:21', 0, 0),
(79, 1, 4, 'pending', '2025-07-16 08:22:21', 0, 0),
(80, 1, 4, 'pending', '2025-07-16 08:25:16', 0, 0),
(81, 1, 4, 'pending', '2025-07-16 08:27:42', 0, 0),
(82, 1, 4, 'pending', '2025-07-16 08:28:30', 0, 0),
(83, 1, 4, 'pending', '2025-07-16 08:33:03', 0, 0),
(84, 1, 4, 'pending', '2025-07-16 08:33:18', 0, 0),
(85, 1, 4, 'pending', '2025-07-16 09:04:05', 0, 0),
(86, 1, 4, 'pending', '2025-07-16 09:11:11', 0, 0),
(87, 1, 4, 'pending', '2025-07-16 09:13:17', 0, 0),
(88, 1, 4, 'pending', '2025-07-16 09:20:38', 0, 0),
(89, 1, 4, 'pending', '2025-07-16 09:24:26', 0, 0),
(90, 1, 4, 'pending', '2025-07-16 09:25:34', 0, 0),
(91, 1, 4, 'pending', '2025-07-16 10:01:46', 0, 0),
(92, 1, 4, 'pending', '2025-07-16 10:02:18', 0, 0),
(93, 1, 4, 'pending', '2025-07-16 10:04:07', 0, 0),
(94, 1, 4, 'pending', '2025-07-16 10:17:14', 0, 0),
(95, 1, 4, 'pending', '2025-07-16 10:18:21', 0, 0),
(96, 1, 4, 'pending', '2025-07-16 10:34:04', 0, 0),
(97, 1, 4, 'pending', '2025-07-16 10:36:55', 0, 0),
(98, 1, 4, 'pending', '2025-07-16 10:42:03', 1, 0),
(99, 1, 4, 'pending', '2025-07-16 10:47:03', 1, 0),
(100, 1, 4, 'pending', '2025-07-16 10:47:42', 0, 0),
(101, 1, 4, 'pending', '2025-07-16 10:54:32', 1, 0),
(102, 1, 4, 'pending', '2025-07-16 10:54:34', 0, 1),
(103, 1, 4, 'pending', '2025-07-16 10:54:38', 1, 0),
(104, 1, 4, 'pending', '2025-07-16 11:00:33', 1, 0),
(105, 1, 4, 'pending', '2025-07-16 11:04:35', 1, 0),
(106, 1, 4, 'pending', '2025-07-17 05:26:40', 0, 0),
(107, 1, 4, 'pending', '2025-07-17 10:20:40', 0, 0),
(108, 4, 2, 'pending', '2025-07-21 02:59:56', 0, 1),
(109, 4, 2, 'pending', '2025-07-21 06:56:12', 0, 1),
(110, 4, 10, 'pending', '2025-07-21 07:10:04', 0, 0),
(111, 4, 10, 'pending', '2025-07-21 07:13:08', 0, 0),
(112, 4, 10, 'pending', '2025-07-21 09:24:07', 0, 0),
(113, 4, 10, 'pending', '2025-07-21 09:25:02', 0, 1),
(114, 4, 31, 'pending', '2025-07-23 03:59:22', 0, 0),
(115, 4, 4, 'pending', '2025-07-23 04:05:10', 0, 0),
(116, 4, 4, 'pending', '2025-07-23 04:06:14', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `food_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `food_id`, `quantity`) VALUES
(1, 1, 1, 3),
(2, 2, 1, 2),
(3, 2, 2, 2),
(4, 3, 1, 3),
(5, 4, 1, 2),
(6, 4, 2, 2),
(7, 5, 1, 1),
(8, 5, 9, 2),
(9, 6, 1, 1),
(10, 7, 1, 2),
(11, 8, 1, 3),
(12, 9, 1, 3),
(13, 10, 10, 3),
(14, 10, 1, 2),
(15, 11, 1, 3),
(16, 11, 10, 3),
(17, 12, 9, 2),
(18, 12, 10, 1),
(19, 13, 1, 1),
(20, 13, 10, 2),
(21, 14, 1, 3),
(22, 15, 1, 4),
(23, 16, 1, 3),
(24, 16, 2, 2),
(25, 17, 1, 2),
(26, 18, 1, 3),
(27, 19, 1, 7),
(28, 20, 1, 3),
(29, 21, 9, 2),
(30, 21, 1, 2),
(31, 22, 1, 2),
(32, 23, 1, 2),
(33, 24, 2, 2),
(34, 25, 1, 3),
(35, 26, 1, 2),
(36, 27, 1, 2),
(37, 28, 1, 2),
(38, 33, 1, 1),
(39, 34, 1, 2),
(40, 34, 5, 1),
(41, 35, 1, 3),
(42, 35, 3, 5),
(43, 36, 1, 1),
(44, 36, 5, 1),
(45, 37, 2, 1),
(46, 37, 2, 1),
(47, 38, 1, 3),
(48, 39, 2, 1),
(49, 39, 2, 1),
(50, 40, 1, 8),
(51, 41, 1, 1),
(52, 41, 2, 15),
(53, 42, 1, 1),
(54, 42, 1, 1),
(55, 43, 1, 2),
(56, 43, 8, 1),
(57, 44, 1, 2),
(58, 45, 9, 1),
(59, 45, 9, 1),
(60, 46, 2, 2),
(61, 47, 2, 1),
(62, 47, 1, 2),
(63, 48, 1, 3),
(64, 48, 2, 2),
(65, 49, 10, 1),
(66, 49, 10, 1),
(67, 50, 1, 2),
(68, 51, 1, 2),
(69, 51, 2, 1),
(70, 52, 2, 2),
(71, 53, 2, 3),
(72, 54, 8, 1),
(73, 54, 8, 1),
(74, 55, 1, 1),
(75, 55, 1, 1),
(76, 56, 2, 2),
(77, 56, 1, 1),
(78, 56, 4, 1),
(79, 57, 1, 2),
(80, 57, 2, 1),
(81, 57, 5, 1),
(82, 58, 7, 1),
(83, 58, 7, 1),
(84, 59, 4, 1),
(85, 59, 4, 1),
(86, 60, 3, 3),
(87, 61, 1, 1),
(88, 61, 1, 1),
(89, 62, 4, 1),
(90, 63, 2, 2),
(91, 64, 2, 2),
(92, 65, 2, 2),
(93, 66, 2, 2),
(94, 67, 2, 2),
(95, 68, 3, 1),
(96, 68, 1, 2),
(97, 68, 2, 2),
(98, 69, 7, 1),
(99, 70, 7, 1),
(100, 71, 4, 1),
(101, 71, 1, 1),
(102, 72, 4, 1),
(103, 73, 4, 1),
(104, 74, 4, 1),
(105, 74, 1, 1),
(106, 75, 4, 1),
(107, 76, 4, 1),
(108, 77, 4, 1),
(109, 78, 4, 1),
(110, 78, 1, 2),
(111, 79, 4, 1),
(112, 80, 4, 1),
(113, 81, 4, 1),
(114, 81, 2, 1),
(115, 82, 4, 1),
(119, 86, 1, 1),
(120, 86, 3, 1),
(121, 87, 4, 1),
(122, 88, 4, 1),
(123, 89, 4, 1),
(124, 90, 4, 1),
(125, 91, 4, 1),
(126, 92, 4, 1),
(127, 93, 4, 1),
(128, 94, 4, 1),
(129, 95, 4, 1),
(130, 100, 1, 1),
(131, 100, 4, 1),
(132, 105, 4, 1),
(133, 106, 1, 3),
(134, 106, 2, 2),
(135, 106, 3, 2),
(136, 107, 4, 1),
(137, 108, 17, 1),
(138, 108, 9, 1),
(139, 109, 5, 1),
(140, 110, 9, 1),
(141, 111, 5, 1),
(142, 112, 4, 2),
(143, 113, 2, 1),
(144, 113, 1, 1),
(145, 114, 1, 1),
(146, 114, 17, 2),
(147, 115, 2, 2),
(148, 116, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `rewards`
--

CREATE TABLE `rewards` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `required_points` int(11) NOT NULL,
  `food_id` int(11) NOT NULL,
  `is_deleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rewards`
--

INSERT INTO `rewards` (`id`, `name`, `required_points`, `food_id`, `is_deleted`) VALUES
(9, 'Free Bacon Rolls', 18, 7, 1),
(10, 'Free Ngohionghionghiong', 10, 9, 0),
(11, 'Free Spring Rolls', 15, 5, 0),
(12, 'Free Batchoy', 10, 4, 0),
(13, 'Free Steamed Rice', 12, 3, 0),
(14, 'Free Something', 20, 1, 1),
(15, 'Free Something', 20, 1, 1),
(16, 'Free Something2', 18, 2, 1),
(17, 'Free Something3', 18, 6, 1),
(18, 'Free Chiceken Rice', 20, 1, 1),
(19, 'Free Chiceken Rice', 20, 1, 1),
(20, 'Free Chiceken Rice', 20, 1, 1),
(21, 'Free Chicken Rice', 18, 1, 0),
(23, 'Free Empress Rolls', 15, 6, 0);

-- --------------------------------------------------------

--
-- Table structure for table `reward_claims`
--

CREATE TABLE `reward_claims` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `reward_id` int(11) DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `claimed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `used` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `redeemed` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reward_claims`
--

INSERT INTO `reward_claims` (`id`, `customer_id`, `reward_id`, `code`, `claimed_at`, `used`, `created_at`, `redeemed`) VALUES
(15, 4, 9, 'knV2hnahzg', '2025-07-14 12:01:35', 0, '2025-07-14 20:01:35', 1),
(16, 4, 10, 'td7ybmQ7hU', '2025-07-14 12:07:46', 0, '2025-07-14 20:07:46', 0),
(17, 4, 11, '92uVspKbCB', '2025-07-14 12:10:51', 0, '2025-07-14 20:10:51', 1),
(18, 2, 9, 'w2UL6Hb2Fb', '2025-07-15 08:00:18', 0, '2025-07-15 16:00:18', 0),
(19, 2, 10, 'SieAMyVsfb', '2025-07-15 08:00:27', 0, '2025-07-15 16:00:27', 0),
(20, 2, 11, '6B_s03KUD-', '2025-07-15 08:01:47', 0, '2025-07-15 16:01:47', 0),
(21, 2, 12, 'YSG_W-skmZ', '2025-07-15 08:04:52', 0, '2025-07-15 16:04:52', 1),
(22, 2, 10, 'AvV7ZMlmv1', '2025-07-15 08:38:59', 0, '2025-07-15 16:38:59', 0),
(23, 2, 10, 'zr0X_0EwaP', '2025-07-15 08:41:03', 0, '2025-07-15 16:41:03', 1),
(24, 2, 10, 'RCJrKPMkVM', '2025-07-15 08:43:07', 0, '2025-07-15 16:43:07', 0),
(25, 4, 9, 'mzkL1UhRNn', '2025-07-15 14:02:09', 0, '2025-07-15 22:02:09', 1),
(26, 4, 10, '3BJPYpOZb8', '2025-07-15 14:08:24', 0, '2025-07-15 22:08:24', 0),
(27, 4, 13, '6ChZtkYSFl', '2025-07-16 02:26:10', 0, '2025-07-16 10:26:10', 1),
(28, 4, 12, '5Qu8WaniAt', '2025-07-16 05:28:54', 0, '2025-07-16 13:28:54', 1),
(29, 4, 11, '8-DEf3gFc_', '2025-07-16 05:31:15', 0, '2025-07-16 13:31:15', 1),
(30, 4, 10, 'wMQiRyMi5F', '2025-07-17 10:20:01', 0, '2025-07-17 18:20:01', 1),
(31, 2, 10, '5h5wuz4mja', '2025-07-21 02:57:19', 0, '2025-07-21 10:57:19', 1),
(32, 2, 11, 'plvLt6UHlv', '2025-07-21 06:55:59', 0, '2025-07-21 14:55:59', 1),
(33, 10, 10, 'VJSTArky2p', '2025-07-21 07:09:51', 0, '2025-07-21 15:09:51', 1),
(34, 10, 11, '3QE657tbVq', '2025-07-21 07:12:35', 0, '2025-07-21 15:12:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_code` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `points` int(11) DEFAULT 0,
  `role` enum('customer','staff','admin') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `visit_count` int(11) DEFAULT 0,
  `is_verified` tinyint(4) DEFAULT 0,
  `is_deleted` tinyint(1) DEFAULT 0,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expires` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_code`, `email`, `password`, `username`, `points`, `role`, `created_at`, `visit_count`, `is_verified`, `is_deleted`, `reset_token`, `reset_token_expires`) VALUES
(1, 'USER-4WA9L9FR', 'chaewonbaby@gmail.com', '$2b$08$biK2rpSalJPIxWg6Cf1oTuGg2ydcs8nhxhUKw85yN91i0nMB9p1wW', 'Chaewon', 0, 'staff', '2025-07-03 08:38:34', 0, 1, 0, NULL, NULL),
(2, 'USER-VRS1WNLH', 'test2@gmail.com', '$2b$10$nhwAKdg88Iq11i3EUm6tbOvC6TeY7juAUhsO.E7e9fH/WiYTtUav6', 'Haerin Kang', 591, 'customer', '2025-07-03 08:39:50', 28, 1, 0, NULL, NULL),
(3, 'BRDX-R17BLV3Z', 'test4@gmail.com', '$2b$08$Pur7ldhc3N8XIcguncgDB.w.1L6loqstv0HVJ5hJTLHE9.OnQsXCS', 'blablabal', 86, 'customer', '2025-07-09 10:52:12', 5, 0, 0, NULL, NULL),
(4, 'BRDX-0EUHA811', 'anggand@gmail.com', '$2b$08$P3.YL4nuiHzUUhtJkygpW.F3ZGW9wyIyJ9heYA5VM7CBLubNaO9E6', 'aprilbabygwapa', 639, 'staff', '2025-07-09 15:07:40', 55, 1, 0, NULL, NULL),
(9, 'BRDX-G7N88NGN', 'test5@gmail.com', '$2b$08$NPu0ghpEmj0MVFrR/R9u.Oihb3FciWm9kuuphTbm7YfPvPfq/GTci', 'nga', 78, 'admin', '2025-07-10 05:02:19', 2, 0, 1, NULL, NULL),
(10, 'BRDX-UC6IWHM9', 'ethan@gmail.com', '$2b$10$smE3RW7OEvJ7lx6rFcluteLeuGfgQE/Bqhr0svyk9/4P5OqZ2.tX.', 'ethan', 1013, 'customer', '2025-07-14 11:26:30', 4, 1, 0, NULL, NULL),
(11, 'BRDX-OFB0U004', 'jose@gmail.com', '$2b$08$jtilUSIltKQ.ZRNG.cowRuYtwf3D.7Ct9v6gniEgDWIt83hE6zkO.', 'jose', 0, 'admin', '2025-07-15 11:46:26', 0, 0, 0, NULL, NULL),
(24, 'BRDX-M522TP8L', 'arnocolencel@gmail.com', '$2b$08$wrTp4OFGr6CefhtELAK2Eeorwr0XsBjQl/1f1tD.BEnqzvcwgqrw.', 'realestfella', 0, 'admin', '2025-07-15 13:21:37', 0, 1, 0, NULL, NULL),
(25, 'BRDX-NEOBOQVW', 'aprilprincessmadina@gmail.com', '$2b$08$dSO4YfLjF/gHsTsym0fQgOqk6dtA.XF8nwxL8JpNsajbdaVeuoDfa', 'sawolcess', 0, 'admin', '2025-07-17 03:04:51', 1, 1, 0, NULL, NULL),
(31, 'BRDX-R476FOO6', 'kirayoshikagebtd@gmail.com', '$2b$08$1iaek7fzT79XPuylJTzU9ejjaLcVW1VyeEKManoklqyJpnr5TR2yW', 'kirara', 0, 'customer', '2025-07-23 03:56:09', 1, 1, 0, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_feedback_order` (`order_id`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `food_id` (`food_id`);

--
-- Indexes for table `rewards`
--
ALTER TABLE `rewards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `food_id` (`food_id`);

--
-- Indexes for table `reward_claims`
--
ALTER TABLE `reward_claims`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `reward_id` (`reward_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_code` (`user_code`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT for table `rewards`
--
ALTER TABLE `rewards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `reward_claims`
--
ALTER TABLE `reward_claims`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_feedback_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food` (`id`);

--
-- Constraints for table `rewards`
--
ALTER TABLE `rewards`
  ADD CONSTRAINT `rewards_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `food` (`id`);

--
-- Constraints for table `reward_claims`
--
ALTER TABLE `reward_claims`
  ADD CONSTRAINT `reward_claims_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reward_claims_ibfk_2` FOREIGN KEY (`reward_id`) REFERENCES `rewards` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
