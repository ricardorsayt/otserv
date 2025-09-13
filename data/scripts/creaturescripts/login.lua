local conditionLight = Condition(CONDITION_LIGHT)
conditionLight:setTicks(-1)
conditionLight:setParameter(CONDITION_PARAM_LIGHT_LEVEL, 9)

function isPremiumArea(position)
	local x = position.x / 32
	local y = position.y / 32

	if x <= 1035 then
		if x <= 1031 or y > 998 then
			if x <= 1029 or y <= 1007 then
				if x <= 1028 or y <= 1008 then
					if x <= 1021 or y <= 1013 then
						return y >= 1016
					end
				end
			end
		end
	end

	return true
end

function Player.isPremiumPosition(self)
	local position = self:getPosition()

	return isPremiumArea(position)
end

local creatureevent = CreatureEvent("PlayerLogin")

function creatureevent.onLogin(player)
	if player:getLastLoginSaved() <= 0 then
		player:sendOutfitWindow()
		player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "Please choose your outfit.")
	else
		-- 23:46 Your last visit in Tibia: 11. Jul 2005 22:19:56 CEST.
		-- Your last visit in Ravenor: Fri Mar 01 23:45:34 2024.
		player:sendTextMessage(MESSAGE_STATUS_DEFAULT, string.format("Your last visit in Ravenor: %s GMT-3.", os.date("%d %b %Y %X", player:getLastLoginSaved())))
	end

	--Bestiary Points:
	if player:getStorageValue(G_MONSTERSTAR.STR_BESTIARY_POINTS) < 0 then
		player:setStorageValue(G_MONSTERSTAR.STR_BESTIARY_POINTS, 0)
	end

	-- Stamina
	nextUseStaminaTime[player.uid] = 0

	-- Promotion
	local isPromoted = player:getStorageValue(PlayerStorageKeys.promotion)
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		if isPromoted == 1 then
			player:setVocation(promotion)
		end
	elseif isPromoted == 1 and not player:isPremium() then
		-- Demote the player since we are no longer premium
		player:setVocation(vocation:getDemotion())
	end

	-- Player lost premium time
	local lastLoginPremium = player:getLastLoginSaved() ~= 0 and player:getLastLoginSaved() <= player:getPremiumEndsAt() -- Se, quando fez login por último era premium
	-- local lastLogoutPremium = player:getLastLogout() <= player:getPremiumEndsAt() and player:getPremiumEndsAt() <= os.time() -- Se, quando fez logout por último ainda era premium

	if not player:isPremium() and (lastLoginPremium or player:isPremiumPosition()) then -- and lastLogoutPremium
		local town = Town(player:getVocation():getId() == 0 and "Rookgard" or "Thais")
		
		if town then
			if player:isPremiumPosition() then
				player:teleportTo(town:getTemplePosition())
			end

			player:setTown(town)
			print("Player " .. player:getName() .. " lost premium time and was teleported to ".. town:getName() ..".")
		end
	end

	-- Player lost premium time
	if player:getVocation():getId() > 0 and player:getPremiumEndsAt() ~= 0 and player:getLastLogout() ~= 0 then
		if player:getLastLogout() <= player:getPremiumEndsAt() and player:getPremiumEndsAt() <= os.time() then
			local town = Town("Thais")
			if town then
				player:teleportTo(town:getTemplePosition())
				player:setTown(town)
				print("Player " .. player:getName() .. " lost premium time and was teleported to Thais.")
			end
		end
	elseif player:getVocation():getId() == 0 and player:getPremiumEndsAt() ~= 0 and player:getLastLogout() ~= 0 then
		if player:getLastLogout() <= player:getPremiumEndsAt() and player:getPremiumEndsAt() <= os.time() then
			local town = Town("Rookgaard")
			if town then
				player:teleportTo(town:getTemplePosition())
				player:setTown(town)
				print("Player " .. player:getName() .. " lost premium time and was teleported to Rookgaard (newbie).")
			end
		end
	end

	-- update blessing storages
	player:updateBlessingStorages()
	
	-- Gamemaster Light
	if player:getGroup():hasFlag(PlayerFlag_FullLight) then
		player:addCondition(conditionLight)
	end

	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("ExtendedOpCode")
	player:registerEvent("BestiaryHealthChange")
	player:registerEvent("CopycatBestiaryHealthChange")

	return true
end

creatureevent:register()