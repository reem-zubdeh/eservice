-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3308
-- Generation Time: Jul 13, 2022 at 09:59 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eservice`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `timeslot` datetime NOT NULL,
  `status` char(1) NOT NULL,
  `date_booked` date NOT NULL,
  `Fdone` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `service_id`, `customer_id`, `emp_id`, `timeslot`, `status`, `date_booked`, `Fdone`) VALUES
(2, 15, 2, 15, '0000-00-00 00:00:00', '1', '0000-00-00', 1),
(3, 2, 2, 1, '0000-00-00 00:00:00', '1', '0000-00-00', 1),
(4, 3, 2, 15, '0000-00-00 00:00:00', '4', '0000-00-00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `image`) VALUES
('cleaning', 'Cleaning', 'category_cleaning.jpg'),
('delivery', 'Errands & Delivery', 'category_delivery.jpg'),
('fixup', 'Maintenance & Fix-Up', 'category_fixup.jpg'),
('mechanic', 'Mechanic', 'category_mechanic.jpg'),
('moving', 'Moving Day', 'category_moving.jpg'),
('painting', 'Painting', 'category_painting.jpg'),
('plumbing', 'Plumbing', 'category_plumbing.jpg'),
('transportation', 'Transportation', 'category_transportation.jpg'),
('woodwork', 'Carpentry & Woodwork', 'category_woodwork.jpg'),
('_misc', 'Miscellaneous', 'category_misc.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `chat_id` int(11) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`chat_id`, `message`, `from_id`, `to_id`, `datetime`) VALUES
(1, '', 2, 15, '2022-07-09 22:50:35'),
(2, '', 2, 15, '2022-07-09 22:52:03'),
(3, '', 2, 15, '2022-07-10 00:30:32'),
(4, '', 2, 15, '2022-07-11 21:14:12'),
(5, 'hello', 2, 15, '2022-07-11 21:14:35'),
(6, 'i am jane', 2, 15, '2022-07-11 21:14:42'),
(7, 'ok bye', 15, 2, '2022-07-11 22:27:21'),
(8, 'dont text me again', 15, 2, '2022-07-11 22:29:31');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `country` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `idcard` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `country`, `city`, `idcard`) VALUES
(1, 'Lebanon', 'Beirut', '1653687723657.pdf'),
(4, 'Lebanon', 'Beirut', '1653691489975.pdf'),
(6, 'Lebanon', 'Beirut', '1653691800215.pdf'),
(8, 'Lebanon', 'Beirut', '1653691988629.pdf'),
(12, 'Lebanon', 'Beirut', '1653692357736.pdf'),
(15, 'Lebanon', 'Beirut', '1653692954823.pdf'),
(17, 'Lebanon', 'Beirut', '1653693213645.pdf'),
(18, 'Lebanon', 'Beirut', '1653693324985.pdf'),
(20, 'Lebanon', 'Beirut', '1653693576565.pdf'),
(21, 'Lebanon', 'Beirut', '1653693664361.pdf'),
(23, 'Lebanon', 'Beirut', '1653693840790.pdf'),
(24, 'Lebanon', 'Beirut', '1653693907368.pdf'),
(27, 'Lebanon', 'Beirut', '1653694381187.pdf'),
(28, 'Lebanon', 'Beirut', '1653694435980.pdf'),
(29, 'Lebanon', 'Beirut', '1653694628882.pdf'),
(30, 'Lebanon', 'Beirut', '1653694896975.pdf'),
(32, 'Lebanon', 'Beirut', '1653695497775.pdf'),
(35, 'Lebanon', 'Beirut', '1653695883194.pdf'),
(37, 'Lebanon', 'Beirut', '1653696120339.pdf'),
(38, 'Lebanon', 'Beirut', '1653696247192.pdf'),
(39, 'Lebanon', 'Beirut', '1653696387861.pdf'),
(40, 'Lebanon', 'Beirut', '1653696494952.pdf'),
(42, 'Lebanon', 'Beirut', '1653696875315.pdf'),
(50, 'Lebanon', 'Beirut', '1653697347135.pdf'),
(53, 'Lebanon', 'Beirut', '1653697543709.pdf'),
(55, 'Lebanon', 'Beirut', '1653697682553.pdf'),
(56, 'Lebanon', 'Beirut', '1653697728525.pdf'),
(59, 'Lebanon', 'Beirut', '1653697887702.pdf'),
(60, 'Lebanon', 'Beirut', '1653697929393.pdf'),
(61, 'Lebanon', 'Beirut', '1653697983232.pdf'),
(62, 'Lebanon', 'Beirut', '1653698055128.pdf'),
(65, 'Lebanon', 'Beirut', '1653698189684.pdf'),
(66, 'Lebanon', 'Beirut', '1653698578096.pdf'),
(67, 'Lebanon', 'Beirut', '1653698627563.pdf'),
(69, 'Lebanon', 'Beirut', '1653698935058.pdf'),
(78, 'Lebanon', 'Beirut', '1653700435313.pdf'),
(79, 'Lebanon', 'Beirut', '1653700477449.pdf'),
(80, 'Lebanon', 'Beirut', '1653700521455.pdf'),
(85, 'Lebanon', 'Beirut', '1653700869097.pdf'),
(86, 'Lebanon', 'Beirut', '1653700956210.pdf'),
(91, 'Lebanon', 'Beirut', '1653701184218.pdf'),
(97, 'Lebanon', 'Beirut', '1653701444622.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `employee_timeslots`
--

CREATE TABLE `employee_timeslots` (
  `timeslot_id` int(11) NOT NULL,
  `availablity` tinyint(4) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time_from` time NOT NULL,
  `time_to` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee_timeslots`
--

INSERT INTO `employee_timeslots` (`timeslot_id`, `availablity`, `employee_id`, `date`, `time_from`, `time_to`) VALUES
(1, 0, 2, '2022-05-26', '14:23:00', '13:23:00'),
(2, 0, 15, '2022-05-26', '23:30:00', '23:29:00'),
(3, 1, 1, '2022-06-30', '01:11:00', '01:12:00'),
(4, 0, 2, '2022-08-04', '14:52:00', '14:48:00'),
(5, 0, 2, '2022-07-26', '14:51:00', '14:54:00');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `is_from_customer` tinyint(1) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `rating` decimal(10,0) NOT NULL DEFAULT 0,
  `total` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `is_from_customer`, `description`, `from_id`, `to_id`, `service_id`, `name`, `rating`, `total`) VALUES
(1, 1, ' z,x', 15, 3, 0, 'fatima', '0', 0),
(2, 1, ' zxmzm', 1, 3, 0, 'fatima', '0', 0),
(10, 1, 'c', 2, 15, 0, 'fatima', '0', 0),
(11, 1, 'x', 2, 15, 4, 'fatima', '0', 0),
(12, 1, 'g', 2, 15, 4, 'fatima', '0', 0),
(13, 1, 'd', 2, 15, 2, 'fatima', '0', 0),
(14, 1, 'dj', 2, 15, 2, 'fatima', '0', 0),
(15, 1, 'm', 2, 2, 4, 'fatima', '0', 0),
(16, 1, 's', 2, 2, 4, 'fatima', '0', 0),
(17, 1, 'd', 2, 15, 4, 'fatima', '0', 0),
(18, 1, 's', 2, 15, 2, 'fatima', '0', 0),
(19, 0, 'm', 2, 15, 15, '', '0', 0),
(20, 0, 'mmdx', 2, 15, 15, '', '0', 0),
(21, 0, 'z', 2, 15, 15, '', '0', 0),
(22, 1, 'ss', 2, 15, 3, 'fatima', '0', 0),
(23, 1, '', 13, 3, 0, 'fatima', '0', 0),
(24, 1, 'xa', 2, 15, 3, 'fatima', '4', 0),
(25, 1, '', 2, 3, 0, 'fatima', '4', 0),
(26, 1, 'hello', 2, 15, 3, 'fatima', '4', 0),
(27, 1, 'test', 2, 15, 3, 'fatima', '4', 0),
(28, 1, 'he', 2, 15, 3, 'fatima', '4', 0),
(29, 1, 'nd', 2, 15, 3, 'fatima', '4', 0),
(30, 1, '', 2, 3, 0, 'fatima', '1', 0),
(31, 1, 'new feed', 2, 15, 3, 'fatima', '1', 0),
(34, 1, 'm', 2, 3, 0, 'fatima', '1', 0),
(35, 1, 'm', 2, 15, 3, 'fatima', '1', 0),
(36, 1, 's', 2, 15, 3, 'fatima', '1', 0),
(37, 1, 'n', 2, 15, 3, 'fatima', '1', 0),
(38, 1, 'nxd', 2, 15, 3, 'fatima', '1', 0),
(39, 1, 'xd', 2, 15, 3, 'fatima', '1', 0),
(40, 1, 'bebe', 2, 15, 3, 'fatima', '1', 0),
(41, 1, 'duu', 2, 15, 3, 'fatima', '1', 0),
(42, 1, 'kk', 2, 15, 3, 'fatima', '1', 0),
(43, 1, 'zxz', 2, 15, 3, 'fatima', '1', 0),
(44, 1, 'newmessage', 2, 3, 0, 'fatima', '1', 0),
(45, 1, 'xxx', 2, 15, 3, 'fatima', '1', 0),
(46, 0, 'cdddddddd', 15, 15, 3, '', '4', 0),
(47, 0, 'zs', 15, 15, 3, '', '4', 0),
(48, 0, 'm', 15, 3, 0, '', '4', 0),
(49, 0, 'scs', 15, 2, 3, '', '2', 0),
(50, 0, 'dd', 15, 2, 3, '', '2', 0),
(51, 0, 'my new', 15, 2, 3, '', '2', 0),
(52, 1, 'mew', 2, 15, 3, 'fatima', '1', 0),
(53, 1, 'mew', 2, 15, 3, 'fatima', '5', 0);

-- --------------------------------------------------------

--
-- Table structure for table `forgot_codes`
--

CREATE TABLE `forgot_codes` (
  `code_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `code` char(6) NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(11) NOT NULL,
  `category_id` varchar(255) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `tags` varchar(500) NOT NULL,
  `rate` int(11) NOT NULL,
  `description` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `category_id`, `employee_id`, `tags`, `rate`, `description`) VALUES
