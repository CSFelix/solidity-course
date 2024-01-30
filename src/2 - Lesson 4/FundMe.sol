// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// TO-DO:
// - get funds from users;
// - withdraw funds;
// - set a minimum funding value in USD

contract FundMe {
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
        require(getConversionRate(msg.value) >= minimumUsd, "You have to send at least 1 Ethereum!!"); 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function getPrice() public view returns(uint256) {
        // - url: https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1
        // - address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // - ABI: interaction functions from AggregatorV3Interface
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        // Price in Ethereum in terms of USD
        (, int256 price, , ,) = priceFeed.latestRoundData(); // extracting only the 'price' from the result
        return uint256(price * 1e10);   
    }
    
    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        // 1 ETH?
        // 2000_000000000000000
        uint256 ethPrice = getPrice();

        // (2000_000000000000000 * 1_000000000000000000) / 1e18
        // $2000 = 1ETH
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }
}