local config = {
    HOME_DEPOTS = { 5155, 5156, 5157, 5158 }
}

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition)
    if not item:canUseItemAccountBound(player) then
        return true
    end

    player:getDepotLocker(12, true) -- create depot 12 home
    return false
end

action:id(unpack(config.HOME_DEPOTS))
action:register()

function Item.isHomeDepot(self)
    return table.contains(config.HOME_DEPOTS, self:getId())
end

function isHomeDepot(itemid)
    return table.contains(config.HOME_DEPOTS, itemid)
end

function Item.isItemAccountBound(self)
    return self:isHomeDepot() or self:getId() == 5159
end

function Item.onUnpackAccountBoundItem(self, player)
    self:setCustomAttribute("wrap_owner", player:getAccountId())
end

function Item.canUseItemAccountBound(self, player)
    if self:getCustomAttribute("wrap_owner") then
        if self:getCustomAttribute("wrap_owner") ~= player:getAccountId() then
            player:sendCancelMessage("You are not the owner.")
            return false
        end
    end
    return true
end