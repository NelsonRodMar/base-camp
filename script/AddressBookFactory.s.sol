// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {AddressBookFactory} from "../src/AddressBookFactory.sol";

contract BasicMathScript is Script {
    function run() public {
        vm.startBroadcast();
        AddressBookFactory addressBookFactory = new AddressBookFactory();
        console2.log("AddressBookFactory address: ", address(addressBookFactory));
        vm.stopBroadcast();
    }
}
