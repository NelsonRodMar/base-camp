// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

// @title UnburnableToken
// @author NelsonRodMar
contract UnburnableToken {
    // @notice Balance of each user
    mapping(address => uint256) public balances;

    // @notice Whether a user has claimed their tokens
    mapping(address => bool) public hasClaimed;

    // @notice The total supply of tokens
    uint256 public totalSupply;

    // @notice The total number of tokens claimed
    uint256 public totalClaimed;

    // @notice An error that is thrown when a user tries to claim tokens twice
    error TokensClaimed();

    // @notice An error that is thrown when all tokens have been claimed
    error AllTokensClaimed();

    // @notice An error that is thrown when a user tries to transfer tokens to a dead address or an address with no ETH
    error UnsafeTransfer(address _to);

    constructor() {
        totalSupply = 100_000_000;
    }

    // @notice Let a user claim 1_000 tokens
    // @dev This function checks that the user has not already claimed tokens and that there are still tokens to claim
    function claim() public {
        if (hasClaimed[msg.sender]) revert TokensClaimed();
        if (totalClaimed >= totalSupply) revert AllTokensClaimed();

        hasClaimed[msg.sender] = true;
        balances[msg.sender] = 1000;
        totalClaimed += 1000;
    }

    // @notice Transfer tokens to another user
    // @dev This function check that the recipient is dead_address and that the recipient has some ETH
    function safeTransfer(address _to, uint256 _amount) public {
        if (address(_to).balance == 0 || _to == address(0)) revert UnsafeTransfer(_to);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}
