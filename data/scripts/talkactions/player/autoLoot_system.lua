-- autoLoot_system_merged.lua
-- Unifica coleta correta (v1) + janela/ponte QuickLoot (v3) e manda tudo para a Loot Pouch.
-- Coleta SEMPRE: moedas (2148, 2152, 2160); e itens da lista do jogador.

local jsonOk, json = pcall(require, "cjson")
if not jsonOk then
    local ok2, j2 = pcall(require, "json")
    if ok2 then json = j2 else
        local ok3, j3 = pcall(require, "dkjson")
        if ok3 then json = j3 else json = nil end
    end
end

-- =========================
-- Estrutura de dados (v3)
-- =========================
AutoLootList = { players = {} }

function AutoLootList:init(playerGuid)
    self.players[playerGuid] = { lootList = {} }
    local q = "SELECT `item_id` FROM `auto_loot_list` WHERE `player_id` = " .. playerGuid
    local resultId = db.storeQuery(q)
    if resultId then
        self.players[playerGuid].lootList = queryToTable(resultId, {'item_id:number'})
        result.free(resultId)
    end
end

function AutoLootList:addItem(playerGuid, itemId)
    if not self.players[playerGuid] then self:init(playerGuid) end
    if self:itemInList(playerGuid, itemId) then return false end
    local ok = db.query("INSERT INTO `auto_loot_list` (`player_id`, `item_id`) VALUES (" .. playerGuid .. ", " .. itemId .. ")")
    if ok then
        table.insert(self.players[playerGuid].lootList, { item_id = itemId })
        return true
    end
    return false
end

function AutoLootList:removeItem(playerGuid, itemId)
    if not self.players[playerGuid] then self:init(playerGuid) end
    local ok = db.query("DELETE FROM `auto_loot_list` WHERE `player_id` = " .. playerGuid .. " AND `item_id` = " .. itemId)
    if ok then
        for i, it in ipairs(self.players[playerGuid].lootList) do
            if it.item_id == itemId then table.remove(self.players[playerGuid].lootList, i) break end
        end
        return true
    end
    return false
end

function AutoLootList:clear(playerGuid)
    if not self.players[playerGuid] then return false end
    local ok = db.query("DELETE FROM `auto_loot_list` WHERE `player_id` = " .. playerGuid)
    if ok then
        self.players[playerGuid].lootList = {}
        return true
    end
    return false
end

function AutoLootList:itemInList(playerGuid, itemId)
    local pdata = self.players[playerGuid]
    if not pdata then return false end
    for _, it in ipairs(pdata.lootList) do
        if it.item_id == itemId then return true end
    end
    return false
end

function AutoLootList:countList(playerGuid)
    local pdata = self.players[playerGuid]
    return pdata and #pdata.lootList or 0
end

function AutoLootList:getItemList(playerGuid)
    local pdata = self.players[playerGuid]
    return pdata and pdata.lootList or {}
end

-- =========================
-- Startup: carrega DB (v1/v3)
-- =========================
local autoLootStartup = GlobalEvent("AutoLootStartup")
function autoLootStartup.onStartup()
    lootBlockListm, lootBlockListn, lastItem, autolootBP = {}, {}, {}, 1
    Game.sendConsoleMessage("> Loading autoloot data from database...", CONSOLEMESSAGE_TYPE_STARTUP)
    local resultId = db.storeQuery('SELECT DISTINCT `player_id` FROM `auto_loot_list`')
    if resultId then
        local playersLoaded = 0
        repeat
            local pg = result.getNumber(resultId, "player_id")
            if pg then AutoLootList:init(pg); playersLoaded = playersLoaded + 1 end
        until not result.next(resultId)
        result.free(resultId)
        Game.sendConsoleMessage(string.format("> Loaded autoloot data for %d players", playersLoaded), CONSOLEMESSAGE_TYPE_STARTUP)
    else
        Game.sendConsoleMessage("> No autoloot data found in database", CONSOLEMESSAGE_TYPE_STARTUP)
    end
    return true
