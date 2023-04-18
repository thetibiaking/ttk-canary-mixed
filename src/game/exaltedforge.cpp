/*
Credits - Rick(FakeShinoda)
#2021
*/

#include "otpch.h"

#include "game/exaltedforge.h"
#include "utils/pugicast.h"
#include "game/game.h"
#include "game/scheduling/scheduler.h"

extern Game g_game;

bool Forge::loadFromXml()
{
	pugi::xml_document file;
	pugi::xml_parse_result result = file.load_file("data/XML/exaltedforge.xml");
	if (!result) {
		printXMLError("Error - ExaltedForge::loadFromXml", "data/XML/exaltedforge.xml", result);
		return  false;
	}

	for (auto baseNode : file.child("exaltedforge").children()) {
		pugi::xml_attribute attr;
		if (strcasecmp(baseNode.name(), "monster") == 0) {
			if ((attr = baseNode.attribute("healthPercentStack"))) {
				monsterConfiguration.healthPercentStack = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("damagePerStack"))) {
				monsterConfiguration.damagePerStack = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("armorPerStack"))) {
				monsterConfiguration.armorPerStack = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("maxFiendishCount"))) {
				monsterConfiguration.maxFiendishCount = pugi::cast<uint16_t>(attr.value());
			}
		} else if (strcasecmp(baseNode.name(), "config") == 0) {
			if ((attr = baseNode.attribute("dustPercent"))) {
				configuration.dustPercent = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("dustToSleaver"))) {
				configuration.dustToSleaver = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("sliverToCore"))) {
				configuration.sliverToCore = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("dustPercentUpgrade"))) {
				configuration.dustPercentUpgrade = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("minDustCap"))) {
				configuration.minDustCap = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("maxDustCap"))) {
				configuration.maxDustCap = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("dustFusion"))) {
				configuration.dustFusion = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("dustTransfer"))) {
				configuration.dustTransfer = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("chanceBase"))) {
				configuration.chanceBase = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("chanceImproved"))) {
				configuration.chanceImproved = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("reduceTierLoss"))) {
				configuration.reduceTierLoss = pugi::cast<uint16_t>(attr.value());
			} else if ((attr = baseNode.attribute("bonusChance"))) {
				configuration.bonusChance = pugi::cast<uint16_t>(attr.value());
			}
		} else if (strcasecmp(baseNode.name(), "item") == 0) {
			uint16_t upgradeClass = pugi::cast<uint16_t>(baseNode.attribute("class").value());
			std::vector<ExaltedCategory> info;

			for (auto childNode : baseNode.children()) {
				if (strcasecmp(childNode.name(), "info") == 0) {
					ExaltedCategory category;
					category.tier = pugi::cast<uint32_t>(childNode.attribute("tier").value());
					category.price = pugi::cast<uint64_t>(childNode.attribute("price").value());
					category.weaponBonus = pugi::cast<double>(childNode.attribute("weaponBonus").value());
					category.helmetBonus = pugi::cast<double>(childNode.attribute("helmetBonus").value());
					category.armorBonus = pugi::cast<double>(childNode.attribute("armorBonus").value());

					info.emplace_back(category);
				}
			}

			exaltedCategories.emplace(upgradeClass, info);
		}
	}

	return true;
}

bool Forge::itemCanBeFused(uint16_t itemCategory, uint16_t itemUpgrade)
{
	auto it = exaltedCategories.find(itemCategory);
	if (it != exaltedCategories.end()) {
		if (itemUpgrade < (*it).second.size()) {
			return true;
		}
	}
	return false;
}

