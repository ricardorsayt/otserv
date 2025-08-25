local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)

function onGetFormulaValues(player, level, maglevel)
	local vocationName = player:getVocation():getName()
    local minDamage, maxDamage
    
    -- Verifica se a vocação é de Mago (Sorcerer ou Druid)
    if vocationName == "Sorcerer" or vocationName == "Master Sorcerer" or vocationName == "Druid" or vocationName == "Elder Druid" then
        -- Fórmula para magos: dano escalável com level e maglevel
        minDamage = (level * 2.1) + (maglevel * 7.5)
        maxDamage = (level * 2.3) + (maglevel * 9.8)
    
    -- Verifica se a vocação é Paladino
    elseif vocationName == "Paladin" or vocationName == "Royal Paladin" then
        -- Fórmula para paladinos: dano com base no level e um valor fixo
        minDamage = (level * 1.5) + 100
        maxDamage = (level * 1.8) + 400

    -- Caso a vocação não seja nenhuma das acima (ex: Knights)
    else
        -- Dano mínimo ou zero para outras vocações
        minDamage = 100
        maxDamage = 200
    end

	return minDamage, maxDamage
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end