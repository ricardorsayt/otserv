--[[
    ACCOUNT_TYPE_NORMAL = 1,
    ACCOUNT_TYPE_TUTOR = 2,
    ACCOUNT_TYPE_SENIORTUTOR = 3,
    ACCOUNT_TYPE_GAMEMASTER = 4,
    ACCOUNT_TYPE_GOD = 5

]]

local config = {
    interval = "1 hour",
    rewards = {[2160] = 5},
    -- [itemid] = count; [2160] = 1 - it gives 1 crystal coins
    website = false
}

function onThink(interval)
    if Game.getPlayerCount() == 0 then
        return true
    end

    local players = {}

    for _, player in ipairs(Game.getPlayers()) do
        if player:getAccountType() <= 2 then
            table.insert(players, player)
        end
    end

    local winner  = players[math.random(#players)]

    local items = {}
    for itemid, count in pairs(config.rewards) do
        items[#items + 1] = itemid
    end

    local itemid = items[math.random(1, #items)]
    local amount = config.rewards[itemid]
    winner:addItem(itemid, amount)

    local it   = ItemType(itemid)
    local name = ""
    if amount == 1 then
        name = it:getArticle() .. " " .. it:getName()
    else
        name = amount .. " " .. it:getPluralName()
    end

    broadcastMessage("[LOTTERY SYSTEM] " .. winner:getName() .. " won " .. name .. "! Congratulations! (Next lottery in " .. config.interval .. ")")

    if config.website then
        db.query("INSERT INTO `lottery` (`name`, `item`) VALUES (\"".. db.escapeString(winner:getName()) .."\", \"".. db.escapeString(it:getName()) .."\");")
    end
    return true
end