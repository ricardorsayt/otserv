function getPlayerAccountInfo(accountId, shouldUseName)
    local accountInfo = {}

    if shouldUseName ~= false then
        local resultQuery = db.storeQuery("SELECT name, email FROM accounts WHERE id = " .. accountId)

        if resultQuery ~= false then
            accountInfo["login"] = result.getString(resultQuery, "name")
            accountInfo["email"] = result.getString(resultQuery, "email")
            result.free(resultQuery)
        end
    else
        local resultQuery = db.storeQuery("SELECT id, email FROM accounts WHERE id = " .. accountId)

        if resultQuery ~= false then
            accountInfo["login"] = result.getString(resultQuery, "id")
            accountInfo["email"] = result.getString(resultQuery, "email")
            result.free(resultQuery)
        end
    end

    return accountInfo
end

function onLogin(player)
    local accountId = player:getAccountId()

    -- You should set the last parameter to true if your server uses login instead account number to authenticate the user.
    local playerAccountInfo = getPlayerAccountInfo(accountId, false)

    if playerAccountInfo ~= nil then
        local playerLogin = playerAccountInfo["login"]
        local playerEmail = playerAccountInfo["email"]
        
        if playerLogin ~= nil then
            local resultKickQuery = db.storeQuery("SELECT time from emac_anticheat_kicks where account_id = " .. accountId .. " AND (TIMESTAMPADD(SECOND, -10, CURRENT_TIMESTAMP) <= time) LIMIT 1")

            -- Prevent user from reconnecting too quickly after being kicked.
            if resultKickQuery ~= false then
                result.free(resultKickQuery)
                return false
            end

            -- Insert the user field in database, that field will be used by EMAC Anti-Cheat to update some informations (last heartbeat received, etc) 
            if playerEmail ~= nil then
                db.query("INSERT INTO emac_anticheat (account_id, name, email, version) VALUES (" .. accountId .. ", " .. db.escapeString(playerLogin) .. ", " .. db.escapeString(playerEmail) .. ", '9.9.9') ON DUPLICATE KEY UPDATE last_heartbeat_time = CURRENT_TIMESTAMP")
            else
                db.query("INSERT INTO emac_anticheat (account_id, name, version) VALUES (" .. accountId .. ", " .. db.escapeString(playerLogin) .. ", '9.9.9') ON DUPLICATE KEY UPDATE last_heartbeat_time = CURRENT_TIMESTAMP")
            end
            
            -- Check if user is banned from EMAC Anti-Cheat
            local resultQueryBan = db.storeQuery("SELECT account_id FROM emac_anticheat WHERE kicked = 0 AND banned = 1 AND account_id = "  .. accountId)
            if resultQueryBan ~= false then
                for _, charId in ipairs(getPlayersByAccountNumber(accountId)) do
                    local player = Player(charId)
                    if player ~= nil then
                        db.query("UPDATE emac_anticheat SET kicked = 1 WHERE account_id = " .. db.escapeString(accountId))
                    end
                end
                result.free(resultQueryBan)
            end
        end
    end

    return true
end