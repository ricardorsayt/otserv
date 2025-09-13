function disconnectPlayer(charId)
    local player = Player(charId)

    if player ~= nil then
        -- WARNING: Some versions of theforgottenserver do not have the hasCondition function exported
        if not player:hasCondition(CONDITION_INFIGHT) then
            player:remove()
        else
            -- WARNING: That function is a custom exported function, you should define it yourself
            player:disconnect()
        end
    end

    return true
end

function showMessageAndDisconnect(charId, message)
    local player = Player(charId)

    if player ~= nil then
        player:popupFYI(message)
	    player:sendTextMessage(MESSAGE_STATUS_WARNING, message)
    end
    
    addEvent(disconnectPlayer, 2500, charId)
end

function getCurrentTimestamp()
	local currentTimestamp = os.time(os.date("!*t"))

    -- Query current timestamp from database to avoid timing discrepancies between OS time and database time
    local resultQuery = db.storeQuery("SELECT UNIX_TIMESTAMP() as timestamp")

    if resultQuery ~= false then
        currentTimestamp = result.getNumber(resultQuery, "timestamp")
        result.free(resultQuery)
    end

    return currentTimestamp
end

-- Some versions of theforgottenserver do not have this function defined, so let's define it ourselves
function getPlayersByAccountNumberEMAC(accountNumber)
	local result = {}

	for _, player in ipairs(Game.getPlayers()) do
		if player:getAccountId() == accountNumber then
			result[#result + 1] = player:getId()
		end
	end

	return result
end

local function getWhitelistedPlayers()
    local whitelistedPlayers = {}
    local resultQuery = db.storeQuery("SELECT account_id from emac_anticheat_whitelist")

    if resultQuery ~= false then
        repeat
            whitelistedPlayers[#whitelistedPlayers + 1] = result.getNumber(resultQuery, "account_id")
        until not result.next(resultQuery)
        result.free(resultQuery)
    end

    return whitelistedPlayers
end

local function getAnticheatConfig()
    local config = {}
    local resultQueryConfig = db.storeQuery("SELECT name, value FROM emac_anticheat_config")

    if resultQueryConfig ~= false then
        repeat
            config[result.getString(resultQueryConfig, "name")] = result.getString(resultQueryConfig, "value")
        until not result.next(resultQueryConfig)

        result.free(resultQueryConfig)
    
        return config
    end

    return nil
end

local function isPlayerWhitelisted(accountId, whitelistedPlayers)
    for _, whitelistedAccountId in ipairs(whitelistedPlayers) do
        if whitelistedAccountId == accountId then
            return true
        end
    end

    return false
end

local function checkPlayers(anticheatConfig, minVersion)
    local whitelistedPlayers = getWhitelistedPlayers()
    local kickStr = (anticheatConfig["kick_message_noac"] ~= nil and anticheatConfig["kick_message_noac"] or "You must use EMAC Anti-Cheat to play on this server")
	local kickCheatStr = (anticheatConfig["kick_message_cheat"] ~= nil and anticheatConfig["kick_message_cheat"] or "Kicked by EMAC Anti-Cheat (cheat detected)")
    local kickBanStr = (anticheatConfig["kick_message_bannedcheat"] ~= nil and anticheatConfig["kick_message_bannedcheat"] or "You have been banned by EMAC Anti-Cheat")
    local kickVersionStr = (anticheatConfig["kick_message_oldversion"] ~= nil and anticheatConfig["kick_message_oldversion"] or "You need to reopen your client to update EMAC Anti-Cheat to the lastest version to play on this server")
    
    -- List all players that don't have the field last_heartbeat_time updated in the last 5 minutes (300 seconds) or have the fields cheating/banned equal to 1
    local resultQueryHeartbeat = db.storeQuery("SELECT account_id, banned, cheating, kicked, version FROM emac_anticheat WHERE (kicked = 0 AND ((TIMESTAMPADD(SECOND, -300, CURRENT_TIMESTAMP) > last_heartbeat_time) OR (version < " .. db.escapeString(minVersion) .. ") OR (cheating = 1) OR (banned = 1)))")

    if resultQueryHeartbeat ~= false then
		repeat
			local accountId = result.getNumber(resultQueryHeartbeat, "account_id")
			local banned = result.getNumber(resultQueryHeartbeat, "banned")
			local cheating = result.getNumber(resultQueryHeartbeat, "cheating")
			local kicked = result.getNumber(resultQueryHeartbeat, "kicked")
			local version = result.getString(resultQueryHeartbeat, "version")

			for _, charId in ipairs(getPlayersByAccountNumber(accountId)) do
                if not isPlayerWhitelisted(accountId, whitelistedPlayers) then
				    local player = Player(charId)
				    if player ~= nil then
					    local kickMessageStr = kickStr
					    if cheating == 1 then
						    kickMessageStr = kickCheatStr
					    elseif banned == 1 then
						    kickMessageStr = kickBanStr
                        elseif version ~= nil and version < minVersion then
                            kickMessageStr = kickVersionStr
					    end

                        -- Insert into table emac_anticheat_kicks
					    db.query("INSERT INTO emac_anticheat_kicks (account_id, kick_reason, version, time) VALUES (" .. accountId .. ", " .. db.escapeString(kickMessageStr) .. ", " .. db.escapeString(version) .. ", CURRENT_TIMESTAMP)")
					
                        -- Update kicked field to 1
					    db.query("UPDATE emac_anticheat SET kicked = 1 WHERE account_id = " .. accountId)

                        -- Show a message to the user to know what is happening
                        showMessageAndDisconnect(charId, kickStr)
				    end
			    end
            end
		until not result.next(resultQueryHeartbeat)
		
        result.free(resultQueryHeartbeat)
	end
end

local function heartbeat()
    local anticheatConfig = getAnticheatConfig()

    if anticheatConfig ~= nil then
        local lastHeartbeatTime = (anticheatConfig["last_heartbeat_time"] ~= nil and anticheatConfig["last_heartbeat_time"] or "0")
        local enableKick = (anticheatConfig["enable_kick"] ~= nil and anticheatConfig["enable_kick"] or "0")
        local minVersion = (anticheatConfig["min_version"] ~= nil and anticheatConfig["min_version"] or "1.0.0")

        -- Only start players scan if the enable_kick field is set to 1
        if enableKick == "1" then
            local currentTimestamp = getCurrentTimestamp()
            local isBackendExecuting = ((currentTimestamp - tonumber(lastHeartbeatTime)) < 120)

            -- Only start players scan if we are sure that the anticheat backend is running
            if isBackendExecuting ~= false then
                checkPlayers(anticheatConfig, minVersion)
            end
        end
    end

    -- Execute again the heartbeat scan after 25 seconds
    addEvent(heartbeat, 25000)
    
    return true
end

function onStartup()
    print("> EMAC Anti-cheat Loaded!")

    -- Truncate anti cheat tables
    db.query("TRUNCATE TABLE emac_anticheat")
	db.query("TRUNCATE TABLE emac_anticheat_kicks")

    -- Execute heartbeat function after 5 seconds
    addEvent(heartbeat, 5000)
end