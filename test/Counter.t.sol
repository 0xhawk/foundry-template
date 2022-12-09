// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "../src/Counter.sol";

contract User {
    function callOnlyOwner(Blacksmith b) public {
        b.onlyOwner();
    }
}

contract CounterTest is DSTest {
    Blacksmith blacksmith;
    User user;

    function setUp() public {
        blacksmith = new Blacksmith(address(this));
        user = new User();
    }

    function testOwner() public {
        assertEq(blacksmith.owner(), address(this));
    }

    function testFailOwner() public {
        user.callOnlyOwner(blacksmith);
    }

    function testWrongOwner() public {
        user.callOnlyOwner(blacksmith); // This test will fail
    }
}
