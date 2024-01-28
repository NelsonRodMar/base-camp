// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

// @title Employee
// @author NelsonRodMar
abstract contract Employee {
    uint256 public idNumber;
    uint256 public managerId;

    constructor(uint256 _idNumber, uint256 _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    function getAnnualCost() public view virtual returns (uint256);
}
