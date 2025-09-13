empty_keychain_msg = "This keychain is empty."

function Item.setEmptyKeychain(self)
    self:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, empty_keychain_msg)
end

function Item.addKeyToKeychain(self, newKey)
    local keys = self:getKeychainList()

    -- Check if the key already exists in the keychain
    newKey = tonumber(newKey)
    for _, key in pairs(keys) do
        if tonumber(key) == newKey then
            return false, "Key already exists in the keychain."
        end
    end

    -- Add the new key to the keychain
    table.insert(keys, newKey)

    -- Update the item description with the new keychain
    local keychainStr = "(Keys:" .. table.concat(keys, ",") .. ")"
    self:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, keychainStr)

    return true, "Key added to the keychain successfully."
end

function Item.getKeychainList(self)
    local str = self:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)

    if not str or str == "" or str == empty_keychain_msg then
        return {} -- empty list
    end

    local keys = string.split(string.sub(str, 7, -2), ",")
    for key, value in pairs(keys) do
        keys[key] = tonumber(value)
    end
    return keys
end
