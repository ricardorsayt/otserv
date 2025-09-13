NpcTalk = {
    Process = function(Player, data)
        local npc = Npc(data.id)
        if npc then
            local bubble = npc:getSpeechBubble()
			if bubble == 2 then
				npc:dialog(Player, 1, "hi")
				npc:dialog(Player, 1, "trade")
			end
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
			local data = json_data.data
			if not data then
			    return
			end
            NpcTalk.Process(Player, data)
		end
	end,
}