local talkaction = TalkAction("/manafull")

function talkaction.onSay(_player, words, param)
    if not _player:getGroup():getAccess() then
        return true
    end

    if _player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
	
	logCommand(player, words, param)

    local name = param:trim()
    local player = Player(name)
    
    if not player then
        _player:sendCancelMessage("Player not found.")
        return false
    end

    local addedMana = player:getMaxMana() - player:getMana()
    
    player:addMana(addedMana)
    local name = player:getName()
    local id = _player:getId()
    addEvent(function()
        local player = Player(name)
        if player then
            player:addMana(-addedMana)
            local god = Player(id)
            if god then
                god:sendCancelMessage("Mana removed.")
            end
        end
    end, 5 * 1000)
    _player:sendCancelMessage("Mana added.")
    return false
end

talkaction:separator(" ")
talkaction:register()