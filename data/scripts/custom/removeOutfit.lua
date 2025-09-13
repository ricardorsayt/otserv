local talkAction = TalkAction("/removeOutfit")
--/removeOutfit playerNAME,looktype
function talkAction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end

    local split = param:splitTrimmed(",")

    local tmpPlayer = Player(split[1])
    if not tmpPlayer then
        player:sendCancelMessage("Player not found.")
    end

    local looktype = tonumber(split[2])

    if looktype < 0 then
        player:sendCancelMessage("Invalid looktype.")
    end

    if tmpPlayer:removeOutfit(looktype) then
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Outfit %d has been removed from player: %s", looktype, split[1]))
    else
        player:sendCancelMessage("Error to remove outfit, invalid values.")
    end
end

talkAction:separator(" ")
talkAction:register() 