local SMALL_STONE = 1294

function Item.moveToPouch(self, pouches, player)
    -- should return collected, remained and collected+remained = initial amount

    local freeCap = player:getFreeCapacity()
    local itemId = self:getId()
    local one_weight = ItemType(itemId):getWeight()
    local initialAmount = self:getCount()

    local amount = math.floor(freeCap / one_weight) -- limited by cap
    amount = math.min(amount, initialAmount)

    local collectedAmount, cacheAmount = 0, amount

    for _, pouch in pairs(pouches) do
        if amount == 0 then
            break
        end

        if pouch:getSize() < pouch:getCapacity() then -- has free slot
            if pouch:addItem(itemId, amount) then -- Adicionou tudo!
                self:transform(itemId, initialAmount - amount)
                collectedAmount = amount
            end
            break
        end

        -- Não há free slot

        for _, slotItem in pairs(pouch:getItems()) do

            if amount == 0 then
                break
            end

            if slotItem:getId() == itemId then
                local slotAmount = slotItem:getCount()
                local newSlotAmount = math.min(slotAmount + amount, 100)
                local collected = (newSlotAmount - slotAmount)

                amount = amount - collected
                collectedAmount = collectedAmount + collected
                
                slotItem:transform(itemId, newSlotAmount)
            end
        end
    end

    self:transform(itemId, initialAmount - collectedAmount)
    return collectedAmount
end

function hasSoulBound(pouch)
    local soulBound = pouch:getCustomAttribute("soulbound")
    return soulBound and soulBound > 0
end

function checkSoulBound(player, pouch)
    local soulBound = pouch:getCustomAttribute("soulbound")
    local bound = false
    if soulBound and soulBound > 0 then
        if tonumber(soulBound) == player:getGuid() then
            bound = true
        end
    end
    return bound
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition)
    local parent = item:getParent()
    if parent then
        if parent:isItem() then
            if parent:getId() == ITEM_SMALLSTONE_POUCH then
                player:sendCancelMessage("This stone already is in the stone pouch.")
                return true
            end
        end
    end

    local pouches = player:getPouches(ITEM_SMALLSTONE_POUCH)
    
    local amount = item:getCount()
    
    if #pouches > 0 then
        local topParent = item:getTopParent()
        if not topParent or topParent:isTile() or topParent and not isPlayer(topParent.uid) then

            local unityWeight = ItemType(item:getId()):getWeight()
            local max = math.floor(player:getFreeCapacity() / unityWeight)

            if max <= 0 then
                player:sendCancelMessage("You don't have enough capacity to move this stones to the stone pouch.")
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

    local iName = item:getName()
    local initial_amount = item:getCount()

    local str = ""

    local collected_amount = item:moveToPouch(pouches, player)

    if fromCorpse then
        sendPlayerLootStatistics(player, "loot", item:getCount(), item:getId(), -1)
    end

    if #pouches > 0 then
        if collected_amount > 0 and collected_amount < initial_amount then
            local name = iName .. (collected_amount and "s" or "")

            local unityWeight = ItemType(item:getId()):getWeight()
            local max = math.floor(player:getFreeCapacity() / unityWeight)

            if max <= 0 then
                str = string.format("%sYou collected %dx %s. You don't have enough capacity to collect more.", str, collected_amount, name)
            else
                str = string.format("%sYou collected %dx %s. The stone pouch is full now.", str, collected_amount, name)
            end

        elseif collected_amount > 0 then
            local name = iName .. (collected_amount and "s" or "")
            str = string.format("%sYou collected %dx %s to your stone pouch. ", str, collected_amount, name)
        elseif collected_amount < initial_amount then
            str = string.format("%sYour stone pouch is already full. ", str)
        end

        if str:len() > 0 then
            player:sendCancelMessage(str)
        end
    end

    return true
end

action:id(SMALL_STONE)
action:register()

local weapon = Weapon(WEAPON_DISTANCE)

weapon:action("move")

function weapon.onUseWeapon(player, var, hit, stone)

    local weapon = player:getSlotItem(CONST_SLOT_LEFT)
    if not weapon then
        weapon = player:getSlotItem(CONST_SLOT_RIGHT)
    end

    if weapon then
        if weapon:getId() == ITEM_SMALLSTONE_POUCH then
            if not hasSoulBound(weapon) then
                weapon:setCustomAttribute("soulbound", player:getGuid())
            elseif not checkSoulBound(player, weapon) then
                player:sendCancelMessage("This item is soul bound to another player.")
                return false
            end

            weapon:setCustomAttribute("ITEM_CUSTOM_ATTRIBUTE_DESCRIPTION", "This item is soul bound to " .. player:getName())
        end
    end

    local function finish_collect_small_stone(collected_amount, limitedByCap)
        local message = ""

        if collected_amount > 0 then
            message = string.format("%sYou picked up %d small stones.", message, collected_amount)
        end
        if limitedByCap then
            message = string.format("%s You don't have capacity to pick everything.", message)
        end
        if message:len() > 0 then
            player:sendCancelMessage(message)
        end
    end

    local function slow_collect_small_stone(player, thing)
        local _pouches, pouches = player:getPouches(ITEM_SMALLSTONE_POUCH), {}

        for _, pouch in pairs(_pouches) do
            if checkSoulBound(player, pouch) then
                table.insert(pouches, pouch)
            end
        end

        thing:getPosition():sendMagicEffect(CONST_ME_POFF)
        local collected = thing:moveToPouch(pouches, player)
        finish_collect_small_stone(collected, false)
    end

    if stone and stone:getCount() == 1 then


        local maxAmount = math.min(100, math.floor(player:getFreeCapacity() / ItemType(SMALL_STONE):getWeight()))
        if maxAmount <= 0 then
            return true
        end

        local playerId = player:getId()

        addEvent(function()
        
            local player = Player(playerId)
            
            if not player then return true end

            local highestStone, highestAmount = nil, 0

            for x = -1, 1 do
                for y = -1, 1 do
                    local position = player:getPosition() + Position(x, y, 0)
                    local tile = Tile(position)
                    if tile then
                        local items = tile:getItems()
                        if items then
                            for i = 1, #items do
                                local thing = items[i]
                                if thing and thing:isItem() and thing:getId() == SMALL_STONE then

                                    local initial_amount = thing:getCount()

                                    if initial_amount >= maxAmount then
                                        slow_collect_small_stone(player, thing)
                                        return true
                                    end

                                    if initial_amount > highestAmount then
                                        highestStone = thing
                                        highestAmount = initial_amount
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if highestStone then
                slow_collect_small_stone(player, highestStone)
            end

        end, 2000)
    end
    return true
end

weapon:id(SMALL_STONE) -- Small stone
weapon:breakChance(5)
weapon:register()
