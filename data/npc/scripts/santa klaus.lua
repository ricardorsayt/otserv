local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local count = {}
local transfer = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

local topic = {}

function greetCallback(cid)
	local player = Player(cid)
	local maxAmount = player:getStorageValue(6127)
	selfSay("Ho-ho-ho, Merry Christmas, ".. getCreatureName(cid) .."! Have you been a good boy this year?")
	topic[cid] = 0 -- padrão
	return true
end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)

	local maxAmount = player:getStorageValue(6127)
	local delay = player:getStorageValue(6128)

	if topic[cid] == 0 then
		if not maxAmount or maxAmount < 1 then
			selfSay("I'm glad you've been a good boy! But I have some sad news: it seems that Christmas this year may not happen. The Evil Grinch and his minions are scattered around the world, ready to ruin everything. I asked the elves for help, but they're not enough. Could you help them defeat some Grinches and defeat the Evil Grinch so we can have a happy Christmas for everyone?")
			topic[cid] = 1
		elseif delay and (delay - os.time()) > 0 then
			selfSay("Hey, you saved our christmas! You definetly are a good boy, thanks again! I will call you when the christmas be in dangerous.")
			topic[cid] = 2
		elseif delay and (delay - os.time()) <= 0 then
			selfSay("Hey, you again! Thanks for helping me before! Unfortunally, the Evil Grinch and his minions are scattered around the world, ready to ruin everything. Could you help the elves defeat some Grinches and defeat the Evil Grinch again?")
			topic[cid] = 1
		elseif maxAmount == 65000 then
			selfSay("Hey, what are you still doing here? We have an urgent situtation, the elfs needs your help, go hunt the grinches!")
			topic[cid] = 2
		elseif maxAmount == 65001 then
			selfSay("Wow, you have defeated a lot of grinches, thank you! Now you can go to my home, the elfs will guide you to the Evil Grinch's lair.")
			topic[cid] = 2
		elseif maxAmount == 65002 or maxAmount == 65003 then
			selfSay("Hey, you saved our christmas! You definetly are a good boy, thanks again! I will call you when the christmas be in dangerous.")
			topic[cid] = 2
		else
			selfSay("What are you still doing here? I have an urgent situtation, the elfs needs your help save our christmas!")
			topic[cid] = 2
		end
	elseif topic[cid] == 1 then
		
		if msgcontains(msg, "yes") then
			selfSay("Great! The children around the world will have a happy Christmas because of you. You just need to hunt down a few Grinches before you can confront the Evil Grinch. When you're ready, come to my house and the Elves will show you the way to the Evil Grinch's lair.")
			
			player:setStorageValue(6127, 65000)
		elseif msgcontains(msg, "no") then
			selfSay("Well, you can always come back if you change your mind.")
		else
			selfSay("Yes or no?")
		end

		topic[cid] = 2
	else
		selfSay("What are you still doing here? I have an urgent situtation, the elfs needs your help save our christmas!")
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())