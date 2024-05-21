// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import { World } from "@latticexyz/world/src/World.sol";
import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { Systems } from "@latticexyz/world/src/codegen/tables/Systems.sol";
import { SystemRegistry } from "@latticexyz/world/src/codegen/tables/SystemRegistry.sol";
import { ResourceId } from "@latticexyz/world/src/WorldResourceId.sol";
import { WorldResourceIdInstance } from "@latticexyz/world/src/WorldResourceId.sol";
import { PuppetModule } from "@latticexyz/world-modules/src/modules/puppet/PuppetModule.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { NamespaceOwner } from "@latticexyz/world/src/codegen/tables/NamespaceOwner.sol";
import { IModule } from "@latticexyz/world/src/IModule.sol";

import { SmartObjectFrameworkModule } from "@eveworld/smart-object-framework/src/SmartObjectFrameworkModule.sol";
import { EntityCore } from "@eveworld/smart-object-framework/src/systems/core/EntityCore.sol";
import { HookCore } from "@eveworld/smart-object-framework/src/systems/core/HookCore.sol";
import { ModuleCore } from "@eveworld/smart-object-framework/src/systems/core/ModuleCore.sol";
import "@eveworld/common-constants/src/constants.sol";

import { ModulesInitializationLibrary } from "../../src/utils/ModulesInitializationLibrary.sol";
import { SOFInitializationLibrary } from "../../src/utils/SOFInitializationLibrary.sol";
import { SmartObjectLib } from "@eveworld/smart-object-framework/src/SmartObjectLib.sol";
import { HookType } from "@eveworld/smart-object-framework/src/types.sol";
import { EntityRecordOffchainTable, EntityRecordOffchainTableData } from "../../src/codegen/tables/EntityRecordOffchainTable.sol";
import { EntityRecordTableData, EntityRecordTable } from "../../src/codegen/tables/EntityRecordTable.sol";
import { LocationTable, LocationTableData } from "../../src/codegen/tables/LocationTable.sol";
import { DeployableState, DeployableStateData } from "../../src/codegen/tables/DeployableState.sol";
import { InventoryTable, InventoryTableData } from "../../src/codegen/tables/InventoryTable.sol";
import { InventoryItemTable, InventoryItemTableData } from "../../src/codegen/tables/InventoryItemTable.sol";
import { EphemeralInvTable, EphemeralInvTableData } from "../../src/codegen/tables/EphemeralInvTable.sol";
import { EphemeralInvItemTable, EphemeralInvItemTableData } from "../../src/codegen/tables/EphemeralInvItemTable.sol";
import { EntityTable } from "@eveworld/smart-object-framework/src/codegen/tables/EntityTable.sol";
import { EphemeralInvCapacityTable } from "../../src/codegen/tables/EphemeralInvCapacityTable.sol";

import { SmartStorageUnitModule } from "../../src/modules/smart-storage-unit/SmartStorageUnitModule.sol";
import { StaticDataModule } from "../../src/modules/static-data/StaticDataModule.sol";
import { EntityRecordModule } from "../../src/modules/entity-record/EntityRecordModule.sol";
import { ERC721Module } from "../../src/modules/eve-erc721-puppet/ERC721Module.sol";
import { registerERC721 } from "../../src/modules/eve-erc721-puppet/registerERC721.sol";
import { IERC721Mintable } from "../../src/modules/eve-erc721-puppet/IERC721Mintable.sol";
import { SmartDeployableModule } from "../../src/modules/smart-deployable/SmartDeployableModule.sol";
import { SmartDeployable } from "../../src/modules/smart-deployable/systems/SmartDeployable.sol";
import { SmartDeployableLib } from "../../src/modules/smart-deployable/SmartDeployableLib.sol";
import { InventoryLib } from "../../src/modules/inventory/InventoryLib.sol";
import { ItemSellerModule } from "../../src/modules/item-seller/ItemSellerModule.sol";
import { ItemSellerLib } from "../../src/modules/item-seller/ItemSellerLib.sol";
import { IItemSeller } from "../../src/modules/item-seller/interfaces/IItemSeller.sol";
import { LocationModule } from "../../src/modules/location/LocationModule.sol";
import { InventoryModule } from "../../src/modules/inventory/InventoryModule.sol";
import { Inventory } from "../../src/modules/inventory/systems/Inventory.sol";
import { IInventory } from "../../src/modules/inventory/interfaces/IInventory.sol";
import { EphemeralInventory } from "../../src/modules/inventory/systems/EphemeralInventory.sol";
import { InventoryInteract } from "../../src/modules/inventory/systems/InventoryInteract.sol";
import { IInventoryInteract } from "../../src/modules/inventory/interfaces/IInventoryInteract.sol";
import { SmartDeployableErrors } from "../../src/modules/smart-deployable/SmartDeployableErrors.sol";
import { IInventoryErrors } from "../../src/modules/inventory/IInventoryErrors.sol";

