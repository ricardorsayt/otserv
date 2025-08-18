function onLogout(player)
	-- if player:getStorageValue(Storage.LoginLogoutExaust) > os.stime() then
		-- player:sendCancelMessage("You are performing a very fast action.")
		-- return false
	-- end

	if player:getName() == "Jaaoo" then
		return false
	end

	player:setStorageValue(Storage.LoginLogoutExaust, os.stime() + 5)
	local playerGuid = player:getGuid()
	if nextUseStaminaTime[playerGuid] ~= nil then
		nextUseStaminaTime[playerGuid] = nil
	end

	player:setStorageValue(Storage.Exercisedummy.exaust, 0)

	local stats = player:inBossFight()
	if stats then
		local boss = Monster(stats.bossId)
		-- Player logged out (or died) in the middle of a boss fight, store his damageOut and stamina
		if boss then
			local dmgOut = boss:getDamageMap()[playerGuid]
			if dmgOut then
				stats.damageOut = (stats.damageOut or 0) + dmgOut.total
			end
			stats.stamina = player:getStamina()
		end
	end

	player:logoutEvent()

	return true
end