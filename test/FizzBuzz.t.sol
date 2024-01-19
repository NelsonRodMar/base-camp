// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {FizzBuzz} from "../src/FizzBuzz.sol";

contract BasicMathTest is Test {
    FizzBuzz public fizzBuzz;

    function setUp() public {
        fizzBuzz = new FizzBuzz();
    }

    // Check multiple things :
    //  - return "Fizz" if the _number is divisible by 3
    //  - return "Buzz" if the _number is divisible by 5
    //  - return "FizzBuzz" if the _number is divisible by 3 and 5
    //  - return "Splat" if the _number is not divisible by 3 or 5
    function test_fizzbuzz(uint256 _number) public view {
        string memory result = fizzBuzz.fizzBuzz(_number);
        if (_number % 3 == 0 && _number % 5 == 0) {
            assert(keccak256(abi.encodePacked(result)) == keccak256(abi.encodePacked("FizzBuzz")));
        } else if (_number % 3 == 0) {
            assert(keccak256(abi.encodePacked(result)) == keccak256(abi.encodePacked("Fizz")));
        } else if (_number % 5 == 0) {
            assert(keccak256(abi.encodePacked(result)) == keccak256(abi.encodePacked("Buzz")));
        } else {
            assert(keccak256(abi.encodePacked(result)) == keccak256(abi.encodePacked("Splat")));
        }
    }
}
