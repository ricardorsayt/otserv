local json = require("cjson") -- Adicione esta linha no topo do arquivo

AutoLootList = {
	players = {}
}

function AutoLootList:init(playerGuid)
	self.players[playerGuid] = { lootList = {} }
	local resultId = db.storeQuery("SELECT `item_id` FROM `auto_loot_list` WHERE `player_id` = " .. playerGuid)
	if resultId then
		self.players[playerGuid].lootList = queryToTable(resultId, {'item_id:number'})
		result.free(resultId)
	end
end

function AutoLootList:addItem(playerGuid, itemId)
	if not self.players[playerGuid] then
		self:init(playerGuid)
	end

	if self:itemInList(playerGuid, itemId) then
		return false
	end
	
	local result = db.query("INSERT INTO `auto_loot_list` (`player_id`, `item_id`) VALUES (" .. playerGuid .. ", " .. itemId .. ")")
	if result then
		table.insert(self.players[playerGuid].lootList, { item_id = itemId })
		return true
	end
	
	return false
end

function AutoLootList:removeItem(playerGuid, itemId)
	if not self.players[playerGuid] then
		self:init(playerGuid)
	end
	
	local result = db.query("DELETE FROM `auto_loot_list` WHERE `player_id` = " .. playerGuid .. " AND `item_id` = " .. itemId)
	if result then
		for i, lootItem in ipairs(self.players[playerGuid].lootList) do
			if lootItem.item_id == itemId then
				table.remove(self.players[playerGuid].lootList, i)
				break
			end
		end
		return true
	end

	return false
end

function AutoLootList:clear(playerGuid)
	if not self.players[playerGuid] then
		return false
	end
	
	local result = db.query("DELETE FROM `auto_loot_list` WHERE `player_id` = " .. playerGuid)
	if result then
		self.players[playerGuid].lootList = {}
		return true
	end
	
	return false
end

function AutoLootList:itemInList(playerGuid, itemId)
	if not self.players[playerGuid] then
		return false
	end
	
	for _, lootItem in ipairs(self.players[playerGuid].lootList) do
		if lootItem.item_id == itemId then
			return true
		end
	end
	return false
end

function AutoLootList:countList(playerGuid)
	if not self.players[playerGuid] then
		return 0
	end
	
	return #self.players[playerGuid].lootList
end

function AutoLootList:getItemList(playerGuid)
	if not self.players[playerGuid] then
		return {}
	end
	
	return self.players[playerGuid].lootList
end

local autoLootStartup = GlobalEvent("AutoLootStartup")
function autoLootStartup.onStartup()
	lootBlockListm = {}
	lootBlockListn = {}
	lastItem = {}
	autolootBP = 1
	Game.sendConsoleMessage("> Loading autoloot data from database...", CONSOLEMESSAGE_TYPE_STARTUP)
	
	local resultId = db.storeQuery('SELECT DISTINCT `player_id` FROM `auto_loot_list`')
	if resultId then
		local playersLoaded = 0
		repeat
			local playerGuid = result.getNumber(resultId, "player_id")
			if playerGuid then
				AutoLootList:init(playerGuid)
				playersLoaded = playersLoaded + 1
			end
		until not result.next(resultId)
		result.free(resultId)
		
		Game.sendConsoleMessage(string.format("> Loaded autoloot data for %d players", playersLoaded), CONSOLEMESSAGE_TYPE_STARTUP)
	else
		Game.sendConsoleMessage("> No autoloot data found in database", CONSOLEMESSAGE_TYPE_STARTUP)
	end
	
	return true
end
autoLootStartup:register()

local config = {
	vipMaxItems = configManager.getNumber(configKeys.VIP_AUTOLOOT_LIMIT),
	freeMaxItems = configManager.getNumber(configKeys.FREE_AUTOLOOT_LIMIT),
	exhaustTime = 2,
	rewardBossMessage = "You cannot view the loot of Reward Chest bosses.",
	GOLD_POUCH = 26377,
	blockedIds = {2393}
}

