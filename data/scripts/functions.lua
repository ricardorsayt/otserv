local BACKPACK_ITEMID = 1988
function onUseQuest(player, chest, quest)
	local storageValue = quest.storageValue

	if player:getStorageValue(storageValue) ~= -1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "The " .. chest:getName() .. " is empty.")
		return true
	end

	local rewards = quest.rewards
	if not quest.rewards then
		rewards = { { item = quest.item, content = quest.content } }
	end

	local reward_weight = #rewards > 1 and ItemType(BACKPACK_ITEMID):getWeight() or 0
	local strings = {}

	local term = #rewards > 1 and "they are" or "it is"

	for _, reward in ipairs(rewards) do
		local itemType = ItemType(reward.item.id)
		if not itemType then
			print("Error on quest reward: " ..
			reward:getActionId() .. " to player " .. player:getName() .. " - item " .. reward.item.id .. " not found")
			return false
		end

		local string
		local amount = math.max(1, reward.item.count or 0)
		if itemType:isStackable() and amount > 1 then
			string = amount .. "" .. itemType:getPluralName()
			term = "they are"
		else
			string = itemType:getName()
		end
		if itemType:getArticle():len() > 0 and amount <= 1 then
			string = string.format("%s %s", itemType:getArticle(), string)
		end

		local weight = itemType:getWeight(reward.item.count)

		if reward.content then
			for _, reward in ipairs(reward.content) do
				local it = ItemType(reward.id)
				if not it then
					print("Error on quest reward: " ..
					chest:getActionId() .. " to player " .. player:getName() .. " - item " .. reward.id .. " not found")
					return true
				end
				weight = weight + it:getWeight(reward.count)
			end
		end

		reward_weight = reward_weight + weight
		table.insert(strings, string)
	end

	local content_info = "a reward" --table.concat(strings, ", ")

	if reward_weight > player:getFreeCapacity() and not getPlayerFlagValue(player, PlayerFlag_HasInfiniteCapacity) then
		player:sendTextMessage(MESSAGE_INFO_DESCR,
			string.format("You have found %s. It weighs %d.%02d oz %s too heavy.",
			content_info,
			math.floor(reward_weight / 100),
			math.floor(reward_weight % 100),
			term))
		return true
	end

	local function apply_reward(item, reward, itemType)
		item:rollRarity(true)

		if reward.item.text then
			item:setAttribute(ITEM_ATTRIBUTE_TEXT, reward.item.text)
		end

		if reward.item.keynumber then
			item:setAttribute(ITEM_ATTRIBUTE_KEYNUMBER, reward.item.keynumber)
		end

		if reward.content and itemType:isContainer() then
			for _, reward_content in ipairs(reward.content) do
				local content = item:addItem(reward_content.id,
					reward_content.count or reward_content.subtype or reward_content.charges or 1, INDEX_WHEREEVER,
					FLAG_IGNOREAUTOSTACK)
				content:rollRarity(true)

				if reward_content.text then
					content:setAttribute(ITEM_ATTRIBUTE_TEXT, reward_content.text)
				end

				if reward_content.keynumber then
					content:setAttribute(ITEM_ATTRIBUTE_KEYNUMBER, reward_content.keynumber)
				end
			end
		end
	end

	local reward
	if #rewards == 1 then
		local rewardInfo = rewards[1]
		local itemType = ItemType(rewardInfo.item.id)
		reward = Game.createItem(itemType:getId(),
			rewardInfo.item.count or rewardInfo.item.subtype or rewardInfo.item.charges or 1)

		if not reward then
			print("Something went wrong creating " ..
			reward:getName() .. " to player " .. player:getName() .. "on quest " .. chest:getActionId())
			return false
		end

		apply_reward(reward, rewardInfo, itemType)
	else
		reward = Game.createItem(BACKPACK_ITEMID, 1)
		for _, rewardInfo in ipairs(rewards) do
			local itemType = ItemType(rewardInfo.item.id)
			local item = reward:addItem(itemType:getId(),
				rewardInfo.count or rewardInfo.subtype or rewardInfo.charges or 1,
				INDEX_WHEREEVER, FLAG_IGNOREAUTOSTACK)

			if not item then
				print("Something went wrong creating " ..
					item:getName() .. " to player " .. player:getName() .. "on quest " .. chest:getActionId())
				return false
			end

			apply_reward(item, rewardInfo, itemType)
		end
	end

	local weight = reward:getWeight()

	if weight > player:getFreeCapacity() then
		reward:remove()
		player:sendTextMessage(MESSAGE_INFO_DESCR,
			string.format("You have found %s. It weighs %d.%02d oz %s too heavy.", content_info,
				math.floor(weight / 100), math.floor(weight % 100), term))
		return true
	end

	local returns = player:addItemEx(reward, false, INDEX_WHEREEVER, FLAG_IGNOREAUTOSTACK)

	if returns ~= RETURNVALUE_NOERROR then
		reward:remove()
		player:sendTextMessage(MESSAGE_INFO_DESCR,
			string.format("You have found %s but you don't have room to take it.", content_info))
		return true
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have found %s.", content_info))

	if not getPlayerFlagValue(player, PlayerFlag_HasInfiniteCapacity) then
		player:setStorageValue(storageValue, 1)
	end

	return true
