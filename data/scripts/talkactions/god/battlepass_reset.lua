local TalkAction = TalkAction("/reset_pass")

function TalkAction.onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        player:sendCancelMessage("Apenas administradores podem usar este comando.")
        return false
    end

    local playerId = player:getId()
    local guid = player:getGuid()

    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Você será desconectado. BattlePass será resetado.")
    player:remove()

    addEvent(function()
        local success = db.query("UPDATE players SET battlepass = NULL WHERE id = " .. guid)
        if success then
            print("[BattlePass] Resetado para jogador com id: " .. guid)
        else
            print("[BattlePass] Falha ao resetar battlepass para id: " .. guid)
        end
    end, 2000)

    return false
end

TalkAction:access(true)
TalkAction:register()
