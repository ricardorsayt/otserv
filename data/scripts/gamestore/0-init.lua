CS_SHOP_RECEIVE = 202
CS_SHOP_SERVERSIDE = 203

GameStore = {
	developer = "Reddington",
	table = "web_accounts",
	tableName = "shop_coins",
	historyMaxRows = 26,
	storeUrl = "https://shanera-retro.com/?subtopic=getcoins",
	imagesUrl = "https://skydrivestudios.com/store",
	debug = false,
	usingStoreInbox = false,
	coinsId = 5092,
}

GameStore_OfferTypes = {
	OFFER_TYPE_NONE = 0,
	OFFER_TYPE_ITEM = 1,
	OFFER_TYPE_STACKABLE = 2,
	OFFER_TYPE_OUTFIT = 3,
	OFFER_TYPE_NAMECHANGE = 5,
	OFFER_TYPE_SEXCHANGE = 6,
	OFFER_TYPE_TEMPLE = 7,
	OFFER_TYPE_PREMIUM = 8,
	OFFER_TYPE_BLESSINGS = 9,
	OFFER_TYPE_ALLBLESSINGS = 10,
	OFFER_TYPE_MOUNT = 11,
	OFFER_TYPE_XPBOOST = 12,
	OFFER_TYPE_EXTRACHARM = 13,
	OFFER_TYPE_PACKMARKET = 14,
	OFFER_TYPE_UPGRADEEXTRACT = 15,
}

PREMIUM_DEFAULT_DESC = "Enhance your gaming experience by gaining additional abilities and advantages:\n\n* access to Premium areas\n* use Tibia's transport system (ships, carpet)\n* more spells\n* rent houses\n* found guilds\n* offline training\n* larger depots\n* and many more\n\n- valid for all characters on this account\n- activated at purchase"

dofile('data/scripts/gamestore/1-gamestore.lua')

local function addPlayerEvent(callable, delay, playerId, ...)
	local player = Player(playerId)
	if not player then
		return false
	end

	addEvent(function(callable, playerId, ...)
		local player = Player(playerId)
		if player then
			pcall(callable, player, ...)
		end
	end, delay, callable, player.uid, ...)
end

function onShopCallback(player, opcode, buffer)
	local status, json_data = pcall(function() return json.decode(buffer) end)
	if not status then return false end
	local action = json_data['action']
	local data = json_data['data']
	
	if GameStore.debug then
		print("Opcode "..opcode.." sent with value "..buffer)
	end
	
	if action == "getCoins" then
		player:sendShopBalance()
	elseif action == "buyItem" then
		player:storeBuyItem(data)
	elseif action == "getStoreData" then
		player:getShopData()
	elseif action == "getHistoryData" then
		player:getHistoryData()
	elseif action == "transferCoins" then
		player:transferCoins(data)
	elseif action == "withdrawCoins" then
		player:withdrawCoins(data)
	elseif action == "getStoreUrl" then
		player:sendStoreURL()
	elseif action == "getImagesUrl" then
		player:sendImagesURL()
	elseif action == "getGender" then
		player:sendPlayerGender()
	end
end

local MAX_PACKET_SIZE = 5000

