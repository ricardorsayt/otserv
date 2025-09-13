function onGMTeleport(player, opcode, buffer) 
	if not player:getGroup():getAccess() then
		return
	end
    local json_data = json.decode(buffer)
    local p = json_data.data.position
    local position = Position(p.x, p.y, p.z)
    player:teleportTo(position)
end