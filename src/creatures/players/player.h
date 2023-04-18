/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2019  Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#ifndef SRC_PLAYER_H_
#define SRC_PLAYER_H_

#include "account/account.hpp"
#include "items/containers/container.h"
#include "creatures/creature.h"
#include "items/cylinder.h"
#include "items/containers/depot/depotchest.h"
#include "items/containers/depot/depotlocker.h"
#include "utils/enums.h"
#include "grouping/familiars.h"
#include "game/gamestore.h"
#include "grouping/groups.h"
#include "grouping/guild.h"
#include "imbuements/imbuements.h"
#include "items/containers/inbox/inbox.h"
#include "io/ioguild.h"
#include "io/ioprey.h"
#include "creatures/appearance/mounts/mounts.h"
#include "creatures/appearance/outfit/outfit.h"
#include "grouping/party.h"
#include "server/network/protocol/protocolgame.h"
#include "items/containers/rewards/reward.h"
#include "items/containers/rewards/rewardchest.h"
#include "map/town.h"
#include "vocations/vocation.h"
#include "creatures/npc/npc.h"
#include "creatures/combat/spells.h"

class House;
class NetworkMessage;
class Weapon;
class ProtocolGame;
class Npc;
class Party;
class SchedulerTask;
class Bed;
class Guild;
class Imbuement;
class PreySlot;
class TaskHuntingSlot;
class Spell;

enum skillsid_t {
	SKILLVALUE_LEVEL = 0,
	SKILLVALUE_TRIES = 1,
	SKILLVALUE_PERCENT = 2,
};

enum fightMode_t : uint8_t {
	FIGHTMODE_ATTACK = 1,
	FIGHTMODE_BALANCED = 2,
	FIGHTMODE_DEFENSE = 3,
};

enum pvpMode_t : uint8_t {
	PVP_MODE_DOVE = 0,
	PVP_MODE_WHITE_HAND = 1,
	PVP_MODE_YELLOW_HAND = 2,
	PVP_MODE_RED_FIST = 3,
};

enum tradestate_t : uint8_t {
	TRADE_NONE,
	TRADE_INITIATED,
	TRADE_ACCEPT,
	TRADE_ACKNOWLEDGE,
	TRADE_TRANSFER,
};

enum PlayerAsyncOngoingTaskFlags : uint64_t {
	PlayerAsyncTask_Highscore = 1 << 0,
	PlayerAsyncTask_RecentDeaths = 1 << 1,
	PlayerAsyncTask_RecentPvPKills = 1 << 2
};

struct VIPEntry {
	VIPEntry(uint32_t initGuid, std::string initName, std::string initDescription, uint32_t initIcon, bool initNotify) :
		guid(initGuid), name(std::move(initName)), description(std::move(initDescription)), icon(initIcon), notify(initNotify) {}

	uint32_t guid;
	std::string name;
	std::string description;
	uint32_t icon;
	bool notify;
};

struct OpenContainer {
	Container* container;
	uint16_t index;
};

struct OutfitEntry {
	constexpr OutfitEntry(uint16_t initLookType, uint8_t initAddons) : lookType(initLookType), addons(initAddons) {}

	uint16_t lookType;
	uint8_t addons;
};

struct FamiliarEntry {
	constexpr explicit FamiliarEntry(uint16_t initLookType) : lookType(initLookType) {}
	uint16_t lookType;
};

struct Skill {
	uint64_t tries = 0;
	uint16_t level = 10;
	double_t percent = 0;
};

struct Kill {
	uint32_t target;
	time_t time;
	bool unavenged;

	Kill(uint32_t _target, time_t _time, bool _unavenged) : target(_target), time(_time), unavenged(_unavenged) {}
};

using MuteCountMap = std::map<uint32_t, uint32_t>;

static constexpr int32_t PLAYER_MAX_SPEED = 10000;
static constexpr int32_t PLAYER_MIN_SPEED = 10;
static constexpr int32_t PLAYER_SOUND_HEALTH_CHANGE = 10;

class Player final : public Creature, public Cylinder
{
	public:
		explicit Player(ProtocolGame_ptr p);
		~Player();

		// non-copyable
		Player(const Player&) = delete;
		Player& operator=(const Player&) = delete;

		Player* getPlayer() override {
			return this;
		}
		const Player* getPlayer() const override {
			return this;
		}

		void setID() override {
			if (id == 0) {
				if (guid != 0) {
					id = 0x10000000 + guid;
				}
			}
		}

		static MuteCountMap muteCountMap;

		const std::string& getName() const override {
			return name;
		}
		void setName(std::string newName) {
			this->name = std::move(newName);
		}
		const std::string& getNameDescription() const override {
			return name;
		}
		std::string getDescription(int32_t lookDistance) const override;

		CreatureType_t getType() const override {
			return CREATURETYPE_PLAYER;
		}

		uint8_t getCurrentMount() const;
		void setCurrentMount(uint8_t mountId);
		bool isMounted() const {
			return defaultOutfit.lookMount != 0;
		}
		bool toggleMount(bool mount);
		bool tameMount(uint8_t mountId);
		bool untameMount(uint8_t mountId);
		bool hasMount(const Mount* mount) const;
		void dismount();

		void sendFYIBox(const std::string& message) {
			if (client) {
				client->sendFYIBox(message);
			}
		}

		void sendHotkeyItemMap() {
			if (client) {
				client->sendHotkeyItems();
			}
		}

		void setHotkeyItemMap(std::multimap<uint16_t, uint8_t>& items);
		const std::multimap<uint16_t, uint8_t>& getHotkeyItemMap() const {
			return hotkeyItems;
		}

		void sendInvetoryItems();

		void BestiarysendCharms() {
			if (client) {
				client->BestiarysendCharms();
			}
		}
		void addBestiaryKillCount(uint16_t raceid, uint32_t amount)
		{
			uint32_t oldCount = getBestiaryKillCount(raceid);
			uint32_t key = STORAGEVALUE_BESTIARYKILLCOUNT + raceid;
			addStorageValue(key, static_cast<int32_t>(oldCount + amount), true);
		}
		uint32_t getBestiaryKillCount(uint16_t raceid) const
		{
			int32_t cp = 0;
			uint32_t key = STORAGEVALUE_BESTIARYKILLCOUNT + raceid;
			getStorageValue(key, cp);
			return cp > 0 ? static_cast<uint32_t>(cp) : 0;
		}

		void setGUID(uint32_t newGuid) {
			this->guid = newGuid;
		}
		uint32_t getGUID() const {
			return guid;
		}
		bool canSeeInvisibility() const override {
			return hasFlag(PlayerFlag_CanSenseInvisibility) || group->access;
		}

		void setDailyReward(uint8_t reward) {
			this->isDailyReward = reward;
		}

		void removeList() override;
		void addList() override;
		void kickPlayer(bool displayEffect);

		static uint64_t getExpForLevel(int32_t lv) {
			lv--;
			return ((50ULL * lv * lv * lv) - (150ULL * lv * lv) + (400ULL * lv)) / 3ULL;
		}

		uint16_t getStaminaMinutes() const {
			return staminaMinutes;
		}


		bool addOfflineTrainingTries(skills_t skill, uint64_t tries);

		void addOfflineTrainingTime(int32_t addTime) {
			offlineTrainingTime = std::min<int32_t>(12 * 3600 * 1000, offlineTrainingTime + addTime);
		}
		void removeOfflineTrainingTime(int32_t removeTime) {
			offlineTrainingTime = std::max<int32_t>(0, offlineTrainingTime - removeTime);
		}
		int32_t getOfflineTrainingTime() const {
			return offlineTrainingTime;
		}

		int32_t getOfflineTrainingSkill() const {
			return offlineTrainingSkill;
		}
		void setOfflineTrainingSkill(int32_t skill) {
			offlineTrainingSkill = skill;
		}

		uint64_t getBankBalance() const {
			return bankBalance;
		}
		void setBankBalance(uint64_t balance) {
			bankBalance = balance;
		}

		Guild* getGuild() const {
			return guild;
		}
		void setGuild(Guild* guild);

		  GuildRank_ptr getGuildRank() const {
			return guildRank;
		}
		void setGuildRank(GuildRank_ptr newGuildRank) {
			guildRank = newGuildRank;
		}

		bool isGuildMate(const Player* player) const;

		const std::string& getGuildNick() const {
			return guildNick;
		}
		void setGuildNick(std::string nick) {
			guildNick = nick;
		}

		bool isInWar(const Player* player) const;
		bool isInWarList(uint32_t guild_id) const;

		void setLastWalkthroughAttempt(int64_t walkthroughAttempt) {
			lastWalkthroughAttempt = walkthroughAttempt;
		}
		void setLastWalkthroughPosition(Position walkthroughPosition) {
			lastWalkthroughPosition = walkthroughPosition;
		}

		Inbox* getInbox() const {
			return inbox;
		}

		uint32_t getClientIcons() const;

		const GuildWarVector& getGuildWarVector() const {
		return guildWarVector;
		}

		std::list<MonsterType*> getBestiaryTrackerList() const {
			return BestiaryTracker;
		}

		void addBestiaryTrackerList(MonsterType* mtype) {
			if (client) {
				auto it = std::find(BestiaryTracker.begin(), BestiaryTracker.end(), mtype);
				if (it == BestiaryTracker.end()) {
					BestiaryTracker.push_front(mtype);
				} else {
					BestiaryTracker.remove(mtype);
				}
				client->refreshBestiaryTracker(BestiaryTracker);
			}
		}

		void sendBestiaryEntryChanged(uint16_t raceid) {
			if (client) {
				client->sendBestiaryEntryChanged(raceid);
			}
		}

		void refreshBestiaryTracker(std::list<MonsterType*> trackerList) {
			if (client) {
				client->refreshBestiaryTracker(trackerList);
			}
		}

		Vocation* getVocation() const {
			return vocation;
		}

		OperatingSystem_t getOperatingSystem() const {
			return operatingSystem;
		}
		void setOperatingSystem(OperatingSystem_t clientos) {
			operatingSystem = clientos;
		}

		uint32_t getProtocolVersion() const {
			if (!client) {
				return 0;
			}

			return client->getVersion();
		}

		bool hasSecureMode() const {
			return secureMode;
		}

		void setParty(Party* newParty) {
			this->party = newParty;
		}
		Party* getParty() const {
			return party;
		}

		int32_t getReflectPercent(CombatType_t combatType) const override {
			return reflectPercent[combatTypeToIndex(combatType)];
		}
		int32_t getReflectFlat(CombatType_t combatType) const override {
			return reflectFlat[combatTypeToIndex(combatType)];
		}

		void setReflectPercent(CombatType_t combatType, int32_t value) {
			this->reflectPercent[combatTypeToIndex(combatType)] = std::max(0, this->reflectPercent[combatTypeToIndex(combatType)] + value);
		}

		void setReflectFlat(CombatType_t combatType, int32_t value) {
			this->reflectFlat[combatTypeToIndex(combatType)] = std::max(0, this->reflectFlat[combatTypeToIndex(combatType)] + value);
		}

		int16_t getCleavePercent() const {
			return cleavePercent;
		}

		void setCleavePercent(int16_t value) {
			cleavePercent = std::max(0, cleavePercent + value);
		}

		int32_t getPerfectShotDamage(uint8_t range) const {
			auto it = perfectShot.find(range);
			if (it != perfectShot.end())
				return it->second;
			return 0;
		}

		void setPerfectShotDamage(uint8_t range, int32_t damage) {
			int32_t actualDamage = getPerfectShotDamage(range);
			bool aboveZero = (actualDamage != 0);
			actualDamage += damage;
			if (actualDamage == 0 && aboveZero)
				perfectShot.erase(range);
			else
				perfectShot[range] = actualDamage;
		}

		int32_t getSpecializedMagicLevel(CombatType_t combat) const {
			return specializedMagicLevel[combatTypeToIndex(combat)];
		}

		void setSpecializedMagicLevel(CombatType_t combat, int32_t value) {
			specializedMagicLevel[combatTypeToIndex(combat)] = std::max(0, specializedMagicLevel[combatTypeToIndex(combat)] + value);
		}

		int32_t getMagicShieldCapacityFlat() const {
			return magicShieldCapacityFlat;
		}

		int16_t getMagicShieldCapacityPercent() const {
			return magicShieldCapacityPercent;
		}

		void setMagicShieldCapacityFlat(int32_t value) {
			magicShieldCapacityFlat += value;
		}

		void setMagicShieldCapacityPercent(int16_t value) {
			magicShieldCapacityPercent += value;
		}

		PartyShields_t getPartyShield(const Player* player) const;
		bool isInviting(const Player* player) const;
		bool isPartner(const Player* player) const;
		void sendPlayerPartyIcons(Player* player);
		bool addPartyInvitation(Party* party);
		void removePartyInvitation(Party* party);
		void clearPartyInvitations();

		void sendUnjustifiedPoints();

