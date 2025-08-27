local event = Event()

event.onLook = function(self, thing, position, distance, description)
    local description = "You see " .. thing:getDescription(distance)

    -- KD system: só para players
    if thing:isPlayer() then
        local guid = thing:getGuid()
        local kills = 0
        local deaths = 0

        local query = db.storeQuery("SELECT COUNT(*) as total FROM player_killers WHERE player_id = " .. guid)
        if query then
            kills = result.getNumber(query, "total")
            result.free(query)
        end

        local query2 = db.storeQuery("SELECT COUNT(*) as total FROM player_deaths WHERE player_id = " .. guid)
        if query2 then
            deaths = result.getNumber(query2, "total")
            result.free(query2)
        end

        local pronoun = (thing:getSex() == PLAYERSEX_FEMALE) and "She" or "He"
        description = string.format("%s\n%s has killed [%d] players and died [%d] times.", description, pronoun, kills, deaths)
    end

    return description
end

event:register()
