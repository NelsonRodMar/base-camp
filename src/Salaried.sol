// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Employee} from "./Employee.sol";

// @title Salaried
// @author NelsonRodMar
contract Salaried is Employee {
    uint256 public annualSalary;

    constructor(uint256 _idNumber, uint256 _managerId, uint256 _annualSalary) Employee(_idNumber, _managerId) {
        annualSalary = _annualSalary;
    }

    function getAnnualCost() public view override returns (uint256) {
        return annualSalary;
    }
}
