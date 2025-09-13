local talkaction = TalkAction("!online")

local maxPlayersPerMessage = 10

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end

    local players = Game.getPlayers()
	local onlineList = {}

	for _, targetPlayer in ipairs(players) do
		if player:canSeeCreature(targetPlayer) then
			table.insert(onlineList, ("%s"):format(targetPlayer:getName()))
		end
	end

	local playersOnline = #onlineList
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, ("%d players online."):format(playersOnline))

	for i = 1, playersOnline, maxPlayersPerMessage do
		local j = math.min(i + maxPlayersPerMessage - 1, playersOnline)
		local msg = table.concat(onlineList, ", ", i, j) .. "."
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, msg)
	end
	return false
end

talkaction:register()