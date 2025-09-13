function onUpdateDatabase()
	print("> Updating database to version 4 (adding battlepass blob to players table)")
	db.query("ALTER TABLE `players` ADD `battlepass` blob")
	return true
end