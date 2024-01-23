// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {EmployeeStorage} from "../src/EmployeeStorage.sol";

contract EmployeeStorageScript is Script {
    function run() public {
        vm.startBroadcast();
        EmployeeStorage employeeStorage = new EmployeeStorage();
        console2.log("EmployeeStorage address: ", address(employeeStorage));
        vm.stopBroadcast();
    }
}
