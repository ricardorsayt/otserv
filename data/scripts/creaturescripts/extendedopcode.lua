local creatureevent = CreatureEvent("ExtendedOpCode")

local OPCODE_LANGUAGE = 1

function creatureevent.onExtendedOpcode(player, opcode, buffer)

	if opcode == 2 then
		NpcTalk.Read(player, buffer)
	elseif opcode == 64 then
		onGMTeleport(player, opcode, buffer)
	elseif opcode == 90 then
		Modal.Read(player, buffer)
	elseif opcode == 91 then
			Bestiary.read(player, buffer)
	elseif opcode == 202 then
    	onShopCallback(player, opcode, buffer)
	elseif opcode == OPCODE_LANGUAGE then
		-- otclient language
		if buffer == 'en' or buffer == 'pt' then
			-- example, setting player language, because otclient is multi-language...
			-- player:setStorageValue(SOME_STORAGE_ID, SOME_VALUE)
		end
	else
		-- other opcodes can be ignored, and the server will just work fine...
	end
end

creatureevent:register()