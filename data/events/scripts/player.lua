function Player:onLook(thing, position, distance)
	local description = ""
	if hasEventCallback(EVENT_CALLBACK_ONLOOK) then
		description = EventCallback(EVENT_CALLBACK_ONLOOK, self, thing, position, distance, description)
	end
	if thing:isItem() and (thing:getActionId() == 1224 or thing:getActionId() == 1040) then
		self:sendTextMessage(MESSAGE_INFO_DESCR, "You see a loose board.")
		return
	end

	if thing:isItem() then
		local wrap = thing:getCustomAttribute("wrap")
		if wrap then
			if thing:isPackage() then
				local it = ItemType(wrap)
				local amount = thing:getCustomAttribute("wrap_amount")
				if amount then
					self:sendTextMessage(MESSAGE_INFO_DESCR, string.format("%s\nCan be unpacked to %s (%dx).", description, it:getName(), amount))
					return
				else
					self:sendTextMessage(MESSAGE_INFO_DESCR, string.format("%s\nCan be unpacked to %s.", description, it:getName()))
					return
				end
			else
				self:sendTextMessage(MESSAGE_INFO_DESCR, string.format("%s\nCan be packed again.", description))
				return
			end
		end
	end

	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInBattleList(creature, distance)
	local description = ""
	if hasEventCallback(EVENT_CALLBACK_ONLOOKINBATTLELIST) then
		description = EventCallback(EVENT_CALLBACK_ONLOOKINBATTLELIST, self, creature, distance, description)
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInTrade(partner, item, distance)
	local description = "You see " .. item:getDescription(distance)
	if hasEventCallback(EVENT_CALLBACK_ONLOOKINTRADE) then
		description = EventCallback(EVENT_CALLBACK_ONLOOKINTRADE, self, partner, item, distance, description)
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onUseItem(item)
	if self:getGroup():getAccess() then	
		if onUseRope(self, item, item:getPosition(), item, item:getPosition()) or onUsePick(self, item, fromPosition, item, item:getPosition()) or
		onUseShovel(self, item, item:getPosition(), item, item:getPosition()) or onUseScythe(self, item, fromPosition, item, item:getPosition()) or
		onUseMachete(self, item, item:getPosition(), item, item:getPosition()) then
		return true
		end
	end
	
	if hasEventCallback(EVENT_CALLBACK_ONUSEITEM) then
		return EventCallback(EVENT_CALLBACK_ONUSEITEM, self, item)
	end
	return false
end

function Player:onItemUsed(item, target)
	if hasEventCallback(EVENT_CALLBACK_ONITEMUSED) then
		EventCallback(EVENT_CALLBACK_ONITEMUSED, self, item, target)
	end
end

