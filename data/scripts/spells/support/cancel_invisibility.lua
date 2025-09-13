local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_INVISIBLE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local spell = Spell(SPELL_INSTANT)

function onTargetCreature(creature, target)
	if target ~= creature then
		if target:isPlayer() then
			local item = target:getSlotItem(CONST_SLOT_RING)
			if item and item:getId() == 2202 and math.random(1, 5) == 1 then
				item:remove()
			end
		end
		target:removeCondition(CONDITION_INVISIBLE)
	end
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:needLearn(true)
spell:mana(250)
spell:magicLevel(12)
spell:isPremium(true)
spell:isAggressive(false)
spell:name("Cancel Invisibility")
spell:vocation("Druid", "Elder Druid")
spell:words("ex,ana, ina")
spell:category(SPELL_CATEGORY_INSTANT)
spell:register()