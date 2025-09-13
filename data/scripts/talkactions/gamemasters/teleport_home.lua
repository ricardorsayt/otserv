local talkaction = TalkAction("/t", "/home")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
	
	logCommand(player, words, param)

	player:teleportTo(player:getTown():getTemplePosition())
	return false
end

talkaction:register()