local saveserverEvent = GlobalEvent("Saving server before shutdown")
local runscriptsEvent = GlobalEvent("Run scripts before shutdown")

--saveserverEvent:time("5:55:00") -- Início dos avisos antes do save + entrar em manutenção no fim dos avisos
runscriptsEvent:time("6:03:00") -- Alguns segundos após entrar em manutenção, executar scripts diários importantes
--! INFO: This crontab task should be on "3 6 * * * /usr/bin/killall -9 tfs" to kill the server at 6:03 AM using the auto restarter script!
--! INFO: "ignoreMaintance = true" on local enviroment and "ignoreMaintance = false" on online enviroment
--? INFO: If you need to force restart, you can use /restart to auto warning players and shutdown in ~6 minutes.
--? INFO: If you need to force save, you can use /serversave to auto warning players and load serversave scripts, then shutdown in ~6 minutes.

local isWarning = false

local function warning()
    
    -- if isWarning then
    --     return true
    -- end

    -- isWarning = true

    -- Game.broadcastMessage("Server is saving game in 5 minutes.\nPlease come back in 15 minutes.", MESSAGE_STATUS_WARNING)

    -- Game.setGameState(GAME_STATE_CLOSED)

    -- -- First warning in 2 minutes
    -- addEvent(function()
    --     Game.broadcastMessage("Server is saving game in 3 minutes.\nPlease come back in 15 minutes.",
    --         MESSAGE_STATUS_WARNING)
    -- end, 2 * 60 * 1000)

    -- -- Last warning in 4 minutes
    -- addEvent(function()
    --     Game.broadcastMessage("Server is saving game in one minute.\nPlease log out.", MESSAGE_STATUS_WARNING)
    -- end, 4 * 60 * 1000)

    -- -- Server save function
    -- addEvent(function()
    --     Game.broadcastMessage("Server is starting maintance.", MESSAGE_STATUS_WARNING)
    --     Game.setGameState(GAME_STATE_MAINTAIN)
    -- end, 5 * 60 * 1000)

    -- addEvent(function()
    --     local players = Game.getPlayers()
    --     for _, player in pairs(players) do
    --         player:remove()
    --     end
    -- end, 5 * 60 * 1000 + 10)
end

local isShutdowing = false

local function shutdown()

    if isShutdowing then
        return true
    end

    isShutdowing = true

    saveServer() -- Save before finishes everything!
    Game.setGameState(GAME_STATE_SHUTDOWN)
end

local function serversave()

    if isShutdowing then
        return true
    end

    -- Run 'house' scripts before shutdown

    local resultId = db.storeQuery(
        "SELECT h.id FROM houses h JOIN players p ON h.owner = p.id JOIN accounts a ON p.account_id = a.id WHERE h.owner <> 0 AND UNIX_TIMESTAMP(NOW()) > a.premium_ends_at")
    if resultId ~= false then
        repeat
            local houseId = result.getDataInt(resultId, "id")
            local house = House(houseId)
            if house then
                house:setOwnerGuid(0)
            end
        until not result.next(resultId)
        result.free(resultId)
    end

    Game.payHouses()

    shutdown()
end

function saveserverEvent.onTime(interval)
    warning()
    return true
end

function runscriptsEvent.onTime(interval)
    serversave()
    return true
end

local restarterTalkaction = TalkAction("/restart")
restarterTalkaction:separator(" ")

function restarterTalkaction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return true
    end

    if isWarning then
        player:sendCancelMessage("Server is already in warning process.")
        return true
    end

    if isShutdowing then
        player:sendCancelMessage("Server is already in shutdown process.")
        return true
    end

    warning()

    addEvent(function()
        shutdown()
    end, 5 * 60 * 1000 + 30)
    return false
end

local serversaveTalkaction = TalkAction("/serversave")
serversaveTalkaction:separator(" ")

function serversaveTalkaction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return true
    end

    if isWarning then
        player:sendCancelMessage("Server is already in warning process.")
        return true
    end

    if isShutdowing then
        player:sendCancelMessage("Server is already in shutdown process.")
        return true
    end

    warning()

    addEvent(function()
        serversave()
    end, 5 * 60 * 1000 + 30)
    return false
end

saveserverEvent:register()
runscriptsEvent:register()
restarterTalkaction:register()
serversaveTalkaction:register()
