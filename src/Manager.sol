// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// @title Manager
// @author NelsonRodMar
contract Manager {
    uint256[] public employeeIds;

    constructor() {}

    function addReport(uint256 _employeeId) public {
        employeeIds.push(_employeeId);
    }

    function resetReports() public {
        delete employeeIds;
    }
}