function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	-- Do not allow moving of map quest objects
	if item:getActionId() >= 1000 and item:getActionId() <= 2000 then
		return RETURNVALUE_NOTMOVEABLE
	end
	
	-- Convert permanent candelabrum into expiring candelabrum
	if item:getId() == 2057 then
		item:transform(2042)
	end
	
	if item:getId() == 2579 then
		item:transform(2578)
		item:removeCustomAttribute("PlayerHunter")
		toCylinder:getPosition():sendMagicEffect(CONST_ME_POFF)
	end

	if fromCylinder and toCylinder then
		local container
		local ignoreCheck = false
		if toPosition.x == CONTAINER_POSITION and toCylinder:isPlayer() then
			local tmpContainer = toCylinder:getContainerById(toPosition.y - 64)
			if tmpContainer then
				container = tmpContainer:getItem(toPosition.z)
			else
				container = toCylinder:getSlotItem(toPosition.y)
			end
			ignoreCheck = true
		elseif toCylinder:isContainer() then
			container = toCylinder
		end

		if container then
			local pouch = container

			if not ignoreCheck and container:isContainer() and (pouch:getId() ~= ITEM_GOLD_POUCH) and toPosition.x == CONTAINER_POSITION then
				pouch = container:getItem(toPosition.z)
			end

			if pouch then
				if pouch:getId() == ITEM_GOLD_POUCH then
					if fromCylinder.uid ~= pouch.uid then
						local id = item:getId()
						if not (id == ITEM_GOLD_COIN or id == ITEM_PLATINUM_COIN or id == ITEM_CRYSTAL_COIN) then
							return RETURNVALUE_CANNOTMOVEITEMINSIDEGOLDPOUCH
						end
					end
				end
			end
		end
	end

	if toCylinder:isTile() and toCylinder:getGround() and toCylinder:getGround():getActionId() == actionIds.blockingTile then
		return RETURNVALUE_NOTENOUGHROOM
	end

	local fromTile, toTile = Tile(fromPosition), Tile(toPosition)
	if item:isItemAccountBound() then
		if fromTile and toTile then
			local fromHouse, toHouse = fromTile:getHouse(), toTile:getHouse()
			if fromHouse and not toHouse then
				return RETURNVALUE_ITEMCANNOTBEMOVEDTHERE
			end
		end
	end

	if hasEventCallback(EVENT_CALLBACK_ONMOVEITEM) then
		return EventCallback(EVENT_CALLBACK_ONMOVEITEM, self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	end
	return RETURNVALUE_NOERROR
end

function Player:onItemMoved(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if hasEventCallback(EVENT_CALLBACK_ONITEMMOVED) then
		EventCallback(EVENT_CALLBACK_ONITEMMOVED, self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	end
end

function Player:onItemRemoved(item)
	if hasEventCallback(EVENT_CALLBACK_ONITEMREMOVED) then
		EventCallback(EVENT_CALLBACK_ONITEMREMOVED, self, item)
	end
end

function Player:onItemTransformed(item)
	if hasEventCallback(EVENT_CALLBACK_ONITEMTRANSFORMED) then
		EventCallback(EVENT_CALLBACK_ONITEMTRANSFORMED, self, item)
	end
end

function Player:onMoveCreature(creature, fromPosition, toPosition)
	if hasEventCallback(EVENT_CALLBACK_ONMOVECREATURE) then
		return EventCallback(EVENT_CALLBACK_ONMOVECREATURE, self, creature, fromPosition, toPosition)
	end
	return true
end

function Player:onReportBug(message, position, category)
	if hasEventCallback(EVENT_CALLBACK_ONREPORTBUG) then
		return EventCallback(EVENT_CALLBACK_ONREPORTBUG, self, message, position, category)
	end
	return true
end

function Player:onTurn(direction)
	if hasEventCallback(EVENT_CALLBACK_ONTURN) then
		return EventCallback(EVENT_CALLBACK_ONTURN, self, direction)
	end
	return true
end

function Player:onTradeRequest(target, item)
	if hasEventCallback(EVENT_CALLBACK_ONTRADEREQUEST) then
		return EventCallback(EVENT_CALLBACK_ONTRADEREQUEST, self, target, item)
	end
	return true
end

function Player:onTradeAccept(target, item, targetItem)
	if hasEventCallback(EVENT_CALLBACK_ONTRADEACCEPT) then
		return EventCallback(EVENT_CALLBACK_ONTRADEACCEPT, self, target, item, targetItem)
	end
	return true
end

function Player:onTradeCompleted(target, item, targetItem, isSuccess)
	if hasEventCallback(EVENT_CALLBACK_ONTRADECOMPLETED) then
		EventCallback(EVENT_CALLBACK_ONTRADECOMPLETED, self, target, item, targetItem, isSuccess)
	end
end

local soulCondition = Condition(CONDITION_SOUL, CONDITIONID_DEFAULT)
soulCondition:setTicks(4 * 60 * 1000)
soulCondition:setParameter(CONDITION_PARAM_SOULGAIN, 1)

local function useStamina(player)
	local staminaMinutes = player:getStamina()
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	local currentTime = os.time()
	local timePassed = currentTime - nextUseStaminaTime[playerId]
	if timePassed <= 0 then
		return
	end

	if timePassed > 60 then
		if staminaMinutes > 2 then
			staminaMinutes = staminaMinutes - 2
		else
			staminaMinutes = 0
		end
		nextUseStaminaTime[playerId] = currentTime + 120
	else
		staminaMinutes = staminaMinutes - 1
		nextUseStaminaTime[playerId] = currentTime + 60
	end
	player:setStamina(staminaMinutes)
end

function Player:onGainExperience(source, exp, rawExp)
	if not source or source:isPlayer() then
		return exp
	end

	-- Soul regeneration
	local vocation = self:getVocation()
	if self:getSoul() < vocation:getMaxSoul() and exp >= self:getLevel() then
		soulCondition:setParameter(CONDITION_PARAM_SOULTICKS, vocation:getSoulGainTicks() * 1000)
		self:addCondition(soulCondition)
	end

	--Experience star buff:
	if source:isElite() then
		local expExtra = geBestiaryConfigByStarAndExperience(source:getType():experience(), source:getStar()).experience
		local bonus = exp * (expExtra / 100)
		exp = exp + math.ceil(bonus)
	end

	-- Apply experience stage multiplier
	exp = exp * Game.getExperienceStage(self:getLevel())

	-- Stamina modifier
	if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
		useStamina(self)

		local staminaMinutes = self:getStamina()
		if staminaMinutes > 2400 and self:isPremium() then
			exp = exp * 1.5
		elseif staminaMinutes <= 840 then
			exp = exp * 0.5
		end
	end

	local partyBonus = 0
	local vocations = {}

	local party = self:getParty()
	if party then

		local members = party:getMembers()
		table.insert(members, party:getLeader())

		if #members > 1 then

			for _, member in pairs(members) do
				local vocationId = member:getVocation():getClientId()
				if vocations[vocationId] then
					partyBonus = 10
					break
				end
				vocations[vocationId] = true
				partyBonus = partyBonus + 5
			end
		end

	end


	exp = exp * (1 + partyBonus / 100)

	return hasEventCallback(EVENT_CALLBACK_ONGAINEXPERIENCE) and EventCallback(EVENT_CALLBACK_ONGAINEXPERIENCE, self, source, exp, rawExp) or exp
end

function Player:onLoseExperience(exp)
	return hasEventCallback(EVENT_CALLBACK_ONLOSEEXPERIENCE) and EventCallback(EVENT_CALLBACK_ONLOSEEXPERIENCE, self, exp) or exp
end

function Player:onGainSkillTries(skill, tries)
	if APPLY_SKILL_MULTIPLIER == false then
		return hasEventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES) and EventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES, self, skill, tries) or tries
	end

	if skill == SKILL_MAGLEVEL then
		tries = tries * configManager.getNumber(configKeys.RATE_MAGIC)
		return hasEventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES) and EventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES, self, skill, tries) or tries
	end
	tries = tries * configManager.getNumber(configKeys.RATE_SKILL)
	return hasEventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES) and EventCallback(EVENT_CALLBACK_ONGAINSKILLTRIES, self, skill, tries) or tries
