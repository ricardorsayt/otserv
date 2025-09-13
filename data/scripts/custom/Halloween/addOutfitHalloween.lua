local CONFIG = {
    [5126] = {
        [0] = 286,
        [1] = 285
    }
}

local action = Action()

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
    local lookType = CONFIG[item:getId()][player:getSex()]
    if player:hasOutfit(lookType) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already own Brotherhood of Bones outfit.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    else
        player:addOutfit(lookType) 
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You just achieved Brotherhood of Bones outfit.")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        item:remove(1)
    end

    return true
end

for id,_ in pairs(CONFIG) do
    action:id(id)
end
action:register()