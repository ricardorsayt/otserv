local CONFIG = {[5128] = {[0] = 286, [1] = 285}}

local action = Action()

function action.onUse(player, item, fromPos, target, toPos, isHotkey)

    if not target:isPlayer() then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to use this on a player.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    local lookType = CONFIG[item:getId()][target:getSex()]
    if not target:hasOutfit(lookType) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to have Brotherhood of Bones outfit before adding the addons.")
        target:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if target:hasOutfit(lookType, 1) and target:hasOutfit(lookType, 2) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have both addons for Brotherhood of Bones outfit.")
        target:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if not target:hasOutfit(lookType, 1) then
        target:addOutfitAddon(lookType, 1)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Addon 1 of Brotherhood of Bones outfit achieved.")
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    else
        if not target:hasOutfit(lookType, 2) then
            target:addOutfitAddon(lookType, 2)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Addon 2 of Brotherhood of Bones outfit achieved.")
            target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        end
    end

    item:remove()
    return true
end

for id, _ in pairs(CONFIG) do action:id(id) end
action:register()
