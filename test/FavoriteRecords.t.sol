// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {FavoriteRecords} from "../src/FavoriteRecords.sol";

contract FavoriteRecordsTest is Test {
    FavoriteRecords public favoriteRecords;

    string[] public recordsNamesTest;

    function setUp() public {
        favoriteRecords = new FavoriteRecords();
        recordsNamesTest = [
            "Thriller",
            "Back in Black",
            "The Bodyguard",
            "The Dark Side of the Moon",
            "Their Greatest Hits (1971-1975)",
            "Hotel California",
            "Come On Over",
            "Rumours",
            "Saturday Night Fever"
        ];
    }

    // @notice Check that the records are init correctly
    function test_init_record() public {
        string[] memory getApprovedRecords = favoriteRecords.getApprovedRecords();
        assert(getApprovedRecords.length == recordsNamesTest.length);
        for (uint256 i = 0; i < getApprovedRecords.length; i++) {
            assert(compareStrings(getApprovedRecords[i], recordsNamesTest[i]) == true);
            assert(favoriteRecords.approvedRecords(getApprovedRecords[i]) == true);
        }
    }

    function test_reset_record() public {
        favoriteRecords.resetUserFavorites();
        string[] memory getUserFavorites = favoriteRecords.getUserFavorites(address(this));
        assert(getUserFavorites.length == 0);
    }

    function test_add_record() public {
        // User should get an empty list of favorites
        string[] memory getUserFavorites = favoriteRecords.getUserFavorites(address(this));
        assert(getUserFavorites.length == 0);

        // Should revert with NotApproved error with record "The Wall"
        bytes4 selector = bytes4(keccak256("NotApproved(string)"));
        vm.expectRevert(abi.encodeWithSelector(selector, "The Wall"));
        favoriteRecords.addRecord("The Wall");

        // Should add the record
        favoriteRecords.addRecord(recordsNamesTest[2]);
        favoriteRecords.addRecord(recordsNamesTest[4]);
        string[] memory getUserFavoritesNow = favoriteRecords.getUserFavorites(address(this));
        assert(getUserFavoritesNow.length == 2);
        assert(compareStrings(getUserFavoritesNow[0], recordsNamesTest[2]) == true);
        assert(compareStrings(getUserFavoritesNow[1], recordsNamesTest[4]) == true);

        // If reset user record, should get an empty list of favorites
        favoriteRecords.resetUserFavorites();
        string[] memory userFavoritesReset = favoriteRecords.getUserFavorites(address(this));
        assert(userFavoritesReset.length == 0);
    }

    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}
