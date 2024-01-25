// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {UnburnableToken} from "../src/UnburnableToken.sol";

contract UnburnableTokenScript is Script {
    function run() public {
        vm.startBroadcast();
        UnburnableToken unburnableToken = new UnburnableToken();
        console2.log("UnburnableToken address: ", address(unburnableToken));
        vm.stopBroadcast();
    }
}
