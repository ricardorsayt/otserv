
local CONFIG = {
    DATA = {},
    ITEM_ID = 5108,
    END_TIME = 86400,
	DUMMY_SKIN_STORAGE = 235000,
    DUMMY_PLAYER_LIMIT = 2,
    DUMMY = {
        NAME = 'Dummy Target',
    },
    ATTRIBUTES = {
        ITEM_DUMMY_TIME = "ITEM_ATTRIBUTE_DUMMY_TIME",
        ITEM_DUMMY_ID = "ITEM_ATTRIBUTE_DUMMY_ID",
        ITEM_OWNER = "ITEM_ATTRIBUTE_OWNER",
        ITEM_OWNER_NAME = "ITEM_ATTRIBUTE_OWNER_NAME",
    },
    INVALID_GROUNDS = {
        384, 418, 2781, 3984, 294, 369, 370, 383, 392, 408, 409, 410,
        427, 428, 429, 430, 462, 469, 470, 482, 484, 485, 489, 924, 3135, 3136,
        3311, 3324, 4835, 4837, 468, 481, 483
    }
}

local dummy_skins = {
	{name = "Dummy Target", storage = 235001, haveSkin = false, outfit = {type = 198, auxType = 0, head = 0, body = 0, legs = 0, feet = 0, addons = 0, wings = 0, aura = 0, shader = ""}, corpse = 5111},
	{name = "Dummy Demon", storage = 235002, haveSkin = false, outfit = {type = 331, auxType = 0, head = 0, body = 0, legs = 0, feet = 0, addons = 0, wings = 0, aura = 0, shader = ""}, corpse = 5543},
	{name = "Dummy Ravenor", storage = 235003, haveSkin = false, outfit = {type = 199, auxType = 0, head = 0, body = 0, legs = 0, feet = 0, addons = 0, wings = 0, aura = 0, shader = ""}, corpse = 5112},
	{name = "Dummy Crow", storage = 235004, haveSkin = false, outfit = {type = 346, auxType = 0, head = 0, body = 0, legs = 0, feet = 0, addons = 0, wings = 0, aura = 0, shader = ""}, corpse = 5749},
}

local function verifyArea(pos, creature, proj, pz)
    if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then
        return false
    end
    
    if getTopCreature(pos).uid > 0 and creature then
        return false
    end
    
    if getTileInfo(pos).protection and pz then
        return false, true
    end
    
    for i = 0, 255 do
        pos.stackpos = i
        local tile = getTileThingByPos(pos)

        if tile.itemid ~= 0 and not isCreature(tile.uid) then
            if hasProperty(tile.uid, 0) then
                return false
            end
        end
    end
    return true
end

local function isSpawnable(position, dummyId) 
    local freeTiles = 0
    local monsterCount = 0
    local pos = position
    for x=-1,1 do
        for y=-1,1 do
        local pos = {x=pos.x+x,y=pos.y+y,z=pos.z}
            if Tile(pos) then
            local tile = Tile(pos)
                if tile and verifyArea(pos) then            
                    freeTiles = freeTiles + 1
                end

                if getTopCreature(pos).uid > 0 then
                    if getTopCreature(pos).uid ~= dummyId then
                        monsterCount = monsterCount + 1
                    end
                end
            end
        end
    end

    if monsterCount > 1 then
        return false
    end

    if freeTiles < 9 then
        return false
    end
    return true
end

