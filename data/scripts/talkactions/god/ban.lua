local talkaction = TalkAction("/ban")

function talkaction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end
	
	logCommand(player, words, param)

    local defaultBanDays = 0
    local name, reason, banDays = param:match('([^,]+),([^,]+),([^,]+)')
    if not name then
        name, reason = param:match('([^,]+),([^,]+)')
        if not name then
            name = param
        end
    end

    if not name or name == "" then
        player:sendCancelMessage("Invalid parameters.")
        return false
    end

    local accountId = getAccountNumberByPlayerName(name)
    if accountId == 0 then
        player:sendCancelMessage("Invalid player name.")
        return false
    end

    local resultId = db.storeQuery("SELECT 1 FROM `account_bans` WHERE `account_id` = " .. accountId)
    if resultId ~= false then
        result.free(resultId)
        player:sendCancelMessage("Player is already banned.")
        return false
    end

    local timeNow = os.time()
    banDays = tonumber(banDays)

    local banDaysMessage
    local expiresAt
    if not banDays or banDays == 0 then
        expiresAt = 0
        banDaysMessage = " permantently"
    else
        expiresAt = timeNow + (banDays or defaultBanDays) * 86400
        banDaysMessage = ((banDays or defaultBanDays) and (" for " .. (banDays or defaultBanDays) .. " days") or "")
    end

    db.query("INSERT INTO `account_bans` (`account_id`, `reason`, `banned_at`, `expires_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(reason or '') .. ", " .. timeNow .. ", " .. expiresAt .. ", " .. player:getGuid() .. ")")

    local guids = {}
    local query = db.storeQuery("SELECT `id` FROM `players` WHERE `account_id` = " .. tostring(accountId))
    if query then
        repeat
            local playerGUID = result.getNumber(query, "id")
            table.insert(guids, playerGUID)
        until not result.next(query)
        result.free(query)
    end

    for _, house in ipairs(Game.getHouses()) do
        if table.contains(guids, house:getOwnerGuid()) then
            house:setAccessList(GUEST_LIST, "")
            house:setAccessList(SUBOWNER_LIST, "")
        end
    end

    local target = Player(name)
    if target then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, target:getName() .. " has been banned" .. banDaysMessage .. (reason and (", reason: " .. reason) or "") .. ".")
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        target:remove()
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, name .. " has been banned" .. banDaysMessage .. (reason and (", reason: " .. reason) or "") .. ".")
    end
	
	local banMessage = name .. " has been banned" .. banDaysMessage .. (reason and (", reason: " .. reason) or "") .. "."
	for _, targetPlayer in ipairs(Game.getPlayers()) do
		targetPlayer:sendPrivateMessage(player, banMessage, TALKTYPE_BROADCAST)
	end
end

talkaction:separator(" ")
talkaction:register()