end

function Player:onRookedEvent()
	-- Should be adjusted to fit your storage value needs
	-- By default this resets CipSoft game quest values entirely
	for i = 0, 500 do
		self:setStorageValue(i, -1)
	end
end

function Player:onBestiaryKill(monster)
	
	if monster:getMaster() then -- ignore summon
		return true 
	end

	local monsterType = monster:getType()
	local id = monsterType:bestiaryId()
	local maxKill = monsterType:bestiaryMastery()
	local player = self

	local party = self:getParty()
	if party then

		local leader = party:getLeader()
		player = leader

		if party:isSharedExperienceEnabled() then
			if leader:getBestiaryKill(id) >= maxKill then
				local members = party:getMembers()
				local damageMap = monster:getDamageMap()
				table.sort(members, function(m_a, m_b)
					local damage_a = 0
					if damageMap[m_a:getId()] then
						damage_a = damageMap[m_a:getId()].total
					end

					local damage_b = 0
					if damageMap[m_b:getId()] then
						damage_b = damageMap[m_b:getId()].total
					end


					return damage_a > damage_b
				end)

				for _, m in ipairs(members) do
					local memberKills = m:getBestiaryKill(id)
					if memberKills <= maxKill then
						player = m
						break
					end
				end
			end

		end
	end

	sendRewardCharm(player, monsterType, math.floor(player:getBestiaryKill(id)), math.floor(player:getBestiaryKill(id)+1))
	player:addBestiaryKill(id)
	Bestiary.send(player, "bestiaryKill", { [monsterType:name()] = math.min(maxKill, player:getBestiaryKill(id)) })
	G_MONSTERSTAR.processPoints(player, monster)

	if hasEventCallback(EVENT_CALLBACK_ONBESTIARYKILL) then
		return EventCallback(EVENT_CALLBACK_ONBESTIARYKILL, self, monster)
	end
end
