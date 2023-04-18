/*
Credits - Rick(FakeShinoda)
#2021
*/

#ifndef FS_EXALTED_FORGE_H
#define FS_EXALTED_FORGE_H

#include "utils/tools.h"
#include "utils/enums.h"
#include "creatures/players/player.h"

struct ExaltedConfig {
	uint8_t dustPercent;
	uint8_t dustToSleaver;
	uint8_t sliverToCore;
	uint8_t dustPercentUpgrade;
	uint8_t minDustCap;
	uint8_t maxDustCap;
	uint8_t dustFusion;
	uint8_t dustTransfer;
	uint8_t chanceBase;
	uint8_t chanceImproved;
	uint8_t reduceTierLoss;
	uint8_t bonusChance;
};

struct MonsterConfig {
	uint8_t healthPercentStack = 0;
	uint8_t damagePerStack = 0;
	uint8_t armorPerStack = 0;
	uint8_t maxFiendishCount = 0;
};

struct ExaltedCategory {
	uint8_t tier;
	uint64_t price;
	double weaponBonus = 0.00f;
	double helmetBonus = 0.00f;
	double armorBonus;
};

class Forge {
	public:
		bool loadFromXml();
		void appendToHistory(Player* player, ForgeAction_t action, std::string message, uint8_t error = 0x00);
		void processFusion(Player* player, uint16_t primaryItemID, uint16_t secondaryItemID, uint8_t itemTier, bool improveSucess, bool reduceLoss);
		void processTransfer(Player* player, uint16_t primaryItemID, uint16_t secondaryItemID, uint8_t itemTier);

		ExaltedForgeBonus_t generateForgeBonus(bool sucess);

		std::map<uint16_t, std::vector<ExaltedCategory>>& getCategories() {
			return exaltedCategories;
		}

		void removeMoney(Player* player, uint16_t classification, uint8_t tier);
		void removeExaltedCore(Player* player, uint8_t count);
		void broadcastFusionMessage(uint32_t playerId, bool sucess, bool itemLoss, bool tierLoss, uint16_t itemId, uint16_t tier);
		void broadcastTransferMessage(uint32_t playerId, uint16_t primaryItemId, uint8_t primaryItemTier, uint16_t secondaryItemId);
		bool itemCanBeFused(uint16_t itemCategory, uint16_t itemUpgrade);

		ExaltedConfig getExaltedConfig() const {
			return configuration;
		}
		MonsterConfig getMonsterConfig() const {
			return monsterConfiguration;
		}

		double getWeaponBonus(uint8_t classification, uint8_t tier);
		double getHelmetBonus(uint8_t classification, uint8_t tier);
		double getArmorBonus(uint8_t classification, uint8_t tier);

		void convertDust(Player* player);
		void convertSliver(Player* player);
		void raiseDustLimit(Player* player);

	private:
		MonsterConfig monsterConfiguration;
		ExaltedConfig configuration;

		std::map<uint16_t, std::vector<ExaltedCategory>> exaltedCategories;
};

#endif
