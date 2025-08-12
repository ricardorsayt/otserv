-- data/creaturescripts/scripts/magic_sound.lua

-- Define o opcode para enviar comandos de som ao cliente
local UPDATESOUND_OPCODE = 85

function onSay(player, words, param)
    -- Obtém o texto da magia em letras minúsculas para comparacao
    local normalizedWords = words:lower()
    
    -- Mensagem de depuracao para verificar se a funcao onSay esta sendo executada
    print("DEBUG: Script magic_sound.lua acionado. Palavras ditas: " .. normalizedWords)

    -- Verifica se a magia usada foi "exura"
    if normalizedWords == "exura" then
        -- Define o caminho do som no cliente
        local sound = "wand.ogg"
        -- Envia o comando para o cliente tocar o som
        doSendPlayerExtendedOpcode(player:getId(), UPDATESOUND_OPCODE, sound .. "|false")
        print("DEBUG: Comando de som para 'exura' enviado ao cliente.")
    end
    
    return false -- Retorna false para que o servidor processe a magia normalmente
end