VIP_SYSTEM_CONFIG = {
	loot_bonus = 20, -- percent
	exp_bonus = 0.1,
	skill_bonus = 0,
	regem_bonus = 1.5,
	tournament_bonus = 0.5,
	death_lose_xp = 0,
	vip_over_msg = "your vip is over",
	vip_add_msg = "your vip is over",
	mounts = {
		[1] = {name="Crimson Ray"},
		[2] = {name="Azudocus"},
		[3] = {name="Platesaurian"},
		[4] = {name="Armoured War Horse"},
		[5] = {name="Carpacosaurus"},
		[6] = {name="Shadow Draptor"},
		[7] = {name="Coral Rhea"},
		[8] = {name="Savanna Ostrich"},
		[9] = {name="Eventide Nandu"},
		[10] = {name="Steelbeak"},
	},
	outfits = {
		[1] = {male = 472, female = 471},
		[2] = {male = 746, female = 745},
	}
}

if not VIP_SYSTEM_DATA then
	VIP_SYSTEM_DATA = {}
end

function removePidFromVipData(pid)
	if not pid or type(pid) ~= "number" then return false end
	if VIP_SYSTEM_DATA[pid] then
		VIP_SYSTEM_DATA[pid] = nil
	end
	return true
end

function Player.hasVipSkins(self)
	if not self then return false end
	local premiumOutfits = VIP_SYSTEM_CONFIG.outfits
	for c = 1, #premiumOutfits do
		if self:hasOutfit(premiumOutfits[c].male) or self:hasOutfit(premiumOutfits[c].female) then
			return true
		end
	end
	return false
end

function Player.removeVipSkins(self)
	local premiumOutfits = VIP_SYSTEM_CONFIG.outfits
	local premiumMounts = VIP_SYSTEM_CONFIG.mounts
	for c = 1, #premiumOutfits do
		self:removeOutfit(premiumOutfits[c].male)
		self:removeOutfit(premiumOutfits[c].female)		
	end
	for m = 1, #premiumMounts do
		self:removeMount(premiumMounts[m].name)
	end
end	

function Player.addVipSkins(self)
	local premiumOutfits = VIP_SYSTEM_CONFIG.outfits
	local premiumMounts = VIP_SYSTEM_CONFIG.mounts
	local sexo = self:getSex()
	for i = 1, #premiumOutfits do
		if sexo == 1 then
			self:addOutfit(premiumOutfits[i].male)
			self:addOutfitAddon(premiumOutfits[i].male, 3)
		else
			self:addOutfit(premiumOutfits[i].female)
			self:addOutfitAddon(premiumOutfits[i].female, 3)
		end
	end
	for m = 1, #premiumMounts do
		self:addMount(premiumMounts[m].name)
	end
end

function Player.getVipTime(self) -- armazena os time que vai acabar
	if not self then return false end
	if VIP_SYSTEM_DATA[self:getId()] then
		if VIP_SYSTEM_DATA[self:getId()].time then
			return VIP_SYSTEM_DATA[self:getId()].time
		end
	end
	if not VIP_SYSTEM_DATA[self:getId()] then
		VIP_SYSTEM_DATA[self:getId()] = {}
	end
	local storeResult = db.storeQuery(string.format('SELECT `vip_time` FROM `accounts` WHERE `id` = %i;', self:getAccountId()))
	VIP_SYSTEM_DATA[self:getId()].time = result.getDataInt(storeResult, "vip_time")
	return VIP_SYSTEM_DATA[self:getId()].time
end

function Player.setVipTime(self, time) -- seta os time que vai acabar
	if not self or type(time) ~= "number" or time < 0 then
		return false
	end
	if not VIP_SYSTEM_DATA[self:getId()] then
		VIP_SYSTEM_DATA[self:getId()] = {}
	end
	db.query("UPDATE `accounts` SET `vip_time` = " .. os.time() + time .. " WHERE `id` = " .. self:getAccountId())
	VIP_SYSTEM_DATA[self:getId()].time = os.time() + time 
	return true
end

function Player.removeVipTime(self) -- seta os time que vai acabar
	if not self  then
		return false
	end
	if not VIP_SYSTEM_DATA[self:getId()] then
		VIP_SYSTEM_DATA[self:getId()] = {}
	end
	db.query("UPDATE `accounts` SET `vip_time` = 0 WHERE `id` = " .. self:getAccountId())
	VIP_SYSTEM_DATA[self:getId()].time = 0
	addEvent(checkVipPrivillegesEvent, 1000, self:getId())
	return true
end

function Player.addVipTime(self, time)
	if not self or type(time) ~= "number" then return false end
	local atualTime = self:getVipTime() - os.time()
	if atualTime < 0 then
		atualTime = 0
	end
	if atualTime then
		self:setVipTime(atualTime + time)
		addEvent(checkVipPrivillegesEvent, 1000, self:getId())
		return true
	end
	return false
end

function Player.addVipDays(self, days)
	if not self or type(days) ~= "number" then return false end
	self:addVipTime(days * 24 * 60 * 60)
	return true
end

function Player.isVip(self)
	if not self then return false end
	local vipTime = self:getVipTime()
	if not vipTime then
		return false
	end
	if vipTime < 0 then
		return false
	end
	if vipTime <= os.time() then
		return false
	end
	return true
end

function Player.getVipTimeLeft(self)
	if not self then return false end -- tempoDoSistema + vipTime
	local timeToOver = self:getVipTime() - os.time()
	if timeToOver < 0 then
		return false
	end
	return convertTimeToText(timeToOver)
end

function checkVipPrivillegesEvent(playerId)
	local player = Player(playerId)
	if not player or player:isRemoved() then return false end
	
	-- Pass player vip info to source
	player:setCustomVip(player:isVip())
	
	if player:hasVipSkins() then
		if not player:isVip() then
			player:removeVipSkins()
			return true
		end
	else
		if player:isVip() then
			player:addVipSkins()
			return true
		end
	end
	return true
end
