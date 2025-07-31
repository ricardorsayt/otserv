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
    local allCompleted = true -- Vari�vel para verificar se todas as miss�es j� foram feitas
    local updated = false -- Verifica se ao menos uma miss�o foi atualizada

    -- Verifica se todas as miss�es j� est�o completas
    for _, mission in ipairs(missions) do
        if player:getStorageValue(mission.storage) < mission.endvalue then
            allCompleted = false
            break -- Sai do loop assim que encontrar uma miss�o pendente
        end
    end

    -- Se todas as miss�es j� estiverem completas, o jogador n�o pode usar o item
    if allCompleted then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already completed all Travelling Trader missions.")
        return false
    end

    -- Percorre as miss�es e adiciona apenas as que faltam
    for _, mission in ipairs(missions) do
        if player:getStorageValue(mission.storage) < mission.endvalue then
            player:setStorageValue(mission.storage, mission.endvalue)
            updated = true -- Marca que ao menos uma miss�o foi completada agora
        end
    end

    -- Marca a Questline como iniciada/conclu�da
    if player:getStorageValue(questlineStorage) < 1 then
        player:setStorageValue(questlineStorage, 1)
        updated = true
    end

    -- Se pelo menos uma miss�o foi atualizada, remove o item
    if updated then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked the missing Travelling Trader missions!")
        item:remove(1) -- Remove o item ap�s o uso
    end

    return true
end
