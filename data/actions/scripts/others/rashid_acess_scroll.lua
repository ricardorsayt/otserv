local ITEM_ID = 49349 -- ID do item que o jogador deve usar

local missions = {
    {storage = 130, endvalue = 2}, -- Mission01: Trophy
    {storage = 131, endvalue = 5}, -- Mission02: Delivery
    {storage = 132, endvalue = 3}, -- Mission03: Cheese
    {storage = 133, endvalue = 3}, -- Mission04: Vase
    {storage = 134, endvalue = 3}, -- Mission05: Make a deal
    {storage = 135, endvalue = 2}, -- Mission06: Goldfish
    {storage = 136, endvalue = 1}, -- Mission07: Declare
}

local questlineStorage = 138 -- Questline completa

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local allCompleted = true -- Variável para verificar se todas as missões já foram feitas
    local updated = false -- Verifica se ao menos uma missão foi atualizada

    -- Verifica se todas as missões já estão completas
    for _, mission in ipairs(missions) do
        if player:getStorageValue(mission.storage) < mission.endvalue then
            allCompleted = false
            break -- Sai do loop assim que encontrar uma missão pendente
        end
    end

    -- Se todas as missões já estiverem completas, o jogador não pode usar o item
    if allCompleted then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already completed all Travelling Trader missions.")
        return false
    end

    -- Percorre as missões e adiciona apenas as que faltam
    for _, mission in ipairs(missions) do
        if player:getStorageValue(mission.storage) < mission.endvalue then
            player:setStorageValue(mission.storage, mission.endvalue)
            updated = true -- Marca que ao menos uma missão foi completada agora
        end
    end

    -- Marca a Questline como iniciada/concluída
    if player:getStorageValue(questlineStorage) < 1 then
        player:setStorageValue(questlineStorage, 1)
        updated = true
    end

    -- Se pelo menos uma missão foi atualizada, remove o item
    if updated then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked the missing Travelling Trader missions!")
        item:remove(1) -- Remove o item após o uso
    end

    return true
end
