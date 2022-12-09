// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function onlyOwner() public view {
        require(msg.sender == owner, "Not the owner");
    }
}
