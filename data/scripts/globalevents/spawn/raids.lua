local raids = {
	-- Weekly
	--Segunda-Feira
	['Monday'] = {		
		['09:00'] = {raidName = 'Demodras_venore'},
		['13:00'] = {raidName = 'Orc Backpack'},
		['10:00'] = {raidName = 'The Pale Count'},
		['04:00'] = {raidName = 'Furyosa'},
		['19:00'] = {raidName = 'Wild Horses'},
		['16:00'] = {raidName = 'Midnight Panther'},
		-- ['20:00'] = {raidName = 'avalon'}
	},

--Terça-Feira
	['Tuesday'] = {
		['16:00'] = {raidName = 'Midnight Panther'},
		['13:00'] = {raidName = 'Orc Backpack'},
		['08:00'] = {raidName = 'Zulazza the Corruptor'},
		['21:00'] = {raidName = 'Morgaroth'},
		['00:00'] = {raidName = 'Zushuka'},		
		-- ['20:00'] = {raidName = 'avalon'},
		['07:00'] = {raidName = 'Dharalion'}
	},

	--Quarta-Feira
	['Wednesday'] = {
		['12:00'] = {raidName = 'Draptor'},
		['13:00'] = {raidName = 'Orc Backpack'},
		['13:00'] = {raidName = 'Demodras_thais'},
		['18:00'] = {raidName = 'Chayenne'},
		['15:00'] = {raidName = 'Kongra'},
		['16:00'] = {raidName = 'Midnight Panther'},
		-- ['20:00'] = {raidName = 'avalon'},
		['09:00'] = {raidName = 'Wild Horses'}
	},

	--Quinta-Feira
	['Thursday'] = {
		['19:00'] = {raidName = 'Undead Cavebear'},
		['13:00'] = {raidName = 'Orc Backpack'},
		['20:00'] = {raidName = 'Arachir the Ancient One'},
		['21:00'] = {raidName = 'Necropharus'},
		['14:00'] = {raidName = 'The Welter'},
		['16:00'] = {raidName = 'Midnight Panther'},
		-- ['20:00'] = {raidName = 'avalon'},
		['07:00'] = {raidName = 'Dharalion'}
	},

	--Sexta-feira
	['Friday'] = {
		['06:00'] = {raidName = 'RatsThais'},
		['13:00'] = {raidName = 'Orc Backpack'},
		['11:15'] = {raidName = 'Demodras_darashia'},
		['15:00'] = {raidName = 'Orshabaal'},
		['12:00'] = {raidName = 'Omrafir'},
		['16:00'] = {raidName = 'Midnight Panther'},
		-- ['20:00'] = {raidName = 'avalon'},
		['06:00'] = {raidName = 'Fernfang'}
	},

	--Sábado
	['Saturday'] = {
		['20:00'] = {raidName = 'Draptor'},
		['13:00'] = {raidName = 'Orc Backpack'},
		['22:00'] = {raidName = 'white_pale'},
		['16:00'] = {raidName = 'Ghazbaran'},
		['15:00'] = {raidName = 'Hirintror'},
		['16:00'] = {raidName = 'Midnight Panther'},
		-- ['20:00'] = {raidName = 'avalon'},
		['09:00'] = {raidName = 'Wild Horses'}
	},

	--Domingo
	['Sunday'] = {
		['15:00'] = {raidName = 'Midnight Panther'},
		['13:00'] = {raidName = 'Orc Backpack'},
		['10:00'] = {raidName = 'Sir Valorcrest'},
		['05:00'] = {raidName = 'Zevelon Duskbringer'},
		['16:00'] = {raidName = 'Midnight Panther'},
		-- ['20:00'] = {raidName = 'avalon'},
		['23:00'] = {raidName = 'Ocyakao'},
		['20:00'] = {raidName = 'Draptor'},
		['15:00'] = {raidName = 'The Old Widow'}
	}
	
}

local spawnRaids = GlobalEvent("spawn raids")
function spawnRaids.onThink(interval, lastExecution, thinkInterval)
	local day, date = os.date('%A'), getRealDate()

	local raidDays = {}
	if raids[day] then
		raidDays[#raidDays + 1] = raids[day]
	end
	if raids[date] then
		raidDays[#raidDays + 1] = raids[date]
	end
	if #raidDays == 0 then
		return true
	end

	for i = 1, #raidDays do
		local settings = raidDays[i][getRealTime()]
		if settings and not settings.alreadyExecuted then
			Game.startRaid(settings.raidName)
			settings.alreadyExecuted = true
		end
	end
	return true
end

spawnRaids:interval(60000)
spawnRaids:register()
