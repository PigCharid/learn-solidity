// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract MyFirstSmartContract{
    string public space = "Hello World";
    function getSpace()external view returns(string memory){
        return space;
    }
}