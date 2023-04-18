if (BosstiarySystem == nil) then
    BosstiarySystem = {
        config = {
            enabled = true,
            todayBoostedKillIncrease = 3,
            killIncrease = 3,
            pointsToUnlockFirstSlot = 1,
            pointsToUnlockSecondSlot = 1500,
            loopUntilFindAvailableMonsterType = true, -- This one set to 'true' can print a few errors on log if your server doesn't have the specific boss for 'Today boosted'
            storages = {
                kills = 910000,
                cooldown = 950000,
                points = 900001,
                slot = {
                    first = 900002,
                    second = 900003
                }
            },
            bonus = {
                masteryBonus = 25,
                regular = {
                    [1] = {fromPoints = 0, toPoints = 250, getData = function(player, data)
                        if not(player) then
                            return 0
                        end

                        if (data == nil) then
                            data = BosstiarySystem.GetPlayerData(player)
                            if (data == nil) then
                                return 0
                            end
                        end

                        local base, pack = 25, 10
                        return base + math.floor(data.points / pack) -- That means 1 level for every 10 points
                    end},
                    [2] = {fromPoints = 250, toPoints = 1250, getData = function(player, data)
                        if not(player) then
                            return 0
                        end

                        if (data == nil) then
                            data = BosstiarySystem.GetPlayerData(player)
                            if (data == nil) then
                                return 0
                            end
                        end

                        local base, pack = 50, 20
                        local points = data.points - 250
                        return base + math.floor(points / pack) -- That means 1 level for every 20 points
                    end},
                    [3] = {fromPoints = 1250, toPoints = false, getData = function(player, data)
                        if not(player) then
                            return 0
                        end

                        if (data == nil) then
                            data = BosstiarySystem.GetPlayerData(player)
                            if (data == nil) then
                                return 0
                            end
                        end

                        local percentage = 0
                        local base, basepack, pack = 100, 25, 5
                        local points = data.points - 1250

                        while (points >= basepack) do
                            points = points - basepack
                            basepack = basepack + pack
                            percentage = percentage + 1
                        end

                        return base + percentage
                    end}
                }
            }
        },
        data = {
            bane = {
                kills = {
                    prowess = 25,
                    expertise = 100,
                    mastery = 300
                },
                points = {
                    prowess = 5,
                    expertise = 15,
                    mastery = 30
                }
            },
            archfoe = {
                kills = {
                    prowess = 5,
                    expertise = 20,
                    mastery = 60
                },
                points = {
                    prowess = 10,
                    expertise = 30,
                    mastery = 60
                }
            },
            nemesis = {
                kills = {
                    prowess = 1,
                    expertise = 3,
                    mastery = 5
                },
                points = {
                    prowess = 10,
                    expertise = 30,
                    mastery = 60
                }
            },
        },
        enums = {
            bytes = {
                cyclopedia = {
                    client = {
                        slots = 0xAF,
                        bosstiary = 0xAE,
                        action = 0xB0
                    },
                    server = {
                        slots = 0x62,
                        bosstiary = 0x73
                    }
                },
                cooldown = 0xBD,
                data = 0x61,
                resource = 0xEE
            },
            races = {
                bane = 0,
                archfoe = 1,
                nemesis = 2
            },
            slot = {
                today = 0,
                first = 1,
                second = 2,
                global = 3
            },
            grade = {
                none = -1,
                prowess = 0,
                expertise = 2,
                mastery = 3
            }
        },
        boosted = {
            bonus = {
                loot = 250,
                next = 0
            }
        },
        internal = {
            players = {}
        }
    }
end

dofile('data/modules/scripts/bosstiary/init.lua')

-- Protocol region
BosstiarySystem.SendLoginData = function(player)
    if not(player) then
        return false
    end

    if (player:getClient().version < 1200) then
        return true
    end

	local msg = NetworkMessage()
	msg:addByte(BosstiarySystem.enums.bytes.data)
	msg:addU16(BosstiarySystem.data.bane.kills.prowess)
	msg:addU16(BosstiarySystem.data.bane.kills.expertise)
	msg:addU16(BosstiarySystem.data.bane.kills.mastery)
	msg:addU16(BosstiarySystem.data.archfoe.kills.prowess)
	msg:addU16(BosstiarySystem.data.archfoe.kills.expertise)
	msg:addU16(BosstiarySystem.data.archfoe.kills.mastery)
	msg:addU16(BosstiarySystem.data.nemesis.kills.prowess)
	msg:addU16(BosstiarySystem.data.nemesis.kills.expertise)
	msg:addU16(BosstiarySystem.data.nemesis.kills.mastery)
	msg:addU16(BosstiarySystem.data.bane.points.prowess)
	msg:addU16(BosstiarySystem.data.bane.points.expertise)
	msg:addU16(BosstiarySystem.data.bane.points.mastery)
	msg:addU16(BosstiarySystem.data.archfoe.points.prowess)
	msg:addU16(BosstiarySystem.data.archfoe.points.expertise)
	msg:addU16(BosstiarySystem.data.archfoe.points.mastery)
	msg:addU16(BosstiarySystem.data.nemesis.points.prowess)
	msg:addU16(BosstiarySystem.data.nemesis.points.expertise)
	msg:addU16(BosstiarySystem.data.nemesis.points.mastery)
	msg:sendToPlayer(player)
    return true
