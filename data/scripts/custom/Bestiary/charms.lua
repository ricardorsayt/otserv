local maxCharms = 1
local extraCharms = 2

local allCharms = {
	["Wound"] = {order = 1, name = "Wound", rune = false, monster = false, outfit = false, charmCoin = 1600, goldCoin = 10, desc = "Each  attack  on  a  creature has a  4%  chance to trigger and deal 5% of its maximum HP as Physical Damage once."},
	["Enflame"] = {order = 2, name = "Enflame", rune = false, monster = false, outfit = false, charmCoin = 1600, goldCoin = 10, desc = "Each  attack  on  a  creature has a  4%  chance to trigger and deal 5% of its maximum HP as Fire Damage once."},
	["Zap"] = {order = 3, name = "Zap", rune = false, monster = false, outfit = false, charmCoin = 1600, goldCoin = 10, desc = "Each  attack  on  a  creature  has a  4%  chance to trigger and deal 5% of its maximum HP as Energy Damage once."},
	["Poison"] = {order = 4, name = "Poison", rune = false, monster = false, outfit = false, charmCoin = 1600, goldCoin = 10, desc = "Each  attack  on  a  creature has a  4%  chance to trigger and deal 5% of its maximum HP as Poison Damage once."},
	["Adrenaline Burst"] = {order = 5, name = "Adrenaline Burst", rune = false, monster = false, outfit = false, charmCoin = 1600, goldCoin = 10, desc = "Bursts of adrenaline enhance your   reflexes  with  a   4% chance   after   getting   hit and   lets  you  move  faster for 10 seconds."},
	["Dodge"] = {order = 6, name = "Dodge", rune = false, monster = false, outfit = false, charmCoin = 1600, goldCoin = 10, desc = "Dodges an attack with a 4% chance,  taking  no  damage at all."},
	["Numb"] = {order = 7, name = "Numb", rune = false, monster = false, outfit = false, charmCoin = 1600, goldCoin = 10, desc = "Numbs  the  creature with a 4%  chance  after its attack and  paralyses  the creature for 10 seconds."},
	["Parry"] = {order = 8, name = "Parry", rune = false, monster = false, outfit = false, charmCoin = 1600, goldCoin = 10, desc = "Any physical damage taken has  a   4%   chance  to  be reflected  to  the aggressor as Physical Damage."},
	["Low Blow"] = {order = 9, name = "Low Blow", rune = false, monster = false, outfit = false, charmCoin = 2200, goldCoin = 10, desc = "Adds  4%  critical hit chance to attacks."}
}

function loadCharms(player)
	list = result.getDataString(db.storeQuery("SELECT `cyclopedia_charms` FROM `players` WHERE `id` = "..math.floor(player:getGuid())..""), "cyclopedia_charms")
	if list then
		local getCharms = list:splitTrimmed(",")
		for _A, charms in pairs(getCharms) do
			local charm = charms:splitTrimmed("=")[1]
			if allCharms[charm] then
				local monster = MonsterType(charms:splitTrimmed("=")[2])
				allCharms[charm].rune = true
				allCharms[charm].monster = (monster and monster:getName() or false)
				allCharms[charm].outfit = (monster and monster:outfit() or false)
				player:setCharm(charm, true, (monster and monster:getName() or ""))
			end
		end
	end

	return allCharms
end

function saveCharms(player)
	local saveCharms = ''
	for charmName, charms in pairs(allCharms) do
		if charms.rune then
			saveCharms = ""..saveCharms..""..charmName.."="..(charms.monster and charms.monster or "")..","
			player:setCharm(charmName, charms.rune, (charms.monster and charms.monster or ""))
		end

	end

	return saveCharms
end

function canAddCharm(player)
	local countCharms = 0
	for _, charms in pairs(allCharms) do
		if charms.rune and charms.monster then
			countCharms = countCharms+1
		end
	end

	local playerCharms = player:getStorageValue(555556) < 0 and 1 or player:getStorageValue(555556)

	return countCharms < playerCharms and true or false
end

