function Monster:onDropLoot(corpse)
	if hasEventCallback(EVENT_CALLBACK_ONDROPLOOT) then
		EventCallback(EVENT_CALLBACK_ONDROPLOOT, self, corpse)
	end

	if self:isElite() then
		G_MONSTERSTAR.processExtraLoot(self, corpse)
	end
end

function Monster:onCreate(position)
	G_MONSTERSTAR.processSpawn(self, position)
	self:checkStatisticsMode()
end

function Monster:onDeath(player, position)
	if hasEventCallback(EVENT_CALLBACK_ONDEATH) then
		return EventCallback(EVENT_CALLBACK_ONDEATH, self, player, position)
	end

	local party = player:getParty()
	if party then
		local leader = party:getLeader()
		local damageMap = self:getDamageMap()

		if not party:isSharedExperienceEnabled() or not party:isSharedExperienceActive() then
			return true
		end

		if not damageMap[leader:getId()] then
			return true
		end

		G_MONSTERSTAR.processDeath(self, leader, position)
	else
		G_MONSTERSTAR.processDeath(self, player, position)
	end

end

function Monster:onGenerateLootChance(chance)
	-- Exclusive function for monster stars.
	local lootChanceExtra = geBestiaryConfigByStarAndExperience(self:getType():experience(), self:getStar()).loot
	chance = chance + lootChanceExtra
	return chance
end

