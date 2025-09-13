function onStartup()
	db.query("TRUNCATE TABLE `players_online`")
	db.asyncQuery("DELETE FROM `guild_wars` WHERE `status` = 0")
	db.asyncQuery("DELETE FROM `players` WHERE `deletion` != 0 AND `deletion` < " .. os.time())
	db.asyncQuery("DELETE FROM `ip_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())

	-- Move expired bans to ban history
	local resultId = db.storeQuery("SELECT * FROM `account_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())
	if resultId ~= false then
		repeat
			local accountId = result.getNumber(resultId, "account_id")
			db.asyncQuery("INSERT INTO `account_ban_history` (`account_id`, `reason`, `banned_at`, `expired_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(result.getString(resultId, "reason")) .. ", " .. result.getNumber(resultId, "banned_at") .. ", " .. result.getNumber(resultId, "expires_at") .. ", " .. result.getNumber(resultId, "banned_by") .. ")")
			db.asyncQuery("DELETE FROM `account_bans` WHERE `account_id` = " .. accountId)
		until not result.next(resultId)
		result.free(resultId)
	end

	-- Clear monsters and insert a new list to database
	db.query("TRUNCATE TABLE `web_creatures`")
	local monsterList = Monster.getList()
	for i, monsterName in ipairs(monsterList) do
		db.asyncQuery("INSERT INTO `web_creatures` (`name`, `created_at`, `updated_at`) VALUES (" .. db.escapeString(monsterName) .. ", NOW(), NOW())")
	end

	-- store towns in database
	db.query("TRUNCATE TABLE `towns`")
	for i, town in ipairs(Game.getTowns()) do
		local position = town:getTemplePosition()
		db.query("INSERT INTO `towns` (`id`, `name`, `posx`, `posy`, `posz`) VALUES (" .. town:getId() .. ", " .. db.escapeString(town:getName()) .. ", " .. position.x .. ", " .. position.y .. ", " .. position.z .. ")")
	end

	--Update house website rent info
	local houseList = Game.getHouses()
	for _, house in ipairs(houseList) do
		local housePrice = configManager.getNumber(configKeys.HOUSE_PRICE)
		local rent = house:getRent()
		if housePrice > -1 then
			local price = house:getTileCount() * housePrice
			if price ~= rent then
				house:setRent(price)
				db.asyncQuery("UPDATE `houses` SET `rent` = " .. price .. " WHERE `id` = " .. house:getId())
			end
		end
	end

	Game.loadBosses()

	if getConfigInfo("ignoreMaintance") then
		print("Ignoring maintenance game status.")
		return true
	end

	addEvent(function()
		Game.setGameState(GAME_STATE_MAINTAIN)
		print("Game state set to maintain.")
	end, 3 * 1000)

	addEvent(function()
		Game.setGameState(GAME_STATE_NORMAL)
		print("Game state set to normal.")
	end, 5 * 60 * 1000)
end
