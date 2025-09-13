local CONFIG = {
    USED = {},
    BLESS = {1, 2, 3, 4, 5},
}

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local hasAllBlessings = true
    for i = 1, #CONFIG.BLESS do
        if not player:hasBlessing(CONFIG.BLESS[i]) then
            hasAllBlessings = false
            break
        end
    end

    if hasAllBlessings then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already possess all blessings.")
        return true
    end

    if player:removeMoney(0) then
        for i = 1, #CONFIG.BLESS do
            player:addBlessing(CONFIG.BLESS[i])
        end
        player:updateBlessingStorages()
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You now have all the blessings.")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        CONFIG.USED[player:getGuid()] = true
    end

    item:remove()
    return true
end

action:id(5101)
action:register()