void Forge::processFusion(Player* player, uint16_t primaryItemID, uint16_t secondaryItemID, uint8_t itemTier, bool improveSucess, bool reduceLoss)
{
	if (!player) {
		return;
	}

	Item* inventoryItem = player->inventory[CONST_SLOT_BACKPACK];
	if (!inventoryItem) {
		player->sendCancelMessage(RETURNVALUE_NOTENOUGHROOM);
		return;
	}

	Container* container = inventoryItem->getContainer();
	if (!container) {
		return;
	}

	std::vector<Item*> targetItems;
	const ItemType& iType = Item::items.getItemType(primaryItemID);
	
	for (ContainerIterator it = container->iterator(); it.hasNext(); it.advance()) {
		Item* item = (*it);
		if (!item) {
			continue;
		}
			
		if (!item->hasMarketAttributes() || item->getID() != primaryItemID || item->getBoost() != itemTier) {
			continue;
		}

		targetItems.emplace_back(item);
		if (targetItems.size() == 2) {
			break;
		}
	}

	if (targetItems.size() != 2) {
		player->sendFYIBox("You cannot forge an imbued item.");
		return;
	}

	Item* exaltedItem = Item::CreateItem(ITEM_EXALTED_CHEST);
	if (!exaltedItem) {
		return;
	}

	Container* exaltedChest = exaltedItem->getContainer();
	if (!exaltedChest) {
		g_game.ReleaseItem(exaltedItem);
		return;
	}

	uint32_t playerCap = player->getFreeCapacity();
	if (playerCap <= (targetItems[0]->getWeight() + targetItems[1]->getWeight() + exaltedItem->getWeight())) {
		player->sendCancelMessage(RETURNVALUE_NOTENOUGHCAPACITY);
		g_game.ReleaseItem(exaltedItem);
		return;
	}

	g_game.internalRemoveItem(targetItems.front(), 1);
	g_game.internalRemoveItem(targetItems.back(), 1);

	ReturnValue exaltedRet = g_game.internalAddItem(player, exaltedChest);
	if (exaltedRet != RETURNVALUE_NOERROR) {
		appendToHistory(player, FORGEACTION_FUSION, "Failed to send exalted chest to player.", 1);
		g_game.ReleaseItem(exaltedItem);
		return;
	}

	uint8_t sucessChance = (improveSucess ? configuration.chanceBase + configuration.chanceImproved : configuration.chanceBase);
	
	if (player->hasCustomVip() && sucessChance < 100) {
		sucessChance += 20; // more 20% chance for vip players
		if (sucessChance > 100) {
			sucessChance = 100;
		}
	}
	
	bool sucess = (rand() % 100 <= sucessChance);

	ExaltedForgeBonus_t bonus = generateForgeBonus(sucess);
	uint8_t bonusInfo = 0;

	if (bonus == BONUS_KEEP_TIER_SUCESS && itemTier == 0) {
		bonus = BONUS_NULL;
	} else if (bonus == BONUS_CORE) {
		if ((improveSucess + reduceLoss) != 0) {
			bonusInfo = (improveSucess + reduceLoss);
		} else {
			bonus = BONUS_NULL;
		}
	} else if (bonus == BONUS_DOUBLE_TIER_UPGRADE) {
		if (!itemCanBeFused(iType.classification, (itemTier + 1))) {
			bonus = BONUS_NULL;
		}
	}

	if (sucess) {
		Item* newItem = Item::CreateItem(primaryItemID);
		ReturnValue newItemRet = g_game.internalAddItem(exaltedChest, newItem);
		if (newItemRet != RETURNVALUE_NOERROR) {
			g_game.ReleaseItem(newItem);
			return;
		}

		if (bonus == BONUS_KEEP_TIER_SUCESS || bonus == BONUS_KEEP_ITEM_TIER || bonus == BONUS_BOTH_TIER_UPGRADE) {
			Item* bonusItem = Item::CreateItem(secondaryItemID);
			ReturnValue bonusItemRet = g_game.internalAddItem(exaltedChest, bonusItem);
			if (bonusItemRet != RETURNVALUE_NOERROR) {
				g_game.ReleaseItem(bonusItem);
				return;
			}

			if (bonus == BONUS_BOTH_TIER_UPGRADE) {
				bonusInfo = itemTier + 1;
			} else {
				bonusInfo = (bonus == BONUS_KEEP_TIER_SUCESS ? itemTier - 1 : itemTier);
			}

			bonusItem->setIntAttr(ITEM_ATTRIBUTE_BOOST, bonusInfo);
		}

		if (bonus == BONUS_DOUBLE_TIER_UPGRADE) {
			bonusInfo = itemTier + 2;
			newItem->setIntAttr(ITEM_ATTRIBUTE_BOOST, bonusInfo);
		} else {
			newItem->setIntAttr(ITEM_ATTRIBUTE_BOOST, (itemTier + 1));
		}

		player->sendExaltedFusionWindow(true, newItem, secondaryItemID, itemTier, bonus, bonusInfo);
		g_scheduler.addEvent(createSchedulerTask(3500, std::bind(&Forge::broadcastFusionMessage, this, player->getID(), true, true, false, primaryItemID, itemTier)));

	} else {
		Item* primaryItem = Item::CreateItem(primaryItemID);
		ReturnValue primaryRet = g_game.internalAddItem(exaltedChest, primaryItem);
		if (primaryRet != RETURNVALUE_NOERROR) {
			g_game.ReleaseItem(primaryItem);
			return;
		}

		bool tierLoss = true;
		bool itemLoss = (itemTier == 0);
		if (bonus == BONUS_KEEP_TIER_FAIL || !itemLoss) {
			Item* secondaryItem = Item::CreateItem(secondaryItemID);
			ReturnValue secondaryRet = g_game.internalAddItem(exaltedChest, secondaryItem);
			if (secondaryRet != RETURNVALUE_NOERROR) {
				g_game.ReleaseItem(secondaryItem);
				return;
			}

			uint8_t finalTier = (bonus == BONUS_KEEP_TIER_FAIL ? itemTier : itemTier - 1);
			uint8_t lossTierChance = (reduceLoss ? configuration.reduceTierLoss : 100);
			if (bonus != BONUS_KEEP_TIER_FAIL && lossTierChance != 100) {
				int chance = rand() % 100;
				if (chance >= lossTierChance) {
					finalTier = itemTier;
					tierLoss = false;
				}
			}

			bonusInfo = finalTier;
			secondaryItem->setIntAttr(ITEM_ATTRIBUTE_BOOST, finalTier);
		}

		primaryItem->setIntAttr(ITEM_ATTRIBUTE_BOOST, itemTier);
		player->sendExaltedFusionWindow(false, primaryItem, secondaryItemID, itemTier, bonus, bonusInfo);
		g_scheduler.addEvent(createSchedulerTask(3500, std::bind(&Forge::broadcastFusionMessage, this, player->getID(), false, itemLoss, tierLoss, primaryItemID, itemTier)));
	}

	if (bonus != BONUS_DUST) {
		player->removeDust(configuration.dustFusion);
	}

	if (bonus != BONUS_CORE) {
		removeExaltedCore(player, (improveSucess + reduceLoss));
	}

	if (bonus != BONUS_GOLD) {
		removeMoney(player, iType.classification, itemTier);
	}

	appendToHistory(player, FORGEACTION_FUSION, (sucess ? "Sucess." : "Failed."), 0);

	player->sendResourceBalance(RESOURCE_BANK, player->getBankBalance());
	player->sendResourceBalance(RESOURCE_INVENTORY, player->getMoney());
	player->sendResourceBalance(RESOURCE_DUST, player->getDust());
	player->sendResourceBalance(RESOURCE_EXALTED_CORE, player->getExaltedCore());

	player->openExaltedForgeWindow();
}

