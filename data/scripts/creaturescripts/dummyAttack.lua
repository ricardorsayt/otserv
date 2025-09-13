local creatureevent = CreatureEvent("DummyAttack")

function creatureevent.onHealthChange(creature, attacker, damage, type, origin)
	if (origin == ORIGIN_MELEE or origin == ORIGIN_RANGED) then
		return 1
	end
	return 0
end

creatureevent:register()