local function sendJSON(player, action, data)
	local buffer = json.encode({ action = action, data = data })
	local s = {}
	for i = 1, #buffer, MAX_PACKET_SIZE do
		s[#s + 1] = buffer:sub(i, i + MAX_PACKET_SIZE - 1)
	end
	local msg = NetworkMessage()
	if #s == 1 then
		msg:addByte(50)
		msg:addByte(CS_SHOP_SERVERSIDE)
		msg:addString(s[1])
		msg:sendToPlayer(player)
		return
	end
	-- split message if too big
	msg:addByte(50)
	msg:addByte(CS_SHOP_SERVERSIDE)
	msg:addString("S" .. s[1])
	msg:sendToPlayer(player)
	for i = 2, #s - 1 do
		msg = NetworkMessage()
		msg:addByte(50)
		msg:addByte(CS_SHOP_SERVERSIDE)
		msg:addString("P" .. s[i])
		msg:sendToPlayer(player)
	end
	msg = NetworkMessage()
	msg:addByte(50)
	msg:addByte(CS_SHOP_SERVERSIDE)
	msg:addString("E" .. s[#s])
	msg:sendToPlayer(player)
end

GameStore.getOfferByName = function(name)
	for _, category in pairs(storeIndex) do
		for __, offer in pairs(category.offers) do
			if offer.name == name then
				return offer
			end
		end
	end

	return nil
end

GameStore.canChangeToName = function(name)
	local result = {
		ability = false
	}
	
	if name:len() < 3 or name:len() > 15 then
		result.reason = "The length of your new name must be between 3 and 15 characters."
		return result
	end

	local match = name:gmatch("%s+")
	local count = 0
	for v in match do
		count = count + 1
	end

	local matchtwo = name:match("^%s+")
	if (matchtwo) then
		result.reason = "Your new name can't have whitespace at begin."
		return result
	end

	if (count > 1) then
		result.reason = "Your new name have more than 1 whitespace."
		return result
	end

	-- just copied from znote aac.
	local words = { "owner", "gamemaster", "hoster", "admin", "staff", "tibia", "account", "god", "anal", "ass", "fuck", "sex", "hitler", "pussy", "dick", "rape", "adm", "cm", "gm", "tutor", "counsellor" }
	local split = name:split(" ")
	for k, word in ipairs(words) do
		for k, nameWord in ipairs(split) do
			if nameWord:lower() == word then
				result.reason = "You can't use word \"" .. word .. "\" in your new name."
				return result
			end
		end
	end

	local tmpName = name:gsub("%s+", "")
	for i = 1, #words do
		if (tmpName:lower():find(words[i])) then
			result.reason = "You can't use word \"" .. words[i] .. "\" with whitespace in your new name."
			return result
		end
	end

	if MonsterType(name) then
		result.reason = "Your new name \"" .. name .. "\" can't be a monster's name."
		return result
	elseif Npc(name) then
		result.reason = "Your new name \"" .. name .. "\" can't be a npc's name."
		return result
	end

	local letters = "{}|_*+-=<>0123456789@#%^&()/*'\\.,:;~!\"$"
	for i = 1, letters:len() do
		local c = letters:sub(i, i)
		for i = 1, name:len() do
			local m = name:sub(i, i)
			if m == c then
				result.reason = "You can't use this letter \"" .. c .. "\" in your new name."
				return result
			end
		end
	end
	result.ability = true
	return result
end

function Player.sendPlayerGender(self)
	sendJSON(self, "sendPlayerSex", {sex = self:getSex()})
end

function Player.sendShopBalance(self)
	sendJSON(self, "sendCoins", self:getCoinsBalance())
end

function Player.getShopData(self)
	local storeData = {storeIndex}

	--Get item clientId:
	for _, category in pairs(storeData[1]) do
		for _, offer in pairs(category.offers) do
			if offer.type == GameStore_OfferTypes.OFFER_TYPE_ITEM then
				local item = ItemType(offer.id)
				if item then
					offer.clientId = item:getClientId()
				end
			elseif offer.type == GameStore_OfferTypes.OFFER_TYPE_OUTFIT then
				local looktype = offer.sexId.male
				if self:getSex() == 0 then
					looktype = offer.sexId.female
				end
				offer.have = self:hasOutfit(looktype) and true or false
				for i = 1, #offer.addons do
					offer.addons[i].have = self:hasOutfit(looktype, i) and true or false
				end
			end
		end
	end

	sendJSON(self, "sendStoreData", storeData)
end

function Player.getHistoryData(self)
	local finalOutput = {}
	local historyList = GameStore.retrieveHistoryEntries(self:getAccountId())
	
	for i = 1, #historyList do
		finalOutput[i] = {date = timestampToDate(historyList[i].date), balance = historyList[i].balance, description = historyList[i].description}
	end
	
	sendJSON(self, "sendHistory", {finalOutput})
end

function Player.sendStoreURL(self)
	sendJSON(self, "sendStoreURL", {url = GameStore.storeUrl})
end

function Player.sendImagesURL(self)
	sendJSON(self, "sendImagesURL", {url = GameStore.imagesUrl})
end

function Player.sendHideStore(self)
	sendJSON(self, "sendHideStore", {})
end

function Player.transferCoins(self, data)
	local player = Player(self)
	if not player then
		return false
	end
	
	local playerId = player:getId()
	local receiver = data.name
	local amount = data.amount
	
	if (player:getCoinsBalance() < amount) then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You don't have this amount of coins.")
	end

	if receiver:lower() == player:getName():lower() then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You can't transfer coins to yourself.")
	end

	local resultId = db.storeQuery("SELECT `account_id` FROM `players` WHERE `name` = " .. db.escapeString(receiver:lower()) .. "")
	if not resultId then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "We couldn't find that player.")
	end

	local accountId = result.getDataInt(resultId, "account_id")
	if accountId == player:getAccountId() then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You cannot transfer coin to a character in the same account.")
	end
	
	db.query("UPDATE `"..GameStore.table.."` SET `"..GameStore.tableName.."` = `"..GameStore.tableName.."` + " .. amount .. " WHERE `account_id` = " .. accountId)
	player:removeCoinsBalance(amount)
	addPlayerEvent(sendMessageBox, 350, playerId, "Transfer Successfull", "You have transfered " .. amount .. " coins to " .. receiver .. " successfully")

	-- Adding history for both receiver/sender
	GameStore.insertHistory(accountId, player:getName() .. " transfered you this amount.", amount)
	GameStore.insertHistory(player:getAccountId(), "You transfered this amount to "..receiver, -1 * amount) -- negative
end

function Player.withdrawCoins(self, data)	
    local playerId = self:getId()
    local amount = data.amount
    local originalAmount = amount  -- Store the original amount before the loop
    
    if (self:getCoinsBalance() < amount) then
        return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You don't have this amount of coins.")
    end
    
    self:removeCoinsBalance(amount)
    local storeInbox = self:getStoreInbox()

    while amount > 0 do
        local stack = math.min(amount, 100)
        local item = Game.createItem(GameStore.coinsId, stack)

        item:setStoreItem(true)
        item:moveTo(storeInbox, FLAG_NOLIMIT)
        item:setStoreItem(false)

        amount = amount - stack
    end
    
    -- Use originalAmount in the success message
    addPlayerEvent(sendMessageBox, 350, playerId, "Withdraw Successful", "You have withdrawn " .. originalAmount .. " coins successfully, check it in your storeinbox.")
    
    -- Adding history for both receiver/sender
    GameStore.insertHistory(self:getAccountId(), "Withdrawn coins", -1 * originalAmount) -- negative
end


function Player.storeBuyItem(self, offer)
	local data = GameStore.getOfferByName(offer.name)
	if not data then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "This offer is unavailable [1].")
	end

	local price = data.price
	if offer.addon and data.addons[tonumber(offer.addon)].price then
		price = data.addons[tonumber(offer.addon)].price
	end
	
	local playerId = self:getId()
	if (table.contains(GameStore_OfferTypes, data.type) == false)                    -- we've got an invalid offer type
		or (not self)                                                                -- player not found
		or (not data)                                                                  -- we could not find the offer
		or (data.type == GameStore_OfferTypes.OFFER_TYPE_NONE)                         -- offer is disabled
		or (data.type ~= GameStore_OfferTypes.OFFER_TYPE_NAMECHANGE and
			data.type ~= GameStore_OfferTypes.OFFER_TYPE_EXPBOOST and
			data.type ~= GameStore_OfferTypes.OFFER_TYPE_TEMPLE and
			data.type ~= GameStore_OfferTypes.OFFER_TYPE_OUTFIT and
			data.type ~= GameStore_OfferTypes.OFFER_TYPE_SEXCHANGE and
	not data.id) then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "This offer is unavailable [1].")
	end
	
	if not self:canRemoveCoins(price) then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You don't have enough coins. Your purchase has been cancelled.")
	end

	if data.type == GameStore_OfferTypes.OFFER_TYPE_ITEM then
		local storeInbox = self:getStoreInbox()

		local item
		if data.wrap then
			item = Game.createItem(data.wrap, 1)
			item:setCustomAttribute('wrap', data.id)
			item:setCustomAttribute('wrap_amount', data.count)
		else
			item = Game.createItem(data.id, data.count)
		end

		if data.floor_furniture then
			item:setCustomAttribute('wrap_tile', true)
		elseif data.border_furniture then
			item:setCustomAttribute('wrap_border', true)
		end

		item:setCustomAttribute('wrap_pack', true)
		item:setStoreItem(true)
		item:moveTo(storeInbox, FLAG_NOLIMIT)
		item:setStoreItem(false)
	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_STACKABLE then
		local storeInbox = self:getStoreInbox()
		local item = Game.createItem(data.id, data.count)
		item:setStoreItem(true)
		item:moveTo(storeInbox, FLAG_NOLIMIT)
		item:setStoreItem(false)
	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_OUTFIT then

		local looktype = data.sexId.male
		if self:getSex() == 0 then
			looktype = data.sexId.female
		end

		local addon = tonumber(offer.addon)
		local addonData = data.addons[addon]

		if addonData then
			if not addonData.enabled then
				return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Internal error.")
			end
		end

		if addon and addon > 0 then
			if self:hasOutfit(looktype) then
				if self:hasOutfit(looktype, offer.addon) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You already own this addon.")
				else
					self:addOutfitAddon(looktype, offer.addon)
    
					self:removeCoinsBalance(addonData.price)
					self:sendShopBalance()
					GameStore.insertHistory(self:getAccountId(), data.name, (data.price) * -1)
					local message = string.format("You have purchased addon %d of %s for %d coins.", addon, data.name, addonData.price)
					return addPlayerEvent(sendMessageBox, 350, playerId, "Purchase Successfull", message)
				end
			else
				return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You need to buy the outfit first.")
			end
		end

		if not looktype then
			return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "This outfit seems not to suit your sex, we are sorry for that!")
		elseif self:hasOutfit(looktype) then
			return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You already own this outfit.")
		else
			if not (self:addOutfitAddon(looktype)) or (not self:hasOutfit(looktype)) then
				return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "There has been an issue with your outfit purchase. Your purchase has been cancelled.")
			else
				self:addOutfit(looktype)
			end
		end
	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_MOUNT then
		self:addMount(data.id)
	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_NAMECHANGE then
		-- name change support not done
	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_SEXCHANGE then
		local currentSex = self:getSex()
		local playerOutfit = self:getOutfit()

		playerOutfit.lookAddons = 0
		if currentSex == PLAYERSEX_FEMALE then
			self:setSex(PLAYERSEX_MALE)
			playerOutfit.lookType = 128
		else
			self:setSex(PLAYERSEX_FEMALE)
			playerOutfit.lookType = 136
		end
		
		self:setOutfit(playerOutfit)
		-- self:sendHideStore()
	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_TEMPLE then
		if self:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) or self:isPzLocked() then
			return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You can't use temple teleport in fight!")
		end

		self:teleportTo(self:getTown():getTemplePosition())
		self:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have been teleported to your hometown.')
	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_PREMIUM then
		self:addPremiumDays(data.count)
	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_BLESSINGS then
		if not self:hasBlessing(data.id) then
			self:addBlessing(data.id)
			self:updateBlessingStorages()
		else
			return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Sorry, you already posses this blessing.")
		end
	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_ALLBLESSINGS then
		if (self:getBlessingCount() > 5) then
			return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Sorry, you already posses this blessing.")
		end
		
		for i = 1, 5 do
			self:addBlessing(i)
		end
		self:updateBlessingStorages()
	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_XPBOOST then
		local expBoostSto = self:getStorageValue(45245)
		if (expBoostSto > os.time()) then
			return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Sorry, you have already a expboost ongoing.")
		end
		