void Forge::processTransfer(Player* player, uint16_t primaryItemID, uint16_t secondaryItemID, uint8_t itemTier)
{
	if (!player) {
		return;
	}

	Item* primaryItem = player->getItemTypeByTier(primaryItemID, itemTier);
	Item* secondaryItem = player->getItemTypeByTier(secondaryItemID, 0);
	if (!primaryItem || !secondaryItem) {
		return;
	}

	Item* exaltedItem = Item::CreateItem(ITEM_EXALTED_CHEST);
	if (!exaltedItem) {
		return;
	}

	Container* exaltedChest = exaltedItem->getContainer();
	if (!exaltedChest) {
		g_game.ReleaseItem(exaltedItem);
		return;
	}

	uint32_t playerCap = player->getFreeCapacity();
	if (playerCap <= (primaryItem->getWeight() + secondaryItem->getWeight() + exaltedItem->getWeight())) {
		player->sendCancelMessage(RETURNVALUE_NOTENOUGHCAPACITY);
		g_game.ReleaseItem(exaltedItem);
		return;
	}

	g_game.internalRemoveItem(primaryItem, 1);
	g_game.internalRemoveItem(secondaryItem, 1);

	ReturnValue exaltedRet = g_game.internalAddItem(player, exaltedChest);
	if (exaltedRet != RETURNVALUE_NOERROR) {
		appendToHistory(player, FORGEACTION_TRANSFER, "Failed to send exalted chest to player.", 1);
		g_game.ReleaseItem(exaltedItem);
		return;
	}

	Item* newItem = Item::CreateItem(secondaryItemID);
	ReturnValue newRet = g_game.internalAddItem(exaltedChest, newItem);
	if (newRet != RETURNVALUE_NOERROR) {
		appendToHistory(player, FORGEACTION_TRANSFER, "Failed to insert primary item into exalted chest.", 1);
		g_game.ReleaseItem(newItem);
		return;
	}

	const ItemType& iType = Item::items.getItemType(primaryItemID);

	removeExaltedCore(player, 1);
	player->removeDust(configuration.dustTransfer);
	removeMoney(player, iType.classification, itemTier - 1);
	newItem->setIntAttr(ITEM_ATTRIBUTE_BOOST, itemTier - 1);
	appendToHistory(player, FORGEACTION_TRANSFER, "Sucessful.", 0);

	player->sendExaltedTransferWindow(primaryItemID, itemTier, newItem);
	g_scheduler.addEvent(createSchedulerTask(3500, std::bind(&Forge::broadcastTransferMessage, this, player->getID(), primaryItemID, itemTier, secondaryItemID)));

	player->sendResourceBalance(RESOURCE_BANK, player->getBankBalance());
	player->sendResourceBalance(RESOURCE_INVENTORY, player->getMoney());
	player->sendResourceBalance(RESOURCE_DUST, player->getDust());
	player->sendResourceBalance(RESOURCE_EXALTED_CORE, player->getExaltedCore());

	player->openExaltedForgeWindow();
}

