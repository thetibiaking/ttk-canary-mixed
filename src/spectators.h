////////////////////////////////////////////////////////////////////////
// OpenTibia - an opensource roleplaying game
////////////////////////////////////////////////////////////////////////
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
////////////////////////////////////////////////////////////////////////

#ifndef __SPECTATORS__
#define __SPECTATORS__

#include "utils/enums.h"
#include "server/network/protocol/protocolgame.h"
#include "game/scheduling/scheduler.h"

class Creature;
class Player;
class House;
class Container;
class Tile;
class Quest;

using SpectatorList = std::map<ProtocolGame_ptr, std::pair<std::string, uint32_t>>;
using DataList = std::map<std::string, uint32_t>;

class Spectators
{
public:
  Spectators(ProtocolGame_ptr client) : owner(client)
  {
    id = 0;
    broadcast = false;
    broadcast_time = 0;
    liverecord = 0;
    description = "";
  }
  virtual ~Spectators() {}

  void clear(bool full)
  {
    for (const auto& it : spectators) {
      if (!it.first->twatchername.empty()) {
        it.first->parseTelescopeBack(true);
        continue;
      }

      it.first->disconnect();
    }

    spectators.clear();
    mutes.clear();
    removeCaster();

    id = 0;
    if (!full)
      return;

    bans.clear();
    password = "";
    broadcast = false;
    broadcast_time = 0;
    liverecord = 0;
  }

  bool check(const std::string& _password);
  void handle(Player* player, ProtocolGame_ptr client, const std::string& text, uint16_t channelId);
  void chat(uint16_t channelId);

  uint32_t getCastViewerCount() {
    return spectators.size();
  }

  StringVector list()
  {
    StringVector list_;
    for (const auto& it : spectators) {
      if (it.first && it.first->spy) {
        continue;
      }

      list_.push_back(it.second.first);
    }
    return list_;
  }

  void kick(StringVector list);
  StringVector muteList() { return mutes; }
  void mute(StringVector _mutes) { mutes = _mutes; }
  DataList banList() { return bans; }
  void ban(StringVector _bans);

  bool banned(uint32_t ip) const
  {
    for (const auto& it : bans) {
      if (it.second == ip) {
        return true;
      }
    }

    return false;
  }

  ProtocolGame_ptr getOwner() const { return owner; }
  void setOwner(ProtocolGame_ptr client) { owner = client; }
  void resetOwner() {
    owner.reset();
  }

  std::string getPassword() const { return password; }
  void setPassword(const std::string& value) { password = value; }

  bool isBroadcasting() const { return broadcast; }
  void setBroadcast(bool value) { broadcast = value; }

  std::string getBroadCastTimeString() const {
    std::stringstream broadcast;
    int64_t seconds = getBroadcastTime() / 1000;

    uint16_t hour = floor(seconds / 60 / 60 % 24);
    uint16_t minute = floor(seconds / 60 % 60);
    uint16_t second = floor(seconds % 60);

    if (hour > 0) { broadcast << hour << " hours, "; }
    if (minute > 0) { broadcast << minute << " minutes and "; }
    broadcast << second << " seconds.";
    return broadcast.str();
  }

  void addSpectator(ProtocolGame_ptr client, std::string name = "", bool spy = false);
  void removeSpectator(ProtocolGame_ptr client, bool spy = false);

  int64_t getBroadcastTime() const { return OTSYS_TIME() - broadcast_time; }
  void setBroadcastTime(int64_t time) { broadcast_time = time; }

  std::string getDescription() const { return description; }
  void setDescription(const std::string& desc) { description = desc; }

  uint32_t getSpectatorId(ProtocolGame_ptr client) const {
    auto it = spectators.find(client);
    if (it != spectators.end()) {
      return it->second.second;
    }
    return 0;
  }

  // inherited
  void insertCaster()
  {
    if (owner) {
      owner->insertCaster();
    }
  }

  void removeCaster()
  {
    if (owner) {
      owner->removeCaster();
    }
  }

  bool canSee(const Position& pos) const
  {
    if (owner) {
      return owner->canSee(pos);
    }

    return false;
  }

