// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { EntityRecordData, EntityMetadata } from "./../../namespaces/evefrontier/systems/entity-record/types.sol";

/**
 * @title IEntityRecordSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IEntityRecordSystem {
  function createEntityRecord(uint256 smartObjectId, EntityRecordData memory entityRecord) external;

  function createEntityRecordMetadata(uint256 smartObjectId, EntityMetadata memory entityRecordMetadata) external;

  function setName(uint256 smartObjectId, string memory name) external;

  function setDappURL(uint256 smartObjectId, string memory dappURL) external;

  function setDescription(uint256 smartObjectId, string memory description) external;
}
