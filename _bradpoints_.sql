-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 16, 2025 at 07:19 AM
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
CREATE DATABASE IF NOT EXISTS `bradpoints` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bradpoints`;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `user_id`, `message`, `created_at`, `order_id`) VALUES
(1, 2, 'nigger', '2025-07-09 08:52:03', NULL),
(2, 2, 'hellaur\n', '2025-07-09 09:49:41', NULL),
(3, 2, 'hellaurrrr', '2025-07-09 09:51:27', NULL),
(4, 2, 'another feedback', '2025-07-09 09:53:05', NULL),
(5, 4, 'i love lencel <3', '2025-07-09 15:14:01', NULL),
(6, 4, 'i love lencel <3', '2025-07-09 15:14:01', NULL),
(7, 4, 'NIGGER', '2025-07-14 07:08:17', NULL),
(8, 4, 'NIGGER', '2025-07-14 07:08:17', NULL),
(9, 4, 'hellaur', '2025-07-14 07:13:12', NULL),
(10, 4, 'hellaur', '2025-07-14 07:13:12', NULL),
(11, 4, 'hiii', '2025-07-14 07:14:36', NULL),
(12, 4, 'ermmm', '2025-07-14 07:15:05', NULL),
(13, 4, 'omkey\n', '2025-07-14 07:39:32', NULL),
(14, 4, 'hellaur', '2025-07-14 07:48:46', 45),
(15, 4, 'hella?', '2025-07-14 08:11:23', 39),
(16, 4, 'haiii', '2025-07-14 08:15:03', 40),
(17, 4, 'nauuurr', '2025-07-14 08:15:47', 40),
(18, 4, 'test2', '2025-07-14 08:44:30', 41),
(19, 4, 'Good', '2025-07-14 10:01:10', 45),
(20, 4, 'ablajslfdkja', '2025-07-14 10:35:47', 49),
(21, 4, 'hellaur', '2025-07-14 10:41:02', 50),
(22, 4, 'ingot', '2025-07-14 10:49:50', 51),
(23, 4, 'hellaur\n', '2025-07-14 11:01:57', 52),
(24, 4, 'brehhh', '2025-07-14 11:07:56', 53),
(25, 4, 'errmm\n', '2025-07-15 06:09:04', 55),
(26, 4, 'ermm', '2025-07-15 06:10:36', 56),
(27, 4, 'hellaur', '2025-07-15 06:12:27', 57),
(28, 4, 'so clean  so good', '2025-07-15 15:50:56', 25),
(29, 2, 'so clean  so good', '2025-07-15 15:51:56', 25),
(30, 2, 'so clean  so good', '2025-07-15 15:53:46', 25);

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `points` int(11) DEFAULT 0,
  `is_available` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`id`, `name`, `description`, `price`, `points`, `is_available`, `created_at`) VALUES
(1, 'Cheeseburger', 'Juicy grilled burger with cheese', 120.00, 10, 1, '2025-07-03 09:33:28'),
(2, 'Fried Chicken', 'Crispy golden fried chicken', 150.00, 12, 1, '2025-07-03 09:33:28'),
(3, 'Spaghetti', 'Sweet-style Filipino spaghetti', 100.00, 8, 1, '2025-07-03 09:33:28'),
(4, 'Iced Tea', 'Refreshing lemon iced tea', 40.00, 2, 1, '2025-07-03 09:33:28'),
(5, 'Halo-Halo', 'Classic Filipino dessert with crushed ice and mix-ins', 90.00, 7, 1, '2025-07-03 09:33:28'),
(6, 'Pork BBQ', 'Skewered pork with sweet glaze', 80.00, 6, 1, '2025-07-03 09:33:28'),
(7, 'Sisig', 'Sizzling chopped pork with egg', 130.00, 11, 1, '2025-07-03 09:33:28'),
(8, 'Plain Rice', 'Steamed white rice', 25.00, 1, 1, '2025-07-03 09:33:28'),
(9, 'Lumpia', 'Filipino-style spring rolls', 60.00, 5, 1, '2025-07-03 09:33:28'),
(10, 'Milk Tea', 'Brown sugar milk tea with pearls', 100.00, 5, 1, '2025-07-03 09:33:28');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
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
(24, 1, 2, 'pending', '2025-07-09 09:54:52', 0, 0),
(25, 1, 2, 'pending', '2025-07-09 10:44:51', 0, 0),
(26, 1, 2, 'pending', '2025-07-09 10:48:39', 1, 0),
(27, 1, 3, 'pending', '2025-07-09 10:53:19', 0, 0),
(28, 1, 3, 'pending', '2025-07-09 11:05:40', 0, 0),
(33, 1, 2, 'pending', '2025-07-09 15:00:15', 1, 0),
(34, 1, 3, 'pending', '2025-07-09 15:06:23', 0, 0),
(35, 1, 4, 'pending', '2025-07-09 15:12:28', 1, 0),
(36, 1, 4, 'pending', '2025-07-09 15:16:03', 1, 0),
(37, 1, 2, 'pending', '2025-07-10 04:27:45', 1, 0),
(38, 1, 2, 'pending', '2025-07-10 04:44:02', 0, 0),
(39, 1, 4, 'pending', '2025-07-10 04:46:07', 1, 0),
(40, 1, 4, 'pending', '2025-07-10 04:50:40', 0, 1),
(41, 1, 4, 'pending', '2025-07-10 04:51:06', 0, 1),
(42, 1, 4, 'pending', '2025-07-10 04:51:35', 1, 0),
(43, 1, 2, 'pending', '2025-07-10 05:36:10', 0, 0),
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
(58, 1, 2, 'pending', '2025-07-15 08:09:03', 0, 0),
(59, 1, 2, 'pending', '2025-07-15 08:41:37', 1, 0),
(60, 1, 9, 'pending', '2025-07-15 13:51:13', 0, 0),
(61, 1, 4, 'pending', '2025-07-15 14:02:46', 0, 0),
(62, 1, 4, 'pending', '2025-07-16 01:55:12', 0, 0),
(63, 1, 4, 'pending', '2025-07-16 02:11:23', 0, 0),
(64, 1, 4, 'pending', '2025-07-16 02:12:18', 0, 0),
(65, 1, 4, 'pending', '2025-07-16 02:14:12', 0, 0),
(66, 1, 4, 'pending', '2025-07-16 02:14:44', 0, 0),
(67, 1, 4, 'pending', '2025-07-16 02:17:46', 0, 0),
(68, 1, 4, 'pending', '2025-07-16 02:26:52', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
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
(97, 68, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `rewards`
--

DROP TABLE IF EXISTS `rewards`;
CREATE TABLE `rewards` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `required_points` int(11) NOT NULL,
  `food_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rewards`
--

INSERT INTO `rewards` (`id`, `name`, `required_points`, `food_id`) VALUES
(9, 'Free Cheeseburger', 18, 1),
(10, 'Free Iced Tea', 6, 4),
(11, 'Free Halo-Halo', 15, 5),
(12, 'Free Sisig', 22, 7),
(13, 'Free Spaghetti', 12, 3);

-- --------------------------------------------------------

--
-- Table structure for table `reward_claims`
--

DROP TABLE IF EXISTS `reward_claims`;
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
(16, 4, 10, 'td7ybmQ7hU', '2025-07-14 12:07:46', 0, '2025-07-14 20:07:46', 1),
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
(27, 4, 13, '6ChZtkYSFl', '2025-07-16 02:26:10', 0, '2025-07-16 10:26:10', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
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
  `is_verified` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_code`, `email`, `password`, `username`, `points`, `role`, `created_at`, `visit_count`, `is_verified`) VALUES
