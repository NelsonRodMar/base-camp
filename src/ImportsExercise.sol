// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./SillyStringUtils.sol";

// @title ImportsExercise
// @author @NelsonRodMar
contract ImportsExercise {
    using SillyStringUtils for SillyStringUtils.Haiku;

    SillyStringUtils.Haiku public haiku;

    // @notice Take three lines and save them as a haiku
    // @param _line1 The first line of the haiku
    // @param _line2 The second line of the haiku
    // @param _line3 The third line of the haiku
    function saveHaiku(string memory _line1, string memory _line2, string memory _line3) public {
        haiku = SillyStringUtils.Haiku(_line1, _line2, _line3);
    }

    // @notice Return the haiku
    // @return The haiku as a Haiku type
    function getHaiku() public view returns (SillyStringUtils.Haiku memory) {
        return haiku;
    }

    // @notice Return the haiku with a shruggie on the third line without modifying the original haiku
    // @return The haiku as a Haiku type
    function shruggieHaiku() public view returns (SillyStringUtils.Haiku memory) {
        SillyStringUtils.Haiku memory _haiku = getHaiku();
        _haiku.line3 = SillyStringUtils.shruggie(_haiku.line3);
        return _haiku;
    }
}
