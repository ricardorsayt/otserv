function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)

    local tileConfig = {
        kickPos = Position(32060, 32192, 7),
        kickEffect = CONST_ME_MAGIC_BLUE,
        kickMsg = "Somente jogadores VIP podem passar!",
        enterMsg = "Bem-vindo a uma área VIP!",
        enterEffect = CONST_ME_MAGIC_BLUE,
    }

    if not player then
        return true
    end

    if player:getStorageValue(30037) > 0 and item.actionid == 50241 then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_EXTENDED, tileConfig.enterMsg)
        doSendMagicEffect(position, tileConfig.enterEffect)
        return true
    end
    
    -- Este bloco será executado se o jogador não for VIP.
    doTeleportThing(cid, tileConfig.kickPos)
    doSendMagicEffect(tileConfig.kickPos, tileConfig.kickEffect)
    doPlayerSendCancel(cid, tileConfig.kickMsg)
    return true
end