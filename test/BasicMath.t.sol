// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {BasicMath} from "../src/BasicMath.sol";

contract BasicMathTest is Test {
    BasicMath public basicMath;

    function setUp() public {
        basicMath = new BasicMath();
    }

    // Check if overflow is detected
    function test_adder(uint256 firstNumber, uint256 secondNumber) public view {
        (uint256 sum, bool error) = basicMath.adder(firstNumber, secondNumber);
        unchecked {
            if (firstNumber + secondNumber >= firstNumber) {
                assert(sum == firstNumber + secondNumber);
                assert(error == false);
            } else {
                assert(sum == 0);
                assert(error == true);
            }
        }
    }

    // Check if underflow is detected
    function test_subtractor(uint256 firstNumber, uint256 secondNumber) public view {
        (uint256 difference, bool error) = basicMath.subtractor(firstNumber, secondNumber);
        unchecked {
            if (firstNumber - secondNumber <= firstNumber) {
                assert(difference == firstNumber - secondNumber);
                assert(error == false);
            } else {
                assert(difference == 0);
                assert(error == true);
            }
        }
    }
}
