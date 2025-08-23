local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end

function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end

function onThink()
	npcHandler:onThink()
end

function onPlayerEndTrade(cid)
	npcHandler:onPlayerEndTrade(cid)
end

function onPlayerCloseChannel(cid)
	npcHandler:onPlayerCloseChannel(cid)
end
-- OTServ event handling functions end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

------------------------------- ITENS QUE O NPC VENDE --------------------------------------

-- Runas
shopModule:addBuyableItem({'Animate Dead Rune'}, 2316, 750, 'Animate Dead Rune')
shopModule:addBuyableItem({'Avalanche Rune'}, 2274, 50, 'Avalanche Rune')
shopModule:addBuyableItem({'Blank Rune'}, 2260, 20, 'Blank Rune')
shopModule:addBuyableItem({'Chameleon Rune'}, 2291, 420, 'Chameleon Rune')
shopModule:addBuyableItem({'Convince Creature Rune'}, 2290, 160, 'Convince Creature Rune')
shopModule:addBuyableItem({'Cure Poison Rune'}, 2266, 130, 'Cure Poison Rune')
shopModule:addBuyableItem({'Desintegrate Rune'}, 2310, 52, 'Desintegrate Rune')
shopModule:addBuyableItem({'Destroy Field Rune'}, 2261, 30, 'Destroy Field Rune')
shopModule:addBuyableItem({'Energy Bomb Rune'}, 2262, 324, 'Energy Bomb Rune')
shopModule:addBuyableItem({'Energy Field Rune'}, 2277, 76, 'Energy Field Rune')
shopModule:addBuyableItem({'Energy Wall Rune'}, 2279, 170, 'Energy Wall Rune')
shopModule:addBuyableItem({'Explosion Rune'}, 2313, 62, 'Explosion Rune')
shopModule:addBuyableItem({'Fire Bomb Rune'}, 2305, 110, 'Fire Bomb Rune')
shopModule:addBuyableItem({'Fire Field Rune'}, 2301, 56, 'Fire Field Rune')
shopModule:addBuyableItem({'Fire Wall Rune'}, 2303, 122, 'Fire Wall Rune')
shopModule:addBuyableItem({'Fireball Rune'}, 2302, 60, 'Fireball Rune')
shopModule:addBuyableItem({'Great Fireball Rune'}, 2304, 90, 'Great Fireball Rune')
shopModule:addBuyableItem({'Heavy Magic Missile Rune'}, 2311, 24, 'Heavy Magic Missile Rune')
shopModule:addBuyableItem({'Holy Missile Rune'}, 2295, 32, 'Holy Missile Rune')
shopModule:addBuyableItem({'Icicle Rune'}, 2271, 60, 'Icicle Rune')
shopModule:addBuyableItem({'Intense Healing Rune'}, 2265, 190, 'Intense Healing Rune')
shopModule:addBuyableItem({'Light Magic Missile Rune'}, 2287, 8, 'Light Magic Missile Rune')
shopModule:addBuyableItem({'Magic Wall Rune'}, 2293, 110, 'Magic Wall Rune')
shopModule:addBuyableItem({'Paralyze Rune'}, 2278, 1000, 'Paralyze Rune')
shopModule:addBuyableItem({'Poison Bomb Rune'}, 2286, 170, 'Poison Bomb Rune')
shopModule:addBuyableItem({'Poison Field Rune'}, 2285, 42, 'Poison Field Rune')
shopModule:addBuyableItem({'Poison Wall Rune'}, 2289, 104, 'Poison Wall Rune')
shopModule:addBuyableItem({'Soulfire Rune'}, 2308, 92, 'Soulfire Rune')
shopModule:addBuyableItem({'Stalagmite Rune'}, 2292, 24, 'Stalagmite Rune')
shopModule:addBuyableItem({'Stone Shower Rune'}, 2288, 74, 'Stone Shower Rune')
shopModule:addBuyableItem({'Sudden Death Rune'}, 2268, 100, 'Sudden Death Rune')
shopModule:addBuyableItem({'Thunderstorm Rune'}, 2315, 74, 'Thunderstorm Rune')
shopModule:addBuyableItem({'Ultimate Healing Rune'}, 2273, 350, 'Ultimate Healing Rune')
shopModule:addBuyableItem({'Wild Growth Rune'}, 2269, 320, 'Wild Growth Rune')

-- Poções
shopModule:addBuyableItem({'Health Potion'}, 7618, 45, 'Health Potion')
shopModule:addBuyableItem({'Mana Potion'}, 7620, 50, 'Mana Potion')
shopModule:addBuyableItem({'Great Health Potion'}, 7591, 190, 'Great Health Potion')
shopModule:addBuyableItem({'Great Mana Potion'}, 7590, 120, 'Great Mana Potion')
shopModule:addBuyableItem({'Strong Health Potion'}, 7588, 100, 'Strong Health Potion')
shopModule:addBuyableItem({'Strong Mana Potion'}, 7589, 80, 'Strong Mana Potion')
shopModule:addBuyableItem({'Great Spirit Potion'}, 8472, 190, 'Great Spirit Potion')
shopModule:addBuyableItem({'Ultimate Health Potion'}, 8473, 310, 'Ultimate Health Potion')

