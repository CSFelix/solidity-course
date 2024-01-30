// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { SimpleStorage } from "./SimpleStorage.sol";

// 'is' keyword is used for Inheritance
contract AddFiveStorage is SimpleStorage {
    
    // Overriding 'storeMyFavoriteNumber' function to add +5 to the number
    function storeMyFavoriteNumber(uint256 _favoriteNumber) public override {
        myFavoriteNumber = _favoriteNumber + 5;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public override {
        listOfPeople.push(Person(_favoriteNumber + 5, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber + 5;
    }
}