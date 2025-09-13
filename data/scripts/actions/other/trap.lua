local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition)
	item:transform(item:getId() - 1)
	item:getPosition():sendMagicEffect(CONST_ME_POFF)
	return true
end

action:id(2579)
action:register()
