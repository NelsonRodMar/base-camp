// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// @title HaikuNFT
// @author NelsonRodMar
contract HaikuNFT is ERC721 {
    // @notice Struct to store a haiku
    struct Haiku {
        address autor;
        string line1;
        string line2;
        string line3;
    }

    // @notice An array of all the haikus
    Haiku[] public haikus;

    // @notice Mapping user to shared haikus
    mapping(address => uint256[]) public sharedHaikus;

    // @notice Mapping to check if a line is already used
    mapping(string => bool) private usedLines;

    // @notice Counter to keep track of the number of haikus
    uint256 public counter = 1;

    error NotYourHaiku(uint256 id);
    error HaikuNotUnique();
    error NoHaikusShared();

    constructor() ERC721("HaikuNFT", "HAIKU") {}

    // @notice Mint a new haiku
    // @dev The haiku is minted to the caller and any line of the haiku must be unique
    // @param _line1 The first line of the haiku
    // @param _line2 The second line of the haiku
    // @param _line3 The third line of the haiku
    function mintHaiku(string memory _line1, string memory _line2, string memory _line3) external {
        if (counter > 11) revert("No more haikus");
        // Check that the line are not already used
        if (usedLines[_line1] || usedLines[_line2] || usedLines[_line3]) {
            revert HaikuNotUnique();
        }

        usedLines[_line1] = true;
        usedLines[_line2] = true;
        usedLines[_line3] = true;

        haikus.push(Haiku(msg.sender, _line1, _line2, _line3));
        _mint(msg.sender, counter);

        counter++;
    }

    // @notice Share a haiku with another user
    // @dev The haiku must belong to the caller
    // @param _to The address of the user to share the haiku with
    // @param _id The id of the haiku to share
    function shareHaiku(address _to, uint256 _id) external {
        if (haikus[_id].autor != msg.sender) revert NotYourHaiku(_id);
        sharedHaikus[_to].push(_id);
    }

    // @notice Get all the haikus shared with the caller
    // @dev The caller must have at least one haiku shared with them otherwise it will revert
    // @return _haikus The haikus shared with the caller
    function getMySharedHaikus() public view returns (Haiku[] memory) {
        // We first need to know how many haikus is shared with the caller
        uint256 totalHaikuShared = sharedHaikus[msg.sender].length;
        if (totalHaikuShared == 0) revert NoHaikusShared();

        // We create an array of haikus with the correct size
        Haiku[] memory _haikus = new Haiku[](totalHaikuShared);

        // We fill the array with the haikus
        for (uint256 i = 0; i < totalHaikuShared; i++) {
            _haikus[i] = haikus[sharedHaikus[msg.sender][i]];
        }

        return _haikus;
    }
}
