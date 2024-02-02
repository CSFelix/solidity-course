// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract HelloWorld {
  function sayHello(string calldata _name) public pure returns(string memory) {
    return string(abi.encodePacked("Hello World ", _name, "!"));
  }
}