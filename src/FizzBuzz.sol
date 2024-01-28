// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

// @title FizzBuzz
// @author NelsonRodMar
contract FizzBuzz {
    constructor() {}

    error AfterHours(uint256 _time);

    // @notice This function a different string depending on the number
    // @param _number The number
    // @return result The string result
    function fizzBuzz(uint256 _number) public pure returns (string memory result) {
        if (_number % 3 == 0 && _number % 5 == 0) {
            result = "FizzBuzz";
        } else if (_number % 3 == 0) {
            result = "Fizz";
        } else if (_number % 5 == 0) {
            result = "Buzz";
        } else {
            result = "Splat";
        }
    }

    // @notice This function return the difference of the two number and a boold true if overflow otherwise false
    // @param _time The first number
    // @return result The result in a string form
    function doNotDisturb(uint256 _time) public pure returns (string memory result) {
        assert(_time < 2400);
        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        } else if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        } else if (_time >= 800 && _time <= 1199) {
            result = "Morning!";
        } else if (_time >= 1300 && _time <= 1799) {
            result = "Afternoon!";
        } else if (_time >= 1800 && _time <= 2200) {
            result = "Evening!";
        }
    }
}
