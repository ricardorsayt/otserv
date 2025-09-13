local talkaction = TalkAction("/checkskills")

function talkaction.onSay(_player, words, param)
    if not _player:getGroup():getAccess() then
        return true
    end

    if _player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
	
	logCommand(player, words, param)

    local name = param:trim()
    local player = Player(name)

    if not player then
        _player:sendCancelMessage("Player not found.")
        return false
    end

    local skills = {}
    for i = 0, 7 do
        local skill = player:getSkillLevel(i)
        skills[i] = skill
    end

    local msg = "Player: " .. player:getName() .. "\n"
    
    local level = player:getLevel()
    msg = msg .. "\nLevel: " .. level .. "\n"

    local magic = player:getSkillLevel(SKILL__MAGLEVEL)
    msg = msg .. "Magic Level: " .. magic .. "\n\nSkills: \n"

    for _skill, skill in pairs(skills) do
        msg = msg .. "    " ..getSkillName(_skill)..": ".. skill.."\n"
    end

    _player:popupFYI(msg)

    return false
end

talkaction:separator(" ")
talkaction:register()
