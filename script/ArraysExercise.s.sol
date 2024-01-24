// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {ArraysExercise} from "../src/ArraysExercise.sol";

contract ArraysExerciseScript is Script {
    function run() public {
        vm.startBroadcast();
        ArraysExercise arraysExercice = new ArraysExercise();
        console2.log("ArraysExercise address: ", address(arraysExercice));
        vm.stopBroadcast();
    }
}
