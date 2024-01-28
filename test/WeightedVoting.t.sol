// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Test, console2} from "forge-std/Test.sol";
import {WeightedVoting} from "../src/WeightedVoting.sol";

contract WeightedVotingTest is Test {
    WeightedVoting public weightedVoting;

    function setUp() public {
        weightedVoting = new WeightedVoting();
    }

    function test_claim() public {
        weightedVoting.claim();
        assert(weightedVoting.balanceOf((address(this))) == 100);
        assert(weightedVoting.totalSupply() == 100);

        // Claiming twice should fail
        bytes4 selector = bytes4(keccak256("TokensClaimed()"));
        vm.expectRevert(abi.encodeWithSelector(selector));
        weightedVoting.claim();

        // Claiming 999 more times should succeed
        for (uint256 i = 0; i < 9999; i++) {
            // We impersonate new addresses everytime to error
            vm.prank(vm.addr(i + 2));
            weightedVoting.claim();
        }

        console2.log("Total supply: ", weightedVoting.totalSupply());

        // Should fail on the 100th claim
        vm.prank(vm.addr(100_000_000));
        selector = bytes4(keccak256("AllTokensClaimed()"));
        vm.expectRevert(abi.encodeWithSelector(selector));
        weightedVoting.claim();
    }

    // @notice Some basic tests for the voting
    function test_vote() public {
        // Create issue should fail if the user has no tokens
        assert(weightedVoting.balanceOf(address(this)) == 0);

        bytes4 selector = bytes4(keccak256("NoTokensHeld()"));
        vm.expectRevert(abi.encodeWithSelector(selector));
        weightedVoting.createIssue("Test issue", 100);

        // We claim some token
        weightedVoting.claim();

        // Should fail if the quorum is too high
        selector = bytes4(keccak256("QuorumTooHigh(uint256)"));
        vm.expectRevert(abi.encodeWithSelector(selector, 1000));
        weightedVoting.createIssue("Test issue", 1000);

        // We create the issue with a quorum of 100
        weightedVoting.createIssue("Test issue", 100);

        // Should fail if the user has already voted
        weightedVoting.vote(1, WeightedVoting.Votes.For);

        // Should fail if the user has already voted
        selector = bytes4(keccak256("VotingClosed()"));
        vm.expectRevert(abi.encodeWithSelector(selector));
        weightedVoting.vote(1, WeightedVoting.Votes.For);

        // The result should be 1 for, 0 against, 0 abstain  and should pass and close
        WeightedVoting.IssueView memory issue = weightedVoting.getIssue(1);
        assert(issue.votesFor == 100);
        assert(issue.votesAgainst == 0);
        assert(issue.votesAbstain == 0);
        assert(issue.totalVotes == 100);
        assert(issue.quorum == 100);
        assert(issue.passed == true);
        assert(issue.closed == true);
    }
}
