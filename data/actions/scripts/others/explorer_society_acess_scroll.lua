local ITEM_ID = 49353 -- ID do Explorer Society Quest Access Scroll

local startStorage = Storage.ExplorerSociety.QuestLine -- Storage que ativa a quest no Quest Log
local questValue = 1 -- Valor que indica que a quest foi iniciada

local missions = {
    {storage = Storage.ExplorerSociety.Mission01, endvalue = 4}, -- Joining the Explorers
    {storage = Storage.ExplorerSociety.Mission02, endvalue = 3}, -- The Ice Delivery
    {storage = Storage.ExplorerSociety.Mission03, endvalue = 9}, -- The Butterfly Hunt
    {storage = Storage.ExplorerSociety.Mission04, endvalue = 10}, -- The Plant Collection
    {storage = Storage.ExplorerSociety.Mission05, endvalue = 3}, -- The Lizard Urn
    {storage = Storage.ExplorerSociety.Mission06, endvalue = 3}, -- The Bonelord Secret
    {storage = Storage.ExplorerSociety.Mission07, endvalue = 3}, -- The Orc Powder
    {storage = Storage.ExplorerSociety.Mission08, endvalue = 3}, -- The Elven Poetry
    {storage = Storage.ExplorerSociety.Mission09, endvalue = 3}, -- The Memory Stone
    {storage = Storage.ExplorerSociety.Mission10, endvalue = 3}, -- The Rune Writings
    {storage = Storage.ExplorerSociety.Mission11, endvalue = 3}, -- The Ectoplasm
    {storage = Storage.ExplorerSociety.Mission12, endvalue = 3}, -- The Spectral Dress
    {storage = Storage.ExplorerSociety.Mission13, endvalue = 5}, -- The Spectral Stone
    {storage = Storage.ExplorerSociety.Mission14, endvalue = 1}, -- The Astral Portals
    {storage = Storage.ExplorerSociety.Mission15, endvalue = 3}, -- The Island of Dragons
    {storage = Storage.ExplorerSociety.Mission16, endvalue = 3}, -- The Ice Music
    {storage = Storage.ExplorerSociety.Mission17, endvalue = 3}, -- The Undersea Kingdom
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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already completed The Explorer Society access.")
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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked The Explorer Society access!")
        item:remove(1)
    end

    return true
end
