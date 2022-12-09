// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract User {
    function callOnlyOwner(Counter c) public {
        c.onlyOwner();
    }
}

contract CounterTest is DSTest {
    Counter counter;
    User user;

    function setUp() public {
        counter = new Counter(address(this));
        user = new User();
    }

    function testOwner() public {
        assertEq(counter.owner(), address(this));
    }

    function testFailOwner() public {
        user.callOnlyOwner(counter);
    }

    // function testWrongOwner() public {
    //     user.callOnlyOwner(counter); // This test will fail
    // }
}
