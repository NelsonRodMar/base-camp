// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

// @title AddressBook
// @author NelsonRodMar
contract AddressBook {
    struct Contact {
        uint256 id;
        string firstName;
        string lastName;
        uint256[] phoneNumbers;
    }

    // @notice The owner of the address book
    address public owner;

    // @notice The total number of contacts in the address book
    uint256 private totalContacts;

    // @notice A mapping of contact IDs to contacts (the AddressBook)
    mapping(uint256 => Contact) public contacts;

    // @notice A modifier that only allows the owner to call a function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    error ContactNotFound(uint256 id);

    constructor(address _owner) {
        owner = _owner;
    }

    // @notice Adds a new contact to the address book
    // @dev Only the owner can add a contact
    function addContact(uint256 _id, string memory _firstName, string memory _lastName) public onlyOwner {
        contacts[_id] = Contact(_id, _firstName, _lastName, new uint[](0));
        totalContacts++;
    }

    // @notice Delete a contact from the address book
    // @dev Only the owner can delete a contact
    function deleteContact(uint256 _id) public onlyOwner {
        if (contacts[_id].id == 0) {
            revert ContactNotFound(_id);
        } else {
            delete contacts[_id];
            totalContacts--;
        }
    }

    // @notice Return all contacts in the address book
    // @dev Only the owner can get all contacts
    // @return Contact[] An array of all contacts
    function getAllContacts() public view onlyOwner returns (Contact[] memory) {
        Contact[] memory _contacts = new Contact[](totalContacts);
        for (uint256 i = 0; i < totalContacts; i++) {
            _contacts[i] = contacts[i];
        }
        return _contacts;
    }
}
