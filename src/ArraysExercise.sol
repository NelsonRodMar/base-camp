// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// @title ArraysExercise
// @notice This contract is used to test the overflow detection
// @author NelsonRodMar
contract ArraysExercise {

    // @notice This array contains the numbers from 1 to 10
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];

    // @notice This array contains the addresses of the senders
    address[] public senders;

    // @notice This array contains the timestamps of the transactions
    uint[] public timestamps;


    // @notice This function the number array
    function getNumbers() public view returns(uint[] memory) {
        return numbers;
    }

    // @notice This function reset the array to its initial state
    function resetNumbers() public {
        delete numbers;
        for (uint i = 1; i <= 10; i++) {
            numbers.push(i);
        }
    }

    // @notice This function append the new numbers array to the existing one
    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    // @notice Save the sender and the timestamp (send) of the tx
    // @param _unixTimestamp The timestamp of the tx
    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    // @notice This function reset the senders array to its initial state
    function resetSenders() public {
        delete senders;
    }

    // @notice This function reset the timestamps array to its initial state
    function resetTimestamps() public {
        delete timestamps;
    }   

    // @notice This function return all the tx and timestamp of it after the January 1, 2000, 12:00am
    // @return timestampsAfterY2K The timestamps of the tx after the January 1, 2000, 12:00am
    // @return sendersAfterY2K The senders of the tx after the January 1, 2000, 12:00am
    function afterY2K() public view returns (uint[] memory, address[] memory) {
        // Need first to count the number of tx after the January 1, 2000, 12:00am
        uint count = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                count++;
            }
        }

        // Then create the arrays with the right size
        uint[] memory timestampsAfterY2K = new uint[](count);
        address[] memory sendersAfterY2K = new address[](count);

        // Need index to keep track of the index of the new arrays
        uint index = 0;

        // Then fill the arrays with the right values
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                timestampsAfterY2K[index] = timestamps[i];
                sendersAfterY2K[index] = senders[i];
                index++;
            }
        }
        
        return (timestampsAfterY2K, sendersAfterY2K);
    }
}