		void updatePartyHuntStatus() {
			if (client) {
				client->updatePartyHuntStatus();
			}
		}
		void clearPartyHuntStatus() {
			if (client) {
				client->clearPartyHuntStatus();
			}
		}

		GuildEmblems_t getGuildEmblem(const Player* player) const;

		uint64_t getSpentMana() const {
			return manaSpent;
		}

		bool hasFlag(PlayerFlags value) const {
			return (group->flags & value) != 0;
		}

		bool hasCustomFlag(PlayerCustomFlags value) const {
			return (group->customflags & value) != 0;
		}

		BedItem* getBedItem() {
			return bedItem;
		}
		void setBedItem(BedItem* b) {
			bedItem = b;
		}

		bool inImbuing() {
			return imbuing != nullptr;
		}
		void inImbuing(Item* item);

		void addBlessing(uint8_t index, uint8_t count) {
			if (blessings[index - 1] == 255) {
				return;
			}

			blessings[index-1] += count;
		}
		void removeBlessing(uint8_t index, uint8_t count) {
			if (blessings[index - 1] == 0) {
				return;
			}

			blessings[index-1] -= count;
		}
		bool hasBlessing(uint8_t index) const {
			return blessings[index - 1] != 0;
		}
		uint8_t getBlessingCount(uint8_t index) const {
			return blessings[index - 1];
		}

		bool isOffline() const {
			return (getID() == 0);
		}
		void disconnect() {
			if (client) {
				client->disconnect();
			}
		}

		uint32_t getIP() const;

		void addContainer(uint8_t cid, Container* container);
		void closeContainer(uint8_t cid);
		void setContainerIndex(uint8_t cid, uint16_t index);

		Container* getContainerByID(uint8_t cid);
		int8_t getContainerID(const Container* container) const;
		uint16_t getContainerIndex(uint8_t cid) const;

		bool canOpenCorpse(uint32_t ownerId) const;

		void addStorageValue(const uint32_t key, const int32_t value, const bool isLogin = false);
		bool getStorageValue(const uint32_t key, int32_t& value) const;
		void genReservedStorageRange();

		void setGroup(Group* newGroup) {
			group = newGroup;
		}
		Group* getGroup() const {
			return group;
		}

		void setInMarket(bool value) {
			inMarket = value;
		}
		bool isInMarket() const {
			return inMarket;
		}
		void setSpecialMenuAvailable(bool supplyStashBool, bool marketMenuBool) {
			// Menu option 'stow, stow container ...'
			// Menu option 'show in market'
			supplyStash = supplyStashBool;
			marketMenu = marketMenuBool;
			if (client) {
				client->sendSpecialContainersAvailable();
			}
		}
		bool isSupplyStashMenuAvailable() {
			return supplyStash;
		}
		bool isMarketMenuAvailable() {
			return marketMenu;
		}
		void setDromeCharmUpgrade(bool charmUpgradeBool) {
			DromeCharmUpgrade = charmUpgradeBool;
		}

		bool hasDromeCharmUpgrade() {
			return DromeCharmUpgrade;
		}

		void setCustomVip(bool vip) {
			customVip = vip;
		}

		bool hasCustomVip() {
			return customVip;
		}

		bool isExerciseTraining() {
			return exerciseTraining;
		}
		void setExerciseTraining(bool isTraining) {
			exerciseTraining = isTraining;
		}
		void setLastDepotId(int16_t newId) {
			lastDepotId = newId;
		}
		int16_t getLastDepotId() const {
			return lastDepotId;
		}

		void resetIdleTime() {
			idleTime = 0;
		}

		void sendSingleSoundEffect(const Position& pos, SoundEffect_t id, SourceEffect_t source) {
			if (client) {
				client->sendSingleSoundEffect(pos, id, source);
			}
		}

		void sendDoubleSoundEffect(const Position& pos, SoundEffect_t mainSoundId, SourceEffect_t mainSource,
			SoundEffect_t secondarySoundId, SourceEffect_t secondarySource) {
			if (client) {
				client->sendDoubleSoundEffect(pos, mainSoundId, mainSource, secondarySoundId, secondarySource);
			}
		}

		SoundEffect_t getAttackSoundEffect();
		SoundEffect_t getHitSoundEffect();

		bool isInGhostMode() const override {
			return ghostMode;
		}
		void switchGhostMode() {
			ghostMode = !ghostMode;
		}