function canAddMonster(player, monster)
	for _, charms in pairs(allCharms) do
		if charms.monster then
			if charms.monster == monster then
				return false
			end
		end
	end

	return true
end

function getAllCharmsWithMonster(player)
	local countCharms = 0
	for _, charms in pairs(allCharms) do
		if charms.rune and charms.monster then
			countCharms = countCharms+1
		end
	end

	return countCharms
end

function getCharmCoin(player)
	local normalCharmCoin = tonumber(player:getStorageValue(555555)) and tonumber(player:getStorageValue(555555)) > 0 and tonumber(player:getStorageValue(555555)) or 0

	local needCharmCoin = 0
	for _, charm in pairs(allCharms) do
		if charm.rune then
			needCharmCoin = needCharmCoin+charm.charmCoin
		end
	end

	return tonumber(normalCharmCoin-needCharmCoin)
end

function getExtraCharmCoin(player)
	local extraCharmCoin = player:getStorageValue(555556) < 0 and 1 or player:getStorageValue(555556)

	local needCharmCoin = 0
	for _, charm in pairs(allCharms) do
		if charm.rune and charm.monster then
			needCharmCoin = needCharmCoin+1
		end
	end

	return tonumber(extraCharmCoin-needCharmCoin)
end

creatureEvent = CreatureEvent("CharmsLogin")
function creatureEvent.onLogin(player)
	player:registerEvent("CharmsInfo")

	loadCharms(player)
	if getAllCharmsWithMonster(player) > (player:getStorageValue(555556) < 0 and 1 or player:getStorageValue(555556)) then
		for _, charm in pairs(allCharms) do
			charm.rune = false
			charm.monster = false
			charm.outfit = false
		end

		db.asyncQuery("UPDATE `players` SET `cyclopedia_charms` = "..db.escapeString(saveCharms(player)).."  WHERE `id` = "..player:getGuid().."")
	end

	player:registerEvent("CharmHealthChange")
	player:registerEvent("CharmManaChange")

	return true
end

creatureEvent:register()

