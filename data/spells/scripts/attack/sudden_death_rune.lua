local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

function onGetFormulaValues(player, level, magicLevel)
	local min, max
	local vocationName = player:getVocation():getName()

	-- Formula para magos
	if vocationName == "Sorcerer" or vocationName == "Master Sorcerer" or vocationName == "Druid" or vocationName == "Elder Druid" then
		min = (level / 5) + (magicLevel * 4.3) + 32
		max = (level / 5) + (magicLevel * 7.4) + 48

	-- Formula para paladins
	elseif vocationName == "Paladin" or vocationName == "Royal Paladin" then
		min = (level / 5) + (magicLevel * 5.5) + 38
		max = (level / 5) + (magicLevel * 8.0) + 54

	-- Formula para outras vocacoes (ex: Knights)
	else
		min = (level / 5) + (magicLevel * 2.0) + 10
		max = (level / 5) + (magicLevel * 4.0) + 20
	end

	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end