ExaltedForgeBonus_t Forge::generateForgeBonus(bool sucess)
{
	if (rand() % 100 >= configuration.bonusChance) {
		return BONUS_NULL;
	}

	const ExaltedForgeBonus_t sucessBonus[] = {BONUS_DUST, BONUS_CORE, BONUS_GOLD, BONUS_KEEP_TIER_SUCESS, BONUS_KEEP_ITEM_TIER, BONUS_BOTH_TIER_UPGRADE, BONUS_DOUBLE_TIER_UPGRADE};
	const ExaltedForgeBonus_t failBonusBonus[] = {BONUS_DUST, BONUS_CORE, BONUS_GOLD, BONUS_KEEP_TIER_FAIL};

	return (sucess ? sucessBonus[normal_random(0, 6)] : failBonusBonus[normal_random(0, 3)]);
}

void Forge::appendToHistory(Player* player, ForgeAction_t action, std::string message, uint8_t error)
{
	ExaltedHistory entry;
	entry.time = time(nullptr);
	entry.action = action;
	entry.message = message;
	entry.error = error;

	player->forgeHistory.emplace_back(entry);

	std::ostringstream query;
	Database& db = Database::getInstance();

	query << "INSERT INTO `forge_history` (`player_id`, `timestamp`, `action`, `message`, `error`) VALUES ("
	<< player->getGUID() << ','
	<< entry.time << ','
	<< entry.action << ','
	<< db.escapeString(std::move(entry.message)) << ','
	<< static_cast<uint16_t>(entry.error) << ')';

	db.executeQuery(query.str());
}

