// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Test, console2} from "forge-std/Test.sol";
import {UnburnableToken} from "../src/UnburnableToken.sol";

contract UnburnableTokenTest is Test {
    UnburnableToken public unburnableToken;

    function setUp() public {
        unburnableToken = new UnburnableToken();
    }

    function test_claim() public {
        unburnableToken.claim();
        assert(unburnableToken.balances(address(this)) == 1000);
        assert(unburnableToken.totalClaimed() == 1000);

        // Claiming twice should fail
        bytes4 selector = bytes4(keccak256("TokensClaimed()"));
        vm.expectRevert(abi.encodeWithSelector(selector));
        unburnableToken.claim();

        // Claiming 99_999 more times should succeed
        for (uint256 i = 0; i < 99_999; i++) {
            // We impersonate new addresses everytime to error
            vm.prank(vm.addr(i + 2));
            unburnableToken.claim();
        }

        // Should fail on the 100th claim
        vm.prank(vm.addr(100_000_000));
        selector = bytes4(keccak256("AllTokensClaimed()"));
        vm.expectRevert(abi.encodeWithSelector(selector));
        unburnableToken.claim();
    }

    function test_safe_transfer() public {
        // Before claim some tokens
        unburnableToken.claim();

        // Should fail if the recipient has no ETH
        bytes4 selector = bytes4(keccak256("UnsafeTransfer(address)"));
        vm.expectRevert(abi.encodeWithSelector(selector, address(1)));
        unburnableToken.safeTransfer(address(1), 1000);

        // Should fail if the recipient is dead_address
        vm.expectRevert(abi.encodeWithSelector(selector, address(0)));
        unburnableToken.safeTransfer(address(0), 1000);

        // Should succeed if the recipient has ETH
        vm.deal(address(1), 1000);
        unburnableToken.safeTransfer(address(1), 1000);
    }
}
