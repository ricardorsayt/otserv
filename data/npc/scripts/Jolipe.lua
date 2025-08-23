local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end
-- OTServ event handling functions end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)



-------------------------------he sells--------------------------------------

--rings
shopModule:addBuyableItem({'wedding ring'}, 2121, 990,'wedding ring')
shopModule:addBuyableItem({'time ring'}, 2169, 2000,'time ring')
shopModule:addBuyableItem({'sword ring'}, 2207, 500,'sword ring')
shopModule:addBuyableItem({'stealth ring'}, 2165, 5000,'stealth ring')
shopModule:addBuyableItem({'signet ring'}, 7697, 15000,'signet ring')
shopModule:addBuyableItem({'ring of the sky'}, 2123, 48000,'ring of the sky')
shopModule:addBuyableItem({'ring of healing'}, 2214, 2000,'ring of healing')
shopModule:addBuyableItem({'power ring'}, 2166, 100,'power ring')
shopModule:addBuyableItem({'might ring'}, 2164, 5000,'might ring')
shopModule:addBuyableItem({'life ring'}, 2168, 900,'life ring')
shopModule:addBuyableItem({'gold ring'}, 2179, 32000,'gold ring')
shopModule:addBuyableItem({'energy ring'}, 2167, 2000,'energy ring')
shopModule:addBuyableItem({'dwarven ring'}, 2213, 2000,'dwarven ring')
shopModule:addBuyableItem({'death ring'}, 6300, 4000,'death ring')
shopModule:addBuyableItem({'crystal ring'}, 2124, 1000,'crystal ring')
shopModule:addBuyableItem({'club ring'}, 2209, 500,'club ring')
shopModule:addBuyableItem({'axe ring'}, 2208, 500,'axe ring')

--amulets
shopModule:addBuyableItem({'Crystal Necklace'}, 2125, 1600,'Crystal Necklace')
shopModule:addBuyableItem({'Ruby Necklace'}, 2133, 3560,'Ruby Necklace')
shopModule:addBuyableItem({'Wolf Tooth Chain'}, 2129, 400,'Wolf Tooth Chain')
shopModule:addBuyableItem({'Dragon Necklace'}, 2201, 1000,'Dragon Necklace')
shopModule:addBuyableItem({'Garlic Necklace'}, 2199, 100,'Garlic Necklace')
shopModule:addBuyableItem({'Beetle Necklace'}, 11374, 6000,'Beetle Necklace')
shopModule:addBuyableItem({'Ancient Amulet'}, 2142, 800,'Ancient Amulet')
shopModule:addBuyableItem({'Demonbone Amulet'}, 2136, 128000,'demonbone Amulet')
shopModule:addBuyableItem({'Golden Amulet'}, 2130, 6600,'Golden Amulet')
shopModule:addBuyableItem({'Scarab Amulet'}, 2135, 800,'Scarab Amulet')
shopModule:addBuyableItem({'Star Amulet'}, 2131, 2000,'Star Amulet')
shopModule:addBuyableItem({'Platinum Amulet'}, 2171, 10000,'Platinum Amulet')
shopModule:addBuyableItem({'Scarf'}, 2661, 15,'Scarf')
shopModule:addBuyableItem({'Amulet of Loss'}, 2173, 50000,'Amulet of Loss')
shopModule:addBuyableItem({'Bronze Amulet'}, 2172, 100,'Bronze Amulet')
shopModule:addBuyableItem({'Elven amulet'}, 2198, 500,'Elven amulet')
shopModule:addBuyableItem({'Glacier amulet'}, 7888, 6000,'Glacier amulet')
shopModule:addBuyableItem({'Leviathan/s amulet'}, 10220, 12000,'Leviathan/s amulet')
shopModule:addBuyableItem({'Lightning pendant'}, 7889, 6000,'Lightning pendant')
shopModule:addBuyableItem({'Magma amulet'}, 7890, 6000,'Magma amulet')
shopModule:addBuyableItem({'Protection amulet'}, 2200, 700,'Protection amulet')
shopModule:addBuyableItem({'Sacred Tree Amulet'}, 10219, 12000,'Sacred Tree Amulet')
shopModule:addBuyableItem({'Shockwave Amulet'}, 10221, 12000,'Shockwave Amulet')
shopModule:addBuyableItem({'Silver Amulet'}, 2170, 50,'Silver Amulet')
shopModule:addBuyableItem({'Stone Skin Amulet'}, 2197, 5000,'Stone Skin Amulet')
shopModule:addBuyableItem({'Strange Talisman'}, 2161, 100,'Strange Talisman')
shopModule:addBuyableItem({'Terra Amulet'}, 7887, 6000, 'Terra Amulet')
shopModule:addBuyableItem({'Gill Necklace'}, 18402, 50000, 'Gill Necklace')
 
