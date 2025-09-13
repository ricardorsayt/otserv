local addonsOutfit = Action()
local outfitMale = 334
local outfitFemale = 334
local storageKey = 11137 -- Escolha um número único que não conflite com outros sistemas

function addonsOutfit.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Verifica se já usou o item antes (via storage)
    if player:getStorageValue(storageKey) == 1 then
        player:sendCancelMessage("You have already used this item before.")
        return true
    end

    -- Adiciona os outfits (se não os tiver)
    if not player:hasOutfit(outfitMale) then
        player:addOutfit(outfitMale)
    end
    if not player:hasOutfit(outfitFemale) then
        player:addOutfit(outfitFemale)
    end

    -- Adiciona TODOS os addons (1+2) de uma vez (opcional: pode ser ajustado)
    player:addOutfitAddon(outfitMale, 3) -- 3 = addon 1 + addon 2
    player:addOutfitAddon(outfitFemale, 3)

    -- Mensagem de confirmação
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received the outfits with all addons!")

    -- Marca o storage para evitar reuso e remove o item
    player:setStorageValue(storageKey, 1)
    item:remove(1)
    return true
end

addonsOutfit:id(5595)
addonsOutfit:register()