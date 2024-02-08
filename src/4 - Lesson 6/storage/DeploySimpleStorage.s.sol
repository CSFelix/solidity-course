// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

// ***---- Notes ----***
//
// - '.s.sol' is a Foundry convention to tell that the file is a script instead
// of a common solidity file;
//
// - in order to tell that the contract is a Script, we add 'is Script' in its
// declaration (inheritance)
contract DeploySimpleStorage is Script {
    function run() external returns (SimpleStorage) {
        // - 'vm' is a cheat code from Foundry Forge-std library;
        // - everything that is between the start and the end of the vm
        // will be deployed;
        //
        vm.startBroadcast();
        SimpleStorage simpleStorage = new SimpleStorage();
        vm.stopBroadcast();
        return simpleStorage;
    }
}
