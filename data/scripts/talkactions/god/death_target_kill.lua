local TalkAction = TalkAction("/deth")

local SPAWN_DELAY = 500
local monsterSpawnLimit = 1000
local spawnData = {}

local function spawnNext(playerId)
    local data = spawnData[playerId]
    if not data then return end

    local player = Player(playerId)
    if not player then
        spawnData[playerId] = nil
        return
    end

    if data.count >= data.goal then
        spawnData[playerId] = nil
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
            "Concluído: spawn de " .. data.count .. " " .. data.monster .. "(s).")
        return
    end

    local pos = player:getPosition()
    local monster = Game.createMonster(data.monster, pos)
    if not monster then
        player:sendCancelMessage("Falha ao spawnar: " .. data.monster)
        spawnData[playerId] = nil
        return
    end

    -- Reduz o monstro para 1 de vida
    local hp = monster:getHealth()
    if hp > 1 then
        monster:addHealth(1 - hp)
    end

    data.count = data.count + 1
    addEvent(spawnNext, SPAWN_DELAY, playerId)
end

local function parseParam(param)
    local namePart, numPart = param:match("^(.-)%s+(%d+)$")
    return namePart and namePart:match("^%s*(.-)%s*$"), tonumber(numPart)
end

function TalkAction.onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        player:sendCancelMessage("Apenas administradores podem usar.")
        return false
    end

    local monsterName, goal = parseParam(param)
    if not monsterName or not goal or goal <= 0 then
        player:sendCancelMessage("Uso: /deth <nome do monstro> <quantidade>")
        return false
    end

    if goal > monsterSpawnLimit then
        player:sendCancelMessage("Limite máximo de spawn é " .. monsterSpawnLimit .. ".")
        return false
    end

    local playerId = player:getId()
    spawnData[playerId] = {
        monster = monsterName,
        goal = goal,
        count = 0
    }

    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
        "Iniciando spawn de " .. goal .. " " .. monsterName .. "(s) com 1 de vida...")
    spawnNext(playerId)
    return false
end

TalkAction:access(true)
TalkAction:separator(" ")
TalkAction:register()
