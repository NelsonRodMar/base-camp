// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {BasicMath} from "../src/BasicMath.sol";

contract BasicMathScript is Script {
    function run() public {
        vm.startBroadcast();
        BasicMath basicMath = new BasicMath();
        console2.log("BasicMath address: ", address(basicMath));
        vm.stopBroadcast();
    }
}