end

function destroyItem(player, target, toPosition)
	if type(target) ~= "userdata" or not target:isItem() then
		return false
	end

	if target:hasAttribute(ITEM_ATTRIBUTE_UNIQUEID) or target:hasAttribute(ITEM_ATTRIBUTE_ACTIONID) then
		return false
	end

	if toPosition.x == CONTAINER_POSITION then
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return true
	end

	local destroyId = ItemType(target.itemid):getDestroyId()
	if destroyId == 0 then
		return false
	end

	if math.random(7) == 1 then
		local item = Game.createItem(destroyId, 1, toPosition)
		if item then
			item:decay()
		end

		-- Move items outside the container
		if target:isContainer() then
			for i = target:getSize() - 1, 0, -1 do
				local containerItem = target:getItem(i)
				if containerItem then
					containerItem:moveTo(toPosition)
				end
			end
		end

		target:remove(1)
	end

	toPosition:sendMagicEffect(CONST_ME_POFF)
	return true
end

function onUseMachete(player, item, fromPosition, target, toPosition)
	local targetId = target.itemid
	if not targetId then
		return true
	end

	if targetId == 1499 then
		toPosition:sendMagicEffect(CONST_ME_POFF)
		target:remove()
		return true
	end

	local grass = jungleGrass[targetId]
	if grass then
		target:transform(grass)
		target:decay()
		return true
	end

	return destroyItem(player, target, toPosition)
end

function onUsePick_original(player, item, fromPosition, target, toPosition)
	local tile = Tile(toPosition)
	if not tile then
		return false
	end
	
	if tile:getItemByGroup(ITEM_GROUP_SPLASH) then
		target = tile:getGround()
	end
	
	if table.contains(pickGrounds, target.itemid) and target.actionid == actionIds.pickHole then
		target:transform(392) -- decays automatically into normal dirt tile
		target:decay()

		toPosition.z = toPosition.z + 1
		tile:relocateTo(toPosition)
		return true
	end

	return false
end

function onUseKnife(player, item, fromPosition, target, toPosition)
	if not target:isItem() then
		return false
	end
	
	if target:getId() == 2683 then 
		target:transform(2096, 1)
		target:decay()
		return true
	end
	
	return false
end

function onUseRope(player, item, fromPosition, target, toPosition)
	local tile = Tile(toPosition)
	if not tile then
		return false
	end
	
	
	local itemType = ItemType(target.itemid)
	if itemType and itemType:getGroup() == ITEM_GROUP_SPLASH then
		target = tile:getGround()
	end

	if table.contains(ropeSpots, target.itemid) then
		tile = Tile(toPosition:moveUpstairs())
		if not tile then
			return false
		end

		if tile:hasFlag(TILESTATE_PROTECTIONZONE) and player:isPzLocked() then
			player:sendCancelMessage(RETURNVALUE_PLAYERISPZLOCKED)
			return true
		end

		player:teleportTo(toPosition, false)
		return true
	end

	if table.contains(holeId, target.itemid) then
		toPosition.z = toPosition.z + 1
		tile = Tile(toPosition)
		if not tile then
			return false
		end

		local thing = tile:getBottomCreature() or tile:getTopDownItem()
		if not thing then
			return true
		end

		if thing:isCreature() then
			return thing:teleportTo(toPosition:moveUpstairs(), false)
		elseif thing:isItem() and thing:getType():isMovable() then
			return thing:moveTo(toPosition:moveUpstairs())
		end

		return true
	end

	return false
