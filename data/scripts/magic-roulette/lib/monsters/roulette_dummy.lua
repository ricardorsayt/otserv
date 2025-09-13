local Constants = require('data/scripts/magic-roulette/lib/core/constants')

local mType = Game.createMonsterType(Constants.ROULETTE_DUMMY_NAME)
local monster = {}

monster.description = ''
monster.experience = 0
monster.outfit = {lookTypeEx = 1551}

monster.health = 100
monster.maxHealth = 100
monster.race = 'undead'
monster.speed = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 2000,
	chance = 0
}

monster.flags = {
	summonable = false,
	attackable = false,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	targetDistance = 1,
	runHealth = 20,
	healthHidden = true,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
}

monster.immunities = {
	{type = 'physical', condition = true},
	{type = 'energy', condition = true},
	{type = 'fire', condition = true},
	{type = 'earth', condition = true},
	{type = 'paralyze', condition = true},
	{type = 'drunk', condition = true},
	{type = 'outfit', condition = true},
	{type = 'invisible', condition = true}
}
mType:register(monster)
