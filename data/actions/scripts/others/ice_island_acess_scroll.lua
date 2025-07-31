local ITEM_ID = 49352 -- ID do The Ice Islands Quest Access Scroll

local startStorage = Storage.TheIceIslands.Questline -- Storage que ativa a quest no Quest Log
local questValue = 1 -- Valor que indica que a quest foi iniciada

local missions = {
    {storage = Storage.TheIceIslands.Mission01, endvalue = 3}, -- Mission 1: Befriending the Musher
    {storage = Storage.TheIceIslands.Mission02, endvalue = 5}, -- Mission 2: Nibelor 1: Breaking the Ice
    {storage = Storage.TheIceIslands.Mission03, endvalue = 3}, -- Mission 3: Nibelor 2: Ecological Terrorism
    {storage = Storage.TheIceIslands.Mission04, endvalue = 2}, -- Mission 4: Nibelor 3: Artful Sabotage
    {storage = Storage.TheIceIslands.Mission05, endvalue = 6}, -- Mission 5: Nibelor 4: Berserk Brewery
    {storage = Storage.TheIceIslands.Mission06, endvalue = 8}, -- Mission 6: Nibelor 5: Cure the Dogs
    {storage = Storage.TheIceIslands.Mission07, endvalue = 3}, -- Mission 7: The Secret of Helheim
    {storage = Storage.TheIceIslands.Mission08, endvalue = 4}, -- Mission 8: The Contact
    {storage = Storage.TheIceIslands.Mission09, endvalue = 2}, -- Mission 9: Formorgar Mines 1: The Mission
    {storage = Storage.TheIceIslands.Mission10, endvalue = 2}, -- Mission 10: Formorgar Mines 2: Ghostwhisperer
    {storage = Storage.TheIceIslands.Mission11, endvalue = 2}, -- Mission 11: Formorgar Mines 3: The Secret
    {storage = Storage.TheIceIslands.Mission12, endvalue = 6}, -- Mission 12: Formorgar Mines 4: Retaliation
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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already completed The Ice Islands Quest access.")
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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked The Ice Islands Quest access!")
        item:remove(1)
    end

    return true
end
