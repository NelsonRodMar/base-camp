// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Script, console2} from "forge-std/Script.sol";
import {ErrorTriageExercise} from "../src/ErrorTriageExercise.sol";

contract ErrorTriageExerciseScript is Script {
    function run() public {
        vm.startBroadcast();
        ErrorTriageExercise errorTriageExercise = new ErrorTriageExercise();
        console2.log("ErrorTriageExercise address: ", address(errorTriageExercise));
        vm.stopBroadcast();
    }
}