local function sendLootMessage(player, message, messageType)
	local color = MESSAGE_STATUS_CONSOLE_BLUE
	
	if messageType == "success" then
		color = MESSAGE_STATUS_CONSOLE_GREEN
	elseif messageType == "error" then
		color = MESSAGE_STATUS_CONSOLE_RED
	elseif messageType == "warning" then
		color = MESSAGE_STATUS_CONSOLE_ORANGE
	elseif messageType == "collected" then
		color = MESSAGE_STATUS_CONSOLE_BLUE
	elseif messageType == "info" then
		color = MESSAGE_STATUS_CONSOLE_BLUE
	end
	
	player:sendTextMessage(color, message)
	
	if messageType == "collected" or messageType == "info" or messageType == "warning" then
		player:sendChannelMessage("", message, TALKTYPE_CHANNEL_O, 9)
	end
end

local CONST_SLOT_BACKPACK = 3
local CONST_SLOT_FIRST = 1
local CONST_SLOT_LAST = 10

local AUTO_LOOT_COOLDOWN_STORAGE = 10001
local OPCODE_QUICKLOOT = 50

function trim(s)
	return s:match("^%s*(.-)%s*$")
end

function isInArray(array, value)
	for _, v in ipairs(array) do
		if v == value then
			return true
		end
	end
	return false
end

local system_autoloot_onKill = CreatureEvent("AutoLoot")
function system_autoloot_onKill.onKill(creature, target)
	if not target:isMonster() then
		return true
	end

	addEvent(AutoLootList.getLootItem, 100, AutoLootList, creature:getId(), target:getPosition())
	return true
end
system_autoloot_onKill:register()

local function addQuickItem(playerGuid, itemId, itemName)
	local player = Player(playerGuid)
	if not player then
		return false
	end

	local itemType = ItemType(itemId)
	if not itemType or itemType:getId() == 0 then
		return false
	end

	if isInArray(config.blockedIds, itemId) then
		sendLootMessage(player, string.format("The item %s is blocked and cannot be added to your loot list.", itemName), "error")
		return false
	end

	if AutoLootList:itemInList(playerGuid, itemId) then
		sendLootMessage(player, string.format("The item %s is already in your loot list.", itemName), "warning")
		return false
	end

	local usedSlots = getGoldPouchUsedSlots(player)
	local maxSlots = getGoldPouchMaxSlots(player)
	local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"
	local maxItems = (player:getVipDays() > os.time()) and config.vipMaxItems or config.freeMaxItems

	if AutoLootList:countList(playerGuid) >= maxItems then
		sendLootMessage(player, string.format("Your auto-loot list is full. You have reached the limit of %d items.", maxItems), "error")
		return false
	end

	if maxSlots == 0 then
		sendLootMessage(player, "You need a Gold Pouch to use auto-loot.", "error")
		return false
	end
	local itemAdded = AutoLootList:addItem(playerGuid, itemId)
	if itemAdded then
		local itemCount = AutoLootList:countList(playerGuid)
		sendLootMessage(player, string.format("The item %s has been added to your loot list. %s account: %d types configured, Gold Pouch: %d/%d slots.", itemName, accountType, itemCount, usedSlots, maxSlots), "info")
		return true
	else
		sendLootMessage(player, string.format("Failed to add %s to your loot list.", itemName), "error")
		return false
	end
end

local function removeQuickItem(playerGuid, itemId, itemName)
	local player = Player(playerGuid)
	if not player then
		return false
	end

	if not AutoLootList:itemInList(playerGuid, itemId) then
		sendLootMessage(player, string.format("The item %s is not in your loot list.", itemName), "info")
		return false
	end

	local itemRemoved = AutoLootList:removeItem(playerGuid, itemId)
	if itemRemoved then
		sendLootMessage(player, string.format("The item %s has been removed from your loot list.", itemName), "info")
	end

	return true
end

local function validateItem(itemInput)
	local itemType = ItemType(itemInput)
	local itemId = itemType:getId()
	if itemId == 0 then
		itemType = ItemType(tonumber(itemInput))
		itemId = itemType:getId()
	end

	if itemId == 0 then
		return nil, nil
	end

	local itemName = tonumber(itemInput) and itemType:getName() or itemInput
	return itemId, itemName
end

