// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Hourly} from "./Hourly.sol";

// @title Salesperson
// @author NelsonRodMar
contract Salesperson is Hourly {
    constructor(uint256 _idNumber, uint256 _managerId, uint256 _hourlyRate)
        Hourly(_idNumber, _managerId, _hourlyRate)
    {}
}