end

function onUseShovel(player, item, fromPosition, target, toPosition)
	local tile = Tile(toPosition)
	if not tile then
		return false
	end
	
	local itemType = ItemType(target.itemid)
	if itemType:getGroup() == ITEM_GROUP_SPLASH then
		target = tile:getGround()
	end

	if table.contains(holes, target.itemid) then
		target:transform(target.itemid + 1)
		target:decay()

		toPosition.z = toPosition.z + 1
		tile:relocateTo(toPosition)
	elseif table.contains(sandIds, target.itemid) then
		local randomValue = randomNumber(1, 100)
		if target.actionid == actionIds.sandHole and randomValue <= 20 then
			target:transform(489)
			target:decay()
		else
			checkScarabTile(toPosition)
		end
		toPosition:sendMagicEffect(CONST_ME_POFF)
	else
		return false
	end

	return true
end

function onUseScythe(player, item, fromPosition, target, toPosition)
	if target.itemid == 2739 then -- wheat
		target:transform(2737)
		target:decay()
		Game.createItem(2694, 1, toPosition) -- bunch of wheat
		return true
	elseif target.itemid == 2738 then -- growing wheat
		player:sendCancelMessage("It's not mature yet.")
		return true
	end
	return destroyItem(player, target, toPosition)
end

local logFormat = "[%s] %s %s"

function logCommand(player, words, param)
	local pos = player:getPosition()
	logger.gameLog(logFormat:format(player:getName() .. " at (" .. pos.x .. "," .. pos.y .. "," .. pos.z ..") used command", words, param):trim())
	
	local file = io.open("data/logs/" .. player:getName() .. " commands.log", "a")
	if not file then
		return
	end

	io.output(file)
	io.write(logFormat:format(os.date("%d/%m/%Y %H:%M"), words, param):trim() .. "\n")
	io.close(file)
end

