local quiverbolts = { 5545, 5091, 5107 }
local quiverarrows = { 5546, 5090, 5106 }

local quivers_by_ammotype = {}
local ammos_by_quivertype = {}

for i = 2500, 6000 do --INFO: Should be enough to cover all the items
    local itemType = ItemType(i)
    if itemType then
        local weaponType = itemType:getWeaponType()
        local ammoType = itemType:getAmmoType()

        if weaponType == WEAPON_QUIVER then
            if not quivers_by_ammotype[ammoType] then
                quivers_by_ammotype[ammoType] = {}
            end
            table.insert(quivers_by_ammotype[ammoType], i)
        elseif weaponType == WEAPON_AMMO then
            if not ammos_by_quivertype[ammoType] then
                ammos_by_quivertype[ammoType] = {}
            end
            table.insert(ammos_by_quivertype[ammoType], i)
        end
    end
end

local quivers = {}

for type, ammos in pairs(ammos_by_quivertype) do
    for _, ammo in pairs(ammos) do
        quivers[ammo] = {}
        for _, quiver in pairs(quivers_by_ammotype[type]) do
            table.insert(quivers[ammo], quiver)
        end
    end
end

local check_pair = {}

for ammo, items in pairs(quivers) do
    check_pair[ammo] = {}
    for _, item in pairs(items) do
        check_pair[ammo][item] = true
    end
end

function Player:addQuiverAmmo(itemId, amount)
    if quivers[itemId] then
        local weight = ItemType(itemId):getWeight() * amount

  
        if self:getFreeCapacity() > weight then
            local pouches = {}
    
            for _, pouchId in pairs(quivers[itemId]) do
                for _, pouch in pairs(self:getPouches(pouchId)) do
                    table.insert(pouches, pouch)
                end
            end

            if #pouches > 0 then
                local item = Game.createItem(itemId, amount)
                if item then
                    if item:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
                        item:decay()
                    end

                    local initial_amount = item:getCount()

                    local collected_amount = item:moveToPouch(pouches, self)
                    if collected_amount >= initial_amount then
                        self:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
                        return true
                    end

                    item:remove()
                    amount = initial_amount - collected_amount
                end
            end
        end
    end

    local item = self:addItem(itemId, amount)

    if not item then
        self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        self:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    if item:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
        item:decay()
    end

    self:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)

    return true
end

function Player:addConjureAmmo(conjureMana, conjureId, conjureCount)
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

    return self:addQuiverAmmo(conjureId, conjureCount)
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition)
    if quivers[item:getId()] then

        local parent = item:getParent()
        if parent then
            if parent:isItem() then
                if check_pair[item:getId()] and check_pair[item:getId()][parent:getId()] then
                    player:sendCancelMessage("This ammunition already is in the quiver.")
                    return true
                end
            end
        end

        local pouches = {}

        for _, pouchId in pairs(quivers[item:getId()]) do
            for _, pouch in pairs(player:getPouches(pouchId)) do
                table.insert(pouches, pouch)
            end
        end

        if #pouches > 0 then
            local topParent = item:getTopParent()
            if not topParent or topParent:isTile() or topParent and not isPlayer(topParent.uid) then

                local unityWeight = ItemType(item:getId()):getWeight()
                local max = math.floor(player:getFreeCapacity() / unityWeight)

                if max <= 0 then
                    player:sendCancelMessage("You don't have enough capacity to collect those ammos to the quiver.")
                    return true
                end
            end
        end

        local iName = item:getName()
        local initial_amount = item:getCount()
        local str = ""

        local initial_amount = item:getCount()
        local collected_amount = item:moveToPouch(pouches, player)
        
        if #pouches > 0 then

            if collected_amount > 0 and collected_amount < initial_amount then
                local name = iName .. (collected_amount and "s" or "")

                local unityWeight = ItemType(item:getId()):getWeight()
                local max = math.floor(player:getFreeCapacity() / unityWeight)

                if max <= 0 then
                    str = string.format("%sYou collected %dx %s. You don't have enough capacity to collect more.", str, collected_amount, name)
                else
                    str = string.format("%sYou collected %dx %s. The quiver are full now.", str, collected_amount, name)
                end

            elseif collected_amount > 0 then
                local name = iName .. (collected_amount and "s" or "")
                str = string.format("%sYou collected %dx %s to your quiver. ", str, collected_amount, name)
            elseif collected_amount < initial_amount then
                str = string.format("%sYour quiver is already full. ", str)
            end

            if str:len() > 0 then
                player:sendCancelMessage(str)
            end
        end
    end
    return true
end

for id, _ in pairs(quivers) do
    action:id(id)
end

action:register()