  uint32_t getIP() const
  {
    if (owner) {
      return owner->getIP();
    }

    return 0;
  }

  void sendStats()
  {
    if (owner) {
      owner->sendStats();

      for (const auto& it : spectators)
        it.first->sendStats();
    }
  }
  void sendPing()
  {
    if (owner) {
      owner->sendPing();

      for (const auto& it : spectators)
        it.first->sendPing();
    }
  }
  void logout(bool displayEffect, bool forceLogout)
  {
    if (owner) {
      owner->logout(displayEffect, forceLogout);
    }
  }
  void sendAddContainerItem(uint8_t cid, uint16_t slot, const Item* item)
  {
    if (owner) {
      owner->sendAddContainerItem(cid, slot, item);

      for (const auto& it : spectators)
        it.first->sendAddContainerItem(cid, slot, item);
    }
  }
  void sendUpdateContainerItem(uint8_t cid, uint16_t slot, const Item* item)
  {
    if (owner) {
      owner->sendUpdateContainerItem(cid, slot, item);

      for (const auto& it : spectators)
        it.first->sendUpdateContainerItem(cid, slot, item);
    }
  }
  void sendRemoveContainerItem(uint8_t cid, uint16_t slot, const Item* lastItem)
  {
    if (owner) {
      owner->sendRemoveContainerItem(cid, slot, lastItem);

      for (const auto& it : spectators)
        it.first->sendRemoveContainerItem(cid, slot, lastItem);
    }
  }
  void sendUpdatedVIPStatus(uint32_t guid, VipStatus_t newStatus)
  {
    if (owner) {
      owner->sendUpdatedVIPStatus(guid, newStatus);

      for (const auto& it : spectators)
        it.first->sendUpdatedVIPStatus(guid, newStatus);
    }
  }
  void sendVIP(uint32_t guid, const std::string& name, const std::string& description, uint32_t icon, bool notify, VipStatus_t status)
  {
    if (owner) {
      owner->sendVIP(guid, name, description, icon, notify, status);

      for (const auto& it : spectators)
        it.first->sendVIP(guid, name, description, icon, notify, status);
    }
  }
  void sendClosePrivate(uint16_t channelId)
  {
    if (owner) {
      owner->sendClosePrivate(channelId);
    }
  }
  void sendFYIBox(const std::string& message) {
    if (owner) {
      owner->sendFYIBox(message);
    }
  }

  uint32_t getVersion() const {
    if (owner) {
      return owner->getVersion();
    }

    return 0;
  }

  void disconnect() {
    if (owner) {
      owner->disconnect();
    }
  }

  void sendPartyCreatureSkull(const Creature* creature) const {
    if (owner) {
      owner->sendPartyCreatureSkull(creature);

      for (const auto& it : spectators)
        it.first->sendPartyCreatureSkull(creature);
    }
  }

  void sendAddTileItem(const Position& pos, uint32_t stackpos, const Item* item) {
    if (owner) {
      owner->sendAddTileItem(pos, stackpos, item);

      for (const auto& it : spectators)
        it.first->sendAddTileItem(pos, stackpos, item);
    }
  }

  void sendUpdateTileItem(const Position& pos, uint32_t stackpos, const Item* item) {
    if (owner) {
      owner->sendUpdateTileItem(pos, stackpos, item);

      for (const auto& it : spectators)
        it.first->sendUpdateTileItem(pos, stackpos, item);
    }
  }

  void sendRemoveTileThing(const Position& pos, int32_t stackpos) {
    if (owner) {
      owner->sendRemoveTileThing(pos, stackpos);

      for (const auto& it : spectators)
        it.first->sendRemoveTileThing(pos, stackpos);
    }
  }

  void sendUpdateTile(const Tile* tile, const Position& pos) {
    if (owner) {
      owner->sendUpdateTile(tile, pos);

      for (const auto& it : spectators)
        it.first->sendUpdateTile(tile, pos);
    }
  }

