-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 02/09/2023 às 13:34
-- Versão do servidor: 8.0.30
-- Versão do PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `tibia`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `accounts`
--

CREATE TABLE `accounts` (
  `id` int NOT NULL,
  `password` char(40) NOT NULL,
  `type` int NOT NULL DEFAULT '1',
  `premium_ends_at` int UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `key` varchar(64) NOT NULL DEFAULT '',
  `blocked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'internal usage',
  `created` int NOT NULL DEFAULT '0',
  `rlname` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `country` varchar(3) NOT NULL DEFAULT '',
  `web_lastlogin` int NOT NULL DEFAULT '0',
  `web_flags` int NOT NULL DEFAULT '0',
  `email_hash` varchar(32) NOT NULL DEFAULT '',
  `email_new` varchar(255) NOT NULL DEFAULT '',
  `email_new_time` int NOT NULL DEFAULT '0',
  `email_code` varchar(255) NOT NULL DEFAULT '',
  `email_next` int NOT NULL DEFAULT '0',
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `creation` int NOT NULL DEFAULT '0',
  `failed_bid_count` int NOT NULL DEFAULT '0',
  `premium_points` int NOT NULL DEFAULT '0',
  `vote` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `accounts`
--

INSERT INTO `accounts` (`id`, `password`, `type`, `premium_ends_at`, `email`, `key`, `blocked`, `created`, `rlname`, `location`, `country`, `web_lastlogin`, `web_flags`, `email_hash`, `email_new`, `email_new_time`, `email_code`, `email_next`, `email_verified`, `creation`, `failed_bid_count`, `premium_points`, `vote`) VALUES
(121234, '775a3ba9805661e2441be66afdfe6e20ac1cd5da', 1, 1696123967, 'teste@teste.com', '', 0, 1693527018, '', '', 'br', 1693527027, 0, '', '', 0, '', 0, 0, 0, 0, 195, 0),
(199361, 'be5c418388d9b376c74674a47062fc7c3f57e58d', 1, 1696124547, 'luancmunhoz@gmail.com', '', 0, 1693527007, '', '', 'br', 1693527146, 0, '', '', 0, '', 0, 0, 0, 0, 650, 0),
(1234567, '41da8bef22aaef9d7c5821fa0f0de7cccc4dda4d', 6, 1695739930, '', '', 0, 0, '', '', '', 1693661034, 5, '', '', 0, '', 0, 0, 0, 0, 1108, 0),
(4022023, '775a3ba9805661e2441be66afdfe6e20ac1cd5da', 5, 0, 'retroniaotserv@gmail.com', '', 0, 1675523240, '', '', 'us', 1689011165, 3, '', '', 0, '', 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_bans`
--

CREATE TABLE `account_bans` (
  `account_id` int NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint NOT NULL,
  `expires_at` bigint NOT NULL,
  `banned_by` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_ban_history`
--

CREATE TABLE `account_ban_history` (
  `id` int UNSIGNED NOT NULL,
  `account_id` int NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint NOT NULL,
  `expired_at` bigint NOT NULL,
  `banned_by` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_storage`
--

CREATE TABLE `account_storage` (
  `account_id` int NOT NULL,
  `key` int UNSIGNED NOT NULL,
  `value` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_viplist`
--

CREATE TABLE `account_viplist` (
  `account_id` int NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `notify` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `allow_request`
--

CREATE TABLE `allow_request` (
  `id` int NOT NULL,
  `ip` text NOT NULL,
  `request` int NOT NULL,
  `status` text NOT NULL,
  `time` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `allow_request`
--

INSERT INTO `allow_request` (`id`, `ip`, `request`, `status`, `time`) VALUES
(38, '::1', 116, 'on', '2023-08-30 20:41:26');

-- --------------------------------------------------------

--
-- Estrutura para tabela `crypto_history`
--

CREATE TABLE `crypto_history` (
  `id` int NOT NULL,
  `value` float NOT NULL,
  `hash` text NOT NULL,
  `wallet_send` text NOT NULL,
  `status` text NOT NULL,
  `date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `crypto_history`
--

INSERT INTO `crypto_history` (`id`, `value`, `hash`, `wallet_send`, `status`, `date`) VALUES
(11, 1, '0x009748d7d4aeb158fb1341261d5d08722c2b9585b4b6e2bd2f6259c5d4df48b4', '0xde58909969bb6a53ecf9c1c369edf5244a085891', 'recive', 'Apr-21-2023 03:17:18 PM +UTC'),
(16, 1, '0xccbda46734d149e26d1a1bb06031d6d2179e4596acb9492f1ff4664da4266dea', '0xde58909969bb6a53ecf9c1c369edf5244a085891', 'recive', 'Apr-28-2023 01:59:04 PM +UTC'),
(17, 1, '0x3ec04570c8c049f5c0dc669a2387c52441d551666ca50bf5320475b02e140f01', '0xde58909969bb6a53ecf9c1c369edf5244a085891', 'recive', 'Apr-28-2023 01:44:49 PM +UTC'),
(18, 1, '0x12e19d50aa376fd80d5c886c324bb3d005ddde0f5b559925d610e170b1348028', '0xde58909969bb6a53ecf9c1c369edf5244a085891', 'recive', 'Apr-28-2023 03:03:56 PM +UTC'),
(19, 1, '0x248d3ba70466a3bf4d86704ebdb1e31d414cb723e55931ef4b6d158c1621b293', '0xde58909969bb6a53ecf9c1c369edf5244a085891', 'recive', 'Apr-28-2023 05:25:19 PM +UTC');

-- --------------------------------------------------------

--
-- Estrutura para tabela `crypto_payments`
--

CREATE TABLE `crypto_payments` (
  `paymentID` int UNSIGNED NOT NULL,
  `boxID` int UNSIGNED NOT NULL DEFAULT '0',
  `boxType` enum('paymentbox','captchabox') NOT NULL,
  `orderID` varchar(50) NOT NULL DEFAULT '',
  `userID` varchar(50) NOT NULL DEFAULT '',
  `countryID` varchar(3) NOT NULL DEFAULT '',
  `coinLabel` varchar(6) NOT NULL DEFAULT '',
  `amount` double(20,8) NOT NULL DEFAULT '0.00000000',
  `amountUSD` double(20,8) NOT NULL DEFAULT '0.00000000',
  `unrecognised` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `addr` varchar(34) NOT NULL DEFAULT '',
  `txID` char(64) NOT NULL DEFAULT '',
  `txDate` datetime DEFAULT NULL,
  `txConfirmed` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `txCheckDate` datetime DEFAULT NULL,
  `processed` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `processedDate` datetime DEFAULT NULL,
  `recordCreated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `dirkyh_items`
--

CREATE TABLE `dirkyh_items` (
  `id` int NOT NULL,
  `type` text NOT NULL,
  `name` text,
  `weight` float NOT NULL,
  `armor` int DEFAULT NULL,
  `monster` json DEFAULT NULL,
  `resistence` json DEFAULT NULL,
  `attack` int DEFAULT NULL,
  `defense` float DEFAULT NULL,
  `attack_speed` int DEFAULT NULL,
  `two_handed` int DEFAULT NULL,
  `ranger` float DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `equals` int DEFAULT NULL,
  `clientid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `dirkyh_items`
--

INSERT INTO `dirkyh_items` (`id`, `type`, `name`, `weight`, `armor`, `monster`, `resistence`, `attack`, `defense`, `attack_speed`, `two_handed`, `ranger`, `duration`, `equals`, `clientid`) VALUES
(1294, 'distance', 'small stone', 360, 0, '[\"Gargoyle\", \"Goblin\", \"Grorlam\", \"Illusion\", \"Stone Golem\"]', NULL, 20, NULL, 2000, 1, 7, NULL, NULL, 1781),
(1987, 'backpack', 'bag', 800, 0, '[\"Dwarf Geomancer\", \"Monk\", \"Orc Shaman\"]', '[[\"8\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2853),
(1988, 'backpack', 'backpack', 1800, 0, '[\"Orc Leader\", \"Orc Rider\", \"Stalker\"]', '[[\"20\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2854),
(1991, 'backpack', 'bag', 800, 0, 'null', '[[\"8\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2857),
(1992, 'backpack', 'bag', 800, 0, 'null', '[[\"8\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2858),
(1993, 'backpack', 'bag', 800, 0, 'null', '[[\"8\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2859),
(1994, 'backpack', 'bag', 800, 0, 'null', '[[\"8\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2860),
(1995, 'backpack', 'bag', 800, 0, 'null', '[[\"8\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2861),
(1996, 'backpack', 'bag', 800, 0, 'null', '[[\"8\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2862),
(1997, 'backpack', 'bag', 800, 0, 'null', '[[\"8\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2863),
(1998, 'backpack', 'backpack', 1800, 0, 'null', '[[\"20\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2865),
(1999, 'backpack', 'backpack', 1800, 0, 'null', '[[\"20\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2866),
(2000, 'backpack', 'backpack', 1800, 0, 'null', '[[\"20\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2867),
(2001, 'backpack', 'backpack', 1800, 0, 'null', '[[\"20\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2868),
(2002, 'backpack', 'backpack', 1800, 0, 'null', '[[\"20\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2869),
(2003, 'backpack', 'backpack', 1800, 0, 'null', '[[\"20\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2870),
(2004, 'backpack', 'backpack', 1800, 0, 'null', '[[\"20\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2871),
(2036, 'tool', 'watch', 50, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2906),
(2111, 'distance', 'snowball', 80, 0, '[\"Yeti\"]', NULL, NULL, NULL, 2000, 1, 7, NULL, NULL, 2992),
(2120, 'tool', 'rope', 1800, 0, '[\"Black Knight\", \"Hero\", \"Troll\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3003),
(2121, 'ring', 'wedding ring', 40, 0, '[\"Banshee\", \"Hero\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3004),
(2123, 'ring', 'ring of the sky', 40, 0, '[\"Apocalypse\", \"Bazir\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\", \"Warlock\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3006),
(2124, 'ring', 'crystal ring', 90, 0, '[\"Apocalypse\", \"Banshee\", \"Bazir\", \"Ferumbras\", \"Grorlam\", \"Infernatil\", \"Morgaroth\", \"Mummy\", \"Orshabaal\", \"Stone Golem\", \"Vashresamun\", \"Warlock\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3007),
(2125, 'necklace', 'crystal necklace', 490, 0, '[\"Amazon\", \"Apocalypse\", \"Bazir\", \"Behemoth\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\", \"Priestess\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3008),
(2126, 'necklace', 'bronze necklace', 410, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3009),
(2128, 'head', 'crown', 1900, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3011),
(2129, 'necklace', 'wolf tooth chain', 330, 0, '[\"Cyclops\", \"Fernfang\", \"Gargoyle\", \"Orc Rider\", \"Witch\", \"Yeti\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3012),
(2130, 'necklace', 'golden amulet', 830, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3013),
(2131, 'necklace', 'star amulet', 610, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3014),
(2132, 'necklace', 'silver necklace', 480, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3015),
(2133, 'necklace', 'ruby necklace', 570, 0, '[\"Black Knight\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3016),
(2135, 'necklace', 'scarab amulet', 770, 0, '[\"Ancient Scarab\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3018),
(2136, 'necklace', 'demonbone amulet', 690, 0, '[\"Morguthis\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3019),
(2138, 'necklace', 'saphire amulet', 680, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3021),
(2139, 'head', 'ancient tiara', 820, 0, '[\"Vashresamun\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3022),
(2142, 'necklace', 'ancient amulet', 840, 0, '[\"Ancient Scarab\", \"Apocalypse\", \"Bazir\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3025),
(2161, 'necklace', 'strange talisman', 290, 0, '[\"Mummy\"]', '[[\"200\", \"charges\"], [\"Protection\", \"10\", \"energy\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3045),
(2164, 'ring', 'might ring', 100, 0, '[\"Apocalypse\", \"Ashmunrah\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Hero\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', '[[\"20\", \"charges\"], [\"Protection\", \"20\", \"physical\"], [\"Protection\", \"20\", \"energy\"], [\"Protection\", \"20\", \"fire\"], [\"Protection\", \"20\", \"poison\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3048),
(2170, 'necklace', 'silver amulet', 500, 0, '[\"Apocalypse\", \"Banshee\", \"Bazir\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Mummy\", \"Orshabaal\", \"Troll\"]', '[[\"200\", \"charges\"], [\"Protection\", \"10\", \"poison\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3054),
(2171, 'necklace', 'platinum amulet', 600, 2, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Giant Spider\", \"Infernatil\", \"Lich\", \"Morgaroth\", \"Orshabaal\", \"The Old Widow\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3055),
(2172, 'necklace', 'bronze amulet', 500, 0, '[\"Minotaur\", \"Vampire\"]', '[[\"200\", \"charges\"], [\"Protection\", \"20\", \"manadrain\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3056),
(2173, 'necklace', 'amulet of loss', 420, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3057),
(2175, 'spellbook', 'spellbook', 5800, 0, '[\"Banshee\", \"Beholder\", \"Dwarf Geomancer\", \"Elder Beholder\", \"Lich\", \"The Evil Eye\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3059),
(2179, 'ring', 'gold ring', 100, 0, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3063),
(2195, 'feet', 'boots of haste', 750, 0, '[\"Apocalypse\", \"Bazir\", \"Black Knight\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Necromancer\", \"Necropharus\", \"Omruc\", \"Orshabaal\"]', '[[\"20\", \"speed\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3079),
(2196, 'necklace', 'broken amulet', 420, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3080),
(2197, 'necklace', 'stone skin amulet', 700, 0, '[\"Apocalypse\", \"Banshee\", \"Bazir\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Morguthis\", \"Orshabaal\", \"Warlock\"]', '[[\"5\", \"charges\"], [\"Protection\", \"80\", \"physical\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3081),
(2198, 'necklace', 'elven amulet', 270, 0, '[\"Dharalion\", \"Elf Arcanist\"]', '[[\"50\", \"charges\"], [\"Protection\", \"5\", \"physical\"], [\"Protection\", \"5\", \"energy\"], [\"Protection\", \"5\", \"fire\"], [\"Protection\", \"5\", \"poison\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3082),
(2199, 'necklace', 'garlic necklace', 380, 0, '[\"Witch\"]', '[[\"150\", \"charges\"], [\"Protection\", \"20\", \"lifedrain\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3083),
(2200, 'necklace', 'protection amulet', 550, 0, '[\"Apocalypse\", \"Bazir\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orc Warlord\", \"Orshabaal\", \"Valkyrie\"]', '[[\"250\", \"charges\"], [\"Protection\", \"6\", \"physical\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3084),
(2201, 'necklace', 'dragon necklace', 630, 0, '[\"Hunter\"]', '[[\"200\", \"charges\"], [\"Protection\", \"8\", \"fire\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3085),
(2202, 'ring', 'stealth ring', 100, 0, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Ghost\", \"Infernatil\", \"Morgaroth\", \"Omruc\", \"Orc Warlord\", \"Orshabaal\"]', '[[\"true\", \"invisible\"]]', NULL, NULL, NULL, NULL, NULL, 600, 2165, 3086),
(2203, 'ring', 'power ring', 80, 0, '[\"Fernfang\", \"Grorlam\", \"Monk\", \"Stone Golem\"]', '[[\"6\", \"skillfist\"]]', NULL, NULL, NULL, NULL, NULL, 1800, 2166, 3087),
(2204, 'ring', 'energy ring', 80, 0, '[\"Apocalypse\", \"Bazir\", \"Demodras\", \"Dipthrah\", \"Dragon Lord\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\", \"Warlock\"]', '[[\"1\", \"manashield\"]]', NULL, NULL, NULL, NULL, NULL, 600, 2167, 3088),
(2205, 'ring', 'life ring', 80, 0, '[\"Ghoul\", \"Mahrdis\"]', '[[\"1\", \"healthgain\"], [\"3000\", \"healthticks\"], [\"1\", \"managain\"], [\"3000\", \"manaticks\"]]', NULL, NULL, NULL, NULL, NULL, 1200, 2168, 3089),
(2206, 'ring', 'time ring', 90, 0, '[\"Giant Spider\", \"Thalas\", \"The Old Widow\"]', '[[\"30\", \"speed\"]]', NULL, NULL, NULL, NULL, NULL, 600, 2169, 3090),
(2210, 'ring', 'sword ring', 90, 0, '[\"Orc Leader\"]', '[[\"4\", \"skillsword\"]]', NULL, NULL, NULL, NULL, NULL, 1800, 2207, 3094),
(2211, 'ring', 'axe ring', 90, 0, '[\"Dwarf Guard\", \"Dwarf Soldier\"]', '[[\"4\", \"skillaxe\"]]', NULL, NULL, NULL, NULL, NULL, 1800, 2208, 3095),
(2212, 'ring', 'club ring', 90, 0, '[\"Cyclops\", \"Gargoyle\"]', '[[\"4\", \"skillclub\"]]', NULL, NULL, NULL, NULL, NULL, 1800, 2209, 3096),
(2215, 'ring', 'dwarven ring', 110, 0, '[\"Dwarf\", \"Dwarf Geomancer\"]', '[[\"true\", \"suppressdrunk\"]]', NULL, NULL, NULL, NULL, NULL, 3600, 2213, 3099),
(2216, 'ring', 'ring of healing', 80, 0, '[\"Apocalypse\", \"Banshee\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Lich\", \"Morgaroth\", \"Orshabaal\", \"Rahemos\"]', '[[\"1\", \"healthgain\"], [\"1000\", \"healthticks\"], [\"1\", \"managain\"], [\"1000\", \"manaticks\"]]', NULL, NULL, NULL, NULL, NULL, 450, 2214, 3100),
(2217, 'spellbook', 'spellbook', 5800, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3101),
(2218, 'necklace', 'paw amulet', 420, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3102),
(2321, 'club', 'giant smithhammer', 6800, 0, 'null', NULL, 24, 14, 2000, 1, NULL, NULL, NULL, 3208),
(2323, 'head', 'hat of the mad', 700, 3, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3210),
(2330, 'backpack', 'letterbag', 50000, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3217),
(2339, 'head', 'damaged helmet', 1800, 5, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3226),
(2342, 'head', 'helmet of the ancients', 2760, 8, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3229),
(2343, 'head', 'helmet of the ancients', 2760, 11, 'null', NULL, NULL, NULL, NULL, NULL, NULL, 1800, NULL, 3230),
(2357, 'ring', 'ring of wishes', 50, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3245),
(2358, 'feet', 'boots of waterwalking', 770, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3246),
(2362, 'food', 'the carrot of doom', 160, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3250),
(2376, 'sword', 'sword', 3500, 0, '[\"Minotaur\", \"Rotworm\", \"Skeleton\"]', NULL, 14, 12, 2000, 1, NULL, NULL, NULL, 3264),
(2377, 'sword', 'two handed sword', 7000, 0, '[\"Apocalypse\", \"Bazir\", \"Behemoth\", \"Beholder\", \"Black Knight\", \"Crypt Shambler\", \"Elder Beholder\", \"Ferumbras\", \"Hero\", \"Infernatil\", \"Morgaroth\", \"Orc Warlord\", \"Orshabaal\", \"The Evil Eye\"]', NULL, 60, 12, 3500, 2, NULL, NULL, NULL, 3265),
(2378, 'axe', 'battle axe', 5000, 0, '[\"Dwarf Soldier\", \"Orc Berserker\"]', NULL, 50, 5, 3500, 2, NULL, NULL, NULL, 3266),
(2379, 'sword', 'dagger', 950, 0, '[\"Amazon\", \"Goblin\", \"Illusion\", \"Orc Leader\", \"Priestess\", \"Swamp Troll\", \"Valkyrie\"]', NULL, 8, 6, 2000, 1, NULL, NULL, NULL, 3267),
(2380, 'axe', 'hand axe', 1800, 0, '[\"Troll\"]', NULL, 10, 5, 2000, 1, NULL, NULL, NULL, 3268),
(2381, 'axe', 'halberd', 9000, 0, '[\"Black Knight\", \"Cyclops\", \"Orc Berserker\"]', NULL, 70, 7, 3500, 2, NULL, NULL, NULL, 3269),
(2382, 'club', 'club', 2500, 0, '[\"Frost Troll\"]', NULL, 7, 7, 2000, 1, NULL, NULL, NULL, 3270),
(2383, 'sword', 'spike sword', 5000, 0, '[\"Vampire\"]', NULL, 24, 21, 2000, 1, NULL, NULL, NULL, 3271),
(2384, 'sword', 'rapier', 1500, 0, '[\"Frost Troll\"]', NULL, 10, 8, 2000, 1, NULL, NULL, NULL, 3272),
(2385, 'sword', 'sabre', 2500, 0, '[\"Amazon\", \"Orc\", \"Orc Warrior\"]', NULL, 12, 10, 2000, 1, NULL, NULL, NULL, 3273),
(2386, 'axe', 'axe', 4000, 0, '[\"Dwarf\", \"Minotaur\", \"Orc\", \"Wild Warrior\"]', NULL, 12, 6, 2000, 1, NULL, NULL, NULL, 3274),
(2387, 'axe', 'double axe', 7000, 0, '[\"Apocalypse\", \"Bazir\", \"Behemoth\", \"Demon\", \"Dragon\", \"Dwarf Guard\", \"Ferumbras\", \"Fire Devil\", \"General Murius\", \"Infernatil\", \"Minotaur Guard\", \"Morgaroth\", \"Orshabaal\", \"The Horned Fox\", \"Valkyrie\"]', NULL, 70, 6, 3500, 2, NULL, NULL, NULL, 3275),
(2388, 'axe', 'hatchet', 3500, 0, '[\"Dwarf\", \"Minotaur Guard\", \"Skeleton\", \"The Horned Fox\"]', NULL, 15, 8, 2000, 1, NULL, NULL, NULL, 3276),
(2389, 'distance', 'spear', 2000, 0, '[\"Black Knight\", \"Frost Troll\", \"Orc Shaman\", \"Orc Spearman\", \"Troll\", \"Valkyrie\"]', NULL, 30, NULL, 2000, 1, 7, NULL, NULL, 3277),
(2390, 'sword', 'magic longsword', 4300, 0, 'null', NULL, 110, 20, 3500, 2, NULL, NULL, NULL, 3278),
(2391, 'club', 'war hammer', 8500, 0, '[\"Hero\", \"Wild Warrior\"]', NULL, 90, 5, 3500, 2, NULL, NULL, NULL, 3279),
(2392, 'sword', 'fire sword', 2300, 0, '[\"Demodras\", \"Dragon Lord\", \"Hero\"]', NULL, 35, 20, 2000, 1, NULL, NULL, NULL, 3280),
(2393, 'sword', 'giant sword', 18000, 0, '[\"Apocalypse\", \"Bazir\", \"Behemoth\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', NULL, 92, 11, 3500, 2, NULL, NULL, NULL, 3281),
(2394, 'club', 'morning star', 5400, 0, '[\"Beholder\", \"Elder Beholder\", \"Gargoyle\", \"Ghost\", \"The Evil Eye\"]', NULL, 25, 11, 2000, 1, NULL, NULL, NULL, 3282),
(2395, 'sword', 'carlin sword', 4000, 0, '[\"Stone Golem\"]', NULL, 15, 13, 2000, 1, NULL, NULL, NULL, 3283),
(2396, 'sword', 'ice rapier', 1500, 0, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\", \"Vampire\"]', '[[\"1\", \"charges\"]]', 100, 1, 2000, 1, NULL, NULL, NULL, 3284),
(2397, 'sword', 'longsword', 4200, 0, '[\"Beholder\", \"Dragon\", \"Elder Beholder\", \"Elf\", \"Elf Scout\", \"Orc Leader\", \"The Evil Eye\"]', NULL, 17, 14, 2000, 1, NULL, NULL, NULL, 3285),
(2398, 'club', 'mace', 3800, 0, '[\"Dragon\", \"Minotaur\", \"Rotworm\", \"Skeleton\", \"Wild Warrior\"]', NULL, 16, 11, 2000, 1, NULL, NULL, NULL, 3286),
(2399, 'distance', 'throwing star', 100, 0, '[\"Crypt Shambler\", \"Demon Skeleton\", \"Orc Warlord\"]', NULL, 25, NULL, 2000, 1, 7, NULL, NULL, 3287),
(2400, 'sword', 'magic sword', 4200, 0, 'null', NULL, 48, 35, 2000, 1, NULL, NULL, NULL, 3288),
(2401, 'club', 'staff', 3800, 0, '[\"Dharalion\", \"Elf Arcanist\", \"Fernfang\", \"Fernfang\", \"Lich\", \"Monk\", \"Orc Shaman\"]', NULL, 10, 25, 2000, 2, NULL, NULL, NULL, 3289),
(2402, 'sword', 'silver dagger', 1020, 0, '[\"Apocalypse\", \"Bazir\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\", \"Witch\"]', NULL, 8, 7, 2000, 1, NULL, NULL, NULL, 3290),
(2403, 'sword', 'knife', 420, 0, '[\"Ghoul\", \"Minotaur Mage\"]', NULL, 7, 5, 2000, 1, NULL, NULL, NULL, 3291),
(2404, 'sword', 'combat knife', 870, 0, '[\"Ghost\", \"Minotaur Mage\"]', NULL, 8, 6, 2000, 1, NULL, NULL, NULL, 3292),
(2405, 'axe', 'sickle', 1050, 0, '[\"Witch\"]', NULL, 7, 4, 2000, 1, NULL, NULL, NULL, 3293),
(2406, 'sword', 'short sword', 3500, 0, '[\"Cyclops\", \"Dragon\", \"Goblin\", \"Illusion\", \"Mummy\", \"Necromancer\", \"Necropharus\"]', NULL, 11, 11, 2000, 1, NULL, NULL, NULL, 3294),
(2407, 'sword', 'bright sword', 2900, 0, 'null', NULL, 36, 30, 2000, 1, NULL, NULL, NULL, 3295),
(2408, 'sword', 'warlord sword', 6400, 0, 'null', NULL, 106, 19, 3500, 2, NULL, NULL, NULL, 3296),
(2409, 'sword', 'serpent sword', 4100, 0, '[\"Dragon\", \"Thalas\"]', NULL, 26, 15, 2000, 1, NULL, NULL, NULL, 3297),
(2410, 'distance', 'throwing knife', 210, 0, '[\"Orc Leader\", \"Stalker\"]', NULL, 30, NULL, 2000, 1, 7, NULL, NULL, 3298),
(2411, 'sword', 'poison dagger', 880, 0, '[\"Banshee\", \"Mummy\", \"Orc Warrior\", \"Thalas\", \"Warlock\"]', NULL, 18, 8, 2000, 1, NULL, NULL, NULL, 3299),
(2412, 'sword', 'katana', 3100, 0, '[\"Rotworm\", \"Stalker\", \"Vampire\"]', NULL, 16, 12, 2000, 1, NULL, NULL, NULL, 3300),
(2413, 'sword', 'broadsword', 5250, 0, '[\"Dragon\", \"Orc Leader\"]', NULL, 52, 11, 3500, 2, NULL, NULL, NULL, 3301),
(2414, 'axe', 'dragon lance', 6700, 0, '[\"Black Knight\"]', NULL, 94, 8, 3500, 2, NULL, NULL, NULL, 3302),
(2415, 'axe', 'great axe', 9000, 0, 'null', NULL, 104, 11, 3500, 2, NULL, NULL, NULL, 3303),
(2416, 'club', 'crowbar', 2100, 0, '[\"Behemoth\"]', NULL, 6, 6, 2000, 1, NULL, NULL, NULL, 3304),
(2417, 'club', 'battle hammer', 6800, 0, '[\"Black Knight\", \"Demon Skeleton\", \"Dwarf Guard\"]', NULL, 24, 14, 2000, 1, NULL, NULL, NULL, 3305),
(2418, 'axe', 'golden sickle', 1950, 0, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', NULL, 13, 6, 2000, 1, NULL, NULL, NULL, 3306),
(2419, 'sword', 'scimitar', 2900, 0, '[\"Fire Devil\", \"Orc Leader\", \"Orc Warlord\"]', NULL, 19, 13, 2000, 1, NULL, NULL, NULL, 3307),
(2420, 'sword', 'machete', 1650, 0, '[\"Orc Spearman\"]', NULL, 12, 9, 2000, 1, NULL, NULL, NULL, 3308),
(2421, 'club', 'thunder hammer', 12500, 0, '[\"Apocalypse\", \"Bazir\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', NULL, 49, 35, 2000, 1, NULL, NULL, NULL, 3309),
(2422, 'club', 'iron hammer', 6600, 0, 'null', NULL, 18, 10, 2000, 1, NULL, NULL, NULL, 3310),
(2423, 'club', 'clerical mace', 5800, 0, '[\"Dwarf Geomancer\", \"Necromancer\", \"Necropharus\", \"Priestess\"]', NULL, 28, 15, 2000, 1, NULL, NULL, NULL, 3311),
(2424, 'club', 'silver mace', 6700, 0, 'null', NULL, 40, 30, 2000, 1, NULL, NULL, NULL, 3312),
(2425, 'axe', 'obsidian lance', 8000, 0, '[\"Orc Rider\", \"Stalker\"]', NULL, 68, 5, 3500, 2, NULL, NULL, NULL, 3313),
(2426, 'axe', 'naginata', 7800, 0, 'null', NULL, 78, 12, 3500, 2, NULL, NULL, NULL, 3314),
(2427, 'axe', 'guardian halberd', 11000, 0, 'null', NULL, 92, 7, 3500, 2, NULL, NULL, NULL, 3315),
(2428, 'axe', 'orcish axe', 4500, 0, '[\"Orc Rider\", \"Orc Warlord\"]', NULL, 23, 12, 2000, 1, NULL, NULL, NULL, 3316),
(2429, 'axe', 'barbarian axe', 5100, 0, 'null', NULL, 28, 18, 2000, 1, NULL, NULL, NULL, 3317),
(2430, 'axe', 'knight axe', 5900, 0, '[\"Black Knight\", \"Morguthis\"]', NULL, 33, 21, 2000, 1, NULL, NULL, NULL, 3318),
(2431, 'axe', 'stonecutter axe', 9900, 0, 'null', NULL, 50, 30, 2000, 1, NULL, NULL, NULL, 3319),
(2432, 'axe', 'fire axe', 4000, 0, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Mahrdis\", \"Morgaroth\", \"Orshabaal\"]', NULL, 38, 16, 2000, 1, NULL, NULL, NULL, 3320),
(2433, 'club', 'enchanted staff', 3800, 0, 'null', NULL, 39, 45, 2000, 2, NULL, 60, NULL, 3321),
(2434, 'club', 'dragon hammer', 9700, 0, '[\"Apocalypse\", \"Bazir\", \"Dragon\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orc Warlord\", \"Orshabaal\"]', NULL, 32, 20, 2000, 1, NULL, NULL, NULL, 3322),
(2435, 'axe', 'dwarven axe', 8200, 0, 'null', NULL, 31, 19, 2000, 1, NULL, NULL, NULL, 3323),
(2436, 'club', 'skull staff', 1700, 0, '[\"Apocalypse\", \"Bazir\", \"Dipthrah\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Necromancer\", \"Necropharus\", \"Orshabaal\", \"Warlock\"]', NULL, 36, 12, 2000, 1, NULL, NULL, NULL, 3324),
(2437, 'club', 'light mace', 4100, 0, 'null', NULL, 14, 9, NULL, 1, NULL, NULL, NULL, 3325),
(2438, 'sword', 'foil', 1450, 0, 'null', NULL, 9, 11, NULL, 1, NULL, NULL, NULL, 3326),
(2439, 'club', 'daramanian mace', 6800, 0, '[\"Scarab\"]', NULL, 21, 12, 2000, 1, NULL, NULL, NULL, 3327),
(2440, 'axe', 'daramanian waraxe', 5250, 0, '[\"Ancient Scarab\"]', NULL, 78, 7, 3500, 2, NULL, NULL, NULL, 3328),
(2441, 'axe', 'daramanian axe', 4100, 0, 'null', NULL, 16, 8, NULL, 1, NULL, NULL, NULL, 3329),
(2442, 'sword', 'heavy machete', 1840, 0, '[\"Efreet\", \"Marid\", \"Scarab\"]', NULL, 16, 10, 2000, 1, NULL, NULL, NULL, 3330),
(2443, 'axe', 'ravagers axe', 5250, 0, '[\"Morguthis\"]', NULL, 98, 7, 3500, 2, NULL, NULL, NULL, 3331),
(2444, 'club', 'hammer of wrath', 7000, 0, '[\"Ashmunrah\"]', NULL, 96, 6, 3500, 2, NULL, NULL, NULL, 3332),
(2445, 'club', 'crystal mace', 8000, 0, '[\"Vashresamun\"]', NULL, 38, 16, 2000, 1, NULL, NULL, NULL, 3333),
(2446, 'sword', 'pharaoh sword', 15000, 0, '[\"Dipthrah\"]', NULL, 41, 23, 2000, 1, NULL, NULL, NULL, 3334),
(2447, 'axe', 'twin axe', 6400, 0, '[\"Rahemos\"]', NULL, 90, 12, 3500, 2, NULL, NULL, NULL, 3335),
(2448, 'club', 'studded club', 3500, 0, '[\"Gargoyle\", \"Troll\"]', NULL, 9, 8, 2000, 1, NULL, NULL, NULL, 3336),
(2449, 'club', 'bone club', 3900, 0, '[\"Bonebeast\", \"Goblin\", \"Necropharus\"]', NULL, 12, 8, 2000, 1, NULL, NULL, NULL, 3337),
(2450, 'sword', 'bone sword', 1900, 0, '[\"Crypt Shambler\"]', NULL, 14, 10, 2000, 1, NULL, NULL, NULL, 3338),
(2451, 'sword', 'djinn blade', 2450, 0, '[\"Thalas\"]', NULL, 38, 22, 2000, 1, NULL, NULL, NULL, 3339),
(2452, 'club', 'heavy mace', 11000, 0, 'null', NULL, 100, 7, 3500, 2, NULL, NULL, NULL, 3340),
(2453, 'club', 'arcane staff', 4000, 0, 'null', NULL, 100, 15, 3500, 2, NULL, NULL, NULL, 3341),
(2454, 'axe', 'war axe', 6150, 0, 'null', NULL, 40, 5, 3500, 2, NULL, NULL, NULL, 3342),
(2455, 'distance', 'crossbow', 4000, 0, '[\"Dragon\", \"Dwarf Soldier\", \"Minotaur Archer\"]', NULL, NULL, NULL, 3000, 2, 7, NULL, NULL, 3349),
(2456, 'distance', 'bow', 3100, 0, '[\"Elf Scout\", \"Hero\", \"Hunter\"]', NULL, NULL, NULL, NULL, 2, 7, NULL, NULL, 3350),
(2457, 'head', 'steel helmet', 4600, 6, '[\"Black Knight\", \"Dragon\", \"Dwarf Guard\", \"Gargoyle\", \"Giant Spider\", \"The Old Widow\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3351),
(2458, 'head', 'chain helmet', 4200, 2, '[\"Minotaur\", \"Orc Berserker\", \"Orc Shaman\", \"Valkyrie\", \"Wild Warrior\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3352),
(2459, 'head', 'iron helmet', 3000, 5, '[\"Crypt Shambler\", \"Demon Skeleton\", \"Wild Warrior\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3353),
(2460, 'head', 'brass helmet', 2700, 3, '[\"Ghoul\", \"Hunter\", \"Minotaur\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3354),
(2461, 'head', 'leather helmet', 2200, 1, '[\"Goblin\", \"Hunter\", \"Illusion\", \"Minotaur Archer\", \"Minotaur Mage\", \"Troll\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3355),
(2462, 'head', 'devil helmet', 5000, 7, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3356),
(2463, 'body', 'plate armor', 12000, 10, '[\"Ancient Scarab\", \"Behemoth\", \"Black Knight\", \"Bonebeast\", \"Giant Spider\", \"Orc Leader\", \"Orc Warlord\", \"The Old Widow\", \"Valkyrie\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3357),
(2464, 'body', 'chain armor', 10000, 6, '[\"Dwarf Soldier\", \"Minotaur\", \"Minotaur Guard\", \"Orc Berserker\", \"Orc Shaman\", \"Orc Warrior\", \"Valkyrie\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3358),
(2465, 'body', 'brass armor', 8000, 8, '[\"General Murius\", \"Hunter\", \"Minotaur Archer\", \"Minotaur Guard\", \"Minotaur Mage\", \"Orc Warlord\", \"The Horned Fox\", \"Wild Warrior\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3359),
(2466, 'body', 'golden armor', 8000, 14, '[\"Warlock\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3360),
(2467, 'body', 'leather armor', 6000, 4, '[\"Amazon\", \"Goblin\", \"Illusion\", \"Monk\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3361),
(2468, 'legs', 'studded legs', 2600, 2, '[\"Dwarf Geomancer\", \"Orc Spearman\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3362),
(2469, 'legs', 'dragon scale legs', 4800, 10, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3363),
(2470, 'legs', 'golden legs', 5600, 9, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3364),
(2471, 'head', 'golden helmet', 3200, 12, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3365),
(2472, 'body', 'magic plate armor', 8500, 17, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3366),
(2473, 'head', 'viking helmet', 3900, 4, '[\"Ghoul\", \"Skeleton\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3367),
(2474, 'head', 'winged helmet', 1200, 10, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3368),
(2475, 'head', 'warrior helmet', 6800, 8, '[\"Black Knight\", \"Orc Leader\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3369),
(2476, 'body', 'knight armor', 12000, 12, '[\"Black Knight\", \"Giant Spider\", \"The Old Widow\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3370),
(2477, 'legs', 'knight legs', 7000, 8, '[\"Black Knight\", \"Giant Spider\", \"The Old Widow\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3371),
(2478, 'legs', 'brass legs', 3800, 5, '[\"Black Knight\", \"Giant Spider\", \"Orc Leader\", \"Orc Warlord\", \"Stalker\", \"The Old Widow\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3372),
(2479, 'head', 'strange helmet', 4600, 6, '[\"Demodras\", \"Dragon Lord\", \"Lich\", \"Vampire\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3373),
(2480, 'head', 'legion helmet', 3100, 4, '[\"Rotworm\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3374),
(2481, 'head', 'soldier helmet', 3200, 5, '[\"Dwarf Geomancer\", \"Dwarf Soldier\", \"Minotaur Archer\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3375),
(2482, 'head', 'studded helmet', 2450, 2, '[\"Elf\", \"Elf Scout\", \"Orc\", \"Orc Rider\", \"Orc Spearman\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3376),
(2483, 'body', 'scale armor', 10500, 9, '[\"Dwarf Guard\", \"Ghoul\", \"Grorlam\", \"Minotaur Archer\", \"Necromancer\", \"Necropharus\", \"Orc Rider\", \"Stone Golem\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3377),
(2484, 'body', 'studded armor', 7100, 5, '[\"Dwarf\", \"Elf\", \"Elf Scout\", \"Orc\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3378),
(2485, 'body', 'doublet', 2500, 2, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3379),
(2486, 'body', 'noble armor', 12000, 11, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3380),
(2487, 'body', 'crown armor', 9900, 13, '[\"Ashmunrah\", \"Hero\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3381),
(2488, 'legs', 'crown legs', 6500, 8, '[\"Hero\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3382),
(2489, 'body', 'dark armor', 12000, 10, '[\"Behemoth\", \"Black Knight\", \"Gargoyle\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3383),
(2490, 'head', 'dark helmet', 4600, 6, '[\"Black Knight\", \"Cyclops\", \"Orc Warlord\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3384),
(2491, 'head', 'crown helmet', 2950, 7, '[\"Hero\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3385),
(2492, 'body', 'dragon scale mail', 11400, 15, '[\"Demodras\", \"Dragon Lord\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3386),
(2493, 'head', 'demon helmet', 2950, 10, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3387),
(2494, 'body', 'demon armor', 8000, 16, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3388),
(2495, 'legs', 'demon legs', 7000, 9, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3389),
(2496, 'head', 'horned helmet', 5100, 11, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3390),
(2497, 'head', 'crusader helmet', 5200, 8, '[\"Orc Warlord\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3391),
(2498, 'head', 'royal helmet', 4800, 9, '[\"Demodras\", \"Dragon Lord\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3392),
(2499, 'head', 'amazon helmet', 2950, 7, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3393),
(2500, 'body', 'amazon armor', 9900, 13, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3394),
(2501, 'head', 'ceremonial mask', 4000, 9, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3395),
(2502, 'head', 'dwarfen helmet', 4200, 6, '[\"The Horned Fox\"]', '[[\"Protection\", \"2\", \"physical\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3396),
(2503, 'body', 'dwarven armor', 13000, 10, 'null', '[[\"Protection\", \"5\", \"physical\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3397),
(2504, 'legs', 'dwarfen legs', 4900, 6, 'null', '[[\"Protection\", \"3\", \"physical\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3398),
(2505, 'body', 'elven mail', 9000, 9, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3399),
(2506, 'head', 'dragon scale helmet', 3250, 9, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3400),
(2507, 'legs', 'elven legs', 3300, 4, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3401),
(2508, 'body', 'native armor', 8000, 7, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3402),
(2509, 'shield', 'steel shield', 6900, 0, '[\"Beholder\", \"Dragon\", \"Elder Beholder\", \"Grorlam\", \"Stone Golem\", \"The Evil Eye\", \"Wild Warrior\"]', NULL, NULL, 21, NULL, NULL, NULL, NULL, NULL, 3409),
(2510, 'shield', 'plate shield', 6500, 0, '[\"Cyclops\", \"Minotaur\", \"Orc Leader\"]', NULL, NULL, 17, NULL, NULL, NULL, NULL, NULL, 3410),
(2511, 'shield', 'brass shield', 6000, 0, '[\"Elf\", \"Skeleton\", \"Stalker\", \"Wild Warrior\"]', NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, 3411),
(2512, 'shield', 'wooden shield', 4000, 0, '[\"Beholder\", \"Frost Troll\", \"Gazer\", \"Orc Warrior\", \"The Evil Eye\", \"Troll\"]', NULL, NULL, 14, NULL, NULL, NULL, NULL, NULL, 3412),
(2513, 'shield', 'battle shield', 6200, 0, '[\"Cyclops\", \"Demon Skeleton\", \"Dwarf Guard\", \"Gargoyle\", \"General Murius\", \"Minotaur Guard\", \"Orc Rider\", \"The Horned Fox\"]', NULL, NULL, 23, NULL, NULL, NULL, NULL, NULL, 3413),
(2514, 'shield', 'mastermind shield', 5700, 0, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', NULL, NULL, 37, NULL, NULL, NULL, NULL, NULL, 3414),
(2515, 'shield', 'guardian shield', 5500, 0, '[\"Demon Skeleton\", \"Fire Devil\"]', NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, 3415),
(2516, 'shield', 'dragon shield', 6000, 0, '[\"Dragon\"]', NULL, NULL, 31, NULL, NULL, NULL, NULL, NULL, 3416),
(2517, 'shield', 'shield of honour', 5400, 0, 'null', NULL, NULL, 33, NULL, NULL, NULL, NULL, NULL, 3417),
(2518, 'shield', 'beholder shield', 4700, 0, '[\"Beholder\", \"Elder Beholder\", \"The Evil Eye\"]', NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, 3418),
(2519, 'shield', 'crown shield', 6200, 0, '[\"Hero\"]', NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, 3419),
(2520, 'shield', 'demon shield', 2600, 0, '[\"Apocalypse\", \"Bazir\", \"Demon\", \"Ferumbras\", \"Infernatil\", \"Morgaroth\", \"Orshabaal\"]', NULL, NULL, 35, NULL, NULL, NULL, NULL, NULL, 3420),
(2521, 'shield', 'dark shield', 5200, 0, 'null', NULL, NULL, 25, NULL, NULL, NULL, NULL, NULL, 3421),
(2522, 'shield', 'great shield', 8400, 0, 'null', NULL, NULL, 38, NULL, NULL, NULL, NULL, NULL, 3422),
(2523, 'shield', 'blessed shield', 6800, 0, 'null', NULL, NULL, 40, NULL, NULL, NULL, NULL, NULL, 3423),
(2524, 'shield', 'ornamented shield', 6700, 0, 'null', NULL, NULL, 22, NULL, NULL, NULL, NULL, NULL, 3424),
(2525, 'shield', 'dwarven shield', 5500, 0, '[\"Dwarf Soldier\"]', NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, 3425),
(2526, 'shield', 'studded shield', 5800, 0, '[\"Amazon\", \"Orc\"]', NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, 3426),
(2527, 'shield', 'rose shield', 5200, 0, 'null', NULL, NULL, 27, NULL, NULL, NULL, NULL, NULL, 3427),
(2528, 'shield', 'tower shield', 8200, 0, '[\"Demodras\", \"Dragon Lord\"]', NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, 3428),
(2529, 'shield', 'black shield', 4200, 0, '[\"Mummy\", \"Priestess\"]', NULL, NULL, 18, NULL, NULL, NULL, NULL, NULL, 3429),
(2530, 'shield', 'copper shield', 6300, 0, '[\"Dwarf\", \"Orc Warrior\", \"Rotworm\"]', NULL, NULL, 19, NULL, NULL, NULL, NULL, NULL, 3430),
(2531, 'shield', 'viking shield', 6600, 0, 'null', NULL, NULL, 22, NULL, NULL, NULL, NULL, NULL, 3431),
(2532, 'shield', 'ancient shield', 6100, 0, '[\"Ghost\"]', NULL, NULL, 27, NULL, NULL, NULL, NULL, NULL, 3432),
(2533, 'shield', 'griffin shield', 5000, 0, 'null', NULL, NULL, 29, NULL, NULL, NULL, NULL, NULL, 3433),
(2534, 'shield', 'vampire shield', 3800, 0, '[\"Vampire\"]', NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, 3434),
(2535, 'shield', 'castle shield', 4900, 0, '[\"Lich\"]', NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, 3435),
(2536, 'shield', 'medusa shield', 5800, 0, 'null', NULL, NULL, 33, NULL, NULL, NULL, NULL, NULL, 3436),
(2537, 'shield', 'amazon shield', 6200, 0, 'null', NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, 3437),
(2538, 'shield', 'eagle shield', 6200, 0, 'null', NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, 3438),
(2539, 'shield', 'phoenix shield', 3500, 0, '[\"Mahrdis\"]', NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, 3439),
(2540, 'shield', 'scarab shield', 4700, 0, '[\"Ancient Scarab\"]', NULL, NULL, 25, NULL, NULL, NULL, NULL, NULL, 3440),
(2541, 'shield', 'bone shield', 5500, 0, '[\"Bonebeast\", \"Crypt Shambler\", \"Necropharus\"]', NULL, NULL, 20, NULL, NULL, NULL, NULL, NULL, 3441),
(2542, 'shield', 'tempest shield', 5100, 0, 'null', NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, 3442),
(2543, 'ammunition', 'bolt', 80, 0, '[\"Dwarf Soldier\", \"Minotaur Archer\", \"Minotaur Archer\"]', NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, 3446),
(2544, 'ammunition', 'arrow', 70, 0, '[\"Elf\", \"Elf Arcanist\", \"Elf Scout\", \"Hero\", \"Hunter\", \"Hunter\", \"Omruc\", \"Scarab\"]', NULL, 25, NULL, NULL, NULL, NULL, NULL, NULL, 3447),
(2545, 'ammunition', 'poison arrow', 80, 0, '[\"Elf Scout\", \"Omruc\"]', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL, 3448),
(2546, 'ammunition', 'burst arrow', 90, 0, '[\"Dragon\", \"Hunter\", \"Omruc\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3449),
(2547, 'ammunition', 'power bolt', 90, 0, '[\"Demodras\", \"Dragon Lord\", \"Omruc\"]', NULL, 40, NULL, NULL, NULL, NULL, NULL, NULL, 3450),
(2548, 'tool', 'pitchfork', 2500, 0, '[\"Fire Devil\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3451),
(2549, 'tool', 'rake', 1500, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3452),
(2550, 'club', 'scythe', 3000, 0, 'null', NULL, 16, 1, 3500, 2, NULL, NULL, NULL, 3453),
(2551, 'tool', 'broom', 1100, 0, '[\"Witch\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3454),
(2552, 'tool', 'hoe', 2800, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3455),
(2553, 'tool', 'pick', 4500, 0, '[\"Behemoth\", \"Dwarf\", \"Grorlam\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3456),
(2554, 'tool', 'shovel', 3500, 0, '[\"Dwarf Soldier\", \"Minotaur\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3457),
(2558, 'tool', 'saw', 1000, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3461),
(2580, 'tool', 'fishing rod', 850, 0, '[\"General Murius\", \"Minotaur Guard\", \"Swamp Troll\", \"The Horned Fox\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3483),
(2640, 'feet', 'soft boots', 800, 0, 'null', '[[\"3\", \"healthgain\"], [\"6000\", \"healthticks\"], [\"12\", \"managain\"], [\"6000\", \"manaticks\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3549),
(2641, 'feet', 'patched boots', 1000, 2, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3550),
(2642, 'feet', 'sandals', 600, 0, '[\"Dharalion\", \"Elf Arcanist\", \"Elf Scout\", \"Fernfang\", \"Ghost\", \"Monk\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3551),
(2643, 'feet', 'leather boots', 900, 1, '[\"Dwarf Geomancer\", \"Dwarf Guard\", \"Elf\", \"Swamp Troll\", \"Troll\", \"Witch\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3552),
(2644, 'feet', 'bunnyslippers', 600, 0, '[\"Yeti\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3553),
(2645, 'feet', 'steel boots', 2900, 3, '[\"Behemoth\", \"Grorlam\", \"Morguthis\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3554),
(2646, 'feet', 'golden boots', 3100, 4, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3555),
(2647, 'legs', 'plate legs', 5000, 7, '[\"Dragon\", \"Orc Leader\", \"Orc Warlord\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3557),
(2648, 'legs', 'chain legs', 3500, 3, '[\"General Murius\", \"Minotaur Guard\", \"Minotaur Mage\", \"The Horned Fox\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3558),
(2649, 'legs', 'leather legs', 1800, 1, '[\"Dwarf\", \"Hunter\", \"Minotaur\", \"Minotaur Archer\", \"Minotaur Guard\", \"Minotaur Mage\", \"Stalker\", \"Vampire\", \"Wild Warrior\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3559),
(2650, 'body', 'jacket', 2400, 1, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3561),
(2651, 'body', 'coat', 2700, 1, '[\"Frost Troll\", \"Witch\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3562),
(2652, 'body', 'green tunic', 930, 1, '[\"Dharalion\", \"Elf Arcanist\", \"Fernfang\", \"Hero\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3563),
(2653, 'body', 'red tunic', 1400, 2, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3564),
(2654, 'body', 'cape', 3200, 1, '[\"Ghost\", \"Witch\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3565),
(2655, 'body', 'red robe', 2600, 1, '[\"Banshee\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3566),
(2656, 'body', 'blue robe', 2200, 11, '[\"Banshee\", \"Lich\", \"Vashresamun\", \"Warlock\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3567),
(2657, 'body', 'simple dress', 2400, 0, '[\"Banshee\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3568),
(2658, 'body', 'white dress', 2400, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3569),
(2659, 'body', 'ball gown', 2500, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3570),
(2660, 'body', 'rangers cloak', 3200, 1, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3571),
(2661, 'necklace', 'scarf', 200, 1, '[\"Hero\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3572),
(2662, 'head', 'magician hat', 750, 1, '[\"Rahemos\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3573),
(2663, 'head', 'mystic turban', 850, 1, '[\"Blue Djinn\", \"Efreet\", \"Green Djinn\", \"Marid\", \"Necromancer\", \"Necropharus\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3574),
(2664, 'head', 'wood cape', 1100, 2, 'null', '[[\"Protection\", \"4\", \"poison\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3575),
(2665, 'head', 'post officers hat', 700, 1, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3576),
(2666, 'food', 'meat', 1300, 0, '[\"Badger\", \"Bear\", \"Behemoth\", \"Black Sheep\", \"Cyclops\", \"Deer\", \"Gargoyle\", \"General Murius\", \"Hero\", \"Hyaena\", \"Larva\", \"Lion\", \"Minotaur\", \"Minotaur Archer\", \"Minotaur Guard\", \"Orc\", \"Orc Leader\", \"Orc Rider\", \"Orc Spearman\", \"Orc Warlord\", \"Orc Warrior\", \"Pig\", \"Polar Bear\", \"Rabbit\", \"Rotworm\", \"Scarab\", \"Sheep\", \"Skunk\", \"The Horned Fox\", \"Troll\", \"Valkyrie\", \"War Wolf\", \"Wild Warrior\", \"Winter Wolf\", \"Wolf\", \"Yeti\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3577),
(2667, 'food', 'fish', 520, 0, '[\"Frost Troll\", \"Goblin\", \"Illusion\", \"Orc Leader\", \"Orc Warlord\", \"Swamp Troll\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3578),
(2668, 'food', 'salmon', 320, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3579),
(2669, 'food', 'fish', 830, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3580),
(2670, 'food', 'shrimp', 50, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3581),
(2671, 'food', 'ham', 2000, 0, '[\"Bear\", \"Cyclops\", \"Deer\", \"Gargoyle\", \"Lion\", \"Orc Berserker\", \"Polar Bear\", \"Rotworm\", \"War Wolf\", \"Yeti\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3582),
(2672, 'food', 'dragon ham', 3000, 0, '[\"Demodras\", \"Dragon\", \"Dragon Lord\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3583),
(2673, 'food', 'pear', 140, 0, '[\"Dwarf Geomancer\", \"Efreet\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3584),
(2674, 'food', 'red apple', 150, 0, '[\"Elf\", \"Omruc\", \"Priestess\", \"Valkyrie\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3585),
(2675, 'food', 'orange', 110, 0, '[\"Hunter\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3586),
(2676, 'food', 'banana', 180, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3587),
(2677, 'food', 'blueberry', 20, 0, '[\"Marid\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3588),
(2678, 'food', 'coconut', 480, 0, '[\"Demon\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3589),
(2679, 'food', 'cherry', 20, 0, '[\"Bug\", \"Mimic\", \"Warlock\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3590),
(2680, 'food', 'strawberry', 20, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3591),
(2681, 'food', 'grapes', 250, 0, '[\"Elf Scout\", \"Hero\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3592),
(2682, 'food', 'melon', 950, 0, '[\"Dharalion\", \"Elf Arcanist\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3593),
(2683, 'food', 'pumpkin', 1350, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3594),
(2684, 'food', 'carrot', 160, 0, '[\"Blue Djinn\", \"Minotaur Mage\", \"Rabbit\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3595),
(2685, 'food', 'tomato', 100, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3596),
(2686, 'food', 'corncob', 350, 0, '[\"Orc Shaman\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3597),
(2687, 'food', 'cookie', 10, 0, '[\"Cave Rat\", \"Witch\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3598),
(2688, 'food', 'candy cane', 50, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3599),
(2689, 'food', 'bread', 500, 0, '[\"Dharalion\", \"Elf Arcanist\", \"Fernfang\", \"Monk\", \"Warlock\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3600),
(2690, 'food', 'roll', 100, 0, '[\"Hunter\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3601),
(2691, 'food', 'brown bread', 400, 0, '[\"Amazon\", \"Black Knight\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3602),
(2695, 'food', 'egg', 30, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3606),
(2696, 'food', 'cheese', 400, 0, '[\"Cave Rat\", \"Green Djinn\", \"Rat\", \"Witch\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3607),
(2787, 'food', 'white mushroom', 40, 0, '[\"Dwarf\", \"Dwarf Geomancer\", \"Dwarf Guard\", \"Dwarf Soldier\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3723),
(2788, 'food', 'red mushroom', 50, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3724),
(2789, 'food', 'brown mushroom', 20, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3725),
(2790, 'food', 'orange mushroom', 30, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3726),
(2792, 'food', 'dark mushroom', 10, 0, '[\"Warlock\"]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3728),
(3939, 'backpack', 'bag', 800, 0, 'null', '[[\"8\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2864),
(3940, 'backpack', 'backpack', 1800, 0, 'null', '[[\"20\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2872),
(3960, 'backpack', 'old and used backpack', 1800, 0, 'null', '[[\"20\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3244),
(4847, 'body', 'spectral dress', 1000, 0, 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4836),
(5090, 'quiver', 'arrow quiver', 1800, 0, 'null', '[[\"5\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5090),
(5091, 'quiver', 'bolt quiver', 1800, 0, 'null', '[[\"5\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5091),
(5093, 'backpack', 'Retronia backpack', 1800, 0, 'null', '[[\"40\", \"containersize\"]]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5103);

-- --------------------------------------------------------

--
-- Estrutura para tabela `guilds`
--

CREATE TABLE `guilds` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `ownerid` int NOT NULL,
  `creationdata` int NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `logo_name` varchar(255) NOT NULL DEFAULT 'default.gif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Acionadores `guilds`
--
DELIMITER $$
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('the Leader', 3, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Vice-Leader', 2, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Member', 1, NEW.`id`);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guildwar_kills`
--

CREATE TABLE `guildwar_kills` (
  `id` int NOT NULL,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int NOT NULL DEFAULT '0',
  `targetguild` int NOT NULL DEFAULT '0',
  `warid` int NOT NULL DEFAULT '0',
  `time` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_invites`
--

CREATE TABLE `guild_invites` (
  `player_id` int NOT NULL DEFAULT '0',
  `guild_id` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_membership`
--

CREATE TABLE `guild_membership` (
  `player_id` int NOT NULL,
  `guild_id` int NOT NULL,
  `rank_id` int NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_ranks`
--

CREATE TABLE `guild_ranks` (
  `id` int NOT NULL,
  `guild_id` int NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_wars`
--

CREATE TABLE `guild_wars` (
  `id` int NOT NULL,
  `guild1` int NOT NULL DEFAULT '0',
  `guild2` int NOT NULL DEFAULT '0',
  `name1` varchar(255) NOT NULL,
  `name2` varchar(255) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `started` bigint NOT NULL DEFAULT '0',
  `ended` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `houses`
--

CREATE TABLE `houses` (
  `id` int NOT NULL,
  `owner` int NOT NULL,
  `paid` int UNSIGNED NOT NULL DEFAULT '0',
  `warnings` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `rent` int NOT NULL DEFAULT '0',
  `town_id` int NOT NULL DEFAULT '0',
  `bid` int NOT NULL DEFAULT '0',
  `bid_end` int NOT NULL DEFAULT '0',
  `last_bid` int NOT NULL DEFAULT '0',
  `highest_bidder` int NOT NULL DEFAULT '0',
  `size` int NOT NULL DEFAULT '0',
  `beds` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `houses`
--

INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `beds`) VALUES
(1, 0, 0, 0, 'Spiritkeep', 19210, 1, 0, 0, 0, 0, 565, 23),
(2, 0, 0, 0, 'Snake Tower', 29720, 1, 0, 0, 0, 0, 859, 21),
(3, 0, 0, 0, 'Halls of the Adventurers', 15380, 1, 0, 0, 0, 0, 417, 18),
(4, 0, 0, 0, 'Dark Mansion', 17845, 1, 0, 0, 0, 0, 490, 17),
(5, 0, 0, 0, 'Bloodhall', 15270, 1, 0, 0, 0, 0, 439, 16),
(6, 0, 0, 0, 'Sunset Homes, Flat 01', 520, 1, 0, 0, 0, 0, 20, 1),
(7, 0, 0, 0, 'Sunset Homes, Flat 02', 520, 1, 0, 0, 0, 0, 20, 1),
(8, 0, 0, 0, 'Sunset Homes, Flat 03', 520, 1, 0, 0, 0, 0, 20, 1),
(9, 0, 0, 0, 'Sunset Homes, Flat 11', 520, 1, 0, 0, 0, 0, 20, 1),
(10, 0, 0, 0, 'Sunset Homes, Flat 12', 520, 1, 0, 0, 0, 0, 20, 1),
(11, 0, 0, 0, 'Sunset Homes, Flat 13', 860, 1, 0, 0, 0, 0, 28, 2),
(12, 0, 0, 0, 'Sunset Homes, Flat 14', 520, 1, 0, 0, 0, 0, 20, 1),
(13, 0, 0, 0, 'Sunset Homes, Flat 21', 520, 1, 0, 0, 0, 0, 20, 1),
(14, 0, 0, 0, 'Sunset Homes, Flat 22', 520, 1, 0, 0, 0, 0, 20, 1),
(15, 0, 0, 0, 'Sunset Homes, Flat 23', 860, 1, 0, 0, 0, 0, 28, 2),
(16, 0, 0, 0, 'Sunset Homes, Flat 24', 520, 1, 0, 0, 0, 0, 20, 1),
(17, 0, 0, 0, 'Beach Home Apartments, Flat 01', 715, 1, 0, 0, 0, 0, 19, 1),
(18, 0, 0, 0, 'Beach Home Apartments, Flat 02', 715, 1, 0, 0, 0, 0, 19, 1),
(19, 0, 0, 0, 'Beach Home Apartments, Flat 03', 715, 1, 0, 0, 0, 0, 20, 1),
(20, 0, 0, 0, 'Beach Home Apartments, Flat 04', 715, 1, 0, 0, 0, 0, 20, 1),
(21, 0, 0, 0, 'Beach Home Apartments, Flat 05', 715, 1, 0, 0, 0, 0, 20, 1),
(22, 0, 0, 0, 'Beach Home Apartments, Flat 06', 1145, 1, 0, 0, 0, 0, 28, 2),
(23, 0, 0, 0, 'Beach Home Apartments, Flat 11', 715, 1, 0, 0, 0, 0, 19, 1),
(24, 0, 0, 0, 'Beach Home Apartments, Flat 12', 880, 1, 0, 0, 0, 0, 23, 1),
(25, 0, 0, 0, 'Beach Home Apartments, Flat 13', 880, 1, 0, 0, 0, 0, 24, 1),
(26, 0, 0, 0, 'Beach Home Apartments, Flat 14', 385, 1, 0, 0, 0, 0, 12, 1),
(27, 0, 0, 0, 'Beach Home Apartments, Flat 15', 385, 1, 0, 0, 0, 0, 12, 1),
(28, 0, 0, 0, 'Beach Home Apartments, Flat 16', 1145, 1, 0, 0, 0, 0, 27, 2),
(29, 0, 0, 0, 'Alai Flats, Flat 01', 765, 1, 0, 0, 0, 0, 24, 1),
(30, 0, 0, 0, 'Alai Flats, Flat 02', 765, 1, 0, 0, 0, 0, 24, 1),
(31, 0, 0, 0, 'Alai Flats, Flat 03', 765, 1, 0, 0, 0, 0, 24, 1),
(32, 0, 0, 0, 'Alai Flats, Flat 04', 765, 1, 0, 0, 0, 0, 24, 1),
(33, 0, 0, 0, 'Alai Flats, Flat 05', 1225, 1, 0, 0, 0, 0, 34, 2),
(34, 0, 0, 0, 'Alai Flats, Flat 06', 1225, 1, 0, 0, 0, 0, 34, 2),
(35, 0, 0, 0, 'Alai Flats, Flat 07', 765, 1, 0, 0, 0, 0, 24, 1),
(36, 0, 0, 0, 'Alai Flats, Flat 08', 765, 1, 0, 0, 0, 0, 24, 1),
(37, 0, 0, 0, 'Alai Flats, Flat 11', 765, 1, 0, 0, 0, 0, 24, 1),
(38, 0, 0, 0, 'Alai Flats, Flat 12', 765, 1, 0, 0, 0, 0, 24, 1),
(39, 0, 0, 0, 'Alai Flats, Flat 13', 765, 1, 0, 0, 0, 0, 25, 1),
(40, 0, 0, 0, 'Alai Flats, Flat 14', 900, 1, 0, 0, 0, 0, 29, 1),
(41, 0, 0, 0, 'Alai Flats, Flat 15', 1450, 1, 0, 0, 0, 0, 43, 2),
(42, 0, 0, 0, 'Alai Flats, Flat 16', 1450, 1, 0, 0, 0, 0, 43, 2),
(43, 0, 0, 0, 'Alai Flats, Flat 17', 900, 1, 0, 0, 0, 0, 29, 1),
(44, 0, 0, 0, 'Alai Flats, Flat 18', 900, 1, 0, 0, 0, 0, 29, 1),
(45, 0, 0, 0, 'Alai Flats, Flat 22', 765, 1, 0, 0, 0, 0, 24, 1),
(46, 0, 0, 0, 'Alai Flats, Flat 21', 765, 1, 0, 0, 0, 0, 24, 1),
(47, 0, 0, 0, 'Alai Flats, Flat 23', 765, 1, 0, 0, 0, 0, 25, 1),
(48, 0, 0, 0, 'Alai Flats, Flat 24', 900, 1, 0, 0, 0, 0, 29, 1),
(49, 0, 0, 0, 'Alai Flats, Flat 25', 1450, 1, 0, 0, 0, 0, 43, 2),
(50, 0, 0, 0, 'Alai Flats, Flat 26', 1450, 1, 0, 0, 0, 0, 43, 2),
(51, 0, 0, 0, 'Alai Flats, Flat 27', 900, 1, 0, 0, 0, 0, 29, 1),
(52, 0, 0, 0, 'Alai Flats, Flat 28', 900, 1, 0, 0, 0, 0, 29, 1),
(53, 0, 0, 0, 'Upper Swamp Lane 2', 4740, 1, 0, 0, 0, 0, 111, 4),
(54, 0, 0, 0, 'Upper Swamp Lane 4', 4740, 1, 0, 0, 0, 0, 111, 4),
(55, 0, 0, 0, 'Lower Swamp Lane 1', 4740, 1, 0, 0, 0, 0, 111, 4),
(56, 0, 0, 0, 'Lower Swamp Lane 3', 4740, 1, 0, 0, 0, 0, 111, 4),
(57, 0, 0, 0, 'Upper Swamp Lane 8', 8120, 1, 0, 0, 0, 0, 187, 3),
(58, 0, 0, 0, 'Southern Thais Guildhall', 22260, 1, 0, 0, 0, 0, 507, 16),
(59, 0, 0, 0, 'Upper Swamp Lane 10', 2060, 1, 0, 0, 0, 0, 46, 3),
(60, 0, 0, 0, 'Upper Swamp Lane 12', 3800, 1, 0, 0, 0, 0, 93, 3),
(61, 0, 0, 0, 'Sorcerer\'s Avenue 1a', 1255, 1, 0, 0, 0, 0, 30, 2),
(62, 0, 0, 0, 'Sorcerer\'s Avenue 1b', 1035, 1, 0, 0, 0, 0, 25, 2),
(63, 0, 0, 0, 'Sorcerer\'s Avenue 1c', 1255, 1, 0, 0, 0, 0, 30, 2),
(64, 0, 0, 0, 'Sorcerer\'s Avenue 5', 2695, 1, 0, 0, 0, 0, 69, 1),
(65, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2a', 715, 1, 0, 0, 0, 0, 20, 1),
(66, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2b', 715, 1, 0, 0, 0, 0, 20, 1),
(67, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2c', 715, 1, 0, 0, 0, 0, 19, 1),
(68, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2d', 715, 1, 0, 0, 0, 0, 19, 1),
(69, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2e', 715, 1, 0, 0, 0, 0, 19, 1),
(70, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2f', 715, 1, 0, 0, 0, 0, 19, 1),
(71, 0, 0, 0, 'Thais Clanhall', 8420, 1, 0, 0, 0, 0, 282, 10),
(72, 0, 0, 0, 'Harbour Street 4', 935, 1, 0, 0, 0, 0, 25, 1),
(73, 0, 0, 0, 'Thais Hostel', 6980, 1, 0, 0, 0, 0, 143, 24),
(74, 0, 0, 0, 'Farm Lane, Basement (Shop)', 945, 1, 0, 0, 0, 0, 29, 0),
(75, 0, 0, 0, 'Farm Lane, 1st floor (Shop)', 945, 1, 0, 0, 0, 0, 29, 0),
(76, 0, 0, 0, 'Farm Lane, 2nd Floor (Shop)', 945, 1, 0, 0, 0, 0, 29, 0),
(77, 0, 1696186389, 0, 'Warriors Guildhall', 14725, 1, 0, 0, 0, 0, 440, 11),
(78, 0, 0, 0, 'Main Street 9, 1st floor (Shop)', 1440, 1, 0, 0, 0, 0, 44, 0),
(79, 0, 0, 0, 'Main Street 9a, 2nd floor (Shop)', 765, 1, 0, 0, 0, 0, 23, 0),
(80, 0, 0, 0, 'Main Street 9b, 2nd floor (Shop)', 1260, 1, 0, 0, 0, 0, 39, 0),
(81, 0, 0, 0, 'Mill Avenue 1 (Shop)', 1300, 1, 0, 0, 0, 0, 38, 1),
(82, 0, 0, 0, 'Mill Avenue 2 (Shop)', 2350, 1, 0, 0, 0, 0, 68, 2),
(83, 0, 0, 0, 'Mill Avenue 3', 1400, 1, 0, 0, 0, 0, 35, 2),
(84, 0, 0, 0, 'Mill Avenue 4', 1400, 1, 0, 0, 0, 0, 36, 2),
(85, 0, 0, 0, 'Mill Avenue 5', 3250, 1, 0, 0, 0, 0, 92, 4),
(86, 0, 1696187566, 0, 'The City Wall 5a', 585, 1, 0, 0, 0, 0, 20, 1),
(87, 0, 0, 0, 'The City Wall 5b', 585, 1, 0, 0, 0, 0, 20, 1),
(88, 0, 0, 0, 'The City Wall 5c', 585, 1, 0, 0, 0, 0, 20, 1),
(89, 0, 0, 0, 'The City Wall 5d', 585, 1, 0, 0, 0, 0, 20, 1),
(90, 0, 0, 0, 'The City Wall 5e', 585, 1, 0, 0, 0, 0, 20, 1),
(91, 0, 0, 0, 'The City Wall 5f', 585, 1, 0, 0, 0, 0, 20, 1),
(92, 0, 0, 0, 'The City Wall 7a', 585, 1, 0, 0, 0, 0, 20, 1),
(93, 0, 0, 0, 'The City Wall 7b', 585, 1, 0, 0, 0, 0, 20, 1),
(94, 0, 0, 0, 'The City Wall 7c', 865, 1, 0, 0, 0, 0, 25, 2),
(95, 0, 0, 0, 'The City Wall 7d', 865, 1, 0, 0, 0, 0, 25, 2),
(96, 0, 0, 0, 'The City Wall 7e', 865, 1, 0, 0, 0, 0, 24, 2),
(97, 0, 0, 0, 'The City Wall 7f', 865, 1, 0, 0, 0, 0, 24, 2),
(98, 0, 0, 0, 'The City Wall 7g', 585, 1, 0, 0, 0, 0, 19, 1),
(99, 0, 0, 0, 'The City Wall 7h', 585, 1, 0, 0, 0, 0, 19, 1),
(100, 0, 0, 0, 'The City Wall 9', 955, 1, 0, 0, 0, 0, 30, 2),
(101, 0, 0, 0, 'The City Wall 3a', 1045, 1, 0, 0, 0, 0, 30, 2),
(102, 0, 0, 0, 'The City Wall 3b', 1045, 1, 0, 0, 0, 0, 30, 2),
(103, 0, 0, 0, 'The City Wall 3c', 1045, 1, 0, 0, 0, 0, 30, 2),
(104, 0, 0, 0, 'The City Wall 3d', 1045, 1, 0, 0, 0, 0, 30, 2),
(105, 0, 0, 0, 'The City Wall 3e', 1045, 1, 0, 0, 0, 0, 30, 2),
(106, 0, 0, 0, 'The City Wall 3f', 1045, 1, 0, 0, 0, 0, 30, 2),
(107, 0, 0, 0, 'The City Wall 1a', 1270, 1, 0, 0, 0, 0, 36, 2),
(108, 0, 0, 0, 'The City Wall 1b', 1270, 1, 0, 0, 0, 0, 36, 2),
(109, 3, 1696186325, 0, 'Harbour Place 2 (Shop)', 1300, 1, 0, 0, 0, 0, 37, 1),
(110, 0, 0, 0, 'Harbour Place 1 (Shop)', 1100, 1, 0, 0, 0, 0, 33, 0),
(111, 0, 0, 0, 'Mercenary Tower', 41955, 1, 0, 0, 0, 0, 836, 26),
(112, 0, 0, 0, 'Guildhall of the Red Rose', 27725, 1, 0, 0, 0, 0, 516, 15),
(113, 0, 0, 0, 'Fibula Village 1', 845, 1, 0, 0, 0, 0, 20, 1),
(114, 0, 0, 0, 'Fibula Village 2', 845, 1, 0, 0, 0, 0, 20, 1),
(115, 0, 0, 0, 'Fibula Village 3', 3810, 1, 0, 0, 0, 0, 77, 4),
(116, 0, 0, 0, 'Fibula Village 4', 1790, 1, 0, 0, 0, 0, 35, 2),
(117, 0, 0, 0, 'Fibula Village 5', 1790, 1, 0, 0, 0, 0, 35, 2),
(118, 0, 0, 0, 'Fibula Village, Tower Flat', 5105, 1, 0, 0, 0, 0, 110, 2),
(119, 0, 0, 0, 'Fibula Village, Bar', 5235, 1, 0, 0, 0, 0, 98, 2),
(120, 0, 0, 0, 'Fibula Clanhall', 11430, 1, 0, 0, 0, 0, 236, 10),
(121, 0, 0, 0, 'Fibula Village, Villa', 11490, 1, 0, 0, 0, 0, 344, 7),
(122, 0, 0, 0, 'The Tibianic', 34500, 1, 0, 0, 0, 0, 814, 22),
(123, 0, 0, 0, 'Castle of Greenshore', 18740, 1, 0, 0, 0, 0, 440, 12),
(124, 0, 0, 0, 'Greenshore Village, Villa', 10440, 1, 0, 0, 0, 0, 230, 4),
(125, 0, 0, 0, 'Greenshore Village, Shop', 1800, 1, 0, 0, 0, 0, 45, 1),
(126, 0, 0, 0, 'Greenshore Village 1', 2420, 1, 0, 0, 0, 0, 49, 3),
(127, 0, 0, 0, 'Greenshore Village 2', 780, 1, 0, 0, 0, 0, 19, 1),
(128, 0, 0, 0, 'Greenshore Village 3', 780, 1, 0, 0, 0, 0, 19, 1),
(129, 0, 0, 0, 'Greenshore Village 4', 780, 1, 0, 0, 0, 0, 20, 1),
(130, 0, 0, 0, 'Greenshore Village 5', 780, 1, 0, 0, 0, 0, 20, 1),
(131, 0, 0, 0, 'Greenshore Village 6', 4360, 1, 0, 0, 0, 0, 98, 2),
(132, 0, 0, 0, 'Greenshore Village 7', 1260, 1, 0, 0, 0, 0, 30, 1),
(133, 0, 0, 0, 'Greenshore Clanhall', 10800, 1, 0, 0, 0, 0, 242, 10),
(134, 0, 0, 0, 'Moonkeep', 13020, 2, 0, 0, 0, 0, 404, 16),
(135, 0, 0, 0, 'House of Recreation', 22980, 2, 0, 0, 0, 0, 568, 16),
(136, 0, 0, 0, 'Nordic Stronghold', 18300, 2, 0, 0, 0, 0, 595, 21),
(137, 0, 0, 0, 'Druids Retreat A', 1340, 2, 0, 0, 0, 0, 43, 2),
(138, 0, 0, 0, 'Druids Retreat B', 1260, 2, 0, 0, 0, 0, 41, 2),
(139, 0, 0, 0, 'Druids Retreat C', 980, 2, 0, 0, 0, 0, 31, 2),
(140, 0, 0, 0, 'Druids Retreat D', 1180, 2, 0, 0, 0, 0, 37, 2),
(141, 0, 0, 0, 'Central Plaza 3', 600, 2, 0, 0, 0, 0, 14, 0),
(142, 0, 0, 0, 'Central Plaza 2', 600, 2, 0, 0, 0, 0, 14, 0),
(143, 0, 0, 0, 'Central Plaza 1', 600, 2, 0, 0, 0, 0, 14, 0),
(144, 0, 0, 0, 'Park Lane 1a', 1220, 2, 0, 0, 0, 0, 39, 2),
(145, 0, 0, 0, 'Park Lane 1b', 1380, 2, 0, 0, 0, 0, 46, 2),
(146, 0, 0, 0, 'Park Lane 3b', 1100, 2, 0, 0, 0, 0, 35, 2),
(147, 0, 0, 0, 'Park Lane 3a', 1220, 2, 0, 0, 0, 0, 39, 2),
(148, 0, 0, 0, 'Park Lane 4', 980, 2, 0, 0, 0, 0, 30, 2),
(149, 0, 0, 0, 'Park Lane 2', 980, 2, 0, 0, 0, 0, 29, 2),
(150, 0, 0, 0, 'Theater Avenue 6a', 820, 2, 0, 0, 0, 0, 23, 2),
(151, 0, 0, 0, 'Theater Avenue 6b', 820, 2, 0, 0, 0, 0, 23, 2),
(152, 0, 0, 0, 'Theater Avenue 6c', 225, 2, 0, 0, 0, 0, 8, 1),
(153, 0, 0, 0, 'Theater Avenue 6d', 225, 2, 0, 0, 0, 0, 8, 1),
(154, 0, 0, 0, 'Theater Avenue 6e', 820, 2, 0, 0, 0, 0, 24, 2),
(155, 0, 0, 0, 'Theater Avenue 6f', 820, 2, 0, 0, 0, 0, 24, 2),
(156, 0, 0, 0, 'Theater Avenue 5a', 450, 2, 0, 0, 0, 0, 16, 1),
(157, 0, 0, 0, 'Theater Avenue 5b', 450, 2, 0, 0, 0, 0, 16, 1),
(158, 0, 0, 0, 'Theater Avenue 5c', 450, 2, 0, 0, 0, 0, 15, 1),
(159, 0, 0, 0, 'Theater Avenue 5d', 450, 2, 0, 0, 0, 0, 15, 1),
(160, 0, 0, 0, 'Theater Avenue 8a', 1270, 2, 0, 0, 0, 0, 36, 2),
(161, 0, 0, 0, 'Theater Avenue 8b', 1370, 2, 0, 0, 0, 0, 36, 3),
(162, 0, 0, 0, 'Theater Avenue 7, Flat 01', 315, 2, 0, 0, 0, 0, 11, 1),
(163, 0, 0, 0, 'Theater Avenue 7, Flat 02', 405, 2, 0, 0, 0, 0, 14, 1),
(164, 0, 0, 0, 'Theater Avenue 7, Flat 03', 405, 2, 0, 0, 0, 0, 15, 1),
(165, 0, 0, 0, 'Theater Avenue 7, Flat 04', 495, 2, 0, 0, 0, 0, 18, 1),
(166, 0, 0, 0, 'Theater Avenue 7, Flat 05', 405, 2, 0, 0, 0, 0, 15, 1),
(167, 0, 0, 0, 'Theater Avenue 7, Flat 06', 315, 2, 0, 0, 0, 0, 12, 1),
(168, 0, 0, 0, 'Theater Avenue 7, Flat 11', 495, 2, 0, 0, 0, 0, 17, 1),
(169, 0, 0, 0, 'Theater Avenue 7, Flat 12', 405, 2, 0, 0, 0, 0, 14, 1),
(170, 0, 0, 0, 'Theater Avenue 7, Flat 13', 405, 2, 0, 0, 0, 0, 15, 1),
(171, 0, 0, 0, 'Theater Avenue 7, Flat 14', 495, 2, 0, 0, 0, 0, 18, 1),
(172, 0, 0, 0, 'Theater Avenue 7, Flat 15', 405, 2, 0, 0, 0, 0, 15, 1),
(173, 0, 0, 0, 'Theater Avenue 7, Flat 16', 405, 2, 0, 0, 0, 0, 14, 1),
(174, 0, 0, 0, 'Theater Avenue 10', 1090, 2, 0, 0, 0, 0, 31, 2),
(175, 0, 0, 0, 'Theater Avenue 12', 955, 2, 0, 0, 0, 0, 27, 2),
(176, 0, 0, 0, 'Theater Avenue 14 (Shop)', 2115, 2, 0, 0, 0, 0, 63, 1),
(177, 0, 0, 0, 'Theater Avenue 11a', 1405, 2, 0, 0, 0, 0, 39, 2),
(178, 0, 0, 0, 'Theater Avenue 11b', 585, 2, 0, 0, 0, 0, 19, 1),
(179, 0, 0, 0, 'Theater Avenue 11c', 585, 2, 0, 0, 0, 0, 19, 1),
(180, 0, 0, 0, 'Magician\'s Alley 1', 1050, 2, 0, 0, 0, 0, 28, 2),
(181, 0, 0, 0, 'Magician\'s Alley 1a', 700, 2, 0, 0, 0, 0, 19, 2),
(182, 0, 0, 0, 'Magician\'s Alley 1b', 750, 2, 0, 0, 0, 0, 20, 2),
(183, 0, 0, 0, 'Magician\'s Alley 1c', 500, 2, 0, 0, 0, 0, 15, 1),
(184, 0, 0, 0, 'Magician\'s Alley 1d', 450, 2, 0, 0, 0, 0, 14, 1),
(185, 0, 0, 0, 'Magician\'s Alley 5a', 350, 2, 0, 0, 0, 0, 12, 1),
(186, 0, 0, 0, 'Magician\'s Alley 5b', 500, 2, 0, 0, 0, 0, 16, 1),
(187, 0, 0, 0, 'Magician\'s Alley 5c', 1150, 2, 0, 0, 0, 0, 29, 2),
(188, 0, 0, 0, 'Magician\'s Alley 5d', 500, 2, 0, 0, 0, 0, 15, 1),
(189, 0, 0, 0, 'Magician\'s Alley 5e', 500, 2, 0, 0, 0, 0, 15, 1),
(190, 0, 0, 0, 'Magician\'s Alley 5f', 1150, 2, 0, 0, 0, 0, 29, 2),
(191, 0, 0, 0, 'Magician\'s Alley 4', 2750, 2, 0, 0, 0, 0, 68, 4),
(192, 0, 0, 0, 'Magician\'s Alley 8', 1400, 2, 0, 0, 0, 0, 35, 2),
(193, 0, 0, 0, 'Carlin Clanhall', 11800, 2, 0, 0, 0, 0, 315, 10),
(194, 0, 0, 0, 'Northern Street 1a', 940, 2, 0, 0, 0, 0, 30, 2),
(195, 0, 0, 0, 'Northern Street 1b', 940, 2, 0, 0, 0, 0, 30, 2),
(196, 0, 0, 0, 'Northern Street 1c', 740, 2, 0, 0, 0, 0, 24, 2),
(197, 0, 0, 0, 'Northern Street 3a', 740, 2, 0, 0, 0, 0, 24, 2),
(198, 0, 0, 0, 'Northern Street 3b', 780, 2, 0, 0, 0, 0, 24, 2),
(199, 0, 0, 0, 'Northern Street 5', 1980, 2, 0, 0, 0, 0, 67, 2),
(200, 0, 0, 0, 'Northern Street 7', 1700, 2, 0, 0, 0, 0, 58, 2),
(201, 0, 0, 0, 'Harbour Lane 1 (Shop)', 1040, 2, 0, 0, 0, 0, 38, 0),
(202, 0, 0, 0, 'Harbour Lane 3', 3560, 2, 0, 0, 0, 0, 109, 3),
(203, 0, 0, 0, 'Harbour Lane 2a (Shop)', 680, 2, 0, 0, 0, 0, 26, 0),
(204, 0, 0, 0, 'Harbour Lane 2b (Shop)', 680, 2, 0, 0, 0, 0, 26, 0),
(205, 0, 0, 0, 'Harbour Flats, Flat 11', 520, 2, 0, 0, 0, 0, 20, 1),
(206, 0, 0, 0, 'Harbour Flats, Flat 12', 400, 2, 0, 0, 0, 0, 15, 1),
(207, 0, 0, 0, 'Harbour Flats, Flat 13', 520, 2, 0, 0, 0, 0, 20, 1),
(208, 0, 0, 0, 'Harbour Flats, Flat 14', 400, 2, 0, 0, 0, 0, 15, 1),
(209, 0, 0, 0, 'Harbour Flats, Flat 15', 360, 2, 0, 0, 0, 0, 15, 1),
(210, 0, 0, 0, 'Harbour Flats, Flat 16', 400, 2, 0, 0, 0, 0, 15, 1),
(211, 0, 0, 0, 'Harbour Flats, Flat 17', 360, 2, 0, 0, 0, 0, 15, 1),
(212, 0, 0, 0, 'Harbour Flats, Flat 18', 400, 2, 0, 0, 0, 0, 15, 1),
(213, 0, 0, 0, 'Harbour Flats, Flat 21', 860, 2, 0, 0, 0, 0, 28, 2),
(214, 0, 0, 0, 'Harbour Flats, Flat 22', 980, 2, 0, 0, 0, 0, 32, 2),
(215, 0, 0, 0, 'Harbour Flats, Flat 23', 400, 2, 0, 0, 0, 0, 15, 1),
(216, 0, 0, 0, 'East Lane 1a', 2260, 2, 0, 0, 0, 0, 74, 2),
(217, 0, 0, 0, 'East Lane 1b', 1700, 2, 0, 0, 0, 0, 58, 2),
(218, 0, 0, 0, 'East Lane 2', 4580, 2, 0, 0, 0, 0, 149, 2),
(219, 0, 0, 0, 'Suntower', 10080, 2, 0, 0, 0, 0, 344, 9),
(220, 0, 0, 0, 'Lonely Sea Side Hostel', 12180, 2, 0, 0, 0, 0, 391, 8),
(221, 0, 0, 0, 'Northport Village 1', 1475, 2, 0, 0, 0, 0, 35, 2),
(222, 0, 0, 0, 'Northport Village 2', 1475, 2, 0, 0, 0, 0, 35, 2),
(223, 0, 0, 0, 'Northport Village 3', 5435, 2, 0, 0, 0, 0, 129, 2),
(224, 0, 0, 0, 'Northport Village 4', 2630, 2, 0, 0, 0, 0, 63, 2),
(225, 0, 0, 0, 'Seawatch', 25010, 2, 0, 0, 0, 0, 595, 19),
(226, 0, 0, 0, 'Northport Village 5', 1805, 2, 0, 0, 0, 0, 42, 2),
(227, 0, 0, 0, 'Northport Village 6', 2135, 2, 0, 0, 0, 0, 48, 2),
(228, 0, 0, 0, 'Northport Clanhall', 9810, 2, 0, 0, 0, 0, 237, 10),
(229, 0, 0, 0, 'Senja Village 1a', 765, 2, 0, 0, 0, 0, 25, 1),
(230, 0, 0, 0, 'Senja Village 1b', 1630, 2, 0, 0, 0, 0, 49, 2),
(231, 0, 0, 0, 'Senja Village 2', 765, 2, 0, 0, 0, 0, 24, 1),
(232, 0, 0, 0, 'Senja Village 3', 1765, 2, 0, 0, 0, 0, 54, 2),
(233, 0, 0, 0, 'Senja Village 4', 765, 2, 0, 0, 0, 0, 24, 1),
(234, 0, 0, 0, 'Senja Village 5', 1225, 2, 0, 0, 0, 0, 35, 2),
(235, 0, 0, 0, 'Senja Village 6a', 765, 2, 0, 0, 0, 0, 24, 1),
(236, 0, 0, 0, 'Senja Village 6b', 765, 2, 0, 0, 0, 0, 25, 1),
(237, 0, 0, 0, 'Senja Village 7', 865, 2, 0, 0, 0, 0, 25, 2),
(238, 0, 0, 0, 'Senja Village 8', 1675, 2, 0, 0, 0, 0, 51, 2),
(239, 0, 0, 0, 'Senja Village 9', 2575, 2, 0, 0, 0, 0, 80, 2),
(240, 0, 0, 0, 'Senja Village 10', 1485, 2, 0, 0, 0, 0, 48, 1),
(241, 0, 0, 0, 'Senja Village 11', 2620, 2, 0, 0, 0, 0, 75, 2),
(242, 0, 0, 0, 'Senja Clanhall', 10575, 2, 0, 0, 0, 0, 312, 10),
(243, 0, 1696186547, 0, 'Wolftower', 21550, 3, 0, 0, 0, 0, 556, 23),
(244, 0, 0, 0, 'Hill Hideout', 13950, 3, 0, 0, 0, 0, 334, 15),
(245, 0, 0, 0, 'Riverspring', 19450, 3, 0, 0, 0, 0, 502, 19),
(246, 0, 0, 0, 'The Farms 1', 2510, 3, 0, 0, 0, 0, 58, 3),
(247, 0, 0, 0, 'The Farms 2', 1530, 3, 0, 0, 0, 0, 35, 2),
(248, 0, 0, 0, 'The Farms 3', 1530, 3, 0, 0, 0, 0, 35, 2),
(249, 0, 0, 0, 'The Farms 4', 1530, 3, 0, 0, 0, 0, 35, 2),
(250, 0, 0, 0, 'The Farms 5', 1530, 3, 0, 0, 0, 0, 35, 2),
(251, 0, 0, 0, 'The Farms 6, Fishing Hut', 1255, 3, 0, 0, 0, 0, 29, 2),
(252, 0, 0, 0, 'Nobility Quarter 1', 1865, 3, 0, 0, 0, 0, 49, 3),
(253, 0, 0, 0, 'Nobility Quarter 2', 1865, 3, 0, 0, 0, 0, 49, 3),
(254, 0, 0, 0, 'Nobility Quarter 3', 1865, 3, 0, 0, 0, 0, 49, 3),
(255, 0, 0, 0, 'Nobility Quarter 4', 765, 3, 0, 0, 0, 0, 24, 1),
(256, 0, 0, 0, 'Nobility Quarter 5', 765, 3, 0, 0, 0, 0, 24, 1),
(257, 0, 0, 0, 'Nobility Quarter 6', 765, 3, 0, 0, 0, 0, 25, 1),
(258, 0, 0, 0, 'Nobility Quarter 7', 765, 3, 0, 0, 0, 0, 24, 1),
(259, 0, 0, 0, 'Nobility Quarter 8', 765, 3, 0, 0, 0, 0, 25, 1),
(260, 0, 0, 0, 'Nobility Quarter 9', 765, 3, 0, 0, 0, 0, 25, 1),
(261, 0, 0, 0, 'Upper Barracks 1', 210, 3, 0, 0, 0, 0, 12, 1),
(262, 0, 0, 0, 'Upper Barracks 2', 210, 3, 0, 0, 0, 0, 12, 1),
(263, 0, 0, 0, 'Upper Barracks 3', 210, 3, 0, 0, 0, 0, 12, 1),
(264, 0, 0, 0, 'Upper Barracks 4', 210, 3, 0, 0, 0, 0, 12, 1),
(265, 0, 0, 0, 'Upper Barracks 5', 210, 3, 0, 0, 0, 0, 11, 1),
(266, 0, 0, 0, 'Upper Barracks 6', 210, 3, 0, 0, 0, 0, 11, 1),
(267, 0, 0, 0, 'Upper Barracks 7', 210, 3, 0, 0, 0, 0, 11, 1),
(268, 0, 0, 0, 'Upper Barracks 8', 210, 3, 0, 0, 0, 0, 12, 1),
(269, 0, 0, 0, 'Upper Barracks 9', 210, 3, 0, 0, 0, 0, 12, 1),
(270, 0, 0, 0, 'Upper Barracks 10', 210, 3, 0, 0, 0, 0, 12, 1),
(271, 0, 0, 0, 'Upper Barracks 11', 210, 3, 0, 0, 0, 0, 12, 1),
(272, 0, 0, 0, 'Upper Barracks 12', 210, 3, 0, 0, 0, 0, 11, 1),
(273, 0, 0, 0, 'Upper Barracks 13', 580, 3, 0, 0, 0, 0, 23, 2),
(274, 0, 0, 0, 'The Market 1 (Shop)', 650, 3, 0, 0, 0, 0, 18, 0),
(275, 0, 0, 0, 'The Market 2 (Shop)', 1100, 3, 0, 0, 0, 0, 31, 0),
(276, 0, 0, 0, 'The Market 3 (Shop)', 1450, 3, 0, 0, 0, 0, 38, 0),
(277, 0, 0, 0, 'The Market 4 (Shop)', 1800, 3, 0, 0, 0, 0, 46, 0),
(278, 0, 0, 0, 'Lower Barracks 1', 300, 3, 0, 0, 0, 0, 16, 1),
(279, 0, 0, 0, 'Lower Barracks 2', 300, 3, 0, 0, 0, 0, 15, 1),
(280, 0, 0, 0, 'Lower Barracks 3', 300, 3, 0, 0, 0, 0, 16, 1),
(281, 0, 0, 0, 'Lower Barracks 4', 300, 3, 0, 0, 0, 0, 15, 1),
(282, 0, 0, 0, 'Lower Barracks 5', 300, 3, 0, 0, 0, 0, 16, 1),
(283, 0, 0, 0, 'Lower Barracks 6', 300, 3, 0, 0, 0, 0, 15, 1),
(284, 0, 0, 0, 'Lower Barracks 7', 300, 3, 0, 0, 0, 0, 16, 1),
(285, 0, 0, 0, 'Lower Barracks 8', 300, 3, 0, 0, 0, 0, 15, 1),
(286, 0, 0, 0, 'Lower Barracks 9', 300, 3, 0, 0, 0, 0, 16, 1),
(287, 0, 0, 0, 'Lower Barracks 10', 300, 3, 0, 0, 0, 0, 15, 1),
(288, 0, 0, 0, 'Lower Barracks 11', 300, 3, 0, 0, 0, 0, 16, 1),
(289, 0, 0, 0, 'Lower Barracks 12', 300, 3, 0, 0, 0, 0, 15, 1),
(290, 0, 0, 0, 'Lower Barracks 13', 300, 3, 0, 0, 0, 0, 15, 1),
(291, 0, 0, 0, 'Lower Barracks 14', 300, 3, 0, 0, 0, 0, 16, 1),
(292, 0, 0, 0, 'Lower Barracks 15', 300, 3, 0, 0, 0, 0, 15, 1),
(293, 0, 0, 0, 'Lower Barracks 16', 300, 3, 0, 0, 0, 0, 16, 1),
(294, 0, 0, 0, 'Lower Barracks 17', 300, 3, 0, 0, 0, 0, 15, 1),
(295, 0, 0, 0, 'Lower Barracks 18', 300, 3, 0, 0, 0, 0, 16, 1),
(296, 0, 0, 0, 'Lower Barracks 19', 300, 3, 0, 0, 0, 0, 15, 1),
(297, 0, 0, 0, 'Lower Barracks 20', 300, 3, 0, 0, 0, 0, 16, 1),
(298, 0, 0, 0, 'Lower Barracks 21', 300, 3, 0, 0, 0, 0, 15, 1),
(299, 0, 0, 0, 'Lower Barracks 22', 300, 3, 0, 0, 0, 0, 16, 1),
(300, 0, 0, 0, 'Lower Barracks 23', 300, 3, 0, 0, 0, 0, 15, 1),
(301, 0, 0, 0, 'Lower Barracks 24', 300, 3, 0, 0, 0, 0, 16, 1),
(302, 0, 0, 0, 'Tunnel Gardens 1', 1820, 3, 0, 0, 0, 0, 39, 3),
(303, 0, 0, 0, 'Tunnel Gardens 2 ', 1820, 3, 0, 0, 0, 0, 37, 3),
(304, 0, 0, 0, 'Tunnel Gardens 3', 2000, 3, 0, 0, 0, 0, 44, 3),
(305, 0, 0, 0, 'Tunnel Gardens 4', 2000, 3, 0, 0, 0, 0, 43, 3),
(306, 0, 0, 0, 'Tunnel Gardens 5', 1360, 3, 0, 0, 0, 0, 30, 2),
(307, 0, 0, 0, 'Tunnel Gardens 6', 1360, 3, 0, 0, 0, 0, 30, 2),
(308, 0, 0, 0, 'Tunnel Gardens 7', 1360, 3, 0, 0, 0, 0, 30, 2),
(309, 0, 0, 0, 'Tunnel Gardens 8', 1360, 3, 0, 0, 0, 0, 30, 2),
(310, 0, 0, 0, 'Tunnel Gardens 9', 1000, 3, 0, 0, 0, 0, 21, 2),
(311, 0, 0, 0, 'Tunnel Gardens 10', 1000, 3, 0, 0, 0, 0, 23, 2),
(312, 0, 0, 0, 'Tunnel Gardens 11', 1060, 3, 0, 0, 0, 0, 24, 2),
(313, 0, 0, 0, 'Tunnel Gardens 12', 1060, 3, 0, 0, 0, 0, 23, 2),
(314, 0, 0, 0, 'Marble Guildhall', 16810, 3, 0, 0, 0, 0, 486, 17),
(315, 0, 0, 0, 'Iron Guildhall', 15560, 3, 0, 0, 0, 0, 431, 18),
(316, 0, 0, 0, 'Granite Guildhall', 17845, 3, 0, 0, 0, 0, 505, 17),
(317, 0, 0, 0, 'Outlaw Camp 1', 1660, 3, 0, 0, 0, 0, 58, 2),
(318, 0, 0, 0, 'Outlaw Camp 2', 280, 3, 0, 0, 0, 0, 11, 1),
(319, 0, 0, 0, 'Outlaw Camp 3', 740, 3, 0, 0, 0, 0, 24, 2),
(320, 0, 0, 0, 'Outlaw Camp 4', 200, 3, 0, 0, 0, 0, 8, 1),
(321, 0, 0, 0, 'Outlaw Camp 5', 200, 3, 0, 0, 0, 0, 8, 1),
(322, 0, 0, 0, 'Outlaw Camp 6', 200, 3, 0, 0, 0, 0, 8, 1),
(323, 0, 0, 0, 'Outlaw Camp 7', 780, 3, 0, 0, 0, 0, 26, 2),
(324, 0, 0, 0, 'Outlaw Camp 8', 280, 3, 0, 0, 0, 0, 11, 1),
(325, 0, 0, 0, 'Outlaw Camp 9', 200, 3, 0, 0, 0, 0, 8, 1),
(326, 0, 0, 0, 'Outlaw Camp 10', 200, 3, 0, 0, 0, 0, 8, 1),
(327, 0, 0, 0, 'Outlaw Camp 11', 200, 3, 0, 0, 0, 0, 8, 1),
(328, 0, 0, 0, 'Outlaw Camp 12 (Shop)', 280, 3, 0, 0, 0, 0, 11, 0),
(329, 0, 0, 0, 'Outlaw Camp 13 (Shop)', 280, 3, 0, 0, 0, 0, 11, 0),
(330, 0, 0, 0, 'Outlaw Camp 14 (Shop)', 640, 3, 0, 0, 0, 0, 24, 0),
(331, 0, 0, 0, 'Outlaw Castle', 8000, 3, 0, 0, 0, 0, 276, 9),
(332, 0, 0, 0, 'Blessed Shield Guildhall', 8090, 7, 0, 0, 0, 0, 230, 9),
(333, 0, 0, 0, 'Steel Home', 13845, 7, 0, 0, 0, 0, 378, 13),
(334, 0, 0, 0, 'Swamp Watch', 11090, 7, 0, 0, 0, 0, 319, 12),
(335, 0, 0, 0, 'Golden Axe Guildhall', 10485, 7, 0, 0, 0, 0, 309, 10),
(336, 0, 0, 0, 'Valorous Venore', 14435, 7, 0, 0, 0, 0, 416, 9),
(337, 0, 0, 0, 'Dagger Alley 1', 2665, 7, 0, 0, 0, 0, 86, 2),
(338, 0, 0, 0, 'Iron Alley 1', 3450, 7, 0, 0, 0, 0, 101, 4),
(339, 0, 0, 0, 'Iron Alley 2', 3450, 7, 0, 0, 0, 0, 101, 4),
(340, 0, 0, 0, 'Dream Street 1 (Shop)', 4330, 7, 0, 0, 0, 0, 139, 2),
(341, 0, 0, 0, 'Dream Street 2', 3340, 7, 0, 0, 0, 0, 108, 2),
(342, 0, 0, 0, 'Dream Street 3', 2710, 7, 0, 0, 0, 0, 87, 2),
(343, 0, 0, 0, 'Dream Street 4', 3765, 7, 0, 0, 0, 0, 117, 4),
(344, 0, 0, 0, 'Elm Street 1', 2710, 7, 0, 0, 0, 0, 86, 2),
(345, 0, 0, 0, 'Elm Street 2', 2665, 7, 0, 0, 0, 0, 85, 2),
(346, 0, 0, 0, 'Elm Street 3', 2855, 7, 0, 0, 0, 0, 85, 3),
(347, 0, 0, 0, 'Elm Street 4', 2620, 7, 0, 0, 0, 0, 85, 2),
(348, 0, 0, 0, 'Seagull Walk 1', 5095, 7, 0, 0, 0, 0, 164, 2),
(349, 0, 0, 0, 'Seagull Walk 2', 2765, 7, 0, 0, 0, 0, 90, 3),
(350, 0, 0, 0, 'Lucky Lane 1 (Shop)', 6960, 7, 0, 0, 0, 0, 208, 4),
(351, 0, 0, 0, 'Paupers Palace, Flat 01', 405, 7, 0, 0, 0, 0, 15, 1),
(352, 0, 0, 0, 'Paupers Palace, Flat 02', 450, 7, 0, 0, 0, 0, 15, 1),
(353, 0, 0, 0, 'Paupers Palace, Flat 03', 405, 7, 0, 0, 0, 0, 15, 1),
(354, 0, 0, 0, 'Paupers Palace, Flat 04', 450, 7, 0, 0, 0, 0, 16, 1),
(355, 0, 0, 0, 'Paupers Palace, Flat 05', 315, 7, 0, 0, 0, 0, 12, 1),
(356, 0, 0, 0, 'Paupers Palace, Flat 06', 450, 7, 0, 0, 0, 0, 16, 1),
(357, 0, 0, 0, 'Paupers Palace, Flat 07', 685, 7, 0, 0, 0, 0, 19, 2),
(358, 0, 0, 0, 'Paupers Palace, Flat 11', 315, 7, 0, 0, 0, 0, 12, 1),
(359, 0, 0, 0, 'Paupers Palace, Flat 12', 685, 7, 0, 0, 0, 0, 19, 2),
(360, 0, 0, 0, 'Paupers Palace, Flat 13', 450, 7, 0, 0, 0, 0, 16, 1),
(361, 0, 0, 0, 'Paupers Palace, Flat 14', 585, 7, 0, 0, 0, 0, 19, 1),
(362, 0, 0, 0, 'Paupers Palace, Flat 15', 450, 7, 0, 0, 0, 0, 16, 1),
(363, 0, 0, 0, 'Paupers Palace, Flat 16', 585, 7, 0, 0, 0, 0, 19, 1),
(364, 0, 0, 0, 'Paupers Palace, Flat 17', 450, 7, 0, 0, 0, 0, 16, 1),
(365, 0, 0, 0, 'Paupers Palace, Flat 18', 315, 7, 0, 0, 0, 0, 12, 1),
(366, 0, 0, 0, 'Paupers Palace, Flat 21', 315, 7, 0, 0, 0, 0, 12, 1),
(367, 0, 0, 0, 'Paupers Palace, Flat 22', 450, 7, 0, 0, 0, 0, 16, 1),
(368, 0, 0, 0, 'Paupers Palace, Flat 23', 585, 7, 0, 0, 0, 0, 19, 1),
(369, 0, 0, 0, 'Paupers Palace, Flat 24', 450, 7, 0, 0, 0, 0, 16, 1),
(370, 0, 0, 0, 'Paupers Palace, Flat 25', 585, 7, 0, 0, 0, 0, 19, 1),
(371, 0, 0, 0, 'Paupers Palace, Flat 26', 450, 7, 0, 0, 0, 0, 16, 1),
(372, 0, 0, 0, 'Paupers Palace, Flat 27', 685, 7, 0, 0, 0, 0, 19, 2),
(373, 0, 0, 0, 'Paupers Palace, Flat 28', 315, 7, 0, 0, 0, 0, 12, 1),
(374, 0, 0, 0, 'Paupers Palace, Flat 31', 855, 7, 0, 0, 0, 0, 28, 1),
(375, 0, 0, 0, 'Paupers Palace, Flat 32', 1135, 7, 0, 0, 0, 0, 34, 2),
(376, 0, 0, 0, 'Paupers Palace, Flat 33', 765, 7, 0, 0, 0, 0, 27, 1),
(377, 0, 0, 0, 'Paupers Palace, Flat 34', 1675, 7, 0, 0, 0, 0, 51, 2),
(378, 0, 0, 0, 'Salvation Street 1 (Shop)', 6240, 7, 0, 0, 0, 0, 189, 4),
(379, 0, 0, 0, 'Salvation Street 2', 3790, 7, 0, 0, 0, 0, 116, 2),
(380, 0, 0, 0, 'Salvation Street 3', 3790, 7, 0, 0, 0, 0, 116, 2),
(381, 0, 0, 0, 'Mystic Lane 1', 2945, 7, 0, 0, 0, 0, 94, 3),
(382, 0, 0, 0, 'Mystic Lane 2', 2980, 7, 0, 0, 0, 0, 96, 2),
(383, 0, 0, 0, 'Silver Street 1', 2565, 7, 0, 0, 0, 0, 85, 1),
(384, 0, 0, 0, 'Silver Street 2', 1980, 7, 0, 0, 0, 0, 68, 1),
(385, 0, 0, 0, 'Silver Street 3', 1980, 7, 0, 0, 0, 0, 68, 1),
(386, 0, 0, 0, 'Silver Street 4', 3295, 7, 0, 0, 0, 0, 109, 2),
(387, 0, 0, 0, 'Loot Lane 1 (Shop)', 4565, 7, 0, 0, 0, 0, 145, 3),
(388, 0, 0, 0, 'Old Lighthouse', 3610, 7, 0, 0, 0, 0, 116, 2),
(389, 0, 0, 0, 'Market Street 1', 6680, 7, 0, 0, 0, 0, 200, 3),
(390, 0, 0, 0, 'Market Street 2', 4925, 7, 0, 0, 0, 0, 154, 3),
(391, 0, 0, 0, 'Market Street 3', 3475, 7, 0, 0, 0, 0, 109, 2),
(392, 0, 0, 0, 'Market Street 4 (Shop)', 5105, 7, 0, 0, 0, 0, 160, 3),
(393, 0, 0, 0, 'Market Street 5 (Shop)', 6375, 7, 0, 0, 0, 0, 185, 4),
(394, 0, 0, 0, 'Market Street 6', 5485, 7, 0, 0, 0, 0, 162, 5),
(395, 0, 0, 0, 'Market Street 7', 2305, 7, 0, 0, 0, 0, 77, 2),
(396, 0, 0, 0, 'Shadow Towers', 21800, 4, 0, 0, 0, 0, 571, 18),
(397, 0, 0, 0, 'The Hideout', 20800, 4, 0, 0, 0, 0, 521, 21),
(398, 0, 0, 0, 'Underwood 1', 1495, 4, 0, 0, 0, 0, 42, 2),
(399, 0, 0, 0, 'Underwood 2', 1495, 4, 0, 0, 0, 0, 42, 2),
(400, 0, 0, 0, 'Underwood 3', 1685, 4, 0, 0, 0, 0, 45, 3),
(401, 0, 0, 0, 'Underwood 4', 2235, 4, 0, 0, 0, 0, 56, 4),
(402, 0, 0, 0, 'Underwood 5', 1370, 4, 0, 0, 0, 0, 36, 3),
(403, 0, 0, 0, 'Underwood 6', 1595, 4, 0, 0, 0, 0, 42, 3),
(404, 0, 0, 0, 'Underwood 7', 1460, 4, 0, 0, 0, 0, 38, 3),
(405, 0, 0, 0, 'Underwood 8', 865, 4, 0, 0, 0, 0, 25, 2),
(406, 0, 0, 0, 'Underwood 9', 585, 4, 0, 0, 0, 0, 20, 1),
(407, 0, 0, 0, 'Underwood 10', 585, 4, 0, 0, 0, 0, 19, 1),
(408, 0, 0, 0, 'Ab\'Dendriel Clanhall', 14850, 4, 0, 0, 0, 0, 419, 10),
(409, 0, 0, 0, 'Castle of the Winds', 23885, 4, 0, 0, 0, 0, 694, 18),
(410, 0, 0, 0, 'Great Willow 1a', 500, 4, 0, 0, 0, 0, 16, 1),
(411, 0, 0, 0, 'Great Willow 1b', 650, 4, 0, 0, 0, 0, 19, 1),
(412, 0, 0, 0, 'Great Willow 1c', 650, 4, 0, 0, 0, 0, 19, 1),
(413, 0, 0, 0, 'Great Willow 2a', 650, 4, 0, 0, 0, 0, 20, 1),
(414, 0, 0, 0, 'Great Willow 2b', 450, 4, 0, 0, 0, 0, 14, 1),
(415, 0, 0, 0, 'Great Willow 2c', 650, 4, 0, 0, 0, 0, 19, 1),
(416, 0, 0, 0, 'Great Willow 2d', 450, 4, 0, 0, 0, 0, 14, 1),
(417, 0, 0, 0, 'Great Willow 3a', 650, 4, 0, 0, 0, 0, 20, 1),
(418, 0, 0, 0, 'Great Willow 3b', 450, 4, 0, 0, 0, 0, 14, 1),
(419, 0, 0, 0, 'Great Willow 3c', 650, 4, 0, 0, 0, 0, 19, 1),
(420, 0, 0, 0, 'Great Willow 3d', 450, 4, 0, 0, 0, 0, 14, 1),
(421, 0, 0, 0, 'Great Willow 4a', 950, 4, 0, 0, 0, 0, 25, 2),
(422, 0, 0, 0, 'Great Willow 4b', 950, 4, 0, 0, 0, 0, 25, 2),
(423, 0, 0, 0, 'Great Willow 4c', 950, 4, 0, 0, 0, 0, 25, 2),
(424, 0, 0, 0, 'Great Willow 4d', 750, 4, 0, 0, 0, 0, 22, 1),
(425, 0, 0, 0, 'Mangrove 1', 1750, 4, 0, 0, 0, 0, 42, 3),
(426, 0, 0, 0, 'Mangrove 2', 1350, 4, 0, 0, 0, 0, 35, 2),
(427, 0, 0, 0, 'Mangrove 3', 1150, 4, 0, 0, 0, 0, 30, 2),
(428, 0, 0, 0, 'Mangrove 4', 950, 4, 0, 0, 0, 0, 25, 2),
(429, 0, 0, 0, 'Treetop 1', 650, 4, 0, 0, 0, 0, 19, 1),
(430, 0, 0, 0, 'Treetop 2', 650, 4, 0, 0, 0, 0, 19, 1),
(431, 0, 0, 0, 'Treetop 3 (Shop)', 1250, 4, 0, 0, 0, 0, 38, 1),
(432, 0, 0, 0, 'Treetop 4 (Shop)', 1250, 4, 0, 0, 0, 0, 38, 1),
(433, 0, 0, 0, 'Treetop 5 (Shop)', 1350, 4, 0, 0, 0, 0, 39, 1),
(434, 0, 0, 0, 'Treetop 6', 450, 4, 0, 0, 0, 0, 15, 1),
(435, 0, 0, 0, 'Treetop 7', 800, 4, 0, 0, 0, 0, 24, 1),
(436, 0, 0, 0, 'Treetop 8', 800, 4, 0, 0, 0, 0, 24, 1),
(437, 0, 0, 0, 'Treetop 9', 1150, 4, 0, 0, 0, 0, 30, 2),
(438, 0, 0, 0, 'Treetop 10', 1150, 4, 0, 0, 0, 0, 29, 2),
(439, 0, 0, 0, 'Treetop 11', 900, 4, 0, 0, 0, 0, 23, 2),
(440, 0, 0, 0, 'Treetop 12 (Shop)', 1350, 4, 0, 0, 0, 0, 38, 1),
(441, 0, 0, 0, 'Treetop 13', 1400, 4, 0, 0, 0, 0, 36, 2),
(442, 0, 0, 0, 'Coastwood 1', 980, 4, 0, 0, 0, 0, 24, 2),
(443, 0, 0, 0, 'Coastwood 2', 980, 4, 0, 0, 0, 0, 24, 2),
(444, 0, 0, 0, 'Coastwood 3', 1310, 4, 0, 0, 0, 0, 31, 2),
(445, 0, 0, 0, 'Coastwood 4', 1145, 4, 0, 0, 0, 0, 29, 2),
(446, 0, 0, 0, 'Coastwood 5', 1530, 4, 0, 0, 0, 0, 36, 2),
(447, 0, 0, 0, 'Coastwood 6 (Shop)', 1595, 4, 0, 0, 0, 0, 41, 1),
(448, 0, 0, 0, 'Coastwood 7', 660, 4, 0, 0, 0, 0, 19, 1),
(449, 0, 0, 0, 'Coastwood 8', 1255, 4, 0, 0, 0, 0, 29, 2),
(450, 0, 0, 0, 'Coastwood 9', 935, 4, 0, 0, 0, 0, 25, 1),
(451, 0, 0, 0, 'Coastwood 10', 1630, 4, 0, 0, 0, 0, 36, 3),
(452, 0, 0, 0, 'Shadow Caves 1', 300, 4, 0, 0, 0, 0, 16, 1),
(453, 0, 0, 0, 'Shadow Caves 2', 300, 4, 0, 0, 0, 0, 15, 1),
(454, 0, 0, 0, 'Shadow Caves 3', 300, 4, 0, 0, 0, 0, 16, 1),
(455, 0, 0, 0, 'Shadow Caves 4', 300, 4, 0, 0, 0, 0, 15, 1),
(456, 0, 0, 0, 'Shadow Caves 11', 300, 4, 0, 0, 0, 0, 16, 1),
(457, 0, 0, 0, 'Shadow Caves 12', 300, 4, 0, 0, 0, 0, 15, 1),
(458, 0, 0, 0, 'Shadow Caves 13', 300, 4, 0, 0, 0, 0, 16, 1),
(459, 0, 0, 0, 'Shadow Caves 14', 300, 4, 0, 0, 0, 0, 15, 1),
(460, 0, 0, 0, 'Shadow Caves 15', 300, 4, 0, 0, 0, 0, 16, 1),
(461, 0, 0, 0, 'Shadow Caves 16', 300, 4, 0, 0, 0, 0, 15, 1),
(462, 0, 0, 0, 'Shadow Caves 17', 300, 4, 0, 0, 0, 0, 16, 1),
(463, 0, 0, 0, 'Shadow Caves 18', 300, 4, 0, 0, 0, 0, 15, 1),
(464, 0, 0, 0, 'Shadow Caves 21', 300, 4, 0, 0, 0, 0, 16, 1),
(465, 0, 0, 0, 'Shadow Caves 22', 300, 4, 0, 0, 0, 0, 15, 1),
(466, 0, 0, 0, 'Shadow Caves 23', 300, 4, 0, 0, 0, 0, 16, 1),
(467, 0, 0, 0, 'Shadow Caves 24', 300, 4, 0, 0, 0, 0, 15, 1),
(468, 0, 0, 0, 'Shadow Caves 25', 300, 4, 0, 0, 0, 0, 16, 1),
(469, 0, 0, 0, 'Shadow Caves 26', 300, 4, 0, 0, 0, 0, 15, 1),
(470, 0, 0, 0, 'Shadow Caves 27', 300, 4, 0, 0, 0, 0, 16, 1),
(471, 0, 0, 0, 'Shadow Caves 28', 300, 4, 0, 0, 0, 0, 15, 1),
(472, 0, 0, 0, 'Haggler\'s Hangout 1', 1400, 9, 0, 0, 0, 0, 36, 2),
(473, 0, 0, 0, 'Haggler\'s Hangout 2', 1300, 9, 0, 0, 0, 0, 36, 1),
(474, 0, 0, 0, 'Haggler\'s Hangout 3', 7550, 9, 0, 0, 0, 0, 193, 4),
(475, 0, 0, 0, 'Haggler\'s Hangout 4a', 1850, 9, 0, 0, 0, 0, 49, 1),
(476, 0, 0, 0, 'Haggler\'s Hangout 4b', 1550, 9, 0, 0, 0, 0, 42, 1),
(477, 0, 0, 0, 'Haggler\'s Hangout 5', 1550, 9, 0, 0, 0, 0, 39, 1),
(478, 0, 0, 0, 'Haggler\'s Hangout 6', 6450, 9, 0, 0, 0, 0, 164, 4),
(479, 0, 0, 0, 'Banana Bay 1', 450, 9, 0, 0, 0, 0, 16, 1),
(480, 0, 0, 0, 'Banana Bay 2', 765, 9, 0, 0, 0, 0, 25, 1),
(481, 0, 0, 0, 'Banana Bay 3', 450, 9, 0, 0, 0, 0, 16, 1),
(482, 0, 0, 0, 'Banana Bay 4', 450, 9, 0, 0, 0, 0, 16, 1),
(483, 0, 0, 0, 'Crocodile Bridge 1', 1045, 9, 0, 0, 0, 0, 30, 2),
(484, 0, 0, 0, 'Crocodile Bridge 2', 865, 9, 0, 0, 0, 0, 25, 2),
(485, 0, 0, 0, 'Crocodile Bridge 3', 1270, 9, 0, 0, 0, 0, 36, 2),
(486, 0, 0, 0, 'Crocodile Bridge 4', 4755, 9, 0, 0, 0, 0, 137, 4),
(487, 0, 0, 0, 'Crocodile Bridge 5', 3970, 9, 0, 0, 0, 0, 118, 2),
(488, 0, 0, 0, 'Woodway 1', 765, 9, 0, 0, 0, 0, 25, 1),
(489, 0, 0, 0, 'Woodway 2', 585, 9, 0, 0, 0, 0, 20, 1),
(490, 0, 0, 0, 'Woodway 3', 1540, 9, 0, 0, 0, 0, 47, 2),
(491, 0, 0, 0, 'Woodway 4', 405, 9, 0, 0, 0, 0, 15, 1),
(492, 0, 0, 0, 'Flamingo Flats 1', 685, 9, 0, 0, 0, 0, 20, 2),
(493, 0, 0, 0, 'Flamingo Flats 2', 1045, 9, 0, 0, 0, 0, 30, 2),
(494, 0, 0, 0, 'Flamingo Flats 3', 685, 9, 0, 0, 0, 0, 20, 2),
(495, 0, 0, 0, 'Flamingo Flats 4', 865, 9, 0, 0, 0, 0, 25, 2),
(496, 0, 0, 0, 'Flamingo Flats 5', 1845, 9, 0, 0, 0, 0, 59, 1),
(497, 0, 0, 0, 'Bamboo Garden 1', 1640, 9, 0, 0, 0, 0, 46, 3),
(498, 0, 0, 0, 'Bamboo Garden 2', 1045, 9, 0, 0, 0, 0, 30, 2),
(499, 0, 0, 0, 'Bamboo Garden 3', 1540, 9, 0, 0, 0, 0, 46, 2),
(500, 0, 0, 0, 'Coconut Quay 1', 1765, 9, 0, 0, 0, 0, 49, 2),
(501, 0, 0, 0, 'Coconut Quay 2', 1045, 9, 0, 0, 0, 0, 30, 2),
(502, 0, 0, 0, 'Coconut Quay 3', 2145, 9, 0, 0, 0, 0, 54, 4),
(503, 0, 0, 0, 'Coconut Quay 4', 2135, 9, 0, 0, 0, 0, 56, 3),
(504, 0, 0, 0, 'River Homes 1', 3485, 9, 0, 0, 0, 0, 97, 3),
(505, 0, 0, 0, 'River Homes 2a', 1270, 9, 0, 0, 0, 0, 36, 2),
(506, 0, 0, 0, 'River Homes 2b', 1595, 9, 0, 0, 0, 0, 42, 3),
(507, 0, 0, 0, 'River Homes 3', 5055, 9, 0, 0, 0, 0, 137, 7),
(508, 0, 0, 0, 'Jungle Edge 1', 2495, 9, 0, 0, 0, 0, 71, 3),
(509, 0, 0, 0, 'Jungle Edge 2', 3170, 9, 0, 0, 0, 0, 95, 3),
(510, 0, 0, 0, 'Jungle Edge 3', 865, 9, 0, 0, 0, 0, 25, 2),
(511, 0, 0, 0, 'Jungle Edge 4', 865, 9, 0, 0, 0, 0, 25, 2),
(512, 0, 0, 0, 'Jungle Edge 5', 865, 9, 0, 0, 0, 0, 25, 2),
(513, 0, 0, 0, 'Jungle Edge 6', 450, 9, 0, 0, 0, 0, 16, 1),
(514, 0, 0, 0, 'Shark Manor', 8780, 9, 0, 0, 0, 0, 232, 15),
(515, 0, 0, 0, 'Bamboo Fortress', 21970, 9, 0, 0, 0, 0, 662, 20),
(516, 0, 0, 0, 'The Treehouse', 24120, 9, 0, 0, 0, 0, 733, 23),
(517, 0, 0, 0, 'Castle Shop 1', 1890, 5, 0, 0, 0, 0, 58, 1),
(518, 0, 0, 0, 'Castle Shop 2', 1890, 5, 0, 0, 0, 0, 58, 1),
(519, 0, 0, 0, 'Castle Shop 3', 1890, 5, 0, 0, 0, 0, 58, 1),
(520, 0, 0, 0, 'Castle, 3rd Floor, Flat 01', 585, 5, 0, 0, 0, 0, 19, 1),
(521, 0, 0, 0, 'Castle, 3rd Floor, Flat 02', 765, 5, 0, 0, 0, 0, 24, 1),
(522, 0, 0, 0, 'Castle, 3rd Floor, Flat 03', 585, 5, 0, 0, 0, 0, 20, 1),
(523, 0, 0, 0, 'Castle, 3rd Floor, Flat 04', 585, 5, 0, 0, 0, 0, 20, 1),
(524, 0, 0, 0, 'Castle, 3rd Floor, Flat 05', 765, 5, 0, 0, 0, 0, 24, 1),
(525, 0, 0, 0, 'Castle, 3rd Floor, Flat 06', 1045, 5, 0, 0, 0, 0, 29, 2),
(526, 0, 0, 0, 'Castle, 3rd Floor, Flat 07', 720, 5, 0, 0, 0, 0, 24, 1),
(527, 0, 0, 0, 'Castle, 4th Floor, Flat 01', 585, 5, 0, 0, 0, 0, 19, 1),
(528, 0, 0, 0, 'Castle, 4th Floor, Flat 02', 765, 5, 0, 0, 0, 0, 24, 1),
(529, 0, 0, 0, 'Castle, 4th Floor, Flat 03', 585, 5, 0, 0, 0, 0, 20, 1),
(530, 0, 0, 0, 'Castle, 4th Floor, Flat 04', 585, 5, 0, 0, 0, 0, 20, 1),
(531, 0, 0, 0, 'Castle, 4th Floor, Flat 05', 765, 5, 0, 0, 0, 0, 24, 1),
(532, 0, 0, 0, 'Castle, 4th Floor, Flat 06', 945, 5, 0, 0, 0, 0, 29, 1),
(533, 0, 0, 0, 'Castle, 4th Floor, Flat 07', 720, 5, 0, 0, 0, 0, 24, 1),
(534, 0, 0, 0, 'Castle, 4th Floor, Flat 08', 945, 5, 0, 0, 0, 0, 29, 1),
(535, 0, 0, 0, 'Castle, 4th Floor, Flat 09', 720, 5, 0, 0, 0, 0, 23, 1),
(536, 0, 0, 0, 'Castle, Basement, Flat 01', 585, 5, 0, 0, 0, 0, 20, 1),
(537, 0, 0, 0, 'Castle, Basement, Flat 02', 585, 5, 0, 0, 0, 0, 19, 1),
(538, 0, 0, 0, 'Castle, Basement, Flat 03', 585, 5, 0, 0, 0, 0, 19, 1),
(539, 0, 0, 0, 'Castle, Basement, Flat 04', 585, 5, 0, 0, 0, 0, 19, 1),
(540, 0, 0, 0, 'Castle, Basement, Flat 05', 585, 5, 0, 0, 0, 0, 20, 1),
(541, 0, 0, 0, 'Castle, Basement, Flat 06', 585, 5, 0, 0, 0, 0, 20, 1),
(542, 0, 0, 0, 'Castle, Basement, Flat 07', 585, 5, 0, 0, 0, 0, 19, 1),
(543, 0, 0, 0, 'Castle, Basement, Flat 08', 585, 5, 0, 0, 0, 0, 19, 1),
(544, 0, 0, 0, 'Castle, Basement, Flat 09', 585, 5, 0, 0, 0, 0, 20, 1),
(545, 0, 0, 0, 'Castle Street 1', 2900, 5, 0, 0, 0, 0, 81, 3),
(546, 0, 0, 0, 'Castle Street 2', 1495, 5, 0, 0, 0, 0, 41, 2),
(547, 0, 0, 0, 'Castle Street 3', 1765, 5, 0, 0, 0, 0, 49, 2),
(548, 0, 0, 0, 'Castle Street 4', 1765, 5, 0, 0, 0, 0, 49, 2),
(549, 0, 0, 0, 'Castle Street 5', 1765, 5, 0, 0, 0, 0, 49, 2),
(550, 0, 0, 0, 'Edron Flats, Flat 01', 400, 5, 0, 0, 0, 0, 16, 1),
(551, 0, 0, 0, 'Edron Flats, Flat 02', 860, 5, 0, 0, 0, 0, 27, 2),
(552, 0, 0, 0, 'Edron Flats, Flat 03', 400, 5, 0, 0, 0, 0, 15, 1),
(553, 0, 0, 0, 'Edron Flats, Flat 04', 400, 5, 0, 0, 0, 0, 16, 1),
(554, 0, 0, 0, 'Edron Flats, Flat 05', 400, 5, 0, 0, 0, 0, 16, 1),
(555, 0, 0, 0, 'Edron Flats, Flat 06', 400, 5, 0, 0, 0, 0, 15, 1),
(556, 0, 0, 0, 'Edron Flats, Flat 07', 400, 5, 0, 0, 0, 0, 15, 1),
(557, 0, 0, 0, 'Edron Flats, Flat 08', 400, 5, 0, 0, 0, 0, 16, 1),
(558, 0, 0, 0, 'Edron Flats, Flat 11', 400, 5, 0, 0, 0, 0, 16, 1),
(559, 0, 0, 0, 'Edron Flats, Flat 12', 400, 5, 0, 0, 0, 0, 15, 1),
(560, 0, 0, 0, 'Edron Flats, Flat 13', 400, 5, 0, 0, 0, 0, 15, 1),
(561, 0, 0, 0, 'Edron Flats, Flat 14', 400, 5, 0, 0, 0, 0, 16, 1),
(562, 0, 0, 0, 'Edron Flats, Flat 15', 400, 5, 0, 0, 0, 0, 16, 1),
(563, 0, 0, 0, 'Edron Flats, Flat 16', 400, 5, 0, 0, 0, 0, 15, 1),
(564, 0, 0, 0, 'Edron Flats, Flat 17', 400, 5, 0, 0, 0, 0, 15, 1),
(565, 0, 0, 0, 'Edron Flats, Flat 18', 400, 5, 0, 0, 0, 0, 16, 1),
(566, 0, 0, 0, 'Edron Flats, Flat 21', 860, 5, 0, 0, 0, 0, 28, 2),
(567, 0, 0, 0, 'Edron Flats, Flat 22', 400, 5, 0, 0, 0, 0, 15, 1),
(568, 0, 0, 0, 'Edron Flats, Flat 23', 400, 5, 0, 0, 0, 0, 15, 1),
(569, 0, 0, 0, 'Edron Flats, Flat 24', 400, 5, 0, 0, 0, 0, 16, 1),
(570, 0, 0, 0, 'Edron Flats, Flat 25', 400, 5, 0, 0, 0, 0, 16, 1),
(571, 0, 0, 0, 'Edron Flats, Flat 26', 400, 5, 0, 0, 0, 0, 15, 1),
(572, 0, 0, 0, 'Edron Flats, Flat 27', 400, 5, 0, 0, 0, 0, 15, 1),
(573, 0, 0, 0, 'Edron Flats, Flat 28', 400, 5, 0, 0, 0, 0, 16, 1),
(574, 0, 0, 0, 'Edron Flats, Basement Flat 1', 1540, 5, 0, 0, 0, 0, 47, 2),
(575, 0, 0, 0, 'Edron Flats, Basement Flat 2', 1540, 5, 0, 0, 0, 0, 47, 2),
(576, 0, 0, 0, 'Central Circle 1', 3020, 5, 0, 0, 0, 0, 102, 2),
(577, 0, 0, 0, 'Central Circle 2', 3300, 5, 0, 0, 0, 0, 110, 2),
(578, 0, 0, 0, 'Central Circle 3', 4160, 5, 0, 0, 0, 0, 138, 5),
(579, 0, 0, 0, 'Central Circle 4', 4160, 5, 0, 0, 0, 0, 138, 5),
(580, 0, 0, 0, 'Central Circle 5', 4160, 5, 0, 0, 0, 0, 138, 5),
(581, 0, 0, 0, 'Central Circle 6 (Shop)', 3980, 5, 0, 0, 0, 0, 141, 2),
(582, 0, 0, 0, 'Central Circle 7 (Shop)', 3980, 5, 0, 0, 0, 0, 141, 2),
(583, 0, 0, 0, 'Central Circle 8 (Shop)', 3980, 5, 0, 0, 0, 0, 141, 2),
(584, 0, 0, 0, 'Central Circle 9a', 940, 5, 0, 0, 0, 0, 30, 2),
(585, 0, 0, 0, 'Central Circle 9b', 940, 5, 0, 0, 0, 0, 30, 2),
(586, 0, 0, 0, 'Wood Avenue 1', 1765, 5, 0, 0, 0, 0, 49, 2),
(587, 0, 0, 0, 'Wood Avenue 2', 1765, 5, 0, 0, 0, 0, 48, 2),
(588, 0, 0, 0, 'Wood Avenue 3', 1765, 5, 0, 0, 0, 0, 48, 2),
(589, 0, 0, 0, 'Wood Avenue 4', 1765, 5, 0, 0, 0, 0, 49, 2),
(590, 0, 0, 0, 'Wood Avenue 5', 1765, 5, 0, 0, 0, 0, 48, 2),
(591, 0, 0, 0, 'Wood Avenue 6a', 1450, 5, 0, 0, 0, 0, 45, 2),
(592, 0, 0, 0, 'Wood Avenue 6b', 1450, 5, 0, 0, 0, 0, 46, 2),
(593, 0, 0, 0, 'Wood Avenue 7', 5960, 5, 0, 0, 0, 0, 182, 3),
(594, 0, 0, 0, 'Wood Avenue 8', 5960, 5, 0, 0, 0, 0, 182, 3),
(595, 0, 0, 0, 'Wood Avenue 9a', 1540, 5, 0, 0, 0, 0, 48, 2),
(596, 0, 0, 0, 'Wood Avenue 9b', 1495, 5, 0, 0, 0, 0, 48, 2),
(597, 0, 0, 0, 'Wood Avenue 10a', 1540, 5, 0, 0, 0, 0, 48, 2),
(598, 0, 0, 0, 'Wood Avenue 10b', 1595, 5, 0, 0, 0, 0, 47, 3),
(599, 0, 0, 0, 'Wood Avenue 11', 7205, 5, 0, 0, 0, 0, 210, 6),
(600, 0, 0, 0, 'Wood Avenue 4a', 1495, 5, 0, 0, 0, 0, 42, 2),
(601, 0, 0, 0, 'Wood Avenue 4b', 1495, 5, 0, 0, 0, 0, 41, 2),
(602, 0, 0, 0, 'Wood Avenue 4c', 1765, 5, 0, 0, 0, 0, 49, 2),
(603, 0, 0, 0, 'Sky Lane, Guild 1', 21145, 5, 0, 0, 0, 0, 557, 23),
(604, 0, 0, 0, 'Sky Lane, Guild 2', 19300, 5, 0, 0, 0, 0, 547, 14),
(605, 0, 0, 0, 'Sky Lane, Guild 3', 17315, 5, 0, 0, 0, 0, 469, 18),
(606, 0, 0, 0, 'Sky Lane, Sea Tower', 4775, 5, 0, 0, 0, 0, 138, 6),
(607, 0, 0, 0, 'Magic Academy, Guild', 12025, 5, 0, 0, 0, 0, 284, 14),
(608, 0, 0, 0, 'Magic Academy, Shop', 1595, 5, 0, 0, 0, 0, 33, 1),
(609, 0, 0, 0, 'Magic Academy, Flat 1', 1465, 5, 0, 0, 0, 0, 35, 3),
(610, 0, 0, 0, 'Magic Academy, Flat 2', 1530, 5, 0, 0, 0, 0, 37, 2),
(611, 0, 0, 0, 'Magic Academy, Flat 3', 1430, 5, 0, 0, 0, 0, 37, 1),
(612, 0, 0, 0, 'Magic Academy, Flat 4', 1530, 5, 0, 0, 0, 0, 37, 2),
(613, 0, 0, 0, 'Magic Academy, Flat 5', 1430, 5, 0, 0, 0, 0, 37, 1),
(614, 0, 0, 0, 'Stonehome Village 1', 1780, 5, 0, 0, 0, 0, 58, 2),
(615, 0, 0, 0, 'Stonehome Village 2', 640, 5, 0, 0, 0, 0, 24, 1),
(616, 0, 0, 0, 'Stonehome Village 3', 680, 5, 0, 0, 0, 0, 25, 1),
(617, 0, 0, 0, 'Stonehome Village 4', 940, 5, 0, 0, 0, 0, 30, 2),
(618, 0, 0, 0, 'Stonehome Village 5', 1140, 5, 0, 0, 0, 0, 35, 2),
(619, 0, 0, 0, 'Stonehome Village 6', 1300, 5, 0, 0, 0, 0, 40, 2),
(620, 0, 0, 0, 'Stonehome Village 7', 1140, 5, 0, 0, 0, 0, 36, 2),
(621, 0, 0, 0, 'Stonehome Village 8', 680, 5, 0, 0, 0, 0, 25, 1),
(622, 0, 0, 0, 'Stonehome Village 9', 680, 5, 0, 0, 0, 0, 25, 1),
(623, 0, 0, 0, 'Stonehome Flats, Flat 01', 400, 5, 0, 0, 0, 0, 16, 1),
(624, 0, 0, 0, 'Stonehome Flats, Flat 02', 740, 5, 0, 0, 0, 0, 23, 2),
(625, 0, 0, 0, 'Stonehome Flats, Flat 03', 400, 5, 0, 0, 0, 0, 15, 1),
(626, 0, 0, 0, 'Stonehome Flats, Flat 04', 400, 5, 0, 0, 0, 0, 16, 1),
(627, 0, 0, 0, 'Stonehome Flats, Flat 05', 400, 5, 0, 0, 0, 0, 16, 1),
(628, 0, 0, 0, 'Stonehome Flats, Flat 06', 400, 5, 0, 0, 0, 0, 15, 1),
(629, 0, 0, 0, 'Stonehome Flats, Flat 11', 740, 5, 0, 0, 0, 0, 24, 2),
(630, 0, 0, 0, 'Stonehome Flats, Flat 12', 740, 5, 0, 0, 0, 0, 23, 2),
(631, 0, 0, 0, 'Stonehome Flats, Flat 13', 400, 5, 0, 0, 0, 0, 15, 1),
(632, 0, 0, 0, 'Stonehome Flats, Flat 14', 400, 5, 0, 0, 0, 0, 16, 1),
(633, 0, 0, 0, 'Stonehome Flats, Flat 15', 400, 5, 0, 0, 0, 0, 16, 1),
(634, 0, 0, 0, 'Stonehome Flats, Flat 16', 400, 5, 0, 0, 0, 0, 15, 1),
(635, 0, 0, 0, 'Stonehome Clanhall', 8580, 5, 0, 0, 0, 0, 284, 10),
(636, 0, 0, 0, 'Cormaya Flats, Flat 01', 450, 5, 0, 0, 0, 0, 16, 1),
(637, 0, 0, 0, 'Cormaya Flats, Flat 02', 450, 5, 0, 0, 0, 0, 16, 1),
(638, 0, 0, 0, 'Cormaya Flats, Flat 03', 820, 5, 0, 0, 0, 0, 24, 2),
(639, 0, 0, 0, 'Cormaya Flats, Flat 04', 820, 5, 0, 0, 0, 0, 23, 2),
(640, 0, 0, 0, 'Cormaya Flats, Flat 05', 450, 5, 0, 0, 0, 0, 15, 1),
(641, 0, 0, 0, 'Cormaya Flats, Flat 06', 450, 5, 0, 0, 0, 0, 15, 1),
(642, 0, 0, 0, 'Cormaya Flats, Flat 11', 450, 5, 0, 0, 0, 0, 16, 1),
(643, 0, 0, 0, 'Cormaya Flats, Flat 12', 450, 5, 0, 0, 0, 0, 16, 1),
(644, 0, 0, 0, 'Cormaya Flats, Flat 13', 820, 5, 0, 0, 0, 0, 24, 2),
(645, 0, 0, 0, 'Cormaya Flats, Flat 14', 820, 5, 0, 0, 0, 0, 23, 2),
(646, 0, 0, 0, 'Cormaya Flats, Flat 15', 450, 5, 0, 0, 0, 0, 15, 1),
(647, 0, 0, 0, 'Cormaya Flats, Flat 16', 450, 5, 0, 0, 0, 0, 15, 1),
(648, 0, 0, 0, 'Cormaya 1', 1270, 5, 0, 0, 0, 0, 36, 2),
(649, 0, 0, 0, 'Cormaya 2', 3710, 5, 0, 0, 0, 0, 109, 3),
(650, 0, 0, 0, 'Cormaya 3', 2035, 5, 0, 0, 0, 0, 55, 2),
(651, 0, 0, 0, 'Cormaya 4', 1720, 5, 0, 0, 0, 0, 48, 2),
(652, 0, 0, 0, 'Cormaya 5', 5600, 5, 0, 0, 0, 0, 156, 3),
(653, 0, 0, 0, 'Cormaya 6', 2395, 5, 0, 0, 0, 0, 71, 2),
(654, 0, 0, 0, 'Cormaya 7', 2395, 5, 0, 0, 0, 0, 71, 2),
(655, 0, 0, 0, 'Cormaya 8', 2710, 5, 0, 0, 0, 0, 82, 2),
(656, 0, 0, 0, 'Cormaya 9a', 1225, 5, 0, 0, 0, 0, 34, 2),
(657, 0, 0, 0, 'Cormaya 9b', 2620, 5, 0, 0, 0, 0, 76, 2),
(658, 0, 0, 0, 'Cormaya 9c', 1225, 5, 0, 0, 0, 0, 34, 2),
(659, 0, 0, 0, 'Cormaya 9d', 2620, 5, 0, 0, 0, 0, 76, 2),
(660, 0, 0, 0, 'Cormaya 10', 3800, 5, 0, 0, 0, 0, 109, 3),
(661, 0, 0, 0, 'Cormaya 11', 2035, 5, 0, 0, 0, 0, 55, 2),
(662, 0, 0, 0, 'Castle of the White Dragon', 24975, 5, 0, 0, 0, 0, 695, 19),
(663, 0, 0, 0, 'Chameken I', 850, 8, 0, 0, 0, 0, 25, 1),
(664, 0, 0, 0, 'Chameken II', 850, 8, 0, 0, 0, 0, 25, 1),
(665, 0, 0, 0, 'Thanah I a', 850, 8, 0, 0, 0, 0, 25, 1),
(666, 0, 0, 0, 'Thanah I b', 3000, 8, 0, 0, 0, 0, 79, 3),
(667, 0, 0, 0, 'Thanah I c', 3250, 8, 0, 0, 0, 0, 87, 3),
(668, 0, 0, 0, 'Thanah I d', 2900, 8, 0, 0, 0, 0, 75, 4),
(669, 0, 0, 0, 'Thanah II a', 850, 8, 0, 0, 0, 0, 25, 1),
(670, 0, 0, 0, 'Thanah II b', 450, 8, 0, 0, 0, 0, 15, 1),
(671, 0, 0, 0, 'Thanah II c', 450, 8, 0, 0, 0, 0, 14, 1),
(672, 0, 0, 0, 'Thanah II d', 350, 8, 0, 0, 0, 0, 12, 1),
(673, 0, 0, 0, 'Thanah II e', 350, 8, 0, 0, 0, 0, 11, 1),
(674, 0, 0, 0, 'Thanah II f', 2850, 8, 0, 0, 0, 0, 76, 3),
(675, 0, 0, 0, 'Thanah II g', 1650, 8, 0, 0, 0, 0, 42, 2),
(676, 0, 0, 0, 'Thanah II h', 1400, 8, 0, 0, 0, 0, 38, 2),
(677, 0, 0, 0, 'Thrarhor I a (Shop)', 1050, 8, 0, 0, 0, 0, 29, 1),
(678, 0, 0, 0, 'Thrarhor I b (Shop)', 1050, 8, 0, 0, 0, 0, 23, 1),
(679, 0, 0, 0, 'Thrarhor I c (Shop)', 1050, 8, 0, 0, 0, 0, 27, 1),
(680, 0, 0, 0, 'Thrarhor I d (Shop)', 1050, 8, 0, 0, 0, 0, 21, 1),
(681, 0, 0, 0, 'Botham I a', 950, 8, 0, 0, 0, 0, 28, 1),
(682, 0, 0, 0, 'Botham I b', 3000, 8, 0, 0, 0, 0, 79, 3),
(683, 0, 0, 0, 'Botham I c', 1700, 8, 0, 0, 0, 0, 46, 2),
(684, 0, 0, 0, 'Botham I d', 3050, 8, 0, 0, 0, 0, 77, 3),
(685, 0, 0, 0, 'Botham I e', 1650, 8, 0, 0, 0, 0, 42, 2),
(686, 0, 0, 0, 'Botham II a', 850, 8, 0, 0, 0, 0, 24, 1),
(687, 0, 0, 0, 'Botham II b', 1600, 8, 0, 0, 0, 0, 44, 2),
(688, 0, 0, 0, 'Botham II c', 1250, 8, 0, 0, 0, 0, 35, 2),
(689, 0, 0, 0, 'Botham II d', 1950, 8, 0, 0, 0, 0, 48, 2),
(690, 0, 0, 0, 'Botham II e', 1650, 8, 0, 0, 0, 0, 41, 2),
(691, 0, 0, 0, 'Botham II f', 1650, 8, 0, 0, 0, 0, 42, 2),
(692, 0, 0, 0, 'Botham II g', 1400, 8, 0, 0, 0, 0, 36, 2),
(693, 0, 0, 0, 'Botham III a', 1400, 8, 0, 0, 0, 0, 35, 2),
(694, 0, 0, 0, 'Botham III b', 950, 8, 0, 0, 0, 0, 24, 2),
(695, 0, 0, 0, 'Botham III c', 850, 8, 0, 0, 0, 0, 25, 1),
(696, 0, 0, 0, 'Botham III d', 850, 8, 0, 0, 0, 0, 25, 1),
(697, 0, 0, 0, 'Botham III e', 850, 8, 0, 0, 0, 0, 25, 1),
(698, 0, 0, 0, 'Botham III f', 2350, 8, 0, 0, 0, 0, 55, 3),
(699, 0, 0, 0, 'Botham III g', 1650, 8, 0, 0, 0, 0, 41, 2),
(700, 0, 0, 0, 'Botham III h', 3750, 8, 0, 0, 0, 0, 95, 3),
(701, 0, 0, 0, 'Botham IV a', 1400, 8, 0, 0, 0, 0, 35, 2),
(702, 0, 0, 0, 'Botham IV b', 850, 8, 0, 0, 0, 0, 24, 1),
(703, 0, 0, 0, 'Botham IV c', 850, 8, 0, 0, 0, 0, 25, 1),
(704, 0, 0, 0, 'Botham IV d', 850, 8, 0, 0, 0, 0, 25, 1),
(705, 0, 0, 0, 'Botham IV e', 850, 8, 0, 0, 0, 0, 25, 1),
(706, 0, 0, 0, 'Botham IV f', 1700, 8, 0, 0, 0, 0, 47, 2),
(707, 0, 0, 0, 'Botham IV g', 1650, 8, 0, 0, 0, 0, 46, 2),
(708, 0, 0, 0, 'Botham IV h', 1850, 8, 0, 0, 0, 0, 48, 1),
(709, 0, 0, 0, 'Botham IV i', 1800, 8, 0, 0, 0, 0, 48, 3),
(710, 0, 0, 0, 'Ramen Tah', 7650, 8, 0, 0, 0, 0, 176, 16),
(711, 0, 0, 0, 'Charsirakh I a', 280, 8, 0, 0, 0, 0, 12, 1),
(712, 0, 0, 0, 'Charsirakh I b', 1580, 8, 0, 0, 0, 0, 49, 2),
(713, 0, 0, 0, 'Charsirakh II', 1140, 8, 0, 0, 0, 0, 36, 2),
(714, 0, 0, 0, 'Charsirakh III', 680, 8, 0, 0, 0, 0, 25, 1),
(715, 0, 0, 0, 'Othehothep I a', 280, 8, 0, 0, 0, 0, 12, 1),
(716, 0, 0, 0, 'Othehothep I b', 1380, 8, 0, 0, 0, 0, 47, 2),
(717, 0, 0, 0, 'Othehothep I c', 1720, 8, 0, 0, 0, 0, 54, 3),
(718, 0, 0, 0, 'Othehothep I d', 2020, 8, 0, 0, 0, 0, 64, 4),
(719, 0, 0, 0, 'Othehothep II a', 400, 8, 0, 0, 0, 0, 16, 1),
(720, 0, 0, 0, 'Othehothep II b', 1920, 8, 0, 0, 0, 0, 62, 3),
(721, 0, 0, 0, 'Othehothep II c', 840, 8, 0, 0, 0, 0, 29, 1),
(722, 0, 0, 0, 'Othehothep II d', 840, 8, 0, 0, 0, 0, 30, 1),
(723, 0, 0, 0, 'Othehothep II e', 1340, 8, 0, 0, 0, 0, 42, 2),
(724, 0, 0, 0, 'Othehothep II f', 1340, 8, 0, 0, 0, 0, 42, 2),
(725, 0, 0, 0, 'Othehothep III a', 280, 8, 0, 0, 0, 0, 12, 1),
(726, 0, 0, 0, 'Othehothep III b', 1340, 8, 0, 0, 0, 0, 46, 2),
(727, 0, 0, 0, 'Othehothep III c', 940, 8, 0, 0, 0, 0, 29, 2),
(728, 0, 0, 0, 'Othehothep III d', 1040, 8, 0, 0, 0, 0, 35, 1),
(729, 0, 0, 0, 'Othehothep III e', 840, 8, 0, 0, 0, 0, 30, 1),
(730, 0, 0, 0, 'Othehothep III f', 680, 8, 0, 0, 0, 0, 25, 1),
(731, 0, 0, 0, 'Harrah I', 5740, 8, 0, 0, 0, 0, 176, 10),
(732, 0, 0, 0, 'Murkhol I a', 440, 8, 0, 0, 0, 0, 18, 1),
(733, 0, 0, 0, 'Murkhol I b', 440, 8, 0, 0, 0, 0, 17, 1),
(734, 0, 0, 0, 'Murkhol I c', 440, 8, 0, 0, 0, 0, 17, 1),
(735, 0, 0, 0, 'Murkhol I d', 440, 8, 0, 0, 0, 0, 18, 1),
(736, 0, 0, 0, 'Oskahl I a', 1580, 8, 0, 0, 0, 0, 49, 2),
(737, 0, 0, 0, 'Oskahl I b', 840, 8, 0, 0, 0, 0, 29, 1),
(738, 0, 0, 0, 'Oskahl I c', 680, 8, 0, 0, 0, 0, 25, 1),
(739, 0, 0, 0, 'Oskahl I d', 1140, 8, 0, 0, 0, 0, 35, 2),
(740, 0, 0, 0, 'Oskahl I e', 840, 8, 0, 0, 0, 0, 30, 1),
(741, 0, 0, 0, 'Oskahl I f', 840, 8, 0, 0, 0, 0, 30, 1),
(742, 0, 0, 0, 'Oskahl I g', 1140, 8, 0, 0, 0, 0, 36, 2),
(743, 0, 0, 0, 'Oskahl I h', 1760, 8, 0, 0, 0, 0, 58, 3),
(744, 0, 0, 0, 'Oskahl I i', 840, 8, 0, 0, 0, 0, 29, 1),
(745, 0, 0, 0, 'Oskahl I j', 680, 8, 0, 0, 0, 0, 24, 1),
(746, 0, 0, 0, 'Mothrem I', 1140, 8, 0, 0, 0, 0, 36, 2),
(747, 0, 0, 0, 'Arakmehn I', 1320, 8, 0, 0, 0, 0, 39, 3),
(748, 0, 0, 0, 'Arakmehn II', 1040, 8, 0, 0, 0, 0, 36, 1),
(749, 0, 0, 0, 'Arakmehn III', 1140, 8, 0, 0, 0, 0, 36, 2),
(750, 0, 0, 0, 'Arakmehn IV', 1220, 8, 0, 0, 0, 0, 39, 2),
(751, 0, 0, 0, 'Unklath I a', 1140, 8, 0, 0, 0, 0, 36, 2),
(752, 0, 0, 0, 'Unklath I b', 1460, 8, 0, 0, 0, 0, 48, 2),
(753, 0, 0, 0, 'Unklath I c', 1460, 8, 0, 0, 0, 0, 48, 2),
(754, 0, 0, 0, 'Unklath I d', 1680, 8, 0, 0, 0, 0, 48, 3),
(755, 0, 0, 0, 'Unklath I e', 1580, 8, 0, 0, 0, 0, 49, 2),
(756, 0, 0, 0, 'Unklath I f', 1580, 8, 0, 0, 0, 0, 49, 2),
(757, 0, 0, 0, 'Unklath I g', 1480, 8, 0, 0, 0, 0, 49, 1),
(758, 0, 0, 0, 'Unklath II a', 1040, 8, 0, 0, 0, 0, 35, 1),
(759, 0, 0, 0, 'Unklath II b', 680, 8, 0, 0, 0, 0, 24, 1),
(760, 0, 0, 0, 'Unklath II c', 680, 8, 0, 0, 0, 0, 25, 1),
(761, 0, 0, 0, 'Unklath II d', 1580, 8, 0, 0, 0, 0, 50, 2),
(762, 0, 0, 0, 'Rathal I a', 1140, 8, 0, 0, 0, 0, 35, 2),
(763, 0, 0, 0, 'Rathal I b', 680, 8, 0, 0, 0, 0, 24, 1),
(764, 0, 0, 0, 'Rathal I c', 680, 8, 0, 0, 0, 0, 25, 1),
(765, 0, 0, 0, 'Rathal I d', 780, 8, 0, 0, 0, 0, 25, 2),
(766, 0, 0, 0, 'Rathal I e', 780, 8, 0, 0, 0, 0, 25, 2),
(767, 0, 0, 0, 'Rathal II a', 1040, 8, 0, 0, 0, 0, 36, 1),
(768, 0, 0, 0, 'Rathal II b', 680, 8, 0, 0, 0, 0, 24, 1),
(769, 0, 0, 0, 'Rathal II c', 680, 8, 0, 0, 0, 0, 25, 1),
(770, 0, 0, 0, 'Rathal II d', 1460, 8, 0, 0, 0, 0, 49, 2),
(771, 0, 0, 0, 'Uthemath I a', 400, 8, 0, 0, 0, 0, 16, 1),
(772, 0, 0, 0, 'Uthemath I b', 800, 8, 0, 0, 0, 0, 30, 1),
(773, 0, 0, 0, 'Uthemath I c', 900, 8, 0, 0, 0, 0, 31, 2),
(774, 0, 0, 0, 'Uthemath I d', 840, 8, 0, 0, 0, 0, 29, 1),
(775, 0, 0, 0, 'Uthemath I e', 940, 8, 0, 0, 0, 0, 30, 2),
(776, 0, 0, 0, 'Uthemath I f', 2440, 8, 0, 0, 0, 0, 81, 3),
(777, 0, 0, 0, 'Uthemath II', 4460, 8, 0, 0, 0, 0, 132, 8),
(778, 0, 0, 0, 'Esuph I', 680, 8, 0, 0, 0, 0, 24, 1),
(779, 0, 0, 0, 'Esuph II a', 280, 8, 0, 0, 0, 0, 12, 1),
(780, 0, 0, 0, 'Esuph II b', 1380, 8, 0, 0, 0, 0, 48, 2),
(781, 0, 0, 0, 'Esuph III a', 280, 8, 0, 0, 0, 0, 12, 1),
(782, 0, 0, 0, 'Esuph III b', 1340, 8, 0, 0, 0, 0, 46, 2),
(783, 0, 0, 0, 'Esuph IV a', 400, 8, 0, 0, 0, 0, 15, 1),
(784, 0, 0, 0, 'Esuph IV b', 400, 8, 0, 0, 0, 0, 15, 1),
(785, 0, 0, 0, 'Esuph IV c', 400, 8, 0, 0, 0, 0, 16, 1),
(786, 0, 0, 0, 'Esuph IV d', 800, 8, 0, 0, 0, 0, 31, 1),
(787, 0, 0, 0, 'Horakhal', 9420, 8, 0, 0, 0, 0, 269, 14),
(788, 0, 0, 0, 'Darashia 1, Flat 01', 1100, 6, 0, 0, 0, 0, 35, 2),
(789, 0, 0, 0, 'Darashia 1, Flat 02', 1000, 6, 0, 0, 0, 0, 35, 1),
(790, 0, 0, 0, 'Darashia 1, Flat 03', 2660, 6, 0, 0, 0, 0, 83, 4),
(791, 0, 0, 0, 'Darashia 1, Flat 04', 1000, 6, 0, 0, 0, 0, 34, 1),
(792, 0, 0, 0, 'Darashia 1, Flat 05', 1100, 6, 0, 0, 0, 0, 34, 2),
(793, 0, 0, 0, 'Darashia 1, Flat 11', 1100, 6, 0, 0, 0, 0, 35, 2),
(794, 0, 0, 0, 'Darashia 1, Flat 12', 1780, 6, 0, 0, 0, 0, 59, 2),
(795, 0, 0, 0, 'Darashia 1, Flat 13', 1780, 6, 0, 0, 0, 0, 58, 2),
(796, 0, 0, 0, 'Darashia 1, Flat 14', 2760, 6, 0, 0, 0, 0, 82, 5),
(797, 0, 0, 0, 'Darashia 2, Flat 01', 1000, 6, 0, 0, 0, 0, 35, 1),
(798, 0, 0, 0, 'Darashia 2, Flat 02', 1000, 6, 0, 0, 0, 0, 35, 1);
INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `beds`) VALUES
(799, 0, 0, 0, 'Darashia 2, Flat 03', 1160, 6, 0, 0, 0, 0, 40, 1),
(800, 0, 0, 0, 'Darashia 2, Flat 04', 520, 6, 0, 0, 0, 0, 20, 1),
(801, 0, 0, 0, 'Darashia 2, Flat 05', 1260, 6, 0, 0, 0, 0, 39, 2),
(802, 0, 0, 0, 'Darashia 2, Flat 06', 520, 6, 0, 0, 0, 0, 19, 1),
(803, 0, 0, 0, 'Darashia 2, Flat 07', 1000, 6, 0, 0, 0, 0, 34, 1),
(804, 0, 0, 0, 'Darashia 2, Flat 11', 1000, 6, 0, 0, 0, 0, 34, 1),
(805, 0, 0, 0, 'Darashia 2, Flat 12', 520, 6, 0, 0, 0, 0, 20, 1),
(806, 0, 0, 0, 'Darashia 2, Flat 13', 1160, 6, 0, 0, 0, 0, 40, 1),
(807, 0, 0, 0, 'Darashia 2, Flat 14', 520, 6, 0, 0, 0, 0, 20, 1),
(808, 0, 0, 0, 'Darashia 2, Flat 15', 1260, 6, 0, 0, 0, 0, 40, 2),
(809, 0, 0, 0, 'Darashia 2, Flat 16', 680, 6, 0, 0, 0, 0, 24, 1),
(810, 0, 0, 0, 'Darashia 2, Flat 17', 1000, 6, 0, 0, 0, 0, 34, 1),
(811, 0, 0, 0, 'Darashia 2, Flat 18', 680, 6, 0, 0, 0, 0, 24, 1),
(812, 0, 0, 0, 'Darashia 3, Flat 01', 1100, 6, 0, 0, 0, 0, 35, 2),
(813, 0, 0, 0, 'Darashia 3, Flat 02', 1620, 6, 0, 0, 0, 0, 54, 2),
(814, 0, 0, 0, 'Darashia 3, Flat 03', 1100, 6, 0, 0, 0, 0, 34, 2),
(815, 0, 0, 0, 'Darashia 3, Flat 04', 1620, 6, 0, 0, 0, 0, 53, 2),
(816, 0, 0, 0, 'Darashia 3, Flat 05', 1000, 6, 0, 0, 0, 0, 34, 1),
(817, 0, 0, 0, 'Darashia 3, Flat 11', 1000, 6, 0, 0, 0, 0, 35, 1),
(818, 0, 0, 0, 'Darashia 3, Flat 12', 2600, 6, 0, 0, 0, 0, 78, 5),
(819, 0, 0, 0, 'Darashia 3, Flat 13', 1100, 6, 0, 0, 0, 0, 34, 2),
(820, 0, 0, 0, 'Darashia 3, Flat 14', 2400, 6, 0, 0, 0, 0, 77, 3),
(821, 0, 0, 0, 'Darashia 4, Flat 01', 1000, 6, 0, 0, 0, 0, 35, 1),
(822, 0, 0, 0, 'Darashia 4, Flat 02', 1780, 6, 0, 0, 0, 0, 59, 2),
(823, 0, 0, 0, 'Darashia 4, Flat 03', 1000, 6, 0, 0, 0, 0, 35, 1),
(824, 0, 0, 0, 'Darashia 4, Flat 04', 1780, 6, 0, 0, 0, 0, 58, 2),
(825, 0, 0, 0, 'Darashia 4, Flat 05', 1100, 6, 0, 0, 0, 0, 34, 2),
(826, 0, 0, 0, 'Darashia 4, Flat 11', 1000, 6, 0, 0, 0, 0, 35, 1),
(827, 0, 0, 0, 'Darashia 4, Flat 12', 2560, 6, 0, 0, 0, 0, 83, 3),
(828, 0, 0, 0, 'Darashia 4, Flat 13', 1780, 6, 0, 0, 0, 0, 58, 2),
(829, 0, 0, 0, 'Darashia 4, Flat 14', 1780, 6, 0, 0, 0, 0, 58, 2),
(830, 0, 0, 0, 'Darashia 5, Flat 01', 1000, 6, 0, 0, 0, 0, 35, 1),
(831, 0, 0, 0, 'Darashia 5, Flat 02', 1620, 6, 0, 0, 0, 0, 54, 2),
(832, 0, 0, 0, 'Darashia 5, Flat 03', 1000, 6, 0, 0, 0, 0, 35, 1),
(833, 0, 0, 0, 'Darashia 5, Flat 04', 1620, 6, 0, 0, 0, 0, 53, 2),
(834, 0, 0, 0, 'Darashia 5, Flat 05', 1000, 6, 0, 0, 0, 0, 34, 1),
(835, 0, 0, 0, 'Darashia 5, Flat 11', 1780, 6, 0, 0, 0, 0, 59, 2),
(836, 0, 0, 0, 'Darashia 5, Flat 12', 1620, 6, 0, 0, 0, 0, 54, 2),
(837, 0, 0, 0, 'Darashia 5, Flat 13', 1780, 6, 0, 0, 0, 0, 58, 2),
(838, 0, 0, 0, 'Darashia 5, Flat 14', 1620, 6, 0, 0, 0, 0, 53, 2),
(839, 0, 0, 0, 'Darashia 6a', 3115, 6, 0, 0, 0, 0, 97, 2),
(840, 0, 0, 0, 'Darashia 6b', 3430, 6, 0, 0, 0, 0, 102, 2),
(841, 0, 0, 0, 'Darashia 7, Flat 01', 1125, 6, 0, 0, 0, 0, 35, 1),
(842, 0, 0, 0, 'Darashia 7, Flat 02', 1125, 6, 0, 0, 0, 0, 35, 1),
(843, 0, 0, 0, 'Darashia 7, Flat 03', 2955, 6, 0, 0, 0, 0, 82, 4),
(844, 0, 0, 0, 'Darashia 7, Flat 04', 1125, 6, 0, 0, 0, 0, 34, 1),
(845, 0, 0, 0, 'Darashia 7, Flat 05', 1225, 6, 0, 0, 0, 0, 34, 2),
(846, 0, 0, 0, 'Darashia 7, Flat 11', 1125, 6, 0, 0, 0, 0, 35, 1),
(847, 0, 0, 0, 'Darashia 7, Flat 12', 2955, 6, 0, 0, 0, 0, 83, 4),
(848, 0, 0, 0, 'Darashia 7, Flat 13', 1125, 6, 0, 0, 0, 0, 34, 1),
(849, 0, 0, 0, 'Darashia 7, Flat 14', 2955, 6, 0, 0, 0, 0, 82, 4),
(850, 0, 0, 0, 'Darashia 8, Flat 01', 2485, 6, 0, 0, 0, 0, 74, 2),
(851, 0, 0, 0, 'Darashia 8, Flat 02', 3385, 6, 0, 0, 0, 0, 101, 2),
(852, 0, 0, 0, 'Darashia 8, Flat 03', 4700, 6, 0, 0, 0, 0, 139, 3),
(853, 0, 0, 0, 'Darashia 8, Flat 04', 2845, 6, 0, 0, 0, 0, 82, 2),
(854, 0, 0, 0, 'Darashia 8, Flat 05', 2665, 6, 0, 0, 0, 0, 78, 2),
(855, 0, 0, 0, 'Darashia, Villa', 5385, 6, 0, 0, 0, 0, 171, 4),
(856, 0, 0, 0, 'Darashia, Western Guildhall', 10435, 6, 0, 0, 0, 0, 298, 14),
(857, 0, 0, 0, 'Darashia, Eastern Guildhall', 12660, 6, 0, 0, 0, 0, 359, 16),
(858, 0, 0, 0, 'Darashia 8, Flat 11', 1990, 6, 0, 0, 0, 0, 59, 2),
(859, 0, 0, 0, 'Darashia 8, Flat 12', 1810, 6, 0, 0, 0, 0, 54, 2),
(860, 0, 0, 0, 'Darashia 8, Flat 13', 1990, 6, 0, 0, 0, 0, 58, 2),
(861, 0, 0, 0, 'Darashia 8, Flat 14', 1810, 6, 0, 0, 0, 0, 53, 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `house_lists`
--

CREATE TABLE `house_lists` (
  `house_id` int NOT NULL,
  `listid` int NOT NULL,
  `list` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ip_bans`
--

CREATE TABLE `ip_bans` (
  `ip` int UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint NOT NULL,
  `expires_at` bigint NOT NULL,
  `banned_by` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `kill_statistics`
--

CREATE TABLE `kill_statistics` (
  `name` varchar(35) NOT NULL,
  `killed_by` smallint UNSIGNED NOT NULL,
  `killed` smallint UNSIGNED NOT NULL,
  `time` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `kill_statistics`
--

INSERT INTO `kill_statistics` (`name`, `killed_by`, `killed`, `time`) VALUES
('Slime', 0, 3, 1693506194),
('Dummy Target', 0, 1, 1693506194),
('Crystal Spider', 0, 5, 1693506194),
('Dwarf', 0, 13, 1693506194),
('Rotworm', 0, 6, 1693506194),
('Dwarf Soldier', 0, 14, 1693506194),
('Bear', 0, 1, 1693506194),
('Wolf', 0, 5, 1693506194),
('Beholder', 0, 8, 1693506194),
('Rat', 0, 21, 1693506194),
('Scorpion', 0, 3, 1693506194),
('Minotaur Archer', 0, 16, 1693506194),
('Frost Dragon', 3, 2, 1693506194),
('Barbarian Headsplitter', 0, 40, 1693506194),
('Sheep', 0, 1, 1693506194),
('Polar Bear', 0, 16, 1693506194),
('Orc Leader', 0, 2, 1693506194),
('Orc Berserker', 0, 3, 1693506194),
('Orc Shaman', 0, 2, 1693506194),
('Snake', 0, 1, 1693506194),
('Barbarian Brutetamer', 0, 6, 1693506194),
('Giant Spider', 0, 3, 1693506194),
('Barbarian Bloodwalker', 0, 26, 1693506194),
('Amazon', 0, 4, 1693506194),
('Valkyrie', 0, 3, 1693506194),
('Barbarian Skullhunter', 0, 64, 1693506194),
('Hero', 0, 14, 1693506194),
('Demon', 0, 19, 1693506194),
('Dragon', 0, 13, 1693506194),
('Dragon Lord', 0, 2, 1693506194),
('Dog', 0, 1, 1693506194),
('Dwarf Guard', 0, 12, 1693506194),
('Winter Wolf', 0, 38, 1693506194),
('Hunter', 0, 17, 1693506194),
('Orc Spearman', 0, 4, 1693506194),
('Skeleton', 0, 6, 1693506194),
('Deer', 0, 1, 1693506194),
('Bug', 0, 1, 1693506194),
('Bug', 0, 1, 1693627514),
('Rat', 0, 5, 1693627514),
('Rabbit', 0, 1, 1693627514);

-- --------------------------------------------------------

--
-- Estrutura para tabela `medivia coins`
--

CREATE TABLE `medivia coins` (
  `id` int NOT NULL,
  `servidor` text NOT NULL,
  `char_name` text NOT NULL,
  `flags` text NOT NULL,
  `city` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `medivia coins`
--

INSERT INTO `medivia coins` (`id`, `servidor`, `char_name`, `flags`, `city`) VALUES
(1, 'Legacy', 'Rafaaw', 'fr', 'Arak'),
(2, 'Purity', 'Rafaaw', 'fr', 'Arak'),
(3, 'Progeny', 'Rafaaw', 'fr', 'Arak'),
(4, 'Destiny', 'Rafaaw', 'ca', 'Arak'),
(5, 'Pendulum', 'Rafaaw', 'ca', 'Arak'),
(6, 'Odyssey', 'Rafaaw', 'ca', 'Arak'),
(7, 'Eternum', 'Rafaaw', 'us', 'Arak');

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_account_actions`
--

CREATE TABLE `myaac_account_actions` (
  `account_id` int NOT NULL,
  `ip` int UNSIGNED NOT NULL DEFAULT '0',
  `ipv6` binary(16) NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `date` int NOT NULL DEFAULT '0',
  `action` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_account_actions`
--

INSERT INTO `myaac_account_actions` (`account_id`, `ip`, `ipv6`, `date`, `action`) VALUES
(4022023, 0, 0x00000000000000000000000000000001, 1675523240, 'Account created.'),
(199361, 0, 0x00000000000000000000000000000000, 1675563518, 'Account created.'),
(199361, 0, 0x00000000000000000000000000000000, 1675563519, 'Created character <b>Luanzera</b>.'),
(121234, 0, 0x00000000000000000000000000000000, 1676241588, 'Account created.'),
(121234, 0, 0x00000000000000000000000000000000, 1676304848, 'Created character <b>Teste</b>.'),
(199361, 0, 0x00000000000000000000000000000000, 1676496962, 'Created character <b>Luan Paladin</b>.'),
(145145, 623863918, 0x00000000000000000000000000000000, 1677197997, 'Account created.'),
(145145, 623863918, 0x00000000000000000000000000000000, 1677197997, 'Created character <b>Marios</b>.'),
(155155, 623863918, 0x00000000000000000000000000000000, 1677198024, 'Account created.'),
(155155, 623863918, 0x00000000000000000000000000000000, 1677198025, 'Created character <b>Marioska</b>.'),
(199361, 0, 0x00000000000000000000000000000000, 1677205059, 'Generated recovery key.'),
(1234567, 0, 0x28040828c2308242e527129bd2bd67d5, 1680813793, 'Created character <b>Kina Teste</b>.'),
(1234567, 0, 0x28040828c2308242e527129bd2bd67d5, 1680813857, 'Created character <b>Knight Tank Test</b>.'),
(1234567, 0, 0x28040828c2308242e527129bd2bd67d5, 1680823217, 'Created character <b>Magez</b>.'),
(199361, 0, 0x28040828c2308242d077c8d172e05b72, 1681528065, 'Created character <b>Luan Teste</b>.'),
(4022023, 0, 0x00000000000000000000000000000001, 1693343207, 'Account created.'),
(199361, 0, 0x28040828c2314082705042ae8083340e, 1693527007, 'Account created.'),
(199361, 0, 0x28040828c2314082705042ae8083340e, 1693527008, 'Created character <b>Luanzera</b>.'),
(121234, 2867305211, 0x00000000000000000000000000000000, 1693527018, 'Account created.'),
(121234, 2867305211, 0x00000000000000000000000000000000, 1693527018, 'Created character <b>Guizao</b>.'),
(121234, 2867305211, 0x00000000000000000000000000000000, 1693527295, 'Created character <b>Guii</b>.'),
(199361, 0, 0x28040828c2314082705042ae8083340e, 1693527313, 'Created character <b>Luanzera Tester</b>.'),
(121234, 2867305211, 0x00000000000000000000000000000000, 1693527322, 'Created character <b>Gui Teste</b>.'),
(121234, 2867305211, 0x00000000000000000000000000000000, 1693527335, 'Created character <b>Guiizao</b>.'),
(199361, 0, 0x28040828c2314082705042ae8083340e, 1693527365, 'Created character <b>Luanzera Kina</b>.'),
(199361, 0, 0x28040828c2314082705042ae8083340e, 1693527377, 'Created character <b>Luanzera Mage</b>.'),
(199361, 0, 0x28040828c2314082705042ae8083340e, 1693527389, 'Created character <b>Luanzera Female</b>.');

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_admin_menu`
--

CREATE TABLE `myaac_admin_menu` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `page` varchar(255) NOT NULL DEFAULT '',
  `ordering` int NOT NULL DEFAULT '0',
  `flags` int NOT NULL DEFAULT '0',
  `enabled` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_admin_menu`
--

INSERT INTO `myaac_admin_menu` (`id`, `name`, `page`, `ordering`, `flags`, `enabled`) VALUES
(1, 'Gifts', 'gifts', 0, 0, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_bugtracker`
--

CREATE TABLE `myaac_bugtracker` (
  `account` varchar(255) NOT NULL,
  `type` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `id` int NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `reply` int NOT NULL DEFAULT '0',
  `who` int NOT NULL DEFAULT '0',
  `uid` int NOT NULL,
  `tag` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_changelog`
--

CREATE TABLE `myaac_changelog` (
  `id` int NOT NULL,
  `body` varchar(500) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - added, 2 - removed, 3 - changed, 4 - fixed',
  `where` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - server, 2 - site',
  `date` int NOT NULL DEFAULT '0',
  `player_id` int NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_changelog`
--

INSERT INTO `myaac_changelog` (`id`, `body`, `type`, `where`, `date`, `player_id`, `hidden`) VALUES
(1, 'MyAAC installed. (:', 3, 2, 1675523187, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_config`
--

CREATE TABLE `myaac_config` (
  `id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_config`
--

INSERT INTO `myaac_config` (`id`, `name`, `value`) VALUES
(1, 'database_version', '33'),
(2, 'status_online', '1'),
(3, 'status_players', '0'),
(4, 'status_playersMax', '0'),
(5, 'status_lastCheck', '1693661452'),
(6, 'status_uptime', '12247'),
(7, 'status_monsters', '21082'),
(8, 'status_uptimeReadable', '3h 24m'),
(9, 'status_motd', 'Welcome to\nRetronia Online! 2.0'),
(10, 'status_mapAuthor', 'Ezzz & CipSoft'),
(11, 'status_mapName', 'map'),
(12, 'status_mapWidth', '65000'),
(13, 'status_mapHeight', '65000'),
(14, 'status_server', 'The Violet Project'),
(15, 'status_serverVersion', '3.1 Beta'),
(16, 'status_clientVersion', '7.72'),
(17, 'last_usage_report', '1691774928'),
(18, 'views_counter', '48850');

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_faq`
--

CREATE TABLE `myaac_faq` (
  `id` int NOT NULL,
  `question` varchar(255) NOT NULL DEFAULT '',
  `answer` varchar(1020) NOT NULL DEFAULT '',
  `ordering` int NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_forum`
--

CREATE TABLE `myaac_forum` (
  `id` int NOT NULL,
  `first_post` int NOT NULL DEFAULT '0',
  `last_post` int NOT NULL DEFAULT '0',
  `section` int NOT NULL DEFAULT '0',
  `replies` int NOT NULL DEFAULT '0',
  `views` int NOT NULL DEFAULT '0',
  `author_aid` int NOT NULL DEFAULT '0',
  `author_guid` int NOT NULL DEFAULT '0',
  `post_text` text NOT NULL,
  `post_topic` varchar(255) NOT NULL DEFAULT '',
  `post_smile` tinyint(1) NOT NULL DEFAULT '0',
  `post_html` tinyint(1) NOT NULL DEFAULT '0',
  `post_date` int NOT NULL DEFAULT '0',
  `last_edit_aid` int NOT NULL DEFAULT '0',
  `edit_date` int NOT NULL DEFAULT '0',
  `post_ip` varchar(32) NOT NULL DEFAULT '0.0.0.0',
  `sticked` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_forum_boards`
--

CREATE TABLE `myaac_forum_boards` (
  `id` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `ordering` int NOT NULL DEFAULT '0',
  `guild` int NOT NULL DEFAULT '0',
  `access` int NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_forum_boards`
--

INSERT INTO `myaac_forum_boards` (`id`, `name`, `description`, `ordering`, `guild`, `access`, `closed`, `hidden`) VALUES
(1, 'News', 'News commenting', 0, 0, 0, 1, 0),
(2, 'Trade', 'Trade offers.', 1, 0, 0, 0, 0),
(3, 'Quests', 'Quest making.', 2, 0, 0, 0, 0),
(4, 'Pictures', 'Your pictures.', 3, 0, 0, 0, 0),
(5, 'Bug Report', 'Report bugs there.', 4, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_gallery`
--

CREATE TABLE `myaac_gallery` (
  `id` int NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `image` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `author` varchar(50) NOT NULL DEFAULT '',
  `ordering` int NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_gallery`
--

INSERT INTO `myaac_gallery` (`id`, `comment`, `image`, `thumb`, `author`, `ordering`, `hidden`) VALUES
(1, 'Demon', 'images/gallery/demon.jpg', 'images/gallery/demon_thumb.gif', 'MyAAC', 1, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_menu`
--

CREATE TABLE `myaac_menu` (
  `id` int NOT NULL,
  `template` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `blank` tinyint(1) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '',
  `category` int NOT NULL DEFAULT '1',
  `ordering` int NOT NULL DEFAULT '0',
  `enabled` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_menu`
--

INSERT INTO `myaac_menu` (`id`, `template`, `name`, `link`, `blank`, `color`, `category`, `ordering`, `enabled`) VALUES
(1, 'kathrine', 'Latest News', 'news', 0, '', 1, 0, 1),
(2, 'kathrine', 'News Archive', 'news/archive', 0, '', 1, 1, 1),
(3, 'kathrine', 'Changelog', 'changelog', 0, '', 1, 2, 1),
(4, 'kathrine', 'Account Management', 'account/manage', 0, '', 2, 0, 1),
(5, 'kathrine', 'Create Account', 'account/create', 0, '', 2, 1, 1),
(6, 'kathrine', 'Lost Account?', 'account/lost', 0, '', 2, 2, 1),
(7, 'kathrine', 'Server Rules', 'rules', 0, '', 2, 3, 1),
(8, 'kathrine', 'Downloads', 'downloads', 0, '', 5, 4, 1),
(9, 'kathrine', 'Report Bug', 'bugtracker', 0, '', 2, 5, 1),
(10, 'kathrine', 'Who is Online?', 'online', 0, '', 3, 0, 1),
(11, 'kathrine', 'Characters', 'characters', 0, '', 3, 1, 1),
(12, 'kathrine', 'Guilds', 'guilds', 0, '', 3, 2, 1),
(13, 'kathrine', 'Highscores', 'highscores', 0, '', 3, 3, 1),
(14, 'kathrine', 'Last Deaths', 'lastkills', 0, '', 3, 4, 1),
(15, 'kathrine', 'Houses', 'houses', 0, '', 3, 5, 1),
(16, 'kathrine', 'Bans', 'bans', 0, '', 3, 6, 1),
(17, 'kathrine', 'Forum', 'forum', 0, '', 3, 7, 1),
(18, 'kathrine', 'Team', 'team', 0, '', 3, 8, 1),
(19, 'kathrine', 'Monsters', 'creatures', 0, '', 5, 0, 1),
(20, 'kathrine', 'Spells', 'spells', 0, '', 5, 1, 1),
(21, 'kathrine', 'Server Info', 'serverInfo', 0, '', 5, 2, 1),
(22, 'kathrine', 'Commands', 'commands', 0, '', 5, 3, 1),
(23, 'kathrine', 'Gallery', 'gallery', 0, '', 5, 4, 1),
(24, 'kathrine', 'Experience Table', 'experienceTable', 0, '', 5, 5, 1),
(25, 'kathrine', 'FAQ', 'faq', 0, '', 5, 6, 1),
(26, 'kathrine', 'Buy Points', 'points', 0, '', 6, 0, 1),
(27, 'kathrine', 'Shop Offer', 'gifts', 0, '', 6, 1, 1),
(28, 'kathrine', 'Shop History', 'gifts/history', 0, '', 6, 2, 1),
(207, 'tibiacom', 'Latest News', 'news', 0, '', 1, 0, 1),
(208, 'tibiacom', 'News Archive', 'news/archive', 0, '', 1, 1, 1),
(209, 'tibiacom', 'Changelog', 'changelog', 0, '', 1, 2, 1),
(210, 'tibiacom', 'Account Management', 'account/manage', 0, '', 2, 0, 1),
(211, 'tibiacom', 'Create Account', 'account/create', 0, '', 2, 1, 1),
(212, 'tibiacom', 'Lost Account?', 'account/lost', 0, '', 2, 2, 1),
(213, 'tibiacom', 'Server Rules', 'rules', 0, '', 2, 3, 1),
(214, 'tibiacom', 'Downloads', 'downloads', 0, '', 2, 4, 1),
(215, 'tibiacom', 'Report Bug', 'bugtracker', 0, '', 2, 5, 1),
(216, 'tibiacom', 'Characters', 'characters', 0, '', 3, 0, 1),
(217, 'tibiacom', 'Who Is Online?', 'online', 0, '', 3, 1, 1),
(218, 'tibiacom', 'Highscores', 'highscores', 0, '', 3, 2, 1),
(219, 'tibiacom', 'Last Kills', 'lastkills', 0, '', 3, 3, 1),
(220, 'tibiacom', 'Houses', 'houses', 0, '', 3, 4, 1),
(221, 'tibiacom', 'Guilds', 'guilds', 0, '', 3, 5, 1),
(222, 'tibiacom', 'Polls', 'polls', 0, '', 3, 6, 1),
(223, 'tibiacom', 'Bans', 'bans', 0, '', 3, 7, 1),
(224, 'tibiacom', 'Support List', 'team', 0, '', 3, 8, 1),
(225, 'tibiacom', 'Forum', 'forum', 0, '', 4, 0, 1),
(226, 'tibiacom', 'Creatures', 'creatures', 0, '', 5, 0, 1),
(227, 'tibiacom', 'Spells', 'spells', 0, '', 5, 1, 1),
(228, 'tibiacom', 'Commands', 'commands', 0, '', 5, 2, 1),
(229, 'tibiacom', 'Exp Stages', 'experienceStages', 0, '', 5, 3, 1),
(230, 'tibiacom', 'Gallery', 'gallery', 0, '', 5, 4, 1),
(231, 'tibiacom', 'Server Info', 'serverInfo', 0, '', 5, 5, 1),
(232, 'tibiacom', 'Experience Table', 'experienceTable', 0, '', 5, 6, 1),
(233, 'tibiacom', 'Buy Points', 'methods', 0, '', 6, 0, 1),
(234, 'tibiacom', 'Shop Offer', 'gifts', 0, '', 6, 1, 1),
(235, 'tibiacom', 'Shop History', 'gifts/history', 0, '', 6, 2, 1),
(236, 'old-school', 'Home', 'news', 0, '', 7, 0, 1),
(237, 'old-school', 'News Archive', 'news/archive', 0, '', 7, 1, 1),
(238, 'old-school', 'Changelog', 'changelog', 0, '', 7, 2, 1),
(239, 'old-school', 'Downloads', 'downloads', 0, '', 7, 3, 1),
(240, 'old-school', 'Rules', 'rules', 0, '', 7, 4, 1),
(241, 'old-school', 'FAQ', 'faq', 0, '', 7, 5, 1),
(242, 'old-school', 'Create Account', 'account/create', 0, '', 2, 0, 1),
(243, 'old-school', 'Lost Account Interface', 'account/lost', 0, '', 2, 1, 1),
(244, 'old-school', 'Forum', 'forum', 0, '', 2, 2, 1),
(245, 'old-school', 'Search Character', 'characters', 0, '', 3, 0, 1),
(246, 'old-school', 'Online', 'online', 0, '', 3, 1, 1),
(247, 'old-school', 'Highscores', 'highscores', 0, '', 3, 2, 1),
(248, 'old-school', 'Last Kills', 'lastkills', 0, '', 3, 3, 1),
(249, 'old-school', 'Houses', 'houses', 0, '', 3, 4, 1),
(250, 'old-school', 'Bug Tracker', 'bugtracker', 0, '', 3, 5, 1),
(251, 'old-school', 'Guilds', 'guilds', 0, '', 3, 6, 1),
(252, 'old-school', 'Bans', 'bans', 0, '', 3, 7, 1),
(253, 'old-school', 'Forum', 'forum', 0, '', 3, 8, 1),
(254, 'old-school', 'Team', 'team', 0, '', 3, 9, 1),
(255, 'old-school', 'Creatures', 'creatures', 0, '', 5, 0, 1),
(256, 'old-school', 'Spells', 'spells', 0, '', 5, 1, 1),
(257, 'old-school', 'Commands', 'commands', 0, '', 5, 2, 1),
(258, 'old-school', 'Server Info', 'serverInfo', 0, '', 5, 3, 1),
(259, 'old-school', 'Gallery', 'gallery', 0, '', 5, 4, 1),
(260, 'old-school', 'Experience Stages', 'experienceStages', 0, '', 5, 5, 1),
(261, 'old-school', 'Experience Table', 'experienceTable', 0, '', 5, 6, 1),
(262, 'old-school', 'Buy Points', 'points', 0, '', 6, 0, 1),
(263, 'old-school', 'Gifts', 'gifts', 0, '', 6, 1, 1),
(264, 'old-school', 'History', 'gifts/history', 0, '', 6, 2, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_monsters`
--

CREATE TABLE `myaac_monsters` (
  `id` int NOT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `mana` int NOT NULL DEFAULT '0',
  `exp` int NOT NULL,
  `health` int NOT NULL,
  `speed_lvl` int NOT NULL DEFAULT '1',
  `use_haste` tinyint(1) NOT NULL,
  `voices` text NOT NULL,
  `immunities` varchar(255) NOT NULL,
  `summonable` tinyint(1) NOT NULL,
  `convinceable` tinyint(1) NOT NULL,
  `race` varchar(255) NOT NULL,
  `loot` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_monsters`
--

INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(1, 0, 'amazon', 390, 60, 110, 1, 0, '[\"Yeee ha!\",\"Your head will be mine!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2691\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"40000\"},{\"id\":\"2229\",\"count\":\"2\",\"chance\":\"80000\"},{\"id\":\"2147\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2125\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2379\",\"count\":1,\"chance\":\"80000\"},{\"id\":\"2385\",\"count\":1,\"chance\":\"23000\"},{\"id\":\"2526\",\"count\":1,\"chance\":\"5000\"}]'),
(2, 0, 'ancient scarab', 0, 720, 1000, 1, 0, '[]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"44400\"},{\"id\":\"2148\",\"count\":\"66\",\"chance\":\"75700\"},{\"id\":\"2148\",\"count\":\"22\",\"chance\":\"99900\"},{\"id\":\"2150\",\"count\":\"4\",\"chance\":\"1200\"},{\"id\":\"2149\",\"count\":\"3\",\"chance\":\"600\"},{\"id\":\"2159\",\"count\":\"2\",\"chance\":\"5000\"},{\"id\":\"2159\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2135\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2142\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"10900\"},{\"id\":\"2440\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2540\",\"count\":1,\"chance\":\"500\"}]'),
(3, 0, 'assassin', 450, 105, 175, 2, 0, '[\"Die!\",\"Feel the hand of death!\",\"You are on my deathlist!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"15000\"},{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"80000\"},{\"id\":\"2145\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2457\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"3969\",\"count\":1,\"chance\":\"200\"},{\"id\":\"3968\",\"count\":1,\"chance\":\"500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2404\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"1000\"}]'),
(4, 0, 'badger', 200, 5, 23, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"40000\"}]'),
(5, 0, 'bandit', 450, 65, 245, 1, 0, '[\"Your money or your life!\",\"Hand me your purse!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"15000\"},{\"id\":\"2458\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2459\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2391\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2511\",\"count\":1,\"chance\":\"17000\"}]'),
(6, 0, 'banshee', 0, 900, 1000, 1, 0, '[\"Are you ready to rock?\",\"That\'s what I call easy listening!\",\"Let the music play!\",\"I will mourn your death!\",\"IIIIEEEeeeeeehhhHHHHH!\",\"Dance for me your dance of death!\",\"Feel my gentle kiss of death.\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"30000\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2121\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2071\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2560\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2134\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2657\",\"count\":1,\"chance\":\"60000\"},{\"id\":\"2237\",\"count\":1,\"chance\":\"19900\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"600\"},{\"id\":\"2655\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2047\",\"count\":1,\"chance\":\"70000\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2170\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"500\"}]'),
(7, 0, 'bat', 250, 10, 30, 1, 0, '[\"Flap! Flap!\"]', '[]', 1, 1, 'blood', '[]'),
(8, 0, 'bear', 300, 23, 80, 1, 0, '[\"Grrrr\",\"Groar\"]', '[]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2671\",\"count\":\"2\",\"chance\":\"40000\"},{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"70000\"}]'),
(9, 0, 'behemoth', 0, 2500, 4000, 60, 0, '[\"You\'re so little!\",\"Human flesh - delicious!\",\"Crush the intruders!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2666\",\"count\":\"6\",\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"60\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"50000\"},{\"id\":\"2150\",\"count\":\"2\",\"chance\":\"4000\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2553\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2023\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2125\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2489\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"400\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2416\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2174\",\"count\":1,\"chance\":\"800\"}]'),
(10, 0, 'beholder', 0, 170, 260, 1, 0, '[\"Eye for eye!\",\"Here\'s looking at you!\",\"Let me take a look at you!\",\"You\'ve got the look!\"]', '[\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"90000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"16\",\"chance\":\"80000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2394\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2181\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2512\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2518\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"5000\"}]'),
(11, 0, 'black knight', 0, 1600, 1800, 85, 0, '[\"By Bolg\'s Blood!\",\"You\'re no match for me!\",\"NO MERCY!\",\"NO PRISONERS!\",\"MINE!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2691\",\"count\":\"2\",\"chance\":\"20000\"},{\"id\":\"2148\",\"count\":\"60\",\"chance\":\"33300\"},{\"id\":\"2148\",\"count\":\"90\",\"chance\":\"22200\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2133\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"13000\"},{\"id\":\"2457\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2489\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2389\",\"count\":\"3\",\"chance\":\"30000\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"13000\"},{\"id\":\"2417\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2414\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2430\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"10000\"}]'),
(12, 0, 'black sheep', 250, 0, 20, 1, 0, '[\"Maeh\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"70000\"}]'),
(13, 0, 'blue djinn', 0, 190, 330, 1, 0, '[\"Simsalabim\",\"Feel the power of my magic, tiny mortal!\",\"Be careful what you wish for.\",\"Wishes can come true.\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2684\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"70000\"},{\"id\":\"2146\",\"count\":\"4\",\"chance\":\"2500\"},{\"id\":\"2063\",\"count\":1,\"chance\":\"7500\"},{\"id\":\"2745\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2663\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"1978\",\"count\":1,\"chance\":\"2500\"}]'),
(14, 0, 'bonebeast', 0, 580, 515, 1, 0, '[\"Cccchhhhhhhhh!\",\"Knooorrrrr!\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2796\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2148\",\"count\":\"90\",\"chance\":\"30000\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2449\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2541\",\"count\":1,\"chance\":\"2000\"}]'),
(15, 0, 'bug', 250, 18, 29, 1, 0, '[]', '[]', 1, 1, 'venom', '[{\"id\":\"2148\",\"count\":\"6\",\"chance\":\"35000\"},{\"id\":\"2679\",\"count\":\"3\",\"chance\":\"3000\"}]'),
(16, 0, 'butterfly', 0, 0, 2, 50, 0, '[]', '[]', 0, 0, 'venom', '[]'),
(17, 0, 'carniphila', 490, 150, 255, 1, 0, '[]', '[\"lifedrain\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2671\",\"count\":1,\"chance\":\"40000\"},{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"70000\"},{\"id\":\"2792\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"40000\"},{\"id\":\"2804\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"500\"}]'),
(18, 0, 'cave rat', 250, 10, 30, 1, 0, '[\"Meep!\",\"Meeeeep!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":\"3\",\"chance\":\"50000\"},{\"id\":\"2687\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2696\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2148\",\"count\":\"2\",\"chance\":\"85000\"}]'),
(19, 0, 'centipede', 335, 30, 70, 1, 0, '[]', '[]', 1, 1, 'venom', '[{\"id\":\"2148\",\"count\":\"15\",\"chance\":\"80000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"4500\"}]'),
(20, 0, 'chicken', 220, 0, 15, 1, 0, '[\"Gokgoooook\",\"Cluck Cluck\"]', '[]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":\"3\",\"chance\":\"30000\"},{\"id\":\"2695\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"2000\"}]'),
(21, 0, 'cobra', 275, 30, 65, 1, 0, '[\"Zzzzzz\"]', '[]', 1, 1, 'blood', '[]'),
(22, 0, 'crab', 305, 30, 55, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"2667\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"80000\"}]'),
(23, 0, 'crocodile', 350, 40, 105, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"2671\",\"count\":\"2\",\"chance\":\"40000\"},{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"50000\"},{\"id\":\"3982\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"8000\"}]'),
(24, 0, 'crypt shambler', 580, 195, 330, 1, 0, '[\"Uhhhhhhh!\",\"Aaaaahhhh!\",\"Hoooohhh!\",\"Chhhhhhh!\"]', '[\"lifedrain\",\"paralyze\"]', 0, 1, 'undead', '[{\"id\":\"3976\",\"count\":\"10\",\"chance\":\"90000\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"30000\"},{\"id\":\"2148\",\"count\":\"25\",\"chance\":\"40000\"},{\"id\":\"2145\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2399\",\"count\":\"3\",\"chance\":\"1000\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2227\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2459\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2450\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2541\",\"count\":1,\"chance\":\"1000\"}]'),
(25, 0, 'cyclops', 490, 150, 260, 1, 0, '[\"Il lorstok human!\",\"Toks utat.\",\"Human, uh whil dyh!\",\"Youh ah trak!\",\"Let da mashing begin!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2671\",\"count\":\"2\",\"chance\":\"20000\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"40000\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"700\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"100\"}]'),
(26, 0, 'dark monk', 480, 145, 190, 5, 0, '[\"This is where your path will end!\",\"Your end has come.\",\"You are no match for us!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":\"2689\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2148\",\"count\":\"18\",\"chance\":\"15000\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2193\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2015\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"1949\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"13000\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"5500\"},{\"id\":\"2642\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2044\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2166\",\"count\":1,\"chance\":\"100\"}]'),
(27, 0, 'deer', 260, 0, 25, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"2671\",\"count\":1,\"chance\":\"45000\"},{\"id\":\"2666\",\"count\":\"3\",\"chance\":\"80000\"}]'),
(28, 0, 'demon skeleton', 620, 240, 400, 1, 0, '[]', '[\"lifedrain\",\"paralyze\"]', 1, 1, 'undead', '[{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"25\",\"chance\":\"30000\"},{\"id\":\"2399\",\"count\":\"3\",\"chance\":\"10000\"},{\"id\":\"2194\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2459\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2417\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"100\"}]'),
(29, 0, 'demon', 0, 6000, 8200, 10, 0, '[\"MUHAHAHAHA!\",\"I SMELL FEEEEEAAAR!\",\"CHAMEK ATH UTHUL ARAK!\",\"Your resistance is futile!\",\"Your soul will be mine!\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2795\",\"count\":\"6\",\"chance\":\"20000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"60000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"50000\"},{\"id\":\"2151\",\"count\":1,\"chance\":\"3500\"},{\"id\":\"2149\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2176\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"1982\",\"count\":1,\"chance\":\"1300\"},{\"id\":\"2179\",\"count\":1,\"chance\":\"1100\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"700\"},{\"id\":\"2462\",\"count\":1,\"chance\":\"1200\"},{\"id\":\"2470\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2472\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2396\",\"count\":1,\"chance\":\"600\"},{\"id\":\"2418\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2520\",\"count\":1,\"chance\":\"700\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"1400\"}]'),
(30, 0, 'dog', 220, 0, 20, 1, 0, '[\"Wuff wuff\"]', '[]', 1, 1, 'blood', '[]'),
(31, 0, 'dragon lord', 0, 2100, 1900, 1, 0, '[\"ZCHHHHH\",\"YOU WILL BURN!\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2672\",\"count\":\"5\",\"chance\":\"60000\"},{\"id\":\"2796\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"60000\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2547\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"600\"},{\"id\":\"1976\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2492\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"5000\"}]'),
(32, 0, 'dragon', 0, 700, 1000, 1, 0, '[\"GROOAAARRR\",\"FCHHHHH\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2672\",\"count\":\"3\",\"chance\":\"45000\"},{\"id\":\"2148\",\"count\":\"45\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"60\",\"chance\":\"50000\"},{\"id\":\"2145\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2546\",\"count\":\"10\",\"chance\":\"16000\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2457\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2647\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2455\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2413\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2434\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2409\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2187\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2516\",\"count\":1,\"chance\":\"300\"}]'),
(33, 0, 'dwarf geomancer', 0, 245, 380, 1, 0, '[\"Hail Durin!\",\"Earth is the strongest element.\",\"Dust to dust.\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2673\",\"count\":\"2\",\"chance\":\"18000\"},{\"id\":\"2787\",\"count\":\"2\",\"chance\":\"60000\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"70000\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2260\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"40000\"},{\"id\":\"2481\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2468\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"2423\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"300\"}]'),
(34, 0, 'dwarf guard', 650, 165, 245, 1, 0, '[\"Hail Durin!\"]', '[\"invisible\"]', 1, 1, 'blood', '[{\"id\":\"2787\",\"count\":\"2\",\"chance\":\"55000\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"50000\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"40000\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2457\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2417\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"600\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"7500\"},{\"id\":\"2208\",\"count\":1,\"chance\":\"200\"}]'),
(35, 0, 'dwarf soldier', 360, 70, 135, 1, 0, '[\"Hail Durin!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2787\",\"count\":\"2\",\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"35000\"},{\"id\":\"2543\",\"count\":\"4\",\"chance\":\"40000\"},{\"id\":\"2554\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2481\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2378\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2525\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2455\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2208\",\"count\":1,\"chance\":\"100\"}]'),
(36, 0, 'dwarf', 320, 45, 90, 1, 0, '[\"Hail Durin!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2787\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"8\",\"chance\":\"45000\"},{\"id\":\"2597\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2553\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2484\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2388\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2530\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"100\"}]'),
(37, 0, 'dworc fleshhunter', 300, 35, 85, 1, 0, '[\"Grak brrretz!\",\"Grow truk grrrrr.\",\"Prek tars, dekklep zurk.\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"80000\"},{\"id\":\"2229\",\"count\":\"3\",\"chance\":\"3000\"},{\"id\":\"2568\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"22000\"},{\"id\":\"3967\",\"count\":1,\"chance\":\"500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5500\"},{\"id\":\"3964\",\"count\":1,\"chance\":\"100\"},{\"id\":\"3965\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2541\",\"count\":1,\"chance\":\"1000\"}]'),
(38, 0, 'dworc venomsniper', 300, 30, 80, 1, 0, '[\"Grak brrretz!\",\"Grow truk grrrrr.\",\"Prek tars, dekklep zurk.\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"80000\"},{\"id\":\"2229\",\"count\":\"2\",\"chance\":\"1000\"},{\"id\":\"2545\",\"count\":\"3\",\"chance\":\"5000\"},{\"id\":\"2410\",\"count\":\"2\",\"chance\":\"8000\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"3967\",\"count\":1,\"chance\":\"500\"},{\"id\":\"3983\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5500\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2172\",\"count\":1,\"chance\":\"100\"}]'),
(39, 0, 'dworc voodoomaster', 300, 50, 80, 1, 0, '[\"Grak brrretz!\",\"Grow truk grrrrr.\",\"Prek tars, dekklep zurk.\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"80000\"},{\"id\":\"2229\",\"count\":\"3\",\"chance\":\"3000\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"3967\",\"count\":1,\"chance\":\"500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5500\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2174\",\"count\":1,\"chance\":\"500\"}]'),
(40, 0, 'efreet', 0, 300, 550, 7, 0, '[\"I grant you a deathwish!\",\"Muhahahaha!\",\"I wish you a merry trip to hell!\",\"Tell me your last wish!\",\"Good wishes are for fairytales\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2673\",\"count\":\"12\",\"chance\":\"25000\"},{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"50000\"},{\"id\":\"2149\",\"count\":\"2\",\"chance\":\"7000\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1860\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2359\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2663\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2442\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2187\",\"count\":1,\"chance\":\"500\"}]'),
(41, 0, 'elder beholder', 0, 280, 500, 1, 0, '[\"653768764!\",\"Let me take a look at you!\",\"Inferior creatures, bow before my power!\",\"659978 54764!\"]', '[\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"24\",\"chance\":\"90000\"},{\"id\":\"2148\",\"count\":\"32\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"35\",\"chance\":\"70000\"},{\"id\":\"3972\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2394\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2518\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"1000\"}]'),
(42, 0, 'elephant', 500, 160, 320, 1, 0, '[\"Hooooot-Toooooot!\",\"Tooooot.\",\"Troooooot!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2671\",\"count\":\"3\",\"chance\":\"60000\"},{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"90000\"},{\"id\":\"3956\",\"count\":\"2\",\"chance\":\"1000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"3973\",\"count\":1,\"chance\":\"100\"}]'),
(43, 0, 'elf arcanist', 0, 175, 220, 1, 0, '[\"Feel my wrath!\",\"For the Daughter of the Stars!\",\"I\'ll bring balance upon you!\",\"Tha\'shi Cenath!\",\"Vihil Ealuel!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2682\",\"count\":1,\"chance\":\"22000\"},{\"id\":\"2689\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2544\",\"count\":\"3\",\"chance\":\"6000\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2600\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"1949\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2032\",\"count\":1,\"chance\":\"5500\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2260\",\"count\":1,\"chance\":\"18000\"},{\"id\":\"2642\",\"count\":1,\"chance\":\"26000\"},{\"id\":\"2652\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2047\",\"count\":1,\"chance\":\"22000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2189\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2198\",\"count\":1,\"chance\":\"2000\"}]'),
(44, 0, 'elf scout', 360, 75, 160, 1, 0, '[\"Tha\'shi Ab\'Dendriel!\",\"Feel the sting of my arrows!\",\"Thy blood will quench the soil\'s thirst!\",\"Evicor guide my arrow.\",\"Your existence will end here!\"]', '[\"invisible\"]', 1, 1, 'blood', '[{\"id\":\"2681\",\"count\":1,\"chance\":\"18000\"},{\"id\":\"2148\",\"count\":\"5\",\"chance\":\"30000\"},{\"id\":\"2544\",\"count\":\"12\",\"chance\":\"30000\"},{\"id\":\"2545\",\"count\":\"3\",\"chance\":\"15000\"},{\"id\":\"2031\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2642\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2482\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2484\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2456\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"6000\"}]'),
(45, 0, 'elf', 320, 42, 100, 1, 0, '[\"Ulathil beia Thratha!\",\"Bahaha aka!\",\"You are not welcome here.\",\"Flee as long as you can.\",\"Death to the defilers!\"]', '[\"invisible\"]', 1, 1, 'blood', '[{\"id\":\"2674\",\"count\":\"2\",\"chance\":\"20000\"},{\"id\":\"2544\",\"count\":\"3\",\"chance\":\"7000\"},{\"id\":\"2482\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2484\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2511\",\"count\":1,\"chance\":\"13000\"}]'),
(46, 0, 'fire devil', 530, 110, 200, 1, 0, '[\"Hot, eh?\",\"Hell, oh hell!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2150\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2260\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2548\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2568\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2185\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"200\"}]'),
(47, 0, 'fire elemental', 690, 220, 280, 1, 0, '[]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 1, 1, 'fire', '[]'),
(48, 0, 'flamingo', 250, 0, 25, 1, 0, '[]', '[]', 1, 1, 'blood', '[]'),
(49, 0, 'frost troll', 300, 23, 55, 1, 0, '[\"Brrrr\",\"Broar!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2667\",\"count\":1,\"chance\":\"18000\"},{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"50000\"},{\"id\":\"2245\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2651\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2389\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2384\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2382\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2512\",\"count\":1,\"chance\":\"15000\"}]'),
(50, 0, 'gargoyle', 0, 150, 250, 1, 0, '[\"Harrrr Harrrr!\",\"Stone sweet stone.\",\"Feel my claws, softskin.\",\"Chhhhhrrrrk!\",\"There is a stone in your shoe!\"]', '[\"lifedrain\"]', 0, 0, 'undead', '[{\"id\":\"2671\",\"count\":\"2\",\"chance\":\"20000\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"40000\"},{\"id\":\"1294\",\"count\":\"10\",\"chance\":\"10000\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2457\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2489\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2448\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2394\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"100\"}]'),
(51, 0, 'gazer', 0, 90, 120, 1, 0, '[\"Mommy!?\",\"Buuuuhaaaahhaaaaa!\",\"Me need mana!\"]', '[\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2512\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2148\",\"count\":\"6\",\"chance\":\"90000\"},{\"id\":\"2148\",\"count\":\"8\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"70000\"}]'),
(52, 0, 'ghost', 0, 120, 150, 1, 0, '[\"Huh!\",\"Shhhhhh\",\"Buuuuuh\"]', '[\"lifedrain\",\"paralyze\"]', 0, 0, 'undead', '[{\"id\":\"2654\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2804\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2642\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2404\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2394\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2532\",\"count\":1,\"chance\":\"800\"},{\"id\":\"1977\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"200\"}]'),
(53, 0, 'ghoul', 450, 85, 100, 1, 0, '[]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":\"6\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"75000\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2460\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2473\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"60000\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"200\"}]'),
(54, 0, 'giant spider', 0, 900, 1300, 10, 0, '[]', '[\"lifedrain\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2148\",\"count\":\"55\",\"chance\":\"33300\"},{\"id\":\"2148\",\"count\":\"11\",\"chance\":\"99900\"},{\"id\":\"2148\",\"count\":\"33\",\"chance\":\"66600\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2457\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"700\"}]'),
(55, 0, 'goblin', 290, 25, 50, 1, 0, '[\"Me have him!\",\"Zig Zag! Gobo attack!\",\"Help! Goblinkiller!\",\"Bugga! Bugga!\",\"Me green, me mean!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2667\",\"count\":1,\"chance\":\"13000\"},{\"id\":\"2148\",\"count\":\"9\",\"chance\":\"50000\"},{\"id\":\"1294\",\"count\":\"3\",\"chance\":\"30000\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"2235\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2559\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"7500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2379\",\"count\":1,\"chance\":\"18000\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2449\",\"count\":1,\"chance\":\"5000\"}]'),
(56, 0, 'green djinn', 0, 190, 330, 1, 0, '[\"I grant you a deathwish!\",\"Muhahahaha!\",\"I wish you a merry trip to hell!\",\"Tell me your last wish!\",\"Good wishes are for fairytales\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2696\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"35000\"},{\"id\":\"2149\",\"count\":\"4\",\"chance\":\"2700\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2359\",\"count\":1,\"chance\":\"7500\"},{\"id\":\"2663\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"1980\",\"count\":1,\"chance\":\"2500\"}]'),
(57, 0, 'hero', 0, 1200, 1400, 30, 0, '[\"Let\'s have a fight!\",\"Welcome to my battleground.\",\"Have you seen princess Lumelia?\",\"I will sing a tune at your grave.\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"18000\"},{\"id\":\"2681\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"60000\"},{\"id\":\"2544\",\"count\":\"13\",\"chance\":\"27000\"},{\"id\":\"1949\",\"count\":1,\"chance\":\"45000\"},{\"id\":\"2744\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2071\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2121\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2661\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"2652\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2491\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"600\"},{\"id\":\"2488\",\"count\":1,\"chance\":\"500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2456\",\"count\":1,\"chance\":\"13000\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2391\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2519\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"500\"}]'),
(58, 0, 'hunter', 530, 150, 150, 1, 0, '[\"Guess who we are hunting, hahaha!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2675\",\"count\":\"2\",\"chance\":\"20000\"},{\"id\":\"2690\",\"count\":\"2\",\"chance\":\"11000\"},{\"id\":\"2147\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2544\",\"count\":\"10\",\"chance\":\"70000\"},{\"id\":\"2544\",\"count\":\"12\",\"chance\":\"40000\"},{\"id\":\"2546\",\"count\":\"3\",\"chance\":\"5000\"},{\"id\":\"2460\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2456\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2201\",\"count\":1,\"chance\":\"3000\"}]'),
(59, 0, 'hyaena', 275, 20, 60, 1, 0, '[\"Grrrrrr\",\"Hou hou hou!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":\"3\",\"chance\":\"50000\"},{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"50000\"}]'),
(60, 0, 'hydra', 0, 2100, 2250, 1, 0, '[\"FCHHHHH\",\"HISSSS\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2671\",\"count\":\"3\",\"chance\":\"60000\"},{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"90000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"60000\"},{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"80000\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"4850\",\"count\":1,\"chance\":\"900\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"600\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2536\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"1200\"}]'),
(61, 0, 'kongra', 0, 110, 340, 1, 0, '[\"Hugah!\",\"Ungh! Ungh!\",\"Huaauaauaauaa!\"]', '[]', 0, 0, 'blood', '[{\"id\":\"2676\",\"count\":\"2\",\"chance\":\"30000\"},{\"id\":\"2676\",\"count\":\"10\",\"chance\":\"5000\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"10000\"},{\"id\":\"2148\",\"count\":\"25\",\"chance\":\"80000\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2200\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2166\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"200\"}]'),
(62, 0, 'larva', 355, 44, 70, 1, 0, '[]', '[\"paralyze\"]', 1, 1, 'venom', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"35000\"}]'),
(63, 0, 'lich', 0, 900, 880, 1, 0, '[\"Death awaits all!\",\"Doomed be the living!\",\"Death and Decay!\",\"You will endure agony beyond thy death!\",\"Come to me my children!\",\"Pain sweet pain!\",\"Thy living flesh offends me!\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"30000\"},{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"40000\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2237\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"60000\"},{\"id\":\"2535\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"1000\"}]'),
(64, 0, 'lion', 320, 30, 80, 1, 0, '[\"Groarrr!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2671\",\"count\":\"2\",\"chance\":\"20000\"},{\"id\":\"2666\",\"count\":\"3\",\"chance\":\"45000\"}]'),
(65, 0, 'lizard sentinel', 560, 105, 265, 1, 0, '[\"Tssss!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"15\",\"chance\":\"80000\"},{\"id\":\"2145\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2389\",\"count\":\"3\",\"chance\":\"10000\"},{\"id\":\"2425\",\"count\":1,\"chance\":\"1200\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"500\"},{\"id\":\"3974\",\"count\":1,\"chance\":\"300\"}]'),
(66, 0, 'lizard snakecharmer', 0, 210, 325, 1, 0, '[\"Shhhhhhhh.\",\"I ssssmell warm blood!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"25\",\"chance\":\"80000\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2817\",\"count\":1,\"chance\":\"70000\"},{\"id\":\"2237\",\"count\":1,\"chance\":\"19900\"},{\"id\":\"2654\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"3971\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2182\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2181\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"200\"}]'),
(67, 0, 'lizard templar', 0, 145, 410, 1, 0, '[\"Hissss!\"]', '[]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"80000\"},{\"id\":\"2149\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2457\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2394\",\"count\":1,\"chance\":\"700\"},{\"id\":\"3963\",\"count\":1,\"chance\":\"500\"},{\"id\":\"3975\",\"count\":1,\"chance\":\"100\"}]'),
(68, 0, 'marid', 0, 300, 550, 7, 0, '[\"Simsalabim\",\"Feel the power of my magic, tiny mortal!\",\"Be careful what you wish for.\",\"Wishes can come true.\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2677\",\"count\":\"25\",\"chance\":\"25000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"70000\"},{\"id\":\"2146\",\"count\":\"2\",\"chance\":\"7000\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1872\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2070\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2359\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2663\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2442\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2183\",\"count\":1,\"chance\":\"500\"}]'),
(69, 0, 'merlkin', 0, 135, 230, 1, 0, '[\"Ugh! Ugh! Ugh!\",\"Holy banana!\",\"Chakka! Chakka!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2676\",\"count\":\"2\",\"chance\":\"30000\"},{\"id\":\"2676\",\"count\":\"10\",\"chance\":\"5000\"},{\"id\":\"2675\",\"count\":\"5\",\"chance\":\"1000\"},{\"id\":\"2148\",\"count\":\"25\",\"chance\":\"80000\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2188\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"3966\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"5000\"}]'),
(70, 0, 'minotaur archer', 390, 65, 100, 1, 0, '[\"Ruan Wihmpy!\",\"Kaplar!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"15000\"},{\"id\":\"2543\",\"count\":\"15\",\"chance\":\"50000\"},{\"id\":\"2543\",\"count\":\"5\",\"chance\":\"80000\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2481\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2455\",\"count\":1,\"chance\":\"10000\"}]'),
(71, 0, 'minotaur guard', 550, 160, 185, 1, 0, '[\"Kirll Karrrl!\",\"Kaplar!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"60000\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2648\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2388\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2580\",\"count\":1,\"chance\":\"5000\"}]'),
(72, 0, 'minotaur mage', 0, 150, 155, 1, 0, '[\"Learrn tha secrret uf deathhh!\",\"Kaplar!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2684\",\"count\":\"7\",\"chance\":\"10000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"80000\"},{\"id\":\"2817\",\"count\":1,\"chance\":\"70000\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2648\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2404\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2189\",\"count\":1,\"chance\":\"500\"}]'),
(73, 0, 'minotaur', 330, 50, 100, 1, 0, '[\"Kaplar!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"55000\"},{\"id\":\"2148\",\"count\":\"15\",\"chance\":\"25000\"},{\"id\":\"2554\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2460\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2458\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"13000\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2172\",\"count\":1,\"chance\":\"100\"}]'),
(74, 0, 'monk', 600, 200, 240, 10, 0, '[\"I will punish the sinners!\",\"A prayer to the almighty one.\",\"Repent Heretic!\"]', '[\"invisible\"]', 1, 0, 'blood', '[{\"id\":\"2689\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2148\",\"count\":\"18\",\"chance\":\"15000\"},{\"id\":\"2193\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"1949\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2015\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"13000\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"5500\"},{\"id\":\"2642\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2044\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2166\",\"count\":1,\"chance\":\"100\"}]'),
(75, 0, 'mummy', 510, 150, 240, 1, 0, '[\"I will ssswallow your sssoul!\",\"Ahkahra exura belil mort!\",\"Yohag Sssetham!\",\"I will tassste life again!\",\"Mort ulhegh dakh visss.\",\"Flesssh to dussst!\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"3976\",\"count\":\"3\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"40000\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2134\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"16000\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2529\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2170\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2161\",\"count\":1,\"chance\":\"5000\"}]'),
(76, 0, 'necromancer', 0, 580, 580, 1, 0, '[\"Your corpse will be mine!\",\"Taste the sweetness of death!\"]', '[\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2796\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2148\",\"count\":\"90\",\"chance\":\"30000\"},{\"id\":\"2663\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2423\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"15000\"}]'),
(77, 0, 'orc berserker', 590, 195, 210, 15, 0, '[\"KRAK ORRRRRRK!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2671\",\"count\":1,\"chance\":\"17000\"},{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"55000\"},{\"id\":\"2458\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2044\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2378\",\"count\":1,\"chance\":\"6000\"}]'),
(78, 0, 'orc leader', 640, 270, 450, 5, 0, '[\"Ulderek futgyr human!\"]', '[\"invisible\"]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"15000\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2148\",\"count\":\"35\",\"chance\":\"28000\"},{\"id\":\"2410\",\"count\":\"4\",\"chance\":\"10000\"},{\"id\":\"1988\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2647\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2413\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"2379\",\"count\":1,\"chance\":\"23000\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2207\",\"count\":1,\"chance\":\"4000\"}]');
INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(79, 0, 'orc rider', 490, 110, 180, 20, 0, '[\"Grrrrrrr\",\"Orc arga Huummmak!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2666\",\"count\":\"3\",\"chance\":\"30000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"100\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1988\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2482\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"600\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2428\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2425\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"1000\"}]'),
(80, 0, 'orc shaman', 0, 110, 115, 1, 0, '[\"Grak brrretz gulu.\",\"Huumans stinkk!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2686\",\"count\":\"2\",\"chance\":\"11000\"},{\"id\":\"2148\",\"count\":\"5\",\"chance\":\"90000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2458\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2389\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2188\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"1973\",\"count\":1,\"chance\":\"4500\"}]'),
(81, 0, 'orc spearman', 310, 38, 105, 1, 0, '[\"Ugaar!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2148\",\"count\":\"7\",\"chance\":\"22000\"},{\"id\":\"2220\",\"count\":1,\"chance\":\"7700\"},{\"id\":\"2482\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2468\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2389\",\"count\":1,\"chance\":\"23000\"},{\"id\":\"2420\",\"count\":1,\"chance\":\"10000\"}]'),
(82, 0, 'orc warlord', 0, 670, 950, 7, 0, '[\"Ranat Ulderek!\",\"Orc buta bana!\",\"Ikem rambo zambo!\",\"Futchi maruk buta!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"20000\"},{\"id\":\"2667\",\"count\":\"2\",\"chance\":\"10000\"},{\"id\":\"2148\",\"count\":\"45\",\"chance\":\"19000\"},{\"id\":\"2399\",\"count\":\"40\",\"chance\":\"30000\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2497\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2647\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2428\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2434\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"2200\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"100\"}]'),
(83, 0, 'orc warrior', 360, 50, 125, 1, 0, '[\"Grow truk grrrr.\",\"Trak grrrr brik.\",\"Alk!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2148\",\"count\":\"15\",\"chance\":\"65000\"},{\"id\":\"2007\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"7500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2385\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2512\",\"count\":1,\"chance\":\"18000\"},{\"id\":\"2530\",\"count\":1,\"chance\":\"500\"}]'),
(84, 0, 'orc', 300, 25, 70, 1, 0, '[\"Grak brrretz!\",\"Grow truk grrrrr.\",\"Prek tars, dekklep zurk.\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2148\",\"count\":\"8\",\"chance\":\"85000\"},{\"id\":\"2482\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2484\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2385\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2526\",\"count\":1,\"chance\":\"10000\"}]'),
(85, 0, 'panda', 300, 23, 80, 1, 0, '[\"Grrrr\",\"Groar\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2671\",\"count\":\"2\",\"chance\":\"40000\"},{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"70000\"}]'),
(86, 0, 'parrot', 250, 0, 25, 50, 0, '[\"BR? PL? SWE?\",\"Screeeeeeech!\",\"Neeeewbiiieee!\",\"You advanshed, you advanshed!\",\"Hope you die and loooosh it!\",\"Hunterrr ish PK!\"]', '[]', 1, 1, 'blood', '[]'),
(87, 0, 'pig', 255, 0, 25, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"65000\"}]'),
(88, 0, 'poison spider', 270, 22, 26, 1, 0, '[]', '[]', 1, 1, 'venom', '[{\"id\":\"2148\",\"count\":\"4\",\"chance\":\"25000\"}]'),
(89, 0, 'polar bear', 315, 28, 85, 1, 0, '[\"Grrrrrr\",\"GROARRR!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2671\",\"count\":\"2\",\"chance\":\"50000\"},{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"70000\"}]'),
(90, 0, 'priestess', 0, 420, 390, 1, 0, '[\"Your energy is mine.\",\"Now, your life has come to an end, hahahha!\",\"Throw the soul on the altar!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2674\",\"count\":\"2\",\"chance\":\"7500\"},{\"id\":\"2791\",\"count\":1,\"chance\":\"3500\"},{\"id\":\"2151\",\"count\":1,\"chance\":\"700\"},{\"id\":\"2070\",\"count\":1,\"chance\":\"1400\"},{\"id\":\"2192\",\"count\":1,\"chance\":\"1200\"},{\"id\":\"2032\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2760\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"2803\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2125\",\"count\":1,\"chance\":\"600\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2379\",\"count\":1,\"chance\":\"23000\"},{\"id\":\"2423\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2183\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2529\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1977\",\"count\":1,\"chance\":\"7000\"}]'),
(91, 0, 'rabbit', 220, 0, 15, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"85000\"},{\"id\":\"2684\",\"count\":1,\"chance\":\"10000\"}]'),
(92, 0, 'rat', 200, 5, 20, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":\"3\",\"chance\":\"50000\"},{\"id\":\"2696\",\"count\":1,\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"4\",\"chance\":\"70000\"}]'),
(93, 0, 'rotworm', 305, 40, 65, 1, 0, '[]', '[]', 0, 1, 'blood', '[{\"id\":\"3976\",\"count\":\"5\",\"chance\":\"50000\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2148\",\"count\":\"8\",\"chance\":\"60000\"},{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"30000\"},{\"id\":\"2480\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"4500\"},{\"id\":\"2412\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2530\",\"count\":1,\"chance\":\"1000\"}]'),
(94, 0, 'scarab', 395, 120, 320, 1, 0, '[]', '[\"paralyze\"]', 1, 1, 'venom', '[{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"54000\"},{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"70500\"},{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"44500\"},{\"id\":\"2159\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2159\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2149\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2544\",\"count\":\"3\",\"chance\":\"5000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2439\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2442\",\"count\":1,\"chance\":\"500\"}]'),
(95, 0, 'scorpion', 310, 45, 45, 1, 0, '[]', '[]', 1, 1, 'venom', '[]'),
(96, 0, 'serpent spawn', 0, 2000, 3000, 7, 0, '[\"Ssssolus for the one\",\"HISSSS\",\"Tsssse one will risssse again\",\"I bring you deathhhh, mortalssss\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2796\",\"count\":1,\"chance\":\"18000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"60000\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2547\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"1967\",\"count\":1,\"chance\":\"500\"},{\"id\":\"1976\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"600\"},{\"id\":\"3971\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2492\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2182\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"3000\"}]'),
(97, 0, 'sheep', 250, 0, 20, 1, 0, '[\"Maeh\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"70000\"}]'),
(98, 0, 'sibang', 0, 105, 225, 1, 0, '[\"Eeeeek! Eeeeek\",\"Huh! Huh! Huh!\",\"Ahhuuaaa!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2676\",\"count\":\"2\",\"chance\":\"30000\"},{\"id\":\"2676\",\"count\":\"10\",\"chance\":\"5000\"},{\"id\":\"2675\",\"count\":\"5\",\"chance\":\"20000\"},{\"id\":\"2678\",\"count\":\"5\",\"chance\":\"20000\"},{\"id\":\"2682\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2148\",\"count\":\"25\",\"chance\":\"80000\"},{\"id\":\"1294\",\"count\":\"3\",\"chance\":\"30000\"},{\"id\":\"2458\",\"count\":1,\"chance\":\"4000\"}]'),
(99, 0, 'skeleton', 300, 35, 50, 1, 0, '[]', '[\"lifedrain\"]', 1, 1, 'undead', '[{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"45000\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2473\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2388\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2511\",\"count\":1,\"chance\":\"12000\"}]'),
(100, 0, 'skunk', 200, 3, 20, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"1000\"}]'),
(101, 0, 'slime', 0, 0, 150, 1, 0, '[\"Blubb\"]', '[]', 0, 0, 'venom', '[]'),
(102, 0, 'smuggler', 390, 48, 130, 1, 0, '[\"I will silence you forever!\",\"You saw something you shouldn\'t!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2671\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"80000\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2404\",\"count\":1,\"chance\":\"4000\"}]'),
(103, 0, 'snake', 205, 10, 15, 1, 0, '[\"Zzzzzzt\"]', '[]', 1, 1, 'blood', '[]'),
(104, 0, 'spider', 210, 12, 20, 1, 0, '[]', '[]', 1, 1, 'venom', '[{\"id\":\"2148\",\"count\":\"5\",\"chance\":\"35000\"}]'),
(105, 0, 'spit nettle', 0, 20, 150, 1, 0, '[]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2148\",\"count\":\"5\",\"chance\":\"10000\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2804\",\"count\":1,\"chance\":\"10000\"}]'),
(106, 0, 'stalker', 0, 90, 120, 10, 0, '[]', '[\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"8\",\"chance\":\"13000\"},{\"id\":\"2410\",\"count\":\"2\",\"chance\":\"11000\"},{\"id\":\"2260\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"1998\",\"count\":1,\"chance\":\"4500\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2412\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2425\",\"count\":1,\"chance\":\"1200\"},{\"id\":\"2511\",\"count\":1,\"chance\":\"5500\"}]'),
(107, 0, 'stone golem', 590, 160, 270, 1, 0, '[]', '[\"paralyze\"]', 1, 1, 'undead', '[{\"id\":\"2148\",\"count\":\"15\",\"chance\":\"16000\"},{\"id\":\"1294\",\"count\":\"4\",\"chance\":\"13000\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5500\"},{\"id\":\"2395\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2166\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"200\"}]'),
(108, 0, 'swamp troll', 320, 25, 55, 1, 0, '[\"Grrrr\",\"Groar!\",\"Me strong! Me ate spinach!\"]', '[]', 1, 1, 'venom', '[{\"id\":\"2667\",\"count\":1,\"chance\":\"60000\"},{\"id\":\"2148\",\"count\":\"5\",\"chance\":\"50000\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2379\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2580\",\"count\":1,\"chance\":\"100\"}]'),
(109, 0, 'tarantula', 485, 120, 225, 1, 0, '[]', '[]', 1, 1, 'venom', '[{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"30000\"},{\"id\":\"2457\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"100\"}]'),
(110, 0, 'terror bird', 490, 150, 300, 1, 0, '[\"CRAAAHHH!\",\"Gruuuh Gruuuh.\",\"Carrah Carrah!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":\"1\",\"chance\":\"20000\"},{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"40000\"},{\"id\":\"3970\",\"count\":1,\"chance\":\"100\"}]'),
(111, 0, 'tiger', 420, 40, 75, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"2671\",\"count\":\"2\",\"chance\":\"22000\"},{\"id\":\"2666\",\"count\":\"3\",\"chance\":\"55000\"}]'),
(112, 0, 'troll', 290, 20, 50, 1, 0, '[\"Grrrr\",\"Groar\",\"Gruntz!\",\"Hmmm, bugs.\",\"Hmmm, dogs.\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"60000\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2389\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2380\",\"count\":1,\"chance\":\"36000\"},{\"id\":\"2448\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2512\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2170\",\"count\":1,\"chance\":\"100\"}]'),
(113, 0, 'valkyrie', 450, 85, 190, 1, 0, '[\"Stand still!\",\"One more head for me!\",\"Head off!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":\"3\",\"chance\":\"30000\"},{\"id\":\"2674\",\"count\":\"2\",\"chance\":\"7500\"},{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"32000\"},{\"id\":\"2145\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2229\",\"count\":\"2\",\"chance\":\"80000\"},{\"id\":\"2458\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"800\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2389\",\"count\":\"3\",\"chance\":\"60000\"},{\"id\":\"2379\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2200\",\"count\":1,\"chance\":\"1100\"}]'),
(114, 0, 'vampire', 0, 290, 450, 1, 0, '[\"BLOOD!\",\"Let me kiss your neck.\",\"I smell warm blood.\",\"I call you, my bats! Come!\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"15000\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2032\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"36000\"},{\"id\":\"2127\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2396\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2412\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2383\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2534\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2172\",\"count\":1,\"chance\":\"200\"}]'),
(115, 0, 'war wolf', 420, 55, 140, 22, 0, '[\"Grrrrrrr\",\"Yoooohhuuuu!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2671\",\"count\":\"2\",\"chance\":\"40000\"},{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"70000\"}]'),
(116, 0, 'warlock', 0, 4000, 3200, 5, 0, '[\"Learn the secret of our magic! YOUR death!\",\"Even a rat is a better mage than you.\",\"We don\'t like intruders!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2689\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2792\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2679\",\"count\":\"4\",\"chance\":\"20000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"30000\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"2800\"},{\"id\":\"2151\",\"count\":1,\"chance\":\"1100\"},{\"id\":\"1986\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2600\",\"count\":1,\"chance\":\"13000\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2123\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2466\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2047\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2185\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"3000\"}]'),
(117, 0, 'wasp', 280, 24, 35, 50, 0, '[\"Bsssssss\"]', '[]', 1, 1, 'venom', '[]'),
(118, 0, 'wild warrior', 420, 60, 135, 1, 0, '[\"An enemy!\",\"Gimme your money!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"15000\"},{\"id\":\"2110\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2458\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2459\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2391\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2511\",\"count\":1,\"chance\":\"17000\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"1000\"}]'),
(119, 0, 'winter wolf', 260, 20, 30, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"60000\"}]'),
(120, 0, 'witch', 0, 120, 300, 1, 0, '[\"Horax pokti!\",\"Hihihihi!\",\"Herba budinia ex!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2696\",\"count\":1,\"chance\":\"40000\"},{\"id\":\"2687\",\"count\":\"8\",\"chance\":\"30000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"10000\"},{\"id\":\"2800\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2551\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2654\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2651\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2405\",\"count\":1,\"chance\":\"40000\"},{\"id\":\"2402\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2185\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2199\",\"count\":1,\"chance\":\"2500\"}]'),
(121, 0, 'wolf', 255, 18, 25, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2666\",\"count\":\"2\",\"chance\":\"50000\"}]'),
(122, 0, 'yeti', 0, 460, 950, 15, 0, '[\"Yooodelaaahooohooo!\",\"Yooodelaaaheeeheee!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2671\",\"count\":\"6\",\"chance\":\"35000\"},{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"75000\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"60000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"30000\"},{\"id\":\"2111\",\"count\":\"22\",\"chance\":\"50000\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2644\",\"count\":1,\"chance\":\"100\"}]'),
(123, 0, 'deathslicer', 0, 320, 2000, 1, 0, '[]', '[\"lifedrain\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(124, 0, 'flamethrower', 0, 1200, 9950, 1, 0, '[]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(125, 0, 'plaguethrower', 0, 1300, 9950, 1, 0, '[]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(126, 0, 'Shredderthrower', 0, 18, 100, 1, 0, '[]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(127, 0, 'Ashmunrah', 0, 3100, 5000, 105, 0, '[\"I might be trapped but not without power.\",\"Ahhhh all those long years.\",\"Ages come, ages go. Asmumrah remains.\",\"My traitorous son has sent thee.\",\"No mortal or undead will steal my secrets.\",\"You will be history soon.\",\"Come to me, my allys and underlings.\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"90\",\"chance\":\"40000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"85\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"95\",\"chance\":\"35000\"},{\"id\":\"2134\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2140\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2444\",\"count\":1,\"chance\":\"100\"}]'),
(128, 0, 'Demodras', 0, 3100, 2200, 5, 0, '[\"ZCHHHHH\",\"I WILL SET THE WORLD IN FIRE!\",\"I WILL PROTECT MY BROOD!\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2672\",\"count\":\"10\",\"chance\":\"75000\"},{\"id\":\"2796\",\"count\":\"7\",\"chance\":\"24000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"95000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"55000\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2547\",\"count\":1,\"chance\":\"16000\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"1976\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"1200\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2492\",\"count\":1,\"chance\":\"300\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"600\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"600\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"10000\"}]'),
(129, 0, 'Dharalion', 0, 1200, 1200, 10, 0, '[\"You desecrated this temple!\",\"Noone will stop my ascension!\",\"My powers are divine!\",\"Muahahaha!\"]', '[\"lifedrain\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2689\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2682\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2260\",\"count\":1,\"chance\":\"18000\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2032\",\"count\":1,\"chance\":\"6500\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"1949\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2600\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2652\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2642\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2047\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2198\",\"count\":1,\"chance\":\"2000\"}]'),
(130, 0, 'Dipthrah', 0, 2900, 4200, 50, 0, '[\"Come closer to learn the final lesson.\",\"I sense the weakness of your akh.\",\"Mortality and fear are your fate and your doom.\",\"Undeath will shatter my shackles.\",\"You can\'t escape death forever.\",\"You don\'t need this magic anymore.\",\"Feel the powers of my mind.\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2354\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"85\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"95\",\"chance\":\"35000\"},{\"id\":\"2146\",\"count\":\"3\",\"chance\":\"10000\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2193\",\"count\":1,\"chance\":\"500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2446\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"5000\"}]'),
(131, 0, 'Fernfang', 0, 600, 400, 10, 0, '[\"You desecrated this place!\",\"I will cleanse this isle!\",\"Grrrrrrr\",\"Yoooohhuuuu!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2689\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2148\",\"count\":\"18\",\"chance\":\"15000\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2260\",\"count\":1,\"chance\":\"18000\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2015\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2032\",\"count\":1,\"chance\":\"6500\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2800\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2220\",\"count\":1,\"chance\":\"7700\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2652\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2642\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2044\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2166\",\"count\":1,\"chance\":\"500\"}]'),
(132, 0, 'general murius', 0, 1300, 1200, 10, 0, '[\"Feel the power of the Mooh\'Tah!\",\"You will get what you deserve!\",\"For the king!\",\"Guards!\"]', '[\"lifedrain\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"50000\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"28000\"},{\"id\":\"2648\",\"count\":1,\"chance\":\"35000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"7500\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"18000\"},{\"id\":\"2580\",\"count\":1,\"chance\":\"5000\"}]'),
(133, 0, 'Grorlam', 0, 290, 310, 10, 0, '[]', '[\"paralyze\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"15\",\"chance\":\"16000\"},{\"id\":\"2150\",\"count\":\"2\",\"chance\":\"6500\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"500\"},{\"id\":\"1294\",\"count\":\"4\",\"chance\":\"13000\"},{\"id\":\"2553\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2166\",\"count\":1,\"chance\":\"5500\"}]'),
(134, 0, 'The Halloween Hare', 0, 0, 2000, 45, 0, '[]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(135, 0, 'Mahrdis', 0, 3050, 3900, 40, 0, '[\"Ashes to ashes!\",\"Fire, Fire!\",\"The eternal flame demands its due!\",\"Burnnnnnnnnn!\",\"May my flames engulf you!\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2353\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"85\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"95\",\"chance\":\"35000\"},{\"id\":\"2147\",\"count\":\"3\",\"chance\":\"10000\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2141\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2539\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"5000\"}]'),
(136, 0, 'Morguthis', 0, 3000, 4800, 105, 0, '[\"Vengeance!\",\"You will make a fine trophy.\",\"Come and fight me, cowards!\",\"I am the supreme warrior!\",\"Let me hear the music of battle.\",\"Anotherone to bite the dust!\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2350\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"85\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"95\",\"chance\":\"35000\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2136\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2443\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2430\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"5000\"}]'),
(137, 0, 'necropharus', 0, 1100, 800, 10, 0, '[\"You will rise as my servant!\",\"Praise to my master Urgith!\"]', '[\"lifedrain\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2796\",\"count\":1,\"chance\":\"22500\"},{\"id\":\"2148\",\"count\":\"99\",\"chance\":\"67300\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"16000\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"2663\",\"count\":1,\"chance\":\"1800\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"8500\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"8600\"},{\"id\":\"2423\",\"count\":1,\"chance\":\"5700\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2449\",\"count\":1,\"chance\":\"19900\"},{\"id\":\"2186\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2541\",\"count\":1,\"chance\":\"7500\"}]'),
(138, 0, 'Omruc', 0, 2950, 4300, 45, 0, '[\"Now chhhou shhhee me ... Now chhhou don\'t!!\",\"Omruc is back!\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2352\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2674\",\"count\":\"2\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"85\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"95\",\"chance\":\"35000\"},{\"id\":\"2145\",\"count\":\"3\",\"chance\":\"10000\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2544\",\"count\":\"25\",\"chance\":\"20000\"},{\"id\":\"2545\",\"count\":\"20\",\"chance\":\"60000\"},{\"id\":\"2546\",\"count\":\"15\",\"chance\":\"40000\"},{\"id\":\"2547\",\"count\":\"5\",\"chance\":\"10000\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"5000\"}]'),
(139, 0, 'Orshabaal', 0, 9999, 22500, 80, 0, '[\"PRAISED BE MY MASTERS, THE RUTHLESS SEVEN!\",\"YOU ARE DOOMED!\",\"ORSHABAAL IS BACK!\",\"Be prepared for the day my masters will come for you!\",\"SOULS FOR ORSHABAAL!\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"99900\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"88800\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"77700\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"66600\"},{\"id\":\"2150\",\"count\":\"20\",\"chance\":\"13500\"},{\"id\":\"2145\",\"count\":\"5\",\"chance\":\"9500\"},{\"id\":\"2149\",\"count\":\"10\",\"chance\":\"15500\"},{\"id\":\"2146\",\"count\":\"10\",\"chance\":\"13500\"},{\"id\":\"2144\",\"count\":\"15\",\"chance\":\"15000\"},{\"id\":\"2143\",\"count\":\"15\",\"chance\":\"12500\"},{\"id\":\"2151\",\"count\":\"7\",\"chance\":\"14000\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2112\",\"count\":1,\"chance\":\"14500\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"7500\"},{\"id\":\"1982\",\"count\":1,\"chance\":\"2600\"},{\"id\":\"2176\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"2192\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"5500\"},{\"id\":\"2123\",\"count\":1,\"chance\":\"3500\"},{\"id\":\"2179\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2142\",\"count\":1,\"chance\":\"3500\"},{\"id\":\"2125\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2462\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2472\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2470\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"4500\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"11500\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2418\",\"count\":1,\"chance\":\"4500\"},{\"id\":\"2402\",\"count\":1,\"chance\":\"15500\"},{\"id\":\"2421\",\"count\":1,\"chance\":\"13500\"},{\"id\":\"2396\",\"count\":1,\"chance\":\"7500\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2434\",\"count\":1,\"chance\":\"4500\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"17000\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"12500\"},{\"id\":\"2186\",\"count\":1,\"chance\":\"3500\"},{\"id\":\"2182\",\"count\":1,\"chance\":\"3500\"},{\"id\":\"2185\",\"count\":1,\"chance\":\"3500\"},{\"id\":\"2188\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2520\",\"count\":1,\"chance\":\"15500\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"7500\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"13500\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"13000\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"9500\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2170\",\"count\":1,\"chance\":\"13000\"},{\"id\":\"2200\",\"count\":1,\"chance\":\"4500\"},{\"id\":\"2174\",\"count\":1,\"chance\":\"2500\"}]'),
(140, 0, 'Rahemos', 0, 3100, 3700, 30, 0, '[\"It\'s a kind of magic.\",\"Abrah Kadabrah!\",\"Nothing hidden in my warpings.\",\"It\'s not a trick, it\'s Rahemos.\",\"Meet my dear friend from hell.\",\"I will make you believe in magic.\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2348\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"85\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"95\",\"chance\":\"35000\"},{\"id\":\"2150\",\"count\":\"3\",\"chance\":\"10000\"},{\"id\":\"2323\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2153\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2176\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2184\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2447\",\"count\":1,\"chance\":\"100\"}]'),
(141, 0, 'Tiquandas Revenge', 0, 2635, 1800, 110, 0, '[]', '[\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2792\",\"count\":\"5\",\"chance\":\"25000\"},{\"id\":\"2671\",\"count\":\"2\",\"chance\":\"50000\"},{\"id\":\"2666\",\"count\":\"4\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"28\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"90\",\"chance\":\"100000\"}]'),
(142, 0, 'Thalas', 0, 2950, 4100, 20, 0, '[\"You will become a feast for my maggots.\",\"Death and decay!\",\"Death awaits you.\",\"Your precious life will be wasted.\",\"Red is my favourite color.\",\"Flesssh to dussst!\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2351\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"85\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"95\",\"chance\":\"35000\"},{\"id\":\"2149\",\"count\":\"3\",\"chance\":\"10000\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2409\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2451\",\"count\":1,\"chance\":\"1500\"}]'),
(143, 0, 'The Evil Eye', 0, 1500, 1200, 10, 0, '[\"653768764!\",\"Let me take a look at you!\",\"Inferior creatures, bow before my power!\",\"659978 54764!\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"24\",\"chance\":\"90000\"},{\"id\":\"2148\",\"count\":\"32\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"70000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2394\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2518\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2512\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"5000\"}]'),
(144, 0, 'The Horned Fox', 0, 200, 265, 1, 0, '[\"You will never get me!\",\"I\'ll be back!\",\"Catch me, if you can!\",\"Help me, boys!\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"60000\"},{\"id\":\"2502\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2648\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2388\",\"count\":1,\"chance\":\"9000\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2580\",\"count\":1,\"chance\":\"5000\"}]'),
(145, 0, 'The Old Widow', 0, 2800, 3550, 10, 0, '[]', '[\"lifedrain\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"66\",\"chance\":\"99900\"},{\"id\":\"2148\",\"count\":\"22\",\"chance\":\"99900\"},{\"id\":\"2148\",\"count\":\"77\",\"chance\":\"66600\"},{\"id\":\"2457\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"600\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"16000\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"600\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"200\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"1400\"}]'),
(146, 0, 'Vashresamun', 0, 2950, 4000, 45, 0, '[\"Heheheheee!\",\"Come my maidens, we have visitors!\",\"Are you enjoying my music?\",\"Dance a dance of death for me!\",\"If music is the food of death, drop dead.\",\"Chakka Chakka!\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2349\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"70000\"},{\"id\":\"2148\",\"count\":\"85\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"95\",\"chance\":\"35000\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2072\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2074\",\"count\":1,\"chance\":\"200\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2139\",\"count\":1,\"chance\":\"100\"},{\"id\":\"1987\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2445\",\"count\":1,\"chance\":\"100\"}]');

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_news`
--

CREATE TABLE `myaac_news` (
  `id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - news, 2 - ticker, 3 - article',
  `date` int NOT NULL DEFAULT '0',
  `category` tinyint(1) NOT NULL DEFAULT '0',
  `player_id` int NOT NULL DEFAULT '0',
  `last_modified_by` int NOT NULL DEFAULT '0',
  `last_modified_date` int NOT NULL DEFAULT '0',
  `comments` varchar(50) NOT NULL DEFAULT '',
  `article_text` varchar(300) NOT NULL DEFAULT '',
  `article_image` varchar(100) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_news`
--

INSERT INTO `myaac_news` (`id`, `title`, `body`, `type`, `date`, `category`, `player_id`, `last_modified_by`, `last_modified_date`, `comments`, `article_text`, `article_image`, `hidden`) VALUES
(1, 'Retronia Opening', '<p style=\"text-align: center;\"><span style=\"box-sizing: border-box; font-weight: bold; color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px; text-align: center;\"><span style=\"box-sizing: border-box; font-size: 22px;\"><a style=\"box-sizing: border-box; color: #185886; outline: 0px; font-size: 15px; font-weight: 400;\" href=\"https://otland.net/attachments/1500x370px_com_bandeira-jpg.78035/\" target=\"_blank\" rel=\"noopener\"><img class=\"bbImage \" style=\"box-sizing: border-box; border-style: none; max-width: 100%; height: auto; filter: -opera-shader(shader(url(\'data:text/plain;base64,dW5pZm9ybSBzaGFkZXIgaUNodW5rOwp1bmlmb3JtIGZsb2F0MiBpQ2h1bmtTaXplOwoKY29uc3QgZmxvYXQgVEhSRVNIT0xEX0FSRUEgPSA4MDAgKiA2MDA7CmNvbnN0IGZsb2F0IE1JTl9BUkVBID0gNDAwICogMTAwOwpjb25zdCBmbG9hdCBNSU5fU1RSSVAgPSAyMDsKY29uc3QgZmxvYXQgTUFSR0lOID0gMTsKCmhhbGYzIHBpeGVsKGNvbnN0IGludCB4LCBjb25zdCBpbnQgeSwgaW4gaGFsZjIgeHkpCnsKCXJldHVybiBpQ2h1bmsuZXZhbCh4eSArIGhhbGYyKHgsIHkpKS5yZ2I7Cn0gIAoKaGFsZjMgUkdYKGhhbGYyIHh5KXsKCWhhbGYzIGYgPQoJcGl4ZWwoLTEsLTEsIHh5KSAqICAxLiArICAgICAgICAgICAgICAgICAgICAgCglwaXhlbCggMCwtMSwgeHkpICogLTEuICsgICAgICAgICAgICAgICAgICAgIAoJcGl4ZWwoIDEsLTEsIHh5KSAqICAxLiArCgkKCXBpeGVsKC0xLCAwLCB4eSkgKiAtMS4gKyAgICAgICAgICAgICAgICAgICAgCglwaXhlbCggMCwgMCwgeHkpICogLTIuICsgICAgICAgICAgICAgICAgICAgICAKCXBpeGVsKCAxLCAwLCB4eSkgKiAtMS4gKyAgICAgICAgICAgICAgICAgICAgIAoJCglwaXhlbCgtMSwgMSwgeHkpICogIDEuICsgICAgICAgICAgICAgICAgICAgICAKCXBpeGVsKCAwLCAxLCB4eSkgKiAtMS4gKyAgICAgICAgICAgICAgICAgICAgIAoJcGl4ZWwoIDEsIDEsIHh5KSAqICAxLgoJOwoJcmV0dXJuIGYgLyAtMjsKfQoKaGFsZjMgUkdYTW9yZShoYWxmMiB4eSl7CgloYWxmMyBmID0KCXBpeGVsKC0xLC0xLCB4eSkgKiAgMS4gKyAgICAgICAgICAgICAgICAgICAgIAoJcGl4ZWwoIDAsLTEsIHh5KSAqIC0xLiArICAgICAgICAgICAgICAgICAgICAKCXBpeGVsKCAxLC0xLCB4eSkgKiAgMS4gKwoJCglwaXhlbCgtMSwgMCwgeHkpICogLTEuICsgICAgICAgICAgICAgICAgICAgIAoJcGl4ZWwoIDAsIDAsIHh5KSAqIC0xLiArICAgICAgICAgICAgICAgICAgICAgCglwaXhlbCggMSwgMCwgeHkpICogLTEuICsgICAgICAgICAgICAgICAgICAgICAKCQoJcGl4ZWwoLTEsIDEsIHh5KSAqICAxLiArICAgICAgICAgICAgICAgICAgICAgCglwaXhlbCggMCwgMSwgeHkpICogLTEuICsgICAgICAgICAgICAgICAgICAgICAKCXBpeGVsKCAxLCAxLCB4eSkgKiAgMS4gCgk7CglyZXR1cm4gZiAvIC0xOwp9CgoKaGFsZjQgbWFpbihmbG9hdDIgeHkpCnsKCWhhbGY0IGNvbG9yID0gaUNodW5rLmV2YWwoeHkpOwoJCglpZiAoY29sb3IuYSA8IDEpIHsKCQlyZXR1cm4gY29sb3I7Cgl9CgkKCWlmIChpQ2h1bmtTaXplLnggKiBpQ2h1bmtTaXplLnkgPCBNSU5fQVJFQSkgewoJCXJldHVybiBjb2xvcjsKCX0KCglpZiAoaUNodW5rU2l6ZS55IDwgTUlOX1NUUklQIHx8IGlDaHVua1NpemUueCA8IE1JTl9TVFJJUCkgewoJCXJldHVybiBjb2xvcjsKCX0KCglpZiAoeHkueCA8IE1BUkdJTiB8fCB4eS54ID4gKGlDaHVua1NpemUueCAtIE1BUkdJTikgfHwKCSAgICB4eS55IDwgTUFSR0lOIHx8IHh5LnkgPiAoaUNodW5rU2l6ZS55IC0gTUFSR0lOKSkgewogICAgCXJldHVybiBjb2xvcjsgICAgCiAgICB9CgkKCWlmIChpQ2h1bmtTaXplLnggKiBpQ2h1bmtTaXplLnkgPiBUSFJFU0hPTERfQVJFQSkgewoJCWNvbG9yID0gaGFsZjQoUkdYTW9yZSh4eSksIDEpOwoJfSBlbHNlIHsKCQljb2xvciA9IGhhbGY0KFJHWCh4eSksIDEpOwoJfQoKCXJldHVybiBjb2xvcjsKfQo=\') ));\" title=\"1500x370px_Com_Bandeira.jpg\" src=\"https://static3.otland.net/d/attachments/69/69604-bf6f169c62a2dab48e6d4df750adc33c.jpg\" alt=\"1500x370px_Com_Bandeira.jpg\" width=\"1014\" height=\"250\" /></a></span></span><span style=\"box-sizing: border-box; font-weight: bold; color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px; text-align: center;\"><span style=\"box-sizing: border-box; font-size: 22px;\"><br style=\"box-sizing: border-box; font-size: 15px; font-weight: 400; background-color: #fefefe;\" /></span></span></p>\r\n<p style=\"text-align: center;\"><span style=\"box-sizing: border-box; font-weight: bold; color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px; text-align: center;\"><span style=\"box-sizing: border-box; font-size: 22px;\">September 19GMT, 1:00 CEST</span></span></p>\r\n<p style=\"text-align: center;\"><span style=\"box-sizing: border-box; font-weight: bold; color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px; text-align: center;\"><span style=\"box-sizing: border-box; font-size: 22px;\"><span style=\"box-sizing: border-box; font-size: 15px;\"><span style=\"box-sizing: border-box; font-size: 22px;\"><a style=\"box-sizing: border-box; color: #2577b1; text-decoration-line: none;\" href=\"https://otland.net/attachments/menu-box-item-png.78040/\" target=\"_blank\" rel=\"noopener\"><img class=\"bbImage \" style=\"box-sizing: border-box; border-style: none; max-width: 100%; height: auto; filter: -opera-shader(shader(url(\'data:text/plain;base64,dW5pZm9ybSBzaGFkZXIgaUNodW5rOwp1bmlmb3JtIGZsb2F0MiBpQ2h1bmtTaXplOwoKY29uc3QgZmxvYXQgVEhSRVNIT0xEX0FSRUEgPSA4MDAgKiA2MDA7CmNvbnN0IGZsb2F0IE1JTl9BUkVBID0gNDAwICogMTAwOwpjb25zdCBmbG9hdCBNSU5fU1RSSVAgPSAyMDsKY29uc3QgZmxvYXQgTUFSR0lOID0gMTsKCmhhbGYzIHBpeGVsKGNvbnN0IGludCB4LCBjb25zdCBpbnQgeSwgaW4gaGFsZjIgeHkpCnsKCXJldHVybiBpQ2h1bmsuZXZhbCh4eSArIGhhbGYyKHgsIHkpKS5yZ2I7Cn0gIAoKaGFsZjMgUkdYKGhhbGYyIHh5KXsKCWhhbGYzIGYgPQoJcGl4ZWwoLTEsLTEsIHh5KSAqICAxLiArICAgICAgICAgICAgICAgICAgICAgCglwaXhlbCggMCwtMSwgeHkpICogLTEuICsgICAgICAgICAgICAgICAgICAgIAoJcGl4ZWwoIDEsLTEsIHh5KSAqICAxLiArCgkKCXBpeGVsKC0xLCAwLCB4eSkgKiAtMS4gKyAgICAgICAgICAgICAgICAgICAgCglwaXhlbCggMCwgMCwgeHkpICogLTIuICsgICAgICAgICAgICAgICAgICAgICAKCXBpeGVsKCAxLCAwLCB4eSkgKiAtMS4gKyAgICAgICAgICAgICAgICAgICAgIAoJCglwaXhlbCgtMSwgMSwgeHkpICogIDEuICsgICAgICAgICAgICAgICAgICAgICAKCXBpeGVsKCAwLCAxLCB4eSkgKiAtMS4gKyAgICAgICAgICAgICAgICAgICAgIAoJcGl4ZWwoIDEsIDEsIHh5KSAqICAxLgoJOwoJcmV0dXJuIGYgLyAtMjsKfQoKaGFsZjMgUkdYTW9yZShoYWxmMiB4eSl7CgloYWxmMyBmID0KCXBpeGVsKC0xLC0xLCB4eSkgKiAgMS4gKyAgICAgICAgICAgICAgICAgICAgIAoJcGl4ZWwoIDAsLTEsIHh5KSAqIC0xLiArICAgICAgICAgICAgICAgICAgICAKCXBpeGVsKCAxLC0xLCB4eSkgKiAgMS4gKwoJCglwaXhlbCgtMSwgMCwgeHkpICogLTEuICsgICAgICAgICAgICAgICAgICAgIAoJcGl4ZWwoIDAsIDAsIHh5KSAqIC0xLiArICAgICAgICAgICAgICAgICAgICAgCglwaXhlbCggMSwgMCwgeHkpICogLTEuICsgICAgICAgICAgICAgICAgICAgICAKCQoJcGl4ZWwoLTEsIDEsIHh5KSAqICAxLiArICAgICAgICAgICAgICAgICAgICAgCglwaXhlbCggMCwgMSwgeHkpICogLTEuICsgICAgICAgICAgICAgICAgICAgICAKCXBpeGVsKCAxLCAxLCB4eSkgKiAgMS4gCgk7CglyZXR1cm4gZiAvIC0xOwp9CgoKaGFsZjQgbWFpbihmbG9hdDIgeHkpCnsKCWhhbGY0IGNvbG9yID0gaUNodW5rLmV2YWwoeHkpOwoJCglpZiAoY29sb3IuYSA8IDEpIHsKCQlyZXR1cm4gY29sb3I7Cgl9CgkKCWlmIChpQ2h1bmtTaXplLnggKiBpQ2h1bmtTaXplLnkgPCBNSU5fQVJFQSkgewoJCXJldHVybiBjb2xvcjsKCX0KCglpZiAoaUNodW5rU2l6ZS55IDwgTUlOX1NUUklQIHx8IGlDaHVua1NpemUueCA8IE1JTl9TVFJJUCkgewoJCXJldHVybiBjb2xvcjsKCX0KCglpZiAoeHkueCA8IE1BUkdJTiB8fCB4eS54ID4gKGlDaHVua1NpemUueCAtIE1BUkdJTikgfHwKCSAgICB4eS55IDwgTUFSR0lOIHx8IHh5LnkgPiAoaUNodW5rU2l6ZS55IC0gTUFSR0lOKSkgewogICAgCXJldHVybiBjb2xvcjsgICAgCiAgICB9CgkKCWlmIChpQ2h1bmtTaXplLnggKiBpQ2h1bmtTaXplLnkgPiBUSFJFU0hPTERfQVJFQSkgewoJCWNvbG9yID0gaGFsZjQoUkdYTW9yZSh4eSksIDEpOwoJfSBlbHNlIHsKCQljb2xvciA9IGhhbGY0KFJHWCh4eSksIDEpOwoJfQoKCXJldHVybiBjb2xvcjsKfQo=\') ));\" title=\"menu-box-item.png\" src=\"https://static3.otland.net/d/attachments/69/69609-7ea2f3c3c4b39b59239a4eedef85c5d0.jpg\" alt=\"menu-box-item.png\" width=\"262\" height=\"1\" /></a></span></span></span></span></p>\r\n<p><span style=\"box-sizing: border-box; font-weight: bold; color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">Retronia Online</span><span style=\"color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">&nbsp;will not be just another server with sprites changed to look like 7.4.&nbsp;</span><span style=\"box-sizing: border-box; font-weight: bold; color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">Retronia Online</span><span style=\"color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">&nbsp;is a proposal for a server that will work with a lot of Reverse Engineering of CipSoft for the replication of all&nbsp;</span>Mechanics<span style=\"color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">,&nbsp;</span>Behaviors, Interactions,&nbsp;Monster AI&nbsp;,&nbsp;Damage Formulas&nbsp;and&nbsp;Every Detail of the 7.4 World Map,<span style=\"color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">&nbsp;we will have every smallest detail of operation replicated, even the smallest details that players don\'t even want to remember or because they are used to play other \"</span>7.4<span style=\"color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">\".</span><br style=\"box-sizing: border-box; color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px; background-color: #fefefe;\" /><span style=\"color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">We will also have our own Features and Contents for an experience that is not only&nbsp;</span><em>Nostalgic&nbsp;</em><span style=\"color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">but also&nbsp;</span><em>New Experiences</em><span style=\"color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">!</span></p>\r\n<p>After 3 years since we started this project and also with very little time that we decided to expose ourselves in the Tibian community, we are finally encouraged to put our proposal into practice!<br />We focus on&nbsp;Longevity, WITHOUT RESETS, with 1x Rates, without Tasks, without Exp Share and with Hosting in Brazil and with the aim of offering, in the near future, a proxy for other locations!</p>\r\n<p><span style=\"box-sizing: border-box; font-weight: bold; color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">Retronia Online</span><span style=\"color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\">&nbsp;will not tolerate cheating and use of BOT and other unofficial softwares to play.</span></p>\r\n<p><span style=\"color: #141414; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px;\"><a style=\"box-sizing: border-box; background-color: #fefefe; color: #2577b1; text-decoration-line: none; outline: 0px; text-align: center;\" href=\"https://otland.net/attachments/menu-box-item-png.78040/\" target=\"_blank\" rel=\"noopener\"><img class=\"bbImage \" style=\"box-sizing: border-box; border-style: none; max-width: 100%; height: auto; display: block; margin-left: auto; margin-right: auto;\" title=\"menu-box-item.png\" src=\"https://static3.otland.net/d/attachments/69/69609-7ea2f3c3c4b39b59239a4eedef85c5d0.jpg\" alt=\"menu-box-item.png\" width=\"262\" height=\"1\" /></a></span></p>\r\n<p><em>Some Features of&nbsp;<strong>Retronia Online</strong>:</em></p>\r\n<ul>\r\n<li data-xf-list-type=\"ul\">Exclusives Addons and Exclusives Outfits</li>\r\n<li data-xf-list-type=\"ul\">HD Sprites 64x64</li>\r\n<li data-xf-list-type=\"ul\">MiniMap HD</li>\r\n<li data-xf-list-type=\"ul\">New Monsters</li>\r\n<li data-xf-list-type=\"ul\">New Custom Map Area</li>\r\n<li data-xf-list-type=\"ul\">Differentiation in Game Play between; Knights One/Two Handed Weapons | Paladins Bow/Crossbow</li>\r\n<li data-xf-list-type=\"ul\">Rarity Item System</li>\r\n<li data-xf-list-type=\"ul\">Loot Analyzer</li>\r\n<li data-xf-list-type=\"ul\">Quivers System</li>\r\n<li data-xf-list-type=\"ul\">Training Dumy System</li>\r\n<li data-xf-list-type=\"ul\">NPC Trade Module</li>\r\n<li data-xf-list-type=\"ul\">Ingame Store with Physical Coin Transfers and Deposits</li>\r\n<li data-xf-list-type=\"ul\">ToolTip and Linked Items on Chat</li>\r\n</ul>\r\n<p style=\"text-align: center;\"><a style=\"box-sizing: border-box; color: #2577b1; text-decoration-line: none; font-family: \'Segoe UI\', \'Helvetica Neue\', Helvetica, Roboto, Oxygen, Ubuntu, Cantarell, \'Fira Sans\', \'Droid Sans\', sans-serif; font-size: 15px; text-align: center;\" href=\"https://otland.net/attachments/menu-box-item-png.78040/\" target=\"_blank\" rel=\"noopener\"><img class=\"bbImage \" style=\"box-sizing: border-box; border-style: none; max-width: 100%; height: auto; display: block; margin-left: auto; margin-right: auto;\" title=\"menu-box-item.png\" src=\"https://static3.otland.net/d/attachments/69/69609-7ea2f3c3c4b39b59239a4eedef85c5d0.jpg\" alt=\"menu-box-item.png\" width=\"262\" height=\"1\" /></a></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\">&nbsp;</p>', 1, 1675523240, 2, 5, 1, 1693503113, 'https://my-aac.org', '', 'images/news/announcement.jpg', 0),
(2, 'Hello tickets!', 'https://my-aac.org', 2, 1675523240, 4, 5, 0, 0, '', '', '', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_news_categories`
--

CREATE TABLE `myaac_news_categories` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL DEFAULT '',
  `icon_id` int NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_news_categories`
--

INSERT INTO `myaac_news_categories` (`id`, `name`, `description`, `icon_id`, `hidden`) VALUES
(1, '', '', 0, 0),
(2, '', '', 1, 0),
(3, '', '', 2, 0),
(4, '', '', 3, 0),
(5, '', '', 4, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_notepad`
--

CREATE TABLE `myaac_notepad` (
  `id` int NOT NULL,
  `account_id` int NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_pages`
--

CREATE TABLE `myaac_pages` (
  `id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `title` varchar(30) NOT NULL,
  `body` text NOT NULL,
  `date` int NOT NULL DEFAULT '0',
  `player_id` int NOT NULL DEFAULT '0',
  `php` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - plain html, 1 - php',
  `enable_tinymce` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - enabled, 0 - disabled',
  `access` tinyint NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_pages`
--

INSERT INTO `myaac_pages` (`id`, `name`, `title`, `body`, `date`, `player_id`, `php`, `enable_tinymce`, `access`, `hidden`) VALUES
(1, 'downloads', 'Downloads', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<div style=\"text-align: center;\">We\'re using official Tibia Client <strong>{{ config.client / 100 }}</strong><br />\n<p>Download Tibia Client <strong>{{ config.client / 100 }}</strong>&nbsp;for Windows <a href=\"https://drive.google.com/drive/folders/0B2-sMQkWYzhGSFhGVlY2WGk5czQ\" target=\"_blank\" rel=\"noopener\">HERE</a>.</p>\n<h2>IP Changer:</h2>\n<a href=\"https://static.otland.net/ipchanger.exe\" target=\"_blank\" rel=\"noopener\">HERE</a></div>', 0, 1, 0, 1, 1, 0),
(2, 'commands', 'Commands', '<table style=\"border-collapse: collapse; width: 87.8471%; height: 57px;\" border=\"1\">\n<tbody>\n<tr style=\"height: 18px;\">\n<td style=\"width: 33.3333%; background-color: #505050; height: 18px;\"><span style=\"color: #ffffff;\"><strong>Words</strong></span></td>\n<td style=\"width: 33.3333%; background-color: #505050; height: 18px;\"><span style=\"color: #ffffff;\"><strong>Description</strong></span></td>\n</tr>\n<tr style=\"height: 18px; background-color: #f1e0c6;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!example</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">This is just an example</td>\n</tr>\n<tr style=\"height: 18px; background-color: #d4c0a1;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!buyhouse</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">Buy house you are looking at</td>\n</tr>\n<tr style=\"height: 18px; background-color: #f1e0c6;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!aol</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">Buy AoL</td>\n</tr>\n</tbody>\n</table>', 0, 1, 0, 1, 1, 0),
(3, 'rules_on_the_page', 'Rules', '1. Names\na) Names which contain insulting (e.g. \"Bastard\"), racist (e.g. \"Nigger\"), extremely right-wing (e.g. \"Hitler\"), sexist (e.g. \"Bitch\") or offensive (e.g. \"Copkiller\") language.\nb) Names containing parts of sentences (e.g. \"Mike returns\"), nonsensical combinations of letters (e.g. \"Fgfshdsfg\") or invalid formattings (e.g. \"Thegreatknight\").\nc) Names that obviously do not describe a person (e.g. \"Christmastree\", \"Matrix\"), names of real life celebrities (e.g. \"Britney Spears\"), names that refer to real countries (e.g. \"Swedish Druid\"), names which were created to fake other players\' identities (e.g. \"Arieswer\" instead of \"Arieswar\") or official positions (e.g. \"System Admin\").\n\n2. Cheating\na) Exploiting obvious errors of the game (\"bugs\"), for instance to duplicate items. If you find an error you must report it to CipSoft immediately.\nb) Intentional abuse of weaknesses in the gameplay, for example arranging objects or players in a way that other players cannot move them.\nc) Using tools to automatically perform or repeat certain actions without any interaction by the player (\"macros\").\nd) Manipulating the client program or using additional software to play the game.\ne) Trying to steal other players\' account data (\"hacking\").\nf) Playing on more than one account at the same time (\"multi-clienting\").\ng) Offering account data to other players or accepting other players\' account data (\"account-trading/sharing\").\n\n3. Gamemasters\na) Threatening a gamemaster because of his or her actions or position as a gamemaster.\nb) Pretending to be a gamemaster or to have influence on the decisions of a gamemaster.\nc) Intentionally giving wrong or misleading information to a gamemaster concerning his or her investigations or making false reports about rule violations.\n\n4. Player Killing\na) Excessive killing of characters who are not marked with a \"skull\" on worlds which are not PvP-enforced. Please note that killing marked characters is not a reason for a banishment.\n\nA violation of the Tibia Rules may lead to temporary banishment of characters and accounts. In severe cases removal or modification of character skills, attributes and belongings, as well as the permanent removal of accounts without any compensation may be considered. The sanction is based on the seriousness of the rule violation and the previous record of the player. It is determined by the gamemaster imposing the banishment.\n\nThese rules may be changed at any time. All changes will be announced on the official website.', 0, 1, 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_spells`
--

CREATE TABLE `myaac_spells` (
  `id` int NOT NULL,
  `spell` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL,
  `words` varchar(255) NOT NULL DEFAULT '',
  `category` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - attack, 2 - healing, 3 - summon, 4 - supply, 5 - support',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - instant, 2 - conjure, 3 - rune',
  `level` int NOT NULL DEFAULT '0',
  `maglevel` int NOT NULL DEFAULT '0',
  `mana` int NOT NULL DEFAULT '0',
  `soul` tinyint NOT NULL DEFAULT '0',
  `conjure_id` int NOT NULL DEFAULT '0',
  `conjure_count` tinyint NOT NULL DEFAULT '0',
  `reagent` int NOT NULL DEFAULT '0',
  `item_id` int NOT NULL DEFAULT '0',
  `premium` tinyint(1) NOT NULL DEFAULT '0',
  `vocations` varchar(100) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_spells`
--

INSERT INTO `myaac_spells` (`id`, `spell`, `name`, `words`, `category`, `type`, `level`, `maglevel`, `mana`, `soul`, `conjure_id`, `conjure_count`, `reagent`, `item_id`, `premium`, `vocations`, `hidden`) VALUES
(1, '', 'Light', 'utevo lux', 0, 1, 8, 0, 20, 0, 0, 0, 0, 0, 0, '[]', 0),
(2, '', 'Find Person', 'exiva', 0, 1, 8, 0, 20, 0, 0, 0, 0, 0, 0, '[]', 0),
(3, '', 'Magic Rope', 'exani tera', 0, 1, 9, 0, 20, 0, 0, 0, 0, 0, 0, '[]', 0),
(4, '', 'Light Healing', 'exura', 0, 1, 9, 0, 25, 0, 0, 0, 0, 0, 0, '[]', 0),
(5, '', 'Antidote', 'exana pox', 0, 1, 10, 0, 30, 0, 0, 0, 0, 0, 0, '[]', 0),
(6, '', 'Intense Healing', 'exura gran', 0, 1, 11, 0, 40, 0, 0, 0, 0, 0, 0, '[1,5,2,6,3,7]', 0),
(7, '', 'Levitate', 'exani hur', 0, 1, 12, 0, 50, 0, 0, 0, 0, 0, 1, '[]', 0),
(8, '', 'Energy Strike', 'exori vis', 0, 1, 11, 0, 20, 0, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(9, '', 'Summon Creature', 'utevo res', 0, 1, 25, 0, 0, 0, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(10, '', 'Great Light', 'utevo gran lux', 0, 1, 13, 0, 60, 0, 0, 0, 0, 0, 0, '[]', 0),
(11, '', 'Magic Shield', 'utamo vita', 0, 1, 14, 0, 50, 0, 0, 0, 0, 0, 0, '[1,5,2,6,3,7]', 0),
(12, '', 'Haste', 'utani hur', 0, 1, 14, 0, 60, 0, 0, 0, 0, 0, 1, '[]', 0),
(13, '', 'Flame Strike', 'exori flam', 0, 1, 12, 0, 20, 0, 0, 0, 0, 0, 1, '[1,5,2,6]', 0),
(14, '', 'Force Strike', 'exori mort', 0, 1, 11, 0, 20, 0, 0, 0, 0, 0, 1, '[1,5,2,6]', 0),
(15, '', 'Fire Wave', 'exevo flam hur', 0, 1, 18, 0, 80, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(16, '', 'Heal Friend', 'exura sio', 0, 1, 18, 0, 70, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(17, '', 'Ultimate Healing', 'exura vita', 0, 1, 20, 0, 160, 0, 0, 0, 0, 0, 0, '[1,5,2,6,3,7]', 0),
(18, '', 'Strong Haste', 'utani gran hur', 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 1, '[1,5,2,6]', 0),
(19, '', 'Challenge', 'exeta res', 0, 1, 20, 0, 30, 0, 0, 0, 0, 0, 1, '[8]', 0),
(20, '', 'Energy Beam', 'exevo vis lux', 0, 1, 23, 0, 100, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(21, '', 'Creature Illusion', 'utevo res ina', 0, 1, 23, 0, 100, 0, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(22, '', 'Cancel Invisibility', 'exana ina', 0, 1, 26, 0, 200, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(23, '', 'Ultimate Light', 'utevo vis lux', 0, 1, 26, 0, 140, 0, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(24, '', 'Great Energy Beam', 'exevo gran vis lux', 0, 1, 29, 0, 200, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(25, '', 'Berserk', 'exori', 0, 1, 35, 0, 0, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(26, '', 'Invisibility', 'utana vid', 0, 1, 35, 0, 440, 0, 0, 0, 0, 0, 1, '[1,5,2,6,3,7]', 0),
(27, '', 'Mass Healing', 'exura gran mas res', 0, 1, 36, 0, 150, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(28, '', 'Undead Legion', 'exana mas mort', 0, 1, 30, 0, 500, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(29, '', 'Ultimate Explosion', 'exevo gran mas vis', 0, 1, 60, 0, 1200, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(30, '', 'Poison Storm', 'exevo gran mas pox', 0, 1, 50, 0, 600, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(31, '', 'Energy Wave', 'exevo mort hur', 0, 1, 38, 0, 250, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(32, '', 'Wild Growth', 'exevo grav vita', 0, 1, 27, 0, 220, 0, 0, 0, 0, 0, 1, '[6]', 0),
(33, '', 'Food', 'exevo pan', 0, 1, 14, 0, 120, 1, 0, 0, 0, 0, 0, '[2,6,3,7]', 0),
(34, '', 'Animate Dead Rune', 'adana mort', 0, 1, 0, 0, 600, 5, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(35, '', 'Blank Rune', 'adori blank', 0, 1, 0, 0, 50, 1, 0, 0, 0, 0, 0, '[2,6,3,7,1,5]', 0),
(36, '', 'Chameleon Rune', 'adevo ina', 0, 1, 0, 0, 600, 2, 0, 0, 0, 0, 0, '[2,6]', 0),
(37, '', 'Conjure Arrow', 'exevo con', 0, 1, 0, 0, 100, 1, 0, 0, 0, 0, 0, '[3,7]', 0),
(38, '', 'Conjure Bolt', 'exevo con mort', 0, 1, 0, 0, 140, 2, 0, 0, 0, 0, 0, '[3,7]', 0),
(39, '', 'Conjure Explosive Arrow', 'exevo con flam', 0, 1, 0, 0, 290, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(40, '', 'Conjure Poisoned Arrow', 'exevo con pox', 0, 1, 0, 0, 130, 2, 0, 0, 0, 0, 0, '[3,7]', 0),
(41, '', 'Conjure Power Bolt', 'exevo con vis', 0, 1, 0, 0, 700, 4, 0, 0, 0, 0, 0, '[7]', 0),
(42, '', 'Convince Creature Rune', 'adeta sio', 0, 1, 0, 0, 200, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(43, '', 'Cure Poison Rune', 'adana pox', 0, 1, 0, 0, 200, 1, 0, 0, 0, 0, 0, '[2,6]', 0),
(44, '', 'Destroy Field Rune', 'adito grav', 0, 1, 0, 0, 120, 2, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(45, '', 'Disintegrate Rune', 'adito tera', 0, 1, 0, 0, 200, 3, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(46, '', 'Enchant Staff', 'exeta vis', 0, 1, 0, 0, 80, 0, 0, 0, 0, 0, 0, '[5]', 0),
(47, '', 'Energy Bomb Rune', 'adevo mas vis', 0, 1, 0, 0, 880, 5, 0, 0, 0, 0, 0, '[1,5]', 0),
(48, '', 'Energy Field Rune', 'adevo grav vis', 0, 1, 0, 0, 320, 2, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(49, '', 'Energy Wall Rune', 'adevo mas grav vis', 0, 1, 0, 0, 1000, 5, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(50, '', 'Explosion Rune', 'adevo mas hur', 0, 1, 0, 0, 570, 4, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(51, '', 'Fire Field Rune', 'adevo grav flam', 0, 1, 0, 0, 240, 1, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(52, '', 'Fire Bomb Rune', 'adevo mas flam', 0, 1, 0, 0, 600, 4, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(53, '', 'Fire Wall Rune', 'adevo mas grav flam', 0, 1, 0, 0, 780, 4, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(54, '', 'Fireball Rune', 'adori flam', 0, 1, 0, 0, 460, 3, 0, 0, 0, 0, 0, '[1,5]', 0),
(55, '', 'Great Fireball Rune', 'adori gran flam', 0, 1, 0, 0, 530, 3, 0, 0, 0, 0, 0, '[1,5]', 0),
(56, '', 'Heavy Magic Missile Rune', 'adori gran', 0, 1, 0, 0, 350, 2, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(57, '', 'Intense Healing Rune', 'adura gran', 0, 1, 0, 0, 120, 2, 0, 0, 0, 0, 0, '[2,6]', 0),
(58, '', 'Light Magic Missile Rune', 'adori', 0, 1, 0, 0, 120, 1, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(59, '', 'Magic Wall Rune', 'adevo grav tera', 0, 1, 0, 0, 750, 5, 0, 0, 0, 0, 0, '[1,5]', 0),
(60, '', 'Paralyze Rune', 'adana ani', 0, 1, 0, 0, 1400, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(61, '', 'Poison Bomb Rune', 'adevo mas pox', 0, 1, 0, 0, 520, 2, 0, 0, 0, 0, 0, '[2,6]', 0),
(62, '', 'Poison Field Rune', 'adevo grav pox', 0, 1, 0, 0, 200, 1, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(63, '', 'Poison Wall Rune', 'adevo mas grav pox', 0, 1, 0, 0, 640, 3, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(64, '', 'Soulfire Rune', 'adevo res flam', 0, 1, 0, 0, 420, 3, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(65, '', 'Stalagmite Rune', 'adevo res pox', 0, 1, 0, 0, 350, 2, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(66, '', 'Sudden Death Rune', 'adori vita vis', 0, 1, 0, 0, 985, 5, 0, 0, 0, 0, 0, '[1,5]', 0),
(67, '', 'Ultimate Healing Rune', 'adura vita', 0, 1, 0, 0, 400, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(68, '', 'House Door List', 'aleta grav', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(69, '', 'House Guest List', 'aleta sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(70, '', 'House Kick', 'alana sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(71, '', 'House Subowner List', 'aleta som', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(72, '', 'adevo grav pox Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2285, 0, '[]', 0),
(73, '', 'adura gran Rune', '', 0, 3, 0, 1, 0, 0, 0, 0, 0, 2265, 0, '[]', 0),
(74, '', 'adana pox Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2266, 0, '[]', 0),
(75, '', 'adori Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2287, 0, '[]', 0),
(76, '', 'adevo grav flam Rune', '', 0, 3, 0, 1, 0, 0, 0, 0, 0, 2301, 0, '[]', 0),
(77, '', 'adeta sio Rune', '', 0, 3, 0, 5, 0, 0, 0, 0, 0, 2290, 0, '[]', 0),
(78, '', 'adito grav Rune', '', 0, 3, 0, 3, 0, 0, 0, 0, 0, 2261, 0, '[]', 0),
(79, '', 'adevo grav vis Rune', '', 0, 3, 0, 3, 0, 0, 0, 0, 0, 2277, 0, '[]', 0),
(80, '', 'adito tera Rune', '', 0, 3, 0, 4, 0, 0, 0, 0, 0, 2310, 0, '[]', 0),
(81, '', 'adura vita Rune', '', 0, 3, 0, 4, 0, 0, 0, 0, 0, 2273, 0, '[]', 0),
(82, '', 'adori gran Rune', '', 0, 3, 0, 3, 0, 0, 0, 0, 0, 2311, 0, '[]', 0),
(83, '', 'adevo mas pox Rune', '', 0, 3, 0, 4, 0, 0, 0, 0, 0, 2286, 0, '[]', 0),
(84, '', 'adevo mas flam Rune', '', 0, 3, 0, 5, 0, 0, 0, 0, 0, 2305, 0, '[]', 0),
(85, '', 'adevo res flam Rune', '', 0, 3, 0, 7, 0, 0, 0, 0, 0, 2308, 0, '[]', 0),
(86, '', 'adevo ina Rune', '', 0, 3, 0, 4, 0, 0, 0, 0, 0, 2291, 0, '[]', 0),
(87, '', 'adori flam Rune', '', 0, 3, 0, 4, 0, 0, 0, 0, 0, 2302, 0, '[]', 0),
(88, '', 'adana mort Rune', '', 0, 3, 0, 4, 0, 0, 0, 0, 0, 2316, 0, '[]', 0),
(89, '', 'adevo mas grav pox Rune', '', 0, 3, 0, 5, 0, 0, 0, 0, 0, 2289, 0, '[]', 0),
(90, '', 'adori gran flam Rune', '', 0, 3, 0, 4, 0, 0, 0, 0, 0, 2304, 0, '[]', 0),
(91, '', 'adevo mas hur Rune', '', 0, 3, 0, 6, 0, 0, 0, 0, 0, 2313, 0, '[]', 0),
(92, '', 'adevo grav tera Rune', '', 0, 3, 0, 9, 0, 0, 0, 0, 0, 2293, 0, '[]', 0),
(93, '', 'adevo mas grav flam Rune', '', 0, 3, 0, 6, 0, 0, 0, 0, 0, 2303, 0, '[]', 0),
(94, '', 'adevo mas vis Rune', '', 0, 3, 0, 10, 0, 0, 0, 0, 0, 2262, 0, '[]', 0),
(95, '', 'adevo mas grav vis Rune', '', 0, 3, 0, 9, 0, 0, 0, 0, 0, 2279, 0, '[]', 0),
(96, '', 'adori vita vis Rune', '', 0, 3, 0, 15, 0, 0, 0, 0, 0, 2268, 0, '[]', 0),
(97, '', 'adevo res pox Rune', '', 0, 3, 0, 4, 0, 0, 0, 0, 0, 2292, 0, '[]', 0),
(98, '', 'adana ani Rune', '', 0, 3, 0, 18, 1400, 0, 0, 0, 0, 2278, 0, '[2,6]', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_videos`
--

CREATE TABLE `myaac_videos` (
  `id` int NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `youtube_id` varchar(20) NOT NULL,
  `author` varchar(50) NOT NULL DEFAULT '',
  `ordering` int NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_visitors`
--

CREATE TABLE `myaac_visitors` (
  `ip` varchar(45) NOT NULL,
  `lastvisit` int NOT NULL DEFAULT '0',
  `page` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_weapons`
--

CREATE TABLE `myaac_weapons` (
  `id` int NOT NULL,
  `level` int NOT NULL DEFAULT '0',
  `maglevel` int NOT NULL DEFAULT '0',
  `vocations` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `myaac_weapons`
--

INSERT INTO `myaac_weapons` (`id`, `level`, `maglevel`, `vocations`) VALUES
(1294, 0, 0, '[]'),
(2111, 0, 0, '[]'),
(2181, 26, 0, '{\"2\":true}'),
(2182, 7, 0, '{\"2\":true}'),
(2183, 33, 0, '{\"2\":true}'),
(2185, 19, 0, '{\"2\":true}'),
(2186, 13, 0, '{\"2\":true}'),
(2187, 33, 0, '{\"1\":true}'),
(2188, 19, 0, '{\"1\":true}'),
(2189, 26, 0, '{\"1\":true}'),
(2190, 7, 0, '{\"1\":true}'),
(2191, 13, 0, '{\"1\":true}'),
(2377, 20, 0, '{\"4\":true}'),
(2378, 0, 0, '{\"4\":true}'),
(2381, 25, 0, '[]'),
(2387, 25, 0, '{\"4\":true}'),
(2389, 0, 0, '[]'),
(2390, 140, 0, '{\"4\":true}'),
(2391, 50, 0, '{\"4\":true}'),
(2392, 30, 0, '[]'),
(2393, 55, 0, '{\"4\":true}'),
(2396, 0, 0, '[]'),
(2399, 0, 0, '[]'),
(2400, 80, 0, '[]'),
(2407, 30, 0, '[]'),
(2408, 120, 0, '{\"4\":true}'),
(2410, 0, 0, '[]'),
(2413, 0, 0, '{\"4\":true}'),
(2414, 60, 0, '[]'),
(2415, 95, 0, '{\"4\":true}'),
(2423, 20, 0, '[]'),
(2424, 45, 0, '[]'),
(2425, 20, 0, '[]'),
(2426, 25, 0, '[]'),
(2427, 55, 0, '[]'),
(2429, 20, 0, '[]'),
(2430, 25, 0, '[]'),
(2431, 90, 0, '[]'),
(2432, 35, 0, '[]'),
(2434, 25, 0, '[]'),
(2435, 20, 0, '[]'),
(2436, 30, 0, '[]'),
(2438, 30, 0, '[]'),
(2440, 25, 0, '{\"4\":true}'),
(2443, 70, 0, '{\"4\":true}'),
(2444, 65, 0, '{\"4\":true}'),
(2445, 35, 0, '[]'),
(2446, 45, 0, '[]'),
(2447, 50, 0, '{\"4\":true}'),
(2451, 35, 0, '[]'),
(2452, 70, 0, '{\"4\":true}'),
(2454, 65, 0, '{\"4\":true}'),
(2543, 0, 0, '[]'),
(2544, 0, 0, '[]'),
(2545, 0, 0, '[]'),
(2546, 0, 0, '[]'),
(2547, 55, 0, '[]'),
(3961, 40, 0, '[]'),
(3962, 30, 0, '[]');

-- --------------------------------------------------------

--
-- Estrutura para tabela `packages_history`
--

CREATE TABLE `packages_history` (
  `id` int NOT NULL,
  `account_id` int NOT NULL,
  `value` int NOT NULL,
  `method` text NOT NULL,
  `status` text NOT NULL,
  `bronze` int NOT NULL,
  `silver` int DEFAULT NULL,
  `gold` int DEFAULT NULL,
  `date` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `packages_history`
--

INSERT INTO `packages_history` (`id`, `account_id`, `value`, `method`, `status`, `bronze`, `silver`, `gold`, `date`) VALUES
(162, 4022023, 800, 'Pix', 'approved', 1, 1, 1, '2023-08-30T13:04:27.622-04:00'),
(163, 4022023, 800, 'Pix', 'approved', 1, 1, 1, '2023-08-30T16:16:40.795-04:00'),
(164, 4022023, 800, 'Pix', 'approved', 1, 1, 1, '2023-08-30T16:35:09.736-04:00'),
(165, 4022023, 800, 'Pix', 'approved', 1, 1, 1, '2023-08-30T16:36:25.362-04:00'),
(166, 4022023, 800, 'Pix', 'approved', 1, 1, 1, '2023-08-30T16:40:21.378-04:00'),
(167, 4022023, 800, 'Pix', 'approved', 1, 1, 1, '2023-08-30T16:41:21.934-04:00');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagseguro_transactions`
--

CREATE TABLE `pagseguro_transactions` (
  `transaction_code` varchar(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `payment_method` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `item_count` int NOT NULL,
  `data` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `payment_history`
--

CREATE TABLE `payment_history` (
  `id` int NOT NULL,
  `account_id` int NOT NULL,
  `method` text,
  `status` text,
  `code` text,
  `copy` text,
  `char_name` text,
  `servidor` text,
  `value` float NOT NULL,
  `coins` int NOT NULL,
  `date` varchar(60) NOT NULL,
  `wallet` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `payment_history`
--

INSERT INTO `payment_history` (`id`, `account_id`, `method`, `status`, `code`, `copy`, `char_name`, `servidor`, `value`, `coins`, `date`, `wallet`) VALUES
(107, 4022023, 'Pix', 'Cancelado', '<img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABRQAAAUUAQAAAACGnaNFAAAH0klEQVR42u3dXYrrOBAGUO9A+9+ld6BhoKEd1Veyk1yGC3P8EOK2Yx33W1E/OuZff5wHIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjI+P3xmM9xs/f/r3t+Pn286tjubD8It9cT5dvy6MYGRkZGRkZGRkZGRkfG8c11FlOF9nPx8s65XXH9Vvm/T6lXZyRkZGRkZGRkZGRkfGR8fr0cV3x93EL5Zd8F6rNcuFKbhZnZGRkZGRkZGRkZGT8wngNspq46fqL8/WFzmvMtcRwS8zFyMjIyMjIyMjIyMj454yp1m0JlHJJW6lrW8mLm5GRkZGRkZGRkZGR8VtjIue46czvkldc3Gd4yY/r9hgZGRkZGRkZGRkZGfPMgv/s44u5CoyMjIyMjIyMjIyM/3dje6TenfaWfJqCsSOPKygHIyMjIyMjIyMjIyPjvfEskU/2jOCeJVWU5xPsquNySomRkZGRkZGRkZGRkfFN4/K4zS11xPQSVeUA7XidgXA+yyExMjIyMjIyMjIyMjI2xvKQ2Q0kOMok6dIa1Pw2Z6dePrY5JEZGRkZGRkZGRkZGxhxzjXIaoqA+lirf2ucdm+wUIyMjIyMjIyMjIyPjO8a2T6eNqq4Xlgq3GW6ZayxV81RnKMNjZGRkZGRkZGRkZGS8M27DniO596mn6y6hY1Nyt5TX3dTEMTIyMjIyMjIyMjIyppirmffcDi5YligJojNEZLtqu2vLz2RkZGRkZGRkZGRkZHxs7DI4MUuUFxuhx2eUsrkWlbNOjIyMjIyMjIyMjIyMd8YUPG2SS3Vm2iJrry4PaPNUjIyMjIyMjIyMjIyMD4055pp57sD1wj5uOkuPT6mJG2VxRkZGRkZGRkZGRkbGD4z7gOrMG9vkCyO8RtMutI3NGBkZGRkZGRkZGRkZ74xNqqgdl3aXUlqMzS44d1PbGBkZGRkZGRkZGRkZHxrzbUdJ8tRU0b4c7tGLL98YGRkZGRkZGRkZGRkfGUtt2m7bm1LhNnNAld+vBmNL5MbIyMjIyMjIyMjIyPiOsciWPp02jDpL2Vy5b5TOnk2E96gPiZGRkZGRkZGRkZGRsZTDjRJ9lbWP0NmzbK3TJpfabXQSj5GRkZGRkZGRkZGR8ZGxbeBJZW6phq2gjjxlLT2g3VyUkZGRkZGRkZGRkZHx3liSPO1im/K1GJaVwQVHmNq2PGAwMjIyMjIyMjIyMjJ+YCzHyMFYmxvajFVrJx8c4Z0ZGRkZGRkZGRkZGRnfNo6uTi7dVzfqbFdMTUL71RgZGRkZGRkZGRkZGZ8YlxkDabecWVp0chfPKAFVm6zKq01GRkZGRkZGRkZGRsY3jG0UtKDarNPYKNJCKVQLxXeMjIyMjIyMjIyMjIx742ZDzyUPtDT6jFzclhp90mm6uYu5GBkZGRkZGRkZGRkZNzmkpf6t5nfKbp1p9nTq52kr645uhAEjIyMjIyMjIyMjI+MjY27HOV4HsZ25DejqObfh1iylb+lCn0NiZGRkZGRkZGRkZGTcxVzXlFLK/hxlBlsplqtPySVy6Q0e7UvKyMjIyMjIyMjIyMi4qYlrcj4pBZRK2tIIg7QFz6J9r26PkZGRkZGRkZGRkZFx5hgpTVTLsVQtbksRVKqnu/5HUm8RIyMjIyMjIyMjIyPjnbEUsr14cmh1lrK5dJrr6c7NDLY+z8XIyMjIyMjIyMjIyNjkkDb1bym0mmHAQZt/2q9RE1iMjIyMjIyMjIyMjIyfGZeEznXZNHTtuJsV/WA89YwHIyMjIyMjIyMjIyPjnTGle5ZYqtw8QoyUKuZmDsvKwLaUSGJkZGRkZGRkZGRkZLwzlrVHbvlpEz/Xb6nR57bvJ70VIyMjIyMjIyMjIyPjvbHtyVmSPCWRdBs85bK5o2y3c18Tx8jIyMjIyMjIyMjImI1pBvQMo9GWrT1r+qhkmPbZqV1ExsjIyMjIyMjIyMjI+NCY0ziz2+zmLG1AS/C0byFaLjyp22NkZGRkZGRkZGRkZEw1cbUdp5S5zRJzLZHWfqLBDEfaN4eRkZGRkZGRkZGRkfEdY+7TmdswqiaNUplbi8qLj3U4GyMjIyMjIyMjIyMj451x5AAozxiooVoZ0/YStKUXb9uFtnkuRkZGRkZGRkZGRkbG2c8s2PFS/VvRjk24VfDpf8PIyMjIyMjIyMjIyPjcmB93bDI9S9yUX/LohrOlDULHzcwCRkZGRkZGRkZGRkbGB8YcFM0uw9TOHTi3k9dmaCaafU0cIyMjIyMjIyMjIyPjXQ7pRZb/NjYJojSuoEw0GGGM9bidE8fIyMjIyMjIyMjIyJiMI+eQlqgqzYW+3rc7zb8dNxEeIyMjIyMjIyMjIyPjA2MKrUq0VOvk0lHiqwXV1MSVRh9GRkZGRkZGRkZGRsbPjC8/XYxZO7qauBkBzRS4ycjIyMjIyMjIyMjI+KWxlqrlGQNLA8+RS99e1z5yFR0jIyMjIyMjIyMjI+MnxkyuOaS0dlknjStY0kyz7DDKyMjIyMjIyMjIyMj4gbHOLChNOHUa2wzHUv9WKuvmJkp7vOcnIyMjIyMjIyMjIyPj334wMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMn5s/Afs1ozLvHvJ9gAAAABJRU5ErkJggg==\" style=\"width:300px\">', '00020126450014br.gov.bcb.pix0123support@retronia.online520400005303986540540.005802BR5913G. SEBASTIANI6009Joinville62240520mpqrinter6181225731763046D3E', NULL, NULL, 40, 40, '2023-08-30T13:04:27.622-04:00', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `players`
--

CREATE TABLE `players` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `group_id` int NOT NULL DEFAULT '1',
  `account_id` int NOT NULL DEFAULT '0',
  `level` int NOT NULL DEFAULT '1',
  `vocation` int NOT NULL DEFAULT '0',
  `health` int NOT NULL DEFAULT '150',
  `healthmax` int NOT NULL DEFAULT '150',
  `experience` bigint UNSIGNED NOT NULL DEFAULT '0',
  `lookbody` int NOT NULL DEFAULT '0',
  `lookfeet` int NOT NULL DEFAULT '0',
  `lookhead` int NOT NULL DEFAULT '0',
  `looklegs` int NOT NULL DEFAULT '0',
  `looktype` int NOT NULL DEFAULT '136',
  `maglevel` int NOT NULL DEFAULT '0',
  `mana` int NOT NULL DEFAULT '0',
  `manamax` int NOT NULL DEFAULT '0',
  `manaspent` bigint UNSIGNED NOT NULL DEFAULT '0',
  `soul` int UNSIGNED NOT NULL DEFAULT '0',
  `town_id` int NOT NULL DEFAULT '1',
  `posx` int NOT NULL DEFAULT '0',
  `posy` int NOT NULL DEFAULT '0',
  `posz` int NOT NULL DEFAULT '0',
  `conditions` blob NOT NULL,
  `cap` int NOT NULL DEFAULT '400',
  `sex` int NOT NULL DEFAULT '0',
  `lastlogin` bigint UNSIGNED NOT NULL DEFAULT '0',
  `lastip` int UNSIGNED NOT NULL DEFAULT '0',
  `save` tinyint NOT NULL DEFAULT '1',
  `skull` tinyint NOT NULL DEFAULT '0',
  `skulltime` bigint NOT NULL DEFAULT '0',
  `lastlogout` bigint UNSIGNED NOT NULL DEFAULT '0',
  `blessings` tinyint NOT NULL DEFAULT '0',
  `onlinetime` bigint NOT NULL DEFAULT '0',
  `deletion` bigint NOT NULL DEFAULT '0',
  `balance` bigint UNSIGNED NOT NULL DEFAULT '0',
  `stamina` smallint UNSIGNED NOT NULL DEFAULT '2520',
  `skill_fist` int UNSIGNED NOT NULL DEFAULT '10',
  `skill_fist_tries` bigint UNSIGNED NOT NULL DEFAULT '0',
  `skill_club` int UNSIGNED NOT NULL DEFAULT '10',
  `skill_club_tries` bigint UNSIGNED NOT NULL DEFAULT '0',
  `skill_sword` int UNSIGNED NOT NULL DEFAULT '10',
  `skill_sword_tries` bigint UNSIGNED NOT NULL DEFAULT '0',
  `skill_axe` int UNSIGNED NOT NULL DEFAULT '10',
  `skill_axe_tries` bigint UNSIGNED NOT NULL DEFAULT '0',
  `skill_dist` int UNSIGNED NOT NULL DEFAULT '10',
  `skill_dist_tries` bigint UNSIGNED NOT NULL DEFAULT '0',
  `skill_shielding` int UNSIGNED NOT NULL DEFAULT '10',
  `skill_shielding_tries` bigint UNSIGNED NOT NULL DEFAULT '0',
  `skill_fishing` int UNSIGNED NOT NULL DEFAULT '10',
  `skill_fishing_tries` bigint UNSIGNED NOT NULL DEFAULT '0',
  `created` int NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `lookaddons` int DEFAULT '0',
  `lookShader` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `players`
--

INSERT INTO `players` (`id`, `name`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `lastlogout`, `blessings`, `onlinetime`, `deletion`, `balance`, `stamina`, `skill_fist`, `skill_fist_tries`, `skill_club`, `skill_club_tries`, `skill_sword`, `skill_sword_tries`, `skill_axe`, `skill_axe_tries`, `skill_dist`, `skill_dist_tries`, `skill_shielding`, `skill_shielding_tries`, `skill_fishing`, `skill_fishing_tries`, `created`, `hidden`, `comment`, `lookaddons`, `lookShader`) VALUES
(1, 'GM Violet', 6, 1234567, 1000, 0, 150, 150, 16566949800, 69, 76, 78, 58, 75, 1000, 0, 0, 0, 0, 1, 32368, 32232, 7, '', 400, 0, 1693650281, 4221233066, 1, 0, 0, 1693650308, 0, 964455, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 67, 2017612633061982258, 10, 0, 10, 0, 11, 15, 0, 0, '', 48, 0),
(2, 'GM Ezzz', 6, 1234567, 101, 0, 155, 155, 16180000, 125, 95, 0, 76, 132, 3, 5, 5, 0, 0, 2, 32348, 31785, 7, '', 410, 1, 1693594861, 4221233066, 1, 0, 0, 1693594865, 0, 228879, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, '', 0, 0),
(3, 'Knight', 1, 1234567, 100, 4, 4861, 5960, 16126059, 127, 114, 114, 1, 139, 8, 8065, 8140, 1881998, 16, 1, 32369, 32229, 7, '', 12060, 0, 1693650309, 4221233066, 1, 0, 0, 1693650523, 0, 105592, 0, 0, 2518, 13, 17, 26, 30, 75, 3464, 70, 940, 14, 94, 20, 22, 10, 0, 0, 0, '', 0, 0),
(4, 'Druid', 1, 1234567, 43, 2, 10604, 10605, 1218083, 114, 114, 110, 48, 142, 39, 8266, 10280, 10569, 4, 1, 0, 32241, 7, '', 21310, 0, 1693494341, 1728299697, 1, 0, 1683148611, 1693495394, 0, 110418, 0, 0, 2520, 22, 3338, 10, 0, 10, 38, 10, 0, 10, 1, 11, 16, 10, 12, 0, 0, '', 0, 0),
(5, 'retroniaotserv', 6, 4022023, 1, 0, 100, 100, 0, 10, 10, 10, 10, 136, 0, 100, 100, 0, 0, 1, 0, 0, 0, '', 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1675523240, 0, '', 0, 0),
(6, 'Rook Sample', 1, 4022023, 1, 0, 150, 150, 0, 69, 76, 78, 58, 130, 0, 0, 0, 0, 100, 10, 0, 32219, 7, '', 400, 1, 1675523241, 2130706433, 1, 0, 0, 1675523241, 0, 0, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1675523241, 1, '', 0, 0),
(7, 'Sorcerer Sample', 1, 4022023, 8, 1, 185, 185, 4200, 69, 76, 78, 58, 130, 0, 90, 90, 0, 100, 1, 0, 1000, 7, '', 470, 1, 1675523241, 2130706433, 1, 0, 0, 1675523241, 0, 0, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1675523241, 1, '', 0, 0),
(8, 'Druid Sample', 1, 4022023, 8, 2, 185, 185, 4200, 69, 76, 78, 58, 130, 0, 90, 90, 0, 100, 1, 0, 1000, 7, '', 470, 1, 1675523241, 2130706433, 1, 0, 0, 1675523241, 0, 0, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1675523241, 1, '', 0, 0),
(9, 'Paladin Sample', 1, 4022023, 8, 3, 185, 185, 4200, 69, 76, 78, 58, 129, 0, 90, 90, 0, 100, 1, 0, 1000, 7, '', 470, 1, 1675523241, 2130706433, 1, 0, 0, 1675523241, 0, 0, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1675523241, 1, '', 0, 0),
(10, 'Knight Sample', 1, 4022023, 8, 4, 185, 185, 4200, 69, 76, 78, 58, 131, 0, 90, 90, 0, 100, 1, 0, 1000, 7, '', 470, 1, 1675523241, 2130706433, 1, 0, 0, 1675523241, 0, 0, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1675523241, 1, '', 0, 0),
(16, 'Kina Teste', 1, 1234567, 7, 4, 170, 170, 3780, 106, 95, 78, 58, 134, 0, 85, 85, 0, 100, 1, 32368, 32233, 7, '', 445, 1, 1693594630, 4221233066, 1, 0, 0, 1693594860, 0, 5494, 0, 0, 2520, 10, 0, 12, 17, 10, 0, 10, 0, 16, 111, 10, 0, 10, 0, 1680813793, 0, '', 0, 0),
(17, 'Luanzudo', 1, 1234567, 18, 4, 365, 365, 76860, 114, 95, 21, 114, 134, 8, 43, 140, 12000, 100, 1, 32335, 32211, 7, '', 720, 1, 1693595503, 4221233066, 1, 0, 0, 1693595505, 0, 53779, 0, 0, 2520, 10, 0, 39, 736, 51, 2259, 100, 9200, 100, 36500, 100, 8550, 10, 0, 1680813857, 0, '', 0, 0),
(18, 'Magez', 1, 1234567, 33, 5, 257, 310, 499200, 106, 76, 116, 114, 133, 53, 790, 840, 15050, 200, 1, 32368, 32215, 7, '', 720, 1, 1693651383, 4221233066, 1, 0, 1685500988, 1693651719, 0, 124416, 0, 0, 2520, 17, 492, 68, 4035225266123968238, 16, 500, 20, 24219, 18, 7049, 16, 35, 10, 0, 1680823217, 0, '', 0, 0),
(36, 'GM Luanzera', 6, 199361, 1000, 0, 160, 150, 16566949800, 125, 57, 116, 95, 152, 0, 0, 0, 0, 100, 10, 32340, 31789, 7, '', 400, 1, 1693616005, 4165462184, 1, 0, 0, 1693616848, 0, 5538, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1693527007, 0, '', 48, 0),
(37, 'GM Guizao', 6, 121234, 1000, 3, 150, 150, 16566949800, 106, 95, 78, 58, 75, 0, 0, 0, 0, 100, 2, 32368, 31811, 7, '', 400, 1, 1693531432, 406024637, 1, 0, 0, 1693531609, 0, 177, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1693527018, 0, '', 0, 0),
(38, 'Guii', 1, 121234, 1, 0, 150, 150, 0, 69, 76, 78, 58, 130, 0, 0, 0, 0, 100, 10, 0, 0, 0, '', 400, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1693527295, 0, '', 0, 0),
(39, 'Luanzera Tester', 1, 199361, 8, 0, 185, 185, 5000, 106, 95, 78, 58, 129, 0, 35, 35, 0, 100, 10, 32110, 32244, 7, '', 470, 1, 1693617020, 4165462184, 1, 0, 0, 1693618977, 0, 2128, 0, 0, 2520, 10, 0, 17, 2650, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1693527313, 0, '', 0, 0),
(40, 'Gui Teste', 1, 121234, 1, 0, 150, 150, 0, 69, 76, 78, 58, 130, 0, 0, 0, 0, 100, 10, 0, 0, 0, '', 400, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1693527322, 0, '', 0, 0),
(41, 'Guiizao', 1, 121234, 90, 3, 1005, 1005, 11592100, 106, 95, 78, 58, 147, 15, 1280, 1265, 0, 100, 2, 32368, 32241, 7, '', 2110, 1, 1693536651, 406024637, 1, 0, 0, 1693539533, 31, 3822, 0, 0, 2520, 10, 0, 17, 12, 10, 0, 10, 0, 83, 10792, 10, 0, 10, 0, 1693527334, 0, '', 3, 0),
(42, 'Luanzera Kina', 1, 199361, 82, 4, 1190, 1295, 8545354, 106, 95, 116, 114, 131, 5, 410, 405, 63640, 100, 2, 32368, 32227, 7, 0x010010000002ffffffff03a0df07001b001c000000001d000470170000050100000006e02e00000701000000fe, 2320, 1, 1693615996, 4165462184, 1, 0, 0, 1693616004, 0, 6667, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 66, 1151, 10, 0, 57, 8383, 10, 0, 1693527365, 0, '', 51, 0),
(43, 'Luanzera Mage', 1, 199361, 1, 0, 150, 150, 0, 69, 76, 78, 58, 130, 0, 0, 0, 0, 100, 10, 0, 0, 0, '', 400, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1693527377, 0, '', 0, 0),
(44, 'Luanzera Female', 1, 199361, 1, 0, 150, 150, 0, 69, 76, 78, 58, 136, 0, 0, 0, 0, 100, 10, 0, 0, 0, '', 400, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1693527389, 0, '', 0, 0);

--
-- Acionadores `players`
--
DELIMITER $$
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players` FOR EACH ROW BEGIN
    UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `players_online`
--

CREATE TABLE `players_online` (
  `player_id` int NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_deaths`
--

CREATE TABLE `player_deaths` (
  `player_id` int NOT NULL,
  `time` bigint UNSIGNED NOT NULL DEFAULT '0',
  `level` int NOT NULL DEFAULT '1',
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint NOT NULL DEFAULT '1',
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint NOT NULL DEFAULT '0',
  `unjustified` tinyint NOT NULL DEFAULT '0',
  `mostdamage_unjustified` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `player_deaths`
--

INSERT INTO `player_deaths` (`player_id`, `time`, `level`, `killed_by`, `is_player`, `mostdamage_by`, `mostdamage_is_player`, `unjustified`, `mostdamage_unjustified`) VALUES
(42, 1693536167, 59, 'Frost Dragon', 0, 'Frost Dragon', 0, 0, 0),
(42, 1693536305, 59, 'Frost Dragon', 0, 'Frost Dragon', 0, 0, 0),
(42, 1693536454, 57, 'Frost Dragon', 0, 'Frost Dragon', 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_depotitems`
--

CREATE TABLE `player_depotitems` (
  `player_id` int NOT NULL,
  `sid` int NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int NOT NULL DEFAULT '0',
  `itemtype` smallint UNSIGNED NOT NULL,
  `count` smallint NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_items`
--

CREATE TABLE `player_items` (
  `player_id` int NOT NULL DEFAULT '0',
  `pid` int NOT NULL DEFAULT '0',
  `sid` int NOT NULL DEFAULT '0',
  `itemtype` smallint UNSIGNED NOT NULL DEFAULT '0',
  `count` smallint NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_murders`
--

CREATE TABLE `player_murders` (
  `id` int NOT NULL,
  `player_id` int NOT NULL,
  `date` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `player_murders`
--

INSERT INTO `player_murders` (`id`, `player_id`, `date`) VALUES
(78, 11, 1683745834),
(96, 4, 1683147711),
(133, 18, 1682908916),
(134, 18, 1682908949),
(135, 18, 1682908988);

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_namelocks`
--

CREATE TABLE `player_namelocks` (
  `player_id` int NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint NOT NULL,
  `namelocked_by` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_spells`
--

CREATE TABLE `player_spells` (
  `player_id` int NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_storage`
--

CREATE TABLE `player_storage` (
  `player_id` int NOT NULL DEFAULT '0',
  `key` int UNSIGNED NOT NULL DEFAULT '0',
  `value` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `player_storage`
--

INSERT INTO `player_storage` (`player_id`, `key`, `value`) VALUES
(1, 24000, 1),
(1, 10001001, 18546691),
(41, 50, 1),
(41, 137, 1),
(41, 154, 1),
(41, 24000, 1),
(41, 24001, 1),
(41, 24002, 1),
(41, 10001001, 8454147),
(41, 10001002, 9961475),
(41, 10001003, 17301507),
(41, 10001004, 17563651),
(41, 10001005, 9633795),
(42, 50, 1),
(42, 137, 1),
(42, 154, 1),
(42, 208, 1),
(42, 24000, 1),
(42, 24001, 1),
(42, 24002, 1),
(42, 10001001, 17301507),
(42, 10001002, 17563651),
(42, 10001003, 9961475),
(42, 10001004, 8585219);

-- --------------------------------------------------------

--
-- Estrutura para tabela `raids`
--

CREATE TABLE `raids` (
  `name` varchar(255) NOT NULL,
  `date` bigint NOT NULL DEFAULT '0',
  `count` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `raids`
--

INSERT INTO `raids` (`name`, `date`, `count`) VALUES
('abdendrielbadgers', 1694707177, 7),
('abdendrielwolfattack', 1696137888, 3),
('ankrahmunscarabinvasion', 1709048095, 1),
('carlintowerorcs', 1696108797, 3),
('cavesgrorlam0', 1694732573, 6),
('cavesgrorlam1', 1694722815, 6),
('cavesgrorlam2', 1694729550, 5),
('cavesgrorlam3', 1694740362, 5),
('cavesgrorlam4', 1694724765, 5),
('cavesgrorlam5', 1694745468, 6),
('cormayadwarfattack', 1694727770, 6),
('darashiaundeadinvasion', 1709088098, 1),
('darashiawaspplague', 1694758600, 5),
('dracoriadieingdragons', 1694714203, 5),
('drefianecromancer', 1694749386, 5),
('edronorshabaal', 1707154603, 0),
('edronskunks', 1696109795, 3),
('foldayetis', 1696108348, 3),
('halloweenhare', 1132448568, 293),
('kazordoonhornedfox', 1694753153, 5),
('kazordoonspiderplague', 1694760169, 6),
('mintwalinminogeneral', 1694748068, 6),
('mistisledruid', 1696118057, 4),
('necropolisbeholder', 1694728540, 5),
('northroadoutlaws', 1694143423, 12),
('orclandorc', 1694742265, 6),
('pohdemodras', 1694739881, 6),
('pohwidow', 1695938590, 3),
('rookgaardrats', 1693736937, 41),
('shadowthorndharalion', 1694723196, 6),
('stonehomeghoulattack', 1694739427, 5),
('thaiscaverats', 1694130118, 11),
('thaislighthouseorcs', 1694121996, 9),
('thaisorcinvasion', 1709084321, 1),
('venoreelfinvasion', 1709078200, 1),
('venoreswampelves', 1694754100, 5);

-- --------------------------------------------------------

--
-- Estrutura para tabela `server_config`
--

CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('db_version', '2'),
('motd_hash', '884ac226d1cb747c6494c8bc2302b5773139d004'),
('motd_num', '7'),
('players_record', '4');

-- --------------------------------------------------------

--
-- Estrutura para tabela `store_history`
--

CREATE TABLE `store_history` (
  `id` int UNSIGNED NOT NULL,
  `account_id` int NOT NULL,
  `mode` int NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `coin_amount` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `time` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Despejando dados para a tabela `store_history`
--

INSERT INTO `store_history` (`id`, `account_id`, `mode`, `description`, `coin_amount`, `time`) VALUES
(2, 1234567, 0, '30 Days of Premium Time', '-150', 1675522330),
(3, 1234567, 0, '30 Days of Premium Time', '-150', 1675522480),
(4, 1234567, 0, '30 Days of Premium Time', '-150', 1675522545),
(5, 1234567, 0, 'Withdrawn coins', '-50', 1675527880),
(6, 199361, 0, '30 Days of Premium Time', '-150', 1682297828),
(7, 1234567, 0, 'XP Boost', '-30', 1682320359),
(8, 199361, 0, 'XP Boost', '-30', 1682867322),
(9, 1234567, 0, '30 Days of Premium Time', '-150', 1682905282),
(10, 1234567, 0, 'Character Name Change', '-250', 1682919389),
(11, 1234567, 0, 'Temple Teleport', '-25', 1682919408),
(12, 1234567, 0, '30 Days of Premium Time', '-150', 1683638139),
(13, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693531955),
(14, 121234, 0, 'Premium Scroll 30 Days', '-100', 1693531961),
(15, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693531967),
(16, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693531968),
(17, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693531968),
(18, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693531968),
(19, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693531968),
(20, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693531969),
(21, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693531969),
(22, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693531969),
(23, 121234, 0, 'Addon 1', '-175', 1693532013),
(24, 121234, 0, 'Addon 2', '-175', 1693532015),
(25, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532046),
(26, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532046),
(27, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532047),
(28, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532047),
(29, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532047),
(30, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532047),
(31, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532047),
(32, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532047),
(33, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532048),
(34, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532048),
(35, 121234, 0, 'Bless', '-250', 1693532053),
(36, 121234, 0, 'Arrow Quiver', '-150', 1693532061),
(37, 121234, 0, 'Bolt Quiver', '-150', 1693532064),
(38, 121234, 0, 'Dummy Training Ticket', '-10', 1693532072),
(39, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532103),
(40, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532104),
(41, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532104),
(42, 121234, 0, 'Deposited Coins (Via using item)', '50', 1693532105),
(43, 121234, 0, 'Deposited Coins (Via using item)', '100', 1693532105),
(44, 121234, 0, 'Retronia Backpack', '-20', 1693532242),
(45, 1234567, 0, 'Deposited Coins (Via using item)', '100', 1693532328),
(46, 1234567, 0, 'Deposited Coins (Via using item)', '100', 1693532328),
(47, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532498),
(48, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532498),
(49, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532499),
(50, 199361, 0, 'Deposited Coins (Via using item)', '50', 1693532500),
(51, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532500),
(52, 199361, 0, 'Premium Scroll 30 Days', '-100', 1693532541),
(53, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532553),
(54, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532553),
(55, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532553),
(56, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532553),
(57, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532553),
(58, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532554),
(59, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532554),
(60, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532554),
(61, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532554),
(62, 199361, 0, 'Deposited Coins (Via using item)', '100', 1693532554),
(63, 199361, 0, 'Blessings Checker', '-100', 1693532567),
(64, 199361, 0, 'Bless', '-250', 1693532571),
(65, 199361, 0, 'Addon 2', '-175', 1693538602),
(66, 199361, 0, 'Addon 1', '-175', 1693538605),
(67, 121234, 0, 'Viking Outfit', '-375', 1693538615),
(68, 121234, 0, 'Addon 1', '-375', 1693538617),
(69, 121234, 0, 'Addon 2', '-375', 1693538618),
(70, 1234567, 0, 'Dummy Training Ticket', '-10', 1693649355),
(71, 1234567, 0, 'Dummy Training Ticket', '-10', 1693649523),
(72, 1234567, 0, 'Dummy Training Ticket', '-10', 1693649638),
(73, 1234567, 0, 'Dummy Training Ticket', '-10', 1693650339);

-- --------------------------------------------------------

--
-- Estrutura para tabela `streamers`
--

CREATE TABLE `streamers` (
  `id` int NOT NULL,
  `account_id` int NOT NULL,
  `name` text NOT NULL,
  `url` text NOT NULL,
  `discord` text NOT NULL,
  `token` text NOT NULL,
  `status` text,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `streamers`
--

INSERT INTO `streamers` (`id`, `account_id`, `name`, `url`, `discord`, `token`, `status`, `date`) VALUES
(31, 4022023, 'VulgoGecko', 'www.google.com', '#dirkyh', '37c0911ab822accd8d404a50', 'Aprovado', '2023-08-02 15:30:38'),
(32, 4022023, 'ferfoglia_', 'www.google.com', '#dirkyh', '37c0911ab822accd8d404a50', 'Aprovado', '2023-08-02 15:30:38'),
(33, 4022023, 'Vda_pedro', 'www.google.com', '#dirkyh', '37c0911ab822accd8d404a50', 'Aprovado', '2023-08-02 15:30:38'),
(34, 4022023, 'DiogoTeiixeira', 'www.google.com', '#dirkyh', '37c0911ab822accd8d404a50', 'Aprovado', '2023-08-02 15:30:38'),
(35, 4022023, 'Jardineiroxd', 'www.google.com', '#dirkyh', '37c0911ab822accd8d404a50', 'Aprovado', '2023-08-02 15:30:38'),
(36, 4022023, 'Sileanic', 'www.google.com', '#dirkyh', '37c0911ab822accd8d404a50', 'Aprovado', '2023-08-02 15:30:38'),
(37, 4022023, 'Paradox', 'www.google.com', '#dirkyh', '37c0911ab822accd8d404a50', 'Aprovado', '2023-08-02 15:30:38'),
(38, 4022023, 'Nattank', 'www.google.com', '#dirkyh', '37c0911ab822accd8d404a50', 'Aprovado', '2023-08-02 15:30:38'),
(39, 4022023, 'Rhuanzerahh', 'www.google.com', '#dirkyh', '37c0911ab822accd8d404a50', 'Aprovado', '2023-08-02 15:30:38');

-- --------------------------------------------------------

--
-- Estrutura para tabela `towns`
--

CREATE TABLE `towns` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `posx` int NOT NULL DEFAULT '0',
  `posy` int NOT NULL DEFAULT '0',
  `posz` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `towns`
--

INSERT INTO `towns` (`id`, `name`, `posx`, `posy`, `posz`) VALUES
(1, 'Thais', 32369, 32241, 7),
(2, 'Carlin', 32360, 31782, 7),
(3, 'Kazordoon', 32649, 31925, 11),
(4, 'Ab\'Dendriel', 32732, 31634, 7),
(5, 'Edron', 33217, 31814, 8),
(6, 'Darashia', 33213, 32454, 1),
(7, 'Venore', 32957, 32076, 7),
(8, 'Ankrahmun', 33195, 32853, 8),
(9, 'Port Hope', 32595, 32745, 7),
(10, 'Rookgaard', 32097, 32219, 7),
(11, 'Isle of Solitude', 32316, 31942, 7);

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_ots_comunication`
--

CREATE TABLE `z_ots_comunication` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(255) NOT NULL DEFAULT '',
  `action` varchar(255) NOT NULL DEFAULT '',
  `param1` varchar(255) NOT NULL DEFAULT '',
  `param2` varchar(255) NOT NULL DEFAULT '',
  `param3` varchar(255) NOT NULL DEFAULT '',
  `param4` varchar(255) NOT NULL DEFAULT '',
  `param5` varchar(255) NOT NULL DEFAULT '',
  `param6` varchar(255) NOT NULL DEFAULT '',
  `param7` varchar(255) NOT NULL DEFAULT '',
  `delete_it` int NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `z_ots_comunication`
--

INSERT INTO `z_ots_comunication` (`id`, `name`, `type`, `action`, `param1`, `param2`, `param3`, `param4`, `param5`, `param6`, `param7`, `delete_it`) VALUES
(293, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(292, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(291, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(290, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(289, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(288, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(287, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(286, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(285, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(284, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(283, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(282, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(281, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(280, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(279, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(278, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(277, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(276, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(275, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(274, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(273, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(272, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(271, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(270, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(269, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(268, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(267, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(266, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(265, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(264, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(263, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(262, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(261, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(260, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(259, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(258, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(257, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(256, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(255, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(254, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(253, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(252, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(251, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(250, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(249, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(248, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(247, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(246, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(245, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(244, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(243, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(242, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(241, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(240, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(239, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(238, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(237, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(236, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(235, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(234, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(233, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(232, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(231, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(230, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(229, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(228, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(227, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(226, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(225, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(224, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(223, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(222, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(221, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(220, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(219, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(218, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(217, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(216, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(215, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(214, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(213, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1),
(212, '4022023', 'login', 'give_item', '5113', '1', '', '', 'item', 'packages', '', 1),
(211, '4022023', 'login', 'give_item', '5114', '1', '', '', 'item', 'packages', '', 1),
(210, '4022023', 'login', 'give_item', '5115', '1', '', '', 'item', 'packages', '', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_polls`
--

CREATE TABLE `z_polls` (
  `id` int NOT NULL,
  `question` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `end` int NOT NULL DEFAULT '0',
  `start` int NOT NULL DEFAULT '0',
  `answers` int NOT NULL DEFAULT '0',
  `votes_all` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_polls_answers`
--

CREATE TABLE `z_polls_answers` (
  `poll_id` int NOT NULL,
  `answer_id` int NOT NULL,
  `answer` varchar(255) NOT NULL,
  `votes` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_shop_categories`
--

CREATE TABLE `z_shop_categories` (
  `id` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `z_shop_categories`
--

INSERT INTO `z_shop_categories` (`id`, `name`, `hidden`) VALUES
(1, 'Items', 0),
(2, 'Addons', 0),
(3, 'Mounts', 0),
(4, 'Premium Account', 0),
(5, 'Containers', 0),
(6, 'Other', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_shop_history`
--

CREATE TABLE `z_shop_history` (
  `id` int NOT NULL,
  `comunication_id` int NOT NULL DEFAULT '0',
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL DEFAULT '',
  `from_account` int NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  `offer_id` int NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int NOT NULL DEFAULT '0',
  `trans_real` int NOT NULL DEFAULT '0',
  `is_pacc` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_shop_offer`
--

CREATE TABLE `z_shop_offer` (
  `id` int NOT NULL,
  `points` int NOT NULL DEFAULT '0',
  `itemid1` int NOT NULL DEFAULT '0',
  `count1` int NOT NULL DEFAULT '0',
  `itemid2` int NOT NULL DEFAULT '0',
  `count2` int NOT NULL DEFAULT '0',
  `category_id` tinyint(1) NOT NULL DEFAULT '0',
  `offer_type` varchar(255) DEFAULT NULL,
  `offer_description` text NOT NULL,
  `offer_name` varchar(255) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `ordering` int NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `z_shop_offer`
--

INSERT INTO `z_shop_offer` (`id`, `points`, `itemid1`, `count1`, `itemid2`, `count2`, `category_id`, `offer_type`, `offer_description`, `offer_name`, `hidden`, `ordering`) VALUES
(1, 10, 2160, 50, 0, 0, 1, 'item', '50 crystal coins. They weigh 5.00 oz.', '50 Crystal Coins', 0, 1),
(2, 10, 139, 3, 131, 3, 2, 'addon', 'This purchase will give you the full knight outfit.', 'Knight Outfit', 0, 2),
(3, 10, 22, 0, 0, 0, 3, 'mount', 'This purchase will give you the Rented Horse mount.', 'Rented Horse', 0, 3),
(4, 10, 0, 30, 0, 0, 4, 'pacc', '30 Days of Premium Account', 'PACC 30', 0, 4);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `account_bans`
--
ALTER TABLE `account_bans`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices de tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices de tabela `account_storage`
--
ALTER TABLE `account_storage`
  ADD PRIMARY KEY (`account_id`,`key`);

--
-- Índices de tabela `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD UNIQUE KEY `account_player_index` (`account_id`,`player_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `allow_request`
--
ALTER TABLE `allow_request`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `crypto_history`
--
ALTER TABLE `crypto_history`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `crypto_payments`
--
ALTER TABLE `crypto_payments`
  ADD PRIMARY KEY (`paymentID`),
  ADD UNIQUE KEY `key3` (`boxID`,`orderID`,`userID`,`txID`,`amount`,`addr`),
  ADD KEY `boxID` (`boxID`),
  ADD KEY `boxType` (`boxType`),
  ADD KEY `userID` (`userID`),
  ADD KEY `countryID` (`countryID`),
  ADD KEY `orderID` (`orderID`),
  ADD KEY `amount` (`amount`),
  ADD KEY `amountUSD` (`amountUSD`),
  ADD KEY `coinLabel` (`coinLabel`),
  ADD KEY `unrecognised` (`unrecognised`),
  ADD KEY `addr` (`addr`),
  ADD KEY `txID` (`txID`),
  ADD KEY `txDate` (`txDate`),
  ADD KEY `txConfirmed` (`txConfirmed`),
  ADD KEY `txCheckDate` (`txCheckDate`),
  ADD KEY `processed` (`processed`),
  ADD KEY `processedDate` (`processedDate`),
  ADD KEY `recordCreated` (`recordCreated`),
  ADD KEY `key1` (`boxID`,`orderID`),
  ADD KEY `key2` (`boxID`,`orderID`,`userID`);

--
-- Índices de tabela `dirkyh_items`
--
ALTER TABLE `dirkyh_items`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `ownerid` (`ownerid`);

--
-- Índices de tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warid` (`warid`);

--
-- Índices de tabela `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD PRIMARY KEY (`player_id`,`guild_id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Índices de tabela `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `guild_id` (`guild_id`),
  ADD KEY `rank_id` (`rank_id`);

--
-- Índices de tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Índices de tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild1` (`guild1`),
  ADD KEY `guild2` (`guild2`);

--
-- Índices de tabela `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `town_id` (`town_id`);

--
-- Índices de tabela `house_lists`
--
ALTER TABLE `house_lists`
  ADD KEY `house_id` (`house_id`);

--
-- Índices de tabela `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD PRIMARY KEY (`ip`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices de tabela `kill_statistics`
--
ALTER TABLE `kill_statistics`
  ADD KEY `name` (`name`),
  ADD KEY `time` (`time`);

--
-- Índices de tabela `medivia coins`
--
ALTER TABLE `medivia coins`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_account_actions`
--
ALTER TABLE `myaac_account_actions`
  ADD KEY `account_id` (`account_id`);

--
-- Índices de tabela `myaac_admin_menu`
--
ALTER TABLE `myaac_admin_menu`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_bugtracker`
--
ALTER TABLE `myaac_bugtracker`
  ADD PRIMARY KEY (`uid`);

--
-- Índices de tabela `myaac_changelog`
--
ALTER TABLE `myaac_changelog`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_config`
--
ALTER TABLE `myaac_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `myaac_faq`
--
ALTER TABLE `myaac_faq`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_forum`
--
ALTER TABLE `myaac_forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section` (`section`);

--
-- Índices de tabela `myaac_forum_boards`
--
ALTER TABLE `myaac_forum_boards`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_gallery`
--
ALTER TABLE `myaac_gallery`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_menu`
--
ALTER TABLE `myaac_menu`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_monsters`
--
ALTER TABLE `myaac_monsters`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_news`
--
ALTER TABLE `myaac_news`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_news_categories`
--
ALTER TABLE `myaac_news_categories`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_notepad`
--
ALTER TABLE `myaac_notepad`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_pages`
--
ALTER TABLE `myaac_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `myaac_spells`
--
ALTER TABLE `myaac_spells`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `myaac_videos`
--
ALTER TABLE `myaac_videos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_visitors`
--
ALTER TABLE `myaac_visitors`
  ADD UNIQUE KEY `ip` (`ip`);

--
-- Índices de tabela `myaac_weapons`
--
ALTER TABLE `myaac_weapons`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `packages_history`
--
ALTER TABLE `packages_history`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `pagseguro_transactions`
--
ALTER TABLE `pagseguro_transactions`
  ADD UNIQUE KEY `transaction_code` (`transaction_code`,`status`),
  ADD KEY `name` (`name`),
  ADD KEY `status` (`status`);

--
-- Índices de tabela `payment_history`
--
ALTER TABLE `payment_history`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `vocation` (`vocation`);

--
-- Índices de tabela `players_online`
--
ALTER TABLE `players_online`
  ADD PRIMARY KEY (`player_id`);

--
-- Índices de tabela `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `killed_by` (`killed_by`),
  ADD KEY `mostdamage_by` (`mostdamage_by`);

--
-- Índices de tabela `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Índices de tabela `player_items`
--
ALTER TABLE `player_items`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `sid` (`sid`);

--
-- Índices de tabela `player_murders`
--
ALTER TABLE `player_murders`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `namelocked_by` (`namelocked_by`);

--
-- Índices de tabela `player_spells`
--
ALTER TABLE `player_spells`
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `player_storage`
--
ALTER TABLE `player_storage`
  ADD PRIMARY KEY (`player_id`,`key`);

--
-- Índices de tabela `raids`
--
ALTER TABLE `raids`
  ADD UNIQUE KEY `nameindex` (`name`);

--
-- Índices de tabela `server_config`
--
ALTER TABLE `server_config`
  ADD PRIMARY KEY (`config`);

--
-- Índices de tabela `store_history`
--
ALTER TABLE `store_history`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `streamers`
--
ALTER TABLE `streamers`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `towns`
--
ALTER TABLE `towns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `z_ots_comunication`
--
ALTER TABLE `z_ots_comunication`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `z_polls`
--
ALTER TABLE `z_polls`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `z_shop_categories`
--
ALTER TABLE `z_shop_categories`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `z_shop_history`
--
ALTER TABLE `z_shop_history`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `z_shop_offer`
--
ALTER TABLE `z_shop_offer`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58764900;

--
-- AUTO_INCREMENT de tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `allow_request`
--
ALTER TABLE `allow_request`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de tabela `crypto_history`
--
ALTER TABLE `crypto_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de tabela `crypto_payments`
--
ALTER TABLE `crypto_payments`
  MODIFY `paymentID` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=862;

--
-- AUTO_INCREMENT de tabela `medivia coins`
--
ALTER TABLE `medivia coins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `myaac_admin_menu`
--
ALTER TABLE `myaac_admin_menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `myaac_bugtracker`
--
ALTER TABLE `myaac_bugtracker`
  MODIFY `uid` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_changelog`
--
ALTER TABLE `myaac_changelog`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `myaac_config`
--
ALTER TABLE `myaac_config`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `myaac_faq`
--
ALTER TABLE `myaac_faq`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_forum`
--
ALTER TABLE `myaac_forum`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_forum_boards`
--
ALTER TABLE `myaac_forum_boards`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `myaac_gallery`
--
ALTER TABLE `myaac_gallery`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `myaac_menu`
--
ALTER TABLE `myaac_menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=265;

--
-- AUTO_INCREMENT de tabela `myaac_monsters`
--
ALTER TABLE `myaac_monsters`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT de tabela `myaac_news`
--
ALTER TABLE `myaac_news`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `myaac_news_categories`
--
ALTER TABLE `myaac_news_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `myaac_notepad`
--
ALTER TABLE `myaac_notepad`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_pages`
--
ALTER TABLE `myaac_pages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `myaac_spells`
--
ALTER TABLE `myaac_spells`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT de tabela `myaac_videos`
--
ALTER TABLE `myaac_videos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `packages_history`
--
ALTER TABLE `packages_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT de tabela `payment_history`
--
ALTER TABLE `payment_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT de tabela `players`
--
ALTER TABLE `players`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de tabela `player_murders`
--
ALTER TABLE `player_murders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT de tabela `store_history`
--
ALTER TABLE `store_history`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT de tabela `streamers`
--
ALTER TABLE `streamers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de tabela `towns`
--
ALTER TABLE `towns`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `z_ots_comunication`
--
ALTER TABLE `z_ots_comunication`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=294;

--
-- AUTO_INCREMENT de tabela `z_polls`
--
ALTER TABLE `z_polls`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_shop_history`
--
ALTER TABLE `z_shop_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_shop_offer`
--
ALTER TABLE `z_shop_offer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `account_bans`
--
ALTER TABLE `account_bans`
  ADD CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD CONSTRAINT `account_ban_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `account_storage`
--
ALTER TABLE `account_storage`
  ADD CONSTRAINT `account_storage_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guilds`
--
ALTER TABLE `guilds`
  ADD CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD CONSTRAINT `guild_membership_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