local function showMonsterLootModal(playerGuid, monsterName)
	local player = Player(playerGuid)
	if not player then
		return false
	end

	local monsterType = MonsterType(monsterName)
	if not monsterType then
		sendLootMessage(player, "This monster does not exist or is not on the map.")
		return false
	end

	if monsterType:isRewardBoss() then
		sendLootMessage(player, config.rewardBossMessage)
		return false
	end

	local formattedMonsterName = monsterName:lower()
	local window = ModalWindow {
		title = string.format("Loot of the Monster %s", formattedMonsterName),
		message = "Add or remove items from this monster to your auto-loot list.",
	}

	local windowCount = 0
	local uniqueItems = {}
	local monsterLoot = monsterType:getLoot()
	if monsterLoot then
		if #monsterLoot == 0 then
			sendLootMessage(player, "This monster has no available loot.")
			return false
		end
		
		for _, v in pairs(monsterLoot) do
			if windowCount < 255 then
				local itemId = v.itemId
				if not isInArray(uniqueItems, itemId) and not isInArray(config.blockedIds, itemId) then
					local itemType = ItemType(itemId)
					if itemType then
						local itemName = itemType:getName()

						local itemStatus = AutoLootList:itemInList(playerGuid, itemId) and ' - Added!' or ''
						local choice = window:addChoice(itemName .. itemStatus)
						windowCount = windowCount + 1

						choice.itemId = itemId
						choice.itemName = itemName
						table.insert(uniqueItems, itemId)
					end
				end
			end
		end
	end

	if windowCount >= 255 then
		sendLootMessage(player, "Warning: Some items may not be displayed due to modal window limitations.")
	end
	window:addButton("Remove",
		function(button, choice)
			if player and choice then
				removeQuickItem(player:getGuid(), choice.itemId, choice.itemName)
				showMonsterLootModal(playerGuid, formattedMonsterName)
			end
		end
	)

	window:addButton("Add",
		function(button, choice)
			if player and choice then
				addQuickItem(player:getGuid(), choice.itemId, choice.itemName)
				showMonsterLootModal(playerGuid, formattedMonsterName)
			end
		end
	)
	window:setDefaultEnterButton("Add")

	window:addButton("Close")
	window:setDefaultEscapeButton("Close")
	window:sendToPlayer(player)
end

local function openLootListModal(playerGuid)
	local player = Player(playerGuid)
	if not player then
		return false
	end

	local window = ModalWindow {
		title = "Your Auto-Loot List",
		message = "This is your auto-loot list!\nWhen these items drop, clicking on the monster's corpse will collect them to your Gold Pouch.",
	}

	local lootList = AutoLootList:getItemList(playerGuid)
	for _, loot in pairs(lootList) do
		local itemType = ItemType(loot.item_id)
		if itemType then
			local itemName = itemType:getName()
			local choice = window:addChoice(itemName .. " (Inventory)")

			choice.itemId = itemType:getId()
			choice.itemName = itemName
		end
	end

	window:addButton("Remove",
		function(button, choice)
			if player and choice then
				removeQuickItem(playerGuid, choice.itemId, choice.itemName)
				openLootListModal(playerGuid)
			end
		end
	)

	window:addButton("Close")
	window:setDefaultEscapeButton("Close")
	window:sendToPlayer(player)
end

function getGoldPouchUsedSlots(player)
	local goldPouch = player:getItemById(config.GOLD_POUCH, true)
	if not goldPouch then
		return 0
	end
	
	local usedSlots = 0
	for i = 0, goldPouch:getCapacity() - 1 do
		local item = goldPouch:getItem(i)
		if item then
			usedSlots = usedSlots + 1
		end
	end
	
	return usedSlots
end

function getGoldPouchMaxSlots(player)
	local goldPouch = player:getItemById(config.GOLD_POUCH, true)
	if not goldPouch then
		return 0
	end
	
	return goldPouch:getCapacity()
end

