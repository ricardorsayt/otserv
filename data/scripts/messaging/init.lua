MESSAGING_SERVERSIDE = 253

local function sendJSON(player, action, data)
	local msg = NetworkMessage()
	msg:addByte(50)
	msg:addByte(MESSAGING_SERVERSIDE)
	msg:addString(json.encode({action = action, data = data}))
	msg:sendToPlayer(player)
end

function Player.sendMessageBox(self, t, m)
	sendJSON(self, "sendMessage", {title = t, message = m})
end

function sendMessageBox(self, t, m)
	return Player(self):sendMessageBox(t, m)
end