function Player:addPartyCondition(combat, variant, condition, baseMana)
	local party = self:getParty()
	if not party then
		self:sendCancelMessage(RETURNVALUE_NOPARTYMEMBERSINRANGE)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local positions = combat:getPositions(self, variant)
	local members = party:getMembers()
	members[#members + 1] = party:getLeader()

	local affectedMembers = {}
	for _, member in ipairs(members) do
		local memberPosition = member:getPosition()
		for _, position in ipairs(positions) do
			if memberPosition == position then
				affectedMembers[#affectedMembers + 1] = member
			end
		end
	end

	if #affectedMembers <= 1 then
		self:sendCancelMessage(RETURNVALUE_NOPARTYMEMBERSINRANGE)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local mana = math.ceil(#affectedMembers * math.pow(0.9, #affectedMembers - 1) * baseMana)
	if self:getMana() < mana then
		self:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	self:addMana(-mana)
	self:addManaSpent(mana)

	for _, member in ipairs(affectedMembers) do
		member:addCondition(condition)
	end

	for _, position in ipairs(positions) do
		position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end
	return true
end

function Player:conjureItem(conjureMana, reagentId, conjureId, conjureCount, effect)
	local conjureFromHandsOnly = true
	
	if not conjureCount and conjureId ~= 0 then
		local itemType = ItemType(conjureId)
		if itemType:getId() == 0 then
			return false
		end

		local charges = itemType:getCharges()
		if charges ~= 0 then
			conjureCount = charges
		end
	end

	if not conjureFromHandsOnly then
		local reagent = self:getItemById(reagentId, true)
		if reagentId ~= 0 and not reagent then
			self:sendCancelMessage(RETURNVALUE_YOUNEEDAMAGICITEMTOCASTSPELL)
			self:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end

		local item = reagent
		if reagentId == 0 then
			item = self:addItem(conjureId, conjureCount)
			if not item then
				self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				self:getPosition():sendMagicEffect(CONST_ME_POFF)
				return false
			end
		else
			reagent:transform(conjureId, conjureCount)
		end

		if item:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
			item:decay()
		end

		self:getPosition():sendMagicEffect(effect or CONST_ME_MAGIC_RED)
	else
		local leftItem = self:getSlotItem(CONST_SLOT_LEFT)
		local rightItem = self:getSlotItem(CONST_SLOT_RIGHT)
		local totalConjures = 0
		
		if reagentId ~= 0 then
			if leftItem and leftItem:getId() == reagentId then
				leftItem:remove()
				
				local item = self:addItem(conjureId, 1, true, conjureCount, CONST_SLOT_LEFT)
				if not item then
					self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
					self:getPosition():sendMagicEffect(CONST_ME_POFF)
					return false
				end

				if item:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
					item:decay()
				end

				self:getPosition():sendMagicEffect(effect or CONST_ME_MAGIC_RED)
				totalConjures = 1
			end
			
			if rightItem and rightItem:getId() == reagentId then
				local infiniteMana = self:getGroup():hasFlag(PlayerFlag_HasInfiniteMana)
				local notEnoughMana = self:getMana() < conjureMana * 2 and not infiniteMana
				
				if totalConjures == 1 and notEnoughMana then
					-- not enough mana on second hand
					return true
				elseif totalConjures == 1 then
					-- take mana for second hand
					self:addMana(-conjureMana)
					self:addManaSpent(conjureMana)
				end

				rightItem:remove()
				
				local item = self:addItem(conjureId, 1, true, conjureCount, CONST_SLOT_RIGHT)
				if not item then
					self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
					self:getPosition():sendMagicEffect(CONST_ME_POFF)
					return false
				end

				if item:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
					item:decay()
				end

				self:getPosition():sendMagicEffect(effect or CONST_ME_MAGIC_RED)
				totalConjures = totalConjures + 1
			end
			
			if totalConjures == 0 then
				self:sendCancelMessage(RETURNVALUE_YOUNEEDAMAGICITEMTOCASTSPELL)
				self:getPosition():sendMagicEffect(CONST_ME_POFF)
				return false
			end
		else
			local item = self:addItem(conjureId, conjureCount)
			if not item then
				self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				self:getPosition():sendMagicEffect(CONST_ME_POFF)
				return false
			end

			if item:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
				item:decay()
			end

			self:getPosition():sendMagicEffect(effect or CONST_ME_MAGIC_RED)
		end
	end
	
	return true
end

function Player:computeSkillDamage(damage, variation, skill, limitMinimum, limitMaximum)
	local min = damage - variation
	local max = damage + variation
	local formula = (3 * self:getMagicLevel()) + 2 * self:getLevel()
		
	if limitMinimum and formula <= 99 or limitMaximum and formula >= 101 then
		formula = 100
	end

	min = formula * min / 100
	max = formula * max / 100

	-- skills
	min = min * self:getLevel() / 25
	max = max * self:getLevel() / 25
	return -min, -max
end

function Player:computeDamage(damage, variation, limitMinimum, limitMaximum)
	local minimumDamage = damage - variation
	local maximumDamage = damage + variation
	local min = minimumDamage
	local max = maximumDamage
	local formula = (3 * self:getMagicLevel()) + 2 * self:getLevel()

	if limitMinimum and formula <= 99 or limitMaximum and formula >= 101 then
		formula = 100
	end

	min = formula * min / 100
	max = formula * max / 100

	return -min, -max
end

function Player:computeHealing(damage, variation, limitMinimum, limitMaximum)
	local minimumDamage = damage - variation
	local maximumDamage = damage + variation
	local min = minimumDamage
	local max = maximumDamage
	local formula = (3 * self:getMagicLevel()) + 2 * self:getLevel()

	if limitMinimum and formula <= 99 or limitMaximum and formula >= 101 then
		formula = 100
	end

	min = formula * min / 100
	max = formula * max / 100
	return min, max
end

function Creature:addAttributeCondition(parameters)
	local condition = Condition(CONDITION_ATTRIBUTES)
	for _, parameter in ipairs(parameters) do
		if parameter.key and parameter.value then
			condition:setParameter(parameter.key, parameter.value)
		end
	end

	self:addCondition(condition)
end
