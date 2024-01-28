// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

// @title WeightedVoting
// @author NelsonRodMar
contract WeightedVoting is ERC20 {
    using EnumerableSet for EnumerableSet.AddressSet;

    struct Issue {
        EnumerableSet.AddressSet voters;
        string issueDesc;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 votesAbstain;
        uint256 totalVotes;
        uint256 quorum;
        bool passed;
        bool closed;
    }

    struct IssueView {
        address[] voters;
        string issueDesc;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 votesAbstain;
        uint256 totalVotes;
        uint256 quorum;
        bool passed;
        bool closed;
    }

    enum Votes {
        For,
        Against,
        Abstain
    }

    // @notice Balance of each user
    mapping(address => uint256) public balances;

    // @notice Whether a user has claimed their tokens
    mapping(address => bool) public hasClaimed;

    // @notice The total supply of tokens
    uint256 public maxSupply = 1_000_000;

    // @notice The list of issues
    Issue[] private issues;

    error TokensClaimed();
    error AllTokensClaimed();
    error NoTokensHeld();
    error QuorumTooHigh(uint256 quorum);
    error AlreadyVoted();
    error VotingClosed();

    constructor() ERC20("WeightedVoting", "WV") {
        Issue storage newIssue = issues.push();
        newIssue.issueDesc = "burnt";
        newIssue.closed = true;
    }

    // @notice Let a user claim 100 tokens
    // @dev This function checks that the user has not already claimed tokens and that there are still tokens to claim
    function claim() public {
        if (hasClaimed[msg.sender]) revert TokensClaimed();
        if (totalSupply() >= maxSupply) revert AllTokensClaimed();

        hasClaimed[msg.sender] = true;
        _mint(msg.sender, 100);
    }

    // @notice Let a user create an issue
    // @dev This function checks that the user has some tokens and that the quorum is not too high (> totalSupply)
    // @param _issueDesc The description of the issue
    // @param _quorum The quorum required to pass the issue
    // @return issueId The id of the issue
    function createIssue(string calldata _issueDesc, uint256 _quorum) external returns (uint256) {
        if (balanceOf(msg.sender) == 0) revert NoTokensHeld();
        if (_quorum > totalSupply()) revert QuorumTooHigh(_quorum);

        Issue storage newIssue = issues.push();
        newIssue.issueDesc = _issueDesc;
        newIssue.quorum = _quorum;

        return issues.length - 1;
    }

    // @notice This function return an Issue from an id
    // @param _issueId The id of the issue
    // @return The issue view
    function getIssue(uint256 _issueId) external view returns (IssueView memory) {
        Issue storage issue = issues[_issueId];
        return IssueView({
            voters: issue.voters.values(),
            issueDesc: issue.issueDesc,
            quorum: issue.quorum,
            totalVotes: issue.totalVotes,
            votesFor: issue.votesFor,
            votesAgainst: issue.votesAgainst,
            votesAbstain: issue.votesAbstain,
            passed: issue.passed,
            closed: issue.closed
        });
    }

    // @notice Let a user vote on an issue
    // @dev This function checks that the user has not already voted,that they have some tokens and that the issue is not closed
    // @param _issueId The id of the issue
    // @param _vote The vote of the user
    function vote(uint256 _issueId, Votes _vote) external {
        Issue storage issue = issues[_issueId];
        if (issue.closed) revert VotingClosed();
        if (issue.voters.contains(msg.sender)) revert AlreadyVoted();
        if (balanceOf(msg.sender) == 0) revert NoTokensHeld();

        issue.voters.add(msg.sender);
        issue.totalVotes += balanceOf(msg.sender);

        if (_vote == Votes.For) {
            issue.votesFor += balanceOf(msg.sender);
        } else if (_vote == Votes.Against) {
            issue.votesAgainst += balanceOf(msg.sender);
        } else {
            issue.votesAbstain += balanceOf(msg.sender);
        }

        if (issue.totalVotes >= issue.quorum) {
            if (issue.votesFor > issue.votesAgainst) {
                issue.passed = true;
            }

            issue.closed = true;
        }
    }
}
