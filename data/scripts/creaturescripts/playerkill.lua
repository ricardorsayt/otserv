function Player:sendKillStatistics(addKill)
	local today = os.time()
	
	local killsDayRedSkull = configManager.getNumber(configKeys.KILLS_DAY_RED_SKULL)
	local killsWeekRedSkull = configManager.getNumber(configKeys.KILLS_WEEK_RED_SKULL)
	local killsMonthRedSkull = configManager.getNumber(configKeys.KILLS_MONTH_RED_SKULL)
	local killsDayBanishement = configManager.getNumber(configKeys.KILLS_DAY_BANISHMENT)
	local killsWeekBanishement = configManager.getNumber(configKeys.KILLS_WEEK_BANISHMENT)
	local killsMonthBanishement = configManager.getNumber(configKeys.KILLS_MONTH_BANISHMENT)
	
	local kills = self:getMurderTimestamps()
	
	if addKill then
		kills[#kills+1] = today
	end

	--local c = self:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

	local info = {
		player = {},
		red = {day = killsDayRedSkull, week = killsWeekRedSkull, month = killsMonthRedSkull},
		ban = {day = killsDayBanishement, week = killsWeekBanishement, month = killsMonthBanishement},
		unlockTime = self:getPlayerKillerEnd(),
		--conditionTicks = c and math.floor(c:getTicks() / 1000) or 0,
		now = os.time()
	}

	for i = 1, #kills do
		info.player[tostring(i)] = kills[i]
	end

	self:sendExtendedOpcode(GameServerOpcodes.GameWhiteRedSkullStatistics, json.encode(info))
end

local CreatureEventKill = CreatureEvent("PlayerKillsPlayerOnKill")

function CreatureEventKill.onDeath(target, corpse, player, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	--(target, corpse, player, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if not target or not target:isPlayer() or not player or not player:isPlayer() then
		return true 
	end
	--TODO: Não adicionar kill quando o cara morto já tiver pk previamente

	player:sendKillStatistics()
	return true
end

CreatureEventKill:register()

local CreatureEventLogin = CreatureEvent("PlayerKillsPlayerOnLogin")

function CreatureEventLogin.onLogin(player)
    player:registerEvent("PlayerKillsPlayerOnKill")
    player:registerEvent("SkullModuleExtendedOpcode")
	player:sendKillStatistics()
    return true
end

CreatureEventLogin:register()

local ExtendedEvent = CreatureEvent("SkullModuleExtendedOpcode")

function ExtendedEvent.onExtendedOpcode(player, opcode, buffer)
	if opcode == GameServerOpcodes.GameWhiteRedSkullStatistics then
		player:sendKillStatistics()
	end
end

ExtendedEvent:type("extendedopcode")
ExtendedEvent:register()