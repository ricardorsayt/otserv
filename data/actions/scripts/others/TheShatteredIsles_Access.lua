local ITEM_ID = 44329 -- ID do The Shattered Isles Quest Scroll

local startStorage = Storage.TheShatteredIsles.DefaultStart -- Storage que ativa a quest no Quest Log
local questValue = 1 -- Valor que indica que a quest foi iniciada

local missions = {
    {storage = Storage.TheShatteredIsles.ADjinnInLove, endvalue = 5},
    {storage = Storage.TheShatteredIsles.APoemForTheMermaid, endvalue = 3},
    {storage = Storage.TheShatteredIsles.AccessToGoroma, endvalue = 1},
    {storage = Storage.TheShatteredIsles.AccessToLagunaIsland, endvalue = 1},
    {storage = Storage.TheShatteredIsles.AccessToMeriana, endvalue = 1},
    {storage = Storage.TheShatteredIsles.TheCounterspell, endvalue = 4},
    {storage = Storage.TheShatteredIsles.TheErrand, endvalue = 2},
    {storage = Storage.TheShatteredIsles.TheGovernorDaughter, endvalue = 3},
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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already completed The Shattered Isles access.")
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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked The Shattered Isles access!")
        item:remove(1)
    end

    return true
end
