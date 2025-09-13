local creatureevent = CreatureEvent("DropLoot")

function Item:isOnlyContainer()

	if self.itemid == ITEM_SMALLSTONE_POUCH then
		return false
	end

	if self.itemid == ITEM_GOLD_POUCH then
		return false
	end

	if self:getType():getWeaponType() == WEAPON_QUIVER then
		return false
	end

	return self:isContainer()
end

function creatureevent.onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if player:hasFlag(PlayerFlag_NotGenerateLoot) then
		return true
	end

	local amulet = player:getSlotItem(CONST_SLOT_NECKLACE)
	local isRed = player:getSkull() == SKULL_RED
	
	if amulet and not isRed then
		if amulet.itemid == ITEM_AMULETOFLOSS then
			amulet:remove(1)
			return true
		end

		if amulet.itemid == 5551 then
			if amulet:getCustomAttribute("aolenchant") ~= 1 then
				amulet:transform(5588)
				amulet:setCustomAttribute("ITEM_CUSTOM_ATTRIBUTE_DESCRIPTION", "This item is corrupted. You need to enchant it.")
				amulet:setCustomAttribute("aolenchant", 1)
				return true
			end
		end

	end

	for i = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
		local item = player:getSlotItem(i)
		local lossPercent = player:getLossPercent()
		
		local allPouches = {}
		
		for _, pouch in pairs(player:getPouches(ITEM_SMALLSTONE_POUCH)) do
			table.insert(allPouches, pouch)
		end
		
		for _, pouch in pairs(player:getPouches(ITEM_GOLD_POUCH)) do
			table.insert(allPouches, pouch)
		end

		if configManager.getBoolean(configKeys.CLASSIC_PLAYER_LOOTDROP) then
			if item then
				if isRed or math.random(0, 9) == 0 or (item:isOnlyContainer()) then
					if not item:moveTo(corpse) then
						item:remove()
					end
				end
			end
		else
			if item then
				if isRed or math.random(item:isOnlyContainer() and 100 or 1000) <= lossPercent then
					if (isRed or lossPercent ~= 0) and not item:moveTo(corpse) then
						item:remove()
					end
				end
			end
		end

		local remainPouches = {}

		for _, pouch in pairs(player:getPouches(ITEM_SMALLSTONE_POUCH)) do
			table.insert(remainPouches, pouch)
		end

		for _, pouch in pairs(player:getPouches(ITEM_GOLD_POUCH)) do
			table.insert(remainPouches, pouch)
		end

		for _, pouch in pairs(allPouches) do
			local forget_soulbind = false
			local soulbound = pouch:getCustomAttribute("soulbound")
			if soulbound == player:getGuid() then
				forget_soulbind = true

				for _, checkPouch in pairs(remainPouches) do
					if pouch.uid == pouch.uid then
						forget_soulbind = false
						break
					end
				end
			end

			if forget_soulbind then
				pouch:setCustomAttribute("ITEM_CUSTOM_ATTRIBUTE_DESCRIPTION", "This item was soul bound to " .. player:getName())
				pouch:setCustomAttribute("soulbound", 0)
			end
		end
	end

	return true
end

creatureevent:register()