		uint32_t getAccount() const {
			return accountNumber;
		}
		account::AccountType getAccountType() const {
			return accountType;
		}
		uint32_t getLevel() const {
			return level;
		}
		uint8_t getLevelPercent() const {
			return levelPercent;
		}
		uint32_t getMagicLevel() const {
			uint32_t magic = std::max<int32_t>(0, magLevel + varStats[STAT_MAGICPOINTS]);
			magic += getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_MAGIC); // Regular bonus
			magic += getWheelOfDestinyMajorStatConditional("Positional Tatics", WHEEL_OF_DESTINY_MAJOR_MAGIC); // Revelation bonus
			return magic;
		}
		uint32_t getBaseMagicLevel() const {
			return magLevel;
		}
		double_t getMagicLevelPercent() const {
			return magLevelPercent;
		}
		uint8_t getSoul() const {
			return soul;
		}
		void setDust(uint8_t value) {
			dust += value;
		}
		void removeDust(uint8_t value) {
			dust -= value;
		}
		uint8_t getDust() const {
			return dust;
		}
		uint8_t getMaxDust() const {
			return maxDust;
		}
		void raiseMaxDust() {
			maxDust += 1;
		}
		uint64_t getSliver() const {
			return getItemTypeCount(ITEM_SLIVER);
		}
		uint64_t getExaltedCore() const {
			return getItemTypeCount(ITEM_EXALTED_CORE);
		}
		bool isAccessPlayer() const {
			return group->access;
		}
		bool isPremium() const;
		void setPremiumDays(int32_t v);

		void setTibiaCoins(int32_t v);

		uint16_t getHelpers() const;

		bool setVocation(uint16_t vocId);
		uint16_t getVocationId() const {
			return vocation->getId();
		}

		PlayerSex_t getSex() const {
			return sex;
		}
		void setSex(PlayerSex_t);
		uint64_t getExperience() const {
			return experience;
		}

		time_t getLastLoginSaved() const {
			return lastLoginSaved;
		}

		time_t getLastLogout() const {
			return lastLogout;
		}

		const Position& getLoginPosition() const {
			return loginPosition;
		}
		const Position& getTemplePosition() const {
			return town->getTemplePosition();
		}
		Town* getTown() const {
			return town;
		}
		void setTown(Town* newTown) {
			this->town = newTown;
		}

		void clearModalWindows();
		bool hasModalWindowOpen(uint32_t modalWindowId) const;
		void onModalWindowHandled(uint32_t modalWindowId);

		bool isPushable() const override;
		uint32_t isMuted() const;
		void addMessageBuffer();
		void removeMessageBuffer();

		bool removeItemOfType(uint16_t itemId, uint32_t amount, int32_t subType, bool ignoreEquipped = false) const;

		void addItemOnStash(uint16_t clientId, uint32_t amount) {
			auto it = stashItems.find(clientId);
			if (it != stashItems.end()) {
				stashItems[clientId] += amount;
				return;
			}

			stashItems[clientId] = amount;
		}
		uint16_t getStashItemCount(uint16_t clientId) const {
			auto it = stashItems.find(clientId);
			if (it != stashItems.end()) {
				return static_cast<uint16_t>(it->second);
			}
			return 0;
		}
		bool withdrawItem(uint16_t clientId, uint32_t amount) {
			auto it = stashItems.find(clientId);
			if (it != stashItems.end()) {
				if (it->second > amount) {
					stashItems[clientId] -= amount;
				} else if (it->second == amount) {
					stashItems.erase(clientId);
				} else {
					return false;
				}
				return true;
			}
			return false;
		}
		StashItemList getStashItems() const {
			return stashItems;
		}

		uint32_t getBaseCapacity() const {
			if (hasFlag(PlayerFlag_CannotPickupItem)) {
				return 0;
			} else if (hasFlag(PlayerFlag_HasInfiniteCapacity)) {
				return std::numeric_limits<uint32_t>::max();
			}
			return capacity;
		}

		uint32_t getCapacity() const {
			if (hasFlag(PlayerFlag_CannotPickupItem)) {
				return 0;
			} else if (hasFlag(PlayerFlag_HasInfiniteCapacity)) {
				return std::numeric_limits<uint32_t>::max();
			}
			return capacity + bonusCapacity + getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_CAPACITY);
		}

		uint32_t getFreeCapacity() const {
			if (hasFlag(PlayerFlag_CannotPickupItem)) {
				return 0;
			} else if (hasFlag(PlayerFlag_HasInfiniteCapacity)) {
				return std::numeric_limits<uint32_t>::max();
			} else {
				return std::max<int32_t>(0, getCapacity() - inventoryWeight);
			}
		}

		int64_t getMaxHealth() const override {
			return std::max<int64_t>(1, healthMax + varStats[STAT_MAXHITPOINTS] + getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_HEALTH));
		}
		uint32_t getMaxMana() const override {
			return std::max<int64_t>(0, manaMax + varStats[STAT_MAXMANAPOINTS] + getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_MANA));
		}

		Item* getInventoryItem(slots_t slot) const;
		std::unordered_map<uint16_t, uint32_t> getInventoryItems() const;
		std::unordered_map<uint16_t, uint32_t> getStoreInboxItems() const;
		std::unordered_map<uint16_t, uint32_t> getDepotItems() const;
		std::unordered_map<uint16_t, uint32_t> getDepotInboxItems() const;

		bool isItemAbilityEnabled(slots_t slot) const {
			return inventoryAbilities[slot];
		}
		void setItemAbility(slots_t slot, bool enabled) {
			inventoryAbilities[slot] = enabled;
		}

		void setVarSkill(skills_t skill, int32_t modifier) {
			varSkills[skill] += modifier;
		}

		void setVarStats(stats_t stat, int32_t modifier);
		int64_t getDefaultStats(stats_t stat) const;

		void setVarSpecial(specials_t special, double bonus) {
			varSpecial[special] += bonus;
		}

		void addConditionSuppressions(uint32_t conditions);
		void removeConditionSuppressions(uint32_t conditions);

		Reward* getReward(uint32_t rewardId, bool autoCreate);
		void removeReward(uint32_t rewardId);
		void getRewardList(std::vector<uint32_t>& rewards);
		RewardChest* getRewardChest();

		DepotChest* getDepotBox();
		DepotChest* getDepotChest(uint32_t depotId, bool autoCreate);
		DepotLocker* getDepotLocker(uint32_t depotId);
		void onReceiveMail() const;
		bool isNearDepotBox() const;

		Container* setLootContainer(ObjectCategory_t category, Container* container, bool loading = false);
		Container* getLootContainer(ObjectCategory_t category) const;

		bool canSee(const Position& pos) const override;
		bool canSeeCreature(const Creature* creature) const override;

		bool canWalkthrough(const Creature* creature) const;
		bool canWalkthroughEx(const Creature* creature) const;

		RaceType_t getRace() const override {
			return RACE_BLOOD;
		}

		uint64_t getMoney() const;

		//safe-trade functions
		void setTradeState(tradestate_t state) {
			tradeState = state;
		}
		tradestate_t getTradeState() const {
			return tradeState;
		}
		Item* getTradeItem() {
			return tradeItem;
		}

		//shop functions
		void setShopOwner(Npc* owner, int32_t onBuy, int32_t onSell) {
			shopOwner = owner;
			purchaseCallback = onBuy;
			saleCallback = onSell;
		}

		Npc* getShopOwner(int32_t& onBuy, int32_t& onSell) {
			onBuy = purchaseCallback;
			onSell = saleCallback;
			return shopOwner;
		}

		const Npc* getShopOwner(int32_t& onBuy, int32_t& onSell) const {
			onBuy = purchaseCallback;
			onSell = saleCallback;
			return shopOwner;
		}

		Npc* getOnlyShopOwner() {
			return shopOwner;
		}

		//V.I.P. functions
		void notifyStatusChange(Player* player, VipStatus_t status, bool message = true);
		bool removeVIP(uint32_t vipGuid);
		bool addVIP(uint32_t vipGuid, const std::string& vipName, VipStatus_t status);
		bool addVIPInternal(uint32_t vipGuid);
		bool editVIP(uint32_t vipGuid, const std::string& description, uint32_t icon, bool notify);

		//follow functions
		bool setFollowCreature(Creature* creature) override;
		void goToFollowCreature() override;

		//follow events
		void onFollowCreature(const Creature* creature) override;

		//walk events
		void onWalk(Direction& dir) override;
		void onWalkAborted() override;
		void onWalkComplete() override;

		void stopWalk();
		void openShopWindow(Npc* npc, const std::vector<ShopInfo>& shop);
		bool closeShopWindow(bool sendCloseShopWindow = true);
		bool updateSaleShopList(const Item* item);
		bool hasShopItemForSale(uint32_t itemId, uint8_t subType) const;

		void setChaseMode(bool mode);
		void setFightMode(fightMode_t mode) {
			fightMode = mode;
		}
		void setSecureMode(bool mode) {
			secureMode = mode;
		}

		Faction_t getFaction() const override {
			return FACTION_PLAYER;
		}

		//combat functions
		bool setAttackedCreature(Creature* creature) override;
		bool isImmune(CombatType_t type) const override;
		bool isImmune(ConditionType_t type) const override;
		bool hasShield() const;
		bool isAttackable() const override;
		static bool lastHitIsPlayer(Creature* lastHitCreature);

		//stash functions
		bool addItemFromStash(uint16_t itemId, uint32_t itemCount);
		void stowItem(Item* item, uint32_t count, bool allItems);

		void clearSpells();

		void changeHealth(int64_t healthChange, bool sendHealthChange = true) override;
		void changeMana(int64_t manaChange) override;
		void changeSoul(int32_t soulChange);

		bool isPzLocked() const {
			return pzLocked;
		}
		BlockType_t blockHit(Creature* attacker, CombatType_t combatType, int64_t& damage,
									 bool checkDefense = false, bool checkArmor = false, bool field = false) override;
		void doAttacking(uint32_t interval) override;
		bool hasExtraSwing() override {
			return lastAttack > 0 && ((OTSYS_TIME() - lastAttack) >= getAttackSpeed());
		}

		uint16_t getSkillLevel(uint8_t skill) const {
			if (skill == SKILL_LIFE_LEECH_CHANCE || skill == SKILL_MANA_LEECH_CHANCE) {
				return std::min<uint16_t>(100, std::max<uint16_t>(0, skills[skill].level + varSkills[skill]));
			}
			
			uint16_t skillLevel = std::max<uint16_t>(0, skills[skill].level + varSkills[skill]);
			// Wheel of destiny
			if (skill >= SKILL_CLUB && skill <= SKILL_AXE) {
				skillLevel += getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_MELEE);
				skillLevel += getWheelOfDestinyMajorStatConditional("Battle Instinct", WHEEL_OF_DESTINY_MAJOR_MELEE);
			} else if (skill == SKILL_DISTANCE) {
				skillLevel += getWheelOfDestinyMajorStatConditional("Positional Tatics", WHEEL_OF_DESTINY_MAJOR_DISTANCE);
				skillLevel += getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_DISTANCE);
			} else if (skill == SKILL_SHIELD) {
				skillLevel += getWheelOfDestinyMajorStatConditional("Battle Instinct", WHEEL_OF_DESTINY_MAJOR_SHIELD);
			} else if (skill == SKILL_MAGLEVEL) {
				skillLevel += getWheelOfDestinyMajorStatConditional("Positional Tatics", WHEEL_OF_DESTINY_MAJOR_MAGIC);
				skillLevel += getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_MAGIC);
			} else if (skill == SKILL_LIFE_LEECH_AMOUNT) {
				skillLevel += getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_LIFE_LEECH);
			} else if (skill == SKILL_MANA_LEECH_AMOUNT) {
				skillLevel += getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_MANA_LEECH);
			} else if (skill == SKILL_LIFE_LEECH_CHANCE) {
				skillLevel += getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_LIFE_LEECH_CHANCE);
			} else if (skill == SKILL_MANA_LEECH_CHANCE) {
				skillLevel += getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_MANA_LEECH_CHANCE);
			} else if (skill == SKILL_CRITICAL_HIT_DAMAGE) {
				skillLevel += getWheelOfDestinyMajorStatConditional("Combat Mastery", WHEEL_OF_DESTINY_MAJOR_CRITICAL_DMG_2);
				skillLevel += getWheelOfDestinyMajorStatConditional("Ballistic Mastery", WHEEL_OF_DESTINY_MAJOR_CRITICAL_DMG);
				skillLevel += checkWheelOfDestinyAvatarSkill(WHEEL_OF_DESTINY_AVATAR_SKILL_CRITICAL_DAMAGE);
			}
			
			auto it = maxValuePerSkill.find(skill);
			if (it != maxValuePerSkill.end()) {
				skillLevel = std::min<uint16_t>(it->second, skillLevel);
			}
			
			int32_t avatarCritChance = checkWheelOfDestinyAvatarSkill(WHEEL_OF_DESTINY_AVATAR_SKILL_CRITICAL_CHANCE);
			if (skill == SKILL_CRITICAL_HIT_CHANCE && avatarCritChance > 0) {
				skillLevel = avatarCritChance; // 100%
			}

			return skillLevel;
		}
		uint16_t getBaseSkill(uint8_t skill) const {
			return skills[skill].level;
		}
		double_t getSkillPercent(uint8_t skill) const {
			return skills[skill].percent;
		}

		bool getAddAttackSkill() const {
			return addAttackSkillPoint;
		}
		BlockType_t getLastAttackBlockType() const {
			return lastAttackBlockType;
		}

		Item* getWeapon(slots_t slot, bool ignoreAmmo) const;
		Item* getWeapon(bool ignoreAmmo = false) const;
		WeaponType_t getWeaponType() const;
		int32_t getWeaponSkill(const Item* item) const;
		void getShieldAndWeapon(const Item*& shield, const Item*& weapon) const;

		void drainHealth(Creature* attacker, int64_t damage) override;
		void drainMana(Creature* attacker, int64_t manaLoss) override;
		void addManaSpent(uint64_t amount);
		void addSkillAdvance(skills_t skill, uint64_t count);
		
		float getMitigation() const override;

		int32_t getArmor() const override;
		int32_t getDefense() const override;
		
		double getMitigationMultiplier() const {
			return static_cast<double>(getWheelOfDestinyStat(WHEEL_OF_DESTINY_STAT_MITIGATION)) / 100.;
		}
		
		float getAttackFactor() const override;
		float getDefenseFactor() const override;

		void addInFightTicks(bool pzlock = false);

		uint64_t getGainedExperience(Creature* attacker) const override;

		//combat event functions
		void onAddCondition(ConditionType_t type) override;
		void onAddCombatCondition(ConditionType_t type) override;
		void onEndCondition(ConditionType_t type) override;
		void onCombatRemoveCondition(Condition* condition) override;
		void onAttackedCreature(Creature* target) override;
		void onAttacked() override;
		void onAttackedCreatureDrainHealth(Creature* target, int64_t points) override;
		void onTargetCreatureGainHealth(Creature* target, int64_t points) override;
		bool onKilledCreature(Creature* target, bool lastHit = true) override;
		void onGainExperience(uint64_t gainExp, Creature* target) override;
		void onGainSharedExperience(uint64_t gainExp, Creature* source);
		void onAttackedCreatureBlockHit(BlockType_t blockType) override;
		void onBlockHit() override;
		void onChangeZone(ZoneType_t zone) override;
		void onAttackedCreatureChangeZone(ZoneType_t zone) override;
		void onIdleStatus() override;
		void onPlacedCreature() override;

		LightInfo getCreatureLight() const override;

		Skulls_t getSkull() const override;
		Skulls_t getSkullClient(const Creature* creature) const override;
		int64_t getSkullTicks() const { return skullTicks; }
		void setSkullTicks(int64_t ticks) { skullTicks = ticks; }

		bool hasAttacked(const Player* attacked) const;
		void addAttacked(const Player* attacked);
		void removeAttacked(const Player* attacked);
		void clearAttacked();
		void addUnjustifiedDead(const Player* attacked);
		void sendCreatureEmblem(Creature* creature) const {
			if (client) {
				client->sendCreatureEmblem(creature);
			}
		}
		void sendCreatureSkull(const Creature* creature) const {
			if (client) {
				client->sendCreatureSkull(creature);
			}
		}
		void checkSkullTicks(int64_t ticks);

		bool canWear(uint32_t lookType, uint8_t addons) const;
		void addOutfit(uint16_t lookType, uint8_t addons);
		bool removeOutfit(uint16_t lookType);
		bool removeOutfitAddon(uint16_t lookType, uint8_t addons);
		bool getOutfitAddons(const Outfit& outfit, uint8_t& addons) const;

		bool canFamiliar(uint32_t lookType) const;
		void addFamiliar(uint16_t lookType);
		bool removeFamiliar(uint16_t lookType);
		bool getFamiliar(const Familiar& familiar) const;
		void setFamiliarLooktype(uint16_t familiarLooktype) {
			this->defaultOutfit.lookFamiliarsType = familiarLooktype;
		}

		bool canLogout();

		bool hasKilled(const Player* player) const;

		size_t getMaxVIPEntries() const;
		size_t getMaxDepotItems() const;

		void sendExperienceInfo(uint64_t rawExp, uint64_t exp) {
			if (client) {
				client->AddExperienceInfo(rawExp, exp);
			}
		}

		//tile
		//send methods
		void sendAddTileItem(const Tile* itemTile, const Position& pos, const Item* item) {
			if (client) {
				int32_t stackpos = itemTile->getStackposOfItem(this, item);
				if (stackpos != -1) {
					client->sendAddTileItem(pos, stackpos, item);
				}
			}
		}
		void sendUpdateTileItem(const Tile* updateTile, const Position& pos, const Item* item) {
			if (client) {
				int32_t stackpos = updateTile->getStackposOfItem(this, item);
				if (stackpos != -1) {
					client->sendUpdateTileItem(pos, stackpos, item);
				}
			}
		}
		void sendRemoveTileThing(const Position& pos, int32_t stackpos) {
			if (stackpos != -1 && client) {
				client->sendRemoveTileThing(pos, stackpos);
			}
		}
		void sendRemoveTileCreature(const Creature* creature, const Position& pos, int32_t stackpos) {
			if (client) {
				client->sendRemoveTileCreature(creature, pos, stackpos);
			}
		}
		void sendUpdateTile(const Tile* updateTile, const Position& pos) {
			if (client) {
				client->sendUpdateTile(updateTile, pos);
			}
		}

		void sendChannelMessage(const std::string& author, const std::string& text, SpeakClasses type, uint16_t channel) {
			if (client) {
				client->sendChannelMessage(author, text, type, channel);
			}
		}
		void sendChannelEvent(uint16_t channelId, const std::string& playerName, ChannelEvent_t channelEvent) {
			if (client) {
				client->sendChannelEvent(channelId, playerName, channelEvent);
			}
		}
		void sendCreatureAppear(const Creature* creature, const Position& pos, bool isLogin) {
			if (client) {
				client->sendAddCreature(creature, pos, creature->getTile()->getClientIndexOfCreature(this, creature), isLogin);
			}
		}
		void sendCreatureMove(const Creature* creature, const Position& newPos, int32_t newStackPos, const Position& oldPos, int32_t oldStackPos, bool teleport) {
			if (client) {
				client->sendMoveCreature(creature, newPos, newStackPos, oldPos, oldStackPos, teleport);
			}
		}
		void sendCreatureTurn(const Creature* creature) {
			if (client && canSeeCreature(creature)) {
				int32_t stackpos = creature->getTile()->getClientIndexOfCreature(this, creature);
				if (stackpos != -1) {
					client->sendCreatureTurn(creature, stackpos);
				}
			}
		}
		void sendCreatureSay(const Creature* creature, SpeakClasses type, const std::string& text, const Position* pos = nullptr) {
			if (client) {
				client->sendCreatureSay(creature, type, text, pos);
			}
		}
		void sendCreatureReload(const Creature* creature) {
			if (client) {
				client->reloadCreature(creature);
			}
		}
		void sendPrivateMessage(const Player* speaker, SpeakClasses type, const std::string& text) {
			if (client) {
				client->sendPrivateMessage(speaker, type, text);
			}
		}
		void sendCreatureSquare(const Creature* creature, SquareColor_t color) {
			if (client) {
				client->sendCreatureSquare(creature, color);
			}
		}
		void sendCreatureChangeOutfit(const Creature* creature, const Outfit_t& outfit) {
			if (client) {
				client->sendCreatureOutfit(creature, outfit);
			}
		}
		void sendCreatureChangeVisible(const Creature* creature, bool visible) {
			if (!client) {
				return;
			}

			if (creature->getPlayer()) {
				if (visible) {
					client->sendCreatureOutfit(creature, creature->getCurrentOutfit());
				} else {
					static Outfit_t outfit;
					client->sendCreatureOutfit(creature, outfit);
				}
			} else if (canSeeInvisibility()) {
				client->sendCreatureOutfit(creature, creature->getCurrentOutfit());
			} else {
				int32_t stackpos = creature->getTile()->getClientIndexOfCreature(this, creature);
				if (stackpos == -1) {
					return;
				}

				if (visible) {
					client->sendAddCreature(creature, creature->getPosition(), stackpos, false);
				} else {
					client->sendRemoveTileCreature(creature, creature->getPosition(), stackpos);
				}
			}
		}
		void sendCreatureLight(const Creature* creature) {
			if (client) {
				client->sendCreatureLight(creature);
			}
		}
    void sendCreatureIcon(const Creature* creature) {
			if (client) {
				client->sendCreatureIcon(creature);
			}
		}
		void sendCreatureWalkthrough(const Creature* creature, bool walkthrough) {
			if (client) {
				client->sendCreatureWalkthrough(creature, walkthrough);
			}
		}
		void sendCreatureShield(const Creature* creature) {
			if (client) {
				client->sendCreatureShield(creature);
			}
		}
		void sendCreatureType(const Creature* creature, uint8_t creatureType) {
			if (client) {
				client->sendCreatureType(creature, creatureType);
			}
		}
		void sendSpellCooldown(uint16_t spellId, uint32_t time) {
			if (client) {
				client->sendSpellCooldown(spellId, time);
			}
		}
		void sendSpellGroupCooldown(SpellGroup_t groupId, uint32_t time) {
			if (client) {
				client->sendSpellGroupCooldown(groupId, time);
			}
		}

		void reloadCreature(const Creature* creature) {
			if (client) {
				client->reloadCreature(creature);
			}
		}
		void sendModalWindow(const ModalWindow& modalWindow);

		//container
		void sendAddContainerItem(const Container* container, const Item* item);
		void sendUpdateContainerItem(const Container* container, uint16_t slot, const Item* newItem);
		void sendRemoveContainerItem(const Container* container, uint16_t slot);
		void sendContainer(uint8_t cid, const Container* container, bool hasParent, uint16_t firstIndex) {
			if (client) {
				client->sendContainer(cid, container, hasParent, firstIndex);
			}
		}

		//inventory
		void sendLockerItems(std::map<uint16_t, uint16_t> itemMap, uint16_t count) {
			if (client) {
				client->sendLockerItems(itemMap, count);
			}
		}
		void sendCoinBalance() {
			if (client) {
				client->sendCoinBalance();
			}
		}
		void sendInventoryItem(slots_t slot, const Item* item) {
			if (client) {
				client->sendInventoryItem(slot, item);
			}
		}
		void sendItems(const std::multimap<uint16_t, uint8_t>& inventoryMap) {
			if (client) {
				client->sendItems(inventoryMap);
			}
		}

		void openPlayerContainers();

		//store
		void sendOpenStore(uint8_t serviceType) {
			if(client) {
				client->sendOpenStore(serviceType);
			}
		}

		void sendShowStoreCategoryOffers(StoreCategory* category) {
			if(client) {
				client->sendStoreCategoryOffers(category);
			}
		}

		void sendStoreError(GameStoreError_t error, const std::string& errorMessage) {
			if(client) {
				client->sendStoreError(error, errorMessage);
			}
		}

		void sendStorePurchaseSuccessful(const std::string& message, const uint32_t newCoinBalance) {
			if(client)
			{
				client->sendStorePurchaseSuccessful(message, newCoinBalance);
			}
		}

		void sendStoreRequestAdditionalInfo(uint32_t offerId, ClientOffer_t clientOfferType) {
			if(client) {
				client->sendStoreRequestAdditionalInfo(offerId, clientOfferType);
			}
		}

		void sendStoreTrasactionHistory(HistoryStoreOfferList& list, uint32_t page, uint8_t entriesPerPage) {
			if(client) {
				client->sendStoreTrasactionHistory(list, page, entriesPerPage);
			}
		}

		// Quickloot
		void sendLootContainers() {
			if (client) {
				client->sendLootContainers();
			}
		}
		void sendLootStats(Item* item, uint8_t count) {
			if (client) {
				client->sendLootStats(item, count);
			}
		}

		// Resource
		void sendResourceBalance(Resource_t type, uint64_t value) {
			if (client) {
				client->sendResourceBalance(type, value);
			}
		}

		//exalted forge
		void openExaltedForgeWindow() {
			if (client) {
				client->sendExaltationForge();
			}
		}
		void sendExaltedFusionWindow(bool sucess, Item* upgradeItem, uint16_t secondaryItem, uint8_t itemTier, ExaltedForgeBonus_t bonus, uint8_t bonusInfo = 0) {
			if (client) {
				client->sendExaltedFusionWindow(sucess, upgradeItem, secondaryItem, itemTier, bonus, bonusInfo);
			}
		}
		void sendExaltedTransferWindow(uint16_t oldItemId, uint8_t oldItemTier, Item* newItem) {
			if (client) {
				client->sendExaltedTransferWindow(oldItemId, oldItemTier, newItem);
			}
		}

		//event methods
		void onUpdateTileItem(const Tile* tile, const Position& pos, const Item* oldItem,
									  const ItemType& oldType, const Item* newItem, const ItemType& newType) override;
		void onRemoveTileItem(const Tile* tile, const Position& pos, const ItemType& iType,
									  const Item* item) override;

		void onCreatureAppear(Creature* creature, bool isLogin) override;
		void onRemoveCreature(Creature* creature, bool isLogout) override;
		void onCreatureMove(Creature* creature, const Tile* newTile, const Position& newPos,
									const Tile* oldTile, const Position& oldPos, bool teleport) override;

		void onAttackedCreatureDisappear(bool isLogout) override;
		void onFollowCreatureDisappear(bool isLogout) override;

		//container
		void onAddContainerItem(const Item* item);
		void onUpdateContainerItem(const Container* container, const Item* oldItem, const Item* newItem);
		void onRemoveContainerItem(const Container* container, const Item* item);

		void onCloseContainer(const Container* container);
		void onSendContainer(const Container* container);
		void autoCloseContainers(const Container* container);

		//inventory
		void onUpdateInventoryItem(Item* oldItem, Item* newItem);
		void onRemoveInventoryItem(Item* item);

		void sendCancelMessage(const std::string& msg) const {
			if (client) {
				client->sendTextMessage(TextMessage(MESSAGE_FAILURE, msg));
			}
		}
		void sendCancelMessage(ReturnValue message) const;
		void sendCancelTarget() const {
			if (client) {
				client->sendCancelTarget();
			}
		}
		void sendCancelWalk() const {
			if (client) {
				client->sendCancelWalk();
			}
		}
		void sendChangeSpeed(const Creature* creature, uint32_t newSpeed) const {
			if (client) {
				client->sendChangeSpeed(creature, newSpeed);
			}
		}
		void sendCreatureHealth(const Creature* creature) const {
			if (client) {
				client->sendCreatureHealth(creature);
			}
		}
		void sendPartyCreatureUpdate(const Creature* creature) const {
			if (client) {
				client->sendPartyCreatureUpdate(creature);
			}
		}
		void sendPartyCreatureShield(const Creature* creature) const {
			if (client) {
				client->sendPartyCreatureShield(creature);
			}
		}
		void sendPartyCreatureSkull(const Creature* creature) const {
			if (client) {
				client->sendPartyCreatureSkull(creature);
			}
		}
		void sendPartyCreatureHealth(const Creature* creature, uint8_t healthPercent) const {
			if (client) {
				client->sendPartyCreatureHealth(creature, healthPercent);
			}
		}
		void sendPartyPlayerMana(const Player* player, uint8_t manaPercent) const {
			if (client) {
				client->sendPartyPlayerMana(player, manaPercent);
			}
		}
		void sendPartyCreatureShowStatus(const Creature* creature, bool showStatus) const {
			if (client) {
				client->sendPartyCreatureShowStatus(creature, showStatus);
			}
		}
		void sendPartyPlayerVocation(const Player* player) const {
			if (client) {
				client->sendPartyPlayerVocation(player);
			}
		}
		void sendPlayerVocation(const Player* player) const {
			if (client) {
				client->sendPlayerVocation(player);
			}
		}
		void sendDistanceShoot(const Position& from, const Position& to, unsigned char type) const {
			if (client) {
				client->sendDistanceShoot(from, to, type);
			}
		}
		void sendHouseWindow(House* house, uint32_t listId) const;
		void sendCreatePrivateChannel(uint16_t channelId, const std::string& channelName) {
			if (client) {
				client->sendCreatePrivateChannel(channelId, channelName);
			}
		}
		void sendClosePrivate(uint16_t channelId);
		void sendIcons() const {
			if (client) {
				client->sendIcons(getClientIcons());
			}
		}
		void sendClientCheck() const {
			if (client) {
				client->sendClientCheck();
			}
		}
		void sendGameNews() const {
			if (client) {
				client->sendGameNews();
			}
		}
		void sendMagicEffect(const Position& pos, uint8_t type) const {
			if (client) {
				client->sendMagicEffect(pos, type);
			}
		}
		void sendPing();
		void sendPingBack() const {
			if (client) {
				client->sendPingBack();
			}
		}
		void sendStats();
		void sendBasicData() const {
			if (client) {
				client->sendBasicData();
			}
		}
		void sendBlessStatus() const {
			if (client) {
				client->sendBlessStatus();
			}
		}
		void sendSkills() const {
			if (client) {
				client->sendSkills();
			}
		}
		void sendTextMessage(MessageClasses mclass, const std::string& message) const {
			if (client) {
				client->sendTextMessage(TextMessage(mclass, message));
			}
		}
		void sendTextMessage(const TextMessage& message) const {
			if (client) {
				client->sendTextMessage(message);
			}
		}
		void sendReLoginWindow(uint8_t unfairFightReduction) const {
			if (client) {
				client->sendReLoginWindow(unfairFightReduction);
			}
		}
		void sendTextWindow(Item* item, uint16_t maxlen, bool canWrite) const {
			if (client) {
				client->sendTextWindow(windowTextId, item, maxlen, canWrite);
			}
		}
		void sendTextWindow(uint32_t itemId, const std::string& text) const {
			if (client) {
				client->sendTextWindow(windowTextId, itemId, text);
			}
		}
		void sendToChannel(const Creature* creature, SpeakClasses type, const std::string& text, uint16_t channelId) const {
			if (client) {
				client->sendToChannel(creature, type, text, channelId);
			}
		}
		void sendShop(Npc* npc) const {
			if (client) {
				client->sendShop(npc, shopItemList);
			}
		}
    void sendSaleItemList(const std::map<uint32_t, uint32_t>& inventoryMap) const {
      if (client) {
        client->sendSaleItemList(shopItemList, inventoryMap);
      }
    }
		void sendCloseShop() const {
			if (client) {
				client->sendCloseShop();
			}
		}
		void sendMarketEnter(uint32_t depotId);
		void sendMarketLeave() {
			inMarket = false;
			if (client) {
				client->sendMarketLeave();
			}
		}
		void sendMarketBrowseItem(uint16_t itemId, uint8_t tier, const MarketOfferList& buyOffers, const MarketOfferList& sellOffers) const {
			if (client) {
				client->sendMarketBrowseItem(itemId, tier, buyOffers, sellOffers);
			}
		}
		void sendMarketBrowseOwnOffers(const MarketOfferList& buyOffers, const MarketOfferList& sellOffers) const {
			if (client) {
				client->sendMarketBrowseOwnOffers(buyOffers, sellOffers);
			}
		}
		void sendMarketBrowseOwnHistory(const HistoryMarketOfferList& buyOffers, const HistoryMarketOfferList& sellOffers) const {
			if (client) {
				client->sendMarketBrowseOwnHistory(buyOffers, sellOffers);
			}
		}
		void sendMarketDetail(uint16_t itemId, uint8_t tier) const {
			if (client) {
				client->sendMarketDetail(itemId, tier);
			}
		}
		void sendMarketAcceptOffer(const MarketOfferEx& offer) const {
			if (client) {
				client->sendMarketAcceptOffer(offer);
			}
		}
		void sendMarketCancelOffer(const MarketOfferEx& offer) const {
			if (client) {
				client->sendMarketCancelOffer(offer);
			}
		}
		void sendTradeItemRequest(const std::string& traderName, const Item* item, bool ack) const {
			if (client) {
				client->sendTradeItemRequest(traderName, item, ack);
			}
		}
		void sendTradeClose() const {
			if (client) {
				client->sendCloseTrade();
			}
		}
		void sendWorldLight(LightInfo lightInfo) {
			if (client) {
				client->sendWorldLight(lightInfo);
			}
		}
    void sendTibiaTime(int32_t time) {
			if (client) {
				client->sendTibiaTime(time);
			}
		}
		void sendChannelsDialog() {
			if (client) {
				client->sendChannelsDialog();
			}
		}
		void sendOpenPrivateChannel(const std::string& receiver) {
			if (client) {
				client->sendOpenPrivateChannel(receiver);
			}
		}
		void sendOutfitWindow() {
			if (client) {
				client->sendOutfitWindow();
			}
		}
		void sendImbuementWindow(Item* item);
		void sendPodiumWindow(const Item* podium, const Position& position, uint16_t spriteId, uint8_t stackpos) {
			if (client) {
				client->sendPodiumWindow(podium, position, spriteId, stackpos);
			}
		}
		void sendCloseContainer(uint8_t cid) {
			if (client) {
				client->sendCloseContainer(cid);
			}
		}

		void sendChannel(uint16_t channelId, const std::string& channelName, const UsersMap* channelUsers, const InvitedMap* invitedUsers) {
			if (client) {
				client->sendChannel(channelId, channelName, channelUsers, invitedUsers);
			}
		}
		void sendTutorial(uint8_t tutorialId) {
			if (client) {
				client->sendTutorial(tutorialId);
			}
		}
		void sendAddMarker(const Position& pos, uint8_t markType, const std::string& desc) {
			if (client) {
				client->sendAddMarker(pos, markType, desc);
			}
		}
    void sendItemInspection(uint16_t itemId, uint8_t itemCount, const Item* item, bool cyclopedia) {
			if (client) {
				client->sendItemInspection(itemId, itemCount, item, cyclopedia);
			}
		}
    void sendCyclopediaCharacterNoData(CyclopediaCharacterInfoType_t characterInfoType, uint8_t errorCode) {
			if (client) {
				client->sendCyclopediaCharacterNoData(characterInfoType, errorCode);
			}
		}
    void sendCyclopediaCharacterBaseInformation() {
			if (client) {
				client->sendCyclopediaCharacterBaseInformation();
			}
		}
		void sendCyclopediaCharacterGeneralStats() {
			if (client) {
				client->sendCyclopediaCharacterGeneralStats();
			}
		}
		void sendCyclopediaCharacterCombatStats() {
			if (client) {
				client->sendCyclopediaCharacterCombatStats();
			}
		}
		void sendCyclopediaCharacterRecentDeaths(uint16_t page, uint16_t pages, const std::vector<RecentDeathEntry>& entries) {
			if (client) {
				client->sendCyclopediaCharacterRecentDeaths(page, pages, entries);
			}
		}
		void sendCyclopediaCharacterRecentPvPKills(uint16_t page, uint16_t pages, const std::vector<RecentPvPKillEntry>& entries) {
			if (client) {
				client->sendCyclopediaCharacterRecentPvPKills(page, pages, entries);
			}
		}
		void sendCyclopediaCharacterAchievements() {
			if (client) {
				client->sendCyclopediaCharacterAchievements();
			}
		}
		void sendCyclopediaCharacterItemSummary() {
			if (client) {
				client->sendCyclopediaCharacterItemSummary();
			}
		}
		void sendCyclopediaCharacterOutfitsMounts() {
			if (client) {
				client->sendCyclopediaCharacterOutfitsMounts();
			}
		}
		void sendCyclopediaCharacterStoreSummary() {
			if (client) {
				client->sendCyclopediaCharacterStoreSummary();
			}
		}
		void sendCyclopediaCharacterInspection() {
			if (client) {
				client->sendCyclopediaCharacterInspection();
			}
		}
		void sendCyclopediaCharacterBadges() {
			if (client) {
				client->sendCyclopediaCharacterBadges();
			}
		}
		void sendCyclopediaCharacterTitles() {
			if (client) {
				client->sendCyclopediaCharacterTitles();
			}
		}
    void sendHighscoresNoData() {
			if (client) {
				client->sendHighscoresNoData();
			}
		}
		void sendHighscores(const std::vector<HighscoreCharacter>& characters, uint8_t categoryId, uint32_t vocationId, uint16_t page, uint16_t pages) {
			if (client) {
				client->sendHighscores(characters, categoryId, vocationId, page, pages);
			}
		}
    void addAsyncOngoingTask(uint64_t flags) {
			asyncOngoingTasks |= flags;
		}
		bool hasAsyncOngoingTask(uint64_t flags) const {
			return (asyncOngoingTasks & flags);
		}
		void resetAsyncOngoingTask(uint64_t flags) {
			asyncOngoingTasks &= ~(flags);
		}
		void sendTournamentLeaderboard() {
  			if (client) {
				client->sendTournamentLeaderboard();
			}
		}
		void sendEnterWorld() {
			if (client) {
				client->sendEnterWorld();
			}
		}
		void sendFightModes() {
			if (client) {
				client->sendFightModes();
			}
		}
		void sendNetworkMessage(const NetworkMessage& message) {
			if (client) {
				client->writeToOutputBuffer(message);
			}
		}

		void sendStoreOpen(uint8_t serviceType) {
			if (client) {
				client->sendOpenStore(serviceType);
			}
		}

		void receivePing() {
			lastPong = OTSYS_TIME();
		}

		void sendOpenStash(bool isNpc = false) {
			if (client && ((getLastDepotId() != -1) || isNpc)) {
        		client->sendOpenStash();
			}
		}
		bool isStashExhausted() const;
		void updateStashExhausted() {
			lastStashInteraction = OTSYS_TIME();
		}

		void onThink(uint32_t interval) override;

		void postAddNotification(Thing* thing, const Cylinder* oldParent, int32_t index, cylinderlink_t link = LINK_OWNER) override;
		void postRemoveNotification(Thing* thing, const Cylinder* newParent, int32_t index, cylinderlink_t link = LINK_OWNER) override;

		void setNextAction(int64_t time) {
			if (time > nextAction) {
				nextAction = time;
			}
		}
		bool canDoAction() const {
			return nextAction <= OTSYS_TIME();
		}

		void setNextPotionAction(int64_t time) {
			if (time > nextPotionAction) {
				nextPotionAction = time;
			}
		}
		bool canDoPotionAction() const {
			return nextPotionAction <= OTSYS_TIME();
		}

		void cancelPush();

		void setModuleDelay(uint8_t byteortype, int16_t delay) {
			moduleDelayMap[byteortype] = OTSYS_TIME() + delay;
		}

		bool canRunModule(uint8_t byteortype) {
			if (!moduleDelayMap[byteortype]) {
				return true;
			}
			return moduleDelayMap[byteortype] <= OTSYS_TIME();
		}

		time_t getNextForgeAction() {
			return nextForgeAction;
		}
		void nextNextForgeAction() {
			nextForgeAction = time(nullptr) + 2;
		}

		uint32_t getNextActionTime() const;
		uint32_t getNextPotionActionTime() const;

		Item* getWriteItem(uint32_t& windowTextId, uint16_t& maxWriteLen);
		void setWriteItem(Item* item, uint16_t maxWriteLen = 0);

		House* getEditHouse(uint32_t& windowTextId, uint32_t& listId);
		void setEditHouse(House* house, uint32_t listId = 0);

		void learnInstantSpell(const std::string& spellName);
		void forgetInstantSpell(const std::string& spellName);
		bool hasLearnedInstantSpell(const std::string& spellName) const;

		//Autoloot
		void addAutoLootItem(uint16_t itemId, uint16_t bpId);
		void removeAutoLootItem(uint16_t itemId);
		int32_t getAutoLootItem(uint16_t itemId);

		void setScheduledSaleUpdate(bool scheduled) {
			scheduledSaleUpdate = scheduled;
		}

		bool getScheduledSaleUpdate() {
			return scheduledSaleUpdate;
		}

		bool inPushEvent() {
			return inEventMovePush;
		}

		void pushEvent(bool b) {
			inEventMovePush = b;
		}

		bool walkExhausted() {
			if (hasCondition(CONDITION_PARALYZE)) {
				return lastWalking > OTSYS_TIME();
			}

			return false;
		}

		void setWalkExhaust(int64_t value) {
			lastWalking = OTSYS_TIME() + value;
		}

		const std::map<uint8_t, OpenContainer>& getOpenContainers() const {
			return openContainers;
		}

		std::multimap<uint16_t, uint8_t> getFusedItems() const;
		std::map<Item*, std::map<uint16_t, uint16_t>> getTransferItems() const;
		void reduceSpellCooldown(int32_t seconds);

		uint16_t getBaseXpGain() const {
			return baseXpGain;
		}
		void setBaseXpGain(uint16_t value) {
			baseXpGain = std::min<uint16_t>(std::numeric_limits<uint16_t>::max(), value);
		}
		uint16_t getVoucherXpBoost() const {
			return voucherXpBoost;
		}
		void setVoucherXpBoost(uint16_t value) {
			voucherXpBoost = std::min<uint16_t>(std::numeric_limits<uint16_t>::max(), value);
		}
		uint16_t getGrindingXpBoost() const {
			return grindingXpBoost;
		}
		void setGrindingXpBoost(uint16_t value) {
			grindingXpBoost = std::min<uint16_t>(std::numeric_limits<uint16_t>::max(), value);
		}
		uint16_t getStoreXpBoost() const {
			return storeXpBoost;
		}
		void setStoreXpBoost(uint16_t exp) {
			storeXpBoost = exp;
		}
		uint16_t getStaminaXpBoost() const {
			return staminaXpBoost;
		}
		void setStaminaXpBoost(uint16_t value) {
			staminaXpBoost = std::min<uint16_t>(std::numeric_limits<uint16_t>::max(), value);
		}

		void setExpBoostStamina(uint16_t stamina) {
			expBoostStamina = stamina;
		}

		uint16_t getExpBoostStamina() {
			return expBoostStamina;
		}

		int32_t getIdleTime() const {
			return idleTime;
		}

		uint32_t getItemTypeCountByTier(uint16_t itemId, int8_t tier, bool equiped = false) const;
		uint32_t getDepotItemCountByTier(uint16_t itemId, int8_t tier);
		Item* getItemTypeByTier(uint16_t itemId, int8_t tier);

		void setTraining(bool value);

		void onEquipImbueItem(Imbuement* imbuement);
		void onDeEquipImbueItem(Imbuement* imbuement);

		bool isMarketExhausted() const;
		void updateMarketExhausted() {
			lastMarketInteraction = OTSYS_TIME();
		}

		bool isNpcExhausted() const;
		void updateNpcExhausted();

		bool isQuickLootListedItem(const Item* item) const {
      if (!item) {
        return false;
      }

			auto it = std::find(quickLootListClientIds.begin(), quickLootListClientIds.end(), item->getClientID());
			return it != quickLootListClientIds.end();
		}

   		bool updateKillTracker(Container* corpse, const std::string& playerName, const Outfit_t creatureOutfit) const
 		{
  			if (client) {
				client->sendKillTrackerUpdate(corpse, playerName, creatureOutfit);
				return true;
 			}

			return false;
 		}

		void updateSupplyTracker(const Item* item) {
			if (client) {
				client->sendUpdateSupplyTracker(item);
			}
		}

		void updateImpactTracker(CombatType_t type, int32_t amount) {
			if (client) {
				client->sendUpdateImpactTracker(type, amount);
			}
		}
		void updateInputAnalyzer(CombatType_t type, int32_t amount, std::string target) {
			if (client) {
				client->sendUpdateInputAnalyzer(type, amount, target);
			}
		}

   		void updateLootTracker(Item* item)
 		{
  			if (client) {
 				client->sendUpdateLootTracker(item);
 			}
 		}

   		void createLeaderTeamFinder(NetworkMessage &msg)
 		{
  			if (client) {
 				client->createLeaderTeamFinder(msg);
 			}
 		}
   		void sendLeaderTeamFinder(bool reset)
 		{
  			if (client) {
 				client->sendLeaderTeamFinder(reset);
 			}
 		}
   		void sendTeamFinderList()
 		{
  			if (client) {
 				client->sendTeamFinderList();
 			}
 		}
		uint32_t getCharmPoints() {
			return charmPoints;
		}
		void setCharmPoints(uint32_t points) {
			charmPoints = points;
		}
		bool hasCharmExpansion() {
			return charmExpansion;
		}
		void setCharmExpansion(bool onOff) {
			charmExpansion = onOff;
		}
		void setUsedRunesBit(int32_t bit) {
			UsedRunesBit = bit;
		}
		int32_t getUsedRunesBit() {
			return UsedRunesBit;
		}
		void setUnlockedRunesBit(int32_t bit) {
			UnlockedRunesBit = bit;
		}
		int32_t getUnlockedRunesBit() {
			return UnlockedRunesBit;
		}
		void setImmuneCleanse(ConditionType_t conditiontype) {
			cleanseCondition.first = conditiontype;
			cleanseCondition.second = OTSYS_TIME() + 10000;
		}
		bool isImmuneCleanse(ConditionType_t conditiontype) {
			uint64_t timenow = OTSYS_TIME();
			if ((cleanseCondition.first == conditiontype) && (timenow <= cleanseCondition.second)) {
				return true;
			}
			return false;
		}
		uint16_t parseRacebyCharm(charmRune_t charmId, bool set, uint16_t newRaceid) {
			uint16_t raceid = 0;
		switch (charmId) {
			case CHARM_WOUND:
				if (set) { charmRuneWound = newRaceid; } else { raceid = charmRuneWound; }
				break;
			case CHARM_ENFLAME:
				if (set) { charmRuneEnflame = newRaceid; } else { raceid = charmRuneEnflame; }
				break;
			case CHARM_POISON:
				if (set) { charmRunePoison = newRaceid; } else { raceid = charmRunePoison; }
				break;
			case CHARM_FREEZE:
				if (set) { charmRuneFreeze = newRaceid; } else { raceid = charmRuneFreeze; }
				break;
			case CHARM_ZAP:
				if (set) { charmRuneZap = newRaceid; } else { raceid = charmRuneZap; }
				break;
			case CHARM_CURSE:
				if (set) { charmRuneCurse = newRaceid; } else { raceid = charmRuneCurse; }
				break;
			case CHARM_CRIPPLE:
				if (set) { charmRuneCripple = newRaceid; } else { raceid = charmRuneCripple; }
				break;
			case CHARM_PARRY:
				if (set) { charmRuneParry = newRaceid; } else { raceid = charmRuneParry; }
				break;
			case CHARM_DODGE:
				if (set) { charmRuneDodge = newRaceid; } else { raceid = charmRuneDodge; }
				break;
			case CHARM_ADRENALINE:
				if (set) { charmRuneAdrenaline = newRaceid; } else { raceid = charmRuneAdrenaline; }
				break;
			case CHARM_NUMB:
				if (set) { charmRuneNumb = newRaceid; } else { raceid = charmRuneNumb; }
				break;
			case CHARM_CLEANSE:
				if (set) { charmRuneCleanse = newRaceid; } else { raceid = charmRuneCleanse; }
				break;
			case CHARM_BLESS:
				if (set) { charmRuneBless = newRaceid; } else { raceid = charmRuneBless; }
				break;
			case CHARM_SCAVENGE:
				if (set) { charmRuneScavenge = newRaceid; } else { raceid = charmRuneScavenge; }
				break;
			case CHARM_GUT:
				if (set) { charmRuneGut = newRaceid; } else { raceid = charmRuneGut; }
				break;
			case CHARM_LOW:
				if (set) { charmRuneLowBlow = newRaceid; } else { raceid = charmRuneLowBlow; }
				break;
			case CHARM_DIVINE:
				if (set) { charmRuneDivine = newRaceid; } else { raceid = charmRuneDivine; }
				break;
			case CHARM_VAMP:
				if (set) { charmRuneVamp = newRaceid; } else { raceid = charmRuneVamp; }
				break;
			case CHARM_VOID:
				if (set) { charmRuneVoid = newRaceid; } else { raceid = charmRuneVoid; }
				break;
			default:
				raceid = 0;
				break;
		}
			return raceid;
		}

		uint16_t getFreeBackpackSlots() const;
		
		// Wheel of destiny - Checks:
		void onThinkWheelOfDestiny(bool force = false);
		void checkWheelOfDestinyGiftOfLife();
		bool checkWheelOfDestinyBattleInstinct();
		bool checkWheelOfDestinyPositionalTatics();
		bool checkWheelOfDestinyBallisticMastery();
		bool checkWheelOfDestinyCombatMastery();
		bool checkWheelOfDestinyDivineEmpowerment();
		int32_t checkWheelOfDestinyDrainBodyLeech(Creature* target, skills_t skill);
		int32_t checkWheelOfDestinyBeamMasteryDamage();
		int32_t checkWheelOfDestinyBattleHealingAmount();
		int32_t checkWheelOfDestinyBlessingGroveHealingByTarget(Creature* target);
		int32_t checkWheelOfDestinyTwinBurstByTarget(Creature* target);
		int32_t checkWheelOfDestinyExecutionersThrow(Creature* target);
		int32_t checkWheelOfDestinyAvatarSkill(WheelOfDestinyAvatarSkill_t skill) const;
		int32_t checkWheelOfDestinyFocusMasteryDamage() {
			if (getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_FOCUS_MASTERY) && getWheelOfDestinyOnThinkTimer(WHEEL_OF_DESTINY_ONTHINK_FOCUS_MASTERY) >= OTSYS_TIME()) {
				setWheelOfDestinyOnThinkTimer(WHEEL_OF_DESTINY_ONTHINK_FOCUS_MASTERY, 0);
				return 35;
			}
			return 0;
		}
		int32_t checkWheelOfDestinyElementSensitiveReduction(CombatType_t type) const {
			int32_t rt = 0;
			if (type == COMBAT_PHYSICALDAMAGE) {
				rt += getWheelOfDestinyMajorStatConditional("Ballistic Mastery", WHEEL_OF_DESTINY_MAJOR_PHYSICAL_DMG);
			} else if (type == COMBAT_HOLYDAMAGE) {
				rt += getWheelOfDestinyMajorStatConditional("Ballistic Mastery", WHEEL_OF_DESTINY_MAJOR_HOLY_DMG);
			}
			return rt;
		}
		// Wheel of destiny - General functions:
		void reduceAllSpellsCooldownTimer(int32_t value);
		void resetWheelOfDestinyUpgradedSpells() {
			for (const auto& spell : wheelOfDestinyLearnedSpellsSelected) {
				if (hasLearnedInstantSpell(spell)) {
					forgetInstantSpell(spell);
				}
			}
			wheelOfDestinyCreaturesNearby = 0;
			wheelOfDestinySpellsSelected.clear();
			wheelOfDestinyLearnedSpellsSelected.clear();
			for (int i = 0; i < static_cast<int>(WHEEL_OF_DESTINY_MAJOR_COUNT); i++) {
				setWheelOfDestinyMajorStat(static_cast<WheelOfDestinyMajor_t>(i), 0);
			}
			setWheelOfDestinyOnThinkTimer(WHEEL_OF_DESTINY_ONTHINK_FOCUS_MASTERY, 0);
		}
		void upgradeWheelOfDestinySpell(std::string name) {
			if (!hasLearnedInstantSpell(name)) {
				wheelOfDestinyLearnedSpellsSelected.push_back(name);
				learnInstantSpell(name);
			}
			if (wheelOfDestinySpellsSelected[name] == WHEEL_OF_DESTINY_SPELL_GRADE_NONE) {
				wheelOfDestinySpellsSelected[name] = WHEEL_OF_DESTINY_SPELL_GRADE_REGULAR;
			} else if (wheelOfDestinySpellsSelected[name] == WHEEL_OF_DESTINY_SPELL_GRADE_REGULAR) {
				wheelOfDestinySpellsSelected[name] = WHEEL_OF_DESTINY_SPELL_GRADE_UPGRADED;
			} else if (wheelOfDestinySpellsSelected[name] == WHEEL_OF_DESTINY_SPELL_GRADE_UPGRADED) {
				wheelOfDestinySpellsSelected[name] = WHEEL_OF_DESTINY_SPELL_GRADE_MAX;
			}
		}
		void downgradeWheelOfDestinySpell(std::string name) {
			if (wheelOfDestinySpellsSelected[name] == WHEEL_OF_DESTINY_SPELL_GRADE_NONE || wheelOfDestinySpellsSelected[name] == WHEEL_OF_DESTINY_SPELL_GRADE_REGULAR) {
				wheelOfDestinySpellsSelected.erase(name);
			} else if (wheelOfDestinySpellsSelected[name] == WHEEL_OF_DESTINY_SPELL_GRADE_UPGRADED) {
				wheelOfDestinySpellsSelected[name] = WHEEL_OF_DESTINY_SPELL_GRADE_REGULAR;
			} else if (wheelOfDestinySpellsSelected[name] == WHEEL_OF_DESTINY_SPELL_GRADE_MAX) {
				wheelOfDestinySpellsSelected[name] = WHEEL_OF_DESTINY_SPELL_GRADE_UPGRADED;
			}
		}
		// Wheel of destiny - Header set:
		void setWheelOfDestinyStage(WheelOfDestinyStage_t type, uint8_t value) {
			wheelOfDestinyStages[type] = value;
		}
		void setWheelOfDestinyOnThinkTimer(WheelOfDestinyOnThink_t type, int64_t time) {
			wheelOfDestinyOnThink[type] = time;
		}
		void setWheelOfDestinyMajorStat(WheelOfDestinyMajor_t type, int32_t value) {
			wheelOfDestinyMajorStats[type] = value;
		}
		void setWheelOfDestinyInstant(WheelOfDestinyInstant_t type, bool toggle) {
			wheelOfDestinyInstant[type] = toggle;
		}
		void setWheelOfDestinyStat(WheelOfDestinyStat_t type, int32_t value) {
			wheelOfDestinyStats[type] = value;
		}
		void setWheelOfDestinyResistance(CombatType_t type, int32_t value) {
			wheelOfDestinyResistance[combatTypeToIndex(type)] = value;
		}
		void setWheelOfDestinyInstant(std::string name, bool value) {
			if (name == "Battle Instinct") {
				setWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_BATTLE_INSTINCT, value);
				if (!getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_BATTLE_INSTINCT)) {
					setWheelOfDestinyMajorStat(WHEEL_OF_DESTINY_MAJOR_SHIELD, 0);
					setWheelOfDestinyMajorStat(WHEEL_OF_DESTINY_MAJOR_MELEE, 0);
				}
			} else if (name == "Battle Healing") {
				setWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_BATTLE_HEALING, value);
			} else if (name == "Positional Tatics") {
				setWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_POSITIONAL_TATICS, value);
				if (!getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_POSITIONAL_TATICS)) {
					setWheelOfDestinyMajorStat(WHEEL_OF_DESTINY_MAJOR_MAGIC, 0);
					setWheelOfDestinyMajorStat(WHEEL_OF_DESTINY_MAJOR_HOLY_RESISTANCE, 0);
				}
			} else if (name == "Ballistic Mastery") {
				setWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_BALLISTIC_MASTERY, value);
				if (!getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_BALLISTIC_MASTERY)) {
					setWheelOfDestinyMajorStat(WHEEL_OF_DESTINY_MAJOR_CRITICAL_DMG, 0);
					setWheelOfDestinyMajorStat(WHEEL_OF_DESTINY_MAJOR_PHYSICAL_DMG, 0);
					setWheelOfDestinyMajorStat(WHEEL_OF_DESTINY_MAJOR_HOLY_DMG, 0);
				}
			} else if (name == "Healing Link") {
				setWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_HEALING_LINK, value);
			} else if (name == "Runic Mastery") {
				setWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_RUNIC_MASTERY, value);
			} else if (name == "Focus Mastery") {
				setWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_FOCUS_MASTERY, value);
				if (!getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_FOCUS_MASTERY)) {
					setWheelOfDestinyOnThinkTimer(WHEEL_OF_DESTINY_ONTHINK_FOCUS_MASTERY, 0);
				}
			} else if (name == "Beam Mastery") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_BEAM_MASTERY, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_BEAM_MASTERY) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_BEAM_MASTERY, 0);
				}
			} else if (name == "Combat Mastery") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_COMBAT_MASTERY, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_COMBAT_MASTERY) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_COMBAT_MASTERY, 0);
				}
			} else if (name == "Gift of Life") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE, 0);
				}
			} else if (name == "Blessing of the Grove") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_BLESSING_OF_THE_GROVE, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_BLESSING_OF_THE_GROVE) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_BLESSING_OF_THE_GROVE, 0);
				}
			} else if (name == "Drain Body") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_DRAIN_BODY, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_DRAIN_BODY) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_DRAIN_BODY, 0);
				}
			} else if (name == "Divine Empowerment") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_DIVINE_EMPOWERMENT, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_DIVINE_EMPOWERMENT) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_DIVINE_EMPOWERMENT, 0);
				}
			} else if (name == "Twin Burst") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_TWIN_BURST, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_TWIN_BURST) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_TWIN_BURST, 0);
				}
			} else if (name == "Executioner's Thow") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_EXECUTIONERS_THROW, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_EXECUTIONERS_THROW) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_EXECUTIONERS_THROW, 0);
				}
			} else if (name == "Avatar of Light") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_LIGHT, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_LIGHT) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_LIGHT, 0);
				}
			} else if (name == "Avatar of Nature") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_NATURE, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_NATURE) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_NATURE, 0);
				}
			} else if (name == "Avatar of Steel") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_STEEL, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_STEEL) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_STEEL, 0);
				}
			} else if (name == "Avatar of Storm") {
				if (value) {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_STORM, getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_STORM) + 1);
				} else {
					setWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_STORM, 0);
				}
			}
		}
		void resetWheelOfDestinyResistance() {
			wheelOfDestinyResistance[COMBAT_COUNT] = { 0 };
		}
		// Wheel of destiny - Header get:
		bool getWheelOfDestinyInstant(WheelOfDestinyInstant_t type) const {
			return wheelOfDestinyInstant[type];
		}
		bool getWheelOfDestinyHealingLinkUpgrade(std::string spell) const {
			if (!getWheelOfDestinyInstant("Healing Link")) {
				return false;
			}
			if (spell == "Nature's Embrace" || spell == "Heal Friend") {
				return true;
			}
			return false;
		}
		uint8_t getWheelOfDestinyStage(WheelOfDestinyStage_t type) const {
			return wheelOfDestinyStages[type];
		}
		WheelOfDestinySpellGrade_t getWheelOfDestinySpellUpgrade(std::string name) const {
			for (const auto& [name_it, grade_it] : wheelOfDestinySpellsSelected) {
				if (name_it == name) {
					return grade_it;
				}
			}
			return WHEEL_OF_DESTINY_SPELL_GRADE_NONE;
		}
		int32_t getWheelOfDestinyMajorStat(WheelOfDestinyMajor_t type) const {
			return wheelOfDestinyMajorStats[type];
		}
		int32_t getWheelOfDestinyStat(WheelOfDestinyStat_t type) const {
			return wheelOfDestinyStats[type];
		}
		int32_t getWheelOfDestinyResistance(CombatType_t type) const {
			return wheelOfDestinyResistance[combatTypeToIndex(type)];
		}
		int32_t getWheelOfDestinyMajorStatConditional(std::string instant, WheelOfDestinyMajor_t major) const {
			return getWheelOfDestinyInstant(instant) ? getWheelOfDestinyMajorStat(major) : 0;
		}
		int64_t getWheelOfDestinyOnThinkTimer(WheelOfDestinyOnThink_t type) const {
			return wheelOfDestinyOnThink[type];
		}
		bool getWheelOfDestinyInstant(const std::string name) const {
			if (name == "Battle Instinct") {
				return getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_BATTLE_INSTINCT);
			} else if (name == "Battle Healing") {
				return getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_BATTLE_HEALING);
			} else if (name == "Positional Tatics") {
				return getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_POSITIONAL_TATICS);
			} else if (name == "Ballistic Mastery") {
				return getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_BALLISTIC_MASTERY);
			} else if (name == "Healing Link") {
				return getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_HEALING_LINK);
			} else if (name == "Runic Mastery") {
				return getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_RUNIC_MASTERY);
			} else if (name == "Focus Mastery") {
				return getWheelOfDestinyInstant(WHEEL_OF_DESTINY_INSTANT_FOCUS_MASTERY);
			} else if (name == "Beam Mastery") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_BEAM_MASTERY);
			} else if (name == "Combat Mastery") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_COMBAT_MASTERY);
			} else if (name == "Gift of Life") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE);
			} else if (name == "Blessing of the Grove") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_BLESSING_OF_THE_GROVE);
			} else if (name == "Drain Body") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_DRAIN_BODY);
			} else if (name == "Divine Empowerment") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_DIVINE_EMPOWERMENT);
			} else if (name == "Twin Burst") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_TWIN_BURST);
			} else if (name == "Executioner's Thow") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_EXECUTIONERS_THROW);
			} else if (name == "Avatar of Light") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_LIGHT);
			} else if (name == "Avatar of Nature") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_NATURE);
			} else if (name == "Avatar of Steel") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_STEEL);
			} else if (name == "Avatar of Storm") {
				return getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_AVATAR_OF_STORM);

			}

			return false;
		}
		// Wheel of destiny - Specific functions
		uint32_t getWheelOfDestinyGiftOfLifeTotalCooldown() const {
			if (getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE) == 1) {
				return 1 * 60 * 60 * 30;
			} else if (getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE) == 2) {
				return 1 * 60 * 60 * 20;
			} else if (getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE) == 3) {
				return 1 * 60 * 60 * 10;
			}
			return 0;
		}
		uint8_t getWheelOfDestinyGiftOfLifeOverkill() const {
			if (getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE) == 1) {
				return 20;
			} else if (getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE) == 2) {
				return 25;
			} else if (getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE) == 3) {
				return 30;
			}
			return 0;
		}
		uint8_t getWheelOfDestinyGiftOfLifeHeal() const {
			if (getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE) == 1) {
				return 20;
			} else if (getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE) == 2) {
				return 25;
			} else if (getWheelOfDestinyStage(WHEEL_OF_DESTINY_STAGE_GIFT_OF_LIFE) == 3) {
				return 30;
			}
			return 0;
		}
		int32_t getWheelOfDestinyGiftOfCooldown() const {
			int32_t rt = 0;
			getStorageValue(STORAGEVALUE_GIFT_OF_LIFE_COOLDOWN_WOD, rt);
			if (rt <= 0) {
				return 0;
			}
			return rt;
		}
		void setWheelOfDestinyGiftOfCooldown(int32_t value, bool isOnThink) {
			addStorageValue(STORAGEVALUE_GIFT_OF_LIFE_COOLDOWN_WOD, value, true);
			if (!isOnThink) {
				setWheelOfDestinyOnThinkTimer(WHEEL_OF_DESTINY_ONTHINK_GIFT_OF_LIFE, OTSYS_TIME() + 1000);
			}
		}
		void decreaseWheelOfDestinyGiftOfCooldown(int32_t value) {
			int32_t cooldown = getWheelOfDestinyGiftOfCooldown() - value;
			if (cooldown <= 0) {
				setWheelOfDestinyOnThinkTimer(WHEEL_OF_DESTINY_ONTHINK_GIFT_OF_LIFE, OTSYS_TIME() + 3600000);
				return;
			}
			setWheelOfDestinyOnThinkTimer(WHEEL_OF_DESTINY_ONTHINK_GIFT_OF_LIFE, OTSYS_TIME() + (value * 1000));
			setWheelOfDestinyGiftOfCooldown(cooldown, true);
		}
		void sendWheelOfDestinyGiftOfLifeCooldown() {
			if (client) {
				client->sendWheelOfDestinyGiftOfLifeCooldown();
			}
		}
		Spell* getWheelOfDestinyCombatDataSpell(CombatDamage& damage, Creature* target);


  /*****************************************************************************
   * Interfaces
   ****************************************************************************/
  error_t SetAccountInterface(account::Account *account);
  error_t GetAccountInterface(account::Account *account);