  void sendChannelMessage(const std::string& author, const std::string& text, SpeakClasses type, uint16_t channel, uint32_t spectatorLevel = 0) {
    if (owner) {
      owner->sendChannelMessage(author, text, type, channel, spectatorLevel);

      for (const auto& it : spectators)
        it.first->sendChannelMessage(author, text, type, channel, spectatorLevel);
    }
  }
  void sendMoveCreature(const Creature* creature, const Position& newPos, int32_t newStackPos, const Position& oldPos, int32_t oldStackPos, bool teleport) {
    if (owner) {
      owner->sendMoveCreature(creature, newPos, newStackPos, oldPos, oldStackPos, teleport);

      for (const auto& it : spectators)
        it.first->sendMoveCreature(creature, newPos, newStackPos, oldPos, oldStackPos, teleport);
    }
  }
  void sendCreatureTurn(const Creature* creature, int32_t stackpos) {
    if (owner) {
      owner->sendCreatureTurn(creature, stackpos);

      for (const auto& it : spectators)
        it.first->sendCreatureTurn(creature, stackpos);
    }
  }
  void sendCreatureSay(const Creature* creature, SpeakClasses type, const std::string& text, const Position* pos = nullptr);
  void sendPrivateMessage(const Player* speaker, SpeakClasses type, const std::string& text) {
    if (owner) {
      owner->sendPrivateMessage(speaker, type, text);
    }
  }
  void sendCreatureSquare(const Creature* creature, SquareColor_t color) {
    if (owner) {
      owner->sendCreatureSquare(creature, color);

      for (const auto& it : spectators)
        it.first->sendCreatureSquare(creature, color);
    }
  }
  void sendCreatureOutfit(const Creature* creature, const Outfit_t& outfit) {
    if (owner) {
      owner->sendCreatureOutfit(creature, outfit);

      for (const auto& it : spectators)
        it.first->sendCreatureOutfit(creature, outfit);
    }
  }
  void sendCreatureLight(const Creature* creature) {
    if (owner) {
      owner->sendCreatureLight(creature);

      for (const auto& it : spectators)
        it.first->sendCreatureLight(creature);
    }
  }
  void sendCreatureWalkthrough(const Creature* creature, bool walkthrough) {
    if (owner) {
      owner->sendCreatureWalkthrough(creature, walkthrough);

      for (const auto& it : spectators)
        it.first->sendCreatureWalkthrough(creature, walkthrough);
    }
  }
  void sendPartyCreatureShield(const Creature* creature) {
    if (owner) {
      owner->sendPartyCreatureShield(creature);

      for (const auto& it : spectators)
        it.first->sendPartyCreatureShield(creature);
    }
  }
  void sendContainer(uint8_t cid, const Container* container, bool hasParent, uint16_t firstIndex) {
    if (owner) {
      owner->sendContainer(cid, container, hasParent, firstIndex);

      for (const auto& it : spectators)
        it.first->sendContainer(cid, container, hasParent, firstIndex);
    }
  }
  void sendInventoryItem(slots_t slot, const Item* item) {
    if (owner) {
      owner->sendInventoryItem(slot, item);

      for (const auto& it : spectators)
        it.first->sendInventoryItem(slot, item);
    }
  }
  void sendCancelMessage(const std::string& msg) const {
    if (owner) {
      owner->sendTextMessage(TextMessage(MESSAGE_FAILURE, msg));

      for (const auto& it : spectators)
        it.first->sendTextMessage(TextMessage(MESSAGE_FAILURE, msg));
    }
  }
  void sendCancelTarget() const {
    if (owner) {
      owner->sendCancelTarget();

      for (const auto& it : spectators)
        it.first->sendCancelTarget();
    }
  }
  void sendCancelWalk() const {
    if (owner) {
      owner->sendCancelWalk();

      for (const auto& it : spectators)
        it.first->sendCancelWalk();
    }
  }
  void sendChangeSpeed(const Creature* creature, uint32_t newSpeed) const {
    if (owner) {
      owner->sendChangeSpeed(creature, newSpeed);

      for (const auto& it : spectators)
        it.first->sendChangeSpeed(creature, newSpeed);
    }
  }
  void sendPartyPlayerVocation(const Player* player) const {
    if (owner) {
      owner->sendPartyPlayerVocation(player);

      for (const auto& it : spectators)
        it.first->sendPartyPlayerVocation(player);     
    }
  }
  void sendPlayerVocation(const Player* player) const {
    if (owner) {
      owner->sendPlayerVocation(player);

      for (const auto& it : spectators)
        it.first->sendPlayerVocation(player);      
    }
  }    
  void sendCreatureHealth(const Creature* creature) const {
    if (owner) {
      owner->sendCreatureHealth(creature);

      for (const auto& it : spectators)
        it.first->sendCreatureHealth(creature);
    }
  }
  void sendCreatureShield(const Creature* creature) {
    if (owner) {
      owner->sendCreatureShield(creature);

      for (const auto& it : spectators)
        it.first->sendCreatureShield(creature);           
    }
  }  
  void sendPartyCreatureUpdate(const Creature* creature) const {
    if (owner) {
      owner->sendPartyCreatureUpdate(creature);

      for (const auto& it : spectators)
        it.first->sendPartyCreatureUpdate(creature);      
    }
  }
  void sendCreatureSkull(const Creature* creature) const {
    if (owner) {
      owner->sendCreatureSkull(creature);

      for (const auto& it : spectators)
        it.first->sendCreatureSkull(creature);
    }   
  }
  void sendPartyCreatureHealth(const Creature* creature, uint8_t healthPercent) const {
    if (owner) {
      owner->sendPartyCreatureHealth(creature, healthPercent);

      for (const auto& it : spectators)
        it.first->sendPartyCreatureHealth(creature, healthPercent);     
    }
  }
  void sendPartyPlayerMana(const Player* player, uint8_t manaPercent) const {
    if (owner) {
      owner->sendPartyPlayerMana(player, manaPercent);

      for (const auto& it : spectators)
        it.first->sendPartyPlayerMana(player, manaPercent);      
    }
  }
  void sendPartyCreatureShowStatus(const Creature* creature, bool showStatus) const {
    if (owner) {
      owner->sendPartyCreatureShowStatus(creature, showStatus);

      for (const auto& it : spectators)
        it.first->sendPartyCreatureShowStatus(creature, showStatus);         
    }
  }      
  void sendDistanceShoot(const Position& from, const Position& to, unsigned char type) const {
    if (owner) {
      owner->sendDistanceShoot(from, to, type);

      for (const auto& it : spectators)
        it.first->sendDistanceShoot(from, to, type);
    }
  }
  void sendCreatePrivateChannel(uint16_t channelId, const std::string& channelName) {
    if (owner) {
      owner->sendCreatePrivateChannel(channelId, channelName);
    }
  }
  void sendIcons(uint16_t icons) const {
    if (owner) {
      owner->sendIcons(icons);

      for (const auto& it : spectators)
        it.first->sendIcons(icons);
    }
  }
  void sendMagicEffect(const Position& pos, uint8_t type) const {
    if (owner) {
      owner->sendMagicEffect(pos, type);

      for (const auto& it : spectators)
        it.first->sendMagicEffect(pos, type);
    }
  }
  void sendSkills() const {
    if (owner) {
      owner->sendSkills();

      for (const auto& it : spectators)
        it.first->sendSkills();
    }
  }
  void sendTextMessage(MessageClasses mclass, const std::string& message)
  {
    if (owner) {
      owner->sendTextMessage(TextMessage(mclass, message));

      for (const auto& it : spectators)
        it.first->sendTextMessage(TextMessage(mclass, message));
    }
  }
  void sendTextMessage(const TextMessage& message) const {
    if (owner) {
      owner->sendTextMessage(message);

      for (const auto& it : spectators)
        it.first->sendTextMessage(message);
    }
  }
  void sendReLoginWindow(uint8_t unfairFightReduction) {
    if (owner) {
      owner->sendReLoginWindow(unfairFightReduction);
      clear(true);
    }
  }
  void sendTextWindow(uint32_t windowTextId, Item* item, uint16_t maxlen, bool canWrite) const {
    if (owner) {
      owner->sendTextWindow(windowTextId, item, maxlen, canWrite);
    }
  }
  void sendTextWindow(uint32_t windowTextId, uint32_t itemId, const std::string& text) const {
    if (owner) {
      owner->sendTextWindow(windowTextId, itemId, text);
    }
  }
  void sendToChannel(const Creature* creature, SpeakClasses type, const std::string& text, uint16_t channelId);
  void sendShop(Npc* npc, const ShopInfoList& itemList) const {
    if (owner) {
      owner->sendShop(npc, itemList);
    }
  }
  void sendSaleItemList(const std::vector<ShopInfo>& shop, const std::map<uint32_t, uint32_t>& inventoryMap) const {
    if (owner) {
      owner->sendSaleItemList(shop, inventoryMap);
    }
  }
  void sendCloseShop() const {
    if (owner) {
      owner->sendCloseShop();
    }
  }
  void sendTradeItemRequest(const std::string& traderName, const Item* item, bool ack) const {
    if (owner) {
      owner->sendTradeItemRequest(traderName, item, ack);
    }
  }
  void sendTradeClose() const {
    if (owner) {
      owner->sendCloseTrade();
    }
  }
  void sendWorldLight(const LightInfo& lightInfo) {
    if (owner) {
      owner->sendWorldLight(lightInfo);

      for (const auto& it : spectators)
        it.first->sendWorldLight(lightInfo);
    }
  }
  void sendChannelsDialog() {
    if (owner) {
      owner->sendChannelsDialog();
    }
  }
  void sendOpenPrivateChannel(const std::string& receiver) {
    if (owner) {
      owner->sendOpenPrivateChannel(receiver);
    }
  }
  void sendOutfitWindow() {
    if (owner) {
      owner->sendOutfitWindow();
    }
  }
  void sendCloseContainer(uint8_t cid) {
    if (owner) {
      owner->sendCloseContainer(cid);

      for (const auto& it : spectators)
        it.first->sendCloseContainer(cid);
      ;
    }
  }
  void sendChannel(uint16_t channelId, const std::string& channelName, const UsersMap* channelUsers, const InvitedMap* invitedUsers) {
    if (owner) {
      owner->sendChannel(channelId, channelName, channelUsers, invitedUsers);
    }
  }
  void sendTutorial(uint8_t tutorialId) {
    if (owner) {
      owner->sendTutorial(tutorialId);
    }
  }
  void sendAddMarker(const Position& pos, uint8_t markType, const std::string& desc) {
    if (owner) {
      owner->sendAddMarker(pos, markType, desc);
    }
  }
  void sendFightModes() {
    if (owner) {
      owner->sendFightModes();
    }
  }
  void writeToOutputBuffer(const NetworkMessage& message) {
    if (owner) {
      owner->writeToOutputBuffer(message);
    }
  }
  void sendAddCreature(const Creature* creature, const Position& pos, int32_t stackpos, bool isLogin)
  {
    if (owner) {
      owner->sendAddCreature(creature, pos, stackpos, isLogin);

      for (const auto& it : spectators)
        it.first->sendAddCreature(creature, pos, stackpos, isLogin);
    }
  }
  void sendHouseWindow(uint32_t windowTextId, const std::string& text)
  {
    if (owner) {
      owner->sendHouseWindow(windowTextId, text);
    }
  }

