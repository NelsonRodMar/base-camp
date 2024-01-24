// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Salesperson} from "../src/Salesperson.sol";
import {EngineeringManager} from "../src/EngineeringManager.sol";
import {InheritanceSubmission} from "../src/InheritanceSubmission.sol";

contract InheritanceSubmissionScript is Script {
    function run() public {
        vm.startBroadcast();
        Salesperson salesperson = new Salesperson(55555,12345,20);
        console2.log("Salesperson address: ", address(salesperson));

        EngineeringManager engineeringManager = new EngineeringManager(54321, 11111, 200000);
        console2.log("EngineeringManager address: ", address(engineeringManager));

        InheritanceSubmission inheritanceSubmission =
            new InheritanceSubmission(address(salesperson), address(engineeringManager));
        console2.log("InheritanceSubmission address: ", address(inheritanceSubmission));
        vm.stopBroadcast();
    }
}
