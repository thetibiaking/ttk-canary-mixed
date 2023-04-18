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

#ifndef FS_PARTY_H_41D4D7CF417C4CC99FAE94D552255044
#define FS_PARTY_H_41D4D7CF417C4CC99FAE94D552255044

#include "creatures/players/player.h"
#include "creatures/monsters/monsters.h"

class Player;
class Party;

struct LootInfo_t {
	uint64_t itemValue = 0;
	uint32_t itemCount = 0;
};

struct PartyStatatistic_t {
	bool active = true;

	std::map<uint16_t, LootInfo_t> lootedItems;

	uint64_t lootBalance = 0;
	uint64_t supplyWaste = 0;
	uint64_t damageDealt = 0;
	uint64_t incomingHeal = 0;
};

using PartyMap = std::map<uint32_t, PartyStatatistic_t>;
using PlayerVector = std::vector<Player*>;
using ActiveVector = std::vector<uint32_t>;

class Party
{
	public:
		explicit Party(Player* leader);

		Player* getLeader() const {
			return leader;
		}
		PlayerVector& getMembers() {
			return memberList;
		}
		const PlayerVector& getInvitees() const {
			return inviteList;
		}
		ActiveVector& getActiveMembers() {
			return activeList;
		}
		size_t getMemberCount() const {
			return memberList.size();
		}
		size_t getInvitationCount() const {
			return inviteList.size();
		}
		PartyMap getInformation() {
			return informationMap;
		}

		void disband();
		bool invitePlayer(Player& player);
		bool joinParty(Player& player);
		void revokeInvitation(Player& player);
		bool passPartyLeadership(Player* player);
		bool leaveParty(Player* player);

		bool removeInvite(Player& player, bool removeFromPlayer = true);

		bool isPlayerInvited(const Player* player) const;
		void updateAllPartyIcons();
		void broadcastPartyMessage(MessageClasses msgClass, const std::string& msg, bool sendToInvitations = false);
		bool empty() const {
			return memberList.empty() && inviteList.empty();
		}
		bool canOpenCorpse(uint32_t ownerId) const;

		void shareExperience(uint64_t experience, Creature* source = nullptr);
		bool setSharedExperience(Player* player, bool sharedExpActive);
		bool isSharedExperienceActive() const {
			return sharedExpActive;
		}
		bool isSharedExperienceEnabled() const {
			return sharedExpEnabled;
		}
		bool canUseSharedExperience(const Player* player) const;
		void updateSharedExperience();
		void updateInformation(Player* player, PartyInfoType info, Item* item = nullptr, int32_t value = 0);
		int32_t getCreateTime() {
			return OTS_TIME() - createTime;
		}
		void setPartyLootMode(uint8_t lootType);
		void setLootMode(uint8_t value) {
			lootMode = value;
		}
		uint8_t getLootMode() {
			return lootMode;
		}
		uint64_t getLootBalanceByPlayer(uint32_t playerId) {
			return informationMap[playerId].lootBalance;
		}
		void updateLeaderItems(std::map<uint16_t, uint64_t> list);

		void updatePlayerTicks(Player* player, uint64_t points);
		void clearPlayerPoints(Player* player);
		void clearInformation();
		void gainExaltedDust(uint16_t dust);

		void showPlayerStatus(Player* player, Player* member, bool showStatus);
		void updatePlayerStatus(Player* player);
		void updatePlayerStatus(Player* player, const Position& oldPos, const Position& newPos);
		void updatePlayerHealth(const Player* player, const Creature* target, uint8_t healthPercent);
		void updatePlayerMana(const Player* player, uint8_t manaPercent);
		void updatePlayerVocation(const Player* player);

		bool hasInformation = false;

	private:
		std::map<uint32_t, int64_t> ticksMap;
		ActiveVector activeList;

		PlayerVector memberList;
		PlayerVector inviteList;

		PartyMap informationMap;
		std::map<uint16_t, uint64_t> leaderList;

		Player* leader = nullptr;
		uint8_t lootMode = 0;

		bool sharedExpActive = false;
		bool sharedExpEnabled = false;
		bool canEnableSharedExperience();

		int32_t createTime;
};

#endif
