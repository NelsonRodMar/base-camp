// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Script, console2} from "forge-std/Script.sol";
import {GarageManager} from "../src/GarageManager.sol";

contract GarageManagerScript is Script {
    function run() public {
        vm.startBroadcast();
        GarageManager garageManager = new GarageManager();
        console2.log("GarageManager address: ", address(garageManager));
        vm.stopBroadcast();
    }
}
