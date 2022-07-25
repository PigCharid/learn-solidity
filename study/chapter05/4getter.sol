// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testGetter{
    uint public data;
    function getDate() public returns (uint) {
        data = 3; // internal access
        return this.data(); // external access
    }
}