  void reloadCreature(const Creature* creature) {
    if (owner) {
      owner->reloadCreature(creature);

      for (const auto& it : spectators)
        it.first->reloadCreature(creature);
    }
  }

  void telescopeGo(uint16_t guid, bool spy)
  {
    if (owner) {
      owner->telescopeGo(guid, spy);
    }
  }

  // MISSING
  void sendRestingStatus(uint8_t protection) {
    if (owner) {
      owner->sendRestingStatus(protection);
    }
  }
  void sendImbuementWindow(Item* item) {
    if (owner) {
      owner->sendImbuementWindow(item);
    }
  }
  void sendMarketEnter(uint32_t depotId) {
    if (owner) {
      owner->sendMarketEnter(depotId);
    }
  }
  void sendUnjustifiedPoints(const uint8_t& dayProgress, const uint8_t& dayLeft, const uint8_t& weekProgress, const uint8_t& weekLeft, const uint8_t& monthProgress, const uint8_t& monthLeft, const uint8_t& skullDuration) {
    if (owner) {
      owner->sendUnjustifiedPoints(dayProgress, dayLeft, weekProgress, weekLeft, monthProgress, monthLeft, skullDuration);
    }
  }
  void sendModalWindow(const ModalWindow& modalWindow) {
    if (owner) {
      owner->sendModalWindow(modalWindow);
    }
  }
  void AddItem(NetworkMessage& msg, const Item* item) {
    if (owner) {
      owner->AddItem(msg, item);
    }
  }
  void BestiarysendCharms() {
    if (owner) {
      owner->BestiarysendCharms();
    }
  }
  void sendItemsPrice() {
    if (owner) {
      owner->sendItemsPrice();
    }
  }
  void sendBestiaryEntryChanged(uint16_t raceid) {
    if (owner) {
      owner->sendBestiaryEntryChanged(raceid);
    }
  }
  void refreshBestiaryTracker(std::list<MonsterType*> trackerList) {
    if (owner) {
      owner->refreshBestiaryTracker(trackerList);
    }
  }
  void sendChannelEvent(uint16_t channelId, const std::string& playerName, ChannelEvent_t channelEvent) {
    if (owner) {
      owner->sendChannelEvent(channelId, playerName, channelEvent);
    }
  }
  void sendCreatureIcons(const Creature* creature) {
    if (owner) {
      owner->sendCreatureIcons(creature);
      for (const auto& it : spectators)
        it.first->sendCreatureIcons(creature);
    }
  }
  void sendCreatureType(const Creature* creature, uint8_t creatureType) {
    if (owner) {
      owner->sendCreatureType(creature, creatureType);
      for (const auto& it : spectators)
        it.first->sendCreatureType(creature, creatureType);
    }
  }
  void sendCreatureHelpers(uint32_t creatureId, uint16_t helpers) {
    if (owner) {
      owner->sendCreatureHelpers(creatureId, helpers);
      for (const auto& it : spectators)
        it.first->sendCreatureHelpers(creatureId, helpers);
    }
  }  
  void sendSpellCooldown(uint8_t spellId, uint32_t time) {
    if (owner) {
      owner->sendSpellCooldown(spellId, time);
      for (const auto& it : spectators)
        it.first->sendSpellCooldown(spellId, time);
    }
  }
  void sendSpellGroupCooldown(SpellGroup_t groupId, uint32_t time) {
    if (owner) {
      owner->sendSpellGroupCooldown(groupId, time);
      for (const auto& it : spectators)
        it.first->sendSpellGroupCooldown(groupId, time);
    }
  }
  void sendLockerItems(std::map<uint16_t, uint16_t> itemMap, uint16_t count) {
    if (owner) {
      owner->sendLockerItems(itemMap, count);
    }
  }
  void sendCoinBalance() {
    if (owner) {
      owner->sendCoinBalance();
    }
  }
  void sendInventoryClientIds() {
    if (owner) {
      owner->sendInventoryClientIds();
    }
  }
  void sendOpenStore(uint8_t serviceType) {
    if (owner) {
      owner->sendOpenStore(serviceType);
    }
  }

