function onExtendedOpcode(player, opcode, buffer)
    -- Apenas debug
    print("[ExtendedOpcode] Recebido do cliente: opcode=" .. opcode .. ", buffer=" .. buffer)
    return true
end