function canStackInGoldPouch(player, itemId, count)
	local goldPouch = player:getItemById(config.GOLD_POUCH, true)
	if not goldPouch then
		return false, 1
	end
	
	local itemType = ItemType(itemId)
	if not itemType:isStackable() then
		return false, count
	end
	
	local maxStack = 100
	
	for i = 0, goldPouch:getCapacity() - 1 do
		local item = goldPouch:getItem(i)
		if item and item:getId() == itemId then
			local currentCount = item:getCount()
			
			if currentCount + count <= maxStack then
				return true, 0
			else
				local remainingCount = count - (maxStack - currentCount)
				local newSlots = math.ceil(remainingCount / maxStack)
				return false, newSlots
			end
		end
	end
	
	local slotsNeeded = math.ceil(count / maxStack)
	return false, slotsNeeded
end

local function moveToGoldPouch(player, item)
	if not player or not item then
		return false
	end

	local goldPouch = player:getItemById(config.GOLD_POUCH, true)
	if not goldPouch then
		sendLootMessage(player, "You need a Gold Pouch to use auto-loot.")
		return false
	end

	return item:moveTo(goldPouch)
end

function AutoLootList.getLootItem(self, playerGuid, position)
	local player = Player(playerGuid)
	if not player then
		return false
	end

	local itemCount = self:countList(playerGuid)
	if itemCount == 0 then
		return false
	end

	local tile = Tile(position)
	if not tile then
		return false
	end

	local corpse = tile:getTopDownItem()
	if not corpse or not corpse:isContainer() then
		return false
	end

	local usedSlots = getGoldPouchUsedSlots(player)
	local maxSlots = getGoldPouchMaxSlots(player)
	local availableSlots = maxSlots - usedSlots
	local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"

	if maxSlots == 0 then
		sendLootMessage(player, "You need a Gold Pouch to use auto-loot.", "error")
		return false
	end

	if availableSlots <= 0 then
		sendLootMessage(player, string.format("Auto-loot disabled: Gold Pouch is full. %s: %d/%d slots used.", accountType, usedSlots, maxSlots), "warning")
		return false
	end

	local items = {}
	for i = 0, corpse:getSize() - 1 do
		local item = corpse:getItem(i)
		if item then
			table.insert(items, item)
		end
	end

	local itemsCollected = 0
	local slotsUsedThisSession = 0
	
	for _, item in ipairs(items) do
		if self:itemInList(playerGuid, item:getId()) then
			local canStack, slotsNeeded = canStackInGoldPouch(player, item:getId(), item:getCount())
			
			if slotsUsedThisSession + slotsNeeded > availableSlots then
				local currentUsed = usedSlots + slotsUsedThisSession
				sendLootMessage(player, string.format("Collection stopped: Not enough space in Gold Pouch. %s: %d/%d slots used.", accountType, currentUsed, maxSlots), "warning")
				break
			end

			local itemWeight = ItemType(item:getId()):getWeight() * item:getCount()
			if player:getFreeCapacity() < itemWeight then
				sendLootMessage(player, string.format("Not enough capacity to collect %s (need %d oz).", item:getName(), itemWeight), "warning")
				break
			end

			local itemMoved = moveToGoldPouch(player, item)
			
			if itemMoved then
				itemsCollected = itemsCollected + 1
				slotsUsedThisSession = slotsUsedThisSession + slotsNeeded
				local currentUsed = usedSlots + slotsUsedThisSession
				
				local stackInfo = ""
				if canStack and slotsNeeded == 0 then
					stackInfo = " (stacked)"
				elseif ItemType(item:getId()):isStackable() then
					stackInfo = string.format(" (%d slots)", slotsNeeded)
				end
				
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

