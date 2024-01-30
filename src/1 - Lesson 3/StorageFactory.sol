// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { SimpleStorage } from "./SimpleStorage.sol";

contract StorageFactory {
    // ---- States ----
    SimpleStorage[] public listOfSimpleStorageContracts;


    // ---- Functions ----
    function createSimpleStorageContract() public {
        // - the 'new' keyword is used to deploy a contract into another contract.
        // - in this case, we are deploying the 'SimpleStorage' contract into
        // 'StorageFactory' contract.
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function storageFactoryStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // Address
        // ABI (Application Binary Interface)
        listOfSimpleStorageContracts[_simpleStorageIndex].storeMyFavoriteNumber(_newSimpleStorageNumber);
    }

    function storageFactoryGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieveMyFavoriteNumber();
    }
}