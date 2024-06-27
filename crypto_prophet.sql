-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 03, 2023 at 11:56 PM
-- Server version: 8.0.34-0ubuntu0.22.04.1
-- PHP Version: 8.1.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crypto_prophet`
--

-- --------------------------------------------------------

--
-- Table structure for table `coin_prices`
--

CREATE TABLE `coin_prices` (
  `id` int NOT NULL,
  `coin` varchar(50) NOT NULL,
  `value` varchar(20) NOT NULL,
  `created_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `coin_prices`
--

INSERT INTO `coin_prices` (`id`, `coin`, `value`, `created_date`) VALUES
(5, 'CFX', '0.2449', '2023-05-01'),
(4, 'CFX', '0.254', '2023-04-30'),
(3, 'CFX', '0.2624', '2023-04-29'),
(2, 'CFX', '0.2734', '2023-04-28'),
(1, 'CFX', '0.2837', '2023-04-27');

-- --------------------------------------------------------

--
-- Table structure for table `crypto_pairs`
--

CREATE TABLE `crypto_pairs` (
  `id` int NOT NULL,
  `base_pair` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `quote_pair` varchar(15) NOT NULL,
  `exchange` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `source` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_futures` smallint NOT NULL DEFAULT '0',
  `is_spot` smallint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `crypto_pairs`
--

INSERT INTO `crypto_pairs` (`id`, `base_pair`, `quote_pair`, `exchange`, `source`, `is_futures`, `is_spot`) VALUES
(1, 'BTC', 'USDT', 'binance', '', 1, 1),
(2, 'ETH', 'USDT', 'binance', '', 1, 1),
(3, 'BNB', 'USDT', 'binance', '', 1, 1),
(4, 'ADA', 'USDT', 'binance', '', 1, 1),
(5, 'XRP', 'USDT', 'binance', '', 1, 1),
(6, 'SOL', 'USDT', 'binance', '', 1, 1),
(7, 'DOT', 'USDT', 'binance', '', 1, 1),
(8, 'AVAX', 'USDT', 'binance', '', 1, 1),
(9, 'YFI', 'USDT', 'binance', '', 1, 1),
(11, 'ALGO', 'USDT', 'binance', '', 1, 1),
(12, 'MATIC', 'USDT', 'binance', '', 1, 1),
(13, 'TRX', 'USDT', 'binance', '', 1, 1),
(14, 'LINK', 'USDT', 'binance', '', 1, 1),
(15, 'BCH', 'USDT', 'binance', '', 1, 1),
(16, 'ICP', 'USDT', 'binance', '', 1, 1),
(17, 'ETC', 'USDT', 'binance', '', 1, 1),
(18, 'APT', 'USDT', 'binance', '', 1, 1),
(19, 'HBAR', 'USDT', 'binance', '', 1, 1),
(20, 'VET', 'USDT', 'binance', '', 1, 1),
(21, 'EOS', 'USDT', 'binance', '', 1, 1),
(22, 'WAVES', 'USDT', 'binance', '', 1, 1),
(23, 'ZEC', 'USDT', 'binance', '', 1, 1),
(24, 'APE', 'USDT', 'binance', '', 1, 1),
(25, 'GRT', 'USDT', 'binance', '', 1, 1),
(26, 'RNDR', 'USDT', 'binance', '', 1, 1),
(27, 'CFX', 'USDT', 'binance', '', 1, 1),
(28, 'THETA', 'USDT', 'binance', '', 1, 1),
(29, 'MANA', 'USDT', 'binance', '', 1, 1),
(30, 'STX', 'USDT', 'binance', '', 1, 1),
(31, 'XTZ', 'USDT', 'binance', '', 1, 1),
(32, 'SNX', 'USDT', 'binance', '', 1, 1),
(33, 'AXS', 'USDT', 'binance', '', 1, 1),
(34, 'FLOW', 'USDT', 'binance', '', 1, 1),
(35, 'FIL', 'USDT', 'binance', '', 1, 1),
(36, 'LDO', 'USDT', 'binance', '', 1, 1),
(37, 'FTM', 'USDT', 'binance', '', 1, 1),
(38, 'EGLD', 'USDT', 'binance', '', 1, 1),
(39, 'IMX', 'USDT', 'binance', '', 1, 1),
(40, 'GALA', 'USDT', 'binance', '', 1, 1),
(41, 'CRV', 'USDT', 'binance', '', 1, 1),
(42, 'NEO', 'USDT', 'binance', '', 1, 1),
(43, 'KAVA', 'USDT', 'binance', '', 1, 1),
(44, 'KLAY', 'USDT', 'binance', '', 1, 1),
(45, 'MKR', 'USDT', 'binance', '', 1, 1),
(46, 'IOTA', 'USDT', 'binance', '', 1, 1),
(47, 'OP', 'USDT', 'binance', '', 1, 1),
(48, 'CHZ', 'USDT', 'binance', '', 1, 1),
(49, 'SUI', 'USDT', 'binance', '', 1, 1),
(50, 'INJ', 'USDT', 'binance', '', 1, 1),
(51, 'MINA', 'USDT', 'binance', '', 1, 1),
(52, '1000LUNC', 'USDT', 'binance', '', 1, 1),
(53, 'FXS', 'USDT', 'binance', '', 1, 1),
(54, '1000XEC', 'USDT', 'binance', '', 1, 1),
(55, 'GMX', 'USDT', 'binance', '', 1, 1),
(56, 'DASH', 'USDT', 'binance', '', 1, 1),
(57, 'ZIL', 'USDT', 'binance', '', 1, 1),
(58, 'ATOM', 'USDT', 'binance', '', 1, 1),
(59, 'XMR', 'USDT', 'binance', '', 1, 1),
(60, 'ARB', 'USDT', 'binance', '', 1, 1),
(61, 'QNT', 'USDT', 'binance', '', 1, 1),
(62, 'NEAR', 'USDT', 'binance', '', 1, 1),
(63, 'SAND', 'USDT', 'binance', '', 1, 1),
(64, 'AAVE', 'USDT', 'binance', '', 1, 1),
(65, '1000PEPE', 'USDT', 'binance', '', 1, 1),
(66, 'AGIX', 'USDT', 'binance', '', 1, 1),
(67, 'CVX', 'USDT', 'binance', '', 1, 1),
(68, 'RUNE', 'USDT', 'binance', '', 1, 1),
(69, 'AR', 'USDT', 'binance', '', 1, 1),
(70, 'ENJ', 'USDT', 'binance', '', 1, 1),
(71, 'DYDX', 'USDT', 'binance', '', 1, 1),
(72, 'BAT', 'USDT', 'binance', '', 1, 1),
(73, 'MASK', 'USDT', 'binance', '', 1, 1),
(74, '1000FLOKI', 'USDT', 'binance', '', 1, 1),
(75, 'HOT', 'USDT', 'binance', '', 1, 1),
(76, 'XEM', 'USDT', 'binance', '', 1, 1),
(77, 'QTUM', 'USDT', 'binance', '', 1, 1),
(78, 'ENS', 'USDT', 'binance', '', 1, 1),
(79, 'FET', 'USDT', 'binance', '', 1, 1),
(80, 'AUDIO', 'USDT', 'binance', '', 1, 1),
(81, 'CELO', 'USDT', 'binance', '', 1, 1),
(82, 'ANKR', 'USDT', 'binance', '', 1, 1),
(83, 'RVN', 'USDT', 'binance', '', 1, 1),
(84, 'BLUR', 'USDT', 'binance', '', 1, 1),
(85, 'LUNA2', 'USDT', 'binance', '', 1, 1),
(86, 'COMP', 'USDT', 'binance', '', 1, 1),
(87, 'ICX', 'USDT', 'binance', '', 1, 1),
(88, 'GMT', 'USDT', 'binance', '', 1, 1),
(89, 'KSM', 'USDT', 'binance', '', 1, 1),
(90, 'ASTR', 'USDT', 'binance', '', 1, 1),
(91, 'SXP', 'USDT', 'binance', '', 1, 1),
(92, 'ONT', 'USDT', 'binance', '', 1, 1),
(93, 'T', 'USDT', 'binance', '', 1, 1),
(94, 'EDU', 'USDT', 'binance', '', 1, 1),
(95, 'BAL', 'USDT', 'binance', '', 1, 1),
(96, 'IOTX', 'USDT', 'binance', '', 1, 1),
(97, 'MAGIC', 'USDT', 'binance', '', 1, 1),
(98, 'ONE', 'USDT', 'binance', '', 1, 1),
(99, 'ZRX', 'USDT', 'binance', '', 1, 1),
(100, 'BAND', 'USDT', 'binance', '', 1, 1),
(101, 'IOST', 'USDT', 'binance', '', 1, 1),
(102, 'SSV', 'USDT', 'binance', '', 1, 1),
(103, 'SUSHI', 'USDT', 'binance', '', 1, 1),
(104, 'OCEAN', 'USDT', 'binance', '', 1, 1),
(105, 'RSR', 'USDT', 'binance', '', 1, 1),
(106, 'UMA', 'USDT', 'binance', '', 1, 1),
(107, 'SKL', 'USDT', 'binance', '', 1, 1),
(108, 'ID', 'USDT', 'binance', '', 1, 1),
(109, 'ANT', 'USDT', 'binance', '', 1, 1),
(110, 'LPT', 'USDT', 'binance', '', 1, 1),
(111, 'CTSI', 'USDT', 'binance', '', 1, 1),
(112, 'DGB', 'USDT', 'binance', '', 1, 1),
(113, 'JOE', 'USDT', 'binance', '', 1, 1),
(114, 'CKB', 'USDT', 'binance', '', 1, 1),
(115, 'ZEN', 'USDT', 'binance', '', 1, 1),
(116, 'RLC', 'USDT', 'binance', '', 1, 1),
(117, 'OMG', 'USDT', 'binance', '', 1, 1),
(118, 'API3', 'USDT', 'binance', '', 1, 1),
(119, 'C98', 'USDT', 'binance', '', 1, 1),
(120, 'RAD', 'USDT', 'binance', '', 1, 1),
(121, 'ALPHA', 'USDT', 'binance', '', 1, 1),
(122, 'PEOPLE', 'USDT', 'binance', '', 1, 1),
(123, 'GTC', 'USDT', 'binance', '', 1, 1),
(124, 'HFT', 'USDT', 'binance', '', 1, 1),
(125, 'RDNT', 'USDT', 'binance', '', 1, 1),
(126, 'CHR', 'USDT', 'binance', '', 1, 1),
(127, 'COTI', 'USDT', 'binance', '', 1, 1),
(128, 'ARPA', 'USDT', 'binance', '', 1, 1),
(130, 'HOOK', 'USDT', 'binance', '', 1, 1),
(132, 'LINA', 'USDT', 'binance', '', 1, 1),
(133, 'REN', 'USDT', 'binance', '', 1, 1),
(134, 'NKN', 'USDT', 'binance', '', 1, 1),
(135, 'XVS', 'USDT', 'binance', '', 1, 1),
(136, 'CTK', 'USDT', 'binance', '', 1, 1),
(137, 'MTL', 'USDT', 'binance', '', 1, 1),
(138, 'SPELL', 'USDT', 'binance', '', 1, 1),
(139, 'GAL', 'USDT', 'binance', '', 1, 1),
(140, 'DUSK', 'USDT', 'binance', '', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `hot_looser_pairs`
--

CREATE TABLE `hot_looser_pairs` (
  `id` int NOT NULL,
  `pair` varchar(50) NOT NULL,
  `type` smallint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `hot_looser_pairs`
--

INSERT INTO `hot_looser_pairs` (`id`, `pair`, `type`) VALUES
(1, 'ALN', 1),
(2, 'EGGS', 1),
(3, 'BLT', 1),
(4, 'RADAR', 1),
(5, 'ROSN', 1),
(6, 'HYPER', 1),
(7, 'DMOON', 1),
(8, 'DNS', 1),
(9, 'WWDOGE', 1),
(10, 'FND', 1),
(11, 'IPX', 1),
(12, 'BXMI', 1),
(13, 'CC', 1),
(14, 'ORD', 1),
(15, 'CHEQ', 1),
(16, 'ERSDL', 1),
(17, 'VSP', 1),
(18, 'SPA', 1),
(19, 'PLG', 1),
(20, 'FCT', 1),
(21, 'VELO', 1),
(22, 'FLOKI', 1),
(23, 'TOMI', 1),
(24, 'WE', 1),
(25, 'BULL', 1),
(26, 'NFAI', 1),
(27, 'FXF', 1),
(28, 'SONNE', 1),
(29, 'GET', 1),
(30, 'DBI', 1),
(31, 'FALCONS', 1),
(32, 'STABLZ', 1),
(33, 'VOLTA', 1),
(34, 'RIF', 1),
(35, 'KINE', 1),
(36, 'DODO', 1),
(37, 'CAN', 1),
(38, 'ELT', 1),
(39, 'STX', 1),
(40, 'FBX', 1),
(41, 'PIX', 1),
(42, 'TALK', 1),
(43, 'KING', 1),
(44, 'HYPE', 1),
(45, 'GLF', 1),
(46, 'PRXY', 1),
(47, 'CHEEL', 1),
(48, 'KYL', 1),
(49, 'ELA', 1),
(50, 'ASTRA', 1),
(51, 'QLC', 1),
(52, 'SYN', 1),
(53, 'TRAVA', 1),
(54, 'STC', 1),
(55, 'RVF', 1),
(56, 'HIMAYC', 1),
(57, 'HSF', 1),
(58, 'FLUT', 1),
(59, 'PDT', 1),
(60, 'ARBINU', 1),
(61, 'SOV', 1),
(62, 'FX', 1),
(63, 'BIRD', 1),
(64, 'AKITA', 1),
(65, 'FPIS', 1),
(66, 'FIS', 1),
(67, 'YFI', 1),
(68, 'NVIR', 1),
(69, 'UFT', 1),
(70, 'LVL', 1),
(71, 'NFTB', 1),
(72, 'GXE', 1),
(73, 'BADGER', 1),
(74, 'ARCH', 1),
(75, 'GGG', 1),
(76, 'SEELE', 1),
(77, 'LITHO', 1),
(78, 'SIDUS', 1),
(79, 'SSV', 1),
(80, 'ANW', 1),
(81, 'BBO', 1),
(82, 'GHST', 1),
(83, 'TEM', 1),
(84, 'DFYN', 1),
(85, 'COCOS', 1),
(86, 'CDT', 1),
(87, 'FWCL', 1),
(88, 'ACH', 1),
(89, 'LOWB', 1),
(90, 'HEGIC', 1),
(91, 'ESCROW', 1),
(92, 'PLCU', 1),
(93, 'SWFTC', 1),
(94, 'ROG', 1),
(95, 'WNXM', 1),
(96, 'STORE', 1),
(97, 'AVINOC', 1),
(98, 'RBX', 1),
(99, 'POI$ON', 1),
(100, 'D3D', 1),
(101, 'BSCPAD', 1),
(102, 'AMP', 1),
(103, 'HIOD', 1),
(104, 'XTZ', 1),
(105, 'DATA', 1),
(106, 'SOC', 1),
(107, 'GULF', 1),
(108, 'WELL', 1),
(109, 'MBX', 1),
(110, 'SDL', 1),
(111, 'TOMO', 1),
(112, 'KATA', 1),
(113, 'EVER', 1),
(114, 'DKS', 1),
(115, 'AQDC', 1),
(116, 'GSX', 1),
(117, 'BABYDOGE', 1),
(118, 'FON', 1),
(119, 'HIMEEBITS', 1),
(120, 'GAMMA', 1),
(121, 'FLR', 1),
(122, 'MEME', 1),
(123, 'SIGN', 1),
(124, 'UMA', 1),
(125, 'PEEL', 1),
(126, 'MLS', 1),
(127, 'QTO', 1),
(128, 'SKET', 1),
(129, 'COPI', 1),
(130, 'BSGG', 1),
(131, 'ADB', 1),
(132, 'KISHU', 1),
(133, 'BCB', 1),
(134, 'UUU', 1),
(135, 'TONE', 1),
(136, 'SYS', 1),
(137, 'MOF', 1),
(138, 'IMT', 1),
(139, 'WEVER', 1),
(140, 'OAS', 1),
(141, 'PZM', 1),
(142, 'APX', 1),
(143, 'BSCS', 1),
(144, 'MX', 1),
(145, 'MESA', 1),
(146, 'TCH', 1),
(147, 'SWINGBY', 1),
(148, '1SOL', 1),
(149, 'ITA', 1),
(150, 'DEC', 1),
(151, 'BPLC', 1),
(152, 'STNEAR', 1),
(153, 'AGLA', 1),
(154, 'CSIX', 1),
(155, 'IMGNAI', 1),
(156, 'PALM', 1),
(157, 'TSUKA', 1),
(158, 'MARU', 1),
(159, 'TRADE', 1),
(160, 'HIBAYC', 1),
(161, 'BREED', 1),
(162, 'REV3L', 1),
(163, 'ZYB', 1),
(164, 'VELA', 1),
(165, 'CNC', 1),
(166, 'TOP', 1),
(167, 'ARC', 1),
(168, 'CO', 1),
(169, 'AION', 1),
(170, 'BDP', 1),
(171, 'CIX100', 1),
(172, 'PRIMAL', 1),
(173, 'BNX', 1),
(174, 'LM', 1),
(175, 'CAI', 1),
(176, 'LING', 1),
(177, 'CTI', 1),
(178, 'MVX', 1),
(179, 'DOV', 1),
(180, 'RFOX', 1),
(181, 'PSI', 1),
(182, 'REDLC', 1),
(183, 'GMD', 1),
(184, 'BEPRO', 1),
(185, 'PPT', 1),
(186, 'VELO', 1),
(187, 'MARSH', 1),
(188, 'NEPT', 1),
(189, 'NEWO', 1),
(190, 'CARE', 1),
(191, 'TND', 1),
(192, 'IGU', 1),
(193, 'OM', 1),
(194, 'GLQ', 1),
(195, 'KAT', 1),
(196, 'PLEX', 1),
(197, 'USD+', 1),
(198, 'RELAY', 1),
(199, 'DUST', 1),
(200, 'KSC', 1),
(201, 'WPCI', 1),
(202, 'NABOX', 1),
(203, 'DMTR', 1),
(204, 'POKT', 1),
(205, 'X2Y2', 1),
(206, 'MATTER', 1),
(207, 'QOM', 1),
(208, 'HIFRIENDS', 1),
(209, 'VST', 1),
(210, 'PORT', 1),
(211, 'XTAG', 1),
(212, 'SWAP', 1),
(213, 'MAGIC', 1),
(214, 'CEL', 1),
(215, 'JPEG', 1),
(216, 'HIVALHALLA', 1),
(217, 'SDAO', 1),
(218, 'OPUL', 1),
(219, 'QUICK', 1),
(220, 'MAN', 1),
(221, 'HIPENGUINS', 1),
(222, 'CHAT', 1),
(223, 'HIGH', 1),
(224, 'VXV', 1),
(225, 'HIRENGA', 1),
(226, 'TRU', 1),
(227, 'ZCX', 1),
(228, 'GOLD', 1),
(229, 'VOLT', 1),
(230, 'LIT', 1),
(231, 'PCI', 1),
(232, 'LN', 1),
(233, 'SON', 1),
(234, 'EDE', 1),
(235, 'AWO', 1),
(236, 'OLE', 1),
(237, 'GEEQ', 1),
(238, 'KEY', 1),
(239, 'POLYDOGE', 1),
(240, 'MOOV', 1),
(241, 'INT', 1),
(242, 'ALCAZAR', 1),
(243, 'SENATE', 1),
(244, 'DEGO', 1),
(245, 'ACA', 1),
(246, 'CFX', 1),
(247, 'XED', 1),
(248, 'ACS', 1),
(249, 'WOOF', 1),
(250, 'DOGGO', 1),
(251, 'PERL', 1),
(252, 'DSLA', 1),
(253, 'HOOP', 1),
(254, 'HIPUNKS', 1),
(255, 'SOLVE', 1),
(256, 'BRWL', 1),
(257, 'GFT', 1),
(258, 'ATOLO', 1),
(259, 'AI', 1),
(260, 'VRA', 1),
(261, 'MV', 1),
(262, 'PAXW', 1),
(263, 'HIENS3', 1),
(264, 'DG', 1),
(265, 'IDEX', 1),
(266, 'XDB', 1),
(267, 'IDEA', 1),
(268, 'GTC', 1),
(269, 'LSS', 1),
(270, 'RVST', 1),
(271, 'WELT', 1),
(272, 'HT', 1),
(273, 'AURA', 1),
(274, 'RVLT', 1),
(275, 'KAI', 1),
(276, 'ROAD', 1),
(277, 'CHE', 1),
(278, 'ARX', 1),
(279, 'KUMA', 1),
(280, 'UNIDX', 1),
(281, 'RARE', 1),
(282, 'ASM', 1),
(283, 'LTO', 1),
(284, 'GAMEX', 1),
(285, 'FTG', 1),
(286, 'PICKLE', 1),
(287, 'HOP', 1),
(288, 'UMAMI', 1),
(289, 'CNTM', 1),
(290, 'IRIS', 1),
(291, 'DBC', 1),
(292, 'SCREAM', 1),
(293, 'FOR', 1),
(294, 'RLB', 1),
(295, 'AR', 1),
(296, 'STARL', 1),
(297, 'TABOO', 1),
(298, 'FOX', 1),
(299, 'MASQ', 1),
(300, 'PKF', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders_coins`
--

CREATE TABLE `orders_coins` (
  `id` bigint NOT NULL,
  `coin` varchar(15) NOT NULL,
  `price` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type_order` smallint NOT NULL,
  `user_id` bigint NOT NULL,
  `status` smallint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders_coins`
--

INSERT INTO `orders_coins` (`id`, `coin`, `price`, `created_at`, `type_order`, `user_id`, `status`) VALUES
(1, 'ARKMUSDT', '1.222', '2023-08-25 16:09:39', 1, 2, 1),
(2, 'ARKMUSDT', '1.222', '2023-08-25 16:09:39', 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pivot_price`
--

CREATE TABLE `pivot_price` (
  `id` int NOT NULL,
  `base_pair` varchar(25) NOT NULL,
  `pivot_price` double(10,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pivot_price`
--

INSERT INTO `pivot_price` (`id`, `base_pair`, `pivot_price`) VALUES
(50, 'ACM', 3.56199),
(2, 'ADA', 0.44528),
(3, 'ALGO', 0.40329),
(4, 'AMP', 0.00785),
(5, 'ATOM', 12.09898),
(6, 'AUDIO', 0.57736),
(37, 'AVA', 0.91904),
(7, 'AVAX', 39.31755),
(8, 'AXS', 16.07144),
(53, 'BAR', 5.03570),
(9, 'BEAM', 0.15552),
(10, 'BNB', 290.80647),
(56, 'BSW', 0.50096),
(89, 'BTC', 21768.78469),
(111, 'BTC', 21800.91009),
(116, 'BTC', 22709.87980),
(81, 'BTC', 22721.76826),
(74, 'BTC', 22738.45566),
(73, 'BTC', 22738.45651),
(66, 'BTC', 22738.96124),
(62, 'BTC', 22747.84686),
(59, 'BTC', 22747.84697),
(64, 'BTC', 22748.02559),
(63, 'BTC', 23714.28210),
(58, 'BTC', 23718.38945),
(87, 'BTC', 25113.58137),
(115, 'BTC', 25248.19250),
(102, 'BTC', 25305.57687),
(60, 'BTC', 25328.31291),
(61, 'BTC', 25328.31518),
(57, 'BTC', 25329.65665),
(80, 'BTC', 25374.28729),
(11, 'BTC', 25385.99449),
(79, 'BTC', 25418.29934),
(72, 'BTC', 25418.30246),
(95, 'BTC', 25489.51640),
(96, 'BTC', 25532.03462),
(99, 'BTC', 27943.20943),
(112, 'BTC', 28071.36930),
(103, 'BTC', 28557.16712),
(94, 'BTC', 28645.91142),
(86, 'BTC', 28646.05071),
(83, 'BTC', 28646.08760),
(98, 'BTC', 28646.23887),
(110, 'BTC', 28653.06391),
(92, 'BTC', 28666.49467),
(88, 'BTC', 28668.08089),
(82, 'BTC', 28721.86883),
(108, 'BTC', 28724.16000),
(114, 'BTC', 28804.66442),
(104, 'BTC', 28937.73903),
(85, 'BTC', 28965.31779),
(109, 'BTC', 28972.49983),
(105, 'BTC', 28986.65125),
(113, 'BTC', 28987.99341),
(107, 'BTC', 28990.87511),
(84, 'BTC', 29017.09299),
(101, 'BTC', 29018.14617),
(93, 'BTC', 29019.42905),
(106, 'BTC', 29020.61617),
(90, 'BTC', 29069.05711),
(97, 'BTC', 29095.43391),
(100, 'BTC', 29095.49291),
(91, 'BTC', 29097.15622),
(71, 'BTC', 29959.66667),
(12, 'CELR', 0.02025),
(75, 'CFX', 0.09999),
(52, 'CHZ', 0.16579),
(49, 'CITY', 8.01045),
(42, 'CTXC', 0.18039),
(44, 'DOCK', 0.02070),
(13, 'DOGE', 0.09779),
(14, 'DOT', 8.90698),
(45, 'DREP', 0.46218),
(15, 'EGLD', 78.63855),
(38, 'EOS', 1.44129),
(16, 'ETH', 1687.61217),
(51, 'FIDA', 0.73336),
(17, 'FTM', 0.38871),
(18, 'HNT', 7.74394),
(19, 'ICP', 9.47342),
(77, 'ID', 0.58137),
(34, 'IDEX', 0.06939),
(20, 'INJ', 3.20802),
(21, 'LINK', 8.96925),
(54, 'LTC', 73.62774),
(22, 'LUNA', 41.74602),
(43, 'MASK', 3.04344),
(23, 'MATIC', 0.95947),
(48, 'MBL', 0.00440),
(78, 'OAX', 0.31953),
(24, 'ONE', 0.03987),
(70, 'QUICK', 70.32407),
(68, 'QUICK', 70.32412),
(47, 'RAD', 2.85214),
(25, 'REN', 0.19982),
(76, 'RIF', 0.07717),
(55, 'RNDR', 1.02850),
(26, 'ROSE', 0.11885),
(46, 'RVN', 0.03340),
(28, 'SOL', 57.17614),
(29, 'SRM', 1.36041),
(30, 'THETA', 1.75179),
(67, 'TOMO', 0.49214),
(31, 'TRX', 0.06471),
(35, 'UTK', 0.14623),
(32, 'VET', 0.03583),
(65, 'VGX', 0.48589),
(36, 'VGX', 0.64595),
(39, 'WAVES', 7.62959),
(33, 'XRP', 0.43732),
(41, 'YFII', 1446.37387),
(40, 'ZEC', 75.81621);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` smallint NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'Администратор'),
(2, 'Клиент');

-- --------------------------------------------------------

--
-- Table structure for table `tariffs`
--

CREATE TABLE `tariffs` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` mediumint NOT NULL,
  `percent` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracking_coins`
--

CREATE TABLE `tracking_coins` (
  `id` int NOT NULL,
  `coin` varchar(15) NOT NULL,
  `basecoin` varchar(15) NOT NULL,
  `direct` smallint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tracking_coins`
--

INSERT INTO `tracking_coins` (`id`, `coin`, `basecoin`, `direct`, `created_at`) VALUES
(1, 'USDP', 'USDT', 2, '2023-03-21 18:15:04'),
(2, 'XLM', 'USDT', 0, '2023-03-21 18:15:17'),
(3, 'XRP', 'USDT', 0, '2023-03-21 18:15:24'),
(4, 'ADA', 'USDT', 0, '2023-03-21 19:05:41'),
(5, 'MAGIC', 'USDT', 0, '2023-03-21 19:42:42'),
(6, 'BNB', 'USDT', 0, '2023-03-21 20:17:26'),
(7, 'BTC', 'USDT', 0, '2023-03-21 20:17:30'),
(8, 'ETH', 'USDT', 0, '2023-03-21 20:18:17'),
(9, 'DOGE', 'USDT', 0, '2023-03-21 20:46:16'),
(10, 'ETC', 'USDT', 0, '2023-03-21 20:46:33'),
(11, 'AVAX', 'USDT', 0, '2023-03-21 21:05:39'),
(12, 'DOT', 'USDT', 0, '2023-03-21 21:06:25'),
(13, 'TRX', 'USDT', 0, '2023-03-21 21:08:43'),
(14, 'USDC', 'USDT', 2, '2023-03-21 21:14:04'),
(15, 'QNT', 'USDT', 0, '2023-03-21 21:27:55'),
(16, 'LRC', 'USDT', 0, '2023-03-21 23:02:19'),
(17, 'ALGO', 'USDT', 0, '2023-03-21 23:40:24'),
(18, 'MINA', 'USDT', 0, '2023-03-21 23:42:35'),
(19, 'XMR', 'USDT', 0, '2023-03-22 05:13:57'),
(20, 'SOL', 'USDT', 0, '2023-03-22 05:38:23'),
(21, 'EGLD', 'USDT', 0, '2023-03-22 06:21:28'),
(22, 'CAKE', 'USDT', 0, '2023-03-22 06:45:57'),
(23, 'CFX', 'USDT', 0, '2023-03-22 07:11:01'),
(24, '1INCH', 'USDT', 0, '2023-03-22 11:40:12'),
(25, 'AAVE', 'USDT', 0, '2023-03-22 11:40:15'),
(26, 'AGIX', 'USDT', 0, '2023-03-22 11:40:21'),
(27, 'APE', 'USDT', 0, '2023-03-22 11:40:27'),
(28, 'APT', 'USDT', 2, '2023-03-22 11:40:30'),
(29, 'AR', 'USDT', 0, '2023-03-22 11:40:34'),
(30, 'ATOM', 'USDT', 0, '2023-03-22 11:40:38'),
(31, 'AXS', 'USDT', 0, '2023-03-22 11:40:46'),
(32, 'BCH', 'USDT', 0, '2023-03-22 11:40:49'),
(33, 'CHZ', 'USDT', 0, '2023-03-22 11:41:09'),
(34, 'CRV', 'USDT', 0, '2023-03-22 11:41:13'),
(35, 'DASH', 'USDT', 0, '2023-03-22 11:41:17'),
(36, 'DYDX', 'USDT', 0, '2023-03-22 11:41:28'),
(37, 'EOS', 'USDT', 0, '2023-03-22 11:41:36'),
(38, 'FIL', 'USDT', 0, '2023-03-22 11:41:48'),
(39, 'FLOW', 'USDT', 0, '2023-03-22 11:41:51'),
(40, 'FTM', 'USDT', 0, '2023-03-22 11:41:55'),
(41, 'FXS', 'USDT', 0, '2023-03-22 11:41:56'),
(42, 'GMX', 'USDT', 0, '2023-03-22 11:41:59'),
(43, 'GRT', 'USDT', 0, '2023-03-22 11:42:04'),
(44, 'HBAR', 'USDT', 0, '2023-03-22 11:42:08'),
(45, 'ICP', 'USDT', 0, '2023-03-22 11:42:11'),
(46, 'IMX', 'USDT', 0, '2023-03-22 11:42:12'),
(47, 'KLAY', 'USDT', 0, '2023-03-22 11:42:17'),
(48, 'LDO', 'USDT', 0, '2023-03-22 11:42:18'),
(49, 'LINK', 'USDT', 0, '2023-03-22 11:42:23'),
(50, 'LTC', 'USDT', 0, '2023-03-22 11:42:30'),
(51, 'LUNC', 'USDT', 0, '2023-03-22 11:42:32'),
(52, 'MANA', 'USDT', 0, '2023-03-22 11:42:39'),
(53, 'MATIC', 'USDT', 0, '2023-03-22 11:42:43'),
(54, 'MKR', 'USDT', 0, '2023-03-22 11:42:49'),
(55, 'NEAR', 'USDT', 0, '2023-03-22 11:42:53'),
(56, 'NEO', 'USDT', 0, '2023-03-22 11:42:57'),
(57, 'OP', 'USDT', 0, '2023-03-22 11:42:58'),
(58, 'OSMO', 'USDT', 0, '2023-03-22 11:43:00'),
(59, 'PAXG', 'USDT', 0, '2023-03-22 11:43:05'),
(60, 'RNDR', 'USDT', 0, '2023-03-22 11:43:10'),
(61, 'RPL', 'USDT', 0, '2023-03-22 11:43:13'),
(62, 'RUNE', 'USDT', 0, '2023-03-22 11:43:17'),
(63, 'SAND', 'USDT', 0, '2023-03-22 11:43:21'),
(64, 'SHIB', 'USDT', 0, '2023-03-22 11:43:25'),
(65, 'SNX', 'USDT', 0, '2023-03-22 11:43:29'),
(66, 'STX', 'USDT', 0, '2023-03-22 11:43:37'),
(67, 'THETA', 'USDT', 0, '2023-03-22 11:43:40'),
(68, 'TWT', 'USDT', 0, '2023-03-22 11:43:48'),
(69, 'UNI', 'USDT', 0, '2023-03-22 11:43:51'),
(70, 'VET', 'USDT', 0, '2023-03-22 11:43:58'),
(71, 'XEC', 'USDT', 0, '2023-03-22 11:44:01'),
(72, 'XTZ', 'USDT', 0, '2023-03-22 11:44:17'),
(73, 'YFII', 'USDT', 0, '2023-03-22 11:44:21'),
(74, 'ZEC', 'USDT', 0, '2023-03-22 11:44:24'),
(75, 'ZIL', 'USDT', 0, '2023-03-22 11:44:28'),
(76, 'WAVES', 'USDT', 0, '2023-03-23 17:00:33'),
(77, 'MDX', 'USDT', 0, '2023-03-27 21:13:57'),
(78, 'INJ', 'USDT', 0, '2023-03-27 21:14:00'),
(79, 'RAD', 'USDT', 0, '2023-03-27 21:14:07'),
(80, 'SKL', 'USDT', 0, '2023-03-27 21:14:11'),
(81, 'RIF', 'USDT', 0, '2023-03-27 21:14:11'),
(82, 'BAND', 'USDT', 0, '2023-03-27 21:14:12'),
(83, 'JOE', 'USDT', 0, '2023-03-30 20:45:10'),
(84, 'TOMO', 'USDT', 0, '2023-03-30 20:45:13'),
(85, 'CHESS', 'USDT', 0, '2023-03-30 20:45:16'),
(86, 'LINA', 'USDT', 0, '2023-03-30 20:45:19'),
(87, 'SXP', 'USDT', 0, '2023-03-30 20:45:22'),
(88, 'STRAX', 'USDT', 0, '2023-03-30 20:45:26'),
(89, 'PORTO', 'USDT', 0, '2023-03-30 20:45:29'),
(90, 'LAZIO', 'USDT', 0, '2023-03-30 20:45:32'),
(91, 'SANTOS', 'USDT', 0, '2023-03-30 20:45:35'),
(92, 'SUPER', 'USDT', 0, '2023-03-30 20:45:38'),
(93, 'OXT', 'USDT', 0, '2023-03-30 20:45:41'),
(94, 'ALPINE', 'USDT', 0, '2023-03-30 20:45:44'),
(95, 'STEEM', 'USDT', 0, '2023-03-30 20:45:47'),
(96, 'HIVE', 'USDT', 0, '2023-03-30 20:45:51'),
(97, 'UTK', 'USDT', 0, '2023-03-30 20:45:54'),
(98, 'ACM', 'USDT', 0, '2023-03-30 20:45:57'),
(99, 'OMG', 'USDT', 0, '2023-03-30 20:46:03'),
(100, 'MASK', 'USDT', 0, '2023-03-30 20:46:06'),
(101, 'PERL', 'USDT', 0, '2023-03-30 20:46:12'),
(102, 'CELO', 'USDT', 0, '2023-03-30 20:46:15'),
(103, 'ATM', 'USDT', 0, '2023-03-30 21:13:40'),
(104, 'OG', 'USDT', 0, '2023-03-30 21:13:43'),
(105, 'JUV', 'USDT', 0, '2023-03-30 21:13:46'),
(106, 'ASR', 'USDT', 0, '2023-03-30 21:13:49'),
(107, 'TRU', 'USDT', 0, '2023-03-30 21:13:53'),
(108, 'C98', 'USDT', 0, '2023-03-30 21:13:56'),
(109, 'CKB', 'USDT', 0, '2023-03-30 21:13:59'),
(110, 'MC', 'USDT', 0, '2023-03-30 21:14:02'),
(111, 'ELF', 'USDT', 0, '2023-03-31 11:59:13'),
(112, 'SPELL', 'USDT', 0, '2023-03-31 11:59:16'),
(113, 'HOT', 'USDT', 0, '2023-03-31 11:59:19'),
(114, 'DEGO', 'USDT', 0, '2023-03-31 11:59:22'),
(115, 'POND', 'USDT', 0, '2023-03-31 11:59:25'),
(116, 'GHST', 'USDT', 0, '2023-03-31 11:59:28'),
(117, 'DF', 'USDT', 0, '2023-03-31 11:59:34'),
(118, 'KMD', 'USDT', 0, '2023-03-31 19:29:08'),
(119, 'ZRX', 'USDT', 0, '2023-03-31 19:29:12'),
(120, 'ANKR', 'USDT', 0, '2023-03-31 19:29:15'),
(121, 'VIDT', 'USDT', 0, '2023-03-31 19:29:19'),
(122, 'DENT', 'USDT', 0, '2023-03-31 19:29:22'),
(123, 'FIS', 'USDT', 0, '2023-03-31 19:29:26'),
(124, 'ROSE', 'USDT', 0, '2023-03-31 19:29:29'),
(125, 'XNO', 'USDT', 0, '2023-03-31 19:29:32'),
(126, 'ICX', 'USDT', 0, '2023-04-02 21:34:47'),
(127, 'COCOS', 'USDT', 0, '2023-04-02 21:34:50'),
(128, 'LIT', 'USDT', 0, '2023-04-02 21:34:53'),
(129, 'BAT', 'USDT', 0, '2023-04-02 21:34:56'),
(130, 'ALPHA', 'USDT', 0, '2023-04-02 21:34:59'),
(131, 'STORJ', 'USDT', 0, '2023-04-02 21:35:02'),
(132, 'ADX', 'USDT', 0, '2023-04-02 21:35:05'),
(133, 'MTL', 'USDT', 0, '2023-04-02 21:35:08'),
(134, 'WOO', 'USDT', 0, '2023-04-02 21:35:11'),
(135, 'AGLD', 'USDT', 0, '2023-04-02 21:35:14'),
(136, 'JASMY', 'USDT', 0, '2023-04-02 21:35:17'),
(137, 'RSR', 'USDT', 0, '2023-04-02 21:35:20'),
(138, 'SC', 'USDT', 0, '2023-04-02 21:35:23'),
(139, 'SLP', 'USDT', 0, '2023-04-02 21:35:26'),
(140, 'STMX', 'USDT', 0, '2023-04-02 21:35:29'),
(141, 'YGG', 'USDT', 0, '2023-04-02 21:35:32'),
(142, 'DODO', 'USDT', 0, '2023-04-02 21:35:35'),
(143, 'LSK', 'USDT', 0, '2023-04-02 21:35:38'),
(144, 'TFUEL', 'USDT', 0, '2023-04-02 21:35:42'),
(145, 'AUCTION', 'USDT', 0, '2023-04-02 21:35:45'),
(146, 'IOTA', 'USDT', 0, '2023-04-02 21:35:48'),
(147, 'VGX', 'USDT', 0, '2023-04-02 21:35:54'),
(148, 'ACH', 'USDT', 0, '2023-04-02 21:35:56'),
(149, 'NEXO', 'USDT', 0, '2023-04-02 21:36:00'),
(150, 'XVG', 'USDT', 0, '2023-04-02 21:36:03'),
(151, 'CVX', 'USDT', 0, '2023-04-02 21:36:06'),
(152, 'RAY', 'USDT', 0, '2023-04-02 21:36:09'),
(153, 'BURGER', 'USDT', 0, '2023-04-02 21:36:12'),
(154, 'WING', 'USDT', 0, '2023-04-02 21:36:15'),
(155, 'TROY', 'USDT', 0, '2023-04-02 21:36:19'),
(156, 'PYR', 'USDT', 0, '2023-04-02 21:36:22'),
(157, 'CHR', 'USDT', 0, '2023-04-02 21:36:28'),
(158, 'FORTH', 'USDT', 0, '2023-04-02 21:36:31'),
(159, 'T', 'USDT', 0, '2023-04-02 21:36:34'),
(160, 'REN', 'USDT', 0, '2023-04-02 21:36:37'),
(161, 'CELR', 'USDT', 0, '2023-04-02 21:36:40'),
(162, 'KEY', 'USDT', 0, '2023-04-02 21:36:47'),
(163, 'MDT', 'USDT', 0, '2023-04-02 21:36:50'),
(164, 'BNX', 'USDT', 0, '2023-04-02 21:36:53'),
(165, 'RVN', 'USDT', 0, '2023-04-02 21:36:57'),
(166, 'TKO', 'USDT', 0, '2023-04-02 21:37:00'),
(167, 'WRX', 'USDT', 0, '2023-04-02 21:37:06'),
(168, 'BOND', 'USDT', 0, '2023-04-02 21:37:09'),
(169, 'RARE', 'USDT', 0, '2023-04-02 21:37:12'),
(170, 'POLS', 'USDT', 0, '2023-04-03 10:25:57'),
(171, 'GAL', 'USDT', 0, '2023-04-03 10:26:00'),
(172, 'NKN', 'USDT', 0, '2023-04-03 10:26:04'),
(173, 'DCR', 'USDT', 0, '2023-04-03 10:26:07'),
(174, 'BAR', 'USDT', 0, '2023-04-03 10:26:10'),
(175, 'KAVA', 'USDT', 0, '2023-04-03 10:26:13'),
(176, 'XEM', 'USDT', 0, '2023-04-03 10:26:17'),
(177, 'STPT', 'USDT', 0, '2023-04-03 10:26:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `uid` bigint NOT NULL,
  `username` varchar(100) NOT NULL,
  `fio` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` smallint NOT NULL DEFAULT '1',
  `api_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `api_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `trade_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `is_block` smallint NOT NULL DEFAULT '0',
  `tarif_id` smallint NOT NULL DEFAULT '0',
  `role_id` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `uid`, `username`, `fio`, `created_at`, `status`, `api_key`, `api_secret`, `trade_source`, `is_block`, `tarif_id`, `role_id`) VALUES
(1, 309250576, 'Dukuu_med', 'Руся', '2023-02-03 17:45:17', 0, '', '', '', 0, 0, 0),
(2, 208914682, 'proger1989', 'Руся', '2023-02-03 17:45:39', 1, '2MIMxy7xgtVkDfcjeB', '1dNWPBdbaYAtzcDKFdlY2tIbNqZkXYMLhSBx', 'bybit', 0, 0, 0),
(3, 522401542, 'yuri_vovk', 'Yuri', '2023-03-18 19:22:42', 0, 'stU3Fer8pkaY3PIEsi', 'tAylNl2hbja7Vn5JkbV1LsJzjcgdnK7xayK1', 'bybit', 0, 0, 0),
(4, 1007689746, 'Spirin_vitali', 'Виталий', '2023-03-27 08:37:24', 0, '', '', '', 0, 0, 0),
(5, 1230021353, 'oplakhotnyi', 'Oleksandr', '2023-03-30 19:25:13', 0, 'YeqxNFxOyq6Bf3JsgL', 'tdWD0swl0pm93M27ZKEhUT1SiS26P3mIJfhV', 'bybit', 0, 0, 0),
(6, 758773407, 'Ksyu12', 'Ksyu12', '2023-03-30 21:10:54', 0, 'kO3MCMVZ6Z6PPXQQ8g', 'PX0JdxCVvFi9hUmCEnNJEAVccGctjuJ0ZGAt', 'bybit', 0, 0, 0),
(7, 74617305, 'lev_progrev', 'Миша', '2023-04-07 13:08:02', 0, '', '', '', 0, 0, 0),
(8, 1900085165, 'bleared', 'Влад', '2023-04-08 21:06:41', 0, '', '', '', 0, 0, 0),
(9, 1605008049, 'ionie', 'Саша', '2023-04-08 21:07:45', 0, '', '', '', 0, 0, 0),
(10, 325360895, 'castle9', 'User', '2023-04-08 21:08:39', 0, '', '', '', 0, 0, 0),
(11, 56234116, 'seregha23', 'Сергей', '2023-04-08 21:21:20', 0, '', '', '', 0, 0, 0),
(12, 959004565, 'donald_666', 'donald_666', '2023-04-08 21:21:49', 0, 'IiKxOSk2Q0X413jcTS', 'OvvPHnxHGc9DskI8tUPbkDv0pDewm8YcSOhf', 'bybit', 0, 0, 0),
(13, 335384030, 'YG7753191', 'YG7753191', '2023-04-09 13:28:50', 0, 'SDtI35i22pmwxnpWaC', 'rpVIflnWtoibnB1Ky9epfsSkvK6RcZwk9mhs', 'bybit', 0, 0, 0),
(14, 499877035, 'strelkl', 'Сергей', '2023-04-09 13:29:47', 0, 'ds0BgGAj7I8xFZmVNU', 'gsrp74c2DmQBTyCLz3P84mcqc2d3r2FCtoCp', 'bybit', 0, 0, 0),
(15, 1801136702, 'Dmitriy', 'Dmitriy', '2023-04-09 13:30:07', 0, 'upnGDFP0nsNXCimdAX', 'UW7IoZnNHTKK4X5fddaGt0ikJwZgsyKKgQ4y', 'bybit', 0, 0, 0),
(16, 39823653, 'Alexxan89', 'Alexxan', '2023-04-11 10:11:24', 0, '', '', '', 0, 0, 0),
(17, 1910645807, 'Снежа', 'Снежа', '2023-04-17 11:32:16', 0, 'VFcrnILLyuL3r0xPF4', 'MdwbFokXRxVRmfOvTdr8p9hIJW54uoorobBp', '', 0, 0, 0),
(18, 337712775, 'Private', 'Private', '2023-04-17 11:32:16', 0, 'ZNFFDVFLAEBRKAEUYM', 'WKNJWEQYPGMPBPMIJXPWVTIDTORUVELUQNJQ', 'bybit', 0, 0, 0),
(19, 1313015891, 'VDmitry_013', 'Дмитрий', '2023-02-03 17:45:17', 0, 'hJRKwV9QryZa2gs1L9', 'ntcCHw6QA7R45yy5z4BbzmGBaRnFkldf00NM', 'bybit', 0, 0, 0),
(20, 262379200, 'Marina', 'Marina', '2023-02-03 17:45:17', 0, 'BREMI91oW7GXSOWGc6', 'o4FaGYotOrfxtqDuADlMPOw6sDTIeE8tqSp9', 'bybit', 0, 0, 0),
(21, 477848441, 'Vladislav', 'Vladislav', '2023-05-23 15:53:05', 0, '', '', '', 0, 0, 0),
(22, 311215676, 'nevstas', 'nevstas', '2023-05-23 20:31:45', 0, 'EOxk4DVIqkra15QIOh', 'HFivBfBEZ4sNoAyxtrheYWooqOX6jQcSUd04', 'bybit', 0, 0, 0),
(23, 198529463, 'AntonFiryulin', 'AntonFiryulin', '2023-02-03 17:45:17', 0, '', '', '', 0, 0, 0),
(24, 709161558, 'Hero', 'Hero', '2023-02-03 17:45:17', 0, 'oQ0Fm7kTlp0iZbBH1N', 'Jho0QN04oAGs8n8NXtJuGF75hGK1HwSFMIWl', 'bybit', 0, 0, 0),
(25, 309250576, 'lena_katykhina', 'Елена', '2023-02-03 17:45:17', 0, 'JK9NJjY8Dwot6EW3cq', 'MYzB5qh6uIDaO0XI0HppKnhBrGsLUw2MxJBu', 'bybit', 0, 0, 0),
(26, 74617305, 'lev_progrev', 'Миха', '2023-02-03 17:45:17', 0, '6SkORS6Yy5RHx7znAs', 'SIWlkLBpHnQz9WO6vKbehADAwPWzwtKMsZDu', 'bybit', 0, 0, 0),
(27, 519586367, 'mityussha', 'Яна', '2023-02-03 17:45:17', 0, 'yOsQATla9jDFPueVSL', 'Am1rdgjYdcC6Ttck3WJnfVtgFXZ23zczq8CH', 'bybit', 0, 0, 0),
(28, 325360895, 'castle9', 'castle9', '2023-02-03 17:45:17', 0, '75Mje41SlP7Jx5uRRQ', 'SKheiyhsYJQJtdXjejCmqtYlGyGyrLP9kt0G', 'bybit', 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `coin_prices`
--
ALTER TABLE `coin_prices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coin` (`coin`,`created_date`),
  ADD UNIQUE KEY `coin_2` (`coin`,`value`,`created_date`),
  ADD KEY `created_date` (`created_date`);

--
-- Indexes for table `crypto_pairs`
--
ALTER TABLE `crypto_pairs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `base_pair` (`base_pair`,`quote_pair`,`exchange`);

--
-- Indexes for table `hot_looser_pairs`
--
ALTER TABLE `hot_looser_pairs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders_coins`
--
ALTER TABLE `orders_coins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coin` (`coin`),
  ADD KEY `user_id` (`user_id`,`status`);

--
-- Indexes for table `pivot_price`
--
ALTER TABLE `pivot_price`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `base_pair` (`base_pair`,`pivot_price`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tariffs`
--
ALTER TABLE `tariffs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tracking_coins`
--
ALTER TABLE `tracking_coins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coin` (`coin`,`basecoin`),
  ADD KEY `tracking_coins_coin_basecoin_index` (`coin`,`basecoin`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `coin_prices`
--
ALTER TABLE `coin_prices`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `crypto_pairs`
--
ALTER TABLE `crypto_pairs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `hot_looser_pairs`
--
ALTER TABLE `hot_looser_pairs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=301;

--
-- AUTO_INCREMENT for table `orders_coins`
--
ALTER TABLE `orders_coins`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pivot_price`
--
ALTER TABLE `pivot_price`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tariffs`
--
ALTER TABLE `tariffs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tracking_coins`
--
ALTER TABLE `tracking_coins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