local function handleQuickLoot(player, opcode, buffer)
	local data = json.decode(buffer)
	if not data then
		return false
	end

	local action = data.action
	local playerGuid = player:getGuid()

	if action == "add" or action == "remove" or action == "clearMyLoot" then
		if player:getStorageValue(AUTO_LOOT_COOLDOWN_STORAGE) > os.time() then
			local cooldownMsg = string.format("You are on cooldown. Please wait %d seconds to use the command again.", config.exhaustTime)
			local responseData = {
				action = "error",
				message = cooldownMsg
			}
			player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode(responseData))
			return false
		end
		player:setStorageValue(AUTO_LOOT_COOLDOWN_STORAGE, os.time() + config.exhaustTime)
	end

	if action == "init" then
		local usedSlots = getGoldPouchUsedSlots(player)
		local maxSlots = getGoldPouchMaxSlots(player)
		
		local responseData = {
			action = "open",
			limits = {
				current = AutoLootList:countList(playerGuid),
				max = (player:getVipDays() > os.time()) and config.vipMaxItems or config.freeMaxItems,
				goldPouchSlots = {
					used = usedSlots,
					max = maxSlots
				}
			}
		}
		player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode(responseData))
	elseif action == "getLootList" then
		local lootList = AutoLootList:getItemList(playerGuid)
		local formattedLootList = {}
		for _, lootEntry in ipairs(lootList) do
			local itemId = lootEntry.item_id
			local itemType = ItemType(itemId)
			if itemType then
				table.insert(formattedLootList, {
					item_id = itemId,
					name = itemType:getName()
				})
			end
		end
		local responseData = {
			action = "getLootList",
			loot = formattedLootList
		}
		player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode(responseData))
	elseif action == "search" then
		local search = data.search:lower()
		local monsters = {}
		local allMonsters = Game.getMonsterTypes()
		if allMonsters then
			local count = 0
			for monsterName, _ in pairs(allMonsters) do
				if count >= 50 then
					break
				end
				if type(monsterName) == "string" and monsterName:lower():find(search, 1, true) then
					table.insert(monsters, monsterName)
					count = count + 1
				end
			end
		end
		local responseData = {
			action = "searchResults",
			monsters = monsters
		}
		player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode(responseData))
	elseif action == "getLoot" then
		local monsterName = data.monster
		local monsterType = MonsterType(monsterName)
		if not monsterType then
			local responseData = {
				action = "error",
				message = "Monster not found."
			}
			player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode(responseData))
			return false
		end

		local monsterLoot = monsterType:getLoot()
		local outfit = monsterType:getOutfit()
		
		local lootItems = {}
		local uniqueIds = {}
		if monsterLoot then
			for _, lootEntry in ipairs(monsterLoot) do
				local itemId = lootEntry.itemId
				if not uniqueIds[itemId] and not isInArray(config.blockedIds, itemId) then
					local itemType = ItemType(itemId)
					if itemType then
						table.insert(lootItems, {
							id = itemId,
							name = itemType:getName(),
							added = AutoLootList:itemInList(playerGuid, itemId)
						})
						uniqueIds[itemId] = true
					end
				end
			end
		end

		local responseData = {
			action = "showLoot",
			monster = monsterName,
			loot = lootItems,
			outfit = outfit,
			limits = {
				current = AutoLootList:countList(playerGuid),
				max = (player:getVipDays() > os.time()) and config.vipMaxItems or config.freeMaxItems
			}
		}
		player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode(responseData))
	elseif action == "add" then
		local itemId = data.itemId
		local itemName = ItemType(itemId):getName()
		local success = addQuickItem(playerGuid, itemId, itemName)
		local responseData = {
			action = success and "added" or "error",
			message = success and string.format("Added %s to auto-loot list.", itemName) or string.format("Failed to add %s to auto-loot list.", itemName),
			limits = {
				current = AutoLootList:countList(playerGuid),
				max = (player:getVipDays() > os.time()) and config.vipMaxItems or config.freeMaxItems
			}
		}
		player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode(responseData))
	elseif action == "remove" then
		local itemId = data.itemId
		local itemName = ItemType(itemId):getName()
		local success = removeQuickItem(playerGuid, itemId, itemName)
		local responseData = {
			action = success and "removed" or "error",
			message = success and string.format("Removed %s from auto-loot list.", itemName) or string.format("Failed to remove %s from auto-loot list.", itemName),
			limits = {
				current = AutoLootList:countList(playerGuid),
				max = (player:getVipDays() > os.time()) and config.vipMaxItems or config.freeMaxItems
			}
		}
		player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode(responseData))
	elseif action == "showMyLoot" then
		local lootList = {}
		local resultId = db.storeQuery("SELECT `item_id` FROM `auto_loot_list` WHERE `player_id` = " .. player:getGuid())
		if resultId then
			local itemTable = queryToTable(resultId, {'item_id:number'})
			for _, item in ipairs(itemTable) do
				local itemType = ItemType(item.item_id)
				if itemType then
					table.insert(lootList, {
						id = item.item_id,
						name = itemType:getName()
					})
				end
			end
			result.free(resultId)
		end
		
		local responseData = {
			action = "showMyLoot",
			loot = lootList
		}
		player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode(responseData))
	elseif action == "clearMyLoot" then
		AutoLootList:clear(playerGuid)
		local responseData = {
			action = "cleared",
			message = "Sua lista de loot foi limpa com sucesso.",
			limits = {
				current = AutoLootList:countList(playerGuid),
				max = (player:getVipDays() > os.time()) and config.vipMaxItems or config.freeMaxItems
			}
		}
		player:sendExtendedOpcode(OPCODE_QUICKLOOT, json.encode(responseData))
	end
