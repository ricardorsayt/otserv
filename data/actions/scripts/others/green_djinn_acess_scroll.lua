local ITEM_ID = 43947 -- ID do Efreet Access Scroll

local startStorage = Storage.DjinnWar.EfreetFaction.Start -- Storage que ativa a quest no Quest Log
local questValue = 1 -- Valor que indica que a quest foi iniciada

local missions = {
    {storage = Storage.DjinnWar.EfreetFaction.Mission01, endvalue = 3}, -- Mission 1: The Supply Thief
    {storage = Storage.DjinnWar.EfreetFaction.Mission02, endvalue = 3}, -- Mission 2: The Tear of Daraman
    {storage = Storage.DjinnWar.EfreetFaction.Mission03, endvalue = 3}, -- Mission 3: The Sleeping Lamp
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local allCompleted = true
    local updated = false

    -- Verifica se todas as missões já foram concluídas
    for _, mission in ipairs(missions) do
        if player:getStorageValue(mission.storage) < mission.endvalue then
            allCompleted = false
            break
        end
    end

    if allCompleted then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already completed the Efreet Faction access.")
        return false
    end

    -- Define as storages das missões corretamente
    for _, mission in ipairs(missions) do
        if player:getStorageValue(mission.storage) < mission.endvalue then
            player:setStorageValue(mission.storage, mission.endvalue)
            updated = true
        end
    end

    -- Garante que a missão apareça no Quest Log
    if player:getStorageValue(startStorage) < questValue then
        player:setStorageValue(startStorage, questValue)
    end

    if updated then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked the Efreet Faction access!")
        item:remove(1)
    end

    return true
end