void Forge::removeMoney(Player* player, uint16_t classification, uint8_t tier)
{
	if (!player) {
		return;
	}

	uint64_t goldValue = 0;
	auto it = exaltedCategories.find(classification);
	if (it != exaltedCategories.end()) {
		for (auto info : (*it).second) {
			if (info.tier == tier) {
				goldValue = info.price;
				break;
			}
		}
	}

	g_game.removeMoney(player, goldValue, 0, true);
}

void Forge::removeExaltedCore(Player* player, uint8_t count)
{
	if (!player) {
		return;
	}

	Item* core = g_game.findItemOfType(player, ITEM_EXALTED_CORE, true);
	if (!core) {
		return;
	}

	g_game.internalRemoveItem(core, count);
}

void Forge::broadcastFusionMessage(uint32_t playerId, bool sucess, bool itemLoss, bool tierLoss, uint16_t itemId, uint16_t tier)
{
	Player* player = g_game.getPlayerByID(playerId);
	if (!player) {
		return;
	}

	const ItemType& iType = Item::items.getItemType(itemId);
	std::ostringstream text;

	text << player->getName();
	if (sucess) {
		text << " successfully ";
	} else {
		text << " unsuccessfully ";
	}
		
	text << "fused a " << iType.name << " tier " << tier << " with a " << iType.name << ".";
	text << " The character invested " << configuration.dustFusion << " dust and ";

	uint64_t goldValue = 0;
	auto it = exaltedCategories.find(iType.classification);
	if (it != exaltedCategories.end()) {
		for (auto info : (*it).second) {
			if (info.tier == tier) {
				goldValue = info.price;
				break;
			}
		}
	}

	text << valueConvert(goldValue) << " gold.";
	text << " The first item was ";
	if (sucess) {
		text << "upgraded to tier " << (tier + 1) << ".";
	} else {
		text << "not modified.";
	}

	if (itemLoss) {
		text << " The second item was consumed.";
	} else if (!itemLoss && tierLoss) {
		text << " The second item tier was reduced by one.";
	} else if (!itemLoss && !tierLoss) {
		text << " The second item tier was not reduced.";
	}

	const Position forgePos = Position(32207, 32277, 7);

	SpectatorHashSet spectators;
	g_game.map.getSpectators(spectators, forgePos, false, true);
	g_game.internalCreatureSay(player, TALKTYPE_ENVORIMENT_SAY, text.str(), false, &spectators, &forgePos, false);
}

void Forge::broadcastTransferMessage(uint32_t playerId, uint16_t primaryItemId, uint8_t primaryItemTier, uint16_t secondaryItemId)
{
	Player* player = g_game.getPlayerByID(playerId);
	if (!player) {
		return;
	}

	std::ostringstream text;
	text << player->getName();
	text << " has transfered the tier " << primaryItemTier << " from a " << Item::items.getItemType(primaryItemId).name;
	text << " to a " << Item::items.getItemType(secondaryItemId).name << ".";
	text << " The character invested " << configuration.dustFusion << " dust, ";

	uint64_t goldValue = 0;
	auto it = exaltedCategories.find(Item::items.getItemType(primaryItemId).classification);
	if (it != exaltedCategories.end()) {
		for (auto info : (*it).second) {
			if (info.tier == primaryItemTier - 1) {
				goldValue = info.price;
				break;
			}
		}
	}

	text << valueConvert(goldValue) << " gold and 1 exalted core.";
	text << " The first item was consumed.";
	text << " The second item was upgrade to tier " << primaryItemTier - 1 << ".";
	
	const Position forgePos = Position(32207, 32277, 7);

	SpectatorHashSet spectators;
	g_game.map.getSpectators(spectators, forgePos, false, true);
	g_game.internalCreatureSay(player, TALKTYPE_ENVORIMENT_SAY, text.str(), false, &spectators, &forgePos, false);

}

