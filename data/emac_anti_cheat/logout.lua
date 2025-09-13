function onLogout(player)
    db.query("DELETE FROM emac_anticheat WHERE account_id = " .. player:getAccountId())
    return true
end