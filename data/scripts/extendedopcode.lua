function onExtendedOpcode(player, opcode, buffer)
    -- opcode: número do opcode recebido
    -- buffer: dados enviados pelo cliente
    if opcode == 0 then
        -- apenas para debug
        print("Extended opcode 0 recebido: " .. buffer)
        -- aqui você pode enviar de volta algo para o cliente
        player:sendExtendedOpcode(0, "pong")
    end
end
