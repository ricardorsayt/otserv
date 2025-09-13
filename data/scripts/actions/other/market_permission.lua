local MARKET_PERMISSION_STORAGE = 175420
local MARKET_PERMISSION_DAYS = 7 -- dias que o scroll adiciona

local function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or target:getId() ~= player:getId() then
        player:sendCancelMessage("You can only use this item on yourself.")
        return true
    end

    local getPackMarket = player:getStorageValue(MARKET_PERMISSION_STORAGE)
    if getPackMarket >= os.time() then
        player:sendCancelMessage("Sorry, you already have a valid Market Permission.")
        return true
    end

    player:setStorageValue(MARKET_PERMISSION_STORAGE, os.time() + (MARKET_PERMISSION_DAYS * 86400))
    local coins = json.encode({
        action = "coins",
        data = {
            charm = (getCharmCoin(player) > 0 and getCharmCoin(player) or 0),
            extracharm = tonumber(player:getStorageValue(555556)),
            gold = player:getMoney()
        }
    })
    player:sendExtendedOpcode(92, coins)

    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    player:sendCancelMessage("You received 7 days of Market Permission.")
    item:remove()
    return true
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return onUse(player, item, fromPosition, target, toPosition, isHotkey)
end

action:id(5586)
action:register()
