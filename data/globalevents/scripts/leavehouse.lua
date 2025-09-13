function onHouseTransferItems(player, town)
    if player then
        local house = player:getHouse()
        if house then
            local tiles = house:getTiles()
            if tiles then
                local moveItems = {}
                local moveItemsByRotateClass = {}

                for _, tile in pairs(tiles) do
                    local items = tile:getItems()
                    
                    for _, item in pairs(items) do
                        local it = item:getType()
                        if it:isPickupable() then
                            table.insert(moveItems, item)
                        elseif it:isContainer() and not isDepot(item.uid) then
                            for _, _item in pairs(item:getItems()) do -- Move all items in container
                                table.insert(moveItems, _item)
                            end
                        elseif item:isPackable() then

                            local class = getItemRotateClassById(item:getId())

                            if class then
                                if not moveItemsByRotateClass[class] then
                                    moveItemsByRotateClass[class] = {}
                                end

                                table.insert(moveItemsByRotateClass[class], item)
                            else
                                item:pack()
                                table.insert(moveItems, item)
                            end

                        end
                    end
                end

                local playerDepot = player:getDepotLocker(town, true)
                -- move items from 'moveItems' to depot
                for _, item in pairs(moveItems) do
                    item:moveTo(playerDepot, FLAG_NOLIMIT)
                end

                -- move items from 'moveItemsByRotateClass' to depot
                for _, items in pairs(moveItemsByRotateClass) do
                    local count = table.count(items)
                    local item = items[1]
                    item:pack(nil, count)
                    item:moveTo(playerDepot, FLAG_NOLIMIT)

                    for i = 2, #items do -- remove others unnecessary items
                        items[i]:remove()
                    end
                end
            end
        end
    end
    return true
end