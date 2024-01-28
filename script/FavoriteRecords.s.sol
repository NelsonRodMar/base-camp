// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Script, console2} from "forge-std/Script.sol";
import {FavoriteRecords} from "../src/FavoriteRecords.sol";

contract FavoriteRecordsScript is Script {
    function run() public {
        vm.startBroadcast();
        FavoriteRecords favoriteRecords = new FavoriteRecords();
        console2.log("FavoriteRecords address: ", address(favoriteRecords));
        vm.stopBroadcast();
    }
}