void sendMessageDialog(const std::string& message) const
		{
			if (client) {
				client->sendMessageDialog(message);
			}
		}

		// Prey system
		void initializePrey();

		void sendPreyData() const {
			if (client) {
				for (const PreySlot* slot : preys) {
					client->sendPreyData(slot);
				}

				client->sendResourcesBalance(getMoney(), getBankBalance(), getPreyCards());
			}
		}

		void sendPreyTimeLeft(const PreySlot* slot) const {
			if (g_config.getBoolean(ConfigManager::PREY_ENABLED) && client) {
				client->sendPreyTimeLeft(slot);
			}
		}

		void reloadPreySlot(PreySlot_t slotid) {
			if (g_config.getBoolean(ConfigManager::PREY_ENABLED) && client) {
				client->sendPreyData(getPreySlotById(slotid));
				client->sendResourcesBalance(getMoney(), getBankBalance(), getPreyCards(), getTaskHuntingPoints());
			}
		}

		PreySlot* getPreySlotById(PreySlot_t slotid) {
			if (auto it = std::find_if(preys.begin(), preys.end(), [slotid](const PreySlot* preyIt) {
					return preyIt->id == slotid;
				}); it != preys.end()) {
				return *it;
			}

			return nullptr;
		}

		bool setPreySlotClass(PreySlot* slot) {
			if (getPreySlotById(slot->id)) {
				return false;
			}

			preys.push_back(slot);
			return true;
		}

		bool usePreyCards(uint16_t amount) {
			if (preyCards < amount) {
				return false;
			}

			preyCards -= amount;
			if (client) {
				client->sendResourcesBalance(getMoney(), getBankBalance(), getPreyCards(), getTaskHuntingPoints());
			}
			return true;
		}

		void addPreyCards(uint64_t amount) {
			preyCards += amount;
			if (client) {
				client->sendResourcesBalance(getMoney(), getBankBalance(), getPreyCards(), getTaskHuntingPoints());
			}
		}

		uint64_t getPreyCards() const {
			return preyCards;
		}

		uint32_t getPreyRerollPrice() const {
			return getLevel() * g_config.getNumber(ConfigManager::PREY_REROLL_PRICE_LEVEL);
		}

		std::vector<uint16_t> getPreyBlackList() const {
			std::vector<uint16_t> rt;
			for (const PreySlot* slot : preys) {
				if (slot) {
					if (slot->isOccupied()) {
						rt.push_back(slot->selectedRaceId);
					}
					for (uint16_t raceId : slot->raceIdList) {
						rt.push_back(raceId);
					}
				}
			}

			return rt;
		}

		PreySlot* getPreyWithMonster(uint16_t raceId) const {
			if (!g_config.getBoolean(ConfigManager::PREY_ENABLED)) {
				return nullptr;
			}

			if (auto it = std::find_if(preys.begin(), preys.end(), [raceId](const PreySlot* it) {
					return it->selectedRaceId == raceId;
				}); it != preys.end()) {
				return *it;
			}

			return nullptr;
		}

		// Task hunting system
		void initializeTaskHunting();
		bool isCreatureUnlockedOnTaskHunting(const MonsterType* mtype) const;

		bool setTaskHuntingSlotClass(TaskHuntingSlot* slot) {
			if (getTaskHuntingSlotById(slot->id)) {
				return false;
			}

			taskHunting.push_back(slot);
			return true;
		}

		void reloadTaskSlot(PreySlot_t slotid) {
			if (g_config.getBoolean(ConfigManager::TASK_HUNTING_ENABLED) && client) {
				client->sendTaskHuntingData(getTaskHuntingSlotById(slotid));
				client->sendResourcesBalance(getMoney(), getBankBalance(), getPreyCards(), getTaskHuntingPoints());
			}
		}

		TaskHuntingSlot* getTaskHuntingSlotById(PreySlot_t slotid) {
			if (auto it = std::find_if(taskHunting.begin(), taskHunting.end(), [slotid](const TaskHuntingSlot* itTask) {
					return itTask->id == slotid;
				}); it != taskHunting.end()) {
				return *it;
			}

			return nullptr;
		}

		std::vector<uint16_t> getTaskHuntingBlackList() const {
			std::vector<uint16_t> rt;
			std::for_each(taskHunting.begin(), taskHunting.end(), [&rt](const TaskHuntingSlot* slot)
			{
				if (slot->isOccupied()) {
					rt.push_back(slot->selectedRaceId);
				} else {
					std::for_each(slot->raceIdList.begin(), slot->raceIdList.end(), [&rt](uint16_t raceId)
					{
						rt.push_back(raceId);
					});
				}
				});

			return rt;
		}


		void sendTaskHuntingData() const {
			if (client) {
				client->sendResourcesBalance(getMoney(), getBankBalance(), getPreyCards(), getTaskHuntingPoints());
				for (const TaskHuntingSlot* slot : taskHunting) {
					if (slot) {
						client->sendTaskHuntingData(slot);
					}
				}
			}
		}

		void addTaskHuntingPoints(uint16_t amount) {
			taskHuntingPoints += amount;
			if (client) {
				client->sendResourcesBalance(getMoney(), getBankBalance(), getPreyCards(), getTaskHuntingPoints());
			}
		}

		bool useTaskHuntingPoints(uint64_t amount) {
			if (taskHuntingPoints < amount) {
				return false;
			}

			taskHuntingPoints -= amount;
			if (client) {
				client->sendResourcesBalance(getMoney(), getBankBalance(), getPreyCards(), getTaskHuntingPoints());
			}
			return true;
		}

		uint64_t getTaskHuntingPoints() const {
			return taskHuntingPoints;
		}

		uint32_t getTaskHuntingRerollPrice() const {
			return getLevel() * g_config.getNumber(ConfigManager::TASK_HUNTING_REROLL_PRICE_LEVEL);
		}

		TaskHuntingSlot* getTaskHuntingWithCreature(uint16_t raceId) const {
			if (!g_config.getBoolean(ConfigManager::TASK_HUNTING_ENABLED)) {
				return nullptr;
			}

			if (auto it = std::find_if(taskHunting.begin(), taskHunting.end(), [raceId](const TaskHuntingSlot* itTask) {
					return itTask->selectedRaceId == raceId;
				}); it != taskHunting.end()) {
				return *it;
			}

			return nullptr;
		}

 private:
		std::forward_list<Condition*> getMuteConditions() const;

		void checkTradeState(const Item* item);
		bool hasCapacity(const Item* item, uint32_t count) const;

		void checkLootContainers(const Item* item);

		void gainExperience(uint64_t exp, Creature* source);
		void addExperience(Creature* source, uint64_t exp, bool sendText = false);
		void removeExperience(uint64_t exp, bool sendText = false);

		void updateInventoryWeight();

		void setNextWalkActionTask(SchedulerTask* task);
		void setNextWalkTask(SchedulerTask* task);
		void setNextActionTask(SchedulerTask* task, bool resetIdleTime = true);
		void setNextActionPushTask(SchedulerTask* task);
		void setNextPotionActionTask(SchedulerTask* task);

		void death(Creature* lastHitCreature) override;
		bool dropCorpse(Creature* lastHitCreature, Creature* mostDamageCreature, bool lastHitUnjustified, bool mostDamageUnjustified) override;
		Item* getCorpse(Creature* lastHitCreature, Creature* mostDamageCreature) override;

		// KooldownAid Potion
		void resetSpellsCooldown();

		//cylinder implementations
		ReturnValue queryAdd(int32_t index, const Thing& thing, uint32_t count,
				uint32_t flags, Creature* actor = nullptr) const override;
		ReturnValue queryMaxCount(int32_t index, const Thing& thing, uint32_t count, uint32_t& maxQueryCount,
				uint32_t flags) const override;
		ReturnValue queryRemove(const Thing& thing, uint32_t count, uint32_t flags, Creature* actor = nullptr) const override;
		Cylinder* queryDestination(int32_t& index, const Thing& thing, Item** destItem,
				uint32_t& flags) override;

		void addThing(Thing*) override {}
		void addThing(int32_t index, Thing* thing) override;

		void updateThing(Thing* thing, uint16_t itemId, uint32_t count) override;
		void replaceThing(uint32_t index, Thing* thing) override;

		void removeThing(Thing* thing, uint32_t count) override;

		int32_t getThingIndex(const Thing* thing) const override;
		size_t getFirstIndex() const override;
		size_t getLastIndex() const override;
		uint32_t getItemTypeCount(uint16_t itemId, int32_t subType = -1) const override;
		void stashContainer(StashContainerList itemDict);
		std::map<uint32_t, uint32_t>& getAllItemTypeCount(std::map<uint32_t, uint32_t>& countMap) const override;
		void getAllItemType(std::multimap<uint16_t, uint8_t>& countMap) const;
		Item* getItemByClientId(uint16_t clientId) const;
		std::map<uint16_t, uint16_t> getInventoryClientIds() const;
    void getAllItemTypeCountAndSubtype(std::map<uint32_t, uint32_t>& countMap) const;
		Thing* getThing(size_t index) const override;

		void internalAddThing(Thing* thing) override;
		void internalAddThing(uint32_t index, Thing* thing) override;

		std::unordered_set<uint32_t> attackedSet;

		 //Autoloot
		std::unordered_map<uint16_t, uint16_t> autoLootMap;
		// std::unordered_set<uint32_t> autoLootList;
		//std::unordered_set<uint32_t> autoLootList; (use this if you have ubuntu 16+)

		std::unordered_set<uint32_t> VIPList;

		std::map<uint8_t, OpenContainer> openContainers;
		std::map<uint32_t, DepotLocker*> depotLockerMap;
		std::map<uint32_t, DepotChest*> depotChests;
		std::map<uint8_t, int64_t> moduleDelayMap;
		std::map<uint32_t, int32_t> storageMap;

		std::map<uint32_t, Reward*> rewardMap;
		
		std::map<uint8_t, uint16_t> maxValuePerSkill = {
			{SKILL_LIFE_LEECH_CHANCE, 100},
			{SKILL_MANA_LEECH_CHANCE, 100},
			{SKILL_CRITICAL_HIT_CHANCE, g_config.getNumber(ConfigManager::CRITICALCHANCE)}
		};

		std::map<ObjectCategory_t, Container*> quickLootContainers;
		std::vector<uint16_t> quickLootListClientIds;

		std::vector<OutfitEntry> outfits;
		std::vector<FamiliarEntry> familiars;

		std::vector<PreySlot*> preys;
		std::vector<TaskHuntingSlot*> taskHunting;

		GuildWarVector guildWarVector;

		std::vector<ShopInfo> shopItemList;

		std::forward_list<Party*> invitePartyList;
		std::forward_list<uint32_t> modalWindows;
		std::forward_list<std::string> learnedInstantSpellList;
		std::forward_list<Condition*> storedConditionList; // TODO: This variable is only temporarily used when logging in, get rid of it somehow

		std::list<MonsterType*> BestiaryTracker;

		std::string name;
		std::string guildNick;

		Skill skills[SKILL_LAST + 1];
		LightInfo itemsLight;
		Position loginPosition;
		Position lastWalkthroughPosition;

		time_t lastLoginSaved = 0;
		time_t lastLogout = 0;

		uint64_t experience = 0;
		uint64_t manaSpent = 0;
		uint64_t lastAttack = 0;
		uint64_t bankBalance = 0;
		uint64_t lastQuestlogUpdate = 0;
		uint64_t preyCards = 0;
		uint64_t taskHuntingPoints = 0;
		int64_t lastFailedFollow = 0;
		int64_t skullTicks = 0;
		int64_t lastWalkthroughAttempt = 0;
		int64_t lastToggleMount = 0;
		int64_t lastMarketInteraction = 0;  //Custom: Anti bug do market
		int64_t lastNpcInteraction = 0;
		int64_t lastStashInteraction = 0;
		int64_t lastPing;
		int64_t lastPong;
		int64_t nextAction = 0;
		int64_t nextPotionAction = 0;
		int64_t lastQuickLootNotification = 0;
		int64_t lastWalking = 0;
		uint64_t asyncOngoingTasks = 0;
		
		// Wheel of destiny
		uint8_t wheelOfDestinyStages[WHEEL_OF_DESTINY_STAGE_COUNT] = { 0 };
		int64_t wheelOfDestinyOnThink[WHEEL_OF_DESTINY_ONTHINK_COUNT] = { 0 };
		int32_t wheelOfDestinyStats[WHEEL_OF_DESTINY_STAT_COUNT] = { 0 };
		int32_t wheelOfDestinyMajorStats[WHEEL_OF_DESTINY_MAJOR_COUNT] = { 0 };
		bool wheelOfDestinyInstant[WHEEL_OF_DESTINY_INSTANT_COUNT] = { false };
		int32_t wheelOfDestinyResistance[COMBAT_COUNT] = { 0 };
		int32_t wheelOfDestinyCreaturesNearby = 0;
		std::map<std::string, WheelOfDestinySpellGrade_t> wheelOfDestinySpellsSelected;
		std::vector<std::string> wheelOfDestinyLearnedSpellsSelected;

		std::vector<Kill> unjustifiedKills;
		std::multimap<uint16_t, uint8_t> hotkeyItems;

		BedItem* bedItem = nullptr;
		Guild* guild = nullptr;
		GuildRank_ptr guildRank;
		Group* group = nullptr;
		Inbox* inbox;
		Item* imbuing = nullptr; // for intarnal use
		Item* tradeItem = nullptr;
 		Item* inventory[CONST_SLOT_LAST + 1] = {};
		Item* writeItem = nullptr;
		House* editHouse = nullptr;
		Npc* shopOwner = nullptr;
		Party* party = nullptr;
		Player* tradePartner = nullptr;
		ProtocolGame_ptr client;
		SchedulerTask* walkTask = nullptr;
		Town* town = nullptr;
		Vocation* vocation = nullptr;
		RewardChest* rewardChest = nullptr;

		uint32_t inventoryWeight = 0;
		uint32_t capacity = 40000;
		uint32_t bonusCapacity = 0;
		uint32_t damageImmunities = 0;
		uint32_t conditionImmunities = 0;
		uint32_t conditionSuppressions = 0;
		uint32_t level = 1;
		uint32_t magLevel = 0;
		uint32_t actionTaskEvent = 0;
		uint32_t actionTaskEventPush = 0;
		uint32_t actionPotionTaskEvent = 0;
		uint32_t nextStepEvent = 0;
		uint32_t walkTaskEvent = 0;
		uint32_t MessageBufferTicks = 0;
		uint32_t lastIP = 0;
		uint32_t accountNumber = 0;
		uint32_t guid = 0;
		uint8_t isDailyReward = DAILY_REWARD_NOTCOLLECTED;
		uint32_t windowTextId = 0;
		uint32_t editListId = 0;
		uint32_t manaMax = 0;
		int32_t varSkills[SKILL_LAST + 1] = {};
		int32_t varStats[STAT_LAST + 1] = {};
		int32_t purchaseCallback = -1;
		int32_t saleCallback = -1;
		int32_t MessageBufferCount = 0;
		uint32_t premiumDays = 0;
		int32_t bloodHitCount = 0;
		int32_t shieldBlockCount = 0;
		int32_t offlineTrainingSkill = -1;
		int32_t offlineTrainingTime = 0;
		int32_t idleTime = 0;
		uint32_t coinBalance = 0;
		uint32_t tournamentCoinBalance = 0;
		uint16_t expBoostStamina = 0;

		uint16_t lastStatsTrainingTime = 0;
		uint16_t staminaMinutes = 2520;
		std::vector<uint8_t> blessings = { 0, 0, 0, 0, 0, 0, 0, 0 };
		uint16_t maxWriteLen = 0;
		uint16_t baseXpGain = 100;
		uint16_t voucherXpBoost = 0;
		uint16_t grindingXpBoost = 0;
		uint16_t storeXpBoost = 0;
		uint16_t staminaXpBoost = 100;
		int16_t lastDepotId = -1;
		StashItemList stashItems; // [ClientID] = amount

		// Bestiary
		bool charmExpansion = false;
		uint16_t charmRuneWound = 0;
		uint16_t charmRuneEnflame = 0;
		uint16_t charmRunePoison = 0;
		uint16_t charmRuneFreeze = 0;
		uint16_t charmRuneZap = 0;
		uint16_t charmRuneCurse = 0;
		uint16_t charmRuneCripple = 0;
		uint16_t charmRuneParry = 0;
		uint16_t charmRuneDodge = 0;
		uint16_t charmRuneAdrenaline = 0;
		uint16_t charmRuneNumb = 0;
		uint16_t charmRuneCleanse = 0;
		uint16_t charmRuneBless = 0;
		uint16_t charmRuneScavenge = 0;
		uint16_t charmRuneGut = 0;
		uint16_t charmRuneLowBlow = 0;
		uint16_t charmRuneDivine = 0;
		uint16_t charmRuneVamp = 0;
		uint16_t charmRuneVoid = 0;
		uint32_t charmPoints = 0;
		int32_t UsedRunesBit = 0;
		int32_t UnlockedRunesBit = 0;
		std::pair<ConditionType_t, uint64_t> cleanseCondition = {CONDITION_NONE, 0};

		time_t nextForgeAction = 0;
		uint16_t lastMomentumTime = 0;
		double varSpecial[SPECIAL_LAST + 1] = {};

		uint8_t maxDust = 0;
		uint8_t dust = 0;
		uint8_t soul = 0;
		uint8_t levelPercent = 0;
		double_t magLevelPercent = 0;

		PlayerSex_t sex = PLAYERSEX_FEMALE;
		OperatingSystem_t operatingSystem = CLIENTOS_NONE;
		BlockType_t lastAttackBlockType = BLOCK_NONE;
		tradestate_t tradeState = TRADE_NONE;
		fightMode_t fightMode = FIGHTMODE_ATTACK;
		account::AccountType accountType = account::AccountType::ACCOUNT_TYPE_NORMAL;
		QuickLootFilter_t quickLootFilter;
		VipStatus_t statusVipList = VIPSTATUS_ONLINE;

		bool chaseMode = false;
		bool secureMode = true;
		bool inMarket = false;
		bool wasMounted = false;
		bool ghostMode = false;
		bool pzLocked = false;
		bool isConnecting = false;
		bool addAttackSkillPoint = false;
		bool inventoryAbilities[CONST_SLOT_LAST + 1] = {};
		bool quickLootFallbackToMainContainer = false;
		bool logged = false;
		bool scheduledSaleUpdate = false;
		bool inEventMovePush = false;
		bool supplyStash = false; // Menu option 'stow, stow container ...'
		bool marketMenu = false; // Menu option 'show in market'
		bool exerciseTraining = false;
		bool DromeCharmUpgrade = false;
		bool customVip = false;

		std::vector<ExaltedHistory> forgeHistory;

		int16_t reflectPercent[COMBAT_COUNT] = { 0 };
		int32_t reflectFlat[COMBAT_COUNT] = { 0 };
		int32_t specializedMagicLevel[COMBAT_COUNT] = { 0 };
		int16_t cleavePercent = 0;
		std::map<uint8_t, int32_t> perfectShot;
		int32_t magicShieldCapacityFlat = 0;
		int16_t magicShieldCapacityPercent = 0;

		static uint32_t playerAutoID;

		void updateItemsLight(bool internal = false);
		int32_t getStepSpeed() const override {
			return std::max<int32_t>(PLAYER_MIN_SPEED, std::min<int32_t>(PLAYER_MAX_SPEED, getSpeed()));
		}
		void updateBaseSpeed() {
			if (!hasFlag(PlayerFlag_SetMaxSpeed)) {
				baseSpeed = vocation->getBaseSpeed() + (2 * (level - 1));
			} else {
				baseSpeed = PLAYER_MAX_SPEED;
			}
		}

		bool isPromoted() const;

		uint32_t getAttackSpeed() const {
			return vocation->getAttackSpeed();
		}

		static double_t getPercentLevel(uint64_t count, uint64_t nextLevelCount);
		double getLostPercent() const;
		uint64_t getLostExperience() const override {
			return skillLoss ? static_cast<uint64_t>(experience * getLostPercent()) : 0;
		}
		uint32_t getDamageImmunities() const override {
			return damageImmunities;
		}
		uint32_t getConditionImmunities() const override {
			return conditionImmunities;
		}
		uint32_t getConditionSuppressions() const override {
			return conditionSuppressions;
		}
		uint16_t getLookCorpse() const override;
		void getPathSearchParams(const Creature* creature, FindPathParams& fpp) const override;

		friend class Game;
		friend class Npc;
		friend class LuaScriptInterface;
		friend class Map;
		friend class Actions;
		friend class IOLoginData;
		friend class ProtocolGame;
		friend class Forge;
		friend class Combat;

  account::Account *account_;
};

#endif  // SRC_PLAYER_H_