end

local extendedOpcodeEvent = CreatureEvent("AutoLootExtendedOpcode")
function extendedOpcodeEvent.onExtendedOpcode(player, opcode, buffer)
	if opcode == OPCODE_QUICKLOOT then
		return handleQuickLoot(player, opcode, buffer)
	end
	return true
end

local system_autoloot_talk = TalkAction("!autoloot", "/autoloot")
function system_autoloot_talk.onSay(player, words, param, type)
	if type ~= TALKTYPE_SAY and type ~= TALKTYPE_WHISPER and type ~= TALKTYPE_YELL then
		return false
	end
	
	if player:getStorageValue(AUTO_LOOT_COOLDOWN_STORAGE) > os.time() then
		player:sendCancelMessage(string.format("You are on cooldown. Please wait %d seconds to use the command again.", config.exhaustTime))
		return false
	end

	player:setStorageValue(AUTO_LOOT_COOLDOWN_STORAGE, os.time() + config.exhaustTime)
	
	local split = param:split(",")
	local action = split[1] and trim(split[1]) or ""
	local playerGuid = player:getGuid()

	if action == "add" then
		if not split[2] then
			sendLootMessage(player, "Usage: !autoloot add, itemName")
			return false
		end

		local itemInput = trim(split[2])
		local itemId, itemName = validateItem(itemInput)
		if not itemId then
			sendLootMessage(player, "No item exists with that name.")
			return false
		end

		addQuickItem(playerGuid, itemId, itemName)
	elseif action == "remove" then
		if not split[2] then
			sendLootMessage(player, "Usage: !autoloot remove, itemName")
			return false
		end

		local itemInput = trim(split[2])
		local itemId, itemName = validateItem(itemInput)
		if not itemId then
			sendLootMessage(player, "No item exists with that name.")
			return false
		end

		if not AutoLootList:itemInList(playerGuid, itemId) then
			sendLootMessage(player, string.format("The item %s is not in your loot list.", itemName))
			return false
		end

		removeQuickItem(playerGuid, itemId, itemName)
	elseif action == "list" or action == "show" then
		local count = AutoLootList:countList(playerGuid)
		if count == 0 then
			sendLootMessage(player, "Your loot list is empty.")
			return false
		end

		local itemList = AutoLootList:getItemList(playerGuid)
		local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"
		local maxItems = (player:getVipDays() > os.time()) and config.vipMaxItems or config.freeMaxItems
		
		sendLootMessage(player, string.format("=== AUTO LOOT LIST (%s: %d/%d) ===", accountType, count, maxItems))
		
		if itemList then
			for i, item in ipairs(itemList) do
				local itemType = ItemType(item.item_id)
				if itemType then
					sendLootMessage(player, string.format("%d. %s (ID: %d)", i, itemType:getName(), item.item_id))
				end
			end
		end
		
		sendLootMessage(player, "Use !autoloot remove, item name to remove items")
		openLootListModal(playerGuid)
	elseif action == "clear" then
		local count = AutoLootList:countList(playerGuid)
		if count == 0 then
			sendLootMessage(player, "Your loot list is already empty.")
			return false
		end
		
		AutoLootList:clear(playerGuid)
		sendLootMessage(player, string.format("Your auto-loot list has been cleared. %d items removed.", count), "info")
	elseif action ~= "" then
		local monsterName = action
		showMonsterLootModal(playerGuid, monsterName)
	elseif action == "help" then
		local usedSlots = getGoldPouchUsedSlots(player)
		local maxSlots = getGoldPouchMaxSlots(player)
		local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"
		local itemCount = AutoLootList:countList(playerGuid)
		
		local statusText = ""
		if maxSlots == 0 then
			statusText = string.format("- Account type: %s\n- Gold Pouch: Not found\n- Configured items: %d types\n- VIP Gold Pouch: %d slots\n- Free Gold Pouch: %d slots", accountType, itemCount, config.vipMaxItems, config.freeMaxItems)
		else
			statusText = string.format("- Account type: %s\n- Gold Pouch slots: %d/%d used\n- Configured items: %d types\n- VIP Gold Pouch: %d slots\n- Free Gold Pouch: %d slots", accountType, usedSlots, maxSlots, itemCount, config.vipMaxItems, config.freeMaxItems)
		end
		
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("=== AUTO LOOT SYSTEM HELP ===\n\nCurrent Status:\n%s\n\nCommands:\n!autoloot add, item name - Add item to auto-loot list\n!autoloot remove, item name - Remove item from auto-loot list\n!autoloot list - Show your auto-loot list\n!autoloot clear - Clear your auto-loot list\n!autoloot monster, monster name - Show monster loot\n\nItems will be automatically moved to your Gold Pouch when collected.\nStackable items (like rubies) will stack together, saving space!", statusText))
	else
		if param and param:trim() ~= "" then
			local usedSlots = getGoldPouchUsedSlots(player)
			local maxSlots = getGoldPouchMaxSlots(player)
			local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"
			local itemCount = AutoLootList:countList(playerGuid)
			
			sendLootMessage(player, "=== AUTO LOOT SYSTEM ===")
			
			if maxSlots == 0 then
				sendLootMessage(player, string.format("Status: %s account - Gold Pouch: Not found", accountType))
				sendLootMessage(player, string.format("Configured items: %d types", itemCount))
				sendLootMessage(player, "You need a Gold Pouch to use auto-loot!")
			else
				sendLootMessage(player, string.format("Status: %s account - Gold Pouch slots: %d/%d used", accountType, usedSlots, maxSlots))
				sendLootMessage(player, string.format("Configured items: %d types", itemCount))
			end
			
			sendLootMessage(player, "Commands:")		
			sendLootMessage(player, "!autoloot add, item name - Add item to auto-loot list")
			sendLootMessage(player, "!autoloot remove, item name - Remove item from auto-loot list")
			sendLootMessage(player, "!autoloot list - Show your auto-loot list")
			sendLootMessage(player, "!autoloot clear - Clear your auto-loot list")
			sendLootMessage(player, "Items will be moved to your Gold Pouch.")
			sendLootMessage(player, string.format("Limits: VIP players (%d slots), Free players (%d slots)", config.vipMaxItems, config.freeMaxItems))
		else
			if param == "" or not param then
				sendLootMessage(player, "Use !autoloot help for commands.")
			end
		end
		return false
	end

	return false
