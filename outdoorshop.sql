-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 05, 2026 at 05:30 AM
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
-- Database: `outdoorshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `Id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`Id`, `Name`, `Description`) VALUES
(1, 'Палатки', 'Палатки за къмпинг, туризъм и планина'),
(2, 'Раници', 'Туристически и туристически раници'),
(3, 'Спални чували', 'Спални чували за къмпинг и планина'),
(4, 'Челници и фенери', 'Челници, фенери и осветление'),
(5, 'Дрехи', 'Outdoor дрехи за различни атмосферни условия'),
(6, 'Шапки', 'Шапки за туризъм и свободно време'),
(7, 'Обувки', 'Туристически обувки и обувки за планина'),
(8, 'Туристическа екипировка', 'Екипировка за преходи и приключения'),
(9, 'Къмпинг оборудване', 'Оборудване за къмпинг и лагеруване'),
(10, 'Аксесоари', 'Различни полезни outdoor аксесоари');

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `Id` int(11) NOT NULL,
  `OrderId` int(11) NOT NULL,
  `ProductId` int(11) NOT NULL,
  `ProductName` longtext NOT NULL,
  `Price` decimal(65,30) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `TotalPrice` decimal(65,30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`Id`, `OrderId`, `ProductId`, `ProductName`, `Price`, `Quantity`, `TotalPrice`) VALUES
(1, 1, 1, 'Mountain Tent 2P', 249.990000000000000000000000000000, 1, 249.990000000000000000000000000000),
(2, 2, 1, 'Mountain Tent 2P', 249.990000000000000000000000000000, 1, 249.990000000000000000000000000000),
(3, 3, 1, 'Mountain Tent 2P', 249.990000000000000000000000000000, 1, 249.990000000000000000000000000000),
(4, 4, 1, 'Mountain Tent 2P', 249.990000000000000000000000000000, 1, 249.990000000000000000000000000000);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Id` int(11) NOT NULL,
  `CustomerName` longtext NOT NULL,
  `Email` longtext NOT NULL,
  `Phone` longtext NOT NULL,
  `Address` longtext NOT NULL,
  `TotalPrice` decimal(65,30) NOT NULL,
  `CreatedAt` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`Id`, `CustomerName`, `Email`, `Phone`, `Address`, `TotalPrice`, `CreatedAt`) VALUES
(1, 'Darin Zdravchev', 'darinzdravchev48@gmail.com', '0878955498', 'Car Boris 1 N18', 249.990000000000000000000000000000, '2026-08-09 13:45:27.986162'),
(2, 'Darin Zdravchev', 'darinzdravchev48@gmail.com', '0878955498', 'Car Boris 1 N18', 249.990000000000000000000000000000, '2026-08-09 13:51:33.920967'),
(3, 'Darin Zdravchev', 'darinzdravchev48@gmail.com', '0878955498', 'Car Boris 1 N18', 249.990000000000000000000000000000, '2026-08-09 14:24:41.765760'),
(4, 'Darin Zdravchev', 'darinzdravchev48@gmail.com', '0878955498', 'Car Boris 1 N18', 249.990000000000000000000000000000, '2026-08-09 14:29:48.359428');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `Id` int(11) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `Description` text DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Stock` int(11) NOT NULL DEFAULT 0,
  `ImageUrl` varchar(255) DEFAULT NULL,
  `CategoryId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`Id`, `Name`, `Description`, `Price`, `Stock`, `ImageUrl`, `CategoryId`) VALUES
(1, 'Mountain Tent 2P', 'Лека двуместна палатка за планина и къмпинг.', 249.99, 10, '/images/tent.jpg', 1),
(2, 'Trekking Backpack 40L', 'Удобна туристическа раница с обем 40 литра.', 129.99, 15, '/images/backpack.jpg', 2),
(3, 'Winter Sleeping Bag', 'Топъл спален чувал за студено време.', 159.99, 8, '/images/sleepingbag.jpg', 3),
(4, 'LED Headlamp Pro', 'Мощен LED челник с регулируема светлина.', 49.99, 20, '/images/headlamp.jpg', 4),
(5, 'Outdoor Jacket', 'Водоустойчиво яке за туризъм и планина.', 179.99, 12, '/images/jacket.jpg', 5),
(6, 'Mountain Cap', 'Лека шапка за туризъм и свободно време.', 29.99, 25, '/images/cap.jpg', 6),
(7, 'Hiking Boots', 'Здрави туристически обувки за планински преходи.', 219.99, 7, '/images/boots.jpg', 7),
(8, 'Trekking Poles', 'Телескопични щеки за планински преходи.', 69.99, 18, '/images/poles.jpg', 8),
(9, 'Camping Cooking Set', 'Комплект за готвене по време на къмпинг.', 59.99, 14, '/images/cooking.jpg', 9),
(10, 'Outdoor Multi Tool', 'Практичен мултифункционален инструмент за туризъм.', 39.99, 30, '/images/multitool.jpg', 10);

-- --------------------------------------------------------

--
-- Table structure for table `__efmigrationshistory`
--

CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `__efmigrationshistory`
--

INSERT INTO `__efmigrationshistory` (`MigrationId`, `ProductVersion`) VALUES
('20260809102757_InitialCreate', '9.0.8');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IX_OrderItems_OrderId` (`OrderId`),
  ADD KEY `IX_OrderItems_ProductId` (`ProductId`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `CategoryId` (`CategoryId`);

--
-- Indexes for table `__efmigrationshistory`
--
ALTER TABLE `__efmigrationshistory`
  ADD PRIMARY KEY (`MigrationId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `FK_OrderItems_Orders_OrderId` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_OrderItems_Products_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `products` (`Id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`CategoryId`) REFERENCES `categories` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
