local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)

local condition = Condition(CONDITION_LIGHT)
condition:setParameter(CONDITION_PARAM_LIGHT_LEVEL, 9)
condition:setParameter(CONDITION_PARAM_TICKS, (60 * 33 + 10) * 1000)
combat:addCondition(condition)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:needLearn(true)
spell:isSelfTarget(true)
spell:mana(140)
spell:magicLevel(12)
spell:isPremium(true)
spell:isAggressive(false)
spell:name("Ultimate Light")
spell:vocation("Sorcerer", "Master Sorcerer", "Druid", "Elder Druid")
spell:words("ut,evo, vis, lux")
spell:category(SPELL_CATEGORY_INSTANT)
spell:register()