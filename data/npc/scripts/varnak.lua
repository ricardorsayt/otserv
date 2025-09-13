local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- id, lost, gain
local orbT1 = {5570, 200, 1}
local orbT2 = {5571, 40, 1}
local orbT3 = {5572, 10, 1}
local orbT4 = {5573, 100, 1}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)

	if msgcontains(msg, "change") then
		npcHandler:say("Would you like to change Faintlight, Tidebound or Netherbound Orbs?", cid)
		npcHandler.topic[cid] = 0
		return true

	elseif npcHandler.topic[cid] == 0 then
		if msgcontains(msg, "faintlight") then
			npcHandler:say("Are you sure you want to exchange "..orbT1[2].." Faintlight Orbs for "..orbT1[3].." Tidebound Orb?", cid)
			npcHandler.topic[cid] = 1
		elseif msgcontains(msg, "tidebound") then
			npcHandler:say("Are you sure you want to exchange "..orbT2[2].." Tidebound Orbs for "..orbT2[3].." Netherbound Orb?", cid)
			npcHandler.topic[cid] = 2
		elseif msgcontains(msg, "netherbound") then
			npcHandler:say("Are you sure you want to exchange "..orbT3[2].." Netherbound Orbs for "..orbT3[3].." Blazefury Orb?", cid)
			npcHandler.topic[cid] = 3
		else
			npcHandler:say("I didn't understand that. Please say Faintlight, Tidebound or Netherbound.", cid)
			npcHandler.topic[cid] = 0
		end
		return true

	elseif npcHandler.topic[cid] == 1 then
		if msgcontains(msg, "yes") then
			if player:getItemCount(orbT1[1]) >= orbT1[2] then
				player:removeItem(orbT1[1], orbT1[2])
				player:addItem(orbT2[1], orbT1[3])
				npcHandler:say("Here is your Tidebound Orb. Would you like to change something else?", cid)
			else
				npcHandler:say("You do not have the required Orbs. Need help with something else?", cid)
			end
			npcHandler.topic[cid] = 0
		else
			npcHandler:say("No problem. Let me know if you change your mind.", cid)
			npcHandler.topic[cid] = 0
		end
		return true

	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, "yes") then
			if player:getItemCount(orbT2[1]) >= orbT2[2] then
				player:removeItem(orbT2[1], orbT2[2])
				player:addItem(orbT3[1], orbT2[3])
				npcHandler:say("Here is your Netherbound Orb. Want to make another change?", cid)
			else
				npcHandler:say("You do not have the required Orbs. Need anything else?", cid)
			end
			npcHandler.topic[cid] = 0
		else
			npcHandler:say("No problem. Let me know if you change your mind.", cid)
			npcHandler.topic[cid] = 0
		end
		return true

	elseif npcHandler.topic[cid] == 3 then
		if msgcontains(msg, "yes") then
			if player:getItemCount(orbT3[1]) >= orbT3[2] then
				player:removeItem(orbT3[1], orbT3[2])
				player:addItem(orbT4[1], orbT3[3])
				npcHandler:say("Here is your Blazefury Orb. Would you like to do more changes?", cid)
			else
				npcHandler:say("You do not have the required Orbs. Want to try another exchange?", cid)
			end
			npcHandler.topic[cid] = 0
		else
			npcHandler:say("Alright. Let me know if you want to try again.", cid)
			npcHandler.topic[cid] = 0
		end
		return true
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Welcome to the creature with the greatest orb expertise you could ever find, |PLAYERNAME|! Need to change some Rarity Orbs?")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