--		self:setStorageValue(45245, os.time() + 60)
--	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_EXTRACHARM then
--		local getExtraCharm = self:getStorageValue(555556) > 1 and self:getStorageValue(555556) or 1
--		if (getExtraCharm > 2) then
--			return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Sorry, you already have the maximum number of Extra Charms.")
--		end

--		self:setStorageValue(555556, getExtraCharm+1)
--		local coins = json.encode({action = "coins", data = {charm = (getCharmCoin(self) > 0 and getCharmCoin(self) or 0), extracharm = tonumber(self:getStorageValue(555556)), gold = self:getMoney()}})
--		self:sendExtendedOpcode(92, coins)
--	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_PACKMARKET then
--		local getPackMarket = self:getStorageValue(175420)
--		if (getPackMarket >= os.time()) then
--			return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Sorry, you already have a valid Market Permission.")
--		end
--		self:setStorageValue(175420, os.time()+(data.count*86400))

	elseif data.type == GameStore_OfferTypes.OFFER_TYPE_UPGRADEEXTRACT then
		local storeInbox = self:getStoreInbox()
		item = Game.createItem(data.id, data.count)
		item:moveTo(storeInbox, FLAG_NOLIMIT)
	end
	

	self:removeCoinsBalance(data.price)    
	self:sendShopBalance()
	-- self:sendHideStore()
	GameStore.insertHistory(self:getAccountId(), data.name, (data.price) * -1)
		
	local message = string.format("You have purchased %s for %d coins.", data.name, data.price)
	addPlayerEvent(sendMessageBox, 350, playerId, "Purchase Successfull", message)
	return true
