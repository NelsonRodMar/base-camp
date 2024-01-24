// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {AddressBook} from "./AddressBook.sol";

// @title AddressBookFactory
// @author NelsonRodMar
contract AddressBookFactory {
    // @notice An array of all deployed AddressBook contracts
    address[] public addressBooks;

    constructor() {}

    // @notice Deploys a new AddressBook contract
    // @return AddressBook The newly deployed AddressBook contract
    function deploy() public returns (AddressBook) {
        AddressBook addressBook = new AddressBook(msg.sender);
        addressBooks.push(address(addressBook));
        return addressBook;
    }

    // @notice Returns all deployed AddressBook contracts
    // @return address[] An array of all deployed AddressBook contracts
    function getAllAddressBooks() public view returns (address[] memory) {
        return addressBooks;
    }
}
