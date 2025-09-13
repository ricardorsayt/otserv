local talkaction = TalkAction("!sellhouse")

function talkaction.onSay(player, words, param)
	local tradePartner = Player(param)
	if not tradePartner or tradePartner == player then
		player:sendCancelMessage("Trade player not found.")
		return false
	end

	local house = player:getTile():getHouse()
	if not house then
		player:sendCancelMessage("You must stand in your house to initiate the trade.")
		return false
	end

	if tradePartner:getLevel() < 30 then
		player:sendCancelMessage("You need level 30 or higher to buy a house.")
		return false
	end

	if configManager.getBoolean(configKeys.HOUSES_ONLY_PREMIUM) and not tradePartner:isPremium() then
		player:sendCancelMessage("You need a premium account in order to buy a house.")
		return false
	end

	local returnValue = house:startTrade(player, tradePartner)
	if returnValue ~= RETURNVALUE_NOERROR then
		player:sendCancelMessage(returnValue)
	end
	return false
end

talkaction:separator(" ")
talkaction:register()