local function isValidQuantity(playerId)
    local quantity = 0
    for _, data in pairs(CONFIG.DATA) do
        if data.player == playerId  then
            quantity = quantity + 1
        end
    end
    return quantity
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if(player:getPosition() == target:getPosition()) then
        return false
    end

    if target:isItem() then
        if table.contains(CONFIG.INVALID_GROUNDS, target:getId()) then
            return false
        end
    end

    local dummy = Monster(item:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_DUMMY_ID))

    if target:isMonster() then
        if target:getId() == item:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_DUMMY_ID) then
            if CONFIG.DATA[dummy:getId()] then
                stopEvent(CONFIG.DATA[dummy:getId()].event)
                CONFIG.DATA[dummy:getId()] = nil
            end
            dummy:getPosition():sendMagicEffect(CONST_ME_POFF)
            dummy:remove()
            return
        end
    end 

    local dummyId = 0;
    if dummy then
        dummyId = dummy:getId()
    end

    if not isSpawnable(target:getPosition(), dummyId) and not target:getPosition() ~= player:getPosition() then
        player:sendCancelMessage("Sorry, there is not enough space.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return
    end

    if Tile(target:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then 
        player:sendCancelMessage("This action is not permitted in a protection zone.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return
    end
    
    local ownerId = item:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_OWNER)
    
    if ownerId and (ownerId ~= player:getAccountId() or ownerId == player:getId()) then
        player:sendCancelMessage("This dummy is account bounded to another player.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
        
    if not ownerId then
        item:setCustomAttribute(CONFIG.ATTRIBUTES.ITEM_DUMMY_TIME, os.time() + CONFIG.END_TIME)
    end
    
    item:setCustomAttribute(CONFIG.ATTRIBUTES.ITEM_OWNER, player:getAccountId())
    item:setCustomAttribute(CONFIG.ATTRIBUTES.ITEM_OWNER_NAME, player:getName()) -- Always update the last who used!

    local time =  item:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_DUMMY_TIME)
    if time > os.time() then

            if dummy then
                if CONFIG.DATA[dummy:getId()] then
                    stopEvent(CONFIG.DATA[dummy:getId()].event)
                    CONFIG.DATA[dummy:getId()] = nil
                end
                dummy:getPosition():sendMagicEffect(CONST_ME_POFF)
                dummy:remove()
            end

            if isValidQuantity(player:getId()) >= CONFIG.DUMMY_PLAYER_LIMIT then
                player:sendCancelMessage("Your daily usage limit has been used...")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
                return
            end

            dummy = Game.createMonster(CONFIG.DUMMY.NAME, target:getPosition(), true)

			if player:getStorageValue(CONFIG.DUMMY_SKIN_STORAGE) > 0 then
				local getDummy = player:getStorageValue(CONFIG.DUMMY_SKIN_STORAGE)
				dummy:setOutfit({lookType = dummy_skins[getDummy].outfit.type, lookTypeEx = dummy_skins[getDummy].outfit.auxType, lookHead = dummy_skins[getDummy].outfit.head, lookBody = dummy_skins[getDummy].outfit.body, lookLegs = dummy_skins[getDummy].outfit.legs, lookFeet = dummy_skins[getDummy].outfit.feet})
			end

			player:setStorageValue(234000, dummy:getId())

            dummy:registerEvent('dummyDeath')
            dummy:registerEvent('DummyHealthChange')
            dummy:addAccountBound(player)

            item:setCustomAttribute(CONFIG.ATTRIBUTES.ITEM_DUMMY_ID, dummy:getId())
            dummy:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

            if not CONFIG.DATA[dummy:getId()] then
                local eventId = addEvent(function(monsterId)
                    local tmpDummy = Monster(monsterId)
                    if tmpDummy then
                        Game.createItem(CONFIG.DUMMY.CORPSE, 1, tmpDummy:getPosition())
                        CONFIG.DATA[monsterId] = nil
                        tmpDummy:remove()
                    end
                end, (time - os.time()) * 1000, dummy:getId())

                CONFIG.DATA[dummy:getId()] = {
                    player = player:getId(),
                    owner = player:getAccountId(),
                    event = eventId
                }
            end
    else
        item:remove()
    end
    return true
end

action:id(CONFIG.ITEM_ID)
action:register()

local event = EventCallback
function event.onLook(player, thing, position, distance)
    if thing:getId() == CONFIG.ITEM_ID then
        local time = "It is brand new."
        local dummyTime = thing:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_DUMMY_TIME)
        local owner = thing:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_OWNER_NAME)
        local message = ""
        
        if dummyTime then
            message = string.format("\nIt is owned by %s.", owner)
            local remainingTime = dummyTime - os.time()

            if remainingTime > 0 then
                if remainingTime >= 3600 then
                    local remainingHours = math.floor(remainingTime / 3600)
                    local remainingMinutes = math.floor((remainingTime % 3600) / 60)
                    if remainingMinutes == 0 then
                        time = string.format("It has %d hour%s left to expire.", remainingHours,
                            remainingHours > 1 and "s" or "")
                    else
                        time = string.format("It has %d hour%s and %d minute%s left to expire.", remainingHours,
                            remainingHours > 1 and "s" or "", remainingMinutes, remainingMinutes ~= 1 and "s" or "")
                    end
                elseif remainingTime >= 60 then
                    local remainingMinutes = math.floor(remainingTime / 60)
                    local remainingSeconds = remainingTime % 60
                    if remainingSeconds == 0 then
                        time = string.format("It has %d minute%s left to expire.", remainingMinutes,
                            remainingMinutes > 1 and "s" or "")
                    else
                        time = string.format("It has %d minute%s and %d second%s left to expire.", remainingMinutes,
                            remainingMinutes > 1 and "s" or "", remainingSeconds, remainingSeconds ~= 1 and "s" or "")
                    end
                else
                    time = string.format("It has %d second%s left to expire.", remainingTime,
                        remainingTime > 1 and "s" or "")
                end
            else
                time = ""
                message = string.format("It has expired.")
            end
        end

        thing:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("\n%s%s", time, message))
    end
