local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                     npcHandler:onThink()                        end

local voices = { {text = 'Passages to Carlin, Ab\'Dendriel, Edron, Venore, Port Hope, Liberty Bay, Shanera and Svargrond.'} }
npcHandler:addModule(VoiceModule:new(voices))

-- Travel helper (unchanged)
local function addTravelKeyword(keyword, cost, destination, action, condition)
    if condition then
        keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry but I don\'t sail there.'}, condition)
    end

    local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a passage to ' .. keyword:titleCase() .. ' for |TRAVELCOST|?', cost = cost, discount = 'postman'})
        travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, cost = cost, discount = 'postman', destination = destination}, nil, action)
        travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})
end

-- other travels (unchanged)
addTravelKeyword('carlin', 110, Position(32387, 31820, 6), function(player) if player:getStorageValue(Storage.postman.Mission01) == 1 then player:setStorageValue(Storage.postman.Mission01, 2) end end)
addTravelKeyword('ab\'dendriel', 130, Position(32734, 31668, 6))
addTravelKeyword('edron', 160, Position(33175, 31764, 6))
addTravelKeyword('venore', 170, Position(32954, 32022, 6))
addTravelKeyword('port hope', 160, Position(32527, 32784, 6))
-- shanera handled separately below
addTravelKeyword('svargrond', 180, Position(32341, 31108, 6))
addTravelKeyword('liberty bay', 180, Position(32285, 32892, 6))

keywordHandler:addKeyword({'kick'}, StdModule.kick, {npcHandler = npcHandler, destination = {Position(32320, 32219, 6), Position(32321, 32210, 6)}})

-- Basic
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'My name is Captain Bluebear from the Royal Tibia Line.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this sailing-ship.'})
keywordHandler:addKeyword({'captain'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this sailing-ship.'})
keywordHandler:addKeyword({'ship'}, StdModule.say, {npcHandler = npcHandler, text = 'The Royal Tibia Line connects all seaside towns of Tibia.'})
keywordHandler:addKeyword({'line'}, StdModule.say, {npcHandler = npcHandler, text = 'The Royal Tibia Line connects all seaside towns of Tibia.'})
keywordHandler:addKeyword({'company'}, StdModule.say, {npcHandler = npcHandler, text = 'The Royal Tibia Line connects all seaside towns of Tibia.'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = 'The Royal Tibia Line connects all seaside towns of Tibia.'})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, text = 'We can transport everything you want.'})
keywordHandler:addKeyword({'passenger'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to welcome you on board.'})
keywordHandler:addKeyword({'trip'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Carlin}, {Ab\'Dendriel}, {Venore}, {Port Hope}, {Liberty Bay}, {Svargrond}, {Shanera} or {Edron}?'} )
keywordHandler:addKeyword({'route'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Carlin}, {Ab\'Dendriel}, {Venore}, {Port Hope}, {Liberty Bay}, {Svargrond}, {Shanera} or {Edron}?'} )
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Carlin}, {Ab\'Dendriel}, {Venore}, {Port Hope}, {Liberty Bay}, {Svargrond}, {Shanera} or {Edron}?'} )
keywordHandler:addKeyword({'town'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Carlin}, {Ab\'Dendriel}, {Venore}, {Port Hope}, {Liberty Bay}, {Svargrond}, {Shanera} or {Edron}?'} )
keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Carlin}, {Ab\'Dendriel}, {Venore}, {Port Hope}, {Liberty Bay}, {Svargrond}, {Shanera} or {Edron}?'} )
keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Carlin}, {Ab\'Dendriel}, {Venore}, {Port Hope}, {Liberty Bay}, {Svargrond}, {Shanera} or {Edron}?'} )
keywordHandler:addKeyword({'go'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Carlin}, {Ab\'Dendriel}, {Venore}, {Port Hope}, {Liberty Bay}, {Svargrond}, {Shanera} or {Edron}?'} )
keywordHandler:addKeyword({'ice'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry, but we don\'t serve the routes to the Ice Islands.'})
keywordHandler:addKeyword({'senja'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry, but we don\'t serve the routes to the Ice Islands.'})
keywordHandler:addKeyword({'folda'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry, but we don\'t serve the routes to the Ice Islands.'})
keywordHandler:addKeyword({'vega'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry, but we don\'t serve the routes to the Ice Islands.'})
keywordHandler:addKeyword({'darashia'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m not sailing there. This route is afflicted by a ghostship! However I\'ve heard that Captain Fearless from Venore sails there.'})
keywordHandler:addKeyword({'darama'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m not sailing there. This route is afflicted by a ghostship! However I\'ve heard that Captain Fearless from Venore sails there.'})
keywordHandler:addKeyword({'ghost'}, StdModule.say, {npcHandler = npcHandler, text = 'Many people who sailed to Darashia never returned because they were attacked by a ghostship! I\'ll never sail there!'})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, text = 'This is Thais. Where do you want to go?'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome on board, |PLAYERNAME|. Where can I {sail} you today?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye. Recommend us if you were satisfied with our service.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')

npcHandler:addModule(FocusModule:new())

-----------------------------------------------------------------------
-- Custom Shanera travel: only VIPs allowed
-----------------------------------------------------------------------
-- Condition callback (returns true if player is NOT VIP) used to attach the refusal phrase
local function notVipCondition(cid)
    local player = Player(cid)
    if not player then return false end
    -- your VIP check: player:getVipDays() returns timestamp > os.time() when VIP
    return not (player:getVipDays() > os.time())
end

-- Add a refusal message for non-VIP players
keywordHandler:addKeyword({'shanera'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry but I don\'t sail there.'}, notVipCondition)

-- Add the normal travel prompt for everyone (so VIPs will get the prompt & can answer yes/no)
local shaneraTravel = keywordHandler:addKeyword({'shanera'}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a passage to Shanera for |TRAVELCOST|?', cost = 210, discount = 'postman'})

-- 'yes' -> perform travel but require premium (VIP) here
shaneraTravel:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, vipTime = true, cost = 210, discount = 'postman', destination = Position(1270, 1180, 6)}, nil, nil)

-- 'no' response
shaneraTravel:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})

-----------------------------------------------------------------------
-- End of custom Shanera block
-----------------------------------------------------------------------