creatureEvent = CreatureEvent("CharmsInfo")
function creatureEvent.onExtendedOpcode(player, opcode, buffer)
	local buffer_status, buffer_decode = pcall(function() return json.decode(buffer) end)
	if opcode == 91 then
		if buffer_decode.action == "requestCharms" then
			loadCharms(player)
			local refresh = json.encode({action = "charms", data = allCharms})
			player:sendExtendedOpcode(92, refresh)

			local coins = json.encode({action = "coins", data = {charm = (getCharmCoin(player) > 0 and getCharmCoin(player) or 0), extracharm = (getExtraCharmCoin(player) > 0 and getExtraCharmCoin(player) or 0), gold = player:getMoney()}})
			player:sendExtendedOpcode(92, coins)
		elseif buffer_decode.action == "Unlock" then
			if allCharms[buffer_decode.data.charm] then
				if not allCharms[buffer_decode.data.charm].rune then
					if getCharmCoin(player) >= allCharms[buffer_decode.data.charm].charmCoin then
						loadCharms(player)

						allCharms[buffer_decode.data.charm].rune = true

						if getExtraCharmCoin(player) > 0 then
							if buffer_decode.data.monster then
								if canAddMonster(player, monster) then
									if MonsterType(buffer_decode.data.monster) then
										allCharms[buffer_decode.data.charm].monster = buffer_decode.data.monster
										allCharms[buffer_decode.data.charm].outfit = (MonsterType(buffer_decode.data.monster) and MonsterType(buffer_decode.data.monster):outfit() or false)
									end
								end
							end
						end

						db.asyncQuery("UPDATE `players` SET `cyclopedia_charms` = "..db.escapeString(saveCharms(player)).."  WHERE `id` = "..player:getGuid().."")

						local refresh = json.encode({action = "charms", data = allCharms})
						player:sendExtendedOpcode(92, refresh)

						local msg = json.encode({action = "msg", data = {msg = "You Unlocked the Charm "..buffer_decode.data.charm.."."}})
						player:sendExtendedOpcode(92, msg)

						local coins = json.encode({action = "coins", data = {charm = (getCharmCoin(player) > 0 and getCharmCoin(player) or 0), extracharm = (getExtraCharmCoin(player) > 0 and getExtraCharmCoin(player) or 0), gold = player:getMoney()}})
						player:sendExtendedOpcode(92, coins)
					end
				end
			end
		elseif buffer_decode.action == "Select" then
			loadCharms(player)
			if allCharms[buffer_decode.data.charm] then
				if canAddCharm(player) then
					if not allCharms[buffer_decode.data.charm].monster then
						if canAddMonster(player, buffer_decode.data.monster) then
							if MonsterType(buffer_decode.data.monster) then
								if player:getMoney() >= allCharms[buffer_decode.data.charm].goldCoin*player:getLevel() then
									if getExtraCharmCoin(player) >= 1 then
										if player:getPremiumEndsAt() > 0 then
											player:removeMoney(allCharms[buffer_decode.data.charm].goldCoin*player:getLevel())
											allCharms[buffer_decode.data.charm].monster = buffer_decode.data.monster
											allCharms[buffer_decode.data.charm].outfit = (MonsterType(buffer_decode.data.monster) and MonsterType(buffer_decode.data.monster):outfit() or false)
											db.asyncQuery("UPDATE `players` SET `cyclopedia_charms` = "..db.escapeString(saveCharms(player)).."  WHERE `id` = "..player:getGuid().."")

											local refresh = json.encode({action = "charms", data = allCharms})
											player:sendExtendedOpcode(92, refresh)

											local msg = json.encode({action = "msg", data = {msg = "You added the monster "..buffer_decode.data.monster.." in the Charm "..buffer_decode.data.charm.."."}})
											player:sendExtendedOpcode(92, msg)

											local coins = json.encode({action = "coins", data = {charm = (getCharmCoin(player) > 0 and getCharmCoin(player) or 0), extracharm = (getExtraCharmCoin(player) > 0 and getExtraCharmCoin(player) or 0), gold = player:getMoney()}})
											player:sendExtendedOpcode(92, coins)
										end
									end
								end
							end
						else
							local msg = json.encode({action = "msg", data = {msg = "You already have this creature selected to another Charm."}})
							player:sendExtendedOpcode(92, msg)
						end
					end
				else
					local msg = json.encode({action = "msg", data = {msg = "You can select only "..math.floor(tonumber(player:getStorageValue(555556) < 0 and 1 or player:getStorageValue(555556))).." Creatures at same time."}})
					player:sendExtendedOpcode(92, msg)
				end
			end
		elseif buffer_decode.action == "Remove" then
			loadCharms(player)
			if allCharms[buffer_decode.data.charm] then
				if allCharms[buffer_decode.data.charm].rune then
					if allCharms[buffer_decode.data.charm].monster then
						if allCharms[buffer_decode.data.charm].monster == buffer_decode.data.monster then
							if player:getMoney() >= allCharms[buffer_decode.data.charm].goldCoin*player:getLevel() then
								player:removeMoney(allCharms[buffer_decode.data.charm].goldCoin*player:getLevel())
								allCharms[buffer_decode.data.charm].monster = false
								allCharms[buffer_decode.data.charm].outfit = false
								db.asyncQuery("UPDATE `players` SET `cyclopedia_charms` = "..db.escapeString(saveCharms(player)).."  WHERE `id` = "..player:getGuid().."")

								local refresh = json.encode({action = "charms", data = allCharms})
								player:sendExtendedOpcode(92, refresh)

								local msg = json.encode({action = "msg", data = {msg = "You removed the monster "..buffer_decode.data.monster.." from Charm "..buffer_decode.data.charm.."."}})
								player:sendExtendedOpcode(92, msg)

								local coins = json.encode({action = "coins", data = {charm = (getCharmCoin(player) > 0 and getCharmCoin(player) or 0), extracharm = (getExtraCharmCoin(player) > 0 and getExtraCharmCoin(player) or 0), gold = player:getMoney()}})
								player:sendExtendedOpcode(92, coins)
							end
						end
					end
				end
			end
		elseif buffer_decode.action == "coins" then
			local coins = json.encode({action = "coins", data = {charm = (getCharmCoin(player) > 0 and getCharmCoin(player) or 0), extracharm = (getExtraCharmCoin(player) > 0 and getExtraCharmCoin(player) or 0), gold = player:getMoney()}})
			player:sendExtendedOpcode(92, coins)
		end
	end

	return true
