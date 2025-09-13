Modal = {
    Data = {
		Opcode = 90,
		Modules = {}
	},

    Send = function(Player, Message)
		if Player then
			Player:sendExtendedOpcode(Modal.Data.Opcode, Message)
		end
	end,

    Read = function(Player, Message)

		local json_status, json_data =
			pcall(
			function()
			return json.decode(Message)
			end
		)

		if json_status then
			local action = json_data.action
			local data = json_data.data
			if not action or not data then
			return
			end
			if Modal.Data.Modules[action] then
				Modal.Data.Modules[action].Manager(Player, data)
			else
				print("Module: " ..  action .. " not found")
			end
		else
			local Data = Message:split(",")
			if Modal.Data.Modules[Data[1]] then
				Modal.Data.Modules[Data[1]].Manager(Player, Message)
			else
				print("Module: " .. Data[1] .. " not found")
			end
		end

	end,

	NewModal = function(Module, Manager)
		local NewModal = {Name = Module, Manager = Manager}
		Modal.Data.Modules[Module] = NewModal
	end
}