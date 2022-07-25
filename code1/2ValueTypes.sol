//SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract ValueTypes{
    bool public b = true;
    uint public u = 123;//uint max 2**256 - 1 同时也有uint8 其他大小的

    int public i = -123;//-2**255 - 1~~2**255 - 1
    int public intmax = type(int).max;
    int public intmin = type(int).min;

    address public add = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;//40位16进制  其实地址就等于160位二进制  uint160
     bytes32 public by = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4aaaaaaaaaaaaaaaaaaaaaaaa; //64位16进制  uint256
}