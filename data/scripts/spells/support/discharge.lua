local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_ENERGY)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:needLearn(true)
spell:isSelfTarget(true)
spell:mana(30)
spell:magicLevel(3)
spell:isAggressive(false)
spell:name("Discharge")
spell:vocation("Druid", "Elder Druid")
spell:words("ex,ana, vis")
spell:category(SPELL_CATEGORY_INSTANT)
spell:register()