(0, 'transportation', 1, 'driver driving commute taxi car trips', 15, 'Private driver. Comfortable, air conditioned car holds up to 4 adults (excluding driver).'),
(2, 'delivery', 1, 'errands trips delivery groceries grocery-shopping grocery-delivery food-delivery', 10, 'Running any kind of errands. Can deliver your grocery list in optimal time.'),
(3, 'delivery', 1, 'driver driving commute taxi car trips large-groups group-taxi', 11, 'Private driver for big groups. Large, comfortable, air conditioned car holds up to 8 adults (excluding driver) with extra luggage compartment.'),
(4, 'delivery', 4, 'errands errandboy delivery', 17, 'Delivering small packages and running errands from one location to another'),
(5, '_misc', 6, 'kitchen kitchen-help kitchen-buddy food chopping cooking baking', 16, 'Kitchen buddy to help with simple tasks in the kitchen such as chopping, mixing, and washing, mainly for large special occasions. Not a full catering service.'),
(6, '_misc', 8, 'dog dog-walking pet pet-care', 10, 'Dog walking before sunset. Rate scales proportional to how long the walk is (e.g. $5 for 30 minute walk). Daily services available on request.'),
(7, '_misc', 8, 'dog dog-sitter pet pet-care pet-sitter cat cat-sitter', 20, 'Looking after your pet while you\'re gone. $100 per day for full-day services.'),
(8, 'moving', 12, 'boxes box box-moving unpacking loading', 40, 'Box loading and unloading from trucks, carrying boxes in and out of the house, unpacking and moving heavy furniture.'),
(9, 'moving', 12, 'truck moving-truck', 30, 'Moving truck, can carry large amount of boxes and furniture. Several trips possible in case needed.'),
(10, 'delivery', 12, 'truck moving-truck delivery', 20, 'Delivery truck, can deliver large or small packages'),
(11, 'cleaning', 15, 'cleaning house-cleaning housekeeping chores dish-washing dishwashing', 20, 'Full house cleaning as fast and efficiently as possible. Services can include mopping, sweeping, dusting, scrubbing, and dish washing.'),
(12, 'cleaning', 17, 'carpet carpet-cleaning carpet-washing deep-cleaning rug rug-cleaning', 15, 'Deep cleaning for rugs and carpets.'),
(13, 'cleaning', 17, 'cleaning housekeeping chores', 10, 'General housekeeping and cleaning.'),
(14, 'transportation', 18, 'driver daily-driver car', 14, 'Private driver, luxury car. Rates may vary for extra long trips. Daily services available.'),
(15, 'painting', 20, 'paint painter painting wall-painting wallpaper', 12, 'Wallpaper and painting for your walls. Large variety of colors and patterns available. Product cost not included and can vary according to needs.'),
(16, 'woodwork', 21, 'carpenter wood woodwork furniture shelf shelves', 75, 'Wooden furniture design and hand crafting. Specializes in wooden shelf systems.'),
(17, 'woodwork', 21, 'carpenter wood woodwork crafts gifts', 40, 'Small handmade wooden crafts, perfect for gifts and souvenirs. Custom and premade designs available.'),
(18, 'painting', 23, 'painting restoration antique', 12, 'Painting and polishing small objects, antiques, and trinkets in need of restoration. Small pieces of furniture can also be accepted.'),
(19, 'delivery', 24, 'delivery motorbike-delivery errands', 11, 'Small deliveries and errands.'),
(20, 'cleaning', 27, 'chores cleaning laundry iron ironing dishwashing housework housekeeping', 15, 'Will take care of chores in your home, such as cleaning, laundry, dishwashing, and ironing.'),
(21, '_misc', 28, 'gardening garden flowers plants planting', 16, 'Full gardening service: watering, weeding, and harvesting plants. Will use any tools and pest control you have available.'),
(22, 'cleaning', 28, 'lawn lawn-mowing lawn-care lawnmower lawn-mower mowing', 13, 'Lawn mowing. Lawnmower equipment required. Can mow on a regular schedule on request.'),
(23, 'cleaning', 29, 'washing power-washing pressure-washing pressure-cleaning', 50, 'Pressure/power washing for floors, home exteriors, gear, vehicles, and more. Necessary equipment will be provided by me.'),
(24, 'plumbing', 30, 'plumbing plumber bathroom sink pipes', 40, 'General plumber. Bathroom, drain, and sink maintenance/repair.'),
(25, 'painting', 32, 'painter painting walls wall-painting', 52, 'Wall painting for your home. Contact me for currently available colors.'),
(26, 'cleaning', 32, 'painter painting furniture furniture-painting', 35, 'Furniture painting. Contact me for currently available colors.'),
(27, '_misc', 35, 'face face-paint party kids-party artist', 70, 'Face painting artist for kids\' parties. Many designs and colors available; custom designs also possible.'),
(28, '_misc', 37, 'catering caterer food cooking', 100, 'Full catering service for home and events.'),
(29, 'cleaning', 37, 'housekeeping cleaning', 15, 'Cleaning services for home, office, and anywhere.'),
(30, 'fixup', 38, 'fixup repair fix drill tools power-tools handyman', 24, 'Home repairs and maintenance: doors, walls, ceiling, furniture, flooring, basic electric outlets and electronics.'),
(31, 'fixup', 39, 'fix fixes wood repair wood-repair power-tools', 30, 'Repairing various wooden furniture, doors, flooring, and more with power tools.'),
(32, 'fixup', 39, 'fix fixes repair power-tools', 40, 'Repairing various metal objects, doors, and more with power tools.'),
(33, 'woodwork', 40, 'wood woodwork carpentry carpenter', 65, 'Building wooden furniture such as cabinets, tables, and chairs.'),
(34, 'transportation', 42, 'limo limousine chauffeur driver occasion luxury', 120, 'Luxury limousine with private chauffeur. Limousine can seat up to 10 people. Great for special occasions and/or big groups.'),
(35, 'transportation', 50, 'driver chauffeur drive school trips transportation', 10, 'Driving your kids to and from school safely and quickly. Monthly fees available (5 days/week, 4 weeks) range from $200 to $300 depending on distance.');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `is_employee` tinyint(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `gender` char(1) NOT NULL,
  `date_of_birth` date NOT NULL,
  `photo` varchar(255) NOT NULL,
  `rate` float(2,1) NOT NULL DEFAULT 0.0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `is_employee`, `email`, `password`, `first_name`, `last_name`, `phone`, `gender`, `date_of_birth`, `photo`, `rate`) VALUES
