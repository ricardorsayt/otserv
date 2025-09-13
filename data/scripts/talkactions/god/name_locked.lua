local talkaction = TalkAction("/namelock")

function talkaction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end
	
	logCommand(player, words, param)

    local name, reason = param:match('([^,]+),([^,]+)')

    if not name then
        name = param
    end

    if not name or name == "" then
        player:sendCancelMessage("Invalid parameters.")
        return false
    end

    local playerId = getPlayerGUIDByName(name)
    if playerId == 0 then
        player:sendCancelMessage("Invalid player name.")
        return false
    end

    local resultId = db.storeQuery("SELECT 1 FROM `player_namelocks` WHERE `player_id` = " .. playerId)
    if resultId ~= false then
        result.free(resultId)
        player:sendCancelMessage("Player is already name locked.")
        return false
    end

    local timeNow = os.time()

    db.query("INSERT INTO `player_namelocks` (`player_id`, `reason`, `namelocked_at`, `namelocked_by`) VALUES (" .. playerId .. ", " .. db.escapeString(reason or '') .. ", " .. timeNow .. ", " .. player:getGuid() .. ")")

    local target = Player(name)
    if target then
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        target:remove()
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, name .. " has been name locked" .. (reason and (", reason: " .. reason) or "") .. ".")
end

talkaction:separator(" ")
talkaction:register()