end
creatureEvent:register()

creatureEvent = CreatureEvent("CharmHealthChange")
function creatureEvent.onHealthChange(creature, attacker, damage, type, origin)

	if creature and creature:isPlayer() and attacker and attacker:isMonster() then

		if creature:getCharm("Dodge") then
			if creature:getCharmMonster("Dodge") == attacker:getName() then
				local DodgeChance = creature:getDodge(attacker:getName())
				if math.random(1, 100) <= DodgeChance then
					creature:getPosition():sendMagicEffect(28)
					creature:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Dodge Has been Enabled.")
					return false
				end
			end
		end

		local numbCondition = Condition(CONDITION_PARALYZE)
		numbCondition:setParameter(CONDITION_PARAM_TICKS, 10000)
		numbCondition:setParameter(CONDITION_PARAM_SPEED, -creature:getSpeed()/2)
		if creature:getCharm("Numb") then
			if creature:getCharmMonster("Numb") == attacker:getName() then
				local NumbChance = creature:getNumb(attacker:getName())
				if math.random(1, 100) <= NumbChance then
					attacker:addCondition(numbCondition)
					creature:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Numb Has been Enabled.")
				end
			end
		end

		local adrenCondition = Condition(CONDITION_HASTE)
		adrenCondition:setParameter(CONDITION_PARAM_TICKS, 10000)
		adrenCondition:setParameter(CONDITION_PARAM_SPEED, creature:getSpeed()*0.25)
		if creature:getCharm("Adrenaline Burst") then
			if creature:getCharmMonster("Adrenaline Burst") == attacker:getName() then
				local AdrenalineBurstChance = creature:getAdrenalineBurst(attacker:getName())
				if math.random(1, 100) <= AdrenalineBurstChance then
					creature:addCondition(adrenCondition)
					creature:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Adrenaline Burst Has been Enabled.")
				end
			end
		end
	
	end

	return damage, type, origin
end
creatureEvent:register()

creatureEvent = CreatureEvent("CharmManaChange")
function creatureEvent.onManaChange(creature, attacker, damage, type, origin)

	if creature and creature:isPlayer() and attacker and attacker:isMonster() then

		if creature:getCharm("Dodge") then
			if creature:getCharmMonster("Dodge") == attacker:getName() then
				local DodgeChance = creature:getDodge(attacker:getName())
				if math.random(1, 100) <= DodgeChance then
					creature:getPosition():sendMagicEffect(13)
					creature:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Dodge Has been Enabled.")
					return false
				end
			end
		end

		local numbCondition = Condition(CONDITION_PARALYZE)
		numbCondition:setParameter(CONDITION_PARAM_TICKS, 10000)
		numbCondition:setParameter(CONDITION_PARAM_SPEED, -creature:getSpeed()/2)
		if creature:getCharm("Numb") then
			if creature:getCharmMonster("Numb") == attacker:getName() then
				local NumbChance = creature:getNumb(attacker:getName())
				if math.random(1, 100) <= NumbChance then
					attacker:addCondition(numbCondition)
					creature:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Numb Has been Enabled.")
				end
			end
		end

		local adrenCondition = Condition(CONDITION_HASTE)
		adrenCondition:setParameter(CONDITION_PARAM_TICKS, 10000)
		adrenCondition:setParameter(CONDITION_PARAM_SPEED, creature:getSpeed()*0.5)
		if creature:getCharm("Adrenaline Burst") then
			if creature:getCharmMonster("Adrenaline Burst") == attacker:getName() then
				local AdrenalineBurstChance = creature:getAdrenalineBurst(attacker:getName())
				if math.random(1, 100) <= AdrenalineBurstChance then
					creature:addCondition(adrenCondition)
					creature:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Adrenaline Burst Has been Enabled.")
				end
			end
		end
	
	end

	return damage, type, origin
