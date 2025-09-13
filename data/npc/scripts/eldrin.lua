local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local topic = {}
local questStorage = 20000 -- Storage para verificar se a quest foi concluída
local itemStorageBase = 20010 -- Storage base para verificar itens entregues
local tradeCooldownStorage = 10003 -- Storage para cooldown da troca (20h)
local cooldownTime = 20 * 60 * 60 -- 20 horas

-- Itens necessários para a quest
local questItems = {
    {id = 1982, name = "Purple Tome", storage = itemStorageBase + 1},
    {id = 2033, name = "Golden Mug", storage = itemStorageBase + 2},
    {id = 2174, name = "Strange Symbol", storage = itemStorageBase + 3},
    {id = 4850, name = "Hydra Egg", storage = itemStorageBase + 4}
}

local tierPrices = {
    [1] = 10000,
    [2] = 50000,
    [3] = 200000,
    [4] = 500000
}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function greetCallback(cid)
    local player = Player(cid)
    local questStatus = player:getStorageValue(questStorage)

    if questStatus < 1 then
        selfSay("Greetings, traveler. I am Eldrin. I can trade your items, but before that I need some materials. Would you bring me them?", cid)
        topic[cid] = 1
    else
        selfSay("Ah, welcome back! Do you want to trade some item?", cid)
        topic[cid] = 0
    end

    return true
end

function checkQuestCompletion(player)
    for _, item in pairs(questItems) do
        if player:getStorageValue(item.storage) ~= 1 then
            return false
        end
    end
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    local questStatus = player:getStorageValue(questStorage)
    local currentTime = os.time()
    local lastTradeTime = player:getStorageValue(tradeCooldownStorage)

    -- Início da Quest
    if topic[cid] == 1 then
        if msg:lower() == "yes" then
            local itemList = ""
            for _, item in pairs(questItems) do
                itemList = itemList .. item.name .. ", "
            end
            itemList = itemList:sub(1, -3)

            selfSay("Excellent! I need you to bring me these artifacts: " .. itemList .. ". You can deliver me them one by one.", cid)
            topic[cid] = 2
        else
            selfSay("Very well, come back if you change your mind.", cid)
            topic[cid] = 0
        end

    -- Jogador entrega um item
    elseif topic[cid] == 2 then
        local foundItem = nil

        -- Verifica qual item o jogador está tentando entregar
        for _, item in pairs(questItems) do
            if msg:lower() == item.name:lower() then
                foundItem = item
                break
            end
        end

        if foundItem then
            -- Verifica se o jogador já entregou esse item
            if player:getStorageValue(foundItem.storage) == 1 then
                selfSay("You have already given me the " .. foundItem.name .. ". Bring the others.", cid)
            elseif player:getItemCount(foundItem.id) > 0 then
                -- Remove o item e marca como entregue
                player:removeItem(foundItem.id, 1)
                player:setStorageValue(foundItem.storage, 1)
                selfSay("Thank you for bringing the " .. foundItem.name .. ". Keep looking for the others.", cid)

                -- Verifica se todos os itens foram entregues
                if checkQuestCompletion(player) then
                    player:setStorageValue(questStorage, 1)
                    selfSay("You have brought me everything that I need! Now, I can trade your equipment. Just say trade when you are ready.", cid)
                    topic[cid] = 0
                end
            else
                selfSay("You don't have the item " .. foundItem.name .. ". Come back when you find it.", cid)
            end
        else
            selfSay("I do not recognize that item. Bring me one of the ones I asked for.", cid)
        end

    -- Após completar a Quest, permitir trocas
    elseif questStatus == 1 and topic[cid] == 0 then
        if msg:lower() == "trade" then
            if lastTradeTime > 0 and (currentTime - lastTradeTime) < cooldownTime then
                local remainingTime = cooldownTime - (currentTime - lastTradeTime)
                local hoursLeft = math.floor(remainingTime / 3600)
                selfSay("You need to wait " .. hoursLeft .. " more hours before making another trade.", cid)
                return true
            end

            selfSay("Tell me the exact name of the item you want to trade.", cid)
            topic[cid] = 3
        else
            selfSay("I can trade your items. Just say trade if you are ready.", cid)
        end

    elseif topic[cid] == 3 then
        local itemType = ItemType(msg)
        if itemType:getId() == 0 then
            selfSay("I don't recognize that item. Can you say the item name again?", cid)
            return true
        end

        local itemName = itemType:getName()
        local item = player:getItemById(itemType:getId(), true)

        if not item then
            selfSay("Are you kidding me? You don't have that item in your inventory. Maybe was a mistake do business with you!", cid)
            return true
        end

        local tierLevel = tonumber(item:getCustomAttribute("tr")) or 1
        if tierLevel < 1 or tierLevel > 4 then
            tierLevel = 1
        end

        local tradeCost = tierPrices[tierLevel]

        selfSay("You want to trade your " .. itemName .. "? I can do that for " .. tradeCost .. " gold.", cid)
        player:setStorageValue(10000, itemType:getId())
        player:setStorageValue(10001, tradeCost)
        player:setStorageValue(10002, tierLevel)
        topic[cid] = 4

    elseif topic[cid] == 4 then
        if msg:lower() == "yes" then
            local itemId = player:getStorageValue(10000)
            local tradeCost = player:getStorageValue(10001)

            if player:getMoney() < tradeCost then
                selfSay("You don't have enough gold!", cid)
                topic[cid] = 0
                return true
            end

            player:removeMoney(tradeCost)
            player:removeItem(itemId, 1)

            local newItem = player:addItem(itemId, 1)
            if newItem then
                newItem:rollRarity()
                selfSay("Here is your new " .. ItemType(itemId):getName() .. ". Hope you liked it!", cid)
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                player:setStorageValue(tradeCooldownStorage, os.time())
            end

            topic[cid] = 0
        elseif msg:lower() == "no" then
            selfSay("Alright, let me know if you change your mind.", cid)
            topic[cid] = 0
        end
    end

    return true
end

npcHandler:setMessage(MESSAGE_GREET, "")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
