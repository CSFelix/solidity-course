// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ReceiveAndFallbackExamples {
    // ---- States ----
    //
    // - uint256 default value: 0
    //
    uint256 public receiveCalls;
    uint256 public fallbackCalls;

    // ---- Special Functions ----
    receive() external payable { receiveCalls += 1; }
    fallback() external payable { fallbackCalls += 1; }
}