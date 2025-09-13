local function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or target:getId() ~= player:getId() then
        player:sendCancelMessage("You can only use this item on yourself.")
        return true
    end

    player:addPremiumDays(60)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    player:sendCancelMessage("60 Premium Account days have been added to your account.")
    item:remove()
    return true
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return onUse(player, item, fromPosition, target, toPosition, isHotkey)
end

action:id(5105)
action:register()