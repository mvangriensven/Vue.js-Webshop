-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2022 at 03:31 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `final_webshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `adresses`
--

CREATE TABLE `adresses` (
  `id` int(11) NOT NULL,
  `place` varchar(50) NOT NULL,
  `street` varchar(50) NOT NULL,
  `zipcode` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `adresses`
--

INSERT INTO `adresses` (`id`, `place`, `street`, `zipcode`) VALUES
(1, 'Amsterdam', 'Jodenbreestraat 25', '1011 NH'),
(2, 'Amsterdam', 'Museumstraat 1', '1071 XX'),
(3, 'Amsterdam', 'Dam 20', '1012 NP');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`) VALUES
(1, 'Ikea\'s Sofas'),
(2, 'Ikea\'s Lighting'),
(3, 'Ikea\'s Furniture'),
(4, 'Ikea\'s Lounge Chairs');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'FURNITURE'),
(2, 'LIGHTING'),
(3, 'SOFAS'),
(4, 'LOUNGE CHAIRS');

-- --------------------------------------------------------

--
-- Table structure for table `featured`
--

CREATE TABLE `featured` (
  `productId` int(11) NOT NULL,
  `startDate` datetime NOT NULL,
  `expiryDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `featured`
--

INSERT INTO `featured` (`productId`, `startDate`, `expiryDate`) VALUES
(2, '2022-05-01 01:28:44', '2031-06-04 01:28:44'),
(3, '2012-06-02 01:28:44', '2032-06-04 01:28:44'),
(6, '2012-06-01 01:43:48', '2032-06-05 01:43:48'),
(7, '2012-06-01 01:43:48', '2032-06-24 01:43:48'),
(11, '2012-06-01 02:05:20', '2032-06-04 02:05:20'),
(12, '2012-06-01 02:05:20', '2032-06-12 02:05:20'),
(13, '2012-06-01 02:34:05', '2032-06-26 02:34:05'),
(15, '2012-06-02 02:34:05', '2032-06-26 02:34:05');

-- --------------------------------------------------------

--
-- Table structure for table `orderedproducts`
--

CREATE TABLE `orderedproducts` (
  `id` int(11) NOT NULL,
  `orderid` int(11) NOT NULL,
  `productid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orderedproducts`
--

INSERT INTO `orderedproducts` (`id`, `orderid`, `productid`) VALUES
(11, 16, 1),
(12, 16, 1),
(13, 17, 1),
(14, 17, 3),
(15, 17, 14),
(16, 18, 4),
(17, 18, 4),
(18, 19, 5),
(19, 19, 9);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `address` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user`, `address`, `date`) VALUES
(16, 1, 2, '2022-07-15 18:41:06'),
(17, 1, 2, '2022-07-18 17:33:10'),
(18, 2, 1, '2022-07-20 15:06:53'),
(19, 3, 3, '2022-07-20 15:07:21');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `brandId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `inventory` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(535) NOT NULL,
  `description` varchar(500) NOT NULL,
  `specifications` varchar(500) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `brandId`, `categoryId`, `inventory`, `name`, `image`, `description`, `specifications`, `price`) VALUES
(1, 1, 3, 5, 'KLIPPAN', 'https://www.ikea.com/nl/nl/images/products/klippan-2-zitsbank-bomstad-zwart__0827136_pe709127_s5.jpg', 'Sink away in the soft comfort of the KIVIK couch.', '3-sits, Black', 999.99),
(2, 1, 3, 0, 'KIVIK', 'https://www.ikea.com/nl/nl/images/products/kivik-3-zitsbank-grann-bomstad-zwart__0788744_pe763716_s5.jpg', 'Sink away in the comfort of the KIVIK couch.', '3-sits, Black', 999.99),
(3, 1, 3, 8, 'LANDSKRONA', 'https://www.ikea.com/nl/nl/images/products/landskrona-3-zitsbank-grann-bomstad-zwart-metaal__0321002_pe514786_s5.jpg', 'Sink away in the comfort of the LANDSKRONA couch.\n', '3-sits, Black', 999.99),
(4, 1, 3, 22, 'KLIPPAN', 'https://www.ikea.com/nl/nl/images/products/klippan-2-zitsbank-blauw__0979545_pe814594_s5.jpg', 'Sink away in the comfort of the KLIPPAN 2-sits couch.\r\n', '2-sits, Blue', 999.99),
(5, 2, 2, 12, 'RINGSTA', 'https://www.ikea.com/nl/nl/images/products/ringsta-lampenkap-lichtgroen__0782964_pe761404_s5.jpg', 'A lamp cover made out of textile.', '100% Textile, White', 6.99),
(6, 2, 2, 53, 'LAUTERS', 'https://www.ikea.com/nl/nl/images/products/lauters-staande-lamp-bruin-essen-wit__0714122_pe729943_s5.jpg', 'The lampshade on this lamp is made out of recycled materials.', 'Made out of recycled bottles, Very bright!', 59.95),
(7, 2, 2, 0, 'Desklamp', 'https://www.ikea.com/nl/nl/images/products/forsa-bureaulamp-zwart__0880523_pe614068_s5.jpg', 'Classic steel-made desklamp.', 'Steel, Very bright!', 19.99),
(8, 2, 2, 93, 'Wall lamp', 'https://www.ikea.com/nl/nl/images/products/ranarp-wand-klemspot-ecru__0879054_pe619930_s5.jpg', 'These lamps can be mounted directly onto a wall, shelves or similar.', 'Steel, Very bright!', 24.99),
(9, 3, 1, 23, 'SANDSBERG', 'https://www.ikea.com/nl/nl/images/products/sandsberg-tafel-en-4-stoelen-zwart-zwart__1027686_pe834983_s5.jpg', 'An elegant design that blends in well with its environment.', 'Includes 4 chairs, Black', 139.99),
(10, 3, 1, 9, 'JOKKMOKK', 'https://www.ikea.com/nl/nl/images/products/jokkmokk-tafel-en-4-stoelen-antiekbeits__0870916_pe716638_s5.jpg', 'A simple but robust design.', 'Includes 4 chairs, Wood', 199.99),
(11, 3, 1, 2, 'JANNINGE', 'https://www.ikea.com/nl/nl/images/products/ikea-ps-2012-janinge-tafel-en-4-stoelen-bamboe-wit__0871971_pe595111_s5.jpg', 'Very compact in size, perfectly suits smaller rooms.', 'Includes 4 chairs, Bamboo/White', 378.99),
(12, 3, 1, 91, 'APPLARO', 'https://www.ikea.com/nl/nl/images/products/applaro-tafel-2-armleunstoelen-bank-buiten-bruin-gelazuurd__0906055_pe619185_s5.jpg', 'Made out of acacia wood from reusable sources.', 'Includes 2 seats, Brown finish', 368.99),
(13, 4, 4, 4, 'APPLARO', 'https://www.ikea.com/nl/nl/images/products/applaro-tafel-8-tuinstoelen-buiten-bruin-gelazuurd-kuddarna-beige__0667529_pe713939_s5.jpg', 'Made out of acacia wood from reusable sources.', 'Includes 2 chairs, White pillows, Brown finish', 897.99),
(14, 4, 4, 0, 'BONDHOLMEN', 'https://www.ikea.com/nl/nl/images/products/bondholmen-tafel-3-leunstoelen-bank-buiten-grijs-gelazuurd-jarpon-duvholmen-wit__0806220_pe769862_s5.jpg', 'Enjoy the comfort of BONDHOLMEN outside.', 'Made out of eucalyptus, Gray/Silver', 897.99),
(15, 4, 4, 0, 'SJALLAND', 'https://www.ikea.com/nl/nl/images/products/sjalland-tafel-6-leunstoelen-buiten-donkergrijs-froson-duvholmen-donkergrijs__0907379_pe693236_s5.jpg', 'Enjoy the beauty of metal.', 'Includes 6 chairs, dark gray', 774.99),
(16, 4, 4, 3, 'TARNO', 'https://www.ikea.com/nl/nl/images/products/tarno-tafel-2-stoelen-buiten-zwart-lichtbruin-gelazuurd-kuddarna-beige__0667583_pe713986_s5.jpg', 'A clean metal design.', 'Includes 2 chairs, metal', 81.99);

-- --------------------------------------------------------

--
-- Table structure for table `sale`
--

CREATE TABLE `sale` (
  `productId` int(11) NOT NULL,
  `price` float NOT NULL,
  `startDate` datetime NOT NULL,
  `expiryDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sale`
--

INSERT INTO `sale` (`productId`, `price`, `startDate`, `expiryDate`) VALUES
(1, 799.99, '2022-06-18 01:29:49', '2022-06-18 01:29:49'),
(4, 699.99, '2022-06-18 01:29:49', '2022-06-18 01:29:49'),
(5, 2.99, '2012-06-01 01:42:36', '2032-06-18 01:42:36'),
(8, 3.99, '2012-06-09 01:42:36', '2031-06-28 01:42:36'),
(9, 5.99, '2013-06-01 02:03:45', '2032-06-05 02:03:45'),
(10, 5.99, '2012-06-01 02:03:45', '2032-06-19 02:03:45'),
(14, 5.99, '2012-06-01 02:34:36', '2031-06-07 02:34:36'),
(16, 5.99, '2012-06-01 02:34:36', '2032-06-04 02:34:36');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `token` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `userId`, `token`) VALUES
(49, 1, 'dOpO2AvePYc2q98SAFDulk8cwaL9mbqUIwHOBHGU00cglgtHHC');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(535) NOT NULL,
  `address` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password`, `address`) VALUES
