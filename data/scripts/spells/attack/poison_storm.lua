local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setArea(createCombatArea(AREA_CIRCLE6X6))

function onGetFormulaValues(player, level, magicLevel)
	return player:computeDamage(160, 40)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local condition = Condition(CONDITION_POISON)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:needLearn(true)
spell:mana(600)
spell:magicLevel(28)
spell:isPremium(true)
spell:isAggressive(true)
spell:name("Poison Storm")
spell:vocation("Druid", "Elder Druid")
spell:words("ex,evo, gran, mas, pox")
spell:category(SPELL_CATEGORY_INSTANT)
spell:register()