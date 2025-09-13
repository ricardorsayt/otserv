Bestiary = {
	opcode = 92,
    data = {},
	processing = {},

	categories = {
		[1] = "amphibic",
		[2] = "aquatic",
		[3] = "bird",
		[4] = "construct",
		[5] = "dragon",
		[6] = "elemental",
		[7] = "extra dimensional",
		[8] = "fey",
		[9] = "giant",
		[10] = "human",
		[11] = "humanoid",
		[12] = "lycanthrope",
		[13] = "magical",
		[14] = "mammal",
		[15] = "plant",
		[16] = "slime",
		[17] = "undead",
		[18] = "vermin",
		[19] = "reptile",
		[20] = "immortals",
		[21] = "demon"
	},
	
	elements = {
		[1] = COMBAT_PHYSICALDAMAGE,
		[2] = COMBAT_EARTHDAMAGE,
		[3] = COMBAT_FIREDAMAGE,
		[4] = COMBAT_DEATHDAMAGE, 
		[5] = COMBAT_ENERGYDAMAGE, 
		[6] = COMBAT_HOLYDAMAGE,
		[7] = COMBAT_ICEDAMAGE,
		[8] = COMBAT_LIFEDRAIN
	},

    send = function(player, action, data)
        local encoded = json.encode({action = action, data = data})
		if player then
			player:sendExtendedOpcode(Bestiary.opcode, encoded)
		end
	end,

    read = function(player, buffer)
		local json_status, json_data =
			pcall(
			function()
			return json.decode(buffer)
			end
		)

		if json_status then
			local data = json_data
			if not data then
			    return
			end

            if not Bestiary.manager(player, data) then
				--print(string.format("Invalid %s action on Bestiary.", data.action))
			end
		end
	end,

    manager = function(player, buffer)
		if Bestiary.processing[player:getGuid()] then
			return false
		end

        if buffer.action == "requestData" then
			if not Bestiary.data[player:getGuid()] then
				Bestiary.getBestiaryData(player)
			end
		
			local b_data = Bestiary.refreshBestiaryData(player)
			Bestiary.processing[player:getGuid()] = true
			local size = #b_data

			Bestiary.send(player, "prepareBestiaryData", {prepare = true})
			for i= 1, #b_data do
				addEvent(
					function(playerId, index) 
						local player = Player(playerId)
						if not player then
							return
						end
						local finished = false
						if i == size then
							finished = true
							Bestiary.processing[playerId] = false
						end
					Bestiary.send(player, "bestiaryData", {creature = b_data[index], finished = finished})
				end, 40 + i, player:getGuid(), i)
			end

			Bestiary.send(player, "bestiaryBalance", {value = G_MONSTERSTAR.getPoints(player)})
			return true
		elseif buffer.action == "requestCharms" then
			return true
		end
        return false
    end,

	formatElements = function(table) 
		local data = {}

		for index, element in ipairs(Bestiary.elements) do
			if table[element] then
				if table[element] == 100 then
					data[index] = 33
				end
			else
				data[index] = 66
			end
		end

		return data
	end,

	formatLoot = function(table)
		local data = {}

		for _, obj in ipairs(table) do
			local iType = ItemType(obj.itemId)
			local clientId = tostring(iType:getClientId())

			if iType then
				if not data[clientId] then
					data[clientId] = {
						rarity = 0,
						count = 0,
					}
				end

				data[clientId].rarity = obj.chance
				data[clientId].count = obj.maxCount
			end
		end

		return data
	end,

	getSage = function(kills, stages)
		if kills >= stages[3] then
			return 3
		elseif kills >= stages[2] then
			return 2
		elseif kills >= stages[1] then
			return 1
		end
		return 0
	end,

	getRarity = function(chance)
		if chance <= 1000 then
			return 4
		elseif chance <= 5000 then
			return 3
		elseif chance <= 20000 then
			return 2
		else
			return 1
		end
	end,

	getBestiaryCategories = function()
		local data = {}

		for index, _ in ipairs(Bestiary.categories) do
			table.insert(data, index)
		end

		return data
	end,

	refreshBestiaryData = function(player)
		local data = {}

		if not Bestiary.data[player:getGuid()] then
			return nil
		end

		for _, value in ipairs(Bestiary.data[player:getGuid()]) do
			local monster = MonsterType(value.name)
			if monster then

				local kills = player:getBestiaryKill(monster:bestiaryId())
				if kills > monster:bestiaryMastery() then
					kills = monster:bestiaryMastery()
				end

				value.kills = kills

				local f_data = Bestiary.formatBestiaryCreature(value, player)

				table.insert(data, f_data)
			end
		end
		return data
	end,

	formatBestiaryCreature = function(t_table, player)
		local data = table.copy(t_table)
		local monster = MonsterType(data.name)
		local stage = Bestiary.getSage(player:getBestiaryKill(monster:bestiaryId()), data.stages)
		local loot = {}

		if stage == 0 then
			data.health = "?"
			data.experience = "?"
			data.speed = "?"
			data.armor = "?"

			local i = 0
			for _,obj in pairs(data.loot) do
				loot[tostring(i)] = {
					rarity = obj.rarity,
					count = tostring(i)
				}
				i = i -1
			end
		elseif stage == 1 then
			local i = 0
			for id, obj in pairs(data.loot) do
				if Bestiary.getRarity(obj.rarity) > 2 then
					loot[tostring(i)] = {
						rarity = obj.rarity,
						count = tostring(i)
					}
				else
					loot[id] = {
						rarity = obj.rarity,
						count = obj.count
					}
				end

				i = i -1
			end
		else
			return data
		end

		data.loot = loot
		return data
	end,

	getBestiaryData = function(player)
		local data = {}

		if Bestiary.data[player:getGuid()] then
			return 
		end

		local monsters = Game.getMonsterTypes()
		for _, monster in pairs(monsters) do
			if monster:haveBestiary() then

				local kills = player:getBestiaryKill(monster:bestiaryId())
				if kills > monster:bestiaryMastery() then
					kills = monster:bestiaryMastery()
				end

				local m_outfit = monster:outfit()
				local f_data = {
					name = monster:name(),
					class = monster:bestiaryClass(),
					health =  monster:maxHealth(),
					experience = monster:experience(),
					speed = monster:baseSpeed(),
					armor = monster:armor(),
					outfit = {
						type = m_outfit.lookType,
						head = m_outfit.lookHead,
						body = m_outfit.lookBody,
						legs = m_outfit.lookLegs,
						feet = m_outfit.lookFeet,
					},
					kills = kills,
					stages = {monster:bestiaryProwess(), monster:bestiaryExpertise(), monster:bestiaryMastery()},
					difficulty = monster:bestiaryDifficulty(),
					occurrence = monster:bestiaryOccurrence(),
					loot = Bestiary.formatLoot(monster:getLoot()),
					elements = Bestiary.formatElements(monster:getElementList())
				}

				table.insert(data, f_data)
			end
		end

		Bestiary.data[player:getGuid()] = data
	end
}

