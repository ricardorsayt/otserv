local CONFIG = {
    DATA = {},
    EFFECT = CONST_ME_MAGIC_GREEN,
    ITEMS = {
        gold = 5584,
        silver = 5583,
        bronze = 5582
    },
    MESSAGES = {
        [5584] = "You have just received your Gold Founder's package, please check your store inbox!",
        [5583] = "You have just received your Silver Founder's package, please check your store inbox!",
        [5582] = "You have just received your Bronze Founder's package, please check your store inbox!"
    }
}

local creatureevent = CreatureEvent("founderPackLogin")

function creatureevent.onLogin(player)
    local playerName = player:getName()
    -- print("Player name: " .. playerName)

    local playerQuery = db.storeQuery("SELECT `id` FROM `players` WHERE `name` = " .. db.escapeString(playerName))
    if not playerQuery then
        -- print("Player não encontrado na tabela 'players'.")
        return true
    end

    local playerId = result.getDataInt(playerQuery, "id")
    result.free(playerQuery)

    -- print("Player ID no banco: " .. playerId)

    if CONFIG.DATA[playerId] then
        return true
    end

    local query = db.storeQuery("SELECT `bronze`, `silver`, `gold` FROM `order_items` WHERE `player_id` = " .. playerId .. " AND `status` = 'paid'")
    if not query then
        -- print("Nenhum item encontrado com status 'paid' para esse player_id.")
        return true
    end

    local bronze = tonumber(result.getDataString(query, "bronze")) or 0
    local silver = tonumber(result.getDataString(query, "silver")) or 0
    local gold = tonumber(result.getDataString(query, "gold")) or 0
    result.free(query)

    -- print("Bronze: " .. bronze)
    -- print("Silver: " .. silver)
    -- print("Gold: " .. gold)

    local storeInbox = player:getStoreInbox()
    local types = { {type="gold", count=gold}, {type="silver", count=silver}, {type="bronze", count=bronze} }

    for _, t in ipairs(types) do
        local amount = t.count
        local itemId = CONFIG.ITEMS[t.type]

        for i = 1, amount do
            local item = Game.createItem(itemId, 1)
            if item then
                item:setStoreItem(true)
                storeInbox:addItemEx(item, false, FLAG_NOLIMIT)
                item:setStoreItem(false)

                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, CONFIG.MESSAGES[itemId])
                player:getPosition():sendMagicEffect(CONFIG.EFFECT)
            else
                -- print("Erro ao criar item: " .. itemId)
            end
        end
    end

    db.query("UPDATE `order_items` SET `status` = 'delivered' WHERE `player_id` = " .. playerId .. " AND `status` = 'paid'")

    CONFIG.DATA[playerId] = true
    return true
end

creatureevent:register()
