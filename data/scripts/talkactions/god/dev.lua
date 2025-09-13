local talkaction = TalkAction("/dev")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	
	logCommand(player, words, param)
	
	for i = 1, 100 do 
		player:addBestiaryKill(603)
	end
	Bestiary.send(player, "bestiaryKill", {["Dragon"] = player:getBestiaryKill(603)})	
end

talkaction:separator(" ")
talkaction:register()