--------------------------------he buys--------------------------------------
 
 --rings
shopModule:addSellableItem({'wedding ring'}, 2121, 100,'wedding ring')
shopModule:addSellableItem({'time ring'}, 2169, 100,'time ring')
shopModule:addSellableItem({'sword ring'}, 2207, 100,'sword ring')
shopModule:addSellableItem({'stealth ring'}, 2165, 200,'stealth ring')
shopModule:addSellableItem({'ring of the sky'}, 2123, 12000,'ring of the sky')
shopModule:addSellableItem({'ring of healing'}, 2214, 100,'ring of healing')
shopModule:addSellableItem({'power ring'}, 2166, 50,'power ring')
shopModule:addSellableItem({'might ring'}, 2164, 250,'might ring')
shopModule:addSellableItem({'life ring'}, 2168, 50,'life ring')
shopModule:addSellableItem({'gold ring'}, 2179, 8000,'gold ring')
shopModule:addSellableItem({'energy ring'}, 2167, 100,'energy ring')
shopModule:addSellableItem({'dwarven ring'}, 2213, 100,'dwarven ring')
shopModule:addSellableItem({'death ring'}, 6300, 1000,'death ring')
shopModule:addSellableItem({'crystal ring'}, 2124, 250,'crystal ring')
shopModule:addSellableItem({'club ring'}, 2209, 100,'club ring')
shopModule:addSellableItem({'axe ring'}, 2208, 100,'axe ring')
 
 
--amulets 
shopModule:addSellableItem({'Crystal Necklace'}, 2125, 400,'Crystal Necklace')
shopModule:addSellableItem({'Ruby Necklace'}, 2133, 2000,'Ruby Necklace')
shopModule:addSellableItem({'Wolf Tooth Chain'}, 2129, 100,'Wolf Tooth Chain')
shopModule:addSellableItem({'Dragon Necklace'}, 2201, 100,'Dragon Necklace')
shopModule:addSellableItem({'Garlic Necklace'}, 2199, 50,'Garlic Necklace')
shopModule:addSellableItem({'Beetle Necklace'}, 11374, 1500,'Beetle Necklace')
shopModule:addSellableItem({'Ancient Amulet'}, 2142, 200,'Ancient Amulet')
shopModule:addSellableItem({'Demonbone Amulet'}, 14333, 32000,'demonbone Amulet')
shopModule:addSellableItem({'Golden Amulet'}, 2130, 2000,'Golden Amulet')
shopModule:addSellableItem({'Scarab Amulet'}, 2135, 200,'Scarab Amulet')
shopModule:addSellableItem({'Star Amulet'}, 2131, 500,'Star Amulet')
shopModule:addSellableItem({'Platinum Amulet'}, 2171, 2500,'Platinum Amulet')
shopModule:addSellableItem({'Scarf'}, 2661, 5,'Scarf')
shopModule:addSellableItem({'Amulet of loss'}, 2173, 45000,'Amulet of loss')
shopModule:addSellableItem({'Bronze Amulet'}, 2172, 50,'Bronze Amulet')
shopModule:addSellableItem({'Elven amulet'}, 2198, 100,'Elven amulet')
shopModule:addSellableItem({'Glacier amulet'}, 7888, 1500,'Glacier amulet')
shopModule:addSellableItem({'Leviathan/s amulet'}, 10220, 3000,'Leviathan/s amulet')
shopModule:addSellableItem({'Lightning pendant'}, 7889, 1500,'Lightning pendant')
shopModule:addSellableItem({'Magma amulet'}, 7890, 1500,'Magma amulet')
shopModule:addSellableItem({'Protection amulet'}, 2200, 100,'Protection amulet')
shopModule:addSellableItem({'Sacred Tree Amulet'}, 10219, 3000,'Sacred Tree Amulet')
shopModule:addSellableItem({'Shockwave Amulet'}, 10221, 3000,'Shockwave Amulet')
shopModule:addSellableItem({'Silver Amulet'}, 2170, 25,'Silver Amulet')
shopModule:addSellableItem({'Stone Skin Amulet'}, 2197, 500,'Stone Skin Amulet')
shopModule:addSellableItem({'Strange Talisman'}, 2161, 30,'Strange Talisman')
shopModule:addSellableItem({'Terra Amulet'}, 7887, 1500,'Terra Amulet')
shopModule:addSellableItem({'Gill Necklace'}, 18402, 10000, 'Gill Necklace')

npcHandler:addModule(FocusModule:new())