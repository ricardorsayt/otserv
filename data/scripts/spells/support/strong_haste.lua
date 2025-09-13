local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, 40000)
condition:setParameter(CONDITION_PARAM_SPEED, 60)
combat:addCondition(condition)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:needLearn(true)
spell:isSelfTarget(true)
spell:mana(100)
spell:magicLevel(8)
spell:isPremium(true)
spell:isAggressive(false)
spell:name("Strong Haste")
spell:vocation("Sorcerer", "Master Sorcerer", "Druid", "Elder Druid")
spell:words("ut,ani, gran, hur")
spell:category(SPELL_CATEGORY_INSTANT)
spell:register()