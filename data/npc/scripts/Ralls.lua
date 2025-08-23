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

-------------------------------he sells--------------------------------------

-- NPC VENDE ITEMS
shopModule:addBuyableItem({'Assassin Star'}, 7368, 100, 'Assassin Star')
shopModule:addBuyableItem({'Leaf Star'}, 29036, 80, 'Leaf Star')
shopModule:addBuyableItem({'Royal Star'}, 29059, 100, 'Royal Star')
shopModule:addBuyableItem({'Throwing Knife'}, 2410, 30, 'Throwing Knife')
shopModule:addBuyableItem({'Throwing Star'}, 2399, 50, 'Throwing Star')
shopModule:addBuyableItem({'Viper Star'}, 7366, 40, 'Viper Knife')


shopModule:addBuyableItem({'Small Stone'}, 1294, 50, 'Small Stone')


shopModule:addBuyableItem({'Bolt'}, 2543, 4, 'Bolt')
shopModule:addBuyableItem({'Bow'}, 2456, 400, 'Bow')
shopModule:addBuyableItem({'Spear'}, 2389, 9, 'Spear')
shopModule:addBuyableItem({'Quiver'}, 40965, 400, 'Quiver')
shopModule:addBuyableItem({'Arrow'}, 2544, 3, 'Arrow')
shopModule:addBuyableItem({'Bolt'}, 2543, 4, 'Bolt')
shopModule:addBuyableItem({'Bow'}, 2456, 400, 'Bow')
shopModule:addBuyableItem({'Crossbow'}, 2455, 500, 'Crossbow')
shopModule:addBuyableItem({'Crystalline Arrow'}, 18304, 20, 'Crystalline Arrow')
shopModule:addBuyableItem({'Drill Bolt'}, 18436, 12, 'Drill Bolt')
shopModule:addBuyableItem({'Earth Arrow'}, 7850, 5, 'Earth Arrow')
shopModule:addBuyableItem({'Envenomed Arrow'}, 18437, 12, 'Envenomed Arrow')
shopModule:addBuyableItem({'Flaming Arrow'}, 7840, 5, 'Flaming Arrow')
shopModule:addBuyableItem({'Flash Arrow'}, 7838, 5, 'Flash Arrow')
shopModule:addBuyableItem({'Onyx Arrow'}, 7365, 7, 'Onyx Arrow')
shopModule:addBuyableItem({'Piercing Bolt'}, 7363, 5, 'Piercing Bolt')
shopModule:addBuyableItem({'Power Bolt'}, 2547, 7, 'Power Bolt')
shopModule:addBuyableItem({'Prismatic Bolt'}, 18435, 20, 'Prismatic Bolt')
shopModule:addBuyableItem({'Shiver Arrow'}, 7839, 5, 'Shiver Arrow')
shopModule:addBuyableItem({'Sniper Arrow'}, 7364, 5, 'Sniper Arrow')
shopModule:addBuyableItem({'Tarsal Arrow'}, 15648, 6, 'Tarsal Arrow')
shopModule:addBuyableItem({'Throwing Star'}, 2399, 42, 'Throwing Star')
shopModule:addBuyableItem({'Vortex Bolt'}, 15649, 6, 'Vortex Bolt')

shopModule:addBuyableItem({'Royal Spear'}, 7378, 15, 'Royal Spear')
shopModule:addBuyableItem({'Glooth Spear'}, 23529, 100, 'Glooth Spear')
shopModule:addBuyableItem({'HuntingSpear'}, 3965, 15, 'Hunting Spear')


--------------------------------he buys--------------------------------------

-- NPC COMPRA ARMOR


npcHandler:addModule(FocusModule:new())