function onUse(player, item, fromPosition, target, toPosition)
    if (item:getId() == 5092) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have added ".. item:getCount() .." coins to your own account!")
        player:addCoinsBalance(item:getCount(),true)
        player:sendShopBalance()
        item:remove()
    end
    return true
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition)
    return onUse(player, item, fromPosition, target, toPosition)
end

action:id(5092) -- Ravenor coins
action:register()

