// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Salaried} from "./Salaried.sol";
import {Manager} from "./Manager.sol";

// @title EngineeringManager
// @author NelsonRodMar
contract EngineeringManager is Salaried, Manager {
    constructor(uint256 _idNumber, uint256 _managerId, uint256 _annualSalary)
        Salaried(_idNumber, _managerId, _annualSalary)
    {}
}
