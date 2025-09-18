local talkaction = TalkAction("/test_rarity")

function talkaction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end

    local itemType = ItemType(param)
    if itemType:getId() == 0 then
        itemType = ItemType(tonumber(param))
        if not tonumber(param) or itemType:getId() == 0 then
            player:sendCancelMessage("There is no item with that id or name.")
            return false
        end
    end

    local count = 1

    local result = player:addItem(itemType:getId(), count)
    if result then
        local raridades = {}
        local N = 1
        for i = 1, N do
            result:rollRarity()
            local rarityAttr = tonumber(result:getCustomAttribute("ry"))
            if rarityAttr == 2 then
                rarityAttr = "incomum"
            elseif rarityAttr == 3 then
                rarityAttr = "raro"
            elseif rarityAttr == 4 then
                rarityAttr = "epic"
            elseif rarityAttr == 5 then
                rarityAttr = "lendario"
            else
                rarityAttr = "comum"
            end
            if not raridades[rarityAttr] then
                raridades[rarityAttr] = 1
            else
                raridades[rarityAttr] = raridades[rarityAttr] + 1
            end
        end
        for k, v in pairs(raridades) do
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "raridade " .. k .. " = " .. math.floor((v / N) * 10000) / 100 .. "% dos gerados!")
        end

        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    end
    return false
end

talkaction:separator(" ")
talkaction:register()