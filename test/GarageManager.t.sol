// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Test, console2} from "forge-std/Test.sol";
import {GarageManager} from "../src/GarageManager.sol";

contract GarageManagerTest is Test {
    GarageManager public garageManager;

    function setUp() public {
        garageManager = new GarageManager();
    }

    // @notice Check that the records are init correctly
    function test_add_reset_car(string memory make, string memory model, string memory color, uint256 numberOfDoors)
        public
    {
        // User should get an empty list of cars
        GarageManager.Car[] memory getUserCars = garageManager.getMyCars();
        assert(getUserCars.length == 0);

        // Should add the car
        garageManager.addCar(make, model, color, numberOfDoors);
        GarageManager.Car[] memory getUserCarsNow = garageManager.getMyCars();
        assert(getUserCarsNow.length == 1);
        assert(compareStrings(getUserCarsNow[0].make, make) == true);
        assert(compareStrings(getUserCarsNow[0].model, model) == true);
        assert(compareStrings(getUserCarsNow[0].color, color) == true);
        assert(getUserCarsNow[0].numberOfDoors == numberOfDoors);

        // Should return the car of the user
        GarageManager.Car[] memory getUserCarsAddress = garageManager.getUserCars(address(this));
        assert(getUserCarsAddress.length == 1);
        assert(compareStrings(getUserCarsAddress[0].make, make) == true);
        assert(compareStrings(getUserCarsAddress[0].model, model) == true);
        assert(compareStrings(getUserCarsAddress[0].color, color) == true);
        assert(getUserCarsAddress[0].numberOfDoors == numberOfDoors);

        // If reset user garage, should get an empty list of cars
        garageManager.resetMyGarage();
        GarageManager.Car[] memory userCarsReset = garageManager.getMyCars();
        assert(userCarsReset.length == 0);
    }

    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}
