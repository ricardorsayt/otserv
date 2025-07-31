local ITEM_ID = 43947 -- ID do Marid Access Scroll

local startStorage = Storage.DjinnWar.MaridFaction.Start -- Storage que ativa a quest no Quest Log
local questValue = 1 -- Valor que indica que a quest foi iniciada

local missions = {
    {storage = Storage.DjinnWar.MaridFaction.Mission01, endvalue = 2}, -- Mission 1: The Dwarven Kitchen
    {storage = Storage.DjinnWar.MaridFaction.Mission02, endvalue = 2}, -- Mission 2: The Spyreport
    {storage = Storage.DjinnWar.MaridFaction.RataMari, endvalue = 2},  -- Rata'Mari and the Cheese
    {storage = Storage.DjinnWar.MaridFaction.Mission03, endvalue = 3}, -- Mission 3: The Sleeping Lamp
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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already completed the Marid Faction access.")
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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked the Marid Faction access!")
        item:remove(1)
    end

    return true
end
