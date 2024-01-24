// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Employee} from "./Employee.sol";

// @title Hourly
// @author NelsonRodMar
contract Hourly is Employee {
    uint256 public hourlyRate;

    constructor(uint256 _idNumber, uint256 _managerId, uint256 _hourlyRate) Employee(_idNumber, _managerId) {
        hourlyRate = _hourlyRate;
    }

    function getAnnualCost() public view override returns (uint256) {
        return hourlyRate * 2080;
    }
}
