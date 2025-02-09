// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { EntityRecordData, EntityMetadata } from "./../../namespaces/evefrontier/systems/entity-record/types.sol";

/**
 * @title ISmartCharacterSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface ISmartCharacterSystem {
  error SmartCharacter_ERC721AlreadyInitialized();
  error SmartCharacter_AlreadyCreated(address characterAddress, uint256 characterId);
  error SmartCharacterDoesNotExist(uint256 characterId);

  function registerCharacterToken(address tokenAddress) external;

  function createCharacter(
    uint256 characterId,
    address characterAddress,
    uint256 tribeId,
    EntityRecordData memory entityRecord,
    EntityMetadata memory entityRecordMetadata
  ) external;

  function updateTribeId(uint256 characterId, uint256 tribeId) external;
}
