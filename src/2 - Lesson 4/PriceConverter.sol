// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns(uint256) {
        // - url: https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1
        // - address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // - ABI: interaction functions from AggregatorV3Interface
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        // Price in Ethereum in terms of USD
        (, int256 price, , ,) = priceFeed.latestRoundData(); // extracting only the 'price' from the result
        return uint256(price * 1e10);   
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        // 1 ETH?
        // 2000_000000000000000
        uint256 ethPrice = getPrice();

        // (2000_000000000000000 * 1_000000000000000000) / 1e18
        // $2000 = 1ETH
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }
}