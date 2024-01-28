// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Script, console2} from "forge-std/Script.sol";
import {WeightedVoting} from "../src/WeightedVoting.sol";

contract WeightedVotingScript is Script {
    function run() public {
        vm.startBroadcast();
        WeightedVoting weightedVoting = new WeightedVoting();
        console2.log("WeightedVoting address: ", address(weightedVoting));
        vm.stopBroadcast();
    }
}