  void sendStoreCategoryOffers(StoreCategory* category) {
    if (owner) {
      owner->sendStoreCategoryOffers(category);
    }
  }

  void sendStoreError(GameStoreError_t error, const std::string& errorMessage) {
    if (owner) {
      owner->sendStoreError(error, errorMessage);
    }
  }

  void sendStorePurchaseSuccessful(const std::string& message, const uint32_t newCoinBalance) {
    if (owner)
    {
      owner->sendStorePurchaseSuccessful(message, newCoinBalance);
    }
  }

  void sendStoreRequestAdditionalInfo(uint32_t offerId, ClientOffer_t clientOfferType) {
    if (owner) {
      owner->sendStoreRequestAdditionalInfo(offerId, clientOfferType);
    }
  }

  void sendStoreTrasactionHistory(HistoryStoreOfferList& list, uint32_t page, uint8_t entriesPerPage) {
    if (owner) {
      owner->sendStoreTrasactionHistory(list, page, entriesPerPage);
    }
  }
  void sendLootContainers() {
    if (owner) {
      owner->sendLootContainers();
    }
  }
  void sendLootStats(Item* item, uint8_t count) {
    if (owner) {
      owner->sendLootStats(item, count);
    }
  }
  void sendClientCheck() const {
    if (owner) {
      owner->sendClientCheck();
    }
  }
  void sendGameNews() const {
    if (owner) {
      owner->sendGameNews();
    }
  }
  void sendPingBack() const {
    if (owner) {
      owner->sendPingBack();
      for (const auto& it : spectators)
        it.first->sendPingBack();
    }
  }
  void sendBasicData() const {
    if (owner) {
      owner->sendBasicData();
      for (const auto& it : spectators)
        it.first->sendBasicData();
    }
  }
  void sendBlessStatus() const {
    if (owner) {
      owner->sendBlessStatus();
      for (const auto& it : spectators)
        it.first->sendBlessStatus();
    }
  }
  void sendMarketLeave() {
    if (owner) {
      owner->sendMarketLeave();
    }
  }
  void sendMarketBrowseItem(uint16_t itemId, const MarketOfferList& buyOffers, const MarketOfferList& sellOffers, uint16_t tier) const {
    if (owner) {
      owner->sendMarketBrowseItem(itemId, buyOffers, sellOffers, tier);
    }
  }
  void sendMarketBrowseOwnOffers(const MarketOfferList& buyOffers, const MarketOfferList& sellOffers) const {
    if (owner) {
      owner->sendMarketBrowseOwnOffers(buyOffers, sellOffers);
    }
  }
  void sendMarketBrowseOwnHistory(const HistoryMarketOfferList& buyOffers, const HistoryMarketOfferList& sellOffers) const {
    if (owner) {
      owner->sendMarketBrowseOwnHistory(buyOffers, sellOffers);
    }
  }
  void sendMarketDetail(uint16_t itemId, uint16_t tier) const {
    if (owner) {
      owner->sendMarketDetail(itemId, tier);
    }
  }
  void sendMarketAcceptOffer(const MarketOfferEx& offer) const {
    if (owner) {
      owner->sendMarketAcceptOffer(offer);
    }
  }
  void sendMarketCancelOffer(const MarketOfferEx& offer) const {
    if (owner) {
      owner->sendMarketCancelOffer(offer);
    }
  }
  void sendCloseTrade() const {
    if (owner) {
      owner->sendCloseTrade();
    }
  }
  void sendTibiaTime(int32_t time) {
    if (owner) {
      owner->sendTibiaTime(time);
      for (const auto& it : spectators)
        it.first->sendTibiaTime(time);
    }
  }
  void sendSpecialContainersAvailable() {
    if (owner) {
      owner->sendSpecialContainersAvailable();
    }
  }
  void sendItemInspection(uint16_t itemId, uint8_t itemCount, const Item* item, bool cyclopedia) {
    if (owner) {
      owner->sendItemInspection(itemId, itemCount, item, cyclopedia);
    }
  }
  void sendCyclopediaCharacterNoData(CyclopediaCharacterInfoType_t characterInfoType, uint8_t errorCode) {
    if (owner) {
      owner->sendCyclopediaCharacterNoData(characterInfoType, errorCode);
    }
  }
  void sendCyclopediaCharacterBaseInformation() {
    if (owner) {
      owner->sendCyclopediaCharacterBaseInformation();
    }
  }
  void sendCyclopediaCharacterGeneralStats() {
    if (owner) {
      owner->sendCyclopediaCharacterGeneralStats();
    }
  }
  void sendCyclopediaCharacterCombatStats() {
    if (owner) {
      owner->sendCyclopediaCharacterCombatStats();
    }
  }
  void sendCyclopediaCharacterRecentDeaths(uint16_t page, uint16_t pages, const std::vector<RecentDeathEntry>& entries) {
    if (owner) {
      owner->sendCyclopediaCharacterRecentDeaths(page, pages, entries);
    }
  }
  void sendCyclopediaCharacterRecentPvPKills(uint16_t page, uint16_t pages, const std::vector<RecentPvPKillEntry>& entries) {
    if (owner) {
      owner->sendCyclopediaCharacterRecentPvPKills(page, pages, entries);
    }
  }
  void sendCyclopediaCharacterAchievements() {
    if (owner) {
      owner->sendCyclopediaCharacterAchievements();
    }
  }
  void sendCyclopediaCharacterItemSummary() {
    if (owner) {
      owner->sendCyclopediaCharacterItemSummary();
    }
  }
  void sendCyclopediaCharacterOutfitsMounts() {
    if (owner) {
      owner->sendCyclopediaCharacterOutfitsMounts();
    }
  }
  void sendCyclopediaCharacterStoreSummary() {
    if (owner) {
      owner->sendCyclopediaCharacterStoreSummary();
    }
  }
  void sendCyclopediaCharacterInspection() {
    if (owner) {
      owner->sendCyclopediaCharacterInspection();
    }
  }
  void sendCyclopediaCharacterBadges() {
    if (owner) {
      owner->sendCyclopediaCharacterBadges();
    }
  }
  void sendCyclopediaCharacterTitles() {
    if (owner) {
      owner->sendCyclopediaCharacterTitles();
    }
  }
  void sendHighscoresNoData() {
    if (owner) {
      owner->sendHighscoresNoData();
    }
  }
  void sendHighscores(const std::vector<HighscoreCharacter>& characters, uint8_t categoryId, uint32_t vocationId, uint16_t page, uint16_t pages) {
    if (owner) {
      owner->sendHighscores(characters, categoryId, vocationId, page, pages);
    }
  }
  void sendTournamentLeaderboard() {
    if (owner) {
      owner->sendTournamentLeaderboard();
    }
  }
  void sendEnterWorld() {
    if (owner) {
      owner->sendEnterWorld();
      for (const auto& it : spectators)
        it.first->sendEnterWorld();
    }
  }
  void sendOpenStash() {
    if (owner) {
      owner->sendOpenStash();
    }
  }
  bool sendKillTrackerUpdate(Container* corpse, const std::string& playerName, const Outfit_t creatureOutfit) const
  {
    if (owner) {
      owner->sendKillTrackerUpdate(corpse, playerName, creatureOutfit);
      return true;
    }

    return false;
  }