(1, 'USER-4WA9L9FR', 'test3@gmail.com', '$2b$08$biK2rpSalJPIxWg6Cf1oTuGg2ydcs8nhxhUKw85yN91i0nMB9p1wW', 'staff1', 0, 'staff', '2025-07-03 08:38:34', 0, 1),
(2, 'USER-VRS1WNLH', 'test2@gmail.com', '$2b$08$s78lcE.02C9F2GWxrHaENepgvsCAFXjhA2s1EVwUgVZwUneC/0kfe', 'jigga', -25, 'customer', '2025-07-03 08:39:50', 26, 0),
(3, 'BRDX-R17BLV3Z', 'test4@gmail.com', '$2b$08$Pur7ldhc3N8XIcguncgDB.w.1L6loqstv0HVJ5hJTLHE9.OnQsXCS', 'blablabal', 86, 'customer', '2025-07-09 10:52:12', 5, 0),
(4, 'BRDX-0EUHA811', 'anggand@gmail.com', '$2b$08$P3.YL4nuiHzUUhtJkygpW.F3ZGW9wyIyJ9heYA5VM7CBLubNaO9E6', 'aprilbabygwapa', 403, 'customer', '2025-07-09 15:07:40', 25, 1),
(9, 'BRDX-G7N88NGN', 'test5@gmail.com', '$2b$08$NPu0ghpEmj0MVFrR/R9u.Oihb3FciWm9kuuphTbm7YfPvPfq/GTci', 'nga', 78, 'customer', '2025-07-10 05:02:19', 2, 0),
(10, 'BRDX-UC6IWHM9', 'ethan@gmail.com', '$2b$08$L3P6cWC2Wh2fBSK2eWy/9eiWk/p8yvFfdY3LS2Y1cZMlfgqASgVNG', 'ethan', 0, 'customer', '2025-07-14 11:26:30', 0, 0),
(11, 'BRDX-OFB0U004', 'jose@gmail.com', '$2b$08$jtilUSIltKQ.ZRNG.cowRuYtwf3D.7Ct9v6gniEgDWIt83hE6zkO.', 'jose', 0, 'customer', '2025-07-15 11:46:26', 0, 0),
(24, 'BRDX-M522TP8L', 'arnocolencel@gmail.com', '$2b$08$wrTp4OFGr6CefhtELAK2Eeorwr0XsBjQl/1f1tD.BEnqzvcwgqrw.', 'realestfella', 0, 'customer', '2025-07-15 13:21:37', 0, 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `rewards`
--
ALTER TABLE `rewards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `reward_claims`
--
ALTER TABLE `reward_claims`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