-- Itens diversos
shopModule:addBuyableItem({'Egg'}, 2328, 3, 'Egg')
shopModule:addBuyableItem({'Ham'}, 2671, 10, 'Ham')
shopModule:addBuyableItem({'Life Ring'}, 2168, 1800, 'Life Ring')

-- Itens de Mago
shopModule:addBuyableItem({'Exercise Rod'}, 33086, 525000, 'Exercise Rod')
shopModule:addBuyableItem({'Exercise Wand'}, 33087, 525000, 'Exercise Wand')
shopModule:addBuyableItem({'Hailstorm Rod'}, 2183, 30000, 'Hailstorm Rod')
shopModule:addBuyableItem({'Moonlight Rod'}, 2186, 2000, 'Moonlight Rod')
shopModule:addBuyableItem({'Necrotic Rod'}, 2185, 10000, 'Necrotic Rod')
shopModule:addBuyableItem({'Northwind Rod'}, 8911, 15000, 'Northwind Rod')
shopModule:addBuyableItem({'Snakebite Rod'}, 2182, 1000, 'Snakebite Rod')
shopModule:addBuyableItem({'Springsprout Rod'}, 8912, 36000, 'Springsprout Rod')
shopModule:addBuyableItem({'Terra Rod'}, 2181, 20000, 'Terra Rod')
shopModule:addBuyableItem({'Underworld Rod'}, 8910, 44000, 'Underworld Rod')
shopModule:addBuyableItem({'Wand of Cosmic Energy'}, 2189, 20000, 'Wand of Cosmic Energy')
shopModule:addBuyableItem({'Wand of Decay'}, 2188, 10000, 'Wand of Decay')
shopModule:addBuyableItem({'Wand of Draconia'}, 8921, 15000, 'Wand of Draconia')
shopModule:addBuyableItem({'Wand of Dragonbreath'}, 2191, 2000, 'Wand of Dragonbreath')
shopModule:addBuyableItem({'Wand of Inferno'}, 2187, 30000, 'Wand of Inferno')
shopModule:addBuyableItem({'Wand of Starstorm'}, 8920, 36000, 'Wand of Starstorm')
shopModule:addBuyableItem({'Wand of Voodoo'}, 8922, 44000, 'Wand of Voodoo')
shopModule:addBuyableItem({'Wand of Vortex'}, 2190, 1000, 'Wand of Vortex')

-- Materiais de Imbuement
shopModule:addBuyableItem({'Energy Soil'}, 8303, 2000, 'Energy Soil')
shopModule:addBuyableItem({'Eternal Flames'}, 8304, 5000, 'Eternal Flames')
shopModule:addBuyableItem({'Flawless Ice Crystal'}, 8300, 5000, 'Flawless Ice Crystal')
shopModule:addBuyableItem({'Glimmering Soil'}, 8299, 2000, 'Glimmering Soil')
shopModule:addBuyableItem({'Mother Soil'}, 8305, 5000, 'Mother Soil')
shopModule:addBuyableItem({'Iced Soil'}, 8302, 2000, 'Iced Soil')
shopModule:addBuyableItem({'Natural Soil'}, 8298, 2000, 'Natural Soil')
shopModule:addBuyableItem({'Neutral Matter'}, 8310, 5000, 'Neutral Matter')
shopModule:addBuyableItem({'Pure Energy'}, 8306, 5000, 'Pure Energy')

-- Spellbooks
shopModule:addBuyableItem({'Spellbook of Enlightenment'}, 8900, 32000, 'Spellbook of Enlightenment')
shopModule:addBuyableItem({'Spellbook of Lost Souls'}, 8903, 152000, 'Spellbook of Lost Souls')
shopModule:addBuyableItem({'Spellbook of Mind Control'}, 8902, 104000, 'Spellbook of Mind Control')
shopModule:addBuyableItem({'Spellbook of Warding'}, 8901, 64000, 'Spellbook of Warding')

---

------------------------------- ITENS QUE O NPC COMPRA --------------------------------------
shopModule:addSellableItem({'Crystal Ball'}, 2192, 190, 'Crystal Ball')
shopModule:addSellableItem({'Life Crystal'}, 2177, 85, 'Life Crystal')
shopModule:addSellableItem({'Mind Stone'}, 2178, 170, 'Mind Stone')
shopModule:addSellableItem({'Spellbook of Enlightenment'}, 8900, 4000, 'Spellbook of Enlightenment')
shopModule:addSellableItem({'Spellbook of Lost Souls'}, 8903, 19000, 'Spellbook of Lost Souls')
shopModule:addSellableItem({'Spellbook of Mind Control'}, 8902, 13000, 'Spellbook of Mind Control')
shopModule:addSellableItem({'Spellbook of Warding'}, 8901, 8000, 'Spellbook of Warding')

npcHandler:addModule(FocusModule:new())