// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {ArraysExercise} from "../src/ArraysExercise.sol";

contract ArraysExerciseTest is Test {
    ArraysExercise public arraysExercise;

    function setUp() public {
        arraysExercise = new ArraysExercise();
    }

    function test_reset() public {
        arraysExercise.resetNumbers();
        uint256[] memory numbers = arraysExercise.getNumbers();
        assert(numbers.length == 10);
        for (uint256 i = 0; i < numbers.length; i++) {
            assert(numbers[i] == i + 1);
        }
    }

    function test_append() public {
        arraysExercise.resetNumbers();
        uint256[] memory toAppend = new uint256[](3);
        toAppend[0] = 11;
        toAppend[1] = 12;
        toAppend[2] = 13;
        arraysExercise.appendToNumbers(toAppend);
        uint256[] memory numbers = arraysExercise.getNumbers();
        assert(numbers.length == 13);
        for (uint256 i = 0; i < numbers.length; i++) {
            assert(numbers[i] == i + 1);
        }
    }

    function test_afterY2K() public {
        arraysExercise.saveTimestamp(1000);
        arraysExercise.saveTimestamp(946702822);
        arraysExercise.saveTimestamp(946702923);

        (uint256[] memory timestampsAfterY2K, address[] memory sendersAfterY2K) = arraysExercise.afterY2K();
        assert(timestampsAfterY2K.length == 2);
        assert(sendersAfterY2K.length == 2);

        assert(timestampsAfterY2K[0] == 946702822);
        assert(timestampsAfterY2K[1] == 946702923);
    }
}
