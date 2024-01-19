// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {FizzBuzz} from "../src/FizzBuzz.sol";

contract FizzBuzzScript is Script {
    function run() public {
        vm.startBroadcast();
        FizzBuzz fizzBuzz = new FizzBuzz();
        console2.log("FizzBuzz address: ", address(fizzBuzz));
        vm.stopBroadcast();
    }
}
