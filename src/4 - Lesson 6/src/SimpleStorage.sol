// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage {
    //
    //  ***---- Structs ----***
    //
    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    //
    //   ***---- States ----***
    //
    uint256 internal myFavoriteNumber;
    Person[] public listOfPeople;
    mapping(string => uint256) public nameToFavoriteNumber;

    //
    //  ***---- Functions ----***
    //
    function storeMyFavoriteNumber(uint256 _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
    }

    function retrieveMyFavoriteNumber() public view returns (uint256) {
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