end

BosstiarySystem.SendBosstiaryData = function(player, data)
    if not(player) then
        return false
    end

    if (player:getClient().version < 1200) then
        return true
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return 0
        end
    end

    if (data.bosstiaryData ~= nil) then
        data.bosstiaryData:sendToPlayer(player)
        return
    end

    data.bosstiaryData = NetworkMessage()
    data.bosstiaryData:addByte(BosstiarySystem.enums.bytes.cyclopedia.server.bosstiary)

    data.bosstiaryData:addU16(#BosstiarySystem.Bosses)
    for _, bossTable in ipairs(BosstiarySystem.Bosses) do
        data.bosstiaryData:addU32(bossTable.id)
        data.bosstiaryData:addByte(bossTable.type)
        data.bosstiaryData:addU32(BosstiarySystem.GetPlayerBossKills(player, bossTable.id, data))
        data.bosstiaryData:addByte(0x00) -- Unknown byte
    end

    data.bosstiaryData:sendToPlayer(player)
    return true
end

BosstiarySystem.SendBossSlotData = function(player, data)
    if not(player) then
        return false
    end

    if (player:getClient().version < 1200) then
        return true
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return false
        end
    end

	local isSlot1Unlocked = BosstiarySystem.IsSlotUnlocked(player, BosstiarySystem.enums.slot.first, data)
	local isSlot2Unlocked = BosstiarySystem.IsSlotUnlocked(player, BosstiarySystem.enums.slot.second, data)
	local isTodaySlotUnlocked = BosstiarySystem.IsSlotUnlocked(player, BosstiarySystem.enums.slot.today, data)

	local slot1State, slot1 = 0, nil
    if isSlot1Unlocked then
        slot1State = BosstiarySystem.GetSelectedCreatureOnSlot(player, BosstiarySystem.enums.slot.first, data)
        if (slot1State ~= 0) then
            slot1 = BosstiarySystem.GetSlotData(player, BosstiarySystem.enums.slot.first, data)
        end
    else
        slot1State = BosstiarySystem.config.pointsToUnlockFirstSlot
    end

	local slot2State, slot2 = 0, nil
    if isSlot2Unlocked then
        slot2State = BosstiarySystem.GetSelectedCreatureOnSlot(player, BosstiarySystem.enums.slot.second, data)
        if (slot2State ~= 0) then
            slot2 = BosstiarySystem.GetSlotData(player, BosstiarySystem.enums.slot.second, data)
        end
    else
        slot2State = BosstiarySystem.config.pointsToUnlockSecondSlot
    end

	local todaySlotState, todaySlot = 0, nil
    if isTodaySlotUnlocked then
        todaySlotState = BosstiarySystem.GetSelectedCreatureOnSlot(player, BosstiarySystem.enums.slot.today, data)
        if (todaySlotState ~= 0) then
            todaySlot = BosstiarySystem.GetSlotData(player, BosstiarySystem.enums.slot.today, data)
        end
    end

    local sendUnlockeds = false
    if ((isSlot1Unlocked and slot1State == 0) or (isSlot2Unlocked and slot2State == 0)) then
        sendUnlockeds = true
    end

    local loot = BosstiarySystem.GetLootBonus(player, BosstiarySystem.enums.slot.none, data)
	local msg = NetworkMessage()
	msg:addByte(BosstiarySystem.enums.bytes.cyclopedia.server.slots)
	msg:addU32(data.points)
	msg:addU32(BosstiarySystem.GetTotalPointsByCurrentPoints(data.points))
	msg:addU16(loot)
	msg:addU16(loot + 1) -- ?

	msg:addByte(isSlot1Unlocked and 1 or 0)
	msg:addU32(slot1State)
	if (slot1 ~= nil) then
		msg:addByte(slot1.type)
		msg:addU32(slot1.killeds)
		msg:addU16(slot1.loot)
		msg:addByte(slot1.kill)
		msg:addByte(slot1.enum)
		msg:addU32(slot1.price)
		msg:addByte(slot1.unactive and 1 or 0)
	end

	msg:addByte(isSlot2Unlocked and 1 or 0)
	msg:addU32(slot2State)
	if (slot2 ~= nil) then
		msg:addByte(slot2.type)
		msg:addU32(slot2.killeds)
		msg:addU16(slot2.loot)
		msg:addByte(slot2.kill)
		msg:addByte(slot2.enum)
		msg:addU32(slot2.price)
		msg:addByte(slot2.unactive and 1 or 0)
	end

	msg:addByte(isTodaySlotUnlocked and 1 or 0)
	msg:addU32(todaySlotState)
	if (todaySlot ~= nil) then
		msg:addByte(todaySlot.type)
		msg:addU32(todaySlot.killeds)
		msg:addU16(todaySlot.loot)
		msg:addByte(todaySlot.kill)
		msg:addByte(todaySlot.enum)
		msg:addU32(todaySlot.price)
		msg:addByte(todaySlot.unactive and 1 or 0)
	end

    msg:addByte((sendUnlockeds and #data.kills > 0) and 1 or 0)
    if (sendUnlockeds and #data.kills > 0) then
        msg:addU16(#data.kills)
        for _, boss in ipairs(data.kills) do
            msg:addU32(boss.id)
            msg:addByte(boss.type)
        end
    end

	msg:sendToPlayer(player)
    return true
end

BosstiarySystem.ParseIncomeMessageFromClient = function(player, msg, byte)
    local data = BosstiarySystem.GetPlayerData(player)
    if (data == nil) then
        return
    end

    if (player:getClient().version < 1200) then
        return true
    end

	if (byte == BosstiarySystem.enums.bytes.cyclopedia.client.bosstiary) then
		BosstiarySystem.SendBosstiaryData(player, data)
	elseif (byte == BosstiarySystem.enums.bytes.cyclopedia.client.slots) then
		BosstiarySystem.SendBossSlotData(player, data)
	elseif (byte == BosstiarySystem.enums.bytes.cyclopedia.client.action) then
		local slot = msg:getByte()
		local state = msg:getU32()
		if state == 0 then
            BosstiarySystem.PlayerRemoveCreatureFromSlot(player, slot, data)
		else
            BosstiarySystem.PlayerSetCreatureOnSlot(player, slot, state, data)
		end
	end

    BosstiarySystem.SendResourceBalance(player)
end

BosstiarySystem.SendPlayerBossCooldown = function(player)
    if not(player) then
        return false
    end

    if (player:getClient().version < 1200) then
        return true
    end

    local data = BosstiarySystem.GetPlayerData(player)
    if (data == nil) then
        return false
    end

	local msg = NetworkMessage()
	msg:addByte(BosstiarySystem.enums.bytes.cooldown)
    msg:addU16(#data.kills)
    for _, tracker in ipairs(data.kills) do
        msg:addU32(tracker.id)
        msg:addU64(tracker.time)
    end
	msg:sendToPlayer(player)
    return true
end

BosstiarySystem.SendResourceBalance = function(player)
    if (player:getClient().version < 1200) then
        return true
    end

	local msg = NetworkMessage()
	msg:addByte(BosstiarySystem.enums.bytes.resource)
	msg:addByte(0) -- Bank balance
	msg:addU64(player:getBankBalance())
	msg:sendToPlayer(player)
    return true
end

function onRecvbyte(player, msg, byte)
    if not(BosstiarySystem.config.enabled) then
        return
    end

    BosstiarySystem.ParseIncomeMessageFromClient(player, msg, byte)
end
-- end region

-- Initializer region
BosstiarySystem.InitializePlayerData = function(player)
    if (not(player) or not(BosstiarySystem.config.enabled)) then
        return false
    end

    BosstiarySystem.SendLoginData(player)
    local data = BosstiarySystem.GetPlayerData(player)
    if (data == nil) then
        return false
    end

    if (data.reload) then
        for _, boss in ipairs(BosstiarySystem.Bosses) do
            local kills = math.max(0, player:getStorageValue(BosstiarySystem.config.storages.kills + boss.id))
            if (kills > 0) then
                table.insert(data.kills, {id = boss.id,
                                        time = math.max(0, player:getStorageValue(BosstiarySystem.config.storages.cooldown + boss.id)),
                                        amount = kills})
            end
        end
        data.reload = false
    end

    BosstiarySystem.SendPlayerBossCooldown(player)

	player:sendTextMessage(MESSAGE_BOOSTED_CREATURE, "Today's boosted boss: " .. BosstiarySystem.boosted.name .. " \
	Boosted bosses contain more loot and count more kills for your Bosstiary.")
end

BosstiarySystem.InitializeGlobalData = function()
    if (#BosstiarySystem.Bosses == 0) then
        BosstiarySystem.config.enabled = false
        return
    end

	db.query([[CREATE TABLE IF NOT EXISTS `boosted_bosstiary` (
		`name` TEXT NOT NULL,
		`id` INT(16) NOT NULL,
		`date` INT(16) NOT NULL,
		`looktype` INT(16) NOT NULL,
		`looktypeex` INT(16) NOT NULL,
		`lookhead` INT(16) NOT NULL,
		`lookbody` INT(16) NOT NULL,
		`looklegs` INT(16) NOT NULL,
		`lookfeet` INT(16) NOT NULL,
		`addon` INT(16) NOT NULL,
		`lookmount` INT(16) NOT NULL
    )]])

    local databaseData = db.storeQuery("SELECT `name`, `id`, `date` FROM `boosted_bosstiary`")
    local databaseName = result.getStream(databaseData, "name")
    local databaseDate = result.getStream(databaseData, "date")
    local databaseId = result.getNumber(databaseData, "id")
    result.free(databaseData)

    BosstiarySystem.boosted.type = BosstiarySystem.enums.races.archfoe
    if (databaseDate == os.date("%d") and databaseId ~= 0 and databaseName ~= "") then
        BosstiarySystem.boosted.name = databaseName
        BosstiarySystem.boosted.id = databaseId
        return
    else
        db.query([[DELETE FROM `boosted_bosstiary`;]])
        local tries, maxTries = 0, 250
        math.randomseed(os.time())
        local monsterType = nil
        while (BosstiarySystem.boosted.id == nil or BosstiarySystem.boosted.id == 0) do
            tries = tries + 1
            if (tries >= maxTries) then
                local setBoss = true
                if (BosstiarySystem.config.loopUntilFindAvailableMonsterType) then
                    monsterType = MonsterType(BosstiarySystem.Bosses[1].name)
                    if (monsterType == nil) then
                        setBoss = false
                    end
                end

                if (setBoss) then
                    BosstiarySystem.boosted.name = BosstiarySystem.Bosses[1].name
                    BosstiarySystem.boosted.id = BosstiarySystem.Bosses[1].id
                    break
                end
            end

            local index = math.floor(math.random(1, #BosstiarySystem.Bosses))
            local boosted = BosstiarySystem.Bosses[index]
            if (boosted ~= nil and boosted.type == BosstiarySystem.boosted.type) then
                local setBoss = true
                if (BosstiarySystem.config.loopUntilFindAvailableMonsterType) then
                    monsterType = MonsterType(boosted.name)
                    if (monsterType == nil) then
                        setBoss = false
                    end
                end

                if (setBoss) then
                    BosstiarySystem.boosted.name = boosted.name
                    BosstiarySystem.boosted.id = boosted.id
                end
            end
        end

        if not(BosstiarySystem.config.loopUntilFindAvailableMonsterType) then
            monsterType = MonsterType(BosstiarySystem.boosted.name)
        end

        local lookType, lookTypeEx, lookHead, lookBody, lookLegs, lookFeet, lookAddons, lookMount = 0, 0, 0, 0, 0, 0, 0, 0
        local outfit = nil
        if (monsterType ~= nil) then
            outfit = monsterType:outfit()
            lookType = outfit.lookType
            lookTypeEx = outfit.lookTypeEx
            lookHead = outfit.lookHead
            lookBody = outfit.lookBody
            lookLegs = outfit.lookLegs
            lookFeet = outfit.lookFeet
            lookAddons = outfit.lookAddons
            lookMount = outfit.lookMount
        end

        db.query("INSERT INTO `boosted_bosstiary` \
        (`name`, `date`, `id`, `looktype`, `looktypeex`, `lookhead`, `lookbody`, `looklegs`, `lookfeet`, `addon`, `lookmount`) VALUES \
        (" .. db.escapeString(BosstiarySystem.boosted.name) .. ", '" .. os.date("%d") .. "', '" .. BosstiarySystem.boosted.id .. "', '" .. lookType .. "', '" .. lookTypeEx .. "', '" .. lookHead .. "', '" .. lookBody .. "', '" .. lookLegs .. "', '" .. lookFeet .. "', '" .. lookAddons .. "', '" .. lookMount .. "')")
    end
end
-- end region

-- Player region
BosstiarySystem.PlayerSetCreatureOnSlot = function(player, slot, id, data)
    if (not(player) or slot == 0 or id == 0) then
        return false
    end

    if (slot ~= BosstiarySystem.enums.slot.first and slot ~= BosstiarySystem.enums.slot.second) then
        return false
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return false
        end
    end

    if not(BosstiarySystem.IsSlotUnlocked(player, slot, data)) then
        return false
    end

    if (BosstiarySystem.GetSelectedCreatureOnSlot(player, slot, data) ~= 0) then
        return false
    end

    if (BosstiarySystem.GetPlayerBossKills(player, id, data) == 0) then
        return false
    end

    if (slot == BosstiarySystem.enums.slot.first) then
        data.slot1 = id
        player:setStorageValue(BosstiarySystem.config.storages.slot.first, id)
    elseif (slot == BosstiarySystem.enums.slot.second) then
        data.slot2 = id
        player:setStorageValue(BosstiarySystem.config.storages.slot.second, id)
    end

    BosstiarySystem.SendBossSlotData(player, data)
end -- ok

BosstiarySystem.PlayerRemoveMoney = function(player, price)
    if not(player) then
        return false
    end

    if (price == 0) then
        return true
    end

    -- Can only be paid with bank balance
    local bankBalance = player:getBankBalance()
    if (bankBalance >= price) then
        return player:setBankBalance(bankBalance - price)
    end

    return false
end -- ok

BosstiarySystem.PlayerRemoveCreatureFromSlot = function(player, slot, data)
    if (not(player) or slot == 0) then
        return false
    end

    if (slot ~= BosstiarySystem.enums.slot.first and slot ~= BosstiarySystem.enums.slot.second) then
        return false
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return false
        end
    end

    if not(BosstiarySystem.IsSlotUnlocked(player, slot, data)) then
        return false
    end

    if (BosstiarySystem.GetSelectedCreatureOnSlot(player, slot, data) == 0) then
        return false
    end

    local price = BosstiarySystem.GetPriceToRemove(player, slot, data)
    if (BosstiarySystem.PlayerRemoveMoney(player, price)) then
        data.removes = data.removes + 1
        if (slot == BosstiarySystem.enums.slot.first) then
            data.slot1 = 0
            player:setStorageValue(BosstiarySystem.config.storages.slot.first, 0)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have succesfully removed the selected boss on the first slot for " .. price .. " gps.")
        elseif (slot == BosstiarySystem.enums.slot.second) then
            data.slot2 = 0
            player:setStorageValue(BosstiarySystem.config.storages.slot.second, 0)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have succesfully removed the selected boss on the second slot for " .. price .. " gps.")
        end
    else
        player:sendCancelMessage("You don't have enought money to clean this boss slot. You need at least " .. price .. " gps.")
        return
    end

    BosstiarySystem.SendBossSlotData(player, data)
end -- ok

BosstiarySystem.GetPlayerData = function(player)
    if not(player) then
        return nil
    end

    for _, data in ipairs(BosstiarySystem.internal.players) do
        if (data.guid == player:getGuid()) then
            return data
        end
    end

    table.insert(BosstiarySystem.internal.players, {guid = player:getGuid(),
                                                    slot1 = math.max(0, player:getStorageValue(BosstiarySystem.config.storages.slot.first)),
                                                    slot2 = math.max(0, player:getStorageValue(BosstiarySystem.config.storages.slot.second)),
                                                    points = math.max(0, player:getStorageValue(BosstiarySystem.config.storages.points)),
                                                    removes = 1,
                                                    reload = true,
                                                    bosstiaryData = nil,
                                                    kills = {}
                                                })
    return BosstiarySystem.GetPlayerData(player)
end -- ok

BosstiarySystem.GetPlayerGradeByBossID = function(player, id, data)
    if not(player) then
        return BosstiarySystem.enums.grade.none
    end

    local boss = BosstiarySystem.GetBossTableById(id)
    if (boss == nil) then
        return BosstiarySystem.enums.grade.none
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return BosstiarySystem.enums.grade.none
        end
    end

    if (boss.type == BosstiarySystem.enums.races.bane) then
        if (data.points < BosstiarySystem.data.bane.kills.prowess) then
            return BosstiarySystem.enums.grade.none
        elseif (data.points < BosstiarySystem.data.bane.kills.expertise) then
            return BosstiarySystem.enums.grade.prowess
        elseif (data.points < BosstiarySystem.data.bane.kills.mastery) then
            return BosstiarySystem.enums.grade.expertise
        else
            return BosstiarySystem.enums.grade.mastery
        end
    elseif (boss.type == BosstiarySystem.enums.races.archfoe) then
        if (data.points < BosstiarySystem.data.archfoe.kills.prowess) then
            return BosstiarySystem.enums.grade.none
        elseif (data.points < BosstiarySystem.data.archfoe.kills.expertise) then
            return BosstiarySystem.enums.grade.prowess
        elseif (data.points < BosstiarySystem.data.archfoe.kills.mastery) then
            return BosstiarySystem.enums.grade.expertise
        else
            return BosstiarySystem.enums.grade.mastery
        end
    elseif (boss.type == BosstiarySystem.enums.races.nemesis) then
        if (data.points < BosstiarySystem.data.nemesis.kills.prowess) then
            return BosstiarySystem.enums.grade.none
        elseif (data.points < BosstiarySystem.data.nemesis.kills.expertise) then
            return BosstiarySystem.enums.grade.prowess
        elseif (data.points < BosstiarySystem.data.nemesis.kills.mastery) then
            return BosstiarySystem.enums.grade.expertise
        else
            return BosstiarySystem.enums.grade.mastery
        end
    else
        return BosstiarySystem.enums.grade.none
    end
end -- ok

BosstiarySystem.GetLootBonus = function(player, slot, data)
    if not(player) then
        return 0
    end

    if (slot == BosstiarySystem.enums.slot.today) then
        return BosstiarySystem.boosted.bonus.loot
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return 0
        end
    end


    local id, basePercent = BosstiarySystem.GetSelectedCreatureOnSlot(player, slot, data), 0
    if (id > 0 and BosstiarySystem.GetPlayerGradeByBossID(player, id, data) == BosstiarySystem.enums.grade.mastery) then
        basePercent = BosstiarySystem.config.bonus.masteryBonus
    end

    for _, bonusTable in ipairs(BosstiarySystem.config.bonus.regular) do
        if (data.points >= bonusTable.fromPoints and (not(bonusTable.toPoints) or data.points < bonusTable.toPoints)) then
            return (basePercent + bonusTable.getData(player, data))
        end
    end

    return basePercent
end -- ok

BosstiarySystem.GetSlotData = function(player, slot, data)
    if not(player) then
        return nil
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return nil
        end
    end

    local id = BosstiarySystem.GetSelectedCreatureOnSlot(player, slot, data)
    local loot = BosstiarySystem.GetLootBonus(player, slot, data)
    if (slot == BosstiarySystem.enums.slot.today) then
        return {id = id,
                type = BosstiarySystem.boosted.type,
                killeds = BosstiarySystem.GetPlayerBossKills(player, id, data),
                loot = loot,
                kill = BosstiarySystem.config.todayBoostedKillIncrease,
                enum = BosstiarySystem.boosted.type, -- ?
                price = 0, -- Can't remove the 'today boosted' creature, so lets send it 0
                unactive = false}
    elseif (slot == BosstiarySystem.enums.slot.first) then
        local selectedBoss = nil
        if (id ~= 0) then
            selectedBoss = BosstiarySystem.GetBossTableById(id)
        end
        return {id = id,
                type = selectedBoss ~= nil and selectedBoss.type or 0,
                killeds = BosstiarySystem.GetPlayerBossKills(player, id, data),
                loot = loot,
                kill = BosstiarySystem.config.killIncrease,
                enum = selectedBoss ~= nil and selectedBoss.type or 0,
                price = BosstiarySystem.GetPriceToRemove(player, slot, data),
                unactive = selectedBoss ~= nil and (string.lower(selectedBoss.name) == string.lower(BosstiarySystem.boosted.name)) or false}
    elseif (slot == BosstiarySystem.enums.slot.second) then
        local selectedBoss = nil
        if (id ~= 0) then
            selectedBoss = BosstiarySystem.GetBossTableById(id)
        end
        return {id = id,
                type = selectedBoss ~= nil and selectedBoss.type or 0,
                killeds = BosstiarySystem.GetPlayerBossKills(player, id, data),
                loot = loot,
                kill = BosstiarySystem.config.killIncrease,
                enum = selectedBoss ~= nil and selectedBoss.type or 0,
                price = BosstiarySystem.GetPriceToRemove(player, slot, data),
                unactive = selectedBoss ~= nil and (string.lower(selectedBoss.name) == string.lower(BosstiarySystem.boosted.name)) or false}
    end

    return nil
end -- ok

BosstiarySystem.GetPriceToRemove = function(player, slot, data)
    if not(player) then
        return 0
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return 0
        end
    end

    if (slot == BosstiarySystem.enums.slot.first and data.slot1 == BosstiarySystem.boosted.id) then
        return 0
    elseif (slot == BosstiarySystem.enums.slot.second and data.slot2 == BosstiarySystem.boosted.id) then
        return 0
    end

    return math.max(0, ((data.removes - 2) * 300000) + 100000)
end -- ok

BosstiarySystem.IsSlotUnlocked = function(player, slot, data)
    if not(player) then
        return false
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return nil
        end
    end

    if (slot == BosstiarySystem.enums.slot.today) then
        return BosstiarySystem.config.enabled and BosstiarySystem.boosted.id ~= 0
    elseif (slot == BosstiarySystem.enums.slot.first) then
        return data.points >= BosstiarySystem.config.pointsToUnlockFirstSlot
    elseif (slot == BosstiarySystem.enums.slot.second) then
        return data.points >= BosstiarySystem.config.pointsToUnlockSecondSlot
    end

    return false
end -- ok

BosstiarySystem.GetSelectedCreatureOnSlot = function(player, slot, data)
    if not(player) then
        return 0
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return BosstiarySystem.enums.grade.none
        end
    end

    if (slot == BosstiarySystem.enums.slot.today) then
        return BosstiarySystem.boosted.id
    elseif (slot == BosstiarySystem.enums.slot.global) then
        return 0
    elseif (slot == BosstiarySystem.enums.slot.first) then
        return data.slot1
    elseif (slot == BosstiarySystem.enums.slot.second) then
        return data.slot2
    end

    return -1
end -- ok

BosstiarySystem.GetPlayerBossKills = function(player, id, data)
    if not(player) then
        return 0
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return 0
        end
    end

    for _, boss in ipairs(data.kills) do
        if (boss.id == id) then
            return boss.amount
        end
    end

    return 0
end -- ok

BosstiarySystem.AddBossPoints = function(player, amount, data)
    if (not(player) or amount == 0) then
        return
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return 0
        end
    end

    local newCount = data.points + amount
    if (data.points <= BosstiarySystem.config.pointsToUnlockFirstSlot and newCount > BosstiarySystem.config.pointsToUnlockFirstSlot) then
        player:setStorageValue(BosstiarySystem.config.storages.slot.first, 0, true)
        data.slot1 = 0
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have succesfully unlocked the first bosstiary slot.")
    end
    if (data.points <= BosstiarySystem.config.pointsToUnlockSecondSlot and newCount > BosstiarySystem.config.pointsToUnlockSecondSlot) then
        player:setStorageValue(BosstiarySystem.config.storages.slot.second, 0, true)
        data.slot2 = 0
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have succesfully unlocked the second bosstiary slot.")
    end

    data.points = newCount
    player:setStorageValue(BosstiarySystem.config.storages.points, newCount, true)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, amount .. " boss points has been succesfully added into your boss points balance.")
end -- ok

BosstiarySystem.RemoveBossPoints = function(player, amount, data)
    if (not(player) or amount == 0) then
        return
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return 0
        end
    end

    data.points = math.max(0, data.points - amount)
    player:setStorageValue(BosstiarySystem.config.storages.points, data.points, true)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, amount .. " boss points has been succesfully removed from your boss points balance.")
end -- ok

BosstiarySystem.InternalPlayerAddBossKill = function(player, id, increasedTime, newCount, data)
    if (not(player) or id == 0 or increasedTime == 0) then
        return
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return
        end
    end

    for _, boss in ipairs(data.kills) do
        if (boss.id == id) then
            boss.time = os.time() + increasedTime
            boss.amount = newCount
            player:setStorageValue(BosstiarySystem.config.storages.cooldown + id, boss.time)
            player:setStorageValue(BosstiarySystem.config.storages.kills + id, boss.amount, true)
            BosstiarySystem.SendPlayerBossCooldown(player)
            data.bosstiaryData = nil
            return
        end
    end

    table.insert(data.kills, {id = id, amount = newCount, time = os.time() + increasedTime})
    player:setStorageValue(BosstiarySystem.config.storages.cooldown + id, os.time() + increasedTime)
    player:setStorageValue(BosstiarySystem.config.storages.kills + id, newCount, true)
    BosstiarySystem.SendPlayerBossCooldown(player)
    data.bosstiaryData = nil
end -- ok

BosstiarySystem.AddBossKillAmount = function(player, mtype)
    -- if (mtype == nil or not(mtype:isRewardBoss())) then
    if (mtype == nil) then
        return false
    end

    local bossTable = BosstiarySystem.GetBossTableByName(mtype:name())
    if bossTable == nil then
        return false
    end

    local data = BosstiarySystem.GetPlayerData(player)
    if (data == nil) then
        return false
    end

    local count = 0
    for _, boss in ipairs(data.kills) do
        if (boss.id == bossTable.id) then
            count = boss.amount
            break
        end
    end

    local newCount = count + (string.lower(mtype:getName()) == string.lower(BosstiarySystem.boosted.name) and BosstiarySystem.config.todayBoostedKillIncrease or BosstiarySystem.config.killIncrease)

    BosstiarySystem.InternalPlayerAddBossKill(player, bossTable.id, bossTable.cooldown, newCount, data)
    local expertise, mastery, prowess = BosstiarySystem.GetTypeKillsNedded(bossTable.type)
    if (count < prowess and newCount >= prowess) then
        player:sendTextMessage(MESSAGE_STATUS, "You have unlocked prowess status from " .. bossTable.name .. ".")
        if (bossTable.type == BosstiarySystem.enums.races.archfoe) then
            BosstiarySystem.AddBossPoints(player, BosstiarySystem.data.archfoe.points.prowess, data)
        elseif (bossTable.type == BosstiarySystem.enums.races.bane) then
            BosstiarySystem.AddBossPoints(player, BosstiarySystem.data.bane.points.prowess, data)
        elseif (bossTable.type == BosstiarySystem.enums.races.nemesis) then
            BosstiarySystem.AddBossPoints(player, BosstiarySystem.data.nemesis.points.prowess, data)
        end
    end

    if (count < expertise and newCount >= expertise) then
        player:sendTextMessage(MESSAGE_STATUS, "You have unlocked expertise status from " .. bossTable.name .. ".")
        if (bossTable.type == BosstiarySystem.enums.races.archfoe) then
            BosstiarySystem.AddBossPoints(player, BosstiarySystem.data.archfoe.points.expertise, data)
        elseif (bossTable.type == BosstiarySystem.enums.races.bane) then
            BosstiarySystem.AddBossPoints(player, BosstiarySystem.data.bane.points.expertise, data)
        elseif (bossTable.type == BosstiarySystem.enums.races.nemesis) then
            BosstiarySystem.AddBossPoints(player, BosstiarySystem.data.nemesis.points.expertise, data)
        end
    end

    if (count < mastery and newCount >= mastery) then
        player:sendTextMessage(MESSAGE_STATUS, "You have unlocked mastery status from " .. bossTable.name .. ".")
        if (bossTable.type == BosstiarySystem.enums.races.archfoe) then
            BosstiarySystem.AddBossPoints(player, BosstiarySystem.data.archfoe.points.mastery, data)
        elseif (bossTable.type == BosstiarySystem.enums.races.bane) then
            BosstiarySystem.AddBossPoints(player, BosstiarySystem.data.bane.points.mastery, data)
        elseif (bossTable.type == BosstiarySystem.enums.races.nemesis) then
            BosstiarySystem.AddBossPoints(player, BosstiarySystem.data.nemesis.points.mastery, data)
        end
    end

    return true
end -- ok

BosstiarySystem.GetPlayerBossLootBonus = function(player, name, data)
    if not(player) then
        return 1
    end

    name = string.lower(name)
    local boss = BosstiarySystem.GetBossTableByName(name)
    if (boss == nil) then
        return 1
    end

    if (data == nil) then
        data = BosstiarySystem.GetPlayerData(player)
        if (data == nil) then
            return 1
        end
    end

    if (BosstiarySystem.GetSelectedCreatureOnSlot(player, BosstiarySystem.enums.slot.today, data) == boss.id) then
        return BosstiarySystem.GetLootBonus(player, BosstiarySystem.enums.slot.today, data) / 100
    elseif (BosstiarySystem.GetSelectedCreatureOnSlot(player, BosstiarySystem.enums.slot.first, data) == boss.id) then
        return 1 + BosstiarySystem.GetLootBonus(player, BosstiarySystem.enums.slot.first, data) / 100
    elseif (BosstiarySystem.GetSelectedCreatureOnSlot(player, BosstiarySystem.enums.slot.second, data) == boss.id) then
        return 1 + BosstiarySystem.GetLootBonus(player, BosstiarySystem.enums.slot.second, data) / 100
    end

    return 1
end
-- end region

-- Static region
BosstiarySystem.GetTotalPointsByCurrentPoints = function(points)
    for _, bonus in ipairs(BosstiarySystem.config.bonus.regular) do
        if (points >= bonus.fromPoints) then
            if not(bonus.toPoints) then
                return bonus.fromPoints
            elseif (points < bonus.toPoints) then
                return bonus.toPoints
            end
        end
    end

    return 0
end

BosstiarySystem.GetBossTableById = function(id)
    for _, bossTable in ipairs(BosstiarySystem.Bosses) do
        if (bossTable.id == id) then
            return bossTable
        end
    end

    return nil
end

BosstiarySystem.GetBossTableByName = function(string)
    string = string:lower()
    for _, bossTable in ipairs(BosstiarySystem.Bosses) do
        if (bossTable.name ~= nil and string.lower(bossTable.name) == string) then
            return bossTable
        end
    end

    return nil
end

BosstiarySystem.GetTypeKillsNedded = function(type)
    if (type == BosstiarySystem.enums.races.bane) then
        return BosstiarySystem.data.bane.kills.expertise, BosstiarySystem.data.bane.kills.mastery, BosstiarySystem.data.bane.kills.prowess
    elseif (type == BosstiarySystem.enums.races.archfoe) then
        return BosstiarySystem.data.archfoe.kills.expertise, BosstiarySystem.data.archfoe.kills.mastery, BosstiarySystem.data.archfoe.kills.prowess
    elseif (type == BosstiarySystem.enums.races.nemesis) then
        return BosstiarySystem.data.nemesis.kills.expertise, BosstiarySystem.data.nemesis.kills.mastery, BosstiarySystem.data.nemesis.kills.prowess
    end

    return 0, 0, 0
end

BosstiarySystem.IsLootBoosted = function(itemId)
    if (itemId == nil or itemId == 0) then
        return false
    end

    local itemType = ItemType(itemId)
    if (itemType == nil) then
        return false
    end

    if (itemType:getArmor() ~= 0) then
        return true
    end

    if (itemType:getAttack() ~= 0) then
        return true
    end

    if (itemType:getDefense() ~= 0) then
        return true
    end

    if (itemType:getElementDamage() ~= 0) then
        return true
    end

    if (itemType:getSpeed() ~= 0) then
        return true
    end

    if (itemType:getTransformEquipId() ~= 0) then
        return true
    end

    if (itemType:getTransformDeEquipId() ~= 0) then
        return true
    end

    return false
end
-- end region