local effects = {
    {position = Position(32298, 33037, 7), text = 'Ilha de NPCs'}, --- trainer thais
	{position = Position(1062, 1018, 7), text = 'Adventurers'}, -- area vip thais
	{position = Position(1064, 1018, 7), text = 'Treinos'}, -- npcs thais temple
	{position = Position(1066, 1018, 7), text = 'Bosses & Eventos'}, --- event room thais
    {position = Position(1057, 1037, 7), text = 'HUNTs'},
	{position = Position(1058, 1026, 7), text = 'EXIT'},
	{position = Position(17065, 16904, 7), text = 'Elfs Fogo'},
	{position = Position(17065, 16902, 7), text = 'Elfs Gelo'},
	{position = Position(17065, 16900, 7), text = 'Ferumbras HUNT'},
	{position = Position(17065, 16898, 7), text = 'TRUE Asure'},
	{position = Position(17068, 16898, 7), text = 'Catacombs'},
	{position = Position(17071, 16898, 7), text = 'Nightmare Isles'},
	{position = Position(17074, 16898, 7), text = 'Roshamull DP'},
	{position = Position(17077, 16898, 7), text = 'Prison - Roshamuul'},
	{position = Position(17076, 16900, 7), text = 'Poi'},
	{position = Position(17076, 16902, 7), text = 'Inquisition'},
	{position = Position(17076, 16904, 7), text = 'Ruins of Nuur'},
	{position = Position(17076, 16906, 7), text = 'Forest of Life'},
	
  }

local textoEvent = GlobalEvent("textoEvent")

function textoEvent.onThink(interval)
    for i = 1, #effects do
        local settings = effects[i]
        local spectators = Game.getSpectators(settings.position, false, true, 7, 7, 5, 5)
        if #spectators > 0 then
            if settings.text then
                for i = 1, #spectators do
                    spectators[i]:say(settings.text, TALKTYPE_MONSTER_SAY, false, spectators[i], settings.position)
                end
            end
            if settings.effect then
                settings.position:sendMagicEffect(settings.effect)
            end
        end
    end
   return true
end

textoEvent:interval(4500)
textoEvent:register()


