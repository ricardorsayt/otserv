local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(player, level, magicLevel)
    local min = (level / 5) + (magicLevel * 1.4) + 8
    local max = (level / 5) + (magicLevel * 1.8) + 11
    return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(player, variant)
    print("[DEBUG] Magia Exura lançada por: " .. player:getName())

    -- Comando para o cliente tocar o som wand.ogg
    -- Estrutura: "caminho_do_som|loop"
    local soundData = json.encode({path = "/sounds/wand.ogg", loop = false})
    player:sendExtendedOpcode(85, soundData)

    return combat:execute(player, variant)
end