local stages = {
	[1] = {from = 0, to = 9999}, -- stage 1 (nivel de experiencia da criatura)
	--[2] = {from = 501, to = 1000}, -- stage 2 (nivel de experiencia da criatura)
	--[3] = {from = 1001, to = 100000000000}, -- stage 3  (nivel de experiencia da criatura)
}

local bestiary = {
	[1] = { -- stage 1
		[1] = { -- one star
			spawn = 20,
			health = 30,
			loot = 5000,
			defense = 5, 
			heal = 15,  
			attack = 30,  
			experience = 30,
			speed = 20
		},
		[2] = { -- two star
			spawn = 10,
			health = 60,
			loot = 10000,
			defense = 10, 
			heal = 30, 
			attack = 60, 
			experience = 60,
			speed = 40
		},
		[3] = { -- three star
			spawn = 5,
			health = 100,
			loot = 15000,
			defense = 15, 
			heal = 50,
			attack = 100,
			experience = 100,
			speed = 60
		}
	},
	[2] = { -- stage 2
		[1] = { -- one star
			spawn = 20,
			health = 300,
			loot = 24000,
			defense = 0, 
			heal = 100,  
			attack = 100,  
			experience = 300,
			speed = 50
		},
		[2] = { -- two star
			spawn = 10,
			health = 500,
			loot = 24000,
			defense = 0, 
			heal = 150, 
			attack = 150, 
			experience = 500,
			speed = 100
		},
		[3] = { -- three star
			spawn = 5,
			health = 1000,
			loot = 24000,
			defense = 0, 
			heal = 200,
			attack = 200,
			experience = 1000,
			speed = 150
		}
	},
	[3] = { -- stage 3
		[1] = { -- one star
			spawn = 20,
			health = 300,
			loot = 24000,
			defense = 0, 
			heal = 100,  
			attack = 100,  
			experience = 300,
			speed = 50
		},
		[2] = { -- two star
			spawn = 10,
			health = 500,
			loot = 24000,
			defense = 0, 
			heal = 150, 
			attack = 150, 
			experience = 500,
			speed = 100
		},
		[3] = { -- three star
			spawn = 5,
			health = 1000,
			loot = 24000,
			defense = 0, 
			heal = 200,
			attack = 200,
			experience = 1000,
			speed = 150
		}
	},
}

function getBestiaryStatsByExperience(experience)
	for stageId, p in pairs(stages) do
		if p.from <= experience and p.to >= experience then
			return bestiary[stageId]
		end
	end

	return bestiary[1]
end

function geBestiaryConfigByStarAndExperience(experience, star)
	return getBestiaryStatsByExperience(experience)[star]
end

local creatureevent = CreatureEvent("BestiaryHealthChange")

function creatureevent.onHealthChange(creature, attacker, damage, type, origin)
	if type == COMBAT_HEALING then
		if creature and creature:isMonster() then
			local star = creature:getStar()
			if star > 0 then
				-- healing based on force
				local percent = geBestiaryConfigByStarAndExperience(creature:getType():experience(), star).heal / 100

				if creature:getStorageValue("CopycatLowAttack") ~= -1 then
					percent = -2/3 -- cura apenas 1/3
				end

				damage = damage * (1 + percent)
			end
		end
	else
		if attacker and attacker:isMonster() then
			local star = attacker:getStar()
			if star > 0 then
				-- heal
				-- attack
				local percent = geBestiaryConfigByStarAndExperience(attacker:getType():experience(), star).attack / 100

				if attacker:getStorageValue("CopycatLowAttack") ~= -1 then
					percent = -2/3 -- cura apenas 1/3
				end

				damage = damage * (1 + percent)
			end
		elseif creature and creature:isMonster() then
			local star = creature:getStar()
			if star > 0 then
				-- defense
				local percent = geBestiaryConfigByStarAndExperience(creature:getType():experience(), star).defense / 100

				if creature:getStorageValue("CopycatLowAttack") ~= -1 then
					percent = -2 / 3 -- cura apenas 1/3
				end

				damage = damage * (1 - percent)
			end
		end
	end

	return damage, type
end

creatureevent:register()