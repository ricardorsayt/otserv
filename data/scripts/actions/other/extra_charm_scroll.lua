local EXTRA_CHARM_STORAGE = 555556
local MAX_EXTRA_CHARMS = 2

local function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or target:getId() ~= player:getId() then
        player:sendCancelMessage("You can only use this item on yourself.")
        return true
    end

    local getExtraCharm = player:getStorageValue(EXTRA_CHARM_STORAGE) > 1 and player:getStorageValue(EXTRA_CHARM_STORAGE) or 1
    if getExtraCharm > MAX_EXTRA_CHARMS then
        player:sendCancelMessage("Sorry, you already have the maximum number of Extra Charms.")
        return true
    end

    player:setStorageValue(EXTRA_CHARM_STORAGE, getExtraCharm + 1)
    local coins = json.encode({
        action = "coins",
        data = {
            charm = (getCharmCoin(player) > 0 and getCharmCoin(player) or 0),
            extracharm = tonumber(player:getStorageValue(EXTRA_CHARM_STORAGE)),
            gold = player:getMoney()
        }
    })
    player:sendExtendedOpcode(92, coins)

    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    player:sendCancelMessage("You received 1 Extra Charm.")
    item:remove()
    return true
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return onUse(player, item, fromPosition, target, toPosition, isHotkey)
end

action:id(5587)
action:register()
