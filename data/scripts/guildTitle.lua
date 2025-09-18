local json = require("cjson") -- carrega suporte a JSON



local LoginEvent = CreatureEvent("guildTitle_Login")
function LoginEvent.onLogin(player)
	player:registerEvent("guildTitle")
	return true
end
LoginEvent:register()
local OPCODE_GUILDTITLE = 134

local guildTitle = CreatureEvent("guildTitle")
guildTitle:type("extendedopcode")
function guildTitle.onExtendedOpcode(player, opcode, buffer)
	if opcode and opcode == OPCODE_GUILDTITLE then
		local json_status, json_data =
		pcall(
			function()
				return json.decode(buffer)
			end
		)
		local creatureID = json_data.creature
		local creature = Creature(creatureID)
		if creature and creature:isPlayer() then
			local guild = creature:getGuild()
			if guild ~= nil then
				local data = {
					response = "SetGuildName",
					creatureId = creatureID,
					name = creature:getName(),
					guildNick = creature:getGuildNick(),
					guildName = guild:getName(),
				}
				player:sendExtendedOpcode(OPCODE_GUILDTITLE,json.encode(data))
			end
		end
	end
end
guildTitle:register()