(1, 1, 'johnsmith@example.com', '$2b$08$6OIQZkSlXI6rCYio.lEKVOkuNtsRoyi7qtsnvQzF4r23QTeQJnLP6', 'John', 'Smith', '81482021', 'm', '1995-01-04', '1653687723654.png', 0.0),
(2, 0, 'janedoe@example.com', '$2b$08$I8Mc4Y4s9tK2YNuUjQ6sE.r3W0m.VzSum4toQNC4cL8RW.Bo8Cv1K', 'Jane', 'Doe', '81452211', 'f', '1999-11-04', '1653689530990.png', 1.7),
(3, 0, 'laurabrown@example.com', '$2b$08$Ha7L32sLqorzKoUbJ2Pzv.z0HMY1LIwIA3JjqCqm2DKwwZvY9MN9u', 'Laura', 'Brown', '70123123', 'f', '1999-11-04', '1653691338084.png', 4.3),
(4, 1, 'jasonstewart@example.com', '$2b$08$b2EsQRLUkwQirdSYuW0gKuQ3As3mKW3bwfA8sDnOj//uZqVjPmDaa', 'Jason', 'Stewart', '71937492', 'm', '2001-03-18', '1653691489974.png', 0.0),
(5, 0, 'suzieramirez@example.com', '$2b$08$00ZtT/XJpj3ja4JlJxXVf.cCZgkxB2rEE5TTSreMNnmB/cDLEZIV.', 'Suzie', 'Ramirez', '70123123', 'f', '1989-11-04', '1653691616071.png', 0.0),
(6, 1, 'rachelsmith@example.com', '$2b$08$EsKj9yX5jWbmLDnvH./r4uBS53nXeUWi826xGxWoaVgpsZ.LLgRDe', 'Rachel', 'Smith', '80800822', 'f', '1998-06-29', '1653691800213.png', 0.0),
(7, 0, 'amyhoward@example.com', '$2b$08$0ZZ9SWMsuMY.R65U4EKwPeX0mJd/oxf4Xtm/fa12T/2ETkEy2vD5q', 'Amy', 'Howard', '70123123', 'f', '1976-11-04', '1653691925128.png', 0.0),
(8, 1, 'kimthomas@example.com', '$2b$08$AXB67oqnRvUgtgLbKj5Cgu2Cl4LnHtR7FFxGFwp4VuTX2yxTkuIdK', 'Kim', 'Thomas', '80800822', 'f', '1988-06-29', '1653691988628.png', 0.0),
(9, 0, 'peterwilson@example.com', '$2b$08$sV9XCw5A5y/2AMIvqgvu1.PCW8181OoYNVj1T3zu/ERAFewDXQnGC', 'Peter', 'Wilson', '01582052', 'm', '1958-12-07', '1653692085678.png', 0.0),
(10, 0, 'rebeccascott@example.com', '$2b$08$oacnDeRPj/8DQItdN6tYO.WifSDUuNdGBb3aN.LmTU1PwNianP9h.', 'Rebecca', 'Scott', '71839502', 'f', '1991-04-10', '1653692175887.png', 0.0),
(11, 0, 'lorithompson@example.com', '$2b$08$hMBXkMXfbpPlAjr0tFxoMegI8DhTuJwBKya4hbvCFGqGHmz1ATfLK', 'Lori', 'Thompson', '70810331', 'f', '1991-08-30', '1653692255335.png', 0.0),
(12, 1, 'chrisbarnes@example.com', '$2b$08$NmEeskztB3Vb2BTj9QhF1OWIPEFsazawdFztoW5iupWWaK4j3KZd2', 'Chris', 'Barnes', '80100100', 'm', '2000-06-29', '1653692357735.png', 0.0),
(13, 0, 'angeloadams@example.com', '$2b$08$upkZJ/SkhcECa4.FDBM47.NOnA7DnQEHzUOQe7ogwFiLdYG27kGVa', 'Angelo', 'Adams', '03900900', 'm', '1975-02-10', '1653692418829.png', 0.0),
(14, 0, 'louisasimmons@example.com', '$2b$08$Q4oUNdzEmSESmk51Cefqg.xjFvsHx1hM7vx4CbQsjZdlUpbFpxUua', 'Louisa', 'Simmons', '80911911', 'f', '1970-08-30', '1653692870415.png', 0.0),
(15, 1, 'timjenkins@example.com', '$2b$08$gD0t6Y1VebQFtmtVRRmZXegN6nD19EUQFWWENck3GO9jjzTx2.X2C', 'Tim', 'Jenkins', '80100100', 'm', '1994-06-29', '1653692954822.png', 2.4),
(16, 0, 'jeffreylopez@example.com', '$2b$08$nJxQ9jB9DMMb2QOQrTb3UentkmtMmvD9uf02BpUqxE3.CQaGUutvq', 'Jeffrey', 'Lopez', '05283913', 'm', '1990-03-24', '1653693131184.png', 0.0),
(17, 1, 'alicerogers@example.com', '$2b$08$EgZHRGENQDbG6zTKX7Ogq.o2zQ2o57mkHMyBHx30zUXBGcgtqYvDG', 'Alice', 'Rogers', '81800203', 'f', '2000-05-05', '1653693213643.png', 0.0),
(18, 1, 'kathmurphy@example.com', '$2b$08$wNblySMiuotY3dxh/klxo.8qGhOTePAnwRL5A9ZQPvfD1Y7kaaw1y', 'Kath', 'Murphy', '03884111', 'f', '1993-07-26', '1653693324984.png', 0.0),
(19, 0, 'lisamorris@example.com', '$2b$08$uUoaVRD44a08fo6p/ebZM.QoUwSEXbKhipUN5/Xaz5GhJG6qO41Qq', 'Lisa', 'Morris', '03555924', 'f', '1967-10-04', '1653693407626.png', 0.0),
(20, 1, 'alexmartin@example.com', '$2b$08$6F/gVHJgoSseoFDbSMjdwu.FClGyQ51CF4MLss2hmirAUH.ojl.x2', 'Alex', 'Martin', '70024742', 'm', '2002-09-13', '1653693576564.png', 0.0),
(21, 1, 'keithbenjamin@example.com', '$2b$08$vfxX1iYl8H9MbLRKvf39..yCuszvHDqdxumQBKzdZaJK90TMBAyCW', 'Keith', 'Benjamin', '03405789', 'm', '1982-04-19', '1653693664359.png', 0.0),
(22, 0, 'roysanders@example.com', '$2b$08$LNSBKrioO/n4xHIVMpT0y./LWj9yYuR.QD84Ww5RBXGU8Q/RXTTdi', 'Roy', 'Sanders', '80055008', 'm', '1988-10-04', '1653693748760.png', 0.0),
(23, 1, 'teresemitchell@example.com', '$2b$08$W6/1fazXV.NNYdKUrYs8ZugOHLCH8IdrdWGV7W.Gi27x0xIJSiEcC', 'Terese', 'Mitchell', '80314662', 'f', '1993-04-19', '1653693840789.png', 0.0),
(24, 1, 'jessiegonzales@example.com', '$2b$08$GDUU4j8DEXbzeyQJSnWbzuPgC7idEbAKGPVs2CL81ep7ujduNpJVe', 'Jessie', 'Gonzales', '79111197', 'f', '1997-01-01', '1653693907367.png', 0.0),
(25, 0, 'sammiranda@example.com', '$2b$08$y1BxbtC6uxX43sM69XaWX.ulqGx.6XLt56wlBkMjaN95mjZeKb59O', 'Sam', 'Miranda', '80135404', 'm', '1990-01-04', '1653694162154.png', 0.0),
(26, 0, 'marieprince@example.com', '$2b$08$9mG0zptPKWmv8piEIkSpre2VCScfUr7jcsEl8JtW8TLFJ6wnwEgni', 'Marie', 'Prince', '70073258', 'f', '1979-03-18', '1653694283511.png', 0.0),
(27, 1, 'bellarussell@example.com', '$2b$08$fSW/LkSI.RmP1vqDgFVsU.ANplYoS1q22NS0yPhCvdhfMGxq1Bosq', 'Bella', 'Russell', '05828595', 'f', '1996-10-20', '1653694381187.png', 0.0),
(28, 1, 'mayasmith@example.com', '$2b$08$A2N5oYnmxBpJK/6QTEoiNu63gkUgmoQVtc5DBFR8TSHnJrTpnM.T.', 'Maya', 'Smith', '03040721', 'f', '1994-11-23', '1653694435979.png', 0.0),
(29, 1, 'rogerwhite@example.com', '$2b$08$NA1po9tGa37dZ/Sz1GGBnOyYwLtDrnCerw7ZK.eSUV/35XkBYTtji', 'Roger', 'White', '71994994', 'm', '1994-09-14', '1653694628881.png', 0.0),
(30, 1, 'harryhill@example.com', '$2b$08$ANpAiz1ER.ydkluCjlU3n.DJ/nKx4ZwZmWdUNP..RDx2CsB7WwC0O', 'Harry', 'Hill', '80847663', 'm', '1994-12-13', '1653694896974.png', 0.0),
(31, 0, 'kevinmartinez@example.com', '$2b$08$h66nTpIufNbiv6kbmd3CCOyDuODlLIP85Me.crri6We/VfToR154q', 'Kevin', 'Martinez', '81113115', 'm', '1979-06-06', '1653695004984.png', 0.0),
(32, 1, 'jonparker@example.com', '$2b$08$uRQs7Hrb0WjI6n4UAufluevQLFyrBoPUOSa5x70iN3EuH5bWzZ.Y6', 'Jon', 'Parker', '81001204', 'm', '2003-10-23', '1653695497774.png', 0.0),
(33, 0, 'peterogers@example.com', '$2b$08$BhsXcdyMRX4q1MiTgd7PKetdrvDK8EFRC7w0I1KuujanbmLZd/YyG', 'Pete', 'Rogers', '70101013', 'm', '1998-01-11', '1653695664102.png', 0.0),
(34, 0, 'marthabailey@exampe.com', '$2b$08$hv79JHifCuITuvil5dqCneuyOzZvltm2/whEsFMjlwpr.RS/wA0oi', 'Martha', 'Bailey', '01252224', 'f', '1988-12-16', '1653695754724.png', 0.0),
(35, 1, 'christinawood@example.com', '$2b$08$kGrJBnPFZuPWZI2b0TStAujHzRTRstizZ4oW776aVTuZfJxNALZja', 'Christina', 'Wood', '80771739', 'f', '1989-09-29', '1653695883193.png', 0.0),
(36, 0, 'lilliankelly@example.com', '$2b$08$CnBMh7G3yzxKTc.8Z/kdTenotGYv/POxepP1Zz5UBJzBnnUITSKRa', 'Lillian', 'Kelly', '70045045', 'f', '2000-12-16', '1653695957931.png', 0.0),
(37, 1, 'sarahgarcia@example.com', '$2b$08$Yuhxjj7sjExzYWUAVZjhXOUafGlhcbkUAd4pyxOd0mbz5pWKzDWyC', 'Sarah', 'Garcia', '81556556', 'f', '1999-02-01', '1653696120337.png', 0.0),
(38, 1, 'patrickmorgan@example.com', '$2b$08$reTpKEUlSPrd5d4rIQyLauVMOnm/3cuNaxodY72vqm4rRbiwQebyO', 'Patrick', 'Morgan', '05997997', 'm', '1976-11-14', '1653696247191.png', 0.0),
(39, 1, 'alanharris@example.com', '$2b$08$DI8BfwQWq/aO7zt38vTb2uUH3Ic1.o0v.3Tc3PUBZxZOKzJkCLOrO', 'Alan', 'Harris', '71717171', 'm', '1988-05-15', '1653696387860.png', 0.0),
(40, 1, 'kellyperez@example.com', '$2b$08$VgInLs7rIiPhLTgKTpIW9.nZt7S4T6PKO13gkLoLth3ZnMwpMZ/NC', 'Kelly', 'Perez', '81226223', 'f', '1996-08-11', '1653696494951.png', 0.0),
(41, 0, 'ryanpeters@example.com', '$2b$08$EHt3D9Aa/16L7kpUraCrtuw3ceZJ9KEQUrvVG2QrWxmkKcsjfqruS', 'Ryan', 'Peters', '01524553', 'm', '1984-03-28', '1653696587446.png', 0.0),
(42, 1, 'bobroberts@example.com', '$2b$08$mnedTTADLhXlHbvlNF2aROW1l7/gN5XCao8s/AJxjPc/Ax1uRyxG2', 'Bob', 'Robers', '80445752', 'm', '1984-03-25', '1653696875312.png', 0.0),
(43, 0, 'philvance@example.com', '$2b$08$FOhYyVAXcfz8Wb2/NTLSUOtEiklK/8bmypWZK7Z1zBluR60PRwTzC', 'Phil', 'Vance', '03542987', 'm', '1993-01-18', '1653696928585.png', 0.0),
(44, 0, 'peterclark@example.com', '$2b$08$WgT605pECi/vfjRHZu9D..7yCcQvjH4TxI1ijfyMVGm230EPBkOYu', 'Peter', 'Clark', '71652819', 'm', '1997-07-27', '1653696980573.png', 0.0),
(45, 0, 'sarajones@example.com', '$2b$08$6r9d7Wla4yI3VuXBCgpxx.oF5eyDDuXq9DdNgpGqVIeJgOBwAddtm', 'Sara', 'Jones', '82165937', 'f', '1981-06-19', '1653697027374.png', 0.0),
(46, 0, 'christinejones@example.com', '$2b$08$JxZfgDJD9BegCdVx8Ao9BeeUQKqiKxlB2753Jfwx.TaD9ANRxDfxW', 'Christine', 'Jones', '81100600', 'f', '1988-08-08', '1653697078792.png', 0.0),
(47, 0, 'juliacarlos@example.com', '$2b$08$PhUQeT2lszgsqcabd3KqO.8vVJ5AbbVzdoyufP.RKIViov.lCeVIS', 'Julia', 'Carlos', '71554558', 'f', '2001-11-01', '1653697150046.png', 0.0),
(48, 0, 'josephadam@example.com', '$2b$08$lKyNVRw7DRVve3Cg7C/S4usTNC64Wab6/8AKbtjsjfHt5NBZubO8u', 'Joseph', 'Adam', '70940553', 'm', '1994-12-09', '1653697222231.png', 0.0),
(49, 0, 'anthonyroberto@example.com', '$2b$08$h.C.PpnkysmZ63w/FJxfNOaH9SSvcQMqCyGW9EaXqPDL2rtjQkzxu', 'Anthony', 'Roberto', '81444777', 'm', '1986-07-29', '1653697281582.png', 0.0),
(50, 1, 'carlwilliams@example.com', '$2b$08$0se9trdwzGe2LgZcEN.K1OfgwjauvVlYHPQy4hACBrM8dcoxGYbuq', 'Carl', 'Williams', '81225225', 'm', '1985-03-25', '1653697347134.png', 0.0),
(51, 0, 'tombutler@example.com', '$2b$08$qqEehuN6rZwus40I2seNg.sbi/P47XI6tAwalVOvSLw81xsH6aIZC', 'Tom', 'Butler', '80006006', 'm', '1992-02-20', '1653697406222.png', 0.0),
(52, 0, 'timmyking@example.com', '$2b$08$rBAHMacb/E9sPq2ZKIIVVe2P2x8NbjyIBu9LSYQq1B0/Qw9LFNg/K', 'Timmy', 'King', '03567567', 'm', '0016-06-16', '1653697472868.png', 0.0),
(53, 1, 'joannabello@example.com', '$2b$08$bN7nefLuC6bKP531GcTwDuPv8VA6CTIvzEIj5LU1wmajvkZppl6R.', 'Joanna', 'Bello', '81225225', 'f', '2000-05-23', '1653697543708.png', 0.0),
(54, 0, 'cynthiarice@example.com', '$2b$08$vT31j8Rwv9SRDscnVPzIk./CygRALHKwQL4w.qgsh1bNN9CTLC9I.', 'Cynthia', 'Rice', '03444441', 'f', '1994-04-30', '1653697600251.png', 0.0),
(55, 1, 'viktoriarobin@example.com', '$2b$08$PMZLy5pRh7jDL0zU/w6yu.gLnXIuBjZApXwO3GbxvZJWjVCu6SRgm', 'Viktoria', 'Robin', '80611633', 'f', '1998-12-31', '1653697682553.png', 0.0),
(56, 1, 'bengonzales@example.com', '$2b$08$SlSx2SNVd.qLrSnCeJ322OLxSHp28rV2/3aMWsIqSNPUfuEHR4dqu', 'Ben', 'Gonzalez', '71777778', 'm', '1995-10-10', '1653697728523.png', 0.0),
(57, 0, 'mariojackson@example.com', '$2b$08$8hdViW1El66AGnaeZOJvsu07FAsHYzx1WMR4uzts5rS/Kn1NfVLUe', 'Mario', 'Jackson', '01445732', 'm', '1991-10-18', '1653697778950.png', 0.0),
(58, 0, 'danilong@example.com', '$2b$08$U1bKLIJMuB7nh0F3//f1DOzSfKhHU2MPn54nkz.l1spXsdg5UcXbe', 'Dani', 'Long', '70888888', 'm', '1993-01-30', '1653697835525.png', 0.0),
(59, 1, 'johngray@example.com', '$2b$08$HYHUZ3pzzhav8I92aIMXj.0NlmJcaziCE1v/hrg62TuWS4Aaf5nzm', 'John', 'Gray', '03999888', 'm', '1976-03-12', '1653697887701.png', 0.0),
(60, 1, 'zackjackson@example.com', '$2b$08$gkhMDhV9znXLHl0mSE5yUuHA4tdLglqmZQUEHjNNtnoU0CETZZPUe', 'Zack', 'Jackson', '70533533', 'm', '1999-12-14', '1653697929392.png', 0.0),
(61, 1, 'danhernandez@example.com', '$2b$08$zIWxz4WBGjiccicgm8DZ8.MAheTkMdnw2ibh3a8g5qYXrymPk6tve', 'Dan', 'Hernandez', '71787963', 'm', '1978-12-11', '1653697983231.png', 0.0),
(62, 1, 'briangriffin@example.com', '$2b$08$CSLQQAmBUnXxU4PWPNrz4uRwLXgD/38E4N8tKrfRPBmsUSbTzl2Lm', 'Brian', 'Griffin', '01123123', 'm', '1969-11-11', '1653698055127.png', 0.0),
(63, 0, 'harryroberto@example.com', '$2b$08$HUDkx/CDGFKeZjs23z0oheVapL0lZ1r75EnNACeHIBdCQPro8WdwK', 'Harry', 'Roberto', '05666777', 'm', '1992-06-16', '1653698101244.png', 0.0),
(64, 0, 'matthewlee@example.com', '$2b$08$lP19utdailvaAJMsB0rRhOeJ6nOfi4.R9sdKkou8sRSmC4LBbPia6', 'Matthew', 'Lee', '03456456', 'm', '1976-06-16', '1653698146715.png', 0.0),
(65, 1, 'dianarobinson@example.com', '$2b$08$SxoYSYnN/9qMfZZJNV01ruPTKCHYRMzlW4w0pbtjFKeRCL6d9RduS', 'Diana', 'Robinson', '70898636', 'f', '1988-12-25', '1653698189683.png', 0.0),
(66, 1, 'caroldiaz@example.com', '$2b$08$8oflt/ePd5k3faW49lywOuHoDuFi2Fs8Skuw9cwuvMy5QAFz79Q8C', 'Carol', 'Diaz', '03554578', 'f', '1976-12-25', '1653698578096.png', 0.0),
(67, 1, 'donnawalker@example.com', '$2b$08$MdvJc5pBCcKcTSVeCjcTJODOrftQeU4bFYPgE.CNz.N8CLf.fz/1W', 'Donna', 'Walker', '03687687', 'f', '1958-12-25', '1653698627562.png', 0.0),
(68, 0, 'danielleperry@example.com', '$2b$08$icvIXboBNLKK/fuvuetXPu13aEAIpAKJHSPM.2qmaEhxwQDY0dfNe', 'Danielle', 'Perry', '80056065', 'f', '1987-04-19', '1653698738889.png', 0.0),
(69, 1, 'pamelaoscar@example.com', '$2b$08$9QC9qS8sMUrPVmDxbxXRru2lsHWlVc.3v/efZIb3Af6U7CZrFaGxa', 'Pamela', 'Oscar', '03222555', 'f', '1981-01-31', '1653698935057.png', 0.0),
(70, 0, 'mariayoung@example.com', '$2b$08$.eB4EuFe.XTA9IPcX/z9dOcOgF.KC23GBlzs8XWWbVLKSugNoakqC', 'Maria', 'Young', '71000745', 'f', '1999-09-24', '1653699048658.png', 0.0),
(71, 0, 'sandralong@example.com', '$2b$08$dkK5raowdibdzsmR2e4BCuniBu7uLfNF70HghhMvmLyaUpdysM0Ke', 'Sandra', 'Long', '71789789', 'f', '1984-02-28', '1653699103293.png', 0.0),
(72, 0, 'julieanderson@example.com', '$2b$08$3fyV4nHsGlrMrzS0JZP3FukzwFPLFLIeCDu06.HAS8jw0QEVS.6QG', 'Julie', 'Anderson', '03852852', 'f', '1961-03-17', '1653699149749.png', 0.0),
(73, 0, 'suzanneturner@example.com', '$2b$08$G6IU.4mmc0yShMufDJZAduKkVhdNvCWmJc0OC3coDxHFhUQ8JY.3W', 'Suzanne', 'Turner', '03456654', 'f', '1969-08-24', '1653699215098.png', 0.0),
(74, 0, 'jennycoleman@example.com', '$2b$08$qCG2ssCr1Yn6kcmJDFlWjuLER1eonDqwioxYkkoF6wrKpDd5HXMJ.', 'Jenny', 'Coleman', '71333000', 'f', '1976-12-05', '1653699277079.png', 0.0),
(75, 0, 'mayaross@example.com', '$2b$08$3Oy02/9JLSPcLTN1jbtI3unHX1OojjnALdqbiDb4XeqASp3DYntA2', 'Maya', 'Ross', '70327988', 'f', '1999-09-09', '1653699528280.png', 0.0),
(76, 0, 'nicolestewart@example.com', '$2b$08$/2kfrznhuQtTprNfNIAxfOUNiyjGd5xpvaqraKVKvbVsPV5IzavRe', 'Nicole', 'Stewart', '03568568', 'f', '1966-09-27', '1653699639932.png', 0.0),
(77, 0, 'louismitchell@example.com', '$2b$08$YnrnKynIbqnKiA.t.jn6COk6Cbzd5BrNh2qKMjSjN.lxUaAPg4s42', 'Louis', 'Mitchell', '70555555', 'm', '1997-11-19', '1653700299302.png', 0.0),
(78, 1, 'jeffreydiaz@example.com', '$2b$08$0VgphD7Atc8Qgycqqbf81uXl.rqGqKZ6040seOgKPs1677iVrjcXa', 'Jeffrey', 'Diaz', '71414141', 'm', '1977-02-14', '1653700435312.png', 0.0),
(79, 1, 'tombailey@example.com', '$2b$08$1ZawSvD6EbVVp0oh/kiz7uKKCH6wC7a4FQHrTIO0EqXgBOsCAcVYe', 'Tom', 'Bailey', '80007096', 'm', '1984-06-21', '1653700477449.png', 0.0),
(80, 1, 'garyjames@example.com', '$2b$08$4lsEiRPLPnQ/UamMjVrSsO5iNSXHCJEVbQTA5YvWIsd6e7uV3k79y', 'Gary', 'James', '03777666', 'm', '1982-06-14', '1653700521454.png', 0.0),
(81, 0, 'jerryparker@example.com', '$2b$08$UY/ZbH4uT7BFecPSYNl3Euz5mVnFa8XF0UHiLzfjTu6siAI6DuUMm', 'Jerry', 'Parker', '01222312', 'm', '1962-07-17', '1653700641621.png', 0.0),
(82, 0, 'joshthomas@example.com', '$2b$08$falDNL2nj1MwyWmoe86rc.YfJRx/wUbMYgyedxF15TNpkO4WQFLV2', 'Josh', 'Thomas', '71650660', 'm', '1999-06-03', '1653700692836.png', 0.0),
(83, 0, 'fernandocook@example.com', '$2b$08$VOS6RlxxqEtrohw5PzWsX.tGuypVCp/22eqb8Xn3q6zSyhNzY0OTu', 'Fernando', 'Cook', '71554557', 'm', '1986-12-08', '1653700762297.png', 0.0),
(84, 0, 'samrivera@example.com', '$2b$08$ixyAzaR69lDebYixa4O3he0Mp65YNhyWYHFNEd7c7NEo.K2gQXUdu', 'Sam', 'Rivera', '03547521', 'm', '1987-10-05', '1653700795169.png', 0.0),
(85, 1, 'martinwashington@example.com', '$2b$08$fAkshXYfKAEVMiZ49kbN9uO0czYc.OEnq9oAJHZub30t39k3Fv..S', 'Martin', 'Washington', '81256877', 'm', '1998-03-02', '1653700869096.png', 0.0),
(86, 1, 'nicolasnelson@example.com', '$2b$08$OZ0kBSD7h5A./9Pa2KMJmeW.eBW5megylUu3JpGwMz7OEmIDrAevy', 'Nicolas', 'Nelson', '03571266', 'm', '1989-11-29', '1653700956209.png', 0.0),
(87, 0, 'parkercollins@example.com', '$2b$08$oOTYcxcPJSNoevjlayjKP.zATArw.vRrDZDpZQXXRZ1eMalRFi.ie', 'Parker', 'Collins', '03822262', 'm', '1985-06-30', '1653701009005.png', 0.0),
(88, 0, 'kennysimmons@example.com', '$2b$08$j1GFZEzxaIXxF7ptXjRgJuRTXHLisQ4zZb6ojpy9fw91.4kF2kk26', 'Kenny', 'Simmons', '01224789', 'm', '1959-08-17', '1653701051864.png', 0.0),
(89, 0, 'elenarodriguez@example.com', '$2b$08$042UmF5ASfXadlrKQxdTb.qgf8kZtkTpG8.xTxg7/HbVm0F8PSAV2', 'Elena', 'Rodriguez', '70547532', 'f', '1984-09-28', '1653701096740.png', 0.0),
(90, 0, 'rachellawrence@example.com', '$2b$08$.ZARSZbP79qZLlQV0IKkhe7KeOtfCX70CHV/Re4rhCk/mn.d0tD1u', 'Rachel', 'Lawrence', '03258741', 'f', '1981-08-27', '1653701136230.png', 0.0),
(91, 1, 'kennalopez@example.com', '$2b$08$fgMYLPbzfU6lttGUt0lJOurSGJPuYpl4Ub81BE0.aQqrj.9JSCPH6', 'Kenna', 'Lopez', '70054899', 'f', '2000-11-02', '1653701184217.png', 0.0),
(92, 0, 'paulinaturner@example.com', '$2b$08$LKJp6Ea.T3nnGgda99DD7.OaLEegqQ/RzeHKz8LOGxgHneNhNgBaG', 'Paulina', 'Turner', '71548536', 'f', '1987-04-15', '1653701220751.png', 0.0),
(93, 0, 'claraprice@example.com', '$2b$08$hM.dvQEe3hwVlVVW6uP7ruA7J2loR81.k9WzcmhkqnMocIylqIa96', 'Clara', 'Price', '80664733', 'f', '1999-05-17', '1653701265297.png', 0.0),
(94, 0, 'rosagarcia@example.om', '$2b$08$Xm8SJte9oj6CkZYYWO7KxOngjwffaH3aKEJiHQfUxOXQBqN92Raxa', 'Rosa', 'Garcia', '81552554', 'f', '1976-06-27', '1653701306700.png', 0.0),
(95, 0, 'helenwalker@example.com', '$2b$08$drIzW/MzpKXbXlqmSYssHuHD6B2Ak30SOmADR1UsjdnoDJoDdE1a.', 'Helen', 'Walker', '03547896', 'f', '1964-06-27', '1653701341858.png', 0.0),
(96, 0, 'marylopez@example.com', '$2b$08$FgDYhDN3TVIPr.BGPcJWz.Fef0AsJxSTGlDVjTpaDcPbhpbyAcVbC', 'Mary', 'Lopez', '01478999', 'f', '1961-08-18', '1653701384857.png', 0.0),
(97, 1, 'dianasanchez@example.com', '$2b$08$aTF.vj9QKGlQGuW2uKYgAeTHQk1tEcKNh5yQ7l6v36rI7lGMXJO/G', 'Diana', 'Sanchez', '01478777', 'f', '1982-10-26', '1653701444621.png', 0.0),
(98, 0, 'eddycarter@example.com', '$2b$08$1lWp7ueI5ElsLRgscpm0M.63hSBM6A38r5i4OHqvnjRizvmk5Ke1m', 'Eddy', 'Carter', '70969998', 'm', '2002-05-01', '1653701504434.png', 0.0),
(99, 0, 'rosemiller@example.com', '$2b$08$K7YdbXqxrRebo972Om9/9Oy9mXqnZfVMRXVkzvZ1J9t.OfwzV1yQm', 'Rose', 'Miller', '01222555', 'f', '1959-01-01', '1653701558140.png', 0.0),
(100, 0, 'marinajackson@example.com', '$2b$08$7T3Pj0jaVRb80sTmETkaIO7Zr/LSQmFwI/71eDpX0HxZ3V.2ABNB.', 'Marina', 'Jackson', '01457457', 'f', '1979-06-28', '1653701620812.png', 0.0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`chat_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indexes for table `employee_timeslots`
--
ALTER TABLE `employee_timeslots`
  ADD PRIMARY KEY (`timeslot_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `to_id` (`to_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `forgot_codes`
--
ALTER TABLE `forgot_codes`
  ADD PRIMARY KEY (`code_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`),
  ADD KEY `services_ibfk_1` (`category_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `employee_timeslots`
--
ALTER TABLE `employee_timeslots`
  MODIFY `timeslot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `forgot_codes`
--
ALTER TABLE `forgot_codes`
  MODIFY `code_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_timeslots`
--
ALTER TABLE `employee_timeslots`
  ADD CONSTRAINT `employee_timeslots_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`from_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`to_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `feedback_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `services_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