  void sendUpdateSupplyTracker(const Item* item) {
    if (owner) {
      owner->sendUpdateSupplyTracker(item);
    }
  }

  void sendUpdateImpactTracker(CombatType_t type, int32_t amount) {
    if (owner) {
      owner->sendUpdateImpactTracker(type, amount);
    }
  }
  void sendUpdateInputAnalyzer(CombatType_t type, int32_t amount, std::string target) {
    if (owner) {
      owner->sendUpdateInputAnalyzer(type, amount, target);
    }
  }
	void sendUpdateLootTracker(Item* item)
	{
		if (owner) {
			owner->sendUpdateLootTracker(item);
		}
	}
	void createLeaderTeamFinder(NetworkMessage &msg)
	{
		if (owner) {
			owner->createLeaderTeamFinder(msg);
		}
	}
	void sendLeaderTeamFinder(bool reset)
	{
		if (owner) {
			owner->sendLeaderTeamFinder(reset);
		}
	}
	void sendTeamFinderList()
	{
		if (owner) {
			owner->sendTeamFinderList();
		}
	}

  void sendPodiumWindow(const Item* podium, const Position& position, uint16_t spriteId, uint8_t stackpos) {
    if (owner) {
      owner->sendPodiumWindow(podium, position, spriteId, stackpos);
    }
  }
		
	private:
		friend class Player;
		
		SpectatorList spectators;
		StringVector mutes;
		DataList bans;
		Map map;

		ProtocolGame_ptr owner;
		uint32_t id;
		std::string password;
		std::string description;
		bool broadcast;
		int64_t broadcast_time;
		uint16_t liverecord;

};
#endif