double Forge::getWeaponBonus(uint8_t classification, uint8_t tier)
{
	double bonus = 0;
	auto it = exaltedCategories.find(classification);
	if (it != exaltedCategories.end()) {
		for (auto info : (*it).second) {
			if (info.tier == tier - 1) {
				bonus = info.weaponBonus;
				break;
			}
		}
	}

	return bonus;
}

double Forge::getHelmetBonus(uint8_t classification, uint8_t tier)
{
	double bonus = 0;
	auto it = exaltedCategories.find(classification);
	if (it != exaltedCategories.end()) {
		for (auto info : (*it).second) {
			if (info.tier == tier - 1) {
				bonus = info.helmetBonus;
				break;
			}
		}
	}

	return bonus;
}

double Forge::getArmorBonus(uint8_t classification, uint8_t tier)
{
	double bonus = 0;
	auto it = exaltedCategories.find(classification);
	if (it != exaltedCategories.end()) {
		for (auto info : (*it).second) {
			if (info.tier == tier - 1) {
				bonus = info.armorBonus;
				break;
			}
		}
	}

	return bonus;
}

void Forge::convertDust(Player* player)
{
	if (!player) {
		return;
	}

	uint16_t removeDust = (configuration.dustPercent * configuration.dustToSleaver);
	if (player->getDust() < removeDust) {
		return;
	}

	Item* sliver = Item::CreateItem(ITEM_SLIVER, configuration.dustToSleaver);
	if (!sliver) {
		return;
	}

	if (g_game.internalAddItem(player, sliver) != RETURNVALUE_NOERROR) {
		delete sliver;
		player->sendFYIBox("You don't have enough room.");
		return;
	}

	std::ostringstream text;
	text << "Converted " << removeDust << " dust into " << static_cast<uint16_t>(configuration.dustToSleaver) << " slivers.";
	appendToHistory(player, FORGEACTION_CONVERSION, text.str(), 0);
	player->removeDust(removeDust);
	player->sendResourceBalance(RESOURCE_DUST, player->getDust());
	player->sendResourceBalance(RESOURCE_SLIVER, player->getSliver());
}

void Forge::convertSliver(Player* player)
{
	if (!player) {
		return;
	}

	uint8_t removeSliver = configuration.sliverToCore;
	if (player->getSliver() < removeSliver) {
		return;
	}

	Item* core = Item::CreateItem(ITEM_EXALTED_CORE);
	if (!core) {
		return;
	}

	if (g_game.internalAddItem(player, core) != RETURNVALUE_NOERROR) {
		delete core;
		player->sendFYIBox("You don't have enough room.");
		return;
	}

	std::ostringstream text;
	text << "Converted " << static_cast<uint16_t>(removeSliver) << " slivers into 1 exalted core.";
	appendToHistory(player, FORGEACTION_CONVERSION, text.str(), 0);

	player->removeItemOfType(ITEM_SLIVER, removeSliver, -1);
	player->sendResourceBalance(RESOURCE_SLIVER, player->getSliver());
	player->sendResourceBalance(RESOURCE_EXALTED_CORE, player->getExaltedCore());
}

void Forge::raiseDustLimit(Player* player)
{
	if (!player) {
		return;
	}

	uint8_t dustLimit = player->getMaxDust();
	if (dustLimit >= configuration.maxDustCap || dustLimit < configuration.minDustCap) {
		std::cout << "[ExaltedForge] An error has occured with dust limit of Player: " << player->getName() << std::endl;
		return;
	}

	uint8_t dustCost = player->getMaxDust() - configuration.dustPercentUpgrade;
	std::ostringstream text;
	text << "Used " << static_cast<uint16_t>(dustCost) << " dust to increase maximum dust capacity to " << dustLimit + 1 << ".";
	appendToHistory(player, FORGEACTION_CONVERSION, text.str(), 0);

	player->removeDust(dustCost);
	player->raiseMaxDust();
	player->sendResourceBalance(RESOURCE_DUST, player->getDust());
	player->openExaltedForgeWindow();
}
