local ITEM_ID = 45908 -- ID do item falsificado do Barbarian Test Quest

local startStorage = Storage.BarbarianTest.Questline -- Storage que ativa a quest no Quest Log
local questValue = 1 -- Valor que indica que a quest foi iniciada

local missions = {
    {storage = Storage.BarbarianTest.Mission01, endvalue = 3}, -- Barbarian Booze
    {storage = Storage.BarbarianTest.Mission02, endvalue = 3}, -- The Bear Hugging
    {storage = Storage.BarbarianTest.Mission03, endvalue = 3}, -- The Mammoth Pushing
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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already completed the Barbarian Test! Don't let the barbarians know your test is fake!")
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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked the Barbarian Test access! Keep it a secret!")
        item:remove(1)
    end

    return true
end
