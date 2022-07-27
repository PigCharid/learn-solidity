// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testBS{
    bytes public b = 'a';
    string public s = "i am string";
    bytes1 public a = b[0];
    bytes1 public d = bytes(s)[0];

    
}