end

-- History Related Functions
GameStore.insertHistory = function(accountId, description, amount)
	return db.query(string.format("INSERT INTO `store_history`(`account_id`, `mode`, `description`, `coin_amount`, `time`) VALUES (%s, %s, %s, %s, %s)", accountId, 0, db.escapeString(description), amount, os.time()))
end

GameStore.retrieveHistoryTotalEntries = function (accountId) 
	local resultId = db.storeQuery("SELECT count(id) as total FROM store_history WHERE account_id = " .. accountId)
	if resultId == false then
		return 0
	end

	local totalPages = result.getDataInt(resultId, "total")
	result.free(resultId)
	return totalPages
end

GameStore.retrieveHistoryEntries = function(accountId)
	local entries = {}
	
	local resultId = db.storeQuery("SELECT * FROM `store_history` WHERE `account_id` = " .. accountId .. " ORDER BY `time` DESC LIMIT " .. GameStore.historyMaxRows .. ";")
	if resultId ~= false then
		repeat
			local entry = {
				description = result.getDataString(resultId, "description"),
				balance = result.getDataInt(resultId, "coin_amount"),
				date = result.getDataInt(resultId, "time"),
			}
			table.insert(entries, entry)
		until not result.next(resultId)
		result.free(resultId)
	end
	
	return entries
