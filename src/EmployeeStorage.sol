// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

// @title EmployeeStorage
// @author NelsonRodMar
contract EmployeeStorage {
    // @notice Private variable storing the employee's number of shares owned
    uint16 private shares;

    // @notice A private variable storing the employee's salary
    uint32 private salary;

    // @notice A public variable storing the employee's ID number
    uint256 public idNumber;

    // @notic Public variable which stores the employee's name
    string public name;

    // @notice An event that is emitted when the employee is granted too many shares
    error TooManyShares(uint256 _shares);

    constructor() {
        shares = 1000;
        name = "Pat";
        salary = 50000;
        idNumber = 112358132134;
    }

    // @notice This function let everyone add new shares to the employee
    // @param _newShares The number of shares to add to the employee
    function grantShares(uint16 _newShares) public {
        if (_newShares > 5000) {
            revert("Too many shares");
        } else if (shares + _newShares > 5000) {
            revert TooManyShares(shares + _newShares);
        }
        shares += _newShares;
    }

    // @notice This function returns the salary of the employee
    // @return salary The salary of the employee
    function viewSalary() public view returns (uint32) {
        return salary;
    }

    // @notice This function returns the shares of the employee
    // @return shares The shares of the employee
    function viewShares() public view returns (uint16) {
        return shares;
    }

    /**
     * Do not modify this function.  It is used to enable the unit test for this pin
     * to check whether or not you have configured your storage variables to make
     * use of packing.
     *
     * If you wish to cheat, simply modify this function to always return `0`
     * I'm not your boss ¯\_(ツ)_/¯
     *
     * Fair warning though, if you do cheat, it will be on the blockchain having been
     * deployed by your wallet....FOREVER!
     */
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    /**
     * Warning: Anyone can use this function at any time!
     */
    function debugResetShares() public {
        shares = 1000;
    }
}