function onThink(monster, interval)
    if monster:getTarget() and monster:getTarget():isMonster() then
        return true
    end

    local specs = Game.getSpectators(monster:getPosition(), false, false, 5, 5, 5, 5)
    for _, spec in pairs(specs) do
        if spec:getName() == "Grinch" then
            monster:setTarget(spec)
            monster:selectTarget(spec)
            return true
        end
    end
end