end
autoLootStartup:register()

-- =========================
-- Config
-- =========================
local config = {
    vipMaxItems = configManager.getNumber(configKeys.VIP_AUTOLOOT_LIMIT),
    freeMaxItems = configManager.getNumber(configKeys.FREE_AUTOLOOT_LIMIT),
    exhaustTime = 2,
    rewardBossMessage = "You cannot view the loot of Reward Chest bosses.",
    GOLD_POUCH = 26377,
    blockedIds = {2393}, -- bloquear adicionar itens especificos na lista
}

-- Moedas SEMPRE coletadas
local coinIds = {2148, 2152, 2160} -- gold / platinum / crystal
local coinSet = {}
for _, id in ipairs(coinIds) do coinSet[id] = true end

-- =========================
-- Util/Msgs
-- =========================
local AUTO_LOOT_COOLDOWN_STORAGE = 10001
local OPCODE_QUICKLOOT = 50

local function trim(s) return s:match("^%s*(.-)%s*$") end
local function isInArray(t, v) for _,x in ipairs(t) do if x==v then return true end end return false end

local function sendLootMessage(player, msg, kind)
    local color = MESSAGE_STATUS_CONSOLE_BLUE
    if kind == "success" then color = MESSAGE_STATUS_CONSOLE_GREEN
    elseif kind == "error" then color = MESSAGE_STATUS_CONSOLE_RED
    elseif kind == "warning" then color = MESSAGE_STATUS_CONSOLE_ORANGE
    elseif kind == "collected" then color = MESSAGE_STATUS_CONSOLE_BLUE
    elseif kind == "info" then color = MESSAGE_STATUS_CONSOLE_BLUE
    end
    player:sendTextMessage(color, msg)
    if kind == "collected" or kind == "info" or kind == "warning" then
        player:sendChannelMessage("", msg, TALKTYPE_CHANNEL_O, 9)
    end
end

-- =========================
-- Gold Pouch helpers
-- =========================
local function getGoldPouchUsedSlots(player)
    local goldPouch = player:getItemById(config.GOLD_POUCH, true)
    if not goldPouch then return 0 end
    local used = 0
    for i=0, goldPouch:getCapacity()-1 do if goldPouch:getItem(i) then used = used + 1 end end
    return used
end

local function getGoldPouchMaxSlots(player)
    local goldPouch = player:getItemById(config.GOLD_POUCH, true)
    return goldPouch and goldPouch:getCapacity() or 0
end

local function canStackInGoldPouch(player, itemId, count)
    local goldPouch = player:getItemById(config.GOLD_POUCH, true)
    if not goldPouch then return false, 1 end
    local it = ItemType(itemId)
    if not it:isStackable() then return false, count end
    local maxStack = 100
    for i=0, goldPouch:getCapacity()-1 do
        local slotItem = goldPouch:getItem(i)
        if slotItem and slotItem:getId() == itemId then
            local cur = slotItem:getCount()
            if cur + count <= maxStack then
                return true, 0
            else
                local remaining = count - (maxStack - cur)
                local newSlots = math.ceil(remaining / maxStack)
                return false, newSlots
            end
        end
    end
    local slotsNeeded = math.ceil(count / maxStack)
    return false, slotsNeeded
end

local function moveToGoldPouch(player, item)
    local goldPouch = player:getItemById(config.GOLD_POUCH, true)
    if not goldPouch then
        return false
    end
    return item:moveTo(goldPouch)
end

