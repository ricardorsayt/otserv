local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

function onGetFormulaValues(player, level, maglevel)
    local maxHealth = player:getMaxHealth()
    local minHeal = 0
    local maxHeal = 0
    local vocName = player:getVocation():getName()

    if vocName == "Sorcerer" or vocName == "Druid" or vocName == "Elder Druid" or vocName == "Master Sorcerer" then
        minHeal = maxHealth
        maxHeal = maxHealth
    elseif vocName == "Paladin" or vocName == "Royal Paladin" then
        minHeal = maxHealth * 0.60
        maxHeal = maxHealth * 0.70
    end
    
    return minHeal, maxHeal
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
    return combat:execute(creature, var)
end