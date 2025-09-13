local talkaction = TalkAction("/fixhouse")

function talkaction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if not param or param == "" then
        player:sendCancelMessage("House name or ID not found.")
        return false
    end

    local houseList = Game.getHouses()
    for _, house in ipairs(houseList) do
        if house:getId() == tonumber(param) or house:getName():lower() == param:lower() then
            house:setPaidUntil(os.time() + 24 * 60 * 60 * 30)
            player:sendCancelMessage("House updated next paid until.")
            
            local position = house:getExitPosition()
            player:teleportTo(position)

        end
    end

    player:sendCancelMessage("House name or ID not found.")
    return false
end

talkaction:separator(" ")
talkaction:register()
