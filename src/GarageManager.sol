// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

// @title GarageManager
// @author NelsonRodMar
contract GarageManager {
    // @notice This struct represent a car
    struct Car {
        string make;
        string model;
        string color;
        uint256 numberOfDoors;
    }

    // @notice This mapping contains the garage of each user
    mapping(address => Car[]) public garage;

    constructor() {}

    // @notice This function reset the garage of the sender
    function resetMyGarage() public {
        delete garage[msg.sender];
    }

    // @notice This function add a car to the garage of the sender
    // @param make The creator of the car
    // @param model The model of the car
    // @param color The color of the car
    // @param numberOfDoors The number of doors of the car
    function addCar(string memory make, string memory model, string memory color, uint256 numberOfDoors) public {
        garage[msg.sender].push(Car(make, model, color, numberOfDoors));
    }

    // @notice This function return all the cars of the sender
    // @return The list of all the cars of the sender
    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }

    // @notice This function return all the cars of a user
    // @param _user The address of the user
    // @return The list of all the cars of the user
    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }
}
