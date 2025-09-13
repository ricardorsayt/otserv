local OPEN_FURNITURE = 5162
local CLOSED_FURNITURE = 5163

local CONFIG = {
    PACKS = {
        CLOSED_FURNITURE, 5164 -- closed package and tiles
    }
}

function Item.isPackage(self)
    return table.contains(CONFIG.PACKS, self:getId())
end

function Item.isPackable(self)
    local wrap = self:getCustomAttribute("wrap")
    if wrap then
        return wrap == CLOSED_FURNITURE
    end

    return false
end

function Item.pack(self, player, amount)

    if not self then return true end

    if not self:getCustomAttribute("wrap") then
        return true
    end

    if not amount then
        amount = 1
    end
    
    local oldId = self:getId()
    self:transform(CLOSED_FURNITURE, 1, player)
    self:setCustomAttribute("wrap", oldId)
    self:setCustomAttribute("wrap_amount", amount)
    self:getPosition():sendMagicEffect(CONST_ME_POFF)
    if player then
        if self:isItemAccountBound() then
            self:onUnpackAccountBoundItem(player)
        end
    end

end

function Item.unpack(self, tile, player)
    local newId = self:getCustomAttribute("wrap")
    self:getPosition():sendMagicEffect(CONST_ME_POFF)
    
    local item = tile:addItem(newId, 1)
    if item then
        item:setCustomAttribute("wrap", CLOSED_FURNITURE)
        if player then
            if item:isItemAccountBound() then
                item:onUnpackAccountBoundItem(player)
            end
        end
        return true
    end

    return false
end

local empty_furniture_action = Action()
function empty_furniture_action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target:isItem() then
        player:sendCancelMessage("You can't use it here.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if not target:getCustomAttribute("wrap") then
        player:sendCancelMessage("You can't use it here.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    local tile = Tile(target:getPosition())
    local house = tile:getHouse()
    if not house then
        player:sendCancelMessage("You need to be in a house.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if target:isItemAccountBound() then
        if not target:canUseItemAccountBound(player) then
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        end
    end
    
    if target:getCustomAttribute("wrap_tile") or target:getCustomAttribute("wrap_border") then -- is wrap tile
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    else
        target:pack(player)
    end

    item:remove()
    
    return true
end

empty_furniture_action:id(OPEN_FURNITURE)
empty_furniture_action:register()

local closed_furniture_action = Action()
function closed_furniture_action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
    if item:isItemAccountBound() then
        if not item:canUseItemAccountBound(player) then
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        end
    end

    local tile = Tile(toPosition)
    if not tile then
        player:sendCancelMessage("You can't use it here.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    local house = tile:getHouse()
    if not house then
        player:sendCancelMessage("You need to use it in a house.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end
    
    if tile:hasFlag(TILESTATE_FLOORCHANGE) then
        player:sendCancelMessage("You can't use it here.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if item:getCustomAttribute("wrap_border") then
        local newId = item:getCustomAttribute("wrap")
        
        local border = tile:getItemByTopOrder(1)
        if border then
            
            if newId == border:getId() then
                player:sendCancelMessage("You are already using it here.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
                return true 
            end

            border:remove()
        end

        local wrap_amount = item:getCustomAttribute("wrap_amount") or 1
        if wrap_amount == 1 then
            item:remove()
        else
            item:setCustomAttribute("wrap_amount", wrap_amount - 1)
        end


        tile:addItem(newId, 1, FLAG_NOLIMIT)

        toPosition:sendMagicEffect(CONST_ME_POFF)
    elseif item:getCustomAttribute("wrap_tile") then
        
        local newId = item:getCustomAttribute("wrap")

        local border = tile:getItemByTopOrder(1)
        
        local ground = Tile(toPosition):getGround()
        if ground then
            
            if ground:getId() == newId and not border then
                player:sendCancelMessage("You are already using it here!")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
                return true
            end

            ground:transform(newId)
        end

        if border then
            border:remove()
        end
        
        local wrap_amount = item:getCustomAttribute("wrap_amount") or 1
        if wrap_amount == 1 then
            item:remove()
        else
            item:setCustomAttribute("wrap_amount", wrap_amount - 1)
        end

        toPosition:sendMagicEffect(CONST_ME_POFF)
    else
        local wrap_amount = item:getCustomAttribute("wrap_amount") or 1
        if item:unpack(tile, player) then
            if wrap_amount == 1 then
                item:remove()
            else
                item:setCustomAttribute("wrap_amount", wrap_amount - 1)
            end
        else
            player:sendCancelMessage("You can't use it here.")
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    end

    return true
end

for _, itemId in pairs(CONFIG.PACKS) do
    closed_furniture_action:id(itemId)
end

closed_furniture_action:register()