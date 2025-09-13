local ec = EventCallback

ec.onMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if toPosition.x ~= CONTAINER_POSITION then
		local tile = Tile(toPosition)
		if tile then
			local mailbox = tile:getItemByType(ITEM_TYPE_MAILBOX)
			if mailbox then
				local itemId = item:getId()		
				if itemId == ITEM_PARCEL or itemId == ITEM_LETTER then 
					logger.gameLog(self:getName() .. " moved a " .. item:getName() .. " onto a mailbox.")
					if mailbox:isItemAccountBound() and not mailbox:canUseItemAccountBound(self) then
						return RETURNVALUE_YOUARENOTTHEOWNER
					end
				end
			end
		end

		if Game.getStorageValue(GlobalStorageKeys.edronDemonScroll) ~= 1 then
			if item.itemid == 1953 then
				if fromPosition.x == 33063 and fromPosition.y == 31624 and fromPosition.z == 15 then
					Game.createMonster("Demon", {x = 33060, y = 31623, z = 15}, true)
					Game.createMonster("Demon", {x = 33066, y = 31623, z = 15}, true)
					Game.createMonster("Demon", {x = 33066, y = 31627, z = 15}, true)
					Game.createMonster("Demon", {x = 33060, y = 31627, z = 15}, true)
				
					Game.sendMagicEffect({x = 33060, y = 31622, z = 15}, 14)
					Game.sendMagicEffect({x = 33066, y = 31622, z = 15}, 14)
					Game.sendMagicEffect({x = 33066, y = 31628, z = 15}, 14)
					Game.sendMagicEffect({x = 33060, y = 31628, z = 15}, 14)
					
					Game.setStorageValue(GlobalStorageKeys.edronDemonScroll, 1)
				end
			end
		end

		return true
	end


	return true
end

ec:register()