(1, 'John', 'Doe', 'john@doe.com', '$2y$10$wwYpvGy/UNzguN5OymJKS.U5uoybqEgSWfHP5If/YeCtdfV81Dtju', 2),
(2, 'John', 'Doe', 'john1@doe.com', '$2y$10$wwYpvGy/UNzguN5OymJKS.U5uoybqEgSWfHP5If/YeCtdfV81Dtju', 1),
(3, 'John', 'Doe', 'john2@doe.com', '$2y$10$wwYpvGy/UNzguN5OymJKS.U5uoybqEgSWfHP5If/YeCtdfV81Dtju', 3),
(4, 'John', 'Doe', 'john3@doe.com', '$2y$10$90RheMh/DYM/A8.nW8Y8Cux.CVY3hy1uDr0UpGfM8CgtmkeR97xUK', 1),
(5, 'John', 'Doe', 'john4@doe.com', '$2y$10$wwYpvGy/UNzguN5OymJKS.U5uoybqEgSWfHP5If/YeCtdfV81Dtju', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adresses`
--
ALTER TABLE `adresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_2` (`id`),
  ADD UNIQUE KEY `id_3` (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `featured`
--
ALTER TABLE `featured`
  ADD PRIMARY KEY (`productId`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `orderedproducts`
--
ALTER TABLE `orderedproducts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `brandId` (`brandId`),
  ADD KEY `categoryId` (`categoryId`);

--
-- Indexes for table `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`productId`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `id_2` (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`,`email`),
  ADD KEY `id_2` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adresses`
--
ALTER TABLE `adresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orderedproducts`
--
ALTER TABLE `orderedproducts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `sale`
--
ALTER TABLE `sale`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
