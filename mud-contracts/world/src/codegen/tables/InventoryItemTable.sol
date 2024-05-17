// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout, FieldLayoutLib } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

FieldLayout constant _fieldLayout = FieldLayout.wrap(
  0x0060030020202000000000000000000000000000000000000000000000000000
);

struct InventoryItemTableData {
  uint256 quantity;
  uint256 index;
  uint256 stateUpdate;
}

library InventoryItemTable {
  /**
   * @notice Get the table values' field layout.
   * @return _fieldLayout The field layout for the table.
   */
  function getFieldLayout() internal pure returns (FieldLayout) {
    return _fieldLayout;
  }

  /**
   * @notice Get the table's key schema.
   * @return _keySchema The key schema for the table.
   */
  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _keySchema = new SchemaType[](2);
    _keySchema[0] = SchemaType.UINT256;
    _keySchema[1] = SchemaType.UINT256;

    return SchemaLib.encode(_keySchema);
  }

  /**
   * @notice Get the table's value schema.
   * @return _valueSchema The value schema for the table.
   */
  function getValueSchema() internal pure returns (Schema) {
    SchemaType[] memory _valueSchema = new SchemaType[](3);
    _valueSchema[0] = SchemaType.UINT256;
    _valueSchema[1] = SchemaType.UINT256;
    _valueSchema[2] = SchemaType.UINT256;

    return SchemaLib.encode(_valueSchema);
  }

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "smartObjectId";
    keyNames[1] = "inventoryItemId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](3);
    fieldNames[0] = "quantity";
    fieldNames[1] = "index";
    fieldNames[2] = "stateUpdate";
  }

  /**
   * @notice Register the table with its config.
   */
  function register(ResourceId _tableId) internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register(ResourceId _tableId) internal {
    StoreCore.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get quantity.
   */
  function getQuantity(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId
  ) internal view returns (uint256 quantity) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get quantity.
   */
  function _getQuantity(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId
  ) internal view returns (uint256 quantity) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set quantity.
   */
  function setQuantity(ResourceId _tableId, uint256 smartObjectId, uint256 inventoryItemId, uint256 quantity) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((quantity)), _fieldLayout);
  }

  /**
   * @notice Set quantity.
   */
  function _setQuantity(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId,
    uint256 quantity
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((quantity)), _fieldLayout);
  }

  /**
   * @notice Get index.
   */
  function getIndex(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId
  ) internal view returns (uint256 index) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get index.
   */
  function _getIndex(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId
  ) internal view returns (uint256 index) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set index.
   */
  function setIndex(ResourceId _tableId, uint256 smartObjectId, uint256 inventoryItemId, uint256 index) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((index)), _fieldLayout);
  }

  /**
   * @notice Set index.
   */
  function _setIndex(ResourceId _tableId, uint256 smartObjectId, uint256 inventoryItemId, uint256 index) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((index)), _fieldLayout);
  }

  /**
   * @notice Get stateUpdate.
   */
  function getStateUpdate(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId
  ) internal view returns (uint256 stateUpdate) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get stateUpdate.
   */
  function _getStateUpdate(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId
  ) internal view returns (uint256 stateUpdate) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set stateUpdate.
   */
  function setStateUpdate(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId,
    uint256 stateUpdate
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((stateUpdate)), _fieldLayout);
  }

  /**
   * @notice Set stateUpdate.
   */
  function _setStateUpdate(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId,
    uint256 stateUpdate
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((stateUpdate)), _fieldLayout);
  }

  /**
   * @notice Get the full data.
   */
  function get(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId
  ) internal view returns (InventoryItemTableData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId
  ) internal view returns (InventoryItemTableData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId,
    uint256 quantity,
    uint256 index,
    uint256 stateUpdate
  ) internal {
    bytes memory _staticData = encodeStatic(quantity, index, stateUpdate);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId,
    uint256 quantity,
    uint256 index,
    uint256 stateUpdate
  ) internal {
    bytes memory _staticData = encodeStatic(quantity, index, stateUpdate);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId,
    InventoryItemTableData memory _table
  ) internal {
    bytes memory _staticData = encodeStatic(_table.quantity, _table.index, _table.stateUpdate);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(
    ResourceId _tableId,
    uint256 smartObjectId,
    uint256 inventoryItemId,
    InventoryItemTableData memory _table
  ) internal {
    bytes memory _staticData = encodeStatic(_table.quantity, _table.index, _table.stateUpdate);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  ) internal pure returns (uint256 quantity, uint256 index, uint256 stateUpdate) {
    quantity = (uint256(Bytes.slice32(_blob, 0)));

    index = (uint256(Bytes.slice32(_blob, 32)));

    stateUpdate = (uint256(Bytes.slice32(_blob, 64)));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   *
   *
   */
  function decode(
    bytes memory _staticData,
    PackedCounter,
    bytes memory
  ) internal pure returns (InventoryItemTableData memory _table) {
    (_table.quantity, _table.index, _table.stateUpdate) = decodeStatic(_staticData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(ResourceId _tableId, uint256 smartObjectId, uint256 inventoryItemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(ResourceId _tableId, uint256 smartObjectId, uint256 inventoryItemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(uint256 quantity, uint256 index, uint256 stateUpdate) internal pure returns (bytes memory) {
    return abi.encodePacked(quantity, index, stateUpdate);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    uint256 quantity,
    uint256 index,
    uint256 stateUpdate
  ) internal pure returns (bytes memory, PackedCounter, bytes memory) {
    bytes memory _staticData = encodeStatic(quantity, index, stateUpdate);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(uint256 smartObjectId, uint256 inventoryItemId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(smartObjectId));
    _keyTuple[1] = bytes32(uint256(inventoryItemId));

    return _keyTuple;
  }
}
