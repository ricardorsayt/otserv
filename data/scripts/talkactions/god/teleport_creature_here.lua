local talkaction = TalkAction("/c")

local savepos = {}

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
	
	logCommand(player, words, param)

	local split = param:split(",")
	for _, name in pairs(split) do
		local creature = Creature(name:trim())
		if not creature then
			player:sendCancelMessage("A creature with that name could not be found.")
			return false
		end

		local oldPosition = creature:getPosition()
		local newPosition = creature:getClosestFreePosition(player:getPosition(), false)
		if newPosition.x == 0 then
			player:sendCancelMessage("You can not teleport " .. creature:getName() .. ".")
			return false
		elseif creature:teleportTo(newPosition) then
			
			savepos[creature:getId()] = oldPosition

			if not creature:isInGhostMode() then
				oldPosition:sendMagicEffect(CONST_ME_POFF)
				newPosition:sendMagicEffect(CONST_ME_TELEPORT)
			end
		end
	end
	return false
end

talkaction:separator(" ")
talkaction:register()

local talkaction = TalkAction("/cback")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local split = param:split(",")
	for _, name in pairs(split) do
		local creature = Creature(name:trim())
		if not creature then
			player:sendCancelMessage("A creature with that name could not be found.")
			return false
		end

		if not savepos[creature:getId()] then
			player:sendCancelMessage("You have not teleported " .. creature:getName() .. " yet.")
			return false
		end

		local oldPosition = creature:getPosition()
		local newPosition = creature:getClosestFreePosition(savepos[creature:getId()], false)
		if newPosition.x == 0 then
			player:sendCancelMessage("You can not teleport " .. creature:getName() .. ".")
			return false
		elseif creature:teleportTo(newPosition) then
			if not creature:isInGhostMode() then
				oldPosition:sendMagicEffect(CONST_ME_POFF)
				newPosition:sendMagicEffect(CONST_ME_TELEPORT)
			end
		end
	end
	return false
end

talkaction:separator(" ")
talkaction:register()

local talkaction = TalkAction("/cmc")

function talkaction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

	local ipList = {}
	local players = Game.getPlayers()
	for i = 1, #players do
		local tmpPlayer = players[i]
		local ip = tmpPlayer:getIp()
		if ip ~= 0 then
			ip = Game.convertIpToString(ip)
			local list = ipList[ip]
			if not list then
				ipList[ip] = {}
				list = ipList[ip]
			end
			list[#list + 1] = tmpPlayer
		end
	end

	if not ipList[param] then
		player:sendCancelMessage("No players found with that IP.")
		return false
	end

	local list = ipList[param]
	for i = 1, #list do
		local tmpPlayer = list[i]
		local oldPosition = tmpPlayer:getPosition()
		local newPosition = tmpPlayer:getClosestFreePosition(player:getPosition(), false)
		if newPosition.x == 0 then
			player:sendCancelMessage("You can not teleport " .. tmpPlayer:getName() .. ".")
			return false
		elseif tmpPlayer:teleportTo(newPosition) then
			savepos[tmpPlayer:getId()] = oldPosition

			if not tmpPlayer:isInGhostMode() then
				oldPosition:sendMagicEffect(CONST_ME_POFF)
				newPosition:sendMagicEffect(CONST_ME_TELEPORT)
			end
		end
	end

	return true
end

talkaction:separator(" ")
talkaction:register()

local talkaction = TalkAction("/cmcback")

function talkaction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    local ipList = {}
    local players = Game.getPlayers()
    for i = 1, #players do
        local tmpPlayer = players[i]
        local ip = tmpPlayer:getIp()
        if ip ~= 0 then
            ip = Game.convertIpToString(ip)
            local list = ipList[ip]
            if not list then
                ipList[ip] = {}
                list = ipList[ip]
            end
            list[#list + 1] = tmpPlayer
        end
    end

    if not ipList[param] then
        player:sendCancelMessage("No players found with that IP.")
        return false
    end

    local list = ipList[param]
    for i = 1, #list do
        local tmpPlayer = list[i]

		if not savepos[tmpPlayer:getId()] then
			player:sendCancelMessage("You have not teleported " .. tmpPlayer:getName() .. " yet.")
			return false
		end

        local oldPosition = tmpPlayer:getPosition()
		local newPosition = tmpPlayer:getClosestFreePosition(savepos[tmpPlayer:getId()], false)

        if newPosition.x == 0 then
            player:sendCancelMessage("You can not teleport " .. tmpPlayer:getName() .. ".")
            return false
        elseif tmpPlayer:teleportTo(newPosition) then

            if not tmpPlayer:isInGhostMode() then
                oldPosition:sendMagicEffect(CONST_ME_POFF)
                newPosition:sendMagicEffect(CONST_ME_TELEPORT)
            end
        end
    end

    return true
end

talkaction:separator(" ")
talkaction:register()
