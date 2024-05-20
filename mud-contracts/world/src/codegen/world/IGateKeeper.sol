// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { EntityRecordData, SmartObjectData, WorldPosition } from "./../../modules/smart-storage-unit/types.sol";
import { InventoryItem } from "./../../modules/inventory/types.sol";

/**
 * @title IGateKeeper
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IGateKeeper {
  function eveworld__createAndAnchorGateKeeper(
    uint256 smartObjectId,
    EntityRecordData memory entityRecordData,
    SmartObjectData memory smartObjectData,
    WorldPosition memory worldPosition,
    uint256 fuelUnitVolume,
    uint256 fuelConsumptionPerMinute,
    uint256 fuelMaxCapacity,
    uint256 storageCapacity,
    uint256 ephemeralStorageCapacity
  ) external;

  function eveworld__setAcceptedItemTypeId(uint256 smartObjectId, uint256 entityTypeId) external;

  function eveworld__setTargetQuantity(uint256 smartObjectId, uint256 targetItemQuantity) external;

  function eveworld__ephemeralToInventoryTransferHook(uint256 smartObjectId, InventoryItem[] memory items) external;

  function eveworld__depositToInventoryHook(uint256 smartObjectId, InventoryItem[] memory items) external;
}
