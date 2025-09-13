local safeCloseCheck = GlobalEvent("Safe Close Checker")
--safeCloseCheck:type("think")
safeCloseCheck:interval(30 * 1000)

function safeCloseCheck.onThink(interval)

    local resultId = db.storeQuery("SELECT `value` FROM `server_config` WHERE `config` = 'safeClose' LIMIT 1")
    if not resultId then
        print("[SafeCloseChecker] Nenhum valor encontrado.")
        return true
    end

    local value = result.getDataString(resultId, "value")
    result.free(resultId)

    if value == "unscheduled" then
        print("[SafeCloseChecker] safeClose activated. Starting unscheduled maintenance procedure...")

        db.query("UPDATE `server_config` SET `value` = 'false' WHERE `config` = 'safeClose'")

        broadcastMessage("[NOTICE] Unscheduled maintenance will begin in 15 minutes.\nEstimated downtime: 15 minutes.\nCheck our Discord or website news for updates.", MESSAGE_STATUS_WARNING)

        addEvent(function()
            broadcastMessage("[NOTICE] Unscheduled maintenance will begin in 10 minutes.\nEstimated downtime: 15 minutes.\nCheck our Discord or website news for updates.", MESSAGE_STATUS_WARNING)
        end, 5 * 60 * 1000)

        addEvent(function()
            broadcastMessage("[NOTICE] Unscheduled maintenance will begin in 5 minutes.\nEstimated downtime: 15 minutes.\nCheck our Discord or website news for updates.", MESSAGE_STATUS_WARNING)
        end, 10 * 60 * 1000)

        addEvent(function()
            broadcastMessage("[NOTICE] Unscheduled maintenance will begin in 3 minutes.\nEstimated downtime: 15 minutes.\nCheck our Discord or website news for updates.", MESSAGE_STATUS_WARNING)
        end, 12 * 60 * 1000)

        addEvent(function()
            broadcastMessage("[NOTICE] Unscheduled maintenance will begin in 1 minute.\nPlease log out now.\nEstimated downtime: 15 minutes.\nCheck our Discord or website news for updates.", MESSAGE_STATUS_WARNING)
        end, 14 * 60 * 1000)

        addEvent(function()
            broadcastMessage("[NOTICE] Server is entering unscheduled maintenance now.\nAll players will be disconnected.", MESSAGE_STATUS_WARNING)
            Game.setGameState(GAME_STATE_MAINTAIN)
        end, 15 * 60 * 1000)

        addEvent(function()
            for _, player in pairs(Game.getPlayers()) do
                player:remove()
            end
        end, 15 * 60 * 1000 + 10)

        addEvent(function()
            saveServer()
            Game.setGameState(GAME_STATE_SHUTDOWN)
        end, 15 * 60 * 1000 + 30)
    end

    if value == "serve-save" then
        print("[SafeCloseChecker] safeClose activated. Starting scheduled server save procedure...")

        db.query("UPDATE `server_config` SET `value` = 'false' WHERE `config` = 'safeClose'")

        addEvent(function()
            broadcastMessage("Server is saving game in 5 minutes.\nPlease come back in 15 minutes.", MESSAGE_STATUS_WARNING)
        end, 0 * 60 * 1000)

        addEvent(function()
            broadcastMessage("Server is saving game in 3 minutes.\nPlease come back in 15 minutes.", MESSAGE_STATUS_WARNING)
        end, 2 * 60 * 1000)

        addEvent(function()
            broadcastMessage("Server is saving game in one minute.\nPlease log out.", MESSAGE_STATUS_WARNING)
        end, 4 * 60 * 1000)

        addEvent(function()
            broadcastMessage("Server is now saving. All players will be disconnected..", MESSAGE_STATUS_WARNING)
        end, 5 * 60 * 1000)

        addEvent(function()
            for _, player in pairs(Game.getPlayers()) do
                player:remove()
            end
        end, 5 * 60 * 1000 + 10)

        addEvent(function()
            saveServer()
            Game.setGameState(GAME_STATE_SHUTDOWN)
        end, 5 * 60 * 1000 + 30)
    end

    return true
end

safeCloseCheck:register()
