// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Script, console2} from "forge-std/Script.sol";
import {ImportsExercise} from "../src/ImportsExercise.sol";

contract ImportsExerciseScript is Script {
    function run() public {
        vm.startBroadcast();
        ImportsExercise importsExercise = new ImportsExercise();
        console2.log("ImportsExercise address: ", address(importsExercise));
        vm.stopBroadcast();
    }
}
