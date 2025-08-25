local config = {
    [2148] = {changeTo = 2152, changeToAmount = 1}, -- gold coin
    [2152] = {changeBack = 2148, changeBackAmount = 100, changeTo = 2160, changeToAmount = 1}, -- platinum coin
    [2160] = {changeBack = 2152, changeBackAmount = 100} -- crystal coin
}

local goldChange = Action()

function goldChange.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local coin = config[item.itemid]

    if not coin then
        return false
    end

    if item.type == 100 then -- Troca de 100 moedas de ouro para 1 de platina
        if coin.changeTo then
            player:addItem(coin.changeTo, coin.changeToAmount)
            item:remove()
            return true
        end
    end
    
    if item.type == 1 then -- Troca de 1 moeda de platina/cristal de volta para 100
        if coin.changeBack then
            player:addItem(coin.changeBack, coin.changeBackAmount)
            item:remove()
            return true
        end
    end

    return false
end

goldChange:id(2148, 2152, 2160)
goldChange:register()