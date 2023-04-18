local autoloot_helper = TalkAction("!autoloot", "!loot", "/autoloot", "/loot")

local autoloot_text = [[
Autoloot Helper

Informações:
1) Autoloot não precisa ser ativado.
2) Os items já vão direto para seu personagem ao matar uma criatura.
3) Necessário configurar os Recipientes em "Manage Loot Containers".

Como configurar?
1) Para configurar, Você deve abrir o Cyclopedia e clicar em 
"Manage Loot Containers".
2) Escolha para quais containers cada tipo de loot vai.
3) (Opcional) Você pode configurar lista de Items permitidos (Accepted Loot) ou 
ignorados (Skipped Loot).

Autoloot em Party:
1) Caso um membro da party esteja em uma certa distancia do Leader, o loot vai para o Leader.

Gold Direct Bank:
1) Para jogadores VIP's, o Gold, Platinum e Crystal Coins são convertidos direto para o Bank Balance.]]

function autoloot_helper.onSay(player, words, param)
	player:popupFYI(autoloot_text)
	return false
end

autoloot_helper:register()