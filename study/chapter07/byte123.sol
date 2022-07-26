// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract bytes123{
    bytes1 public b1 = 'a';
    bytes2 public b2 = "ab"; //最终显示结果会以两个字节显示
    bytes32 public b32 = "a";//最终显示结果会以32个字节显示，空位补0
    uint public len  = b32.length;
}