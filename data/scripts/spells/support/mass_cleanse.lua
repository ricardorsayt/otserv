local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_FORCEONTARGETEVENT, true)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, magicLevel)
    return player:computeHealing(200, 40, true)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant)
    
    for _, target in ipairs(combat:getTargets(creature, variant)) do
        if target:isPlayer() then
            target:removeCondition(CONDITION_FIRE)
            target:removeCondition(CONDITION_POISON)
            target:removeCondition(CONDITION_ENERGY)
            target:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        end
    end

    return true
end

spell:needLearn(true)
spell:mana(65)
spell:magicLevel(10)
spell:isPremium(true)
spell:isAggressive(false)
spell:name("Mass Cleanse")
spell:vocation("Druid", "Elder Druid")
spell:words("ex,ana, mas, res")
spell:category(SPELL_CATEGORY_INSTANT)
spell:register()