import { Utils as CoreUtils } from "@eveworld/smart-object-framework/src/utils.sol";
import { Utils as SmartStorageUnitUtils } from "../../src/modules/smart-storage-unit/Utils.sol";
import { Utils as EntityRecordUtils } from "../../src/modules/entity-record/Utils.sol";
import { Utils as SmartDeployableUtils } from "../../src/modules/smart-deployable/Utils.sol";
import { Utils as LocationUtils } from "../../src/modules/location/Utils.sol";
import { Utils as InventoryUtils } from "../../src/modules/inventory/Utils.sol";
import { Utils as ItemSellerUtils } from "../../src/modules/item-seller/Utils.sol";
import { State } from "../../src/modules/smart-deployable/types.sol";
import { InventoryItem } from "../../src/modules/inventory/types.sol";

import { SmartStorageUnitLib } from "../../src/modules/smart-storage-unit/SmartStorageUnitLib.sol";
import { StaticDataGlobalTableData } from "../../src/codegen/tables/StaticDataGlobalTable.sol";
import "../../src/modules/smart-storage-unit/types.sol";
import { createCoreModule } from "../CreateCoreModule.sol";

contract ItemSellerUnitTest is Test {
  using CoreUtils for bytes14;
  using SmartStorageUnitUtils for bytes14;
  using EntityRecordUtils for bytes14;
  using SmartDeployableUtils for bytes14;
  using InventoryUtils for bytes14;
  using LocationUtils for bytes14;
  using ItemSellerUtils for bytes14;
  using ModulesInitializationLibrary for IBaseWorld;
  using SOFInitializationLibrary for IBaseWorld;
  using SmartObjectLib for SmartObjectLib.World;
  using SmartStorageUnitLib for SmartStorageUnitLib.World;
  using SmartDeployableLib for SmartDeployableLib.World;
  using ItemSellerLib for ItemSellerLib.World;
  using InventoryLib for InventoryLib.World;
  using WorldResourceIdInstance for ResourceId;

  IBaseWorld world;
  SmartObjectLib.World smartObject;
  IERC721Mintable erc721DeployableToken;
  SmartStorageUnitLib.World smartStorageUnit;
  ItemSellerLib.World itemSeller;
  SmartDeployableLib.World smartDeployable;
  InventoryLib.World inventory;

  uint256 storageCapacity = 100000;
  uint256 ephemeralStorageCapacity = 100000;

  bytes14 constant ERC721_DEPLOYABLE = "DeployableTokn";

  function setUp() public {
    world = IBaseWorld(address(new World()));
    world.initialize(createCoreModule());
    // required for `NamespaceOwner` and `WorldResourceIdLib` to infer current World Address properly
    StoreSwitch.setStoreAddress(address(world));

    // installing SOF & other modules (SmartCharacterModule dependancies)
    world.installModule(
      new SmartObjectFrameworkModule(),
      abi.encode(SMART_OBJECT_DEPLOYMENT_NAMESPACE, new EntityCore(), new HookCore(), new ModuleCore())
    );
    world.initSOF();
    smartObject = SmartObjectLib.World(world, SMART_OBJECT_DEPLOYMENT_NAMESPACE);

    // install module dependancies
    _installModule(new PuppetModule(), 0);
    _installModule(new StaticDataModule(), STATIC_DATA_DEPLOYMENT_NAMESPACE);
    _installModule(new EntityRecordModule(), ENTITY_RECORD_DEPLOYMENT_NAMESPACE);
    _installModule(new LocationModule(), LOCATION_DEPLOYMENT_NAMESPACE);
    world.initStaticData();
    world.initEntityRecord();
    world.initLocation();

    erc721DeployableToken = registerERC721(
      world,
      ERC721_DEPLOYABLE,
      StaticDataGlobalTableData({ name: "SmartDeployable", symbol: "SD", baseURI: "" })
    );
    // install SmartDeployableModule
    SmartDeployableModule deployableModule = new SmartDeployableModule();
    if (
      NamespaceOwner.getOwner(WorldResourceIdLib.encodeNamespace(SMART_DEPLOYABLE_DEPLOYMENT_NAMESPACE)) ==
      address(this)
    )
      world.transferOwnership(
        WorldResourceIdLib.encodeNamespace(SMART_DEPLOYABLE_DEPLOYMENT_NAMESPACE),
        address(deployableModule)
      );
    world.installModule(deployableModule, abi.encode(SMART_DEPLOYABLE_DEPLOYMENT_NAMESPACE, new SmartDeployable()));
    world.initSmartDeployable();
    smartDeployable = SmartDeployableLib.World(world, SMART_DEPLOYABLE_DEPLOYMENT_NAMESPACE);
    smartDeployable.registerDeployableToken(address(erc721DeployableToken));

    // Inventory module installation
    InventoryModule inventoryModule = new InventoryModule();
    if (NamespaceOwner.getOwner(WorldResourceIdLib.encodeNamespace(INVENTORY_DEPLOYMENT_NAMESPACE)) == address(this))
      world.transferOwnership(
        WorldResourceIdLib.encodeNamespace(INVENTORY_DEPLOYMENT_NAMESPACE),
        address(inventoryModule)
      );

    world.installModule(
      inventoryModule,
      abi.encode(INVENTORY_DEPLOYMENT_NAMESPACE, new Inventory(), new EphemeralInventory(), new InventoryInteract())
    );
    world.initInventory();
    inventory = InventoryLib.World(world, INVENTORY_DEPLOYMENT_NAMESPACE);

    // SmartStorageUnitModule installation
    _installModule(new SmartStorageUnitModule(), SMART_STORAGE_UNIT_DEPLOYMENT_NAMESPACE);
    world.initSSU();
    smartStorageUnit = SmartStorageUnitLib.World(world, SMART_STORAGE_UNIT_DEPLOYMENT_NAMESPACE);

    // ItemSellerModule installation
    _installModule(new ItemSellerModule(), ITEM_SELLER_DEPLOYMENT_NAMESPACE);
    world.initItemSeller();
    itemSeller = ItemSellerLib.World(world, ITEM_SELLER_DEPLOYMENT_NAMESPACE);

    smartObject.registerEntity(SMART_DEPLOYABLE_CLASS_ID, CLASS);
    world.associateClassIdToSmartDeployable(SMART_DEPLOYABLE_CLASS_ID);
    
    smartObject.registerEntity(SSU_CLASS_ID, CLASS);
    world.associateClassIdToSSU(SSU_CLASS_ID);

    smartObject.registerEntity(ITEM_SELLER_CLASS_ID, CLASS);
    world.associateClassIdToItemSeller(ITEM_SELLER_CLASS_ID);

    smartDeployable.globalResume();

    smartObject.registerEntity(123, OBJECT);
    world.associateEntityRecord(123);
    smartObject.registerEntity(456, OBJECT);
    world.associateEntityRecord(456);

    _registerClassLevelHookItemSeller();
  }

  // helper function to guard against multiple module registrations on the same namespace
  // TODO: Those kind of functions are used across all unit tests, ideally it should be inherited from a base Test contract
  function _installModule(IModule module, bytes14 namespace) internal {
    if (NamespaceOwner.getOwner(WorldResourceIdLib.encodeNamespace(namespace)) == address(this))
      world.transferOwnership(WorldResourceIdLib.encodeNamespace(namespace), address(module));
    world.installModule(module, abi.encode(namespace));
  }

  function _registerClassLevelHookItemSeller() internal {
    ResourceId itemSellerSystemId = ITEM_SELLER_DEPLOYMENT_NAMESPACE.itemSellerSystemId();
    ResourceId inventoryInteractSystemId = INVENTORY_DEPLOYMENT_NAMESPACE.inventoryInteractSystemId();
    ResourceId inventorySystemId = INVENTORY_DEPLOYMENT_NAMESPACE.inventorySystemId();

    uint256 depositHookId = _registerHook(inventorySystemId, IItemSeller.itemSellerDepositToInventoryHook.selector);
    uint256 withdrawHookId = _registerHook(inventorySystemId, IItemSeller.itemSellerWithdrawFromInventoryHook.selector);
    uint256 transferToInvHookId = _registerHook(inventoryInteractSystemId, IItemSeller.itemSellerEphemeralToInventoryTransferHook.selector);
    uint256 transferToEphHookId = _registerHook(inventoryInteractSystemId, IItemSeller.itemSellerInventoryToEphemeralTransferHook.selector);

    smartObject.associateHook(ITEM_SELLER_CLASS_ID, depositHookId);
    smartObject.associateHook(ITEM_SELLER_CLASS_ID, withdrawHookId);
    smartObject.associateHook(ITEM_SELLER_CLASS_ID, transferToInvHookId);
    smartObject.associateHook(ITEM_SELLER_CLASS_ID, transferToEphHookId);

    smartObject.addHook(
      depositHookId,
      HookType.AFTER,
      inventorySystemId,
      IInventory.depositToInventory.selector
    );

    smartObject.addHook(
      withdrawHookId,
      HookType.AFTER,
      inventorySystemId,
      IInventory.withdrawFromInventory.selector
    );
  }

  function _registerHook(ResourceId systemId, bytes4 functionSelector) internal returns (uint256 hookId) {
    smartObject.registerHook(systemId, functionSelector);
    hookId = uint256(keccak256(abi.encodePacked(systemId, functionSelector)));
  }

  function testSetup() public {
    address smartStorageUnitSystem = Systems.getSystem(
      SMART_STORAGE_UNIT_DEPLOYMENT_NAMESPACE.smartStorageUnitSystemId()
    );
    ResourceId smartStorageUnitSystemId = SystemRegistry.get(smartStorageUnitSystem);
    assertEq(smartStorageUnitSystemId.getNamespace(), SMART_STORAGE_UNIT_DEPLOYMENT_NAMESPACE);
  }

  function testCreateAndAnchorItemSeller(uint256 smartObjectId) public {
    EntityRecordData memory entityRecordData = EntityRecordData({ typeId: 12345, itemId: 45, volume: 10 });
    SmartObjectData memory smartObjectData = SmartObjectData({ owner: address(1), tokenURI: "test" });
    WorldPosition memory worldPosition = WorldPosition({ solarSystemId: 1, position: Coord({ x: 1, y: 1, z: 1 }) });
    vm.assume(
      smartObjectId != 0 &&
        !EntityTable.getDoesExists(SMART_OBJECT_DEPLOYMENT_NAMESPACE.entityTableTableId(), smartObjectId)
    );

    itemSeller.createAndAnchorItemSeller(
      smartObjectId,
      entityRecordData,
      smartObjectData,
      worldPosition,
      1e18, // fuelUnitVolume,
      1, // fuelConsumptionPerMinute,
      1000000 * 1e18, // fuelMaxCapacity,
      storageCapacity,
      ephemeralStorageCapacity
    );

    smartDeployable.depositFuel(smartObjectId, 100000);
    smartDeployable.bringOnline(smartObjectId);

    State currentState = DeployableState.getCurrentState(
      SMART_DEPLOYABLE_DEPLOYMENT_NAMESPACE.deployableStateTableId(),
      smartObjectId
    );
    assertEq(uint8(currentState), uint8(State.ONLINE));

    EntityRecordTableData memory entityRecordTableData = EntityRecordTable.get(
      ENTITY_RECORD_DEPLOYMENT_NAMESPACE.entityRecordTableId(),
      smartObjectId
    );

    assertEq(entityRecordTableData.typeId, entityRecordData.typeId);
    assertEq(entityRecordTableData.itemId, entityRecordData.itemId);
    assertEq(entityRecordTableData.volume, entityRecordData.volume);

    LocationTableData memory locationTableData = LocationTable.get(
      LOCATION_DEPLOYMENT_NAMESPACE.locationTableId(),
      smartObjectId
    );
    assertEq(locationTableData.solarSystemId, worldPosition.solarSystemId);
    assertEq(locationTableData.x, worldPosition.position.x);
    assertEq(locationTableData.y, worldPosition.position.y);
    assertEq(locationTableData.z, worldPosition.position.z);

    assertEq(erc721DeployableToken.ownerOf(smartObjectId), address(1));

    smartStorageUnit.setDeploybaleMetadata(smartObjectId, "testName", "testDappURL", "testdesc");

    EntityRecordOffchainTableData memory entityRecordOffchainTableData = EntityRecordOffchainTable.get(
      ENTITY_RECORD_DEPLOYMENT_NAMESPACE.entityRecordOffchainTableId(),
      smartObjectId
    );

    assertEq(entityRecordOffchainTableData.name, "testName");
    assertEq(entityRecordOffchainTableData.dappURL, "testDappURL");
    assertEq(entityRecordOffchainTableData.description, "testdesc");
  }
}
