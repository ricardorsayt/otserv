local CONFIG = {
    MINIMUM_SKILL_LEVEL = 10,
    SKILLS = {
        SKILL_CLUB,
        SKILL_SWORD,
        SKILL_AXE,
        SKILL_DISTANCE,
        SKILL_SHIELD,
        SKILL_FISHING,
        SKILL_FIST
    }
}

local talkAction = TalkAction("/addlostskills")

function talkAction.onSay(player, words, param)

    if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return true
    end
	
	logCommand(player, words, param)

    local split = param:splitTrimmed(",")

    local selectedPlayer = Player(split[1])
    if not selectedPlayer then
        player:sendCancelMessage("Player not found.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local percent = player:getDeathPenalty()

    if #split == 2 then
        if type(tonumber(split[2])) == "number" then
            percent = tonumber(split[2])
        end
    end

    -- Add Skills:
    for _, skill in pairs(CONFIG.SKILLS) do
        local currentSkillLevel = selectedPlayer:getSkillLevel(skill)
        local sumSkill = 0
        for i = CONFIG.MINIMUM_SKILL_LEVEL + 1, currentSkillLevel, 1 do
            sumSkill = sumSkill + selectedPlayer:getVocation():getRequiredSkillTries(skill, i)
        end

        selectedPlayer:addSkillTries(skill, sumSkill * (percent / 100))
    end

    --Add Magic Level:
    local sumMana = 0
    for i = 1, selectedPlayer:getMagicLevel(), 1 do
        sumMana = sumMana + selectedPlayer:getVocation():getRequiredManaSpent(i)
    end
    selectedPlayer:addManaSpent((sumMana - selectedPlayer:getManaSpent()) * (percent / 100))
    
    -- Add Experience:
    local exp = selectedPlayer:getExperience() * (percent / 100)
    selectedPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You were rewarded for your unjust death with an approximate value...")
    selectedPlayer:addExperience(exp)
    selectedPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    return false
end

talkAction:separator(" ")
talkAction:register()