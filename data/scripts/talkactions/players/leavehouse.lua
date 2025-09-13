local talkaction = TalkAction("!leavehouse")

function talkaction.onSay(player, words, param)

	local position = player:getPosition()
	local tile = Tile(position)
	local house = tile and tile:getHouse()
	if not house then
		player:sendCancelMessage("You are not inside a house.")
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if house:getOwnerGuid() ~= player:getGuid() then
		player:sendCancelMessage("You are not the owner of this house.")
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local timestamp = os.time()
	db.asyncQuery(string.format("INSERT INTO `leave_house_history` (`player_id`, `house_id`, `time`, `date_str`) VALUES (%d, %d, %d, \"%s\")", player:getGuid(), house:getId(), timestamp, os.date("%d-%m-%Y %H:%M:%S", timestamp)))
	
	house:setOwnerGuid(0)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have successfully left your house.")
	position:sendMagicEffect(CONST_ME_POFF)
	return false
end

talkaction:register()