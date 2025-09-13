local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition)
    player:teleportTo({ x = 32068, y = 31875, z = 8 })
    return true
end

action:uid(4000)
action:register()
