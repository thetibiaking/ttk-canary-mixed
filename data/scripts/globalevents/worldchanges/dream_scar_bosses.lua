local config = {
	['Monday'] = 'Alptramun',
	['Tuesday'] = 'Izcandar the Banished',
	['Friday'] = 'Malofur Mangrinder',
	['Thursday'] = 'Maxxenius',
	['Wednesday'] = 'Malofur Mangrinder',
	['Saturday'] = 'Plagueroot', 
	['Sunday'] = 'Maxxenius' 
} 

 
local spawnByDay = true


local spawnScars = GlobalEvent("spawnScars")

function spawnScars.onStartup()
	if spawnByDay then
		print('>> [dream courts] loaded: ' .. config[os.date('%A')])
		Game.loadMap('data/world/Dream_Scar/' .. config[os.date('%A')] ..'.otbm')
	else
		 print('>> dream courts boss: not boss today')
	end
	return true
end

spawnScars:register()