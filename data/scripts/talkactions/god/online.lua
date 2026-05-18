-- data/talkactions/scripts/online.lua
-- Versão robusta: registra várias palavras e expõe função para outros scripts
local Online = {}
_G.Online = Online -- expõe globalmente caso queira chamar de outros scripts: Online.getCounts()

-- Função central que obtém contagens
function Online.getCounts()
    -- real players
    local real = 0
    if Game.getPlayers then
        local players = Game.getPlayers()
        if type(players) == "table" then
            real = #players
        end
    end

    -- total (reais + spoof) preferencialmente pela função C++ que inclui spoof
    local total = real
    if Game.getPlayersOnline then
        local ok, res = pcall(Game.getPlayersOnline)
        if ok and type(res) == "number" then
            total = res
        end
    end

    local spoof = total - real
    if spoof < 0 then spoof = 0 end

    return { real = real, spoof = spoof, total = total }
end

-- função auxiliar para enviar mensagens no formato desejado
local function sendPublic(player)
    local c = Online.getCounts()
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
        string.format("%d jogadores online no momento.", c.total)
    )
end

local function sendAdmin(player)
    local c = Online.getCounts()
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
        string.format("Real players: %d", c.real)
    )
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
        string.format("Spoof players: %d", c.spoof)
    )
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
        string.format("Total: %d jogadores online.", c.total)
    )
end

local function isAdmin(player)
    if not player then return false end
    local ok, grp = pcall(function() return player:getGroup() end)
    if ok and grp and type(grp.getAccess) == "function" then
        local ok2, can = pcall(function() return grp:getAccess() end)
        if ok2 and can then return true end
    end
    ok, acc = pcall(function() return player:getAccountType() end)
    if ok and type(acc) == "number" and acc >= ACCOUNT_TYPE_GOD then return true end
    return false
end

-- Handler comum, recebe um tipo que define comportamento
local function handleCommand(player, kind)
    -- kind == "public" or "admin"
    if kind == "admin" then
        if not isAdmin(player) then
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Você não tem permissão para usar esse comando.")
            return false
        end
        sendAdmin(player)
    else
        sendPublic(player)
    end
    return false
end

-- Registra múltiplos talkactions apontando para o mesmo handler
-- Observação: alguns cores não aceitam '/' dentro do nome do talkaction. Por isso registramos variações sem prefixos.
local function registerTalkAction(word, kind)
    local ta = TalkAction(word)
    function ta.onSay(player, words, param)
        return handleCommand(player, kind)
    end
    ta:register()
end

-- VARIAÇÕES PÚBLICAS (qualquer jogador)
registerTalkAction("!online", "public")
registerTalkAction("!status", "public")

-- VARIAÇÕES ADMIN (somente staff/GOD)
-- Tente registrar com e sem '/'.
-- Se o core não permitir '/', uma das chamadas pode falhar silenciosamente — mas as variantes sem '/' cobrem.
pcall(function() registerTalkAction("/online", "admin") end)
pcall(function() registerTalkAction("/status", "admin") end)
registerTalkAction("!onlineadmin", "admin")
registerTalkAction("onlineadmin", "admin")

-- Também expõe alguns atalhos de uso via função (outros scripts podem chamar)
-- Exemplo de uso em outro script: Online.getCounts() ou Online.sendAdmin(player)
function Online.sendPublic(player) return sendPublic(player) end
function Online.sendAdmin(player) return sendAdmin(player) end

return Online