end

event:register(-1)

function Creature:onTargetDummy(target)
    local player
    if not target then 
        return RETURNVALUE_NOERROR
    end
    if target:isMonster() then
        if self:isPlayer() then
            player = self
        elseif self:isSummon() then
            player = self:getMaster()
        end

        local config = CONFIG.DATA[target:getId()]
    
        if player and config then
            if config.owner ~= player:getAccountId() then
                return RETURNVALUE_YOUARENOTTHEOWNER
            end
        end
    elseif self:isMonster() then
        if target:isPlayer() then
            player = target
        elseif target:isSummon() then
            player = target:getMaster()
        end

        local config = CONFIG.DATA[self:getId()]
    
        if player and config then
            if config.owner ~= player:getAccountId() then
                return RETURNVALUE_YOUARENOTTHEOWNER
            end
        end
    end

    return RETURNVALUE_NOERROR
end

local creatureevent = CreatureEvent("DummyHealthChange")

function creatureevent.onHealthChange(creature, attacker, damage, type, origin)
    if attacker and attacker:isPlayer() then
        if creature:onTargetDummy() == RETURNVALUE_YOUARENOTTHEOWNER then
            return 0, type
        end
    end

	return damage, type
end

creatureevent:register()


local creatureevent = CreatureEvent("dummyDeath")

function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
    CONFIG.DATA[creature:getId()] = nil
	addEvent(function()
		newCorpse = nil
		for i = 1, #dummy_skins do
			if creature:getOutfit().lookType == dummy_skins[i].outfit.type then
				newCorpse = dummy_skins[i].corpse
			end
		end

		if newCorpse then
			corpse:transform(newCorpse, 1)
		end
	end, 0)
    return true
end

creatureevent:register()



function loadDummySkins(player)
	for i = 1, #dummy_skins do
		if player:getStorageValue(dummy_skins[i].storage) >= 1 then
			dummy_skins[i].haveSkin = true
		else
			dummy_skins[i].haveSkin = false
		end
	end

	return true
end

creatureEvent = CreatureEvent("DummySkinsLoggin")
function creatureEvent.onLogin(player)
	player:registerEvent("DummySkins")

	return true
end
creatureEvent:register()

creatureEvent = CreatureEvent("DummySkins")
function creatureEvent.onExtendedOpcode(player, opcode, buffer)
	if opcode == 95 then
		if buffer == "refresh" then
			loadDummySkins(player)
			local refresh = json.encode({action = "dummyskins", data = dummy_skins})
			player:sendExtendedOpcode(95, refresh)
		else
			for i = 1, #dummy_skins do
				if dummy_skins[i].name == buffer then
					if player:getStorageValue(dummy_skins[i].storage) >= 1 then
						local dummy = Monster(player:getStorageValue(234000))
						if dummy then
							if string.find(dummy:getName():lower(), "dummy") then
								player:setStorageValue(235000, i)
								dummy:setOutfit({lookType = dummy_skins[i].outfit.type, lookTypeEx = dummy_skins[i].outfit.auxType, lookHead = dummy_skins[i].outfit.head, lookBody = dummy_skins[i].outfit.body, lookLegs = dummy_skins[i].outfit.legs, lookFeet = dummy_skins[i].outfit.feet})
							end
						end
					end
				end
			end
		end
	end

	return true
end
creatureEvent:register()