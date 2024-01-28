// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {HaikuNFT} from "../src/HaikuNFT.sol";

contract HaikuNFTScript is Script {
    function run() public {
        vm.startBroadcast();
        HaikuNFT haikuNFT = new HaikuNFT();
        console2.log("HaikuNFT address: ", address(haikuNFT));
        vm.stopBroadcast();
    }
}
