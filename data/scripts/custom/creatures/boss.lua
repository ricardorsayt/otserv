local bossNames = {"Grorlam","Necropharus","Orshabaal","yeti","The Horned Fox","General Murius","Fernfang","The Evil Eye","Demodras","The Old Widow","Dharalion"}

function Game.loadBosses()
    -- Load monsterType to boss
    for _, name in pairs(bossNames) do
        local monsterType = MonsterType(name)
        if monsterType then
            monsterType:isBoss(true)
        end
    end
end
