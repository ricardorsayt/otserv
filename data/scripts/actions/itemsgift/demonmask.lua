local action = Action()
local STORAGE = 235002

function action.onUse(player, item, fromPosition, target, toPosition)

    if player:getStorageValue(STORAGE) >= 1 then
        player:sendCancelMessage("You have already have this Dummy Skin.")
        return true
    end

    if not player:removeItem(2110, 1) then
        player:sendCancelMessage("This item must be in your inventory to be used.")
        return true
    end

    player:setStorageValue(STORAGE, 1)
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You just received Demon Dummy Skin!")

    return true
end

action:id(5591)
action:register()
