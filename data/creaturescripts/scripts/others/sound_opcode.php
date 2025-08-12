function onExtendedOpcode(player, opcode, buffer)
    local SOUND_OPCODE = 85
    if opcode == SOUND_OPCODE then
        if buffer == "ready" then
            player:setStorageValue(90000, 1) -- Marca que este player est� pronto para receber sons
            print("DEBUG: Player " .. player:getName() .. " est� pronto para receber sons.")
        end
    end
end
