function onUpdateDatabase()
	print("> Updating database to version 3 (website creatures and spells)")

	db.query([[
		CREATE TABLE IF NOT EXISTS `web_creatures` (
			`id` bigint(20) UNSIGNED NOT NULL,
			`name` varchar(191) NOT NULL,
			`created_at` timestamp NULL DEFAULT NULL,
			`updated_at` timestamp NULL DEFAULT NULL
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
	]])

	db.query([[
		CREATE TABLE IF NOT EXISTS `web_spells` (
			`id` bigint(20) UNSIGNED NOT NULL,
			`name` varchar(191) NOT NULL,
			`words` varchar(191) NOT NULL,
			`category` tinyint(4) NOT NULL COMMENT 'undefined, instant, rune, conjuring, house',
			`mana` int(11) NOT NULL,
			`mlvl` int(11) NOT NULL,
			`premium` tinyint(4) NOT NULL,
			`vocations` varchar(191) NOT NULL,
			`param` tinyint(4) NOT NULL,
			`learn` tinyint(4) NOT NULL,
			`created_at` timestamp NULL DEFAULT NULL,
			`updated_at` timestamp NULL DEFAULT NULL
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
	]])

	return true
end