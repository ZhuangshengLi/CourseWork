-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2022-12-03 08:22:18
-- 服务器版本： 10.4.21-MariaDB
-- PHP 版本： 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `cw？`
--

-- --------------------------------------------------------

--
-- 表的结构 `Ingredient`
--

CREATE TABLE `Ingredient` (
  `Ingredient` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `manufacturing_costs`
--

CREATE TABLE `manufacturing_costs` (
  `Time` date NOT NULL,
  `Package style` varchar(255) NOT NULL,
  `Cost` int(15) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Li Leyan 2143482';

-- --------------------------------------------------------

--
-- 表的结构 `Member_Month`
--

CREATE TABLE `Member_Month` (
  `Member ID` varchar(255) NOT NULL,
  `Month` int(2) NOT NULL,
  `Merit Pay` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Yuan Junyi 2142187';

-- --------------------------------------------------------

--
-- 表的结构 `Months`
--

CREATE TABLE `Months` (
  `Month` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Yuan Junyi 2142187';

-- --------------------------------------------------------

--
-- 表的结构 `ocean dew vending machines`
--

CREATE TABLE `ocean dew vending machines` (
  `Machines ID` varchar(255) NOT NULL,
  `Location Name` varchar(255) NOT NULL,
  `Team Name` varchar(255) NOT NULL,
  `warehouse id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `Package Designs`
--

CREATE TABLE `Package Designs` (
  `Package style` varchar(255) NOT NULL,
  `Drink` varchar(255) NOT NULL,
  `Main Material` varchar(255) NOT NULL,
  `Volume(ml)` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `packaging`
--

CREATE TABLE `packaging` (
  `product_id` varchar(255) NOT NULL,
  `cost` decimal(10,0) NOT NULL,
  `tolerance` varchar(30) NOT NULL,
  `eco_friendly` varchar(30) NOT NULL,
  `material` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `Position`
--

CREATE TABLE `Position` (
  `Position Name` varchar(255) NOT NULL,
  `Regular Pay` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Yuan Junyi 2142187';

-- --------------------------------------------------------

--
-- 表的结构 `Product`
--

CREATE TABLE `Product` (
  `Drink` varchar(255) NOT NULL,
  `Saturated Fat(g)` int(15) DEFAULT 0,
  `Trans-fatty acid(g)` int(15) DEFAULT 0,
  `Cholesterol(mg)` int(15) DEFAULT 0,
  `Carbohydrate(g)` int(15) DEFAULT 0,
  `Protein(g)` int(15) DEFAULT 0,
  `Vitamin D(mcg)` int(15) DEFAULT 0,
  `Calcium(mg)` int(15) DEFAULT 0,
  `Magnesium(mg)` int(15) DEFAULT 0,
  `Potassium(mg)` int(15) DEFAULT 0,
  `Total Calories` int(15) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `production information`
--

CREATE TABLE `production information` (
  `Production Serial` varchar(255) NOT NULL,
  `Package style` varchar(255) NOT NULL,
  `Production Date` date NOT NULL,
  `Expiry Date` date NOT NULL,
  `Machine ID` varchar(255) NOT NULL,
  `warehouse id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `production quality test`
--

CREATE TABLE `production quality test` (
  `Production Serial` varchar(255) NOT NULL,
  ` Test Date` date NOT NULL,
  `Is qualified` tinyint(1) NOT NULL,
  `Employee ID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Xiaioyi Zhang 2143468';

-- --------------------------------------------------------

--
-- 表的结构 `Product_Ingredient`
--

CREATE TABLE `Product_Ingredient` (
  `Drink` varchar(255) NOT NULL,
  `Ingredient` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `Recycle Station`
--

CREATE TABLE `Recycle Station` (
  `ID` varchar(255) NOT NULL,
  `Capacity` int(15) NOT NULL,
  `Contain` int(15) DEFAULT 0,
  `Date` date NOT NULL,
  `Location Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Li Zhuangsheng 2144979';

-- --------------------------------------------------------

--
-- 表的结构 `Staff Members`
--

CREATE TABLE `Staff Members` (
  `Member ID` varchar(255) NOT NULL,
  `Team name` varchar(255) NOT NULL,
  `Position Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Yuan Junyi 2142187';

-- --------------------------------------------------------

--
-- 表的结构 `Staff Teams`
--

CREATE TABLE `Staff Teams` (
  `Team Name` varchar(255) NOT NULL,
  `Phone Number` varchar(255) NOT NULL,
  `Truck` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `warehouse`
--

CREATE TABLE `warehouse` (
  `warehouse id` int(11) NOT NULL COMMENT 'AUTO_INCREMENT',
  `warehouse name` varchar(255) NOT NULL,
  `Location Name` varchar(255) NOT NULL,
  `drink_count` int(255) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='jingtong.cai 2144998';

--
-- 转储表的索引
--

--
-- 表的索引 `Ingredient`
--
ALTER TABLE `Ingredient`
  ADD PRIMARY KEY (`Ingredient`);

--
-- 表的索引 `manufacturing_costs`
--
ALTER TABLE `manufacturing_costs`
  ADD KEY `Packagestyle` (`Package style`);

--
-- 表的索引 `Member_Month`
--
ALTER TABLE `Member_Month`
  ADD PRIMARY KEY (`Member ID`,`Month`),
  ADD KEY `fk_Mon_Mon` (`Month`);

--
-- 表的索引 `Months`
--
ALTER TABLE `Months`
  ADD PRIMARY KEY (`Month`);

--
-- 表的索引 `ocean dew vending machines`
--
ALTER TABLE `ocean dew vending machines`
  ADD PRIMARY KEY (`Machines ID`),
  ADD UNIQUE KEY `Location Name` (`Location Name`),
  ADD KEY `fk_TeamName_TeamName` (`Team Name`),
  ADD KEY `fk_wid` (`warehouse id`);

--
-- 表的索引 `Package Designs`
--
ALTER TABLE `Package Designs`
  ADD PRIMARY KEY (`Package style`),
  ADD KEY `fk_Drinks_Drinks1` (`Drink`);

--
-- 表的索引 `packaging`
--
ALTER TABLE `packaging`
  ADD PRIMARY KEY (`product_id`);

--
-- 表的索引 `Position`
--
ALTER TABLE `Position`
  ADD PRIMARY KEY (`Position Name`);

--
-- 表的索引 `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`Drink`);

--
-- 表的索引 `production information`
--
ALTER TABLE `production information`
  ADD PRIMARY KEY (`Production Serial`),
  ADD KEY `fk_P_P` (`Package style`),
  ADD KEY `fk_wid1` (`warehouse id`),
  ADD KEY `fk_Ma_Ma` (`Machine ID`);

--
-- 表的索引 `production quality test`
--
ALTER TABLE `production quality test`
  ADD PRIMARY KEY (`Production Serial`),
  ADD UNIQUE KEY `Employee ID` (`Employee ID`);

--
-- 表的索引 `Product_Ingredient`
--
ALTER TABLE `Product_Ingredient`
  ADD PRIMARY KEY (`Drink`,`Ingredient`),
  ADD KEY `fk_P_I_D` (`Drink`),
  ADD KEY `fk_P_I_I` (`Ingredient`);

--
-- 表的索引 `Recycle Station`
--
ALTER TABLE `Recycle Station`
  ADD PRIMARY KEY (`ID`,`Date`),
  ADD KEY `fk_R_M` (`Location Name`);

--
-- 表的索引 `Staff Members`
--
ALTER TABLE `Staff Members`
  ADD PRIMARY KEY (`Member ID`),
  ADD KEY `fk _Tn_Tn` (`Team name`),
  ADD KEY `fk_Pn_Pn` (`Position Name`);

--
-- 表的索引 `Staff Teams`
--
ALTER TABLE `Staff Teams`
  ADD PRIMARY KEY (`Team Name`),
  ADD UNIQUE KEY `Phone Number` (`Phone Number`);

--
-- 表的索引 `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`warehouse id`),
  ADD UNIQUE KEY `warehouse name` (`warehouse name`);

--
-- 限制导出的表
--

--
-- 限制表 `manufacturing_costs`
--
ALTER TABLE `manufacturing_costs`
  ADD CONSTRAINT `Packagestyle` FOREIGN KEY (`Package style`) REFERENCES `package designs` (`Package style`);

--
-- 限制表 `Member_Month`
--
ALTER TABLE `Member_Month`
  ADD CONSTRAINT `fk_Me_Me` FOREIGN KEY (`Member ID`) REFERENCES `Staff Members` (`Member ID`),
  ADD CONSTRAINT `fk_Mon_Mon` FOREIGN KEY (`Month`) REFERENCES `Months` (`Month`);

--
-- 限制表 `ocean dew vending machines`
--
ALTER TABLE `ocean dew vending machines`
  ADD CONSTRAINT `fk_TeamName_TeamName` FOREIGN KEY (`Team Name`) REFERENCES `Staff Teams` (`Team Name`),
  ADD CONSTRAINT `fk_wid` FOREIGN KEY (`warehouse id`) REFERENCES `warehouse` (`warehouse id`);

--
-- 限制表 `Package Designs`
--
ALTER TABLE `Package Designs`
  ADD CONSTRAINT `fk_Drinks_Drinks1` FOREIGN KEY (`Drink`) REFERENCES `Product` (`Drink`);

--
-- 限制表 `packaging`
--
ALTER TABLE `packaging`
  ADD CONSTRAINT `packaging_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `production information` (`Production Serial`);

--
-- 限制表 `production information`
--
ALTER TABLE `production information`
  ADD CONSTRAINT `fk_Ma_Ma` FOREIGN KEY (`Machine ID`) REFERENCES `ocean dew vending machines` (`Machines ID`),
  ADD CONSTRAINT `fk_P_P` FOREIGN KEY (`Package style`) REFERENCES `Package Designs` (`Package style`),
  ADD CONSTRAINT `fk_wid1` FOREIGN KEY (`warehouse id`) REFERENCES `warehouse` (`warehouse id`);

--
-- 限制表 `production quality test`
--
ALTER TABLE `production quality test`
  ADD CONSTRAINT `fk_test` FOREIGN KEY (`Production Serial`) REFERENCES `production information` (`Production Serial`);

--
-- 限制表 `Product_Ingredient`
--
ALTER TABLE `Product_Ingredient`
  ADD CONSTRAINT `fk_P_I_D` FOREIGN KEY (`Drink`) REFERENCES `Product` (`Drink`),
  ADD CONSTRAINT `fk_P_I_I` FOREIGN KEY (`Ingredient`) REFERENCES `Ingredient` (`Ingredient`);

--
-- 限制表 `Recycle Station`
--
ALTER TABLE `Recycle Station`
  ADD CONSTRAINT `fk_R_M` FOREIGN KEY (`Location Name`) REFERENCES `Ocean Dew Vending Machines` (`Location Name`);

--
-- 限制表 `Staff Members`
--
ALTER TABLE `Staff Members`
  ADD CONSTRAINT `fk _Tn_Tn` FOREIGN KEY (`Team name`) REFERENCES `Staff Teams` (`Team Name`),
  ADD CONSTRAINT `fk_Pn_Pn` FOREIGN KEY (`Position Name`) REFERENCES `Position` (`Position Name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
