// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { PriceConverter } from "./PriceConverter.sol";

// TO-DO:
// - get funds from users;
// - withdraw funds;
// - set a minimum funding value in USD

contract FundMe {
    // ---- Usings ----
    using PriceConverter for uint256; // PriceConverter library is going to be used with uint256 variables
    // also it adds all its functions into the 'msg.value' global variable

    // ---- States ----
    uint256 public minimumUsd = 5e18; // minimum value of U$5.00
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

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
        require(msg.value.getConversionRate() >= minimumUsd, "You have to send at least 1 Ethereum!!"); 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }
}