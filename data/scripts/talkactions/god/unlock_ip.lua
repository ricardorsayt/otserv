local talkaction = TalkAction("/unlockip")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	
	logCommand(player, words, param)

	local o1,o2,o3,o4 = param:match("(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)" )
	local num = 2^24*o1 + 2^16*o2 + 2^8*o3 + o4

	if num <= 0 then
		player:sendCancelMessage("Type in a valid IP Address (0.0.0.0)")
		return false
	end

	Game.unlockIp(tonumber(param))
	return false
end

talkaction:separator(" ")
talkaction:register()