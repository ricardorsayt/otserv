-- data/scripts/tibiacoins.lua
local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition)
    if item:getId() ~= 24774 then
        return true
    end

    local amount = item:getCount() -- total na pilha clicada
    player:addCoinsBalance(amount, true)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have added " .. amount .. " coins to your own account!")

    -- consome exatamente a pilha usada
    item:remove(amount)

    -- opcional: só se existir no fork
    if player.sendShopBalance then
        pcall(function() player:sendShopBalance() end)
    end
    return true
end

action:id(24774)
action:register()
