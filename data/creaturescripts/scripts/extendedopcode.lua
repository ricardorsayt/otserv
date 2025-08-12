-- Captura o extended opcode enviado pelo cliente
function onExtendedOpcode(player, opcode, buffer)
    if opcode == 110 then
        if buffer == "open" then
            print("[ExtendedOpcode] Cliente pediu para abrir a janela de tasks.")

            -- Verifica se a fun��o sendTasksData existe no seu tasks.lua
            if _G.sendTasksData then
                sendTasksData(player)
            else
                print("[ExtendedOpcode] ERRO: fun��o sendTasksData n�o encontrada.")
            end
        else
            print("[ExtendedOpcode] Recebido do cliente (opcode 0): " .. (buffer or ""))
        end
    end
end
