// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19; // runs on solidity version 0.8.19 and later

// Contracts are like 'Classes' in other programming languages
contract SimpleStorage {
    /*
        ---- Basic Types ----

        - boolean;
        - uint (only positive numbers);
        - int;
        - address (it's like the wallet number in MetaMask);
        - bytes.

        ---

        - bool hasFavoriteNumber = true;
        - uint256 favoriteNumber = 7; // uint256 uses up to 256 bits to represent the number. 256 bits is the default.
        - string favoriteNumberInText = "seven";
        - int256 favoriteNumberInteger = -7;
        - address myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        - bytes32 favoriteBytes32 = "goku"; // 0x2aser25fs (bytes can be represented in '0x' format or in string format
    */

    /*
        ---- States Visibility ----
        
        - internal: the state can only be accessed by the current contract and by the contracts
    that inherit from the current one;
        - public: the state can be accessed by any contracts;
        - private: the state can only be accessed by the current contract.
    */

    /*
        ---- States Keywords ----

        - constant: the state has its value assigned in its creation and cannot be changed;
        - immutable: the state has its value assigned later, such as in the constructor, and,
    once the value is set, it cannot be changed.
    */

    /*
        ---- Functions Visibility ----

        - external: the function can be accessed by any contracts, except by the current one;
        - internal: the function can only be accessed by the current contract and by the
    contracts that inherit from the current one;
        - public: the function can be accessed by any contracts;
        - private: the function can only be accessed by the current contract.
    */
    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    uint256 internal myFavoriteNumber; // default value: 0. State Variable.

    // Arrays Default Value: []
    // Person[3] public listOfPeople; static array: maximum of 3 elements
    Person[] public listOfPeople; // dinamic array (unlimited number of elements)

    // Goku -> 5
    mapping(string => uint256) public nameToFavoriteNumber;

    function storeMyFavoriteNumber(uint256 _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
    }

    /*
        ---- Keywords: view and pure. ----
    
        - View Keyword: the function does not do transactions, only returns states;
        - Pure Keyword: the function does not do transactions, only returns values.
    */
    function retrieveMyFavoriteNumber() public view returns(uint256) {
        return myFavoriteNumber;
    }

    /*
        ---- More Keywords ----
    
        - calldata: the variable is temporary and only exists in the function. Cannot have its value changed into the functiono (immutable);
        - memory: the variable is temporary and only exists in the function. Can have its value changed into the function (mutable;
        - storage: the variable is a state and exists in the whole contract.
    */
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
