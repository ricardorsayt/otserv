-- Constantes (do script novo)
local deathListEnabled = true
local maxDeathRecords = 5 -- Limite de registros de mortes para limpeza

-- Funcao auxiliar (do script antigo)
local function addAssistsPoints(attackerId, target)
    if not attackerId or type(attackerId) ~= 'number' then
        return
    end

    if not target or type(target) ~= 'userdata' or not target:isPlayer() then
        return
    end

    local ignoreIds = {attackerId, target:getId()}
    for id in pairs(target:getDamageMap()) do
        local tmpPlayer = Player(id)
        if tmpPlayer and not isInArray(ignoreIds, id) then
            tmpPlayer:setStorageValue(STORAGEVALUE_ASSISTS, math.max(0, tmpPlayer:getStorageValue(STORAGEVALUE_ASSISTS)) + 1)
        end
    end
end

function onDeath(player, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    local playerId = player:getId()
    if nextUseStaminaTime[playerId] ~= nil then
        nextUseStaminaTime[playerId] = nil
    end

    -- Funcao de AutoLootList (do script antigo)
    AutoLootList:onLogout(player:getId(), player:getGuid())

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You are dead.')
    if player:getStorageValue(Storage.SvargrondArena.Pit) > 0 then
        player:setStorageValue(Storage.SvargrondArena.Pit, 0)
    end
    
    -- Cupcakes storage [itemid = stg] (do script antigo)
    for i = 31719, 31720 do
        player:setStorageValue(i, -1)
    end

    if not deathListEnabled then
        return
    end

    local byPlayer = 0
    local killerName
    if killer ~= nil then
        if killer:isPlayer() then
            byPlayer = 1
        else
            local master = killer:getMaster()
            if master and master ~= killer and master:isPlayer() then
                killer = master
                byPlayer = 1
            end
        end
        -- Nome do killer: usa nome da descricao para monstros (do script antigo, mais informativo)
        killerName = killer:isMonster() and killer:getType():getNameDescription() or killer:getName()
    else
        killerName = 'field item'
    end

    local byPlayerMostDamage = 0
    local mostDamageKillerName
    if mostDamageKiller ~= nil then
        if mostDamageKiller:isPlayer() then
            byPlayerMostDamage = 1
        else
            local master = mostDamageKiller:getMaster()
            if master and master ~= mostDamageKiller and master:isPlayer() then
                mostDamageKiller = master
                byPlayerMostDamage = 1
            end
        end
        -- Nome do mostDamageKiller: usa nome da descricao para monstros (do script antigo, mais informativo)
        mostDamageName = mostDamageKiller:isMonster() and mostDamageKiller:getType():getNameDescription() or mostDamageKiller:getName()
    else
        mostDamageName = 'field item'
    end

    local playerGuid = player:getGuid()
    db.query('INSERT INTO `player_deaths` (`player_id`, `time`, `level`, `killed_by`, `is_player`, `mostdamage_by`, `mostdamage_is_player`, `unjustified`, `mostdamage_unjustified`) VALUES (' .. playerGuid .. ', ' .. os.stime() .. ', ' .. player:getLevel() .. ', ' .. db.escapeString(killerName) .. ', ' .. byPlayer .. ', ' .. db.escapeString(mostDamageName) .. ', ' .. byPlayerMostDamage .. ', ' .. (unjustified and 1 or 0) .. ', ' .. (mostDamageUnjustified and 1 or 0) .. ')')

    -- Limpeza de registros de mortes (do script novo)
    local resultIdDeaths = db.storeQuery('SELECT `player_id` FROM `player_deaths` WHERE `player_id` = ' .. playerGuid)
    local deathRecords = 0
    if resultIdDeaths ~= false then
        -- Conta o numero de registros
        local tmpResultId = resultIdDeaths
        while result.next(tmpResultId) do -- Use result.next para iterar
            deathRecords = deathRecords + 1
        end
        result.free(resultIdDeaths) -- Libera o resultado apos a contagem
    end

    local limit = deathRecords - maxDeathRecords
    if limit > 0 then
        db.asyncQuery("DELETE FROM `player_deaths` WHERE `player_id` = " .. playerGuid .. " ORDER BY `time` LIMIT " .. limit)
    end

    if byPlayer == 1 then
        -- Rastreamento de kills de jogadores (do script novo, com correcao para 'player_id')
        if killer and killer:isPlayer() then
            local killerPlayer = killer:getPlayer()
            -- Usar 'unjustified' do parametro da funcao onDeath, que e mais direto
            if killerPlayer and unjustified then
                local killerGuid = killerPlayer:getGuid()
                local playerGuid = player:getGuid()
                local currentTime = os.time()
                
                -- CORRECAO: Alterado SELECT `id` para SELECT `player_id` e adicionado verificacao robusta
                local existingKillResult = db.storeQuery("SELECT `player_id` FROM `player_kills` WHERE `player_id` = " .. killerGuid .. " AND `target` = " .. playerGuid .. " AND `time` = " .. currentTime)
                if existingKillResult ~= false and result.rowsAffected(existingKillResult) > 0 then
                    -- Kill ja registrado, nao faz nada
                    result.free(existingKillResult)
                else
                    db.asyncQuery("INSERT INTO `player_kills` (`player_id`, `target`, `time`, `unavenged`) VALUES (" .. killerGuid .. ", " .. playerGuid .. ", " .. currentTime .. ", 1)")
                    if existingKillResult ~= false then
                        result.free(existingKillResult)
                    end
                end
            end
        end

        -- Atualizacoes de Storage (do script antigo)
        addAssistsPoints(killer:getId(), player)
        player:setStorageValue(STORAGEVALUE_DEATHS, math.max(0, player:getStorageValue(STORAGEVALUE_DEATHS)) + 1)
        killer:setStorageValue(STORAGEVALUE_KILLS, math.max(0, killer:getStorageValue(STORAGEVALUE_KILLS)) + 1)
        
        player:setStorageValue(STORAGE_DEATH_COUNT, math.max(0, player:getStorageValue(STORAGE_DEATH_COUNT)) + 1)
        killer:setStorageValue(STORAGE_KILL_COUNT, math.max(0, killer:getStorageValue(STORAGE_KILL_COUNT)) + 1)
        
        -- Pontos de guild por matar jogador (do script antigo)
        if killer:getLevel() >= CONFIG_GUILD_MONSTERS.killingPlayer.level then
            local g = killer:getGuild()
            if g then
                local pts = CONFIG_GUILD_MONSTERS.killingPlayer.pts
                g:setGuildPoints(g:getGuildPoints() + pts)
                g:broadcastMessage(string.format(CONFIG_GUILD_MONSTERS.killingPlayer.msg, killer:getName(), pts), MESSAGE_EVENT_ADVANCE)
            end
        end

        -- Logica de guerra de guild (do script antigo, adaptado killer.uid para killer:getId())
        local targetGuild = player:getGuild()
        targetGuild = targetGuild and targetGuild:getId() or 0
        if targetGuild ~= 0 then
            local killerGuild = killer:getGuild()
            killerGuild = killerGuild and killerGuild:getId() or 0
            if killerGuild ~= 0 and targetGuild ~= killerGuild and isInWar(playerId, killer:getId()) then
                local warId = false
                local frags = false
                local resultIdWar = db.storeQuery('SELECT `id`, `frags_limit` FROM `guild_wars` WHERE `status` = 1 AND ((`guild1` = ' .. killerGuild .. ' AND `guild2` = ' .. targetGuild .. ') OR (`guild1` = ' .. targetGuild .. ' AND `guild2` = ' .. killerGuild .. '))')
                if resultIdWar ~= false then
                    warId = result.getNumber(resultIdWar, 'id')
                    frags = result.getNumber(resultIdWar, 'frags_limit')
                    result.free(resultIdWar)
                end

                if warId ~= false then
                    db.asyncQuery('INSERT INTO `guildwar_kills` (`killer`, `target`, `killerguild`, `targetguild`, `time`, `warid`) VALUES (' .. db.escapeString(killerName) .. ', ' .. db.escapeString(player:getName()) .. ', ' .. killerGuild .. ', ' .. targetGuild .. ', ' .. os.stime() .. ', ' .. warId .. ')')
                    addEvent(function(warid, guildid, guildid2, frags)
                        db.asyncStoreQuery("SELECT COUNT(*) as 'count' FROM `guildwar_kills` WHERE warid = ".. warid .." AND `killerguild` = " .. guildid .. ";",function(query)
                            if(query) then
                                local count = result.getNumber(query, 'count')
                                if count >= frags then
                                    db.asyncQuery("UPDATE `guild_wars` SET `status` = 4, `ended` = " .. os.stime() .. " WHERE id = " .. warid)

                                    -- Adicionado verificacao de nil para Guild objects
                                    local guild1Obj = Guild(guildid)
                                    local guild2Obj = Guild(guildid2)
                                    
                                    local guild1Name = guild1Obj and guild1Obj:getName() or "Unknown Guild (ID: " .. guildid .. ")"
                                    local guild2Name = guild2Obj and guild2Obj:getName() or "Unknown Guild (ID: " .. guildid2 .. ")"

                                    if guild1Obj then
                                        guild1Obj:broadcastMessage("War is over, please relog")
                                    end
                                    if guild2Obj then
                                        guild2Obj:broadcastMessage("War is over, please relog")
                                    end
                                    print(string.format("The war between '%s' and '%s' has ended.", guild1Name, guild2Name))
                                    Game.broadcastMessage(string.format("The war between '%s' and '%s' has ended. Winner: %s", guild1Name, guild2Name, guild1Name))
                                end
                            end

                        end)
                    end, 500, warId, killerGuild, targetGuild, frags)
                end
            end
        end
    end
end
