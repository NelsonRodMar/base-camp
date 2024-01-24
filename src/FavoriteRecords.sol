// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

// @title FavoriteRecords
// @notice This contract is used to test the overflow detection
// @author NelsonRodMar
contract FavoriteRecords {
    // @notice This mapping contains the approved records
    mapping(string record => bool isApproved) public approvedRecords;

    // @notice This array contains the names of all the records currently indexed
    string[] private recordsNames;

    // @notice This mapping contains the favorite records of each user
    mapping(address user => mapping(string record => bool isFavorite)) public userFavorites;

    // @notice This error is thrown when the record is not approved
    error NotApproved(string record);

    constructor() {
        recordsNames = [
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
        for (uint256 i = 0; i < recordsNames.length; i++) {
            approvedRecords[recordsNames[i]] = true;
        }
    }

    // @notice This function let the user add a record to his favorites if it is approved, otherwise it reverts with NotApproved error
    // @param _recordName The name of the record to add
    function addRecord(string memory _recordName) public {
        if (!approvedRecords[_recordName]) {
            revert NotApproved(_recordName);
        }
        userFavorites[msg.sender][_recordName] = true;
    }

    // @notice This function reset all the favorites records of the user(sender)
    function resetUserFavorites() public {
        for (uint256 i = 0; i < recordsNames.length; i++) {
            userFavorites[msg.sender][recordsNames[i]] = false;
        }
    }

    // @notice This function return a list of all the names currently indexed
    // @return The list of all the names currently indexed
    function getApprovedRecords() public view returns (string[] memory) {
        return recordsNames;
    }

    // @notice This function return a list of all the favorites records of a user
    // @param _user The address of the user
    // @return The list of all the favorites records of the user
    function getUserFavorites(address _user) public view returns (string[] memory) {
        // Need first to know how much favorites record as the user
        uint256 count;
        for (uint256 i = 0; i < recordsNames.length; i++) {
            if (userFavorites[_user][recordsNames[i]]) {
                count++;
            }
        }


        // We can now create the array with the right size
        string[] memory userFavoritesNames = new string[](count);
        if (count != 0) {
            // And fill it with the favorites records
            uint userFavoritesNamesCount;
            for (uint256 i = 0; i < recordsNames.length; i++) {
                if (userFavorites[_user][recordsNames[i]]) {
                    userFavoritesNames[userFavoritesNamesCount] = recordsNames[i];
                    userFavoritesNamesCount++;
                }
            }
        }

            return userFavoritesNames;
    }
}
