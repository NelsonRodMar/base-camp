// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

// @title ErrorTriageExercise
// @author NelsonRodMar
contract ErrorTriageExercise {
    /**
     * Finds the difference between each uint with it's neighbor (a to b, b to c, etc.)
     * and returns a uint array with the absolute integer difference of each pairing.
     */
    function diffWithNeighbor(uint256 _a, uint256 _b, uint256 _c, uint256 _d) public pure returns (uint256[] memory) {
        uint256[] memory results = new uint[](3);
        results[0] = absDiff(_a, _b);
        results[1] = absDiff(_b, _c);
        results[2] = absDiff(_c, _d);
        return results;
    }

    function absDiff(uint256 _a, uint256 _b) public pure returns (uint256) {
        if (_a > _b) {
            return _a - _b;
        } else {
            return _b - _a;
        }
    }

    /**
     * Changes the _base by the value of _modifier.  Base is always >= 1000.  Modifiers can be
     * between positive and negative 100;
     */
    function applyModifier(uint256 _base, int256 _modifier) public pure returns (uint256) {
        return uint256(int256(_base) + _modifier);
    }

    /**
     * Pop the last element from the supplied array, and return the popped
     * value (unlike the built-in function)
     */
    uint256[] arr;

    function popWithReturn() public returns (uint256 last) {
        last = arr[arr.length - 1];
        arr.pop();
    }

    // The utility functions below are working as expected
    function addToArr(uint256 _num) public {
        arr.push(_num);
    }

    function getArr() public view returns (uint256[] memory) {
        return arr;
    }

    function resetArr() public {
        delete arr;
    }
}
