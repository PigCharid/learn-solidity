// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract constructorTest{
    address owner;
    constructor(address _owner){
        owner = _owner;
    }
}