end

-- Coins related functions
function Player.getCoinsBalance(self)
	resultId = db.storeQuery("SELECT `"..GameStore.tableName.."` FROM `"..GameStore.table.."` WHERE `account_id` = " .. self:getAccountId())
	if not resultId then return 0 end
	return result.getDataInt(resultId, ""..GameStore.tableName.."")
end

function Player.setCoinsBalance(self, coins)
	db.query("UPDATE `"..GameStore.table.."` SET `"..GameStore.tableName.."` = " .. coins .. " WHERE `account_id` = " .. self:getAccountId())
	return true
end

function Player.canRemoveCoins(self, coins)
	if self:getCoinsBalance() < coins then
		return false
	end
	return true
end

function Player.removeCoinsBalance(self, coins)
	if self:canRemoveCoins(coins) then
		return self:setCoinsBalance(self:getCoinsBalance() - coins)
	end

	return false
end

function Player.addCoinsBalance(self, coins, history)
	self:setCoinsBalance(self:getCoinsBalance() + coins)
	if history then
		GameStore.insertHistory(self:getAccountId(), "Deposited Coins (Via using item)", coins)
	end
return true
end

-- Special Functions
function Player.getBlessingCount(self)
	local t = 0
	for i = 1, 5 do
		if self:hasBlessing(i) then
			t = t + 1
		end
	end
return t
end

function timestampToDate(timestamp)
    local day_count, year, days, month = function(yr) return (yr % 4 == 0 and (yr % 100 ~= 0 or yr % 400 == 0)) and 366 or 365 end, 1970, math.ceil(timestamp/86400)
    while days >= day_count(year) do
        days = days - day_count(year) year = year + 1
    end
	
    local tab_overflow = function(seed, table) for i = 1, #table do if seed - table[i] <= 0 then return i, seed end seed = seed - table[i] end end
    month, days = tab_overflow(days, {31,(day_count(year) == 366 and 29 or 28),31,30,31,30,31,31,30,31,30,31})
    local hours, minutes, seconds = math.floor(timestamp / 3600 % 24), math.floor(timestamp / 60 % 60), math.floor(timestamp % 60)
    hours = hours > 12 and hours - 12 or hours == 0 and 12 or hours
    return string.format("%d-%d-%d, %02d:%02d:%02d", year, month, days, hours, minutes, seconds)
end