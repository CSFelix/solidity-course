// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { PriceConverter } from "./PriceConverter.sol";

// TO-DO:
// - get funds from users;
// - withdraw funds;
// - set a minimum funding value in USD

// Gas Consumption to Create the Contract:
// 826,396 gas // pure
// 806,445 gas // adding constant keyword
// 782,878 gas // adding immmutable keyword
contract FundMe {
    // ---- Usings ----
    using PriceConverter for uint256; // PriceConverter library is going to be used with uint256 variables
    // also it adds all its functions into the 'msg.value' global variable

    // ---- States ----
    uint256 public constant MINIMU_USD = 5e18; // minimum value of U$5.00
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    address public immutable i_owner;

    // ---- Constructor -----
    constructor() { i_owner = msg.sender; }

    // ---- Functions ----
    function fund() public payable {
        // - allows users to send money
        // - has a minimum amount of money to sent
        // Question 1) How do we send Ethereum to this contract? 'payable' keyword
        
        // - 'msg.value' is a global variable that tells the amount of money in the transaction
        // - also, 1e18 is equals to 1 Ethereum in Wei
        // - the 'require' checks if the condition is true, if that's so, the transaction goes on, else
        // the transaction is reverted
        //
        // - What is a revert?
        // It undoes any actions that have been done and sends the REMAINING gas back!!
        require(msg.value.getConversionRate() >= MINIMU_USD, "You have to send at least 1 Ethereum!!"); 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // Withdrawing money from all funders (in the programming logic)
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex = funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // Resetting the Funders Array
        funders = new address[](0);

        // Withdrawing Ethereum to the Wallet.
        // Methods:
        //   - transfer
        //   - send
        //   - call
        //

        // ---- Transfer ----
        //
        // - supports up to 2,300 gas, if the function goes up to it, it throws an error
        //
        // payable(msg.sender).transfer(address(this).balance);

        // ---- Send ----
        //
        // - supports the limit gas you set, if the function goes up to it, returns false; else returns true.
        //
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed!");

        // ---- Call (Better Method) ----
        //
        // - supports up to 2,300 gas, if the function goes up to it, returns false; else returns true.
        //
        ( bool callSuccess, /* bytes memory dataReturned */ ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed!");
    }

    // ---- Modifiers ----
    //
    // - modifiers allows you to create functions that works out like 'personalized keywords' to add in other functions;
    // - the modifiers codes are executed in the function that uses their keywords;
    // - _; >> indicates the function code that uses their keywords.
    //
    modifier onlyOwner() {
        // _; // if the underscore were here, the code of the function would be executed first and the require condition would be checked later

        // Only the owner can withdraw the money from the contracts
        require(msg.sender == i_owner, "Only the Owner can withdraw the money from the contracts!");
        _; // execute the code of the function where the keyword is in it
    }
}