end
system_autoloot_talk:separator(" ")
system_autoloot_talk:register()

local autoLootLogin = CreatureEvent("AutoLootLogin")
function autoLootLogin.onLogin(player)
	player:registerEvent("AutoLootExtendedOpcode")
	player:registerEvent("AutoLoot")
	
	local playerGuid = player:getGuid()
	if not AutoLootList.players[playerGuid] then
		AutoLootList:init(playerGuid)
	end
	
	return true
end

local moveItemEvent = Event()
moveItemEvent.onMoveItem = function(player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if not player or not item or not toCylinder then
		return true
	end
	
	if not toCylinder.getId or not player.getId or not item.getId then
		return true
	end
	
	local coinIds = {2148, 2152, 2160}
	
	if toCylinder:getId() == config.GOLD_POUCH then
		if AutoLootList and AutoLootList:itemInList(player:getGuid(), item:getId()) then
			return true
		end
		
		for _, coinId in ipairs(coinIds) do
			if item:getId() == coinId then
				return true
			end
		end
		
		player:sendCancelMessage("You can only move money or auto-loot items to this container.")
		return false
	end
	
	return true
end
moveItemEvent:register()

extendedOpcodeEvent:type("extendedopcode")
extendedOpcodeEvent:register()
autoLootLogin:type("login")
autoLootLogin:register()