-- =========================
-- Coleta pos-kill (v1) + SEMPRE moedas
-- =========================
function AutoLootList.getLootItem(self, playerCid, position)
    local player = Player(playerCid)
    if not player then return false end

    local pguid = player:getGuid()
    local itemCount = self:countList(pguid)

    local tile = Tile(position); if not tile then return false end
    local corpse = tile:getTopDownItem()
    if not corpse or not corpse:isContainer() then return false end

    local goldPouch = player:getItemById(config.GOLD_POUCH, true)
    -- NOVO: Se o jogador for 'free' e nao tiver itens na lista, nao mostrar a mensagem.
    if not goldPouch and itemCount == 0 and (player:getVipDays() <= os.time()) then
        return false
    end

    if not goldPouch then
        sendLootMessage(player, "You need a Gold Pouch to use auto-loot.", "error")
        return false
    end

    local usedSlots = getGoldPouchUsedSlots(player)
    local maxSlots = getGoldPouchMaxSlots(player)
    local available = maxSlots - usedSlots
    local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"

    if available <= 0 then
        sendLootMessage(player, string.format("Auto-loot disabled: Gold Pouch is full. %s: %d/%d slots used.", accountType, usedSlots, maxSlots), "warning")
        return false
    end

    -- snapshot dos itens
    local items = {}
    for i=0, corpse:getSize()-1 do
        local it = corpse:getItem(i)
        if it then table.insert(items, it) end
    end

    local itemsCollected, slotsUsedThisSession = 0, 0

    for _, item in ipairs(items) do
        local iid = item:getId()
        local shouldCollect = coinSet[iid] or self:itemInList(pguid, iid)
        if shouldCollect then
            local canStack, slotsNeeded = canStackInGoldPouch(player, iid, item:getCount())

            if slotsUsedThisSession + slotsNeeded > available then
                local currentUsed = usedSlots + slotsUsedThisSession
                sendLootMessage(player, string.format("Collection stopped: Not enough space in Gold Pouch. %s: %d/%d slots used.", accountType, currentUsed, maxSlots), "warning")
                break
            end

            local itemWeight = ItemType(iid):getWeight() * item:getCount()
            if player:getFreeCapacity() < itemWeight then
                sendLootMessage(player, string.format("Not enough capacity to collect %s (need %d oz).", item:getName(), itemWeight), "warning")
                break
            end

            local moved = moveToGoldPouch(player, item)
            if moved then
                itemsCollected = itemsCollected + 1
                slotsUsedThisSession = slotsUsedThisSession + slotsNeeded
                local currentUsed = usedSlots + slotsUsedThisSession

                local stackInfo = ""
                if canStack and slotsNeeded == 0 then stackInfo = " (stacked)"
                elseif ItemType(iid):isStackable() then stackInfo = string.format(" (%d slots)", slotsNeeded) end

                sendLootMessage(player, string.format("Collected %dx %s%s (%s: %d/%d slots)", item:getCount(), item:getName(), stackInfo, accountType, currentUsed, maxSlots), "collected")
            else
                sendLootMessage(player, string.format("Could not collect %s: No space in Gold Pouch.", item:getName()), "error")
            end
        end
    end

    if itemsCollected > 0 then
        local finalUsed = usedSlots + slotsUsedThisSession
        sendLootMessage(player, string.format("Auto-loot session complete: %d items collected, %d slots used. %s: %d/%d slots.", itemsCollected, slotsUsedThisSession, accountType, finalUsed, maxSlots), "info")
        player:openChannel(9)
    end

    return true
end

-- =========================
-- Evento onKill
-- =========================
local system_autoloot_onKill = CreatureEvent("AutoLoot")
function system_autoloot_onKill.onKill(creature, target)
    if not target:isMonster() then return true end
    addEvent(AutoLootList.getLootItem, 100, AutoLootList, creature:getId(), target:getPosition())
    return true
end
system_autoloot_onKill:register()