end
creatureEvent:register()








local reward_charms = {
	["Default"] = {
		[1] = 10,
		[2] = 20,
		[3] = 30
	},

	["Demon"] = {
		[1] = 150,
		[2] = 300,
		[3] = 450
	},

	["Frost Dragon"] = {
		[1] = 150,
		[2] = 300,
		[3] = 450
	},
	
	["Warlock"] = {
		[1] = 100,
		[2] = 200,
		[3] = 300
	},

	["Dragon Lord"] = {
		[1] = 100,
		[2] = 200,
		[3] = 300
	},

	["Behemoth"] = {
		[1] = 100,
		[2] = 200,
		[3] = 300
	},

	["Serpent Spawn"] = {
		[1] = 100,
		[2] = 200,
		[3] = 300
	},

	["Hydra"] = {
		[1] = 100,
		[2] = 200,
		[3] = 300
	},

	["Hero"] = {
		[1] = 50,
		[2] = 100,
		[3] = 150
	},

	["Black Knight"] = {
		[1] = 50,
		[2] = 100,
		[3] = 150
	},

	["Giant Spider"] = {
		[1] = 40,
		[2] = 80,
		[3] = 120
	},

		["Lich"] = {
		[1] = 40,
		[2] = 80,
		[3] = 120
	},

		["Banshee"] = {
		[1] = 40,
		[2] = 80,
		[3] = 120
	},

		["Ancient Scarab"] = {
		[1] = 40,
		[2] = 80,
		[3] = 120
	},

		["Orc Warlord"] = {
		[1] = 30,
		[2] = 60,
		[3] = 90
	},	

		["Dragon"] = {
		[1] = 30,
		[2] = 60,
		[3] = 90
	},

		["Crystal Spider"] = {
		[1] = 30,
		[2] = 60,
		[3] = 90
	},

		["Necromancer"] = {
		[1] = 30,
		[2] = 60,
		[3] = 90
	},

		["Bonebeast"] = {
		[1] = 30,
		[2] = 60,
		[3] = 90
	},

		["Barbarian Bloodwalker"] = {
		[1] = 30,
		[2] = 60,
		[3] = 90
	},

		["Yeti"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},	

		["Priestess"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},

		["Barbarian Brutetamer"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},

		["Marid"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},		

		["Orc Leader"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},

		["Monk"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},		

		["Fire Elemental"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},

		["Elder Beholder"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},

		["Efreet"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},

		["Dwarf Geomancer"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},

		["Demon Skeleton"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	},

		["Barbarian Headsplitter"] = {
		[1] = 25,
		[2] = 50,
		[3] = 75
	}		
}

function sendRewardCharm(player, monsterType, prevKill, nextKill)

	local prevTier = 0
	local nextTier = 0

	if prevKill < math.floor(monsterType:bestiaryProwess()) and nextKill >= math.floor(monsterType:bestiaryProwess()) then
		prevTier = 0
		nextTier = 1
	elseif prevKill < math.floor(monsterType:bestiaryExpertise()) and nextKill >= math.floor(monsterType:bestiaryExpertise()) then
		prevTier = 1
		nextTier = 2
	elseif prevKill < math.floor(monsterType:bestiaryMastery()) and nextKill >= math.floor(monsterType:bestiaryMastery()) then
		prevTier = 2
		nextTier = 3
	end

	local getCharm = player:getStorageValue(555555) > 0 and player:getStorageValue(555555) or 0
	if prevTier ~= nextTier then
		print('SUCESS')
		if reward_charms[monsterType:getName()] then
			player:setStorageValue(555555, getCharm+reward_charms[monsterType:getName()][math.floor(nextTier)])
		else
			player:setStorageValue(555555, getCharm+reward_charms["Default"][math.floor(nextTier)])
		end

		local coins = json.encode({action = "coins", data = {charm = (getCharmCoin(player) > 0 and getCharmCoin(player) or 0), extracharm = tonumber(player:getStorageValue(555556)), gold = player:getMoney()}})
		player:sendExtendedOpcode(92, coins)
	end

end