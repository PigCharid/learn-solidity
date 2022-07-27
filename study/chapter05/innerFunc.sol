// SPDX-License-Identifier:MIT
pragma solidity ^0.8; 

function sum(uint[] memory _arr) pure returns (uint s) {
    for (uint i = 0; i < _arr.length; i++)
        s += _arr[i];
}
contract ArrayExample {
    bool found;
    function f(uint[] memory _arr) public {
        uint s = sum(_arr);
        require(s >= 10);
        found = true;
    }
}