-- =========================
-- Funcoes add/remove rapidas
-- =========================
local function addQuickItem(playerGuid, itemId, itemName)
    local player = Player(playerGuid)
    if not player then player = Player(getPlayerByGuid and getPlayerByGuid(playerGuid) or 0) end

    local it = ItemType(itemId)
    if not it or it:getId() == 0 then return false end
    if isInArray(config.blockedIds, itemId) then
        if player then sendLootMessage(player, string.format("The item %s is blocked and cannot be added to your loot list.", itemName), "error") end
        return false
    end
    if AutoLootList:itemInList(playerGuid, itemId) then
        if player then sendLootMessage(player, string.format("The item %s is already in your loot list.", itemName), "warning") end
        return false
    end

    local usedSlots, maxSlots = 0, 0
    local accountType = "Free"
    local pObj = nil
    for _, p in pairs(Game.getPlayers()) do
        if p:getGuid() == playerGuid then pObj = p break end
    end
    if pObj then
        usedSlots = getGoldPouchUsedSlots(pObj)
        maxSlots = getGoldPouchMaxSlots(pObj)
        accountType = (pObj:getVipDays() > os.time()) and "VIP" or "Free"
    end

    if maxSlots == 0 then
        if pObj then sendLootMessage(pObj, "You need a Gold Pouch to use auto-loot.", "error") end
        return false
    end

    local maxItems = (pObj and (pObj:getVipDays() > os.time())) and config.vipMaxItems or config.freeMaxItems
    if AutoLootList:countList(playerGuid) >= maxItems then
        if pObj then sendLootMessage(pObj, string.format("Your auto-loot list is full. You have reached the limit of %d items.", maxItems), "error") end
        return false
    end

    local ok = AutoLootList:addItem(playerGuid, itemId)
    if ok and pObj then
        local count = AutoLootList:countList(playerGuid)
        sendLootMessage(pObj, string.format("The item %s has been added to your loot list. %s account: %d types configured, Gold Pouch: %d/%d slots.", itemName, accountType, count, usedSlots, maxSlots), "success")
    end
    return ok
end

local function removeQuickItem(playerGuid, itemId, itemName)
    local pObj = nil
    for _, p in pairs(Game.getPlayers()) do if p:getGuid() == playerGuid then pObj = p break end end
    if not AutoLootList:itemInList(playerGuid, itemId) then
        if pObj then sendLootMessage(pObj, string.format("The item %s is not in your loot list.", itemName), "info") end
        return false
    end
    local ok = AutoLootList:removeItem(playerGuid, itemId)
    if ok and pObj then sendLootMessage(pObj, string.format("The item %s has been removed from your loot list.", itemName), "success") end
    return ok
end

local function validateItem(itemInput)
    local it = ItemType(itemInput); local id = it:getId()
    if id == 0 then it = ItemType(tonumber(itemInput)); id = it:getId() end
    if id == 0 then return nil, nil end
    local name = tonumber(itemInput) and it:getName() or itemInput
    return id, name
end

-- =========================
-- Modal por monstro (v3)
-- =========================
local function showMonsterLootModal(playerGuid, monsterName)
    local pObj = nil
    for _, p in pairs(Game.getPlayers()) do if p:getGuid() == playerGuid then pObj = p break end end
    if not pObj then return false end

    local mType = MonsterType(monsterName)
    if not mType then sendLootMessage(pObj, "This monster does not exist or is not on the map."); return false end
    if mType:isRewardBoss() then sendLootMessage(pObj, config.rewardBossMessage); return false end

    local formatted = monsterName:lower()
    local window = ModalWindow{ title = string.format("Loot of the Monster %s", formatted), message = "Add or remove items from this monster to your auto-loot list." }

    local windowCount, unique = 0, {}
    local mLoot = mType:getLoot()
    if mLoot then
        if #mLoot == 0 then sendLootMessage(pObj, "This monster has no available loot."); return false end
        for _, v in pairs(mLoot) do
            if windowCount < 255 then
                local itemId = v.itemId
                if not unique[itemId] and not isInArray(config.blockedIds, itemId) then
                    local it = ItemType(itemId)
                    if it then
                        local name = it:getName()
                        local status = AutoLootList:itemInList(playerGuid, itemId) and " - Added!" or ""
                        local choice = window:addChoice(name .. status)
                        windowCount = windowCount + 1
                        choice.itemId = itemId; choice.itemName = name
                        unique[itemId] = true
                    end
                end
            end
        end
    end
    if windowCount >= 255 then sendLootMessage(pObj, "Warning: Some items may not be displayed due to modal window limitations.") end

    window:addButton("Remove", function(_, choice)
        if pObj and choice then removeQuickItem(playerGuid, choice.itemId, choice.itemName); showMonsterLootModal(playerGuid, formatted) end
    end)
    window:addButton("Add", function(_, choice)
        if pObj and choice then addQuickItem(playerGuid, choice.itemId, choice.itemName); showMonsterLootModal(playerGuid, formatted) end
    end)
    window:setDefaultEnterButton("Add")
    window:addButton("Close")
    window:setDefaultEscapeButton("Close")
    window:sendToPlayer(pObj)
