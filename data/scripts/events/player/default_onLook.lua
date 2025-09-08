local event = Event()

event.onLook = function(self, thing, position, distance, description)
	local description = "You see "

	if thing:isItem() then
		if thing.actionid == 5640 then
			description = description .. "a honeyflower patch."
		elseif thing.actionid == 5641 then
			description = description .. "a banana palm."
		elseif thing.itemid >= ITEM_HEALTH_CASK_START and thing.itemid <= ITEM_HEALTH_CASK_END
		or thing.itemid >= ITEM_MANA_CASK_START and thing.itemid <= ITEM_MANA_CASK_END
		or thing.itemid >= ITEM_SPIRIT_CASK_START and thing.itemid <= ITEM_SPIRIT_CASK_END
		or thing.itemid >= ITEM_KEG_START and thing.itemid <= ITEM_KEG_END then
			description = description .. thing:getDescription(distance)
			local charges = thing:getAttribute(ITEM_ATTRIBUTE_DATE)
			if charges then
				description = string.format("%s\nIt has %d refillings left.", description, charges)
			end
		else
			description = description .. thing:getDescription(distance)
		end
	else
		description = description .. thing:getDescription(distance)
		if thing:isMonster() then
			local master = thing:getMaster()
			if master and table.contains({'thundergiant','grovebeast','emberwing','skullfrost'}, thing:getName():lower()) then
				description = description .. ' (Master: ' .. master:getName() .. '). It will disappear in ' .. getTimeinWords((thing:getRemoveTime()/1000))
			end
		end
	end

-- Código para adicionar o rank de tasks
	if thing:isPlayer() then
		 local rankPoints = thing:getStorageValue(87613) -- ID de storage para os pontos de rank
		 local rankTitle = "Unranked"

		 if rankPoints > 0 then
			 local ranks = {
				 [25] = "Huntsman",
				 [50] = "Ranger",
				 [100] = "Big Game Hunter",
				 [150] = "Trophy Hunter",
				 [200] = "Pro Hunter",
				 [250] = "Elite Hunter"
			 }

			 local highestRank = ""
			 for points, title in pairs(ranks) do
				 if rankPoints >= points then
					 highestRank = title
				 end
			 end

			 if highestRank ~= "" then
				 rankTitle = highestRank
			 end
		 end

		 description = description .. "\nRank de Tasks: " .. rankTitle
	end

	 local strKills = "%s\n[Kills: %d]\n[Deaths: %d]"
	 if thing:isPlayer() then
		 description = string.format(strKills, description, math.max(thing:getStorageValue(STORAGE_KILL_COUNT), 0), math.max(thing:getStorageValue(STORAGE_DEATH_COUNT), 0))
	 end

	if self:getGroup():getAccess() then
		if thing:isItem() then
			description = string.format("%s\nItem ID: %d", description, thing:getId())

			local actionId = thing:getActionId()
			if actionId ~= 0 then
				description = string.format("%s, Action ID: %d", description, actionId)
			end

			local uniqueId = thing:getAttribute(ITEM_ATTRIBUTE_UNIQUEID)
			if uniqueId > 0 and uniqueId < 65536 then
				description = string.format("%s, Unique ID: %d", description, uniqueId)
			end

			local itemType = thing:getType()

			local transformEquipId = itemType:getTransformEquipId()
			local transformDeEquipId = itemType:getTransformDeEquipId()
			if transformEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onEquip)", description, transformEquipId)
			elseif transformDeEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onDeEquip)", description, transformDeEquipId)
			end

			local decayId = itemType:getDecayId()
			if decayId ~= -1 then
				description = string.format("%s\nDecays to: %d", description, decayId)
			end

			-- Show remaining decay time for GMs/Gods
			if thing:getDuration() > 0 then
				local remainingTime = thing:getRemainingDuration()
				local remainingSeconds = remainingTime / 1000
				if remainingSeconds > 0 then
					description = string.format("%s\nDuration left: %d seconds (%.1f minutes)", description, remainingSeconds, remainingSeconds / 60)
				else
					description = string.format("%s\nDuration left: 0 seconds (expired)", description)
				end
			end
			
		elseif thing:isCreature() then
			local str = "%s\nHealth: %d / %d"
			if thing:isPlayer() and thing:getMaxMana() > 0 then
				str = string.format("%s, Mana: %d / %d", str, thing:getMana(), thing:getMaxMana())
			end
			description = string.format(str, description, thing:getHealth(), thing:getMaxHealth()) .. "."
		end

		local position = thing:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)

		if thing:isCreature() then
			if thing:isPlayer() then
			    description = string.format("%s\nGUID: %s", description, thing:getGuid())
				description = string.format("%s\nIP: %s.", description, Game.convertIpToString(thing:getIp()))
			end
		end
	end
	return description
end

event:register()
