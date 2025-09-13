local ec = EventCallback

local itemsToIgnore = {
	[2148] = {}, -- gold coin
	[2152] = {}, -- platinum coin
	[2160] = {}  -- crystal coin
}

function sendPlayerLootStatistics(self, category, _amount, _itemId, _subType)
	local payload = {
		category = category,
		amount = _amount,
		itemId = _itemId,
		itemSubType = _subType
	}

	self:sendExtendedOpcode(GameServerOpcodes.GameServerLootStatistics, json.encode(payload))
end

ec.onItemMoved = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	local itemId = item:getId()
	local itemType = ItemType(itemId)
	local subType = -1
	local fromValidCondition = false 
	local toValidCondition = false
	
	if fromPosition ~= nil and fromCylinder ~= nil and fromCylinder.getTopParent ~= nil then
		fromValidCondition = fromPosition.x == CONTAINER_POSITION and ItemType(fromCylinder:getTopParent():getId()):isCorpse()
	end

	if itemType:isFluidContainer() then
		subType = item:getSubType()
	end

	if toPosition ~= nil and toCylinder ~= nil and toCylinder.getTopParent ~= nil then
		toValidCondition = toPosition.x == CONTAINER_POSITION and (toCylinder:getTopParent() == self)
	end

	if fromValidCondition and toValidCondition then
		sendPlayerLootStatistics(self, "loot", count, itemId, subType)
		return true
	end
    
    return true
end

ec:register()

ec.onItemRemoved = function(self, item)
	local itemId = item:getId()
	local itemType = ItemType(itemId)
	local subType = -1

	local isOwnByPlayer = item:getTopParent() == self

	local isValid = isOwnByPlayer

	if itemType:isFluidContainer() then
		subType = item:getSubType()
	end

	local transformDeEquipId = itemType:getTransformDeEquipId()
	if transformDeEquipId ~= 0 then
		itemId = transformDeEquipId
	end

	-- send only items out of ignore list and owned by player
	if not itemsToIgnore[itemId] and isOwnByPlayer then
		sendPlayerLootStatistics(self, "supply", 1, itemId, subType)
	end

	return true
end

ec:register()

ec.onItemTransformed = function(self, item)
	local itemId = item:getId()
	local itemType = ItemType(itemId)
	local subType = -1
	local isOwnByPlayer = item:getTopParent() == self

	-- skip items with no subtype
	if not itemType:hasSubType() then
		return true
	end

	if itemType:isFluidContainer() then
		subType = item:getSubType()
	end

	-- send only fluid containers. Chargeables are going to be sent on remove event
	if itemType:isFluidContainer() or itemType:isStackable() then

		-- send only items out of ignore list and owned by player
		if not itemsToIgnore[itemId] and isOwnByPlayer then
			sendPlayerLootStatistics(self, "supply", 1, itemId, subType)
		end
	end

	return true
end

ec:register()