end

local function openLootListModal(playerGuid)
    local pObj = nil
    for _, p in pairs(Game.getPlayers()) do if p:getGuid() == playerGuid then pObj = p break end end
    if not pObj then return false end

    local window = ModalWindow{ title = "Your Auto-Loot List", message = "This is your auto-loot list!\nWhen these items drop, clicking on the monster's corpse will collect them to your Gold Pouch." }
    for _, loot in pairs(AutoLootList:getItemList(playerGuid)) do
        local it = ItemType(loot.item_id)
        if it then
            local name = it:getName()
            local choice = window:addChoice(name .. " (Inventory)")
            choice.itemId = it:getId(); choice.itemName = name
        end
    end
    window:addButton("Remove", function(_, choice)
        if pObj and choice then removeQuickItem(playerGuid, choice.itemId, choice.itemName); openLootListModal(playerGuid) end
    end)
    window:addButton("Close")
    window:setDefaultEscapeButton("Close")
    window:sendToPlayer(pObj)
end

-- =========================
-- Extended Opcode (v3, usando MonsterType)
-- =========================
local function handleQuickLoot(player, opcode, buffer)
    if opcode ~= OPCODE_QUICKLOOT then return true end
    if not json then return false end
    local data = json.decode(buffer); if not data or type(data) ~= "table" then return false end

    local action = data.action
    local playerGuid = player:getGuid()

    if action == "add" or action == "remove" or action == "clearMyLoot" then
        if player:getStorageValue(AUTO_LOOT_COOLDOWN_STORAGE) > os.time() then
            local msg = string.format("You are on cooldown. Please wait %d seconds to use the command again.", config.exhaustTime)
            player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode({ action="error", message=msg }))
            return false
        end
        player:setStorageValue(AUTO_LOOT_COOLDOWN_STORAGE, os.time() + config.exhaustTime)
    end

    if action == "init" then
        player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode({
            action = "open",
            limits = {
                current = AutoLootList:countList(playerGuid),
                max = (player:getVipDays() > os.time()) and config.vipMaxItems or config.freeMaxItems,
                goldPouchSlots = { used = getGoldPouchUsedSlots(player), max = getGoldPouchMaxSlots(player) }
            }
        }))
    elseif action == "getLootList" then
        local out = {}
        for _, e in ipairs(AutoLootList:getItemList(playerGuid)) do
            local it = ItemType(e.item_id)
            if it then table.insert(out, { item_id = e.item_id, name = it:getName() }) end
        end
        player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode({ action="getLootList", loot=out }))

    elseif action == "search" then
        local q = tostring(data.search or ""):lower()
        local monsters = {}
        local all = Game.getMonsterTypes()
        if all then
            local count = 0
            for name,_ in pairs(all) do
                if count >= 50 then break end
                if type(name)=="string" and name:lower():find(q,1,true) then
                    table.insert(monsters, name); count = count + 1
                end
            end
        end
        player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode({ action="searchResults", monsters=monsters }))

    elseif action == "getLoot" then
        local mname = data.monster
        local mType = MonsterType(mname)
        if not mType then
            player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode({ action="error", message="Monster not found." }))
            return false
        end

        local lootItems, seen = {}, {}
        local mLoot = mType:getLoot()
        if mLoot then
            for _, L in ipairs(mLoot) do
                local id = L.itemId
                if not seen[id] and not isInArray(config.blockedIds, id) then
                    local it = ItemType(id)
                    if it then
                        table.insert(lootItems, { id=id, name=it:getName(), added=AutoLootList:itemInList(playerGuid, id) })
                        seen[id] = true
                    end
                end
            end
        end

        player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode({
            action="showLoot",
            monster=mname,
            loot=lootItems,
            outfit=mType:getOutfit(),
            limits={ current=AutoLootList:countList(playerGuid), max=(player:getVipDays()>os.time()) and config.vipMaxItems or config.freeMaxItems }
        }))

    elseif action == "add" then
        local id = tonumber(data.itemId)
        local name = (id and ItemType(id) and ItemType(id):getName()) or ("ID "..tostring(data.itemId))
        local ok = id and addQuickItem(playerGuid, id, name)
        player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode({
            action = ok and "added" or "error",
            message = ok and ("Added "..name.." to auto-loot list.") or ("Failed to add "..name.."."),
            limits = { current=AutoLootList:countList(playerGuid), max=(player:getVipDays()>os.time()) and config.vipMaxItems or config.freeMaxItems }
        }))

    elseif action == "remove" then
        local id = tonumber(data.itemId)
        local name = (id and ItemType(id) and ItemType(id):getName()) or ("ID "..tostring(data.itemId))
        local ok = id and removeQuickItem(playerGuid, id, name)
        player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode({
            action = ok and "removed" or "error",
            message = ok and ("Removed "..name.." from auto-loot list.") or ("Failed to remove "..name.."."),
            limits = { current=AutoLootList:countList(playerGuid), max=(player:getVipDays()>os.time()) and config.vipMaxItems or config.freeMaxItems }
        }))

    elseif action == "showMyLoot" then
        local lootList = {}
        local rid = db.storeQuery("SELECT `item_id` FROM `auto_loot_list` WHERE `player_id` = " .. playerGuid)
        if rid then
            local tbl = queryToTable(rid, {'item_id:number'})
            for _, it in ipairs(tbl) do
                local t = ItemType(it.item_id)
                if t then table.insert(lootList, { id=it.item_id, name=t:getName() }) end
            end
            result.free(rid)
        end
        player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode({ action="showMyLoot", loot=lootList }))

    elseif action == "clearMyLoot" then
        AutoLootList:clear(playerGuid)
        player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode({
            action="cleared",
            message="Sua lista de loot foi limpa com sucesso.",
            limits={ current=AutoLootList:countList(playerGuid), max=(player:getVipDays()>os.time()) and config.vipMaxItems or config.freeMaxItems }
        }))
    end

    return true
