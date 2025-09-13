local talkaction = TalkAction("/m", "/monster")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	
	logCommand(player, words, param)

	if not param or param == "" then
		player:sendCancelMessage("You need to specify a monster name.")
		return false
	end

	local params = param:splitTrimmed(",")

	name = params[1]
	elite = tonumber(params[2]) or 0

	local position = player:getPosition()
	local monster = Game.createMonster(name, position, true, true)

	
	if monster then
		monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
		monster:adjustMonsterStar(position, elite)
	else
		player:sendCancelMessage("There is not enough room.")
		position:sendMagicEffect(CONST_ME_POFF)
	end
	return false
end

talkaction:separator(" ")
talkaction:register()