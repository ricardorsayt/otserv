--[[
	Description: This file is part of Roulette System (refactored)
	Author: Ly�
	Discord: Ly�#8767
]]

local DatabaseRoulettePlays = require('data/scripts/magic-roulette/lib/database/roulette_plays')
local Functions = require('data/scripts/magic-roulette/lib/core/functions')

local creatureevent = CreatureEvent('Roulette Login')

function creatureevent.onLogin(player)
	local pendingPlayRewards = DatabaseRoulettePlays:selectPendingPlayRewardsByPlayerGuid(player:getGuid())
	
	for _, reward in ipairs(pendingPlayRewards) do
		Functions:giveReward(player, reward)
	end

	return true
end

creatureevent:register()