end

local extendedOpcodeEvent = CreatureEvent("AutoLootExtendedOpcode")
function extendedOpcodeEvent.onExtendedOpcode(player, opcode, buffer)
    return handleQuickLoot(player, opcode, buffer)
end
extendedOpcodeEvent:type("extendedopcode")
extendedOpcodeEvent:register()

-- =========================
-- TalkAction (v1/v3)
-- =========================
local system_autoloot_talk = TalkAction("!autoloot", "/autoloot")
function system_autoloot_talk.onSay(player, words, param, type)
    if type ~= TALKTYPE_SAY and type ~= TALKTYPE_WHISPER and type ~= TALKTYPE_YELL then return false end

    if player:getStorageValue(AUTO_LOOT_COOLDOWN_STORAGE) > os.time() then
        player:sendCancelMessage(string.format("You are on cooldown. Please wait %d seconds to use the command again.", config.exhaustTime))
        return false
    end
    player:setStorageValue(AUTO_LOOT_COOLDOWN_STORAGE, os.time() + config.exhaustTime)

    local split = param:split(",")
    local action = split[1] and trim(split[1]) or ""
    local pg = player:getGuid()

    if action == "add" then
        if not split[2] then sendLootMessage(player, "Usage: !autoloot add, itemName"); return false end
        local id, name = validateItem(trim(split[2])); if not id then sendLootMessage(player, "No item exists with that name."); return false end
        addQuickItem(pg, id, name)

    elseif action == "remove" then
        if not split[2] then sendLootMessage(player, "Usage: !autoloot remove, itemName"); return false end
        local id, name = validateItem(trim(split[2])); if not id then sendLootMessage(player, "No item exists with that name."); return false end
        if not AutoLootList:itemInList(pg, id) then sendLootMessage(player, string.format("The item %s is not in your loot list.", name)); return false end
        removeQuickItem(pg, id, name)

    elseif action == "list" or action == "show" then
        local count = AutoLootList:countList(pg); if count == 0 then sendLootMessage(player, "Your loot list is empty."); return false end
        local accountType = (player:getVipDays()>os.time()) and "VIP" or "Free"
        local maxItems = (player:getVipDays()>os.time()) and config.vipMaxItems or config.freeMaxItems
        sendLootMessage(player, string.format("=== AUTO LOOT LIST (%s: %d/%d) ===", accountType, count, maxItems))
        for i, it in ipairs(AutoLootList:getItemList(pg)) do
            local t = ItemType(it.item_id); if t then sendLootMessage(player, string.format("%d. %s (ID: %d)", i, t:getName(), it.item_id)) end
        end
        openLootListModal(pg)

    elseif action == "clear" then
        local count = AutoLootList:countList(pg); if count == 0 then sendLootMessage(player, "Your loot list is already empty."); return false end
        AutoLootList:clear(pg); sendLootMessage(player, string.format("Your auto-loot list has been cleared. %d items removed.", count), "success")

    elseif action == "help" then
        local used, max = getGoldPouchUsedSlots(player), getGoldPouchMaxSlots(player)
        local acc = (player:getVipDays()>os.time()) and "VIP" or "Free"
        local itemCount = AutoLootList:countList(pg)
        local status = (max==0)
            and string.format("- Account type: %s\n- Gold Pouch: Not found\n- Configured items: %d types\n- VIP AutoLoot: %d itens\n- Free AutoLoot: %d itens", acc, itemCount, config.vipMaxItems, config.freeMaxItems)
            or string.format("- Account type: %s\n- Gold Pouch slots: %d/%d used\n- Configured items: %d types\n- VIP AutoLoot: %d itens\n- Free AutoLoot: %d itens", acc, used, max, itemCount, config.vipMaxItems, config.freeMaxItems)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "=== AUTO LOOT SYSTEM HELP ===\n\nCurrent Status:\n"..status..
            "\n\nCommands:\n!autoloot add, item name\n!autoloot remove, item name\n!autoloot list\n!autoloot clear\n!autoloot <monster name>\n\nItems are moved to your Gold Pouch.\nCoins are always collected and stacked.")

    elseif action ~= "" then
        showMonsterLootModal(pg, action) -- abrir janela do monstro

    else
        sendLootMessage(player, "Use !autoloot help for commands.")
        return false
    end

    return false
end
system_autoloot_talk:separator(" ")
system_autoloot_talk:register()

-- =========================
-- Login + onMoveItem (restricoes)
-- =========================
local autoLootLogin = CreatureEvent("AutoLootLogin")
function autoLootLogin.onLogin(player)
    player:registerEvent("AutoLootExtendedOpcode")
    player:registerEvent("AutoLoot")
    local pg = player:getGuid()
    if not AutoLootList.players[pg] then AutoLootList:init(pg) end
    return true
end
autoLootLogin:type("login")
autoLootLogin:register()

local moveItemEvent = Event()
moveItemEvent.onMoveItem = function(player, item, count, fromPos, toPos, fromCyl, toCyl)
    if not player or not item or not toCyl then return true end
    if not toCyl.getId or not player.getId or not item.getId then return true end
    if toCyl:getId() == config.GOLD_POUCH then
        -- permite mover moedas ou itens que ja estao na lista do jogador
        if coinSet[item:getId()] or (AutoLootList and AutoLootList:itemInList(player:getGuid(), item:getId())) then
            return true
        end
        player:sendCancelMessage("You can only move coins or auto-loot items to this container.")
        return false
    end
    return true
end
moveItemEvent:register()
