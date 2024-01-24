// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// @title InheritanceSubmission
// @author NelsonRodMar
contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}
