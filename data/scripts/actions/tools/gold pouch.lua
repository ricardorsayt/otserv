local config = {
	[ITEM_GOLD_COIN] = {changeTo = ITEM_PLATINUM_COIN},
	[ITEM_PLATINUM_COIN] = {changeBack = ITEM_GOLD_COIN, changeTo = ITEM_CRYSTAL_COIN},
	[ITEM_CRYSTAL_COIN] = {changeBack = ITEM_PLATINUM_COIN}
}

local logging = true

local function get_backpack_coins(items)

	local crystals, platinums, golds = 0, 0, 0
	for _, money in pairs(items) do
		if money:getId() == ITEM_GOLD_COIN then
			golds = golds + money:getCount()
		elseif money:getId() == ITEM_PLATINUM_COIN then
			platinums = platinums + money:getCount()
		elseif money:getId() == ITEM_CRYSTAL_COIN then
			crystals = crystals + money:getCount()
		end
	end

	return crystals, platinums, golds
end

local function add_coin_to_pouch(pouch, coin, count, player)
	if count < 1 then return end
	local tmpCount = count
	local tmpAmount, missingAmount = 0, 0
	for i = 1, math.ceil(count / 100) do
		local amount = math.min(100, tmpCount - (i - 1) * 100)
		local addedCoin = pouch:addItem(coin, amount)
		if logging then
			if not addedCoin then
				missingAmount = missingAmount + amount
			elseif addedCoin:getCount() < amount then
				missingAmount = missingAmount + amount - addedCoin:getCount()
			end
		end
		tmpAmount = tmpAmount + amount
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition)

	local parent = item:getParent()
	if parent then
		if parent:isItem() then
			if parent:getId() == ITEM_GOLD_POUCH then
				player:sendCancelMessage("This coin already is in the gold pouch.")
				return true
			end
		end
	end
	
	local pouches = player:getPouches(ITEM_GOLD_POUCH)

	table.sort(pouches, function(a, b)
		local a_bound = checkSoulBound(player, a) or not hasSoulBound(a)
		local b_bound = checkSoulBound(player, b) or not hasSoulBound(b)

		if a_bound then
			return true
		elseif b_bound then
			return false
		else
			return false
		end
	end)
	
	if #pouches > 0 then
		local topParent = item:getTopParent()
		if not topParent or topParent:isTile() or topParent and not isPlayer(topParent.uid) then
			if player:getFreeCapacity() < item:getWeight(item:getCount()) then
				player:sendCancelMessage("You don't have enough capacity to move this coins to the gold pouch.")
				return true
			end
		end
	end

	local parent = item:getTopParent()
	local fromCorpse = false
	if parent then
		if parent:isItem() then
			local it = ItemType(parent:getId())
			if it then
				if it:isCorpse() then
					fromCorpse = true
				end
			end
		end
	end

	local initial_amount = item:getCount()
	local previous_amount = initial_amount
	local collected_amount = 0

	local str = ""

	for _, gold_pouch in pairs(pouches) do

		if hasSoulBound(gold_pouch) and not checkSoulBound(player, gold_pouch) then
			player:sendCancelMessage("You can't move this coin to the gold pouch because it's soul bound to another player.")
			return true
		end

		local flags = 0
		local moved = item:moveTo(gold_pouch, flags)
		local current_amount = item:getCount()
		
		collected_amount = collected_amount + (previous_amount - current_amount)

		if moved then
			local items = gold_pouch:getItems(true)
			local crystals, platinums, golds = get_backpack_coins(items)
	
			for _, money in pairs(items) do
				money:remove()
			end
	
			add_coin_to_pouch(gold_pouch, ITEM_GOLD_COIN, golds, player)
			add_coin_to_pouch(gold_pouch, ITEM_PLATINUM_COIN, platinums, player)
			add_coin_to_pouch(gold_pouch, ITEM_CRYSTAL_COIN, crystals, player)

			gold_pouch:setCustomAttribute("soulbound", player:getGuid())
			gold_pouch:setCustomAttribute("ITEM_CUSTOM_ATTRIBUTE_DESCRIPTION", "This item is soul bound to " .. player:getName())
			
			collected_amount = initial_amount -- fully collected
			break
		end

		previous_amount = current_amount
	end
	if collected_amount > 0 and fromCorpse then
		sendPlayerLootStatistics(player, "loot", item:getCount(), item:getId(), -1)
	end

	if #pouches > 0 then
		if collected_amount > 0 and collected_amount < initial_amount then
			local name = item:getName() .. (collected_amount and "s" or "")
			str = string.format("%sYou collected %dx %s but you couldn't collect everything because your gold pouch is full.", str, collected_amount, name)

		elseif collected_amount > 0 then
			local name = item:getName() .. (collected_amount and "s" or "")
			str = string.format("%sYou collected %dx %s to your gold pouch. ", str, collected_amount, name)
		elseif collected_amount < initial_amount then
			str = string.format("%sYour gold pouch is full. ", str)
		end
		
		if str:len() > 0 then
			player:sendCancelMessage(str)
		end
	end

	return true
end

action:id(ITEM_GOLD_COIN)
action:id(ITEM_PLATINUM_COIN)
action:id(ITEM